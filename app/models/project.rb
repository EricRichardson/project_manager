class Project < ActiveRecord::Base
  validates :title,   presence: true,
                      uniqueness: true
  validate :due_date_checker

  def due_date_checker
    if due_date && due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

end
