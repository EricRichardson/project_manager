class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, uniqueness: {scope: :project}
end
