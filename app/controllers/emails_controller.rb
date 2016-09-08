class EmailsController < ApplicationController
  def subscribe
    gibbon = Gibbon::Request.new
    gibbon.lists(ENV["LIST_ID"]).members.create(
      body: { email_address: params[:email][:address], status: "subscribed" }
    )
    render :js => "alert('Thank you for subscribing. We will keep you updated on our latest features.');"
  end
end
