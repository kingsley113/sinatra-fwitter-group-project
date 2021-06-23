module Slug

    def set_slug
        self[:slug] = self.username.parameterize
    end
end