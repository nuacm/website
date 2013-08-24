class OfficerValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.is_a?(Officer)
      record.errors[attribute] << (options[:message] || "is not an officer")
    end
  end
end