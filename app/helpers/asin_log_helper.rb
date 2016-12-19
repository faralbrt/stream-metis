def formatted_date(object)
  object.created_at.getlocal.strftime("%m/%d/%y")
end

def formatted_price(asin_log)
  return 'n/a' if asin_log.price == 0.0
  sprintf "$%.2f", asin_log.price
end
