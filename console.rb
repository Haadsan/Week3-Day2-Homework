require("pry")
require_relative("./models/property_tracker")

PropertyTracker.delete_all()

property1 = PropertyTracker.new({

'address' => "294 high street",
'value' => 300.000,
'number_of_bedroom' => 3,
'build' => "flat"
})

# step1
property1.save


property2 = PropertyTracker.new({

'address' => "55 johnson street",
'value' => 400.000,
'number_of_bedroom' => 4,
'build' => "flat"
})

# step1
property2.save

property1.value = 250
property1.update


property2.delete

found_id = PropertyTracker.find_by_id(property1.id)
found_address = PropertyTracker.find_by_address(property1.address)

# step2
properties = PropertyTracker.all()

binding.pry
nil
