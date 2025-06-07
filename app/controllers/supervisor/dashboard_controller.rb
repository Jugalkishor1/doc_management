class Supervisor::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_supervisor!

  def index
    @data_entry_operators = current_user.data_entry_operators
    @clients = User.where(data_entry_operator_id: @data_entry_operators.pluck(:id))
    @documents = Document.where(user_id: @clients.pluck(:id))
  end

  private

  def ensure_supervisor!
    redirect_to root_path unless current_user.supervisor?
  end
end
