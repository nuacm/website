module ACM

  module AliasMethodizer
    private

    def alias_method(alias_name, name, &function)
      define_method alias_name, -> (*args, &block) do
        value = method(name)[*args, &block]
        instance_exec &function if function
        value
      end
    end
  end

end
