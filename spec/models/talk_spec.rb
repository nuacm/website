require 'spec_helper'

describe Talk do

  it { should validate_presence_of(:talker) }

  it { should be_an(Event) }

end
