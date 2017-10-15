module Naantala
  module Models
    class Status
      include MongoMapper::Document
      timestamps!

      key :time, Time
      key :description, String
      key :status, String
      key :station, String
      key :bound, String

      # Limit storing issues to save space
      validates_format_of :status, with: /\ACAT (3|4)\z/

      validates_presence_of :time, :status, :station, :bound
      validates_uniqueness_of :time
    end
  end
end
