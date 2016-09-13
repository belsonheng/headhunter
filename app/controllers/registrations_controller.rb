class RegistrationsController < Devise::RegistrationsController
  protected
  def after_update_path_for(resource)
    edit_user_registration_path
  end

  def update_resource(resource, params)
    if current_user.provider == "facebook" || current_user.provider == "linkedin" || current_user.provider == "google"
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end