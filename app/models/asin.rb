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
end
