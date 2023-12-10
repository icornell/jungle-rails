class User < ApplicationRecord
  has_secure_password

  before_save :downcase_email

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, presence: true
  validates :name, presence: true
  validates :password, length: { minimum: 6 }


  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.strip.downcase)
    user&.authenticate(password) ? user : nil
  end

  private

  def downcase_email
    self.email = email.downcase
  end

end
