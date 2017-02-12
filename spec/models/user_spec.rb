require 'rails_helper'

RSpec.describe User, type: :model do

  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password thats too short" do
    user = User.create username:"Pekka", password:"A1", password_confirmation:"A1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password without numbers" do
    user = User.create username:"Pekka", password:"asd", password_confirmation:"asd"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){FactoryGirl.create(:user) }

    it "is saved" do
      user = User.create username:"Pekka", password:"Salsa1", password_confirmation:"Salsa1"

      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "has the correct average rating with two ratings" do
      user = User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"
      brewery = Brewery.new name: "test", year: 2000
      beer = Beer.new name: "testbeer", style: "teststyle"
      rating = Rating.new score: 10, beer: beer
      rating2 = Rating.new score: 20, beer: beer

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }
    it "has a method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only one rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beer_with_rating(user, 10)
      best = create_beer_with_rating(user, 25)
      create_beer_with_rating(user, 7)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }
    it "has method for defining one " do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings has none" do
      expect(user.favorite_style).to eq(nil)
    end

    it "if only one rating, favorite style the one of the beer rated" do
      beer = create_beer_with_rating(user, 10)
      expect(user.favorite_style).to eq(beer.style)
    end

    it "if two rankings is the style of the better one" do
      create_beer_with_rating(user, 10)
      better = create_beer_with_rating(user, 12)
      expect(user.favorite_style).to eq(better.style)
    end

    it "if several rankings of different styles returns one with best scores" do
      create_beer_with_style_and_rating(user, "lager", 20)
      best = create_beer_with_style_and_rating(user, "lowalcohol", 45)
      create_beer_with_style_and_rating(user, "lowalcohol", 50)
      create_beer_with_style_and_rating(user, "IPA", 10)
      create_beer_with_style_and_rating(user, "IPA", 50)
      expect(user.favorite_style).to eq(best.style)
    end
  end

  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user) }
    it "has method for defining one " do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings has none" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "if only one rating, favorite brewery the one of the beer rated" do
      brewery = FactoryGirl.create(:brewery)
      beer = create_beer_with_brewery_and_rating(user, brewery, 10)
      expect(user.favorite_brewery).to eq(brewery)
    end

    it "with two rankings of different breweries is the brewery of the better one" do
      brewery = FactoryGirl.create(:brewery)
      better = FactoryGirl.create(:brewery, name:"Better")
      create_beer_with_brewery_and_rating(user, better, 50)
      create_beer_with_brewery_and_rating(user, brewery, 10)
      create_beer_with_brewery_and_rating(user, better, 40)
      expect(user.favorite_brewery).to eq(better)
    end

    it "if several rankings of beers of different breweries returns one with best scores" do
      bestBrewery = FactoryGirl.create(:brewery, name:"best")
      other1 = FactoryGirl.create(:brewery)
      other2 = FactoryGirl.create(:brewery)
      create_beer_with_brewery_and_rating(user, other1, 10)
      create_beer_with_brewery_and_rating(user, other2, 20)
      beer = create_beer_with_brewery_and_rating(user, bestBrewery, 45)
      create_beer_with_brewery_and_rating(user, other1, 40)
      expect(user.favorite_brewery).to eq(bestBrewery)
    end
  end
end
