class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    # devise :database_authenticatable, :recoverable, :rememberable, :validatable
    # has_secure_password
    # has_many :products, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_one :cart, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_many :orders, dependent: :destroy
    # has_many :order_items, through: :orders
    has_many :payments, dependent: :destroy
    has_many :razorpay_orders, dependent: :destroy
  
    validates :email, :uniqueness => { :case_sensitive => false }
    validate :password_complexity
    # validate :custom_email_validation
    before_validation :downcase_email


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "id_value", "name", "password", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
  
    def generate_password_token!
      self.reset_password_token = generate_token
      self.reset_password_sent_at = Time.now.utc
      save_tokens
    end
  
    def password_token_valid?
      reset_password_sent_at >= 1.hour.ago
    end
  
    def reset_password!(password)
      self.reset_password_token = nil
      self.password = password
      save!
    end
  
    def custom_email_validation
      if email.present? && User.exists?(["LOWER(email) = ?", email.downcase])
        errors.add(:email, "has already been taken")
      end
    end
  
    private

  def downcase_email
   self.email = email.downcase if email.present?
  end
  
    def password_complexity
      return if password.blank? || password.match?(/(?=.*[A-Z])(?=.*[a-z])(?=.*[\d])(?=.*[[:^alnum:]])/)
      
      errors.add(:password, 'must contain at least one uppercase letter, one lowercase letter, one digit, and one special character')
    end
  
    def generate_token
      SecureRandom.hex(10)
    end
  
    def save_tokens
      update_columns(reset_password_token: reset_password_token, reset_password_sent_at: reset_password_sent_at)
    end
end