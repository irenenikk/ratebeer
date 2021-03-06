require 'rails_helper'

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Stadin Panimo" }
  let!(:user) { FactoryGirl.create :user }
  let!(:style) { FactoryGirl.create :style, name:"API" }


    before :each do
      sign_in(username:"Pekka", password:"Salsa1")
    end


  it "is saved correctly if name present" do
    visit new_beer_path

    fill_in('beer[name]', with: 'beer')
    select('API', from: 'beer[style_id]' )
    select('Stadin Panimo', from: 'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

    expect(brewery.beers.count).to eq(1)
  end

  it "is not saved without a name" do
    visit new_beer_path

    select('API', from: 'beer[style_id]' )
    select('Stadin Panimo', from: 'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to_not change{Beer.count}

    expect(page).to have_content "Name can't be blank"
    expect(brewery.beers.count).to eq(0)
  end
end
