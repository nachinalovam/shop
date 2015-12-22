class Order < ActiveRecord::Base
  has_one :product
  has_one :user
end
