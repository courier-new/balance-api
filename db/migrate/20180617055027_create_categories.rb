# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.float :allotment
      t.text :description
      t.integer :parent_id

      t.timestamps
    end
    add_foreign_key :categories, :categories, column: :parent_id, primary_key: :id
    add_index :categories, :parent_id
  end
end
