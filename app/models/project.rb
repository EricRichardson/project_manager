class Project < ActiveRecord::Base
  has_many :discussions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  belongs_to :user

  has_many :membership, dependent: :destroy
  has_many :users, through: :membership

  has_many :favoriting_users, through: :favorites, source: :user
  has_many :favorites, dependent: :destroy

  validates :title,   presence: true,
                      uniqueness: true
  validate :due_date_checker

  def due_date_checker
    if due_date && due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

  def favorited_by?(user)
    favorites.exists?(user: user)
  end

  def favorite_for(user)
    favorites.find_by_user_id user
  end
end
