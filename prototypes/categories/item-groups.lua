local group = "ms-science"
--------------------------------------------------------------------------------
----- science pack group                                                   -----
--------------------------------------------------------------------------------
data.raw["item-subgroup"]["science-pack"].group = group
data:extend{
  {
    type = "item-group",
    name = data.raw["item-subgroup"]["science-pack"].group,
    order = "e",
    icon = "__MoreScience__/graphics/item-group/science-bottles.png",
    icon_size = 512,
  },
}

--------------------------------------------------------------------------------
----- science pack subgroup                                                -----
--------------------------------------------------------------------------------
local subgroupOrdering = data.raw["item-subgroup"]["science-pack"].order
local function createSubgroup(subgroupName, subgroupOrder)
  local subgroup = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
  subgroup.name = subgroup.group .. "-" .. subgroupName
  subgroup.order = subgroupOrdering .. subgroupOrder .. "["..subgroupName.."]"
  data:extend{subgroup}
end

-- science-basics
createSubgroup("raw-material", "-a[science-basics]-a")

-- science bottling
createSubgroup("bottling"    , "-b[science-bottling]-a")
createSubgroup("fluid"       , "-b[science-bottling]-b")

createSubgroup("barrel"      , "-b[science-bottling]-c1")
createSubgroup("barrel-fill" , "-b[science-bottling]-c2")
createSubgroup("barrel-empty", "-b[science-bottling]-c3")

createSubgroup("infused-science-pack", "-c[science-pack]-b")

-- science rocket
local rocketParts    = require ("prototypes/settings").rocketParts
createSubgroup(rocketParts.subgroup   , "-d[science-rocket]-a")
local rocketCauldron = require ("prototypes/settings").rocketCauldron
createSubgroup(rocketCauldron.subgroup, "-d[science-rocket]-b")
local rocket         = require ("prototypes/settings").rocket
createSubgroup(rocket.subgroup        , "-d[science-rocket]-c")

-- science pack
LSlib.item.setOrderstring("item-subgroup", "science-pack", subgroupOrdering .. "-c[science-pack]-a")

--------------------------------------------------------------------------------
----- tree farm                                                            -----
--------------------------------------------------------------------------------
data:extend{{
  type = "item-subgroup",
  name = group .. "-treefarm",
  group = "intermediate-products",
  order = data.raw["item-subgroup"]["raw-resource"].order .. "-z"
}}
