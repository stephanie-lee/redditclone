class User < ActiveRecord::Base
  attr_reader :password

  validates :email, :session_token, :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  before_validation :ensure_session_token

  has_many :posts, dependent: :destroy, foreign_key: :author_id

  has_many :moderated_subs, dependent: :destroy,
    foreign_key: :moderator_id,
    primary_key: :id,
    class_name: "Sub"

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user && user.is_password?(password) ? user : nil
    # return nil if user.nil?
    #
    # if user.is_password?(password)
    #   user
    # else
    #   nil
    # end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= reset_session_token!
  end

end
