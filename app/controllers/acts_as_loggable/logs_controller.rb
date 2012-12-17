class ActsAsLoggable::LogsController < AuthenticatedController

  def index
    if params[:loggable_id]
      @loggable_path = ActsAsLoggable::Log.new( :loggable_type => @loggable_type,
                                :loggable_id => params[:loggable_id]).loggable_path
      @logs = ActsAsLoggable::Log.where( :loggable_type => @loggable_type,
                                         :loggable_id => params[:loggable_id])
                                  .order('id').paginate(:page => params[:page])
    else
      @logs = ActsAsLoggable::Log.order('id').paginate(:page => params[:page])
    end
  end

  def show
  end

  def new
    @log = ActsAsLoggable::Log.new(:loggable_type => @loggable_type, :loggable_id => params[:loggable_id])
  end

  def create
    params[:acts_as_loggable_log][:logger_id] = current_user.id.to_s
    params[:acts_as_loggable_log][:logger_type] = current_user.class.to_s
    log = ActsAsLoggable::Log.new(params[:acts_as_loggable_log])
    if log.save
      redirect_to log.loggable_path
    else
      puts log.errors.inspect
      render :new
    end
  end

  def edit
    @log = ActsAsLoggable::Log.find_by_id(params[:id])
  end

  def update
    @log = ActsAsLoggable::Log.find_by_id(params[:id])
    @log.update_attributes(params[:acts_as_loggable_log].except(:loggable_type, :loggable_type,
                                                                :logger_type, :logger_id,))
    redirect_to @log.loggable_path
  end

  def destroy
  end

end
