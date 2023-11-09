class Item < ApplicationRecord
  mount_uploader :item_image, ItemImageUploader
  
  belongs_to :user
  has_many :item_tag_relations, dependent: :destroy
  has_many :tags, through: :item_tag_relations

  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :item_name, length: {maximum: 25}
  with_options presence: true do
    validates :item_name, :price_range, :target_gender
  end

  enum price_range:{ upto_1000: 0, upto_3000: 1, upto_6000: 2, upto_10000: 3, upto_15000: 4, upto_20000: 5, upto_25000: 6,
                    upto_30000:  7, above_30000: 8}
  enum target_gender:{ other: 0, man: 1, woman:2 }
end
