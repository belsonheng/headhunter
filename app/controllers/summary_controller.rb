class SummaryController < ApplicationController
before_action :authenticate_user!
def new
	@summary = Summary.new
	end

	def create
	@summary = Summary.new(summary_params)
	if @summary.save
	flash[:notice] = "Sucessfully saved data"
	redirect_to summary_path
	else 
	render :action =>'new'
	end
	end

	def update
		@summary = Summary.find(params[:id])
	      respond_to do |format|
	        if @summary.update(summary_params)
	          format.html { redirect_to summary_path, notice: 'Sucessfully Updated data' }
	          format.json { head :no_content }
	        else
	          format.html { render action: 'new' }
	          format.json { render json: @summary.errors, status: :unprocessable_entity }
	        end
	      end
	    end

	def checkRecord
		if Summary.where(:user_id => current_user.id).blank?
			create 
		else 
			update
		end 
	end

private
def summary_params
        params.require(:summary).permit(:user_id,:summary)
      end
end 