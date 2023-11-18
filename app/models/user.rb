class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :icon, UserIconUploader

  has_many :items, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_items, through: :favorites, source: :item

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  enum role:{ general: 0, admin: 1}

  def own?(object)
    object.user_id == id
  end

  def bookmark(item)
    favorite_items << item
  end

  def unbookmark(item)
    favorite_items.destroy(item)
  end

  def bookmark?(item)
    favorite_items.include?(item)
  end
end
