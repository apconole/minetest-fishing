-- This file is licensed under the terms of the GNU General Public License
-- Agreement, version 2.0 only.
--
-- Copyright (C) 2016, Aaron Conole <aconole@bytheb.org>

local modpath = core.get_modpath("plentyofish")

local CRUDE_FISH_POLE_CHANCE = 10
local CRUDE_FISH_POLE_BAITED_CHANCE = 30

local GREEN_FISH_CHANCE = 50
local RED_FISH_CHANCE = 75
local BLUE_FISH_CHANCE = 90

minetest.register_craftitem("plentyofish:green_fish", {
        description = "Green Fish",
        inventory_image = "green_fish.png",
        groups = {},
        on_use = minetest.item_eat(1),
})

minetest.register_craftitem("plentyofish:red_fish", {
        description = "Red Fish",
        inventory_image = "red_fish.png",
        groups = {},
        on_use = minetest.item_eat(2),
})

minetest.register_craftitem("plentyofish:blue_fish", {
        description = "Blue Fish",
        inventory_image = "blue_fish.png",
        groups = {},
        on_use = minetest.item_eat(4),
})

minetest.register_craftitem("plentyofish:prepared_fish", {
        description = "Prepared Fillets",
        inventory_image = "prepared_fish_fillets.png",
        groups = {},
        on_use = minetest.item_eat(8),
})

local function do_fish(fish_pct, itemstack, user, pointed_thing)
      if pointed_thing and pointed_thing.under then
         local node = minetest.env:get_node(pointed_thing.under)
         if string.find(node.name, "default:water") then
            if math.random(1,100) < CRUDE_FISH_POLE_CHANCE then
               local inv = user:get_inventory()
               local strname = "plentyofish:green_fish"
               local rnd = math.random(1,100)
               if rnd < GREEN_FISH_CHANCE then
                  strname = "plentyofish:green_fish"
               elseif rnd < RED_FISH_CHANCE then
                  strname = "plentyofish:red_fish"
               else
                  strname = "plentyofish:blue_fish"
               end
               if inv:room_for_item("main", {name=strname, count=1, wear=0, metadata=""}) then
                  inv:add_item("main", {name=strname, count=1, wear=0, metadata=""})
               end
            end
         end
      end
      return {name="plentyofish:crude_pole", count=1, wear=0, metadata=""}
end

minetest.register_craftitem("plentyofish:crude_pole", {
        description = "Crude Fishing Pole",
        inventory_image = "crude_fishing_pole.png",
        liquids_pointable = true,
        stack_max=1,
        on_use = function(itemstack, user, pointed_thing)
           return do_fish(CRUDE_FISH_POLE_CHANCE, itemstack, user, pointed_thing)
        end
})

minetest.register_craftitem("plentyofish:crude_pole_baited",{
        description = "Crude Fishing Pole (Baited)",
        inventory_image = "crude_fishing_pole_baited.png",
        liquids_pointable = true,
        stack_max = 1,
        on_use = function(itemstack, user, pointed_thing)
           return do_fish(CRUDE_FISH_POLE_BAITED_CHANCE, itemstack, user, pointed_thing)
        end
})

minetest.register_craftitem("plentyofish:chum_bucket", {
        description = "Chum Bucket",
        inventory_image = "chum_bucket.png",
})

minetest.register_craft({
        type = "shapeless",
        output = 'plentyofish:crude_pole',
        recipe = {'default:stick', 'farming:cotton', 'moreores:tin_ingot'},
})

minetest.register_craft({
        type = "shapeless",
        output = 'plentyofish:crude_pole_baited',
        recipe = {'plentyofish:crude_pole', 'plentyofish:chum_bucket'}
})

minetest.register_craft({
        type = "shapeless",
        output = 'plentyofish:chum_bucket',
        recipe = {'plentyofish:green_fish', 'bucket:bucket_empty'}
})

minetest.register_craft({
        type = "shapeless",
        output = 'plentyofish:chum_bucket 2',
        recipe = {'plentyofish:red_fish', 'bucket:bucket_empty'}
})

minetest.register_craft({
        type = "shapeless",
        output = 'plentyofish:chum_bucket 3',
        recipe = {'plentyofish:blue_fish', 'bucket:bucket_empty'}
})

minetest.register_craft({
        type = "cooking",
        output = "plentyofish:prepared_fish",
        recipe = "plentyofish:green_fish",
})

minetest.register_craft({
        type = "cooking",
        output = "plentyofish:prepared_fish 2",
        recipe = "plentyofish:red_fish",
})

minetest.register_craft({
        type = "cooking",
        output = "plentyofish:prepared_fish 4",
        recipe = "plentyofish:blue_fish",
})
