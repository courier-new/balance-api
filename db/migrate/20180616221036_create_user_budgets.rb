# frozen_string_literal: true

class CreateUserBudgets < ActiveRecord::Migration[5.1]
  def change
    create_table :user_budgets do |t|
      t.references :user, foreign_key: true
      t.references :budget, foreign_key: true

      t.timestamps
    end
  end
end
