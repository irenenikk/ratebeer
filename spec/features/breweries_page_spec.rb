require 'rails_helper'

describe "Breweries page" do

  it "has the number of breweries as 0 when none created" do
    visit breweries_path
    expect(page).to have_content 'Listing Breweries'
    expect(page).to have_content 'Number of breweries: 0'
  end

  describe "when breweries have been created" do
    before :each do
      @breweries = ["Koff", "Karjala", "Schlenkerla"]
      year = 1896
      @breweries.each do |brewery_name|
        FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
      end

      visit breweries_path
    end

    it "lists existing breweries and their total amount" do
      expect(page). to have_content "Number of breweries: #{@breweries.count}"
      @breweries.each do |brewery_name|
        expect(page).to have_content brewery_name
      end
    end

    it "allows user to navigate to a brewery's page" do
      click_link "Koff"
      expect(page).to have_content "Koff"
      expect(page).to have_content "Established in 1897"
    end
  end
end
