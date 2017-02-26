module RatingAverage

  def average_rating
    ratings = self.ratings;
    unless ratings.empty?
      average = ratings.inject(0.0){ |sum, el| sum + el.score }.to_f / ratings.size
    else
      0
    end
  end

end
