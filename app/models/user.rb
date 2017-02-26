class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 30}
  validates :password, length: { minimum: 4}

  validate :password_contains_number
  validate :password_contains_upper_case

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  has_secure_password

  def password_contains_number
    unless password =~ /\d/
      errors.add(:password, 'has to contain a number')
    end
  end

  def password_contains_upper_case
    unless password =~ /[A-Z]/
      errors.add(:password, 'has to inlcude an uppercase character')
    end
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
#    ratings_by_style = ratings.group_by{ |rating| rating.beer.style}
    favorite :style
  end

  def favorite_brewery
    return nil if ratings.empty?
    favorite :brewery
  end

  def favorite(attr)
    return nil if ratings.empty?
    ratings_by_attr = ratings.group_by{ |rating| rating.beer.send attr}
    ratings_by_attr.each do |attr, ratings|
      ratings_by_attr[attr] = rating_average(ratings)
    end
    ratings_by_attr.sort_by{ |key, value| value}.last[0]
  end

  def rating_average(ratings)
    ratings.inject(0.0){ |sum, el| sum + el.score }.to_f / ratings.size
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |b| -(b.beers.count||0) }
    sorted_by_rating_in_desc_order[0..4]
  end

  def to_s
    self.username
  end

end
