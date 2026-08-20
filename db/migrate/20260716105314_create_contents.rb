class CreateContents < ActiveRecord::Migration[8.1]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :body
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
