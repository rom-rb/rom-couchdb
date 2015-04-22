class User
  attr_reader :name, :age

  def initialize(attributes)
    @name, @age = attributes.values_at(:name, :age)
  end
end
