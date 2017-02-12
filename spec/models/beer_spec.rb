require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "is saved with a name and a style" do
    beer = Beer.create name:"Beer", style:"lowalcohol"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1);
  end

  it "is not created without a style" do
    beer = Beer.create name:"Beer"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not created without a name" do
    beer = Beer.create style:"lowalcohol"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end
