class Bill < Transaction
	belongs_to :to_user, class_name: "User"
  belongs_to :from_user, class_name: "User"
  has_many :comments, as: :commentable
  validates :from_user_id, :to_user_id, :amount, presence: true
  validates :amount, format: /\A(?!0\d+)\d+(\.\d{2})?\z/
end
