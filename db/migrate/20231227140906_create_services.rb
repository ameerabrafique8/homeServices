class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.integer :status
      t.float :average_rating
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
