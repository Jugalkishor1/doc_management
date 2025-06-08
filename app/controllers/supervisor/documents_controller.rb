class Supervisor::DocumentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @data_entry_operators = current_user.data_entry_operators
    @clients = User.where(data_entry_operator_id: @data_entry_operators.pluck(:id))
    @documents = Document.where(user_id: @clients.pluck(:id))
  end

  def show
    @document = Document.find(params[:id])
  end

  def verify
    @document = Document.find(params[:id])
    if @document.verified_by_data_entry_operator?
      @document.update(status: :verified_by_supervisor)
      redirect_to supervisor_documents_path, notice: "Document verified by Supervisor."
    else
      redirect_to supervisor_documents_path, alert: "Only DEO-verified documents can be verified."
    end
  end
end
