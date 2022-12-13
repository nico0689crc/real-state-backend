class User < ActiveRecord::Base
  extend Devise::Models
  include DeviseTokenAuth::Concerns::User

  has_one_attached :avatar_image, dependent: :delete_all
  belongs_to :real_estate, optional: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #--------------------------------------------- MISC
  enum user_role: [
    :super_administrator,
    :administrator,
    :real_estate_administrator,
    :agent,
    :user_regular,
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

  def is_not_current_user?(current_user)
    unless current_user.id != id 
      errors.add(:message, "You cannot destroy yourself.")
      return false
    end
    return true
  end

  def check_permitted_roles(current_user, p_user_role)
    unless permitted_roles(current_user).include?(p_user_role.to_sym)
      errors.add(:user_role, "You are not allowed to updated to this role.")
      return false
    end
    return true
  end

  def update_password(params)
    errors.add(:current_password, "Current Password is empty.") if params[:current_password].blank?
    errors.add(:current_password, "Current Password is invalid.") unless valid_password?(params[:current_password])
    
    if params[:password].blank? || params[:password_confirmation].blank?
      errors.add(:password, "Password is empty.") if params[:password].blank?
      errors.add(:password_confirmation, "Password Confirmation is empty.") if params[:password_confirmation].blank?
    else
      if passwords_match(params)
        errors.add(:password, "Password format is not valid.") unless params[:password].match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*#?&]).{4,}$/)
      else
        errors.add(:password_confirmation, "Password Confirmation does not match with Password.")
      end
    end
    params.delete(:current_password)
    errors.empty? ? update(params) : false
  end

  private

  def passwords_match(params)
    params[:password] == params[:password_confirmation]
  end

  def password_required?
    return false if send_password_reset_user_initial
    super
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

  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*#?&]).{4,}$/)
      errors.add :password, "Password format invalid."
    end
  end

  def permitted_roles(current_user)
    if current_user.super_administrator?
      if current_user.id == self.id
        [:super_administrator]
      else
        [:super_administrator, :administrator, :user_regular, :real_estate_administrator, :agent, :banned]
      end
    elsif current_user.administrator?
      [:administrator]
    elsif current_user.real_estate_administrator?
      [:real_estate_administrator, :agent]
    elsif current_user.agent?
      [:agent]
    elsif current_user.user_regular?
      [:user_regular]
    else
      [:banned]
    end
  end
end
