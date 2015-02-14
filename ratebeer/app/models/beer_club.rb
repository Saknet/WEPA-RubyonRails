class BeerClub < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships, source: :user

  def is_member?(user)
    users.exists?(user.id)
  end
end
