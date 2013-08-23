require 'spec_helper'

describe Post do
  subject { create(:post) }

  it { should respond_to :title }
  it { should respond_to :body }
  it { should respond_to :member }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :member }

  it "validates that the title doesn't end in a period" do
    create(:post, :title => "This ends in a period.").should_not be_valid
  end

end
