class Room < ApplicationRecord
  has_many :channels
  belongs_to :user
  accepts_nested_attributes_for :user
end
