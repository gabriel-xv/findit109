class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  CONDITION = ['Excellent', 'Good', 'Ok', 'Bad'].freeze
end
