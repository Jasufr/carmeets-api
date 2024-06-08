class Meeting < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :name, presence: true, uniqueness: { scope: :address }
  validates :address, presence: true
  validates :description, presence: true
end
