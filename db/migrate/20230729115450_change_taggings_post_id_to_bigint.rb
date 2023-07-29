class ChangeTaggingsPostIdToBigint < ActiveRecord::Migration[6.1]
  def change
    change_column :taggings, :post_id, :bigint
  end
end
