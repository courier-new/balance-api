# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_budgets
  has_many :budgets, through: :user_budgets
end
