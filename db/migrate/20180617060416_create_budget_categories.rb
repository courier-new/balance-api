# frozen_string_literal: true

class CreateBudgetCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :budget_categories do |t|
      t.references :budget, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
