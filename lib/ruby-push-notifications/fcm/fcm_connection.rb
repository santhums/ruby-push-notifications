require 'uri'
require 'net/https'

require 'httparty'
require 'cgi'
require 'json'

module RubyPushNotifications
  module FCM
    # Encapsulates a connection to the FCM service
    # Responsible for final connection with the service.
    #
    # @author Carlos Alonso
    class FCMConnection

      # @private The URL of the Android FCM endpoint
      FCM_URL = 'https://fcm.googleapis.com/fcm'

      # @private Content-Type HTTP Header string
      CONTENT_TYPE_HEADER  = 'Content-Type'

      # @private Application/JSON content type
      JSON_CONTENT_TYPE    = 'application/json'

      # @private Authorization HTTP Header String
      AUTHORIZATION_HEADER = 'Authorization'
      GROUP_NOTIFICATION_BASE_URI = 'https://android.googleapis.com/gcm'

      # Issues a POST request to the FCM send endpoint to
      # submit the given notifications.
      #
      # @param notification [String]. The text to POST
      # @param key [String]. The FCM sender id to use
      #    (https://developer.android.com/google/gcm/gcm.html#senderid)
      # @return [FCMResponse]. The FCMResponse that encapsulates the received response
      def self.post(notification, key)
        headers = {
            CONTENT_TYPE_HEADER => JSON_CONTENT_TYPE,
            AUTHORIZATION_HEADER => "key=#{key}"
        }
        # TODO: remove to_json if causing error
        params = {
          body: notification,
          headers: {
            AUTHORIZATION_HEADER => "key=#{key}",
            CONTENT_TYPE_HEADER => JSON_CONTENT_TYPE
          }
        }

        fcm_request = FCMRequest.new(params)
        response = fcm_request.make_request
        # puts '*' * 10
        # puts response
        # puts '*' * 10
        FCMResponse.new response.code.to_i, response.body
      end

    end
  end
end
