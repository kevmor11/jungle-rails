class User < ActiveRecord::Base
  has_many :reviews

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true 
  validates :email, uniqueness: true
  validates_uniqueness_of :email, case_sensitive: false 
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 8 }

  def self.authenticate_with_credentials(email, password)
    stripped_email = email.strip
    user = User.where('lower(email) = ?', stripped_email.downcase).first
    if user && user.authenticate(password)
      user
    else
      false
    end
  end

end
