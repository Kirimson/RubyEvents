class Organiser < ApplicationRecord
  has_many :events
  validates :name, presence: true
  validates :email, presence: true, confirmation: true
  validates :password, presence: true, confirmation: true

  before_save :hash_password

  def name_posses
    name[-1] == 's' ? uc_name + '\'' : uc_name + '\'s'
  end

  def uc_name
    name.upcase_first
  end

  def password_correct?(pass)
    true if password == Digest::SHA1.hexdigest(salt + pass)
  end

  def hash_password
    self.salt = SecureRandom.base64(8)
    self.password = Digest::SHA1.hexdigest(salt + password)
  end
end