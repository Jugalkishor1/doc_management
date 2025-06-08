class Client::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @documents = current_user.documents
  end

  def show
    @client = User.find(params[:id])
    @documents = @client.documents
  end
end
