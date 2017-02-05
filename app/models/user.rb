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

end
