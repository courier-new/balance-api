# frozen_string_literal: true

class CreateMemos < ActiveRecord::Migration[5.1]
  def change
    create_table :memos do |t|
      t.references :expense, foreign_key: true
      t.text :description
      t.integer :status
      t.datetime :date
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
