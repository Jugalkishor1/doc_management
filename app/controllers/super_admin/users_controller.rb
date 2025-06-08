class SuperAdmin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_super_admin!

  def index
    @users = User.where.not(id: current_user.id).all.includes(:manager, :supervisor, :data_entry_operator)
  end

  def edit
    @user = User.find(params[:id])
    @managers = User.where(role: "manager")
    @supervisors = User.where(role: "supervisor")
    @deos = User.where(role: "data_entry_operator")
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to super_admin_users_path, notice: "#{@user.role.titleize} updated successfully."
    else
      load_assignables
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:role, :manager_id, :supervisor_id, :data_entry_operator_id)
  end

  def load_assignables
    @managers = User.manager
    @supervisors = User.supervisor
    @data_entry_operators = User.data_entry_operator
  end

  def ensure_super_admin!
    redirect_to root_path unless current_user.super_admin?
  end
end
