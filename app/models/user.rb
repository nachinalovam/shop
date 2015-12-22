class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_many :products, through: :orders

  before_save { email.downcase! }
  before_create :generate_password_hash

  validates :first_name, :last_name,
            presence: true, length: { maximum: 50 }

  validates :password, presence: true, length: { in: 6..20 }, on: :create

  validates :email, presence: true,
                    format: { with: ConstantManager::VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def authenticate(entered_pass)
    Digest::SHA512.hexdigest(entered_pass) == password
  end

  private

  def generate_password_hash
    self.password = Digest::SHA512.hexdigest(password)
  end

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
