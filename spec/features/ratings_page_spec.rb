require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

    before :each do
      sign_in(username:"Pekka", password:"Salsa1")
    end

    it "is registered to the beer and user who is signed in" do
      visit new_rating_path
      select('iso 3', from:'rating[beer_id]')
      fill_in('rating[score]', with:'15')

      expect{
        click_button "Create Rating"
      }.to change{Rating.count}.from(0).to(1)

      expect(user.ratings.count).to eq(1)
      expect(beer1.ratings.count).to eq(1)
      expect(beer1.average_rating).to eq(15.0)
    end

    it "ratings page shows amount of ratings in database" do
      create_beers_with_ratings(user, 10, 12, 13, 14)
      visit ratings_path

      expect(page).to have_content 'Number of ratings 4'
      expect(page).to have_content 'beer: 10'
      expect(page).to have_content 'beer: 12'
      expect(page).to have_content 'beer: 13'
      expect(page).to have_content 'beer: 14'
    end

    it "is shown on maker's site" do
      user2 = FactoryGirl.create :user, username:"Mauri"
      create_beer_with_rating(user, 10)
      create_beer_with_rating(user2, 20)

      visit user_path(user)
      expect(page).to have_content 'has made 1 rating'
      expect(page).to have_content 'beer: 10'
      expect(page).to_not have_content 'beer: 20'
    end

    it "can be deleted from database" do
      create_beer_with_rating(user, 10)
      visit user_path(user)

      expect{
        click_link('delete')
      }.to change{Rating.count}.by(-1)
    end
  end
