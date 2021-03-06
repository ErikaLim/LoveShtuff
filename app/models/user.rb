class User < ActiveRecord::Base
  has_many :authorizations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  # def add_provider(auth_hash)
  # # Check if the provider already exists, so we don't add it twice
  # unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  #   Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
  #   end
  # end

end
