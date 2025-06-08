class Manager::DashboardController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :user, class: "User"

  def index
    @supervisors = current_user.supervisors.where(role: :supervisor)
    @data_entry_operators = User.where(supervisor_id: @supervisors.pluck(:id), role: :data_entry_operator)
    @clients = User.where(data_entry_operator_id: @data_entry_operators.pluck(:id), role: :client)
    @documents = Document.where(user_id: @clients.ids)
  end
end
