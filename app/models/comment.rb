# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :commentable, polymorphic: true

  validates :content, presence: { message: :comment_blank }

  def user_name
    user&.name || I18n.t('views.common.deleted_user')
  end

  def user_avatar
    user&.avatar || nil
  end
end
