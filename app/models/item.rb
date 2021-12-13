class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_date
  belongs_to :user
  has_one_attached :image

  validates :image, :name, :explanation, :selling_price, presence: true
  validates :selling_price, numericality: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters' },
                            inclusion: { in: 300..9999999, message: 'is out of setting range' }
  validates :category_id, :status_id, :shipping_cost_id, 
            :prefecture_id, :shipping_date_id, 
            numericality: { other_than: 1 , message: "can't be blank" }
end
