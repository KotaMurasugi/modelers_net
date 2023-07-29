class AddForeignKeyToTaggings < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :taggings, :posts, column: :post_id
  end
end
