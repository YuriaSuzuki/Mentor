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
    # users.id 参照
    # att_mas.id, user_id, start_time 記録
    client.message channel: data['channel'],
    text: "おはよう！ attendance_managements.start_time に出社記録しました。\n
           今日のタスク一覧は？"

  when 'タスク', 'tasks' then
    client.message channel: data['channel'],
    text: "タスクと見積もり時間(h)を入力してください(間を:で挟んでください)"
    # inputを取得して, text.id, att_man_id, name, start_time, estimate_end_time 記録
    # "終了予定時刻は#{tasks.estimate_end_time}です。頑張ろう!」"

  when '終わった', 'finished' then
    # tasks.actual_end_time, finished_flag記録
    # 実査にかかった時間, 見積もり時間を計算
    client.message channel: data['channel'],
    text: "お疲れ様!"
    # "見積もり時間はxxxでした。\n実際にかかった時間はxxxです。\n"
    # サインさんからのありがたーいメッセージ
  when '日報', 'nippou' then
    # atte_mag.start_time, tasks.where(attd_mag_idが同じもの).name, estimate_end_time, actual_end_timeを呼び出す
    client.message channel: data['channel'],
    text: "今日の働きの成果はxxxです"

  when 'お疲れ様', '乙' then
    # atte_mag.end_time 記録
    client.message channel: data['channel'],
    text: "今日はxxxからxxxまで働きました。お疲れ様です!"
  when '教えてmentor' then
    client.message channel: data['channel'],
    text: "mentorについての説明"
  end
end


# Slackに接続
client.start!
