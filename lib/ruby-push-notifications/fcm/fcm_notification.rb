
module RubyPushNotifications
  module FCM
    # Encapsulates a GCM Notification.
    # By default only Required fields are set.
    # (https://developer.android.com/google/gcm/server-ref.html#send-downstream)
    #
    # @author Carlos Alonso
    class FCMNotification
      include RubyPushNotifications::NotificationResultsManager

      # Initializes the notification
      #
      # @param [Array]. Array with the receiver's GCM registration ids.
      # @param [Hash]. Payload to send.
      def initialize(registration_ids, data)
        @registration_ids = registration_ids
        @data = data
      end

      # @return [String]. The GCM's JSON format for the payload to send.
      #    (https://developer.android.com/google/gcm/server-ref.html#send-downstream)
      def as_fcm_json
        JSON.dump(
          registration_ids: @registration_ids,
          data: @data
        )
      end
    end
  end
end
