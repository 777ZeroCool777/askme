require 'openssl'

class User < ActiveRecord::Base
  # параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }

  has_many :questions

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true

  VALID_USERNAME_FORMAT = /\A[a-zA-Z0-9_]+\Z/
  validates :username, format: { with: VALID_USERNAME_FORMAT },
            uniqueness: {case_sensitive: false}

  VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_FORMAT },
            uniqueness: {case_sensitive: false}

  validates :username, length: {in: 3..40}

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password


  def encrypt_password
    if self.password.present?
      # создаю т. н. "соль" - рандомная строка усложняющая задачу хакера
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # создаю хэш пароля - длинная уникальная строка, из которой невозможно востановить
      # исходный пароль
      self.password_hash = User.hash_to_string(
                                   OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  # служебный метод, преобразующий бинарную строку в 16-ричный формат, для удобства хранения
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email) # сперва находим кандита по email

    # ОБРАТИТЕ внимание: сравнивается password_hash, а оригинальный пароль так никогда
    # и не сохраняется нигде!
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

end
