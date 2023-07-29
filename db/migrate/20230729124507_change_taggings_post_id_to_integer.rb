class ChangeTaggingsPostIdToInteger < ActiveRecord::Migration[6.1]
  def change
    change_column :taggings, :post_id, :integer
  end
end
