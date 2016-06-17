class User < ActiveRecord::Base
  has_secure_password
  has_many :tasks
  has_many :discussions
  has_many :comments
  has_many :projects

  def full_name
    "#{first_name} #{last_name}"
  end
end
