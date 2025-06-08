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
      can :read, User, id: user.data_entry_operator_ids
      can :read, Document, user_id: user.client_ids
      can :manage, Document, user_id: user.client_ids

    when "data_entry_operator"
      can :read, User, id: user.client_ids
      can :read, Document, user_id: user.client_ids
      can :manage, Document, user_id: user.client_ids

    when "client"
      can :read, Document, user_id: user.id
      can :create, Document
    end
  end
end
