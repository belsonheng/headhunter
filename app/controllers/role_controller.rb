class RoleController < ApplicationController
def new
	@role = Role.new
	end

	def create
	@role = Role.new(role_params)
	if @role.save
	flash[:notice] = "Sucessfully saved data"
	redirect_to jobseeker_home_path
	else 
	render :action =>'new'
	end
	end

	def update
		@role = Role.find(params[:id])
	      respond_to do |format|
	        if @role.update(industry_params)
	          format.html { redirect_to jobseeker_home_path, notice: 'Sucessfully Updated data' }
	          format.json { head :no_content }
	        else
	          format.html { render action: 'new' }
	          format.json { render json: @role.errors, status: :unprocessable_entity }
	        end
	      end
	    end

	

private
	def role_params
	      params.require(:role).permit(:industry_id, :role)
	    end

	end