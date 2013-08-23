class PunctuationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    punctuation = value ? value.strip.last : ""

    if options[:without]
      if punctuation =~ /#{options[:without]}/
        record.errors[attribute] << (options[:message] || "has invalid punctuation.")
      end
    elsif options[:with]
      unless punctuation =~ /#{options[:with]}/
        record.errors[attribute] << (options[:message] || "has invalid punctuation.")
      end
    else
      unless punctuation =~ /[:punct:]/
        record.errors[attribute] << (options[:message] || "has invalid punctuation.")
      end
    end
  end
end