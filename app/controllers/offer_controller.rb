class OfferController < ApplicationController
before_action :authenticate_user!

def new
	@offer = Offer.new 
end 

def create 
	@offer = Offer.new(offer_params)
	@offer.user_id = current_user.id
     if @offer.save
	flash[:notice] = "Offer was Offered"
	redirect_to employer_home_path
	else 
	render :action =>'new'
	end
	end

def update
		@offer = Offer.find(params[:id])
	      respond_to do |format|
	        if @offer.update(offer_params)
	          format.html { redirect_to employer_home_path, notice: 'Sucessfully Updated data' }
	          format.json { head :no_content }
	        else
	          format.html { render action: 'new' }
	          format.json { render json: @offer.errors, status: :unprocessable_entity }
	        end
	      end
	    end

def checkRecord
	if Offer.where(:seller_id => current_user.id).blank?
			create 
		else 
			update
		end 
	end


private
def offer_params
        params.require(:offer).permit(:listing_id,:amount, :comment,:area)
      end

end