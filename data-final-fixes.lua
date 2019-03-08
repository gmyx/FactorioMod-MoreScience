--require "graphics/screenshots/science-order" --   <<<-- for screenshot purpose only

-- technology tree cleanup
local containsExtension = false
for _,extension in pairs({
  -- when modules present, we don't remove redundant prerequisites here
}) do
  if mods["MoreScience-" .. extension] then
    containsExtension = true
    break
  end
end
if not containsExtension then
  MoreScience.lib.debug.log("----- Cleaning up the tech tree -----")
  MoreScience.lib.technology.removeAllRedundantPrerequisites()
end
