require 'dice'
require 'dwarf'
require 'faction'
require 'greater_item'
require 'influence_check'

describe InfluenceCheck do
  describe '#pass?' do
    it 'returns true when the roll is greater than the threshold' do
      faction = Faction.new(:threshold => 8)
      Dice.stub(:roll) { 9 }
      InfluenceCheck.new(faction).pass?.should == true
    end

    it 'returns false when the roll is less than the threshold' do
      faction = Faction.new(:threshold => 8)
      Dice.stub(:roll) { 7 }
      InfluenceCheck.new(faction).pass?.should == false
    end

    it 'returns true when the roll plus racial modifier is greater than the threshold' do
      faction = Faction.new(:threshold => 10, :mods => { :Dwarf => 2 })
      Dice.stub(:roll) { 9 }
      InfluenceCheck.new(faction, Dwarf.new).pass?.should == true
    end

    it 'returns true when the roll plus character modifiers is greater than the threshold' do
      faction = DwarfFaction.new(:threshold => 10)
      character = Dwarf.new(:influence_mods => {:DwarfFaction => 3})
      Dice.stub(:roll) { 8 }
      InfluenceCheck.new(faction, character).pass?.should == true
    end

    it 'returns true when an item is discarded and threshold is exceeded' do
      faction = Faction.new(:threshold => 12, :mods => {:GreaterItem => 6, :MajorItem => 3})
      Dice.stub(:roll) { 7 }
      InfluenceCheck.new(faction, Dwarf.new, GreaterItem.new).pass?.should == true
    end
  end
end
