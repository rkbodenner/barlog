class Dwarf
  attr_reader :influence_mods

  def initialize(opts={})
    @influence_mods = opts[:influence_mods] || {}
  end

  def race
    self.class.name.to_sym
  end
end
