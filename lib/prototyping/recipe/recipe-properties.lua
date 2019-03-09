
if not LSlib.recipe then require "recipe" else

  function LSlib.recipe.isEnabled(recipe)
    if not data.raw["recipe"][recipe] then return nil end

    local normalEnabled = false
    local expensiveEnabled = false
    if data.raw["recipe"][recipe].normal then
      if not ((data.raw["recipe"][recipe].normal.enabled == false) or (data.raw["recipe"][recipe].normal.enabled == "false")) then
        if not data.raw["recipe"][recipe].expensive then -- if no expensive recipe is enabled, it will fall back to normal
          return {true, true}
        end
        normalEnabled = true
      end
    end

    if data.raw["recipe"][recipe].expensive then
      if not ((data.raw["recipe"][recipe].expensive.enabled == false) or (data.raw["recipe"][recipe].expensive.enabled == "false")) then
        if not data.raw["recipe"][recipe].normal then -- if no normal recipe is enabled, it will fall back to expensive
          return {true, true}
        end
        expensiveEnabled = true
      end
    end

    if data.raw["recipe"][recipe].normal or data.raw["recipe"][recipe].expensive then return {normalEnabled, expensiveEnabled} end

    if (data.raw["recipe"][recipe].enabled == false) or (data.raw["recipe"][recipe].enabled == "false") then
      return {false, false}
    else
      return {true, true}
    end
  end



  function LSlib.recipe.enable(recipe)
    if not data.raw["recipe"][recipe] then return end

    if data.raw["recipe"][recipe].normal then
      data.raw["recipe"][recipe].normal.enabled = true
    end

    if data.raw["recipe"][recipe].expensive then
      data.raw["recipe"][recipe].expensive.enabled = true
    end

    if data.raw["recipe"][recipe].enabled == false then
      data.raw["recipe"][recipe].enabled = true
    end
  end



  function LSlib.recipe.disable(recipe)
    if not data.raw["recipe"][recipe] then return end

    if data.raw["recipe"][recipe].normal then
      data.raw["recipe"][recipe].normal.enabled = false
    end

    if data.raw["recipe"][recipe].expensive then
      data.raw["recipe"][recipe].expensive.enabled = false
    end

    if not (data.raw["recipe"][recipe].normal or data.raw["recipe"][recipe].expensive) then
      data.raw["recipe"][recipe].enabled = false
    end
  end



  function LSlib.recipe.setCraftingCategory(recipe, category)
    if not data.raw["recipe"][recipe] then return end

    data.raw["recipe"][recipe].category = category
  end



  function LSlib.recipe.setLocalisedName(recipeName, localeString)
    if not data.raw["recipe"][recipeName] then return end

    LSlib.item.setLocalisedName("recipe", recipeName, localeString)
  end



  function LSlib.recipe.setSubgroup(recipeName, subgroup)
    if not data.raw["recipe"][recipeName] then return end

    LSlib.item.setSubgroup("recipe", recipeName, subgroup)
  end



  function LSlib.recipe.setOrderstring(recipeName, orderstring)
    if not data.raw["recipe"][recipeName] then return end

    LSlib.item.setOrderstring("recipe", recipeName, orderstring)
  end



  function LSlib.recipe.setShowMadeIn(recipeName, enableShowMadeIn)
    if not data.raw["recipe"][recipeName] then return end

    data.raw["recipe"][recipeName].always_show_made_in = enableShowMadeIn
  end

end
