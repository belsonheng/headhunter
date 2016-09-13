class PreferencesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @preferences = Preferences.new
  end

  def create
	@preferences = Preferences.new(preference_params)
	if @preferences.save
	  flash[:notice] = "Sucessfully saved data"
	  redirect_to job_info_path
	else 
	  render :action =>'new'
	end
  end

  def update
	@preferences = Preferences.find(params[:id])
    respond_to do |format|
      if @preferences.update(preference_params)
        format.html { redirect_to job_info_path, notice: 'Sucessfully updated data' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @preferences.errors, status: :unprocessable_entity }
      end
    end
  end

  def checkRecord
    if Preferences.where(:user_id => current_user.id).blank?
	  create 
    else 
	  update
    end 
  end

  def preference_params
    params.require(:preferences).permit(:user_id,:type,:why,:where,:salary)
  end
end