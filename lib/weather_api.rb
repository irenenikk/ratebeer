class WeatherApi

  def self.weather_in(city)
    city = city.downcase

    url = "http://api.apixu.com/v1/current.xml?key=#{key}&q="

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    weather = response.parsed_response["root"]["current"]
    return weather
  end

  private

  def self.key
    raise "WEATHERAPI key not found" if ENV['WEATHERAPI'].nil?
    ENV['WEATHERAPI']
  end
end
