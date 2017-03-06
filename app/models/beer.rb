class Beer < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  validates :style_id, presence: true

  belongs_to :brewery, touch: true
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  belongs_to :style

  def to_s
    return self.name + " from " + self.brewery.name
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
    sorted_by_rating_in_desc_order[0..4]
  end

end
