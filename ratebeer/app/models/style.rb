class Style < ActiveRecord::Base
  include RatingAverage

  has_many :beers
  has_many :ratings, through: :beers

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |style| -(style.average_rating||0)}
    sorted_by_rating_in_desc_order.first(n)
  end

  def to_s
    return self.name
  end
end
