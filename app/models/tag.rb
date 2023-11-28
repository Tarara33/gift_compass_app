class Tag < ApplicationRecord
  has_many :item_tag_relations, dependent: :destroy
  has_many :items, through: :item_tag_relations

  validates :tag_name, uniqueness: true, length: {maximum: 10}

  def self.ransackable_attributes(auth_object = nil)
    ["tag_name"]
  end
end
