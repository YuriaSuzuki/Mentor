require 'slack-ruby-client'

Slack.configure do |config|
  config.token = 'xoxb-122070278885-UqPJFSQ5DNJEfKObgU3Q75CX'
end
p "here 1"
client = Slack::RealTime::Client.new
p client
p "here 2"
# 接続の確認
client.on :hello do
  puts 'connected!'
end

# Slackに接続
client.start!
