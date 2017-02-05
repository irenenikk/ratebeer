class Membership < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :user_id, :scope => [:beer_club_id]
  belongs_to :beer_club

end
