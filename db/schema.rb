# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_180_617_062_050) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'budget_categories', force: :cascade do |t|
    t.bigint 'budget_id'
    t.bigint 'category_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['budget_id'], name: 'index_budget_categories_on_budget_id'
    t.index ['category_id'], name: 'index_budget_categories_on_category_id'
  end

  create_table 'budgets', force: :cascade do |t|
    t.string 'name'
    t.float 'allotment'
    t.date 'start'
    t.date 'end'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.float 'allotment'
    t.text 'description'
    t.integer 'parent_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['parent_id'], name: 'index_categories_on_parent_id'
  end

  create_table 'expenses', force: :cascade do |t|
    t.bigint 'category_id'
    t.bigint 'budget_id'
    t.string 'thing'
    t.datetime 'date'
    t.float 'amount'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['budget_id'], name: 'index_expenses_on_budget_id'
    t.index ['category_id'], name: 'index_expenses_on_category_id'
  end

  create_table 'memos', force: :cascade do |t|
    t.bigint 'expense_id'
    t.text 'description'
    t.integer 'status'
    t.datetime 'date'
    t.bigint 'person_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['expense_id'], name: 'index_memos_on_expense_id'
    t.index ['person_id'], name: 'index_memos_on_person_id'
  end

  create_table 'people', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'user_budgets', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'budget_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['budget_id'], name: 'index_user_budgets_on_budget_id'
    t.index ['user_id'], name: 'index_user_budgets_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'budget_categories', 'budgets'
  add_foreign_key 'budget_categories', 'categories'
  add_foreign_key 'categories', 'categories', column: 'parent_id'
  add_foreign_key 'expenses', 'budgets'
  add_foreign_key 'expenses', 'categories'
  add_foreign_key 'memos', 'expenses'
  add_foreign_key 'memos', 'people'
  add_foreign_key 'user_budgets', 'budgets'
  add_foreign_key 'user_budgets', 'users'
end
