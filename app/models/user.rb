class User < ActiveRecord::Base
  extend Devise::Models
  include DeviseTokenAuth::Concerns::User

  has_one_attached :avatar_image, dependent: :delete_all

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #--------------------------------------------- MISC
  enum user_role: [
    :user_regular,
    :super_administrator,
    :administrator,
    :agency_administrator,
    :agency_user,
    :banned
  ]

  #--------------------------------------------- VALIDATION
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, if: -> { self.password.present? }
  validates :password_confirmation, presence: true, if: -> { self.password.present? }
  validate :password_complexity
  validate :acceptable_avatar_image
  
  #--------------------------------------------- CALLBACKS
  before_save :skip_confirmation!
  before_update :skip_confirmation!

  #--------------------------------------------- METHODS
  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*#?&]).{4,}$/)
      errors.add :password, "Password format invalid."
    end
  end

  def acceptable_avatar_image
    return unless avatar_image.attached?

    unless avatar_image.byte_size <= 3.megabyte
      errors.add(:avatar_image, "The avatar image size must be smaller to 3MB.")
    end

    acceptable_types = ["image/jpeg", "image/png"]

    unless acceptable_types.include?(avatar_image.content_type)
      errors.add(:avatar_image, "The avatar image size must be type PNG or JPEG.")
    end
  end

  def is_not_current_user?(current_user)
    if current_user.id == self.id
      errors.add(:message, "You cannot destroy yourself.")
      false
    else
      true
    end
  end

  protected

  def password_required?
    return false if send_password_reset_user_initial
    super
  end
end
