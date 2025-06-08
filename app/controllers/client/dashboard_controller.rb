class Client::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_client!

  def index
    @documents = current_user.documents
  end

  private

  def ensure_client!
    redirect_to root_path unless current_user.client?
  end
end
