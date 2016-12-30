class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :attendance_manegement_id
      t.string :name
      t.datetime :start_time
      t.datetime :extimate_end_time
      t.datetime :actual_end_time
      t.boolean :finished_flag

      t.timestamps null: false
    end
  end
end
