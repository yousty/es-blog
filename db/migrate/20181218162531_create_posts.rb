class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :uid
      t.string :title
      t.text :content
      t.string :author
    end
  end
end
