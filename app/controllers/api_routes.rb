get '/asins' do
  @asins = Asin.all.map { |asin| asin.name}
  @asins.inspect
end

post '/asinlogs' do
  asin = Asin.find_by(name: params[:asin])
  price = params[:price].delete("$").to_f
  @asin_log = AsinLog.new(title: params[:title], price: price, asin: asin)
  if @asin_log.save
    puts "successful save"
  else
    puts "\n\n\n====================^^^^^^^^^^^^^^^^^^^==================== fail!!!!\n\n\n"
  end
end
