require 'sinatra'
require "sinatra/json"

set :public_folder, 'public'

get '/' do
 	File.read('public/index.html')
end

get '/ajax' do
	sleep(1.0)
 	json :serverResponse => 'Resposta do servidor'
end