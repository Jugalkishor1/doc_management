class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def redirect_user
    if user_signed_in?
      case current_user.role
      when "super_admin"
        redirect_to super_admin_users_path
      when "manager"
        redirect_to manager_dashboard_index_path
      when "supervisor"
        redirect_to supervisor_documents_path
      when "data_entry_operator"
        redirect_to data_entry_operator_documents_path
      when "client"
        redirect_to client_dashboard_index_path
      else
        sign_out current_user
        redirect_to new_user_session_path, alert: "Invalid role assigned."
      end
    else
      redirect_to new_user_session_path
    end
  end
end
