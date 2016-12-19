get '/asins/today' do
  @asin_logs = AsinLog.todays_records
  erb :'asins/_table', layout: true
end

get '/asins/:asin' do
  @asin_logs = AsinLog.find_by_asin_name(params[:asin])
  erb :'asins/_table', layout: true
end
