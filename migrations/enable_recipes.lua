for _, force in pairs(game.forces) do
  local technologies = force.technologies
  local recipes = force.recipes

  if technologies["concrete"].researched then
    local ctypes = {
      "emergency-concrete",
      "operations-concrete",
      "radiation-concrete",
      "safety-concrete"
    }
    for _, type in pairs(ctypes) do
      local ref = 'refined-' .. type
      recipes[type].enabled = true
      recipes[ref].enabled = true
    end
  end
end
