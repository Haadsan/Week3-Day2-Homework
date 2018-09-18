# https://gist.github.com/futuresocks/90d6cbddac7884c1e54883411dc93141
require("pry")
require("pg")

class PropertyTracker

  attr_accessor :address, :value, :number_of_bedroom, :build
  attr_reader :id



  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @address = options["address"]
    @value = options["value"].to_i
    @number_of_bedroom = options["number_of_bedroom"].to_i
    @build = options["build"]
  end


  def save()
    db = PG.connect({ dbname: "property_tracker", host: "localhost"})
    sql = "INSERT INTO property_trackers
    (address, value, number_of_bedroom, build)
    VALUES
    ($1, $2, $3, $4)

    RETURNING *"
    values = [@address, @value, @number_of_bedroom, @build]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()

  end



def delete()
  db = PG.connect({dbname: "property_tracker", host: "localhost"})
  sql = "DELETE FROM property_trackers WHERE id = $1"
  values = [@id]
  db.prepare("delete_one", sql)
  db.exec_prepared("delete_one", values)
  db.close()
end



def update()
  db = PG.connect({dbname: "property_tracker", host: "localhost"})
  sql = "UPDATE property_trackers SET (address, value, number_of_bedroom, build)
  = ($1, $2, $3, $4) WHERE id = $5"
  values = [@address, @value, @number_of_bedroom, @build, @id]
  db.prepare("update", sql)
  db.exec_prepared("update", values)
  db.close()

end


def PropertyTracker.all()
  db = PG.connect({dbname: "property_tracker", host: "localhost"})
  sql = "SELECT * FROM property_trackers"
  db.prepare("all", sql)
  properties = db.exec_prepared("all")
  db.close()

  return properties.map{|property_hash| PropertyTracker.new(property_hash)}
end



def PropertyTracker.delete_all
  db = PG.connect({dbname: "property_tracker", host: "localhost"})
  sql = "DELETE FROM property_trackers"
  db.prepare("delete_all", sql)
  db.exec_prepared("delete_all")
  db.close()
end


def PropertyTracker.find_by_id(id)
  db = PG.connect({dbname: "property_tracker", host: "localhost"})
  sql = "SELECT * FROM property_trackers WHERE id = $1"
  values = [id]
  db.prepare("find_by_id", sql)
  properties = db.exec_prepared("find_by_id", values)
  found = properties[0]
  db.close()

  return PropertyTracker.new(found)
end



def PropertyTracker.find_by_address(address)
  db = PG.connect({dbname: "property_tracker", host: "localhost"})
  sql = "SELECT * FROM property_trackers WHERE address = $1"
  values = [address]
  db.prepare("find_by_address", sql)
  # this is saying go and search these data on the database
  # once it searches whatever it found it will store on property variable
  properties = db.exec_prepared("find_by_address", values)
  # properties = [{property2}]
  # propety will return everything on that address in an array of hashes  properties = [{property2}] but you only want one to get first elemnt of that array in index 0
  found = properties[0]
  db.close()
  return PropertyTracker.new(found)
end

end
