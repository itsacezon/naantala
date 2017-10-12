class Status
  include MongoMapper::Document
  timestamps!

  key :time, Time
  key :description, String
  key :status, String
  key :station, String
  key :bound, String
end
