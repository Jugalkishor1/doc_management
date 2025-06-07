class Supervisor::DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_supervisor

  def index
    deo_ids = current_user.data_entry_operators.pluck(:id)
    @documents = Document.joins(:user).where(users: { data_entry_operator_id: deo_ids })
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

  private

  def check_supervisor
    redirect_to root_path unless current_user.supervisor?
  end
end
