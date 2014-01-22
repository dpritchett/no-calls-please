require 'dotenv'; Dotenv.load
require 'twilio-ruby'

# Twilio API phone caller / SMS dialer.
#
# Darth Vader is gonna call and let me know when I hit the wrong key in vim.
#
class Caller
  def initialize(hostname)
    @url = hostname
  end

  attr_reader :url

  def dial(to_number)
    dest = format_phone_number(to_number)
    puts "Dialing #{dest}"

    client.account.calls.create(
      to:     dest,
      from:   from_number,
      url:    "#{url}/twiml/call.xml",
      method: 'GET',
    )
  end

  private
  def format_phone_number(text)
    raise "No phone number supplied!" if text.to_s.empty?
    text.gsub(/[^\d]/, '')
  end

  def from_number
    calling_numbers.first or raise "No phone numbers registered"
  end

  def calling_numbers
    client.account.incoming_phone_numbers.list.map(&:phone_number)
  end

  def client
    @client_memo ||= Twilio::REST::Client.new(
      ENV.fetch('TWILIO_ACCOUNT_SID'),
      ENV.fetch('TWILIO_AUTH_TOKEN')
    )
  end
end
