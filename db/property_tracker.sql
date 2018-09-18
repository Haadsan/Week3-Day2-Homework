DROP TABLE IF EXISTS property_trackers;

CREATE TABLE property_trackers(
id SERIAL4 PRIMARY KEY,
address VARCHAR(255),
value INT2,
number_of_bedroom INT2,
build VARCHAR(255)
  );
