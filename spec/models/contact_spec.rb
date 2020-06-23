require 'rails_helper'

RSpec.describe Contact, :type => :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

  it { should validate_uniqueness_of(:email) }
  
  it 'has a valid factory' do
    expect(build(:contact)).to be_valid
  end
end