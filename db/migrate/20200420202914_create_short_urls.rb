class CreateShortUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :short_urls do |t|
      t.string :original, null: false
      t.string :slug, null: false
      t.datetime :expired_at

      t.timestamps
    end

    add_index :short_urls, :slug
    add_index :short_urls, :expired_at
  end
end
