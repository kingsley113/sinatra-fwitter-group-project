class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  after_validation :set_slug, only: [:create, :update]

  def set_slug
    self[:slug] = self.username.parameterize
  end

end
