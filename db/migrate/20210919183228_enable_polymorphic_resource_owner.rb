class EnablePolymorphicResourceOwner < ActiveRecord::Migration[5.2]
  def change
    add_column :aypex_oauth_access_tokens, :resource_owner_type, :string
    add_column :aypex_oauth_access_grants, :resource_owner_type, :string
    change_column_null :aypex_oauth_access_grants, :resource_owner_type, false

    add_index :aypex_oauth_access_tokens,
              [:resource_owner_id, :resource_owner_type],
              name: 'polymorphic_owner_oauth_access_tokens'

    add_index :aypex_oauth_access_grants,
              [:resource_owner_id, :resource_owner_type],
              name: 'polymorphic_owner_oauth_access_grants'

    Aypex::OauthAccessToken.reset_column_information
    Aypex::OauthAccessToken.update_all(resource_owner_type: Aypex::Config.user_class)

    Aypex::OauthAccessGrant.reset_column_information
    Aypex::OauthAccessGrant.update_all(resource_owner_type: Aypex::Config.user_class)
  end
end
