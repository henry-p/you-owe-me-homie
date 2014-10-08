require 'spec_helper'

describe Comment do
  it { should belong_to(:commentable) }

  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:commentable_type) }
end
