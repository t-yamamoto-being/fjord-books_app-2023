# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :icon

  validate :acceptable_icon

  private

  def acceptable_icon
    return unless icon.attached?

    return if icon.content_type.in?(%w[image/png image/jpg image/jpeg image/gif])

    errors.add(:icon, I18n.t('devise.registrations.edit.icon_upload_help'))
  end
end
