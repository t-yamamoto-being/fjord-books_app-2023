# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :commentable, polymorphic: true

  validates :content, presence: { message: 'コメントを入力してください' }

  def user_name
    user&.name || '削除されたユーザー'
  end

  def user_avatar
    user&.avatar || nil
  end
end 