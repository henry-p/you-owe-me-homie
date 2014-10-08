require 'spec_helper'

describe Transaction do
  it { should have_many(:comments) }
  it { should belong_to(:to_user) }
  it { should belong_to(:from_user) }

  it { should validate_presence_of(:from_user_id) }
  it { should validate_presence_of(:to_user_id) }
  it { should validate_presence_of(:amount) }
end
