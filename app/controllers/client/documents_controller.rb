class Client::DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_client!

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

  def check_client!
    redirect_to root_path unless current_user.client?
  end
end
