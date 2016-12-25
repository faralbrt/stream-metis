get '/login' do
  erb :'sessions/new'
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/sessions' do
  @user = User.find_by(username: params[:username])
  if @user && @user.authenticate(params[:password])
    session[:id] = @user.id
    redirect '/'
  else
    @errors = ["Wrong Email and Password combination"]
    erb :'sessions/new'
  end
end
