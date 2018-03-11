class Commodity < ApplicationRecord
  validates_presence_of :name
  attachment :file
  validates_presence_of :price
  validates_presence_of :display_index
end
