module Aypex
  module UserApiAuthentication
    def generate_aypex_api_key!
      self.aypex_api_key = generate_aypex_api_key
      save!
    end

    def clear_aypex_api_key!
      self.aypex_api_key = nil
      save!
    end

    private

    def generate_aypex_api_key
      SecureRandom.hex(24)
    end
  end
end
