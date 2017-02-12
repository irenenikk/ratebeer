require 'rails_helper'

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

    describe "who has signed up" do

    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Salsa1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if bad credentials" do
      sign_in(username:"Pekka", password:"Salsasana1")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Wrong username or password'
    end

    it "is added to the system" do
      visit signup_path
      fill_in('user_username', with:'Brian')
      fill_in('user_password', with:'Secret55')
      fill_in('user_password_confirmation', with:'Secret55')

      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end
  end

  it "page show favorite beer" do
    user = FactoryGirl.create(:user, username:'Maaret')
    create_beer_with_rating(user, 12)
    visit user_path(user)
    expect(page).to have_content 'favorite beer beer'
  end

  it "page shows favorite brewery" do
    user = FactoryGirl.create(:user, username:'Maaret')
    brewery = FactoryGirl.create(:brewery)
    create_beer_with_brewery_and_rating(user, brewery, 12)
    visit user_path(user)
    expect(page).to have_content 'favorite brewery brewery'
  end
end
