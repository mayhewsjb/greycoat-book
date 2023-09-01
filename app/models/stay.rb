class Stay < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :start_date, :end_date, presence: true
  validates :other_room_name, presence: true, if: :other_room_selected?

  def other_room_selected?
    # Adjust this logic based on how you identify the "Other" option
    room_id == 'Other'
  end
end
