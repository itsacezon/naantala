module Naantala
  module Models
    class PhoneNumber
      include MongoMapper::Document
      timestamps!

      key :number, String

      validates_format_of :number, with: /\A\+63[0-9]{10}\z/
      validates_presence_of :number
      validates_uniqueness_of :number, message: "has already been registered."
    end
  end
end
