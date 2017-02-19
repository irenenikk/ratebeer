require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "is saved with a name and a style" do
    style = Style.create name:"lowalcohol", description:"low on alcohol"
    beer = Beer.create name:"Beer", style: style

    expect(beer).to be_valid
    expect(Beer.count).to eq(1);
  end

  it "is not created without a style" do
    beer = Beer.create name:"Beer"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not created without a name" do
    beer = Beer.create

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end
