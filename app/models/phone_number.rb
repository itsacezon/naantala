module Naantala
  module Models
    class PhoneNumber
      include MongoMapper::Document
      timestamps!

      key :number, String

      validates_format_of :number, with: /\A\+63\d{10}\z/
      validates_presence_of :number
      validates_uniqueness_of :number
    end
  end
end
