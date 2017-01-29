class Beer < ActiveRecord::Base
  include RatingAverage
  
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def to_s
    return self.name + " from " + self.brewery.name
  end

end
