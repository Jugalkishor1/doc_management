class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum role: {
    super_admin: 0,
    manager: 1,
    supervisor: 2,
    data_entry_operator: 3,
    client: 4
  }

  belongs_to :manager, class_name: 'User', optional: true
  has_many :supervisors, class_name: 'User', foreign_key: 'manager_id'

  belongs_to :supervisor, class_name: 'User', optional: true
  has_many :data_entry_operators, class_name: 'User', foreign_key: 'supervisor_id'

  belongs_to :data_entry_operator, class_name: 'User', optional: true
  has_many :clients, class_name: 'User', foreign_key: 'data_entry_operator_id'

  has_many :documents, dependent: :destroy

  before_create :assign_default_role

  private
  def assign_default_role
    self.role ||= 'client'
  end
end
