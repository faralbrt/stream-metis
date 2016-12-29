def already_tracking?(asin)
  Asin.find_by(name: asin)
end
