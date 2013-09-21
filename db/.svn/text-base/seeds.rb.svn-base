require 'spreadsheet'

# truncate all item table

Item.delete_all

@item_workbook = Spreadsheet.open(Rails.root + "public/items-2012.xls")

# TOOLS

@item_worksheet = @item_workbook.worksheet(0)

2.upto @item_worksheet.last_row_index do |index|
  row = @item_worksheet.row(index)
  
  remarks = row[3]
  name = row[4]
  description = row[5]
  brand = row[6]
  measurement = row[7]
  current_qty = row[8]
  unit = row[9]
  serial_number = row[10]
  barcode = row[11]
  storage_location = row[12]
  supplier = row[13]
  
  accessory_1 = row[14]
  accessory_2 = row[15]
  accessory_3 = row[16]
  accessory_4 = row[17]
  accessory_5 = row[18]
  accessory_6 = row[19]
  accessory_7 = row[20]
  
  image_filename = row[11]
  
  puts name
  
  #find or create unit
  unit = Unit.find_or_create_by_name(unit)
  
  #find or create measurement
  measurement = Measurement.find_or_create_by_name(measurement)
  # find or create storage
  storage = StorageLocation.find_or_create_by_name(storage_location)
  # find_or_create brand
  brand = Brand.find_or_create_by_name(brand)
  # find or create supplier
  supplier = Supplier.find_or_create_by_name(supplier)
  
  # item creation
  item = Item.find_by_name(name)

    unless item
      # create item if not found
      item = Item.new :name => name,
                         :description => description,
                         :remarks => remarks,
                         :serial_number => serial_number,
                         :barcode => barcode,
                         :brand_id => (brand.id if brand),
                         :measurement_id => (measurement.id if measurement),
                         :unit_id => (unit.id if unit),
                         :storage_location_id => (storage.id if storage),
                         :current_qty => (current_qty || 1 ),
                         :image_filename => image_filename,
                         :type_of => 'Tools'
      
      
      if item.save
        # create accessories
        Accessory.find_or_create_by_item_id_and_name(item.id, accessory_1)
        Accessory.find_or_create_by_item_id_and_name(item.id, accessory_2)
        Accessory.find_or_create_by_item_id_and_name(item.id, accessory_3)
        Accessory.find_or_create_by_item_id_and_name(item.id, accessory_4)
        Accessory.find_or_create_by_item_id_and_name(item.id, accessory_5)
        Accessory.find_or_create_by_item_id_and_name(item.id, accessory_6)
        Accessory.find_or_create_by_item_id_and_name(item.id, accessory_7)
      else
        puts item.errors.full_messages
      end
      


                       
    end


end

# Consumables

@item_worksheet = @item_workbook.worksheet(1)

1.upto @item_worksheet.last_row_index do |index|
  row = @item_worksheet.row(index)
  
  name = row[2]
  description = row[3]
  brand = row[4]
  measurement = row[9]
  current_qty = row[11]
  reorder_qty = row[10]
  unit = row[7]
  storage_location = row[14]

  supplier_1, price_1 = row[15], row[16]
  supplier_2, price_2 = row[17], row[18]
  supplier_3, price_3 = row[19], row[20]
  
  puts name
  
  #find or create unit
  unit = Unit.find_or_create_by_name(unit)
  
  #find or create measurement
  measurement = Measurement.find_or_create_by_name(measurement)
  # find or create storage
  storage = StorageLocation.find_or_create_by_name(storage_location)
  # find_or_create brand
  brand = Brand.find_or_create_by_name(brand)
  
  # item creation
  item = Item.find_by_name(name)

    unless item
      # create item if not found
      item = Item.new :name => name,
                       :description => description,
                       :brand_id => (brand.id if brand),
                       :measurement_id => (measurement.id if measurement),
                       :unit_id => (unit.id if unit),
                       :storage_location_id => (storage.id if storage),
                       :current_qty => (current_qty || 1 ),
                       :reorder_qty => (reorder_qty || 1),                       
                       :type_of => 'Consumable'
      
      
      if item.save
        
        # supplier 1
        supplier_1 = Supplier.find_or_create_by_name(supplier_1)
        SupplierPriceHistory.create(:supplier_id => supplier_1.id, :item_id => item.id, :price => price_1)

        # supplier 2
        supplier_2 = Supplier.find_or_create_by_name(supplier_2)
        SupplierPriceHistory.create(:supplier_id => supplier_2.id, :item_id => item.id, :price => price_2)
        
        # supplier 1
        supplier_3 = Supplier.find_or_create_by_name(supplier_3)
        SupplierPriceHistory.create(:supplier_id => supplier_3.id, :item_id => item.id, :price => price_3)
        
        
      else
        puts item.errors.full_messages
      end
                       
    end


end

