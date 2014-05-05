class Api::V1::TasksController < Api::V1::BaseController
  EXPECTED_TASKS = "Expected a list of tasks in submitted data."
  CANNOT_MANAGE = "You do not have permission to manage this task."
  NOT_FOUND = "The task could not be found."

  before_filter :validate_params
  before_filter :get_tasks
  before_filter :check_task_permission, except: :show

  def update
    errors = []
    @tasks.each do |task_hash|
      task = task_hash[:record]
      attrs = task_hash[:new_attributes]
      task.update_attributes(attrs)
      if !task.errors.empty?
        errors << { id: task.id, errors: task.errors }
      end
    end

    if !errors.empty?
      render json: { errors: errors }, status: 422 and return
    end
  end

  private
    def validate_params
      if params[:tasks].nil? and not params[:tasks].kind_of?(Array)
        render json: { errors: [EXPECTED_TASKS]}, status: 422 and return
      end
    end

    def get_tasks
      @tasks = []
      errors = []

      params[:tasks].each do |task|
        t = Task.find_by_id(task[:id])
        if t.nil?
          errors << { id: task[:id], error: NOT_FOUND }
        else
          @tasks << { record: t, new_attributes: task }
        end
      end

      if !errors.empty?
          render json: { errors: errors }, status: 404 and return
      end
    end

    def check_task_permission
      errors = []
      @tasks.each do |task_hash|
        task = task_hash[:record]
        if task.task_list.item != current_user.bike
          errors << { id: task[:id], error: CANNOT_MANAGE }
        end
      end

      if cannot? :manage, Bike and !errors.empty?
        render json: { errors: errors}, status: 403 and return
      end
    end
end
