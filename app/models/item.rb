class Item < ApplicationRecord
  mount_uploader :item_image, ItemImageUploader

  belongs_to :user
  has_many :item_tag_relations, dependent: :destroy
  has_many :tags, through: :item_tag_relations
  has_many :favorites, dependent: :destroy

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :item_name, length: { maximum: 25 }
  with_options presence: true do
    validates :item_name, :price_range, :target_gender
  end

  enum price_range: { upto_1000: 0, upto_3000: 1, upto_6000: 2, upto_10000: 3, upto_15000: 4, upto_20000: 5, upto_25000: 6,
                      upto_30000: 7, above_30000: 8 }
  enum target_gender: { other: 0, man: 1, woman: 2 }

  scope :with_tag, ->(tag_name) { preload(:tags).joins(:tags).where(tags: { tag_name: }) }

  # ransackの検索対象設定
  def self.ransackable_attributes(_auth_object = nil)
    %w[item_name price price_range target_gender tags]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["tags"]
  end

  def save_tags(tags)
    # self = @item
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end

    new_tags.each do |new_name|
      new_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << new_tag
    end
  end

  def next
    Item.where("id < ?", id).order("id DESC").first
  end

  def previous
    Item.where("id > ?", id).order("id ASC").first
  end
end
