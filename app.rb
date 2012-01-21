load 'twilio-say.rb'
require 'sinatra'

get '/call/:number' do
    """Calls a phone number, plays some sad Vader."""
    Caller.new("http://#{request.host}:#{request.port.to_s}").dial(params[:number])
    "Now dialing #{params[:number]}..."
end
