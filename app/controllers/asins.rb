get '/asins/today' do
  # @asin_logs = AsinLog.todays_records
  @asin_logs = AsinLog.all
  erb :'asins/_table', layout: true
end

get '/asins/new' do
  erb :'asins/new'
end

post '/asins' do
  @asin = Asin.new(name: params[:name])
  if @asin.save
    redirect '/'
  else
    @errors = @asin.errors.full_messages
    erb :'asins/new'
  end
end

post '/multiple_asins' do
  asins = params[:names]
  asins = asins.delete("\n\r ").split(",")
  asins.each do |asin|
    new_asin = Asin.new(name: asin)
    @errors = [] unless @errors
    @errors << "#{asin} could not save" unless new_asin.save
  end
  erb :'asins/new'
end

get '/asins/:asin' do
  @asin_logs = AsinLog.find_by_asin_name(params[:asin])
  erb :'asins/_table', layout: true
end
