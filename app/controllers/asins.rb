get '/asins/delete' do
  @asins = Asin.sort_by_title
  erb :'asins/index_delete'
end


get '/asins/today' do
  if params[:search_date]
    date = DateTime.parse(params[:search_date])
    @asin_logs = AsinLog.where("created_at >= ? AND created_at < ?", date, date.tomorrow)
  else
    # @asin_logs = AsinLog.todays_records
    @asin_logs = AsinLog.all
  end
  erb :'asins/by_day'
end

get '/asins/new' do
  erb :'asins/new'
end

post '/asins' do
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
  @asin = Asin.find_by(name: params[:asin])
  @asin_logs = @asin.logs
  erb :'asins/show'
end

delete '/asins/delete/:id' do
  asin = Asin.find_by(id: params[:id])
  asin_logs = asin.logs
  asin.destroy
  asin_logs.each {|log| log.destroy} if asin_logs
  redirect '/asins/delete'
end
