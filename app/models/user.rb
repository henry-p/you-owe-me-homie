class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_many :transactions, foreign_key: :from_user_id
  has_many :transactions, foreign_key: :to_user_id
  has_many :comments

  has_secure_password
  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i


  def full_name
    "#{first_name} #{last_name}"
  end
end
