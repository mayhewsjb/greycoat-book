class StaysController < ApplicationController
  before_action :authenticate_user!

  def index
    @stays = Stay.where('end_date > ?', DateTime.now)
    @rooms = Room.all
  end

  def my_stays
    @stays = current_user.stays
  end

  def new
    @stay = Stay.new
  end

  def create
    @stay = Stay.new(stay_params)
    @stay.user = current_user

    if @stay.save
      redirect_to stays_path, notice: 'Stay was successfully created.'
    else
      render :new
    end
  end

  def show
    @stay = Stay.find(params[:id])
  end

  def edit
    @stay = Stay.find(params[:id])
  end

  def update
    @stay = Stay.find(params[:id])
    if @stay.update(stay_params)
      redirect_to stay_path(@stay), notice: 'Stay was successfully updated.'
    else
      flash.now[:alert] = @stay.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @stay = Stay.find(params[:id])
    @stay.destroy
    redirect_to stays_path, notice: 'Stay was successfully deleted.'
  end

  def fetch_stays
    @stays = Stay.where('end_date >= ?', Date.today)  # This filters out past events

    @stays_json = @stays.map do |stay|
      {
        id: stay.id,
        title: "#{stay.user.first_name} in #{stay.room.name} til #{stay.end_date.strftime('%-d/%-m/%y')}",
        start: stay.start_date.to_s,
        end: (stay.end_date + 1.day).to_s,
        color: stay.room.color,
        room_id: stay.room.id
      }
    end

    render json: @stays_json
  end

  def fetch_my_stays
    @stays = current_user.stays.where('end_date >= ?', Date.today)  # Filtering out past stays

    @stays_json = @stays.map do |stay|
      {
        id: stay.id,
        title: "#{stay.user.first_name} in #{stay.room.name} til #{stay.end_date.strftime('%-d/%-m/%y')}",
        start: stay.start_date.to_s,
        end: (stay.end_date + 1.day).to_s,
        color: stay.room.color,
        room_id: stay.room.id
      }
    end

    render json: @stays_json
  end

  def available_rooms
    start_date = params[:start_date]
    end_date = params[:end_date]

    # Find overlapping stays
    overlapping_stays = Stay.where("start_date <= ? AND end_date >= ?", end_date, start_date)

    # Find rooms which are booked in overlapping stays
    booked_rooms = overlapping_stays.map(&:room)

    # All rooms - Booked rooms gives available rooms
    @available_rooms = Room.all - booked_rooms

    @overlapping_stays = overlapping_stays

    # Instantiate @stay for the form
    @stay = Stay.new(start_date: start_date, end_date: end_date)

    render :select_room
  end

  private

  def stay_params
    params.require(:stay).permit(:start_date, :end_date, :room_id, :description)
  end
end
