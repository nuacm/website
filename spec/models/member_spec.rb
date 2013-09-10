require 'spec_helper'

describe Member do
  subject { create(:member) }

  it { should have_many :dues }

  it { should validate_presence_of   :name }
  it { should validate_uniqueness_of :email }
  it { should allow_value("bob.smith@example.com").for(:email) }
  it { should_not allow_value("bob.smith.com").for(:email) }
  it { should_not allow_value("foo").for(:email) }
end
