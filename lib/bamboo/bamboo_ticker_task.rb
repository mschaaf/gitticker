require 'rufus/scheduler'
require_relative 'bamboo_ticker'

ticker = BambooTicker.new
ticker.tick
puts 'refresh in 1min...'

scheduler = Rufus::Scheduler.start_new

scheduler.every("1m") do
  system("clear")
  ticker.tick

  puts 'refresh in 1min...'
end

scheduler.join
