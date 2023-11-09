class Tag < ApplicationRecord
  has_many :item_tag_relations, dependent: :destroy
  has_many :items, throught: :item_tag_relations
  
  validates :name, uniqueness: true
end
