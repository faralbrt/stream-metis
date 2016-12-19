get '/asins/today' do
  @asin_logs = AsinLog.todays_records
  erb :'asins/show'
end
