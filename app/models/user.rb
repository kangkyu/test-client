class User < ApplicationRecord
  has_secure_token :auth_token

  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
