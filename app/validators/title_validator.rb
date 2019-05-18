class TitleValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !(value.class == "".class)
      record.errors.add(attribute, " must not be empty")
    else
      record.errors.add(attribute, " must be more 1 of characters") unless value.length > 1
      record.errors.add(attribute, " must be less 255 of ") unless value.length < 255
    end
  end
end
