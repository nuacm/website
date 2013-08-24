require 'spec_helper'

describe Post do

  it { should respond_to :title }
  it { should respond_to :body }
  it { should respond_to :member }

  it { should have_many :taggings }
  it { should have_many :tags }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :member }

  it "validates that the title doesn't end in a period" do
    build(:post, :title => "This ends in a period.").should_not be_valid
  end

  it "validates that it's author is an officer" do
    build(:post, :member => create(:member)).should_not be_valid
  end

end
