class TaskListsController < AuthenticatedController
  def edit
    @task_list = TaskList.find_by_id(params[:id])
  end
end
