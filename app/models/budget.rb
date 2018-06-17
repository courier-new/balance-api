# frozen_string_literal: true

class Budget < ApplicationRecord
  has_many :user_budgets
  has_many :users, through: :user_budgets
  has_many :budget_categories
  has_many :categories, through: :budget_categories
  has_many :expenses
end
