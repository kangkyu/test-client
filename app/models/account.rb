class Account < ApplicationRecord
  validates :lightspark_id, presence: true, uniqueness: true
end
