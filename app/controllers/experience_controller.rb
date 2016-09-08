class ExperienceController < ApplicationController
	before_action :authenticate_user!
def index
@experience = Experience.all
end
def new
@experience = Experience.new
1.times{@experience.work.build}
1.times{@experience.education.build}

end 
def create
@experience = Experience.new(experience_params)
if @experience.save
flash[:notice] = "Sucessfully saved data"
redirect_to history_path
else 
render :action =>'new'
end
end

def update
		@experience = Experience.find(params[:id])
	      respond_to do |format|
	        if @experience.update(experience_params)
	          format.html { redirect_to history_path, notice: 'Sucessfully Updated data' }
	          format.json { head :no_content }
	        else
	          format.html { render action: 'new' }
	          format.json { render json: @experience.errors, status: :unprocessable_entity }
	        end
	      end
	end

def checkRecord
	if Experience.where(:user_id => current_user.id).blank?
		create
	else 
		
		update
end 
end 
def experience_params
      params.require(:experience).permit(:user_id,work_attributes:[:id,:company, :title,:start_Month,:start_Year,:end_Month,:end_Year, :description],education_attributes:[:id,:university,:course,:year])
    end

end