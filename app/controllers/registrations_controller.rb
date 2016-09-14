class RegistrationsController < Devise::RegistrationsController
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