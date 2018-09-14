Rails.application.routes.draw do
  get '/list' => 'lists#list'
  get '/list/:name' => 'lists#get'
  post '/list/:name' => 'lists#set'
  get '/' => redirect('/ProxyHostList/index.html')
end
