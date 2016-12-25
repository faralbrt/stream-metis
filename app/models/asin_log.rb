class AsinLog < ActiveRecord::Base
  belongs_to :asin

  validates :asin_id, :price, presence: true

  def self.todays_records
    records = AsinLog.where("created_at >= ?", Time.current.beginning_of_day)
    records.sort_by{|record| record.title}
  end

  def self.find_by_asin_name(name)
    asin = Asin.find_by(name: name)
    asin_logs = AsinLog.where(asin: asin)
    asin_logs.sort_by{ |asin_log| asin_log.created_at }
  end
end
