class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :tag_name, null: false
      
      t.timestamps
    end

    create_table :tags do |t|
      t.integer :tag_id
      t.integer :url_id

      t.timestamps
    end
  end
end
