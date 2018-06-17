# frozen_string_literal: true

class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.references :category, foreign_key: true
      t.references :budget, foreign_key: true
      t.string :thing
      t.datetime :date
      t.float :amount

      t.timestamps
    end
  end
end
