require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'bundler/setup'
require 'rack-flash'

configure(:development){set :database, "sqlite3:blog.sqlite3"}

set :sessions,  true


get '/' do
  erb :index
end


get '/sign-up' do
  erb :sign_up

end

post '/sign-up' do
  @user = User.create(params[:user])    
  session[:user_id] = @user.id
  redirect '/profile-form'
end



get '/sign-in' do
 
 erb :sign_in

end

get '/log-out' do
  session.clear 
end

post '/sign-in' do

  @user = User.where(username: params[:username]).first   
  if @user && @user.password == params[:password]     
    session[:user_id] = @user.id
    redirect '/index'   

  else     
    redirect '/login-failed'   
  end 
end



get '/profile-form' do


  erb :profile_form
end

post '/profile-form' do
  puts session[:user_id]
  
  @profile = Profile.new(params)
  @profile.user_id = session[:user_id]
  @profile.save
  puts @profile.inspect
  redirect '/welcome'

end





