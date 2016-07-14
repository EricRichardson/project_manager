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
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}, unless: :using_oauth?


  def full_name
    "#{first_name} #{last_name}"
  end

  def self.create_from_github(github_data)
    user = User.new
    full_name = github_data["info"]["name"].split(" ")
    user.first_name = full_name.first
    user.last_name = full_name.last
    user.password = SecureRandom.urlsafe_base64
    user.uid = github_data["uid"]
    user.provider = github_data["provider"]
    user.github_token = github_data["token"]
    user.save!
    user
  end

  def self.find_or_create_from_github(github_data)
    user = User.find_by_uid github_data["uid"]
    user = User.create_from_github(github_data) unless user
    user
  end

  def using_oauth?
    uid.present? && provider.present?
  end

  def using_github
    using_oauth? && provider = "github"
  end
end
