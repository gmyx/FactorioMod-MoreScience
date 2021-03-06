local function numberToString(number)
  if number >= 10 then return "" .. number else return "0" .. number end
end

local function getFluidOrder(scienceName)
  return LSlib.utils.string.split(
           LSlib.utils.string.split(
             data.raw["fluid"][string.format(scienceName, "fluid")].order,
           "-")[3],
         "[")[1]
end

local function addInfusedSciencePack(scienceName, scienceNumber)
  data:extend{{
    type = "tool",
    name = "infused-"..string.format(scienceName, "pack"),
    localised_name = {"item-name.infused-modifier", {[1] = "item-name." .. string.format(scienceName, "pack")}},
    localised_description = {"item-description.science-pack"},
    icons =
    {
      {
        icon = "__MoreScience__/graphics/icons/potion/set-02/potion-" .. numberToString(scienceNumber) .. ".png",
        icon_size = 32,
      },
      {
        icon = "__MoreScience__/graphics/icons/potion/cork.png",
        icon_size = 32,
      },
    },
    subgroup = "ms-science-infused-science-pack",
    order = "z-MoreScience-" .. getFluidOrder(scienceName) .. "[" .. string.format(scienceName, "pack") .. "]",
    stack_size = 100,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value"
  }}
end

local function alterSciencePack(scienceName, scienceNumber)
  sciencePack = data.raw["tool"][string.format(scienceName, "pack")]

  sciencePack.icon = nil
  sciencePack.icon_size = nil
  sciencePack.icons =
  {
    {
      icon = "__MoreScience__/graphics/icons/potion/set-01/potion-" .. numberToString(scienceNumber) .. ".png",
      icon_size = 32,
    },
    {
      icon = "__MoreScience__/graphics/icons/potion/cork.png",
      icon_size = 32,
    },
  }
  data.raw["tool"][ sciencePack.name] = util.table.deepcopy(sciencePack)

  LSlib.item.setSubgroup   ("tool", sciencePack.name, "science-pack")
  LSlib.item.setOrderstring("tool", sciencePack.name, "z-MoreScience-" .. getFluidOrder(scienceName) .. "[" ..  sciencePack.name .. "]")

  addInfusedSciencePack(scienceName, scienceNumber)
end

local function addSciencePack(scienceName, scienceNumber)
  data:extend{{
    type = "tool",
    name = string.format(scienceName, "pack"),
    localised_description = {"item-description.science-pack"},
    icons =
    {
      {
        icon = "__MoreScience__/graphics/icons/potion/set-01/potion-" .. numberToString(scienceNumber) .. ".png",
        icon_size = 32,
      },
      {
        icon = "__MoreScience__/graphics/icons/potion/cork.png",
        icon_size = 32,
      },
    },
    --flags = {},
    subgroup = "science-pack",
    order = "z-MoreScience-" .. getFluidOrder(scienceName) .. "[" .. string.format(scienceName, "pack") .. "]",
    stack_size = 200,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value"
  }}

  addInfusedSciencePack(scienceName, scienceNumber)
end



local scienceNames = require("prototypes/settings").scienceNames
alterSciencePack(scienceNames.red   , 14)
alterSciencePack(scienceNames.green , 03)
alterSciencePack(scienceNames.gray  , 09)
addSciencePack  (scienceNames.orange, 15)
addSciencePack  (scienceNames.cyan  , 05)
alterSciencePack(scienceNames.blue  , 08)
alterSciencePack(scienceNames.purple, 10)
alterSciencePack(scienceNames.yellow, 02)
addSciencePack  (scienceNames.pink  , 13)
alterSciencePack(scienceNames.white , 01)
