class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    resource.save
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      puts resource.errors.inspect
      clean_up_passwords resource
      set_minimum_password_length
      render 'new_jobseeker' if resource.is_a? Jobseeker
      render 'new_employer' if resource.is_a? Employer
      # respond_with resource, location: employer_signup_path
    end
  end

  def new_jobseeker
    self.resource = Jobseeker.new_with_session({} || {}, session)
    respond_with self.resource
  end

  def new_employer
    self.resource = Employer.new_with_session({} || {}, session)
    respond_with self.resource
  end

  def edit
    render 'pages/jobseeker/settings' if params[:type] == 'jobseeker'
    render 'pages/employer/settings' if params[:type] == 'employer'
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)

    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      # bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      render 'pages/jobseeker/settings' if resource.is_a? Jobseeker
      render 'pages/employer/settings' if resource.is_a? Employer      
      # respond_with resource
    end
  end

  def after_update_path_for(resource)
    return jobseeker_account_update_path if resource.is_a? Jobseeker
    return employer_account_update_path if resource.is_a? Employer      
  end

  def update_resource(resource, params)
    params.delete('password') if (params[:password].empty?)
    resource.update_attributes(params)
    # puts "update resource"
    # puts resource.inspect
    # if (params[:password].blank?) then
    #   resource.update_without_password(params)
    # else
    #   params[:current_password] = resource.password
    #   puts "new params"
    #   puts params
    #   resource.update_with_password(params)
    # end
    # if current_user.provider.casecmp("facebook") || current_user.provider.casecmp('linkedin') || current_user.provider.casecmp('google')
    #   params.delete("current_password")
    #   resource.update_without_password(params)
    # else
    #   resource.update_with_password(params)
    # end
  end

  def build_resource(hash=nil)
    if hash.empty? then
      self.resource = resource_class.new_with_session(hash || {}, session)
    else
      if hash.key?(:type)
        case hash[:type]
        when 'jobseeker'
          self.resource = Jobseeker.new_with_session(hash || {}, session)
        when 'employer'
          self.resource = Employer.new_with_session(hash || {}, session)
        end
      end
    end
  end
end