module Naantala
  module Models
    class PhoneNumber
      include MongoMapper::Document
      timestamps!

      key :number, String
      key :code, String
      key :confirmed, Boolean, default: false

      validates_format_of :number, with: /\A\+639[0-9]{9}\z/
      validates_presence_of :number
      validates_uniqueness_of :number, message: "has already been registered."
    end
  end
end
