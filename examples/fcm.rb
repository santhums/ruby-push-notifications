#!/usr/bin/env bundle exec ruby

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'fcm-ruby-push-notifications'

registration_ids = [
  'First registration id here',
  'Second registration id here'
]

notification = RubyPushNotifications::FCM::FCMNotification.new registration_ids, { text: 'Hello FCM World!' }

pusher = RubyPushNotifications::FCM::FCMPusher.new "Your app's FCM key"

pusher.push [notification]
p 'Notification sending results:'
p "Success: #{notification.success}, Failed: #{notification.failed}"
p 'Details:'
p notification.individual_results
