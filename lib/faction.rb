require 'race'

class Faction
  attr_reader :influence_threshold, :modifiers, :race

  def initialize(opts={})
    @influence_threshold = opts[:threshold]
    @modifiers = opts[:mods] || {}
  end
end

Race::RACES.each do |race|
  klass = Object.const_set("#{race.to_s.capitalize}Faction", Class.new(Faction))
  klass.class_eval "def race; #{race}; end"
end
