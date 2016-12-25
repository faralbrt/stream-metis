get '/asins/delete' do
  redirect '/login' unless logged_in?
  @asins = Asin.sort_by_title
  erb :'asins/index_delete'
end


get '/asins/today' do
  redirect '/login' unless logged_in?
  if params[:search_date]
    date = DateTime.parse(params[:search_date])
    @asin_logs = AsinLog.where("created_at >= ? AND created_at < ?", date, date.tomorrow)
  else
    @asin_logs = AsinLog.todays_records
  end
  erb :'asins/by_day'
end

get '/asins/new' do
  redirect '/login' unless logged_in?
  erb :'asins/new'
end

post '/asins' do
  redirect '/login' unless logged_in?
  @asin = Asin.new(name: params[:name])
  if @asin.save
    @success = "Asin was submitted successfully!"
    erb :'asins/new'
  else
    @errors = @asin.errors.full_messages
    erb :'asins/new'
  end
end

post '/multiple_asins' do
  redirect '/login' unless logged_in?
  asins = params[:names]
  redirect '/asins/new' if asins.empty?
  asins = asins.delete("\n\r ").split(",")
  asins.each do |asin|
    new_asin = Asin.new(name: asin)
    @errors = [] unless @errors
    @errors << "#{asin} could not save" unless new_asin.save
  end
  @success = "Asin(s) were submitted successfully!" if @errors.empty?
  erb :'asins/new'
end

get '/asins/:asin' do
  redirect '/login' unless logged_in?
  @asin = Asin.find_by(name: params[:asin])
  @asin_logs = @asin.logs
  erb :'asins/show'
end

delete '/asins/delete/:id' do
  redirect '/login' unless logged_in?
  asin = Asin.find_by(id: params[:id])
  asin_logs = asin.logs
  asin.destroy
  asin_logs.each {|log| log.destroy} if asin_logs
  redirect '/asins/delete'
end
