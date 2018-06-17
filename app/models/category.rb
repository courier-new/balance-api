# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :user
  has_many :budget_categories
  has_many :budgets, through: :budget_categories
  belongs_to :parent, class_name: Category
  has_many :children, class_name: Category, foreign_key: :parent_id
end
