#!/usr/bin/env bundle exec ruby

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'fcm-ruby-push-notifications'

registration_ids = [
  'First registration id here',
  'Second registration id here'
]

notification = RubyPushNotifications::GCM::GCMNotification.new registration_ids, { text: 'Hello GCM World!' }

pusher = RubyPushNotifications::GCM::GCMPusher.new "Your app's GCM key"
# Open and read timeouts default to 30s
# pusher = RubyPushNotifications::GCM::GCMPusher.new "Your app's GCM key", { open_timeout: 10, read_timeout: 10 }

# Manually set GCM URL (e.g. useful for load testing)
# pusher = RubyPushNotifications::GCM::GCMPusher.new "Your app's GCM key", { url: "https://example.com/gcm/send" }

pusher.push [notification]
p 'Notification sending results:'
p "Success: #{notification.success}, Failed: #{notification.failed}"
p 'Details:'
p notification.individual_results
