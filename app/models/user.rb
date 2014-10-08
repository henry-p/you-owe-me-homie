class User < ActiveRecord::Base
  has_and_belongs_to_many :households
  has_many :transactions, foreign_key: :from_user_id
  has_many :transactions, foreign_key: :to_user_id

  # validates :email, :
end
