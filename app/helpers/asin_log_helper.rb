def formatted_date(object)
  object.created_at.getlocal.strftime("%m/%d/%y")
end

def formatted_price(price)
  return 'n/a' if price == 0.0
  sprintf "$%.2f", price
end

def link_to_site(asin_log)
  'https://www.amazon.com/gp/offer-listing/' + asin_log.asin.name + '/ref=olp_f_primeEligible?ie=UTF8&f_new=true&f_primeEligible=true'
end

def link_to_show(asin_log)
  "/asins/" + asin_log.asin.name
end
