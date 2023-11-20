class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def next
    Item.where("id < ?", self.id).order("id DESC").first
  end

  def previous
    Item.where("id > ?", self.id).order("id ASC").first
  end
end
