class IndustryController < ApplicationController
def new
	@industry = Industry.new
	end

	def create
	@industry = Industry.new(industry_params)
	if @industry.save
	flash[:notice] = "Sucessfully saved data"
	redirect_to jobseeker_home_path
	else 
	render :action =>'new'
	end
	end

	def update
		@industry = Industry.find(params[:id])
	      respond_to do |format|
	        if @industry.update(industry_params)
	          format.html { redirect_to jobseeker_home_path, notice: 'Sucessfully Updated data' }
	          format.json { head :no_content }
	        else
	          format.html { render action: 'new' }
	          format.json { render json: @industry.errors, status: :unprocessable_entity }
	        end
	      end
	    end

	

private
	def industry_params
	      params.require(:industry).permit(:area)
	    end

	end