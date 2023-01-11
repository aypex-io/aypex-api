class RenameApiKeyToAypexApiKey < ActiveRecord::Migration[4.2]
  def change
    unless defined?(User)
      rename_column :aypex_users, :api_key, :aypex_api_key
    end
  end
end
