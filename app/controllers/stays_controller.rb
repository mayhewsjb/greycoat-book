class StaysController < ApplicationController
  before_action :authenticate_user!

  def index
    @stays = Stay.where('end_date > ?', DateTime.now)
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
    @stays = Stay.all

    @stays_json = @stays.map do |stay|
      {
        id: stay.id,
        title: "#{stay.user.first_name} in #{stay.room.name} til #{stay.end_date.strftime('%-d/%-m/%y')}",
        start: stay.start_date.to_s,
        end: (stay.end_date + 1.day).to_s,  # This line is changed
        color: stay.room.color
      }
    end

    render json: @stays_json
  end

  def fetch_my_stays
    @stays = current_user.stays

    @stays_json = @stays.map do |stay|
      {
        id: stay.id,
        title: "#{stay.user.first_name} in #{stay.room.name} til #{stay.end_date.strftime('%-d/%-m/%y')}",
        start: stay.start_date.to_s,
        end: (stay.end_date + 1.day).to_s,  # This line is changed
        color: stay.room.color
      }
    end

    render json: @stays_json
  end



  private

  def stay_params
    params.require(:stay).permit(:start_date, :end_date, :room_id, :description)
  end
end
