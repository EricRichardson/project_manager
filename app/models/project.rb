class Project < ActiveRecord::Base
  validates :title, presence: true,
                    uniquiness: true
end
