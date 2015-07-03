require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'bundler/setup'
require 'rack-flash'

configure(:development){set :database, "sqlite3:microblog.sqlite3"}

set :sessions,  true


get '/' do
  erb :sign_in
end

get '/sign-in' do
 erb :sign_in
end

post '/sign-in' do
  @user = User.where(username: params[:username]).first   
  if @user && @user.password == params[:password]     
    session[:user_id] = @user.id
    redirect '/welcome'   
  else     
    redirect '/login-failed'   
  end 
end






get '/sign-up' do
  erb :sign_up
end

post '/sign-up' do
  @user = User.create(params[:user])    
  session[:user_id] = @user.id
  redirect '/profile-form'
end

get '/profile-form' do
  erb :profile_form

end

post '/profile-form' do
  # puts session[:user_id]
  
  @profile = Profile.new(params)
  @profile.user_id = session[:user_id]
  @profile.save
  # puts @profile.inspect
  redirect '/welcome'
end




get '/welcome' do
  @user = User.where(id: session[:user_id]).first
  @user.username
  @blogs = Blog.last(10)
  erb :welcome
end

post '/welcome' do
  @blog = Blog.new(params[:blog])
  @blog.user_id = session[:user_id]
  @blog.save
  # params[:content] = @blog.content
  # params[:user_id]= session[:user_id]
  redirect '/welcome'
end



get '/profile' do
  @user = User.where(id: session[:user_id]).first
  @user.username
  
  @profile = Profile.where(user_id: session[:user_id]).first
  @profile.fname
  @profile.lname
  @profile.email
  @profile.city

  erb :profile
end

get '/profile_edit' do
  erb :profile_edit
end

post '/profile_edit' do
  @profile = Profile.where(user_id: session[:user_id]).first
  @profile.fname = params[:fname]
  @profile.lname = params[:lname]
  @profile.email = params[:email]
  @profile.city = params[:city] 
  @profile.save
  redirect '/profile'
end







get '/deletecheck' do
  @user = User.where(id: session[:user_id]).first
  @user.username
  erb :deletecheck
end


get '/fuckoff' do
  erb :fuckoff
end

post '/fuckoff' do
  @user = User.where(id: session[:user_id]).first
  @user.destroy

  @blogs = Blog.where(user_id: session[:user_id])
  @blogs.destroy_all


  @profiles = Profile.where(user_id: session[:user_id]).first
  @profiles.destroy

  redirect '/fuckoff'
end








get '/log-out' do
  session.clear 
  redirect '/goodbye'
end

get '/goodbye' do
  erb :goodbye
end




 # @blog.user_id







