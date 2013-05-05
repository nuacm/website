require 'spec_helper'

describe Position do
  subject { create(:position) }
  let(:officer) { create(:officer) }

  it { should respond_to(:title) }

  it "has a Officer relation" do
    subject.officers << officer
    subject.officers.should include(officer)
    officer.positions.should include(subject)
  end

  it "can have more than 1 Officer" do
    subject.officers << officer << create(:officer)
    subject.officers.count.should eq(2)
  end
end
