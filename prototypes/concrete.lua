-- Declare stripe types
local ctypes = {
  "emergency-concrete",
  "operations-concrete",
  "radiation-concrete",
  "safety-concrete"
}

-- Game Injection
local dir = {
  { this = "left",  next = "right" },
  { this = "right", next = "left" }
}
for i = 1, #ctypes, 1 do
  ----- Tiles -----
  for d = 1, #dir, 1 do
    -- Standard
    local sta = table.deepcopy(data.raw["tile"]["hazard-concrete-" .. dir[d].this])
    sta.name = ctypes[i] .. "-" .. dir[d].this
    sta.next_direction = ctypes[i] .. "-" .. dir[d].next
    sta.minable.result = ctypes[i]
    sta.variants.material_background.picture = "__hazard-stripes__/graphics/" ..
    ctypes[i] .. "/" .. ctypes[i] .. "-" .. dir[d].this .. ".png"
    sta.variants.material_background.hr_version.picture = "__hazard-stripes__/graphics/" ..
    ctypes[i] .. "/hr-" .. ctypes[i] .. "-" .. dir[d].this .. ".png"

    -- Refined
    local ref = table.deepcopy(data.raw["tile"]["refined-hazard-concrete-" .. dir[d].this])
    ref.name = "refined-" .. ctypes[i] .. "-" .. dir[d].this
    ref.next_direction = "refined-" .. ctypes[i] .. "-" .. dir[d].next
    ref.minable.result = "refined-" .. ctypes[i]
    ref.variants.material_background.picture = "__hazard-stripes__/graphics/" ..
    ctypes[i] .. "/refined-" .. ctypes[i] .. "-" .. dir[d].this .. ".png"
    ref.variants.material_background.hr_version.picture = "__hazard-stripes__/graphics/" ..
    ctypes[i] .. "/hr-refined-" .. ctypes[i] .. "-" .. dir[d].this .. ".png"

    data:extend({ sta, ref })
  end

  ----- Recipes -----
  -- Standard
  local staRec = table.deepcopy(data.raw["recipe"]["hazard-concrete"])
  staRec.name = ctypes[i]
  staRec.result = ctypes[i]

  -- Refined
  local refRec = table.deepcopy(data.raw["recipe"]["refined-hazard-concrete"])
  refRec.name = "refined-" .. ctypes[i]
  refRec.result = "refined-" .. ctypes[i]

  ----- Items -----
  -- Standard
  local staItem = table.deepcopy(data.raw["item"]["hazard-concrete"])
  staItem.name = ctypes[i]
  staItem.icon = "__hazard-stripes__/graphics/icons/" .. ctypes[i] .. ".png"
  staItem.order = "b[concrete]-b[" .. ctypes[i] .. "]"
  staItem.place_as_tile =
  {
    result = ctypes[i] .. "-left",
    condition_size = 1,
    condition = { "water-tile" }
  }

  -- Refined
  local refItem = table.deepcopy(data.raw["item"]["refined-hazard-concrete"])
  refItem.name = "refined-" .. ctypes[i]
  refItem.icon = "__hazard-stripes__/graphics/icons/refined-" .. ctypes[i] .. ".png"
  refItem.order = "b[concrete]-d[refined-" .. ctypes[i] .. "]"
  refItem.place_as_tile =
  {
    result = "refined-" .. ctypes[i] .. "-left",
    condition_size = 1,
    condition = { "water-tile" }
  }

  data:extend({ staRec, refRec, staItem, refItem })
  table.insert(data.raw.technology["concrete"].effects, { type = "unlock-recipe", recipe = ctypes[i] })
  table.insert(data.raw.technology["concrete"].effects, { type = "unlock-recipe", recipe = 'refined-' .. ctypes[i] })
end
