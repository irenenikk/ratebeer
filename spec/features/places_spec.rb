require 'rails_helper'

describe "Places" do
  it "if is returned by the API, it is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several returned by the API, all shown on the page" do
    places = [Place.new( name:"Flemari 13", id: 1 ) ,
              Place.new( name:"Breezer", id: 2 ) ,
              Place.new( name:"Relaxin", id: 2 ) ]

    allow(BeermappingApi).to receive(:places_in).with("kallio").and_return(
        places
    )
    visit places_path
    fill_in('city', with: 'kallio')
    click_button "Search"

    places.each{ |p|
      expect(page).to have_content p.name
    }
  end

  it "if none found shows notice" do
    paikka = "viikki"
    allow(BeermappingApi).to receive(:places_in).with(paikka).and_return(
        []
    )

    visit places_path
    fill_in('city', with: paikka)
    click_button "Search"

    expect(page).to have_content "No locations in " + paikka 
  end
end
