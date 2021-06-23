module Slug

    def set_slug
        # binding.pry
        self[:slug] = self.username.parameterize
    end
end