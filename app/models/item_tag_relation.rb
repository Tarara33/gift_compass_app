class ItemTagRelation < ApplicationRecord
  belongs_to :item
  belongs_to :tag, counter_cache: :items_count

  validates :item_id, uniqueness: { scope: :tag_id }
end
