class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 15}

  validates :password, format: { with: /(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{4,}/,
                                message: "must be atleast 4 chars long and must contain atleast 1 number and 1 uppercase letter"}

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships, dependent: :destroy

  def self.top(n)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |user| -(user.ratings.count||0)}
    sorted_by_rating_in_desc_order.first(n)
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite_style
    favorite :style
  end

  def favorite(category)
    return nil if ratings.empty?

    category_ratings = rated(category).inject([]) do |set, item|
      set << {
          item: item,
          rating: rating_of(category, item) }
    end

    category_ratings.sort_by { |item| item[:rating] }.last[:item]
  end

  def rating_of(category, item)
    ratings_of_item = ratings.select do |r|
      r.beer.send(category) == item
    end
    ratings_of_item.map(&:score).sum / ratings_of_item.count
  end

  def rated(category)
    ratings.map{ |r| r.beer.send(category) }.uniq
  end
end
