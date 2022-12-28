class UsersGroup < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :managers
  validates :name, uniqueness: true
  mount_uploader :photo, PhotoUploader
  enum status: {
    active: 1,
    in_active: 0
  }
end
