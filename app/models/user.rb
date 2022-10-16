class User < ActiveRecord::Base
  extend Devise::Models
  include DeviseTokenAuth::Concerns::User

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

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
  validates :email, presence: true
  validates :password, confirmation: true, if: -> { self.password.present? }
  validates :password_confirmation, presence: true, if: -> { self.password.present? }
  validate :password_complexity

  #--------------------------------------------- METHODS
  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*#?&]).{4,}$/)
      errors.add :password, "Password format invalid."
    end
  end

  protected

  def password_required?
    return false if send_password_reset_user_initial
    super
  end
end
