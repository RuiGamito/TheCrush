Zones={}


function Zones.updateZoneTrigger()
  if PLAYER_SCORE <= 10 then
    Zones.actZone_01()
  elseif PLAYER_SCORE <= 30 then
    Zones.actZone_02()
  elseif PLAYER_SCORE <= 50 then
    Zones.actZone_03()
  elseif PLAYER_SCORE <= 70 then
    Zones.actZone_04()
  end
end

function Zones.actZone_01()
  world.DYNAMIC_BLOCK_WIDTH = false
  world.DYNAMIC_BLOCK_Y = false
  world.BLOCK_SPAWN_LOCATION = "top" --"bottom"
  --world.BLOCK_SPEED = 2.4
  --world.BLOCK_SPEED_BASE = 2.4
  world.BLOCK_SPAWN_PROBABILITY = 0.01
  world.EXPAND_DIRECTION = Block.EXPAND_RANDOM

  world.GENERATE_WALLS = true
end


function Zones.actZone_02()
  world.DYNAMIC_BLOCK_WIDTH = false
  world.DYNAMIC_BLOCK_Y = false
  world.BLOCK_SPAWN_LOCATION = "bottom"  -- "top"
  --world.BLOCK_SPEED = 2.4
  --world.BLOCK_SPEED_BASE = 2.4
  world.BLOCK_SPAWN_PROBABILITY = 0.01
  world.EXPAND_DIRECTION = Block.EXPAND_RANDOM

  world.GENERATE_WALLS = true
end

function Zones.actZone_03()
  world.DYNAMIC_BLOCK_Y = true
end

function Zones.actZone_04()
  world.GENERATE_WALLS = true
end
