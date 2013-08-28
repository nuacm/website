require 'spec_helper'

describe SecureMember do
  subject { create(:secure_member) }

  it { should be_a(Member) }

  it "must have a password" do
    member = build(:secure_member, :password => nil, :password_confirmation => nil)
    member.should_not be_valid
  end
end
