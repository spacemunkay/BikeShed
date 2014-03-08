class Api::V1::TaskListsController < Api::V1::BaseController
  CANNOT_MANAGE = "You do not have permission to manage this task list."
  NOT_FOUND = "The task list could not be found."

  before_filter :get_task_list
  before_filter :check_task_list_permission, except: :show

  def show
  end

  def edit
    #@task_list.update_attributes(params)
  end

  private
    def get_task_list
      @task_list = TaskList.find(params[:id])
      if @task_list.nil?
        render json: { errors: [NOT_FOUND] }, status: 404 and return
      end
    end

    def check_task_list_permission
      if cannot? :manage, Bike and @task_list.item != current_user.bike
        render json: { errors: [CANNOT_MANAGE]}, status: 403 and return
      end
    end
end
