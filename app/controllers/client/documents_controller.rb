class Client::DocumentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @documents = current_user.documents
  end

  def new
    @document = current_user.documents.new
  end

  def create
    @document = current_user.documents.new(document_params)
    if @document.save
      redirect_to client_documents_path, notice: "Document uploaded!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @document = current_user.documents.find(params[:id])
  end

  private

  def document_params
    params.require(:document).permit(:file)
  end
end
