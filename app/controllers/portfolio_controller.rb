class PortfolioController < ApplicationController
before_action :authenticate_user!
def new
	@portfolio = Portfolio.new
	end

	def create
	@portfolio = Portfolio.new(portfolio_params)
	if @portfolio.save
	flash[:notice] = "Sucessfully saved data"
	redirect_to portfolio_path
	else 
	render :action =>'new'
	end
	end

	def update
		@portfolio = Portfolio.find(params[:id])
	      respond_to do |format|
	        if @portfolio.update(portfolio_params)
	          format.html { redirect_to portfolio_path, notice: 'Sucessfully Updated data' }
	          format.json { head :no_content }
	        else
	          format.html { render action: 'new' }
	          format.json { render json: @portfolio.errors, status: :unprocessable_entity }
	        end
	      end
	    end

	def checkRecord
		if Portfolio.where(:user_id => current_user.id).blank?
			create 
		else 
			update
		end 
	end

private
	def portfolio_params
	      params.require(:portfolio).permit(:user_id,:project_Name,:project_Description)
	    end

	end