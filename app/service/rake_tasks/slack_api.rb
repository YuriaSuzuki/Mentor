module RakeTasks
  module SlackApis
    module_function

    def set_user
      user = User.where(name: user_name)
    end

    def set_attendance_management
      set_user
      attendance_management = AttendanceManagement.where(user_id: user.id).last
    end

    def record_start_working_time(user_name, start_time)
      set_user
      AttendanceManagement.create(user_id: user.id, start_time: start_time)
    end

    def record_end_working_time(user_name, end_time)
      set_attendance_management
      attendance_management.update(end_time: end_time)
    end

    def start_task(user_name, name, start_time, estimate_hour)
      set_attendance_management
      estimate_end_time = start_time + estimate_hour
      Task.create(
                  name: name,
                  start_time: start_time,
                  estimate_end_time: estimate_end_time,
                  attendance_management_id: attendance_management.id
                  )
    end

    def finish_task(user_name, actual_end_time)
      set_attendance_management
      Task.where(
                 set_attendance_management_id: set_attendance_management.id
                 ).last.update(
                               actual_end_time: actual_end_time,
                               finished_flag: true
                               )
    end

    def task_manage_hours(user_name)
      task = Task.where(user_id: user.id).last
      estimate_manage_hours = task.estimate_end_time - task.start_time
      actual_manage_hours = task.actual_end_time - task.start_time
      [estimate_manage_hours, actual_manage_hours]
    end

    def todays_attendance_management_start_time(user_name)
      set_attendance_management
      attendance_management.start_time
    end

    def todays_tasks(user_name)
      set_attendance_management
      daily_report_datas = Task.where(attendance_management_id: attendance_management.id)
    end
  end
end
