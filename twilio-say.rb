require 'twilio-ruby'

class Caller
    """
    Twilio API phone caller / SMS dialer.

    Darth Vader is gonna call and let me know when I hit the wrong key in vim.
    """
    def initialize(hostname)
        """
        For this to work you'll need to host a valid TwiML call script at hostname/public/twiml/call.xml.
        """
        @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'],
            ENV['TWILIO_AUTH_TOKEN']

        @from = @client.account.incoming_phone_numbers.list.first.phone_number
        @url = hostname
    end

    def sms(to_number, message)
        @client.account.sms.messages.create(
            :from => @from,
            :to => "+1" + to_number.to_s,
            :body => message.to_s)
    end

    def dial(to_number)
        @client.account.calls.create(
            :from => @from,
            :to => "+1" + to_number.to_s,
            :url => @url + "/twiml/call.xml",
            :method => 'GET'
        )
    end
end
