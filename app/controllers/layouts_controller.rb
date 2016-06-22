class LayoutsController < ApplicationController

	def index
end
#For the SubScribe List
def subscribe

    @list_id = ENV["LIST_ID"]
    gb = Gibbon::API.new

    gb.lists.subscribe({
      :id => @list_id,
      :email => {:email => params[:email][:address]}
      })

end
end
