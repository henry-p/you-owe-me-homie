class User < ActiveRecord::Base
  has_and_belongs_to_many :households
  has_many :transactions, foreign_key: :from_user_id
  has_many :transactions, foreign_key: :to_user_id

  has_secure_password
  validates :email, :first_name, :last_name, :password, presence: true
  validates :email, uniqueness: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
