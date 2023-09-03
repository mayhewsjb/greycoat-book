class Todo < ApplicationRecord
  belongs_to :user
  before_save :set_completed_at
  validates :title, presence: true

  private

  def set_completed_at
    if status_changed? && status
      self.completed_at = Time.current
    elsif status_changed? && !status
      self.completed_at = nil
    end
  end
end
