class InfoController < ApplicationController
before_action :authenticate_user!
def new
	@info = Info.new
	end

	def create
	@info = Info.new(info_params)
	if @info.save
	flash[:notice] = "Sucessfully saved data"
	redirect_to info_path
	else 
	render :action =>'new'
	end
	end

	def update
		@info = Info.find(params[:id])
	      respond_to do |format|
	        if @info.update(info_params)
	          format.html { redirect_to info_path, notice: 'Sucessfully Updated data' }
	          format.json { head :no_content }
	        else
	          format.html { render action: 'new' }
	          format.json { render json: @info.errors, status: :unprocessable_entity }
	        end
	      end
	    end

	def checkRecord
		if Info.where(:user_id => current_user.id).blank?
			create 
		else 
			update
		end 
	end

private
	def info_params
	      params.require(:info).permit(:user_id,:avatar,:contact)
	    end

	end