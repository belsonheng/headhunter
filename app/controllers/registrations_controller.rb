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

  protected
  def after_update_path_for(resource)
    edit_user_registration_path
  end

  def update_resource(resource, params)
    if current_user.provider.casecmp("facebook") || current_user.provider.casecmp('linkedin') || current_user.provider.casecmp('google')
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  def build_resource(hash=nil)
    puts hash[:type]
    puts hash
    if hash.empty? then
      self.resource = resource_class.new_with_session(hash || {}, session)
    else
      # jobseeker = hash[:type] == 'jobseeker' ? Jobseeker.new_with_session(hash || {}, session) : nil
      # employer = hash[:type] == 'employer' ? Employer.new_with_session(hash || {}, session) : nil
      # self.resource = {:jobseeker => jobseeker, :employer => employer}
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