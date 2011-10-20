class GreaterItem; end
class MajorItem; end

class InfluenceCheck
  def initialize(target, influencer=nil, item=nil)
    @target = target
    @influencer = influencer
    @item = item
  end

  def pass?
    Dice.roll + modifier  > @target.influence_threshold
  end

  def modifier
    race_modifier + character_modifier + item_modifier
  end
  
  def race_modifier
    (@influencer && @target.modifiers[@influencer.race]) || 0
  end
  
  def character_modifier
    (@influencer && @influencer.influence_mods[@target.class.name.to_sym]) || 0
  end

  def item_modifier
    (@item.is_a?(GreaterItem) && @target.modifiers[:GreaterItem]) || (@item.is_a?(MajorItem) && @target.modifiers[:MajorItem]) || 0
  end
end
