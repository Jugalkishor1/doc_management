class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    case resource.role
    when "super_admin"
      super_admin_dashboard_index_path
    when "manager"
      manager_dashboard_index_path
    when "supervisor"
      supervisor_dashboard_index_path
    when "data_entry_operator"
      data_entry_operator_documents_path
    when "client"
      client_documents_path
    else
      root_path
    end
  end
end
