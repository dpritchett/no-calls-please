require './twilio-dial'
require 'sinatra'
require 'haml'

# Calls a phone number, plays some sad Vader.
post '/call' do
  begin
    phone_number = params.fetch("phone_number")
    dial phone_number
  rescue Exception => err
    return "<h1>Dialer failure</h1>\n<tt>#{err}</tt>"
  end

  "Ringing #{phone_number}..."
end

get '/' do
  haml :index
end

post '/callme' do
  begin
    dial(ENV.fetch("MY_NUMBER"))
  rescue Exception => err
    return "<h1>Dialer failure</h1>\n<tt>#{err}</tt>"
  end

  "Success!"
end

def dial(phone_number)
  dialer.dial phone_number
end

private
def dialer
  Caller.new("http://#{request.host}:#{request.port.to_s}")
end
