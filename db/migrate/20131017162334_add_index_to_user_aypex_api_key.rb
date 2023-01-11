class AddIndexToUserAypexApiKey < ActiveRecord::Migration[4.2]
  def change
    unless defined?(User)
      add_index :aypex_users, :aypex_api_key
    end
  end
end
