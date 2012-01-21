load 'twilio-say.rb'
require 'sinatra'

get '/call/:number' do
    """Calls a phone number, plays some sad Vader."""
    Caller.new("http://#{request.host}:#{request.port.to_s}").dial(params[:number])
    "Now dialing #{params[:number]}..."
end

get '/' do
    """
    Welcome to No Calls Please!  See the project's <a href='https://github.com/dpritchett/no-calls-please'>github</a> page for more information.
    """
end
