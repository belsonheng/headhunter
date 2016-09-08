class SkillController < ApplicationController
before_action :authenticate_user!
def new
	@skill = Skill.new
	end

	def create
	@skill = Skill.new(skill_params)
	if @skill.save
	flash[:notice] = "Sucessfully saved data"
	redirect_to role_skill_path
	else 
	render :action =>'new'
	end
	end

	def update
		@skill = Skill.find(params[:id])
	      respond_to do |format|
	        if @skill.update(skill_params)
	          format.html { redirect_to role_skill_path, notice: 'Sucessfully Updated data' }
	          format.json { head :no_content }
	        else
	          format.html { render action: 'new' }
	          format.json { render json: @skill.errors, status: :unprocessable_entity }
	        end
	      end
	    end

	def checkRecord
		if Skill.where(:user_id => current_user.id).blank?
			create 
		else 
			update
		end 
	end

private
def skill_params
        params.require(:skill).permit(:user_id,:area,:skill, :years, role:[])
      end
end 