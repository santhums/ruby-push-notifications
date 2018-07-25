#!/usr/bin/env bundle exec ruby

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'fcm-ruby-push-notifications'

device_urls = [
  'First device url here',
  'Second device url here'
]

# Notification with toast type
notification = RubyPushNotifications::MPNS::MPNSNotification.new device_urls, { title: 'Title', message: 'Hello MPNS World!', type: :toast }

pusher = RubyPushNotifications::MPNS::MPNSPusher.new
# Open and read timeouts default to 30s
# pusher = RubyPushNotifications::MPNS::MPNSPusher.new optional_certificate, { open_timeout: 10, read_timeout: 10 }
pusher.push [notification]
p 'Notification sending results:'
p "Success: #{notification.success}, Failed: #{notification.failed}"
p 'Details:'
p notification.individual_results
