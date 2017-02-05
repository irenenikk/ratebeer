class Beer < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true

  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  def to_s
    return self.name + " from " + self.brewery.name
  end

  def average
    return 0 if ratings.empty?
    ratings.map{|r| r.score}.sum.to_f / ratings.count
  end


end
