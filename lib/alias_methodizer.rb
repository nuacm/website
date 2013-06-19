module AliasMethodizer
  private

  def alias_method(name, &function)
    define_method name.to_s + '!', -> (*args, &block) do
      value = method(name)[*args, &block]
      instance_exec &function
      value
    end
  end
end
