class CreateMeetings < ActiveRecord::Migration[7.1]
  def change
    create_table :meetings do |t|
      t.string :name
      t.string :address
      t.string :picture
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
