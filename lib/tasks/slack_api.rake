require 'slack-ruby-client'

Slack.configure do |config|
  config.token = 'xoxb-122070278885-UqPJFSQ5DNJEfKObgU3Q75CX'
end

client = Slack::RealTime::Client.new

# 接続の確認
client.on :hello do
  puts 'connected!'
end

# 全てに関して例外必要
client.on :message do |data|
  case data['text']
  when '出社', 'syussya' then
      user_name = data['user']
      start_time = Time.now
      RakeTasks::SlackApis.record_start_working_time(user_name, start_time)

    client.message channel: data['channel'],
    text: "おはよう！ attendance_managements.start_time に出社記録しました。\n
           今日のタスク一覧は？"
=begin
  when 'タスク', 'tasks' then
    client.message channel: data['channel'],
    #text: "タスクと見積もり時間(h)を入力してください(間を:で挟んでください)"
    text: "task: から初めてタスクを入力してください"

    user_name = data['user']
    task_name_estimate_hours = data['text']
    start_time = Time.now

    RakeTasks::SlackApis.start_task(user_name, task_name_estimate_hours, start_time)
    # inputを取得して, text.id, att_man_id, name, start_time, estimate_end_time 記録
    # "終了予定時刻は#{tasks.estimate_end_time}です。頑張ろう!」"
  when 'task:'
    input
    text: "hour: から初めて見積もり時間を入力してください"

  when 'hour:'
    tasks.nil? == true error tasks: とタイプしてください
    input
=end
  when '終わった', 'finished' then
    RakeTasks::SlackApis.finish_task(data['user'], Time.now)
    task_manage_hours = RakeTasks::SlackApis.task_manage_hours

    client.message channel: data['channel'],
    text: "お疲れ様！\n
           見積もり時間: #{task_manage_hours[0]}\n
           実際にかかった時間: #{task_manage_hours[1]}"
    # 社員さんからのありがたーいメッセージ

  when '日報', 'dailyreport' then
    start_time  = RakeTasks::SlackApis.attendance_management_start_time
    todays_tasks = RakeTasks::SlackApis.todays_tasks

    client.message channel: data['channel'],
    text: "今日の働きの成果です。\n
           業務開始時刻: #{start_time}\n
           タスク一覧: #{todays_tasks}\n
           "

  when 'お疲れ様', '乙' then
    RakeTasks::SlackApis.record_end_working_time(Time.now)

    client.message channel: data['channel'],
    text: "今日はxxxからxxxまで働きました。お疲れ様です!"

  when '教えてmentor' then
    client.message channel: data['channel'],
    text: "mentorについての説明"
  end
end


# Slackに接続
client.start!
