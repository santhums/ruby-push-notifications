require 'httparty'
require 'cgi'
require 'json'

module RubyPushNotifications
  module FCM
    # Encapsulates a connection to the FCM service
    # Responsible for final connection with the service.
    #
    # @author Carlos Alonso
    class FCMRequest
      include HTTParty
      default_timeout 30
      format :json

      base_uri 'https://fcm.googleapis.com/fcm'

      def initialize(params = {})
        @params = params
      end
      def make_request
        response = self.class.post('/send', @params)
      end
    end
  end
end
