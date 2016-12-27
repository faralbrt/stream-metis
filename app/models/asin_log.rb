class AsinLog < ActiveRecord::Base
  belongs_to :asin

  validates :asin_id, :price, presence: true

  def self.todays_records
    records = AsinLog.where("created_at >= ?", (Time.now - 5*60*60).getutc.to_date.to_time)
    records.sort_by{|record| record.title}
  end

  def self.find_by_asin_name(name)
    asin = Asin.find_by(name: name)
    asin_logs = AsinLog.where(asin: asin)
    asin_logs.sort_by{ |asin_log| asin_log.created_at }
  end

  def fluctuation
    prev_log = AsinLog.where("asin_id = ? AND created_at < ?", self.asin.id, self.created_at)
    return "none" if prev_log.empty?
    prev_log = prev_log.max_by{|log| log.created_at}
    return "blue" if prev_log.price == 0.0 && self.price == 0.0
    return "green" if self.price/prev_log.price > 1.029
    return "red" if self.price/prev_log.price < 0.971
    return "none"
  end

  # def today
  #   (Time.now - 5*60*60).getutc.to_date.to_time
  # end
end
