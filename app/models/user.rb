class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  # include Slug
  after_validation :set_slug, only: [:create, :update]
  # after_create :set_slug


  def set_slug
    # binding.pry
    self[:slug] = self.username.parameterize
  end

end
