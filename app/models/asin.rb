class Asin < ActiveRecord::Base
  has_many :logs, class_name: :AsinLog

  validates :name, presence: true, uniqueness: true, length: {is: 10}

  def title
    return self.logs.order(:created_at).first.title unless self.logs.empty?
    return "n/a"
  end

  def self.sort_by_title
    return Asin.all.sort_by{|asin| asin.title}
  end

  def avg_price
    return 0.0 unless !self.logs.empty?
    prices = self.logs.map {|log| log.price if log.price > 0.0}
    prices = prices.select {|price| price}
    return prices.reduce(0.0) {|sum, price| sum + price}/prices.size unless prices.empty?
    return 0.0
  end
end
