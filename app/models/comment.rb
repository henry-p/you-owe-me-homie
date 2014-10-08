class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true

  validates :content, :commentable_id, :commentable_type, presence: true
end
