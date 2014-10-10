class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :comments, as: :commentable

  validates :name, presence:true

  def add_members(emails)
    members = self.users
    unregistered = Array.new
    emails.each do |email|
      next if email.strip.empty?
      if user = User.find_by(email: email)
        self.users << user unless members.include? user
      else
        unregistered << email
      end
    end
    return unregistered
  end
end
