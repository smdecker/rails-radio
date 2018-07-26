class User < ApplicationRecord
  has_many :episodes
  has_many :comments
  
  has_many :favorite_episodes
  has_many :favorites, through: :favorite_episodes, source: :episode

  has_attached_file :avatar, styles: { thumb: "70x70#" }, default_url: "/assets/:style/missing_profile.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_and_belongs_to_many :oauth_credentials

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  validates :username, presence: :true, uniqueness: { case_sensitive: false }

  extend FriendlyId
  friendly_id :username, use: :slugged

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def admin_favorites_recent
    favorites.order(created_at: :desc).first(6)
  end

  def admin_favorites_all
    favorites.order(created_at: :desc)
  end

  def comments_desc
    comments.order(created_at: :desc)
  end

  def favorites_desc
    favorites.order(created_at: :desc)
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    @user = User.where(email: data['email']).first
    unless @user
      @user = User.create(username: data['name'],
         email: data['email'],
         password: Devise.friendly_token[0,20]
      )
    end    
    	@user
  end
end
