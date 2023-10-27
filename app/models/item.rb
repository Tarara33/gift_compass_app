class Item < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  enum price_range:{ 0_1000: 0, 1000_3000: 1, 3000_6000: 2, 6000_10000: 3, 10000_15000: 4, 15000_20000: 5, 20000_25000: 6,
                    25000_30000:  7, above_30000: 8}
  enum target_gender:{ other: 0, man: 1, woman:2 }
end
