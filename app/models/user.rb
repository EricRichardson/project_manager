class User < ActiveRecord::Base
  has_secure_password
  has_many :tasks, dependent: :nullify
  has_many :discussions, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :projects, dependent: :nullify

  has_many :favorites, dependent: :destroy
  has_many :favorite_projects, through: :favorites, source: :project

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships, source: :project

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}


  def full_name
    "#{first_name} #{last_name}"
  end
end
