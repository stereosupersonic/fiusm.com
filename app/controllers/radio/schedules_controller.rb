class Radio::SchedulesController < RadioController
  def show
    @date = params[:date] ? Date.parse(params[:date]) : DateTime.now.hour < 4 ? Date.today - 1.day : Date.today
    @events = RadioShowEvent.day(@date)
  end
end