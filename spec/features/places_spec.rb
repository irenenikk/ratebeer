require 'rails_helper'

describe "Places" do
=begin
  it "if is returned by the API, it is shown on the page" do
    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>12411</id><name>Gallows Bird</name><status>Brewery</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12411</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=12411&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=12411&amp;d=1&amp;type=norm</blogmap><street>Merituulentie 30</street><city>Espoo</city><state></state><zip>02200</zip><country>Finland</country><phone>+358 9 412 3253</phone><overall>91.66665</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })
    visit places_path
    fill_in('city', with: "kumpula")
    click_button "Search"

    expect(page).to have_content "Gallows Bird"
  end

  it "if several returned by the API, all shown on the page" do
    canned_answer = <<-END_OF_STRING
      <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>13307</id><name>O'Connell's Irish Bar</name><status>Beer Bar</status><reviewlink>https://beermapping.com/location/13307</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap><street>Rautatienkatu 24</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227032</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>18845</id><name>Pyynikin kà¤sityà¶là¤ispanimo</name><status>Brewery</status><reviewlink>https://beermapping.com/location/18845</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18845&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18845&amp;d=1&amp;type=norm</blogmap><street>Tesoman valtatie 24</street><city>Tampere</city><state></state><zip>33300</zip><country>Finland</country><phone></phone><overall>0</overall><imagecount>0</imagecount></location><location><id>18857</id><name>Panimoravintola Plevna</name><status>Brewpub</status><reviewlink>https://beermapping.com/location/18857</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18857&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18857&amp;d=1&amp;type=norm</blogmap><street>Ità¤inenkatu 8</street><city>Tampere</city><state></state><zip>33210</zip><country>Finland</country><phone></phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*tampere/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    expectedPlaces = [Place.new( name:"O'Connell's Irish Bar", street: "Rautatienkatu 24" ) ,
                      Place.new( name:"Pyynikin käsityöläispanimo", street: "Tesoman valtatie 24" ) ,
                      Place.new( name:"Panimoravintola Plevna	", street: "Itäinenkatu 8" ) ]

    visit places_path
    fill_in('city', with: "kallio")
    click_button "Search"

    expectedPlaces.each{ |p|
      expect(page).to have_content p.name
    }
  end

  it "if none found shows notice" do
    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>
    END_OF_STRING
    stub_request(:get, /.*viikki/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    paikka = "viikki"

    visit places_path
    fill_in('city', with: paikka)
    click_button "Search"

    expect(page).to have_content "No locations in " + paikka
  end
=end
end
