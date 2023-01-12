module Aypex
  class OauthAccessGrant < Base
    include ::Doorkeeper::Orm::ActiveRecord::Mixins::AccessGrant

    self.table_name = "aypex_oauth_access_grants"
  end
end
