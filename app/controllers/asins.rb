get '/asins/today' do
  @asin_logs = AsinLog.todays_records
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

get '/asins/:asin' do
  @asin_logs = AsinLog.find_by_asin_name(params[:asin])
  erb :'asins/_table', layout: true
end
