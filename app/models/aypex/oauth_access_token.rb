module Aypex
  class OauthAccessToken < Base
    include ::Doorkeeper::Orm::ActiveRecord::Mixins::AccessToken

    self.table_name = 'aypex_oauth_access_tokens'
  end
end
