require 'spec_helper'

FactoryGirl.factories.map(&:name).each do |name|
  describe "The #{name} factory" do
    subject { build(name) }
    it { should be_valid }
  end
end
