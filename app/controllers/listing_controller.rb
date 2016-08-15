class ListingController < ApplicationController
before_action :authenticate_user!

def new 
	@listing = Listing.new
end 

def create
	@listing = Listing.new(listing_params)
	@listing.user_id = current_user.id
	@listing.status = "Open"
	@listing.end_time = Time.now + (7*24*60*60)
if @listing.save
	flash[:notice] = "Lisitng was sucessfully created"
      redirect_to jobseeker_home_path 
    else 
      flash[:error] = @lisitng.errors.full_messages
      render 'new'
    end
  end

def update
end

private
def listing_params
        params.require(:listing).permit(:area, :amount)
      end

end