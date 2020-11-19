class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  CONDITION = ['Excellent', 'Good', 'Ok', 'Bad'].freeze
end
