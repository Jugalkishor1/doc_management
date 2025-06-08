class Document < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  enum status: {
    uploaded: 0,
    verified_by_data_entry_operator: 1,
    verified_by_supervisor: 2
  }

  validates :file, presence: true
end
