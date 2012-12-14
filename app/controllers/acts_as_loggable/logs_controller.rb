class ActsAsLoggable::LogsController < AuthenticatedController
  before_filter :set_loggable_id

  def index
    if params[:loggable_id]
      @logs = ActsAsLoggable::Log.where( :loggable_type => @loggable_type, :loggable_id => @loggable_id).order('id').paginate(:page => params[:page])
      set_loggable_path
    else
      @logs = ActsAsLoggable::Log.order('id').paginate(:page => params[:page])
    end
  end

  def show
  end

  def new
    @log = ActsAsLoggable::Log.new(:loggable_type => @loggable_type, :loggable_id => @loggable_id)
    set_loggable_path
  end

  def create
    params[:acts_as_loggable_log][:logger_id] = current_user.id.to_s
    params[:acts_as_loggable_log][:logger_type] = current_user.class.to_s
    log = ActsAsLoggable::Log.new(params[:acts_as_loggable_log])
    if log.save
      set_loggable_path
      redirect_to @loggable_path
    else
      puts log.errors.inspect
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

    def set_loggable_id
      @loggable_id = params[:loggable_id]
    end

    def set_loggable_path
      @loggable_path = "/#{@loggable_type.pluralize.downcase}/#{@loggable_id}/logs"
    end
end
