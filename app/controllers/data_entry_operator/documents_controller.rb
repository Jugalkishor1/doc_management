class DataEntryOperator::DocumentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @clients = current_user.clients
    @documents = Document.joins(:user).where(users: { data_entry_operator_id: current_user.id })
  end

  def show
    @document = Document.find(params[:id])
  end

  def verify
    @document = Document.find(params[:id])
    if @document.uploaded?
      @document.update(status: :verified_by_data_entry_operator)
      redirect_to data_entry_operator_documents_path, notice: "Document verified by DEO."
    else
      redirect_to data_entry_operator_documents_path, alert: "Cannot verify."
    end
  end

  private

  def check_data_entry_operator
    redirect_to root_path unless current_user.data_entry_operator?
  end
end
