
module RubyPushNotifications
  module FCM

    # This class is responsible for sending notifications to the FCM service.
    #
    # @author Carlos Alonso
    class FCMPusher

      # Initializes the FCMPusher
      #
      # @param key [String]. FCM sender id to use
      def initialize(key)
        @key = key
      end

      # Actually pushes the given notifications.
      # Assigns every notification an array with the result of each
      # individual notification.
      #
      # @param notifications [Array]. Array of FCMNotification to send.
      def push(notifications)
        notifications.each do |notif|
          notif.results = FCMConnection.post notif.as_fcm_json, @key
        end
      end
    end
  end
end
