get '/asins' do
  @asins = Asin.all.map { |asin| asin.name}
  @asins.inspect
end

post '/asinlogs/new' do
  binding.pry
  @asin_log = AsinLog.new(params)
  if @asin_log.save
    "success"
  else
    "fail"
  end
end
