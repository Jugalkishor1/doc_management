class Manager::DashboardController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :user, class: "User"

  def index
    @supervisors = current_user.supervisors
    @data_entry_operators = User.where(supervisor_id: @supervisors.pluck(:id))
    @clients = User.where(data_entry_operator_id: @data_entry_operators.pluck(:id))
    @documents = Document.where(user_id: @clients.pluck(:id))
  end
end
