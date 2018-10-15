class AddSanitanizedUrlToShortUrls < ActiveRecord::Migration[5.2]
  def change
    add_column :short_urls, :sanitanized_url, :string
  end
end
