class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
  has_and_belongs_to_many :users_groups
  has_many :performances
  mount_uploader :photo, PhotoUploader
  validates :email, :username, uniqueness: true
  validates_presence_of :username
  validates_presence_of :email
end
