
module RubyPushNotifications
  module FCM

    # This class encapsulates a response received from the FCM service
    # and helps parsing and understanding the received meesages/codes.
    #
    # @author Carlos Alonso
    class FCMResponse

      # @return [Integer] the number of successfully sent notifications
      attr_reader :success

      # @return [Integer] the number of failed notifications
      attr_reader :failed

      # @return [Integer] the number of received canonical IDS
      #    (https://developer.android.com/google/gcm/server-ref.html#table4)
      attr_reader :canonical_ids

      # @return [Array] Array of a GCMResult for every receiver of the notification
      #   sent indicating the result of the operation.
      attr_reader :results
      alias_method :individual_results, :results

      # Initializes the GCMResponse and runs response parsing
      #
      # @param code [Integer]. The HTTP status code received
      # @param body [String]. The response body received.
      # @raise MalformedGCMJsonError if code == 400 Bad Request
      # @raise GCMAuthError if code == 401 Unauthorized
      # @raise GCMInternalError if code == 5xx
      # @raise UnexpectedGCMResponseError if code != 200
      def initialize(code, body)
        case code
        when 200
          parse_response body
        when 400
          raise MalformedFCMJSONError, body
        when 401
          raise FCMAuthError, body
        when 500..599
          raise FCMInternalError, body
        else
          raise UnexpectedFCMResponseError, code
        end
      end

      def ==(other)
        (other.is_a?(FCMResponse) &&
          success == other.success &&
          failed == other.failed &&
          canonical_ids == other.canonical_ids &&
          results == other.results) || super(other)
      end

      private

      # Parses the response extracting counts for successful, failed and
      # containing canonical ID messages.
      # Also creates the results array assigning a GCMResult subclass for each
      # registration ID the notification was sent to.
      #
      # @param body [String]. The response body
      def parse_response(body)
        json = JSON.parse body, symbolize_names: true
        @success = json[:success]
        @failed = json[:failure]
        @canonical_ids = json[:canonical_ids]
        @results = (json[:results] || []).map { |result| fcm_result_for result }
      end

      # Factory method that, for each GCM result object assigns a GCMResult
      # subclass.
      #
      # @param result [Hash]. GCM Result parsed hash
      # @return [GCMResult]. Corresponding GCMResult subclass
      def fcm_result_for(result)
        if canonical_id = result[:registration_id]
          FCMCanonicalIDResult.new canonical_id
        elsif error = result[:error]
          FCMResultError.new error
        else
          FCMResultOK.new
        end
      end
    end
  end
end
