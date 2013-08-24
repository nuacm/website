require 'spec_helper'

describe Tag do

  it { should validate_presence_of :name }

  it { should have_many :taggings }
  it { should have_many :events }
  it { should have_many :posts }

end
