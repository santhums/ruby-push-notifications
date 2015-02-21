#!/usr/bin/env ruby

$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'ruby-push-notifications'

notification = RubyPushNotifications::APNS::APNSNotification.new '6400b2a275eacf035d22d285d0ffb58fde5b647e54c7da882703136ba4ecd7d6', { aps: { alert: 'Hola mi cokiciti!', sound: 'true', badge: 1 } }

pusher = RubyPushNotifications::APNS::APNSPusher.new(File.read('/Users/calonso/Desktop/apns.pem'), true)
pusher.push [notification]
