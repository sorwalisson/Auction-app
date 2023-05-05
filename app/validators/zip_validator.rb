class ZipValidator < ActiveModel::Validator
  def validate(record)
    if length_validator(record.zip) == false then record.errors.add(:zip, "isn't valid") end
    if characters_validator(record.zip) == false then record.errors.add(:zip, "isn't valid") end
  end


  def length_validator(zip)
    if zip.length != 9 then return false end
  end

  def characters_validator(zip)
    numbers = ("0".."9").to_a
    zip.each_char {|c| if numbers.include?(c) == false && c != "-" then return false end}
    if zip.count("-") != 1 then return false end
  end
end