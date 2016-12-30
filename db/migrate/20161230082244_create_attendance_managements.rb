class CreateAttendanceManagements < ActiveRecord::Migration
  def change
    create_table :attendance_managements do |t|
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :rest_hour
      t.integer :actual_work_hour

      t.timestamps null: false
    end
  end
end
