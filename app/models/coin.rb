class Coin < ApplicationRecord
  before_create :set_slug  
    private  
    def set_slug
        loop do
        self.slug = self.name
        break unless Coin.where(slug: slug).exists?
        end
    end
end
