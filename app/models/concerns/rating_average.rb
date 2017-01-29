module RatingAverage

  def average_rating
    ratings = self.ratings;
    return ratings.inject(0.0){ |sum, el| sum + el.score }.to_f / ratings.size
  end
  
end
