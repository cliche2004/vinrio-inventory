class SupplierPriceHistory < ActiveRecord::Base
  belongs_to :item
  belongs_to :supplier
end
