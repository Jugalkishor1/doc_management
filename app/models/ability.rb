# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    case user.role
    when "super_admin"
      can :manage, :all

    when "manager"
      can :read, User, supervisor_id: user.id
      can :read, Document

    when "supervisor"
      can :read, User, data_entry_operator_id: user.data_entry_operator_ids
      can :read, Document

    when "data_entry_operator"
      binding.irb
      can :read, User, id: user.client_ids
      can :read, Document, client_id: user.client_ids
      can :update, Document, client_id: user.client_ids

    when "client"
      can :read, Document, user_id: user.id
      can :create, Document
    end
  end
end
