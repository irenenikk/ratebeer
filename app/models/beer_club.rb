class BeerClub < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  def to_s
    return self.name + ", " + self.memberships.count.to_s + " members"
  end
end
