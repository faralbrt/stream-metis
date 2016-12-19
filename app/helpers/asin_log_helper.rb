def formatted_date(object)
  object.created_at.getlocal.strftime("%m/%d/%y")
end

def formatted_price(asin_log)
  return 'n/a' if asin_log.price == 0.0
  sprintf "$%.2f", asin_log.price
end

def link_to_site(asin_log)
  'https://www.amazon.com/gp/offer-listing/' + asin_log.asin.name + '/ref=olp_f_primeEligible?ie=UTF8&f_new=true&f_primeEligible=true'
end
