class StaysController < ApplicationController
  before_action :authenticate_user!

  def index
    @stays = Stay.all
  end

  def new
    @stay = Stay.new
  end

  def create
    @stay = Stay.new(stay_params)
    @stay.user = current_user
    # If the "Other" option is selected, and the `other_room_name` is filled out:
    if params[:room_id] == "Other" && @stay.other_room_name.present?
      # Do something special, like creating a new room, or whatever you intend
      room = Room.create!(name: @stay.other_room_name)
      @stay.room = room
    end
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
      render :edit
    end
  end


  def destroy
    @stay = Stay.find(params[:id])
    @stay.destroy
    redirect_to stays_path, notice: 'Stay was successfully deleted.'
  end

  private

  def stay_params
    params.require(:stay).permit(:start_date, :end_date, :room_id, :other_room_name)
  end
end
