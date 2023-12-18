# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title, comment: 'タイトル'
      t.string :body, comment: '本文'
      t.integer :status, limit: 1, default: 1, comment: 'ステータス(1: 未保存, 2: 保存済み, 3: 公開中)'
      t.references :user, null: false, foreign_key: true, comment: 'ユーザーID'
      t.timestamps
    end
  end
end
