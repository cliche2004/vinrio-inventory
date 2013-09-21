class Supplier < ActiveRecord::Base
	has_many :item_specifics
	
	has_many :supplier_contact_infos
	has_many :supplier_contact_names
	
	has_many :purchase_orders
	
	has_many :supplier_contacts
	
	validates_presence_of :name
	validates_uniqueness_of :name
end
