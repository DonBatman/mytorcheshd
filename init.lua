local torch_used = core.settings:get_bool("mytorches.torch_used", true)
local torch_timer = tonumber(core.settings:get("mytorches.torch_time")) or 3600

if torch_used then

        
minetest.override_item("default:torch", {
	description = "Torch",
	inventory_image = "",
	wield_image = "",
	tiles = {
		{name="mytorch_torch1_ani.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},},
	drawtype = "mesh",
	mesh = "mytorch_torch.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	damage_per_second = 1,
	drop = "default:torch",
	light_source = 14,
	groups = {dig_immediate=3},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.03, 0.0625, 0.4375, 0.03},
			{-0.03, -0.5, -0.0625, 0.03, 0.4375, 0.0625},
			{-0.03, 0.3125, -0.03, 0.03, 0.5, 0.03},
			{-0.095, 0.125, -0.0625, 0.095, 0.375, 0.0625},
			{-0.0625, 0.125, -0.095, 0.0625, 0.3125, 0.095},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.03, 0.0625, 0.4375, 0.03},
			{-0.03, -0.5, -0.0625, 0.03, 0.4375, 0.0625},
			{-0.03, 0.3125, -0.03, 0.03, 0.5, 0.03},
			{-0.095, 0.125, -0.0625, 0.095, 0.375, 0.0625},
			{-0.0625, 0.125, -0.095, 0.0625, 0.3125, 0.095},
		}
	},
on_place = function(itemstack, placer, pointed_thing)
	local timer = minetest.get_node_timer(pointed_thing.above)
		timer:start(torch_timer)
	if pointed_thing.type ~= "node" then
		return itemstack
	end

	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	local dir = {
		x = p1.x - p0.x,
		y = p1.y - p0.y,
		z = p1.z - p0.z
		}
		
	local that = minetest.get_node(pointed_thing.above).name
		
	if that == "air" then
		if p0.y>p1.y then
			minetest.add_node(p1, {name="mytorcheshd:torch_ceiling"})
		elseif p0.y<p1.y then
			minetest.add_node(p1, {name="default:torch"})
		else
			minetest.add_node(p1, {name="mytorcheshd:torch_wall", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		end
	end
	itemstack:take_item()
		return itemstack
end,
	on_timer = function(pos, elapsed)
	local timer = minetest.get_node_timer(pos)
	minetest.set_node(pos, {name = "mytorcheshd:torch_med"})
	timer:start(torch_timer)
	end,
})
minetest.register_node("mytorcheshd:torch_wall", {
	description = "Torch",
	tiles = {
		{name="mytorch_torch2_ani.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
	},
	drawtype = "mesh",
	mesh = "mytorch_torch_wall.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	drop = "default:torch",
	damage_per_second = 1,
	light_source = 14,
	groups = {dig_immediate=3, not_in_creative_inventory = 1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, 0.125, -0.03, 0.0625, 0.4375, 0.03},
			{-0.03, 0.3125, -0.03, 0.03, 0.5, 0.03},
			{-0.095, 0.125, -0.0625, 0.095, 0.375, 0.0625},
			{-0.0625, 0.125, -0.095, 0.0625, 0.3125, 0.00},
			{-0.03, 0.125, -0.0625, 0.03, 0.4375, 0.0625},
			{-0.0625, 0.0625, -0.0625, 0.0625, 0.1875, 0.0625},
			{-0.0625, 0, 0, 0.0625, 0.125, 0.125},
			{-0.0625, -0.0625, 0.0625, 0.0625, 0.0625, 0.1875},
			{-0.0625, -0.125, 0.125, 0.0625, 0, 0.25},
			{-0.0625, -0.1875, 0.1875, 0.0625, -0.0625, 0.3125},
			{-0.0625, -0.25, 0.25, 0.0625, -0.125, 0.375},
			{-0.0625, -0.3125, 0.3125, 0.0625, -0.1875, 0.4375},
			{-0.0625, -0.375, 0.375, 0.0625, -0.25, 0.5},
		}
	},
	on_timer = function(pos, elapsed)
	local node = minetest.get_node(pos)
	local timer = minetest.get_node_timer(pos)
	minetest.set_node(pos, {name = "mytorcheshd:torch_med_wall", param2 = node.param2})
	timer:start(torch_timer)
	end,

})
minetest.register_node("mytorcheshd:torch_ceiling", {
	description = "Torch",
	tiles = {
		{name="mytorch_torch_ceiling.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
	},
	drawtype = "mesh",
	mesh = "mytorch_torch_ceiling.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "default:torch",
	walkable = false,
	damage_per_second = 1,
	light_source = 14,
	groups = {dig_immediate=3, not_in_creative_inventory = 1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			
		}
	},
	on_timer = function(pos, elapsed)
	local timer = minetest.get_node_timer(pos)
	minetest.set_node(pos, {name = "mytorcheshd:torch_med_ceiling"})
	timer:start(torch_timer)
	end,
})
----------------------------------------------------------------------
minetest.register_node("mytorcheshd:torch_med", {
	description = "Torch",
	inventory_image = "",
	wield_image = "",
	tiles = {
		{name="mytorch_torch_med.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
	},
	drawtype = "mesh",
	mesh = "mytorch_torch_med.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	damage_per_second = 1,
	drop = "default:torch",
	light_source = 11,
	groups = {dig_immediate=3, not_in_creative_inventory = 1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.03, 0.0625, 0.25, 0.03},
			{-0.03, -0.5, -0.0625, 0.03, 0.25, 0.0625},
		}
	},
	on_timer = function(pos, elapsed)
	local timer = minetest.get_node_timer(pos)
	minetest.set_node(pos, {name = "mytorcheshd:torch_dim"})
	timer:start(torch_timer)
	end,
})
minetest.register_node("mytorcheshd:torch_med_wall", {
	description = "Torch",
	tiles = {
		{name="mytorch_torch_wall_med.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
	},
	drawtype = "mesh",
	mesh = "mytorch_torch_wall_med.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	damage_per_second = 1,
	drop = "default:torch",
	light_source = 11,
	groups = {dig_immediate=3, not_in_creative_inventory = 1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, 0.0625, -0.0625, 0.0625, 0.1875, 0.0625},
			{-0.0625, 0, 0, 0.0625, 0.125, 0.125},
			{-0.0625, -0.0625, 0.0625, 0.0625, 0.0625, 0.1875},
			{-0.0625, -0.125, 0.125, 0.0625, 0, 0.25},
			{-0.0625, -0.1875, 0.1875, 0.0625, -0.0625, 0.3125},
			{-0.0625, -0.25, 0.25, 0.0625, -0.125, 0.375},
			{-0.0625, -0.3125, 0.3125, 0.0625, -0.1875, 0.4375},
			{-0.0625, -0.375, 0.375, 0.0625, -0.25, 0.5},
		}
	},
	on_timer = function(pos, elapsed)
	local node = minetest.get_node(pos)
	local timer = minetest.get_node_timer(pos)
	minetest.set_node(pos, {name = "mytorcheshd:torch_dim_wall", param2 = node.param2})
	timer:start(torch_timer)
	end,

})
minetest.register_node("mytorcheshd:torch_med_ceiling", {
	description = "Torch",
	tiles = {
		{name="mytorch_torch_ceiling.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},},
	drawtype = "mesh",
	mesh = "mytorch_torch_ceiling_med.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "default:torch",
	walkable = false,
	damage_per_second = 1,
	light_source = 11,
	groups = {dig_immediate=3, not_in_creative_inventory = 1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.25, -0.03, 0.0625, 0.5, 0.03},
			{-0.03, -0.25, -0.0625, 0.03, 0.5, 0.0625},
			
		}
	},
	on_timer = function(pos, elapsed)
	local timer = minetest.get_node_timer(pos)
	minetest.set_node(pos, {name = "mytorcheshd:torch_dim_ceiling"})
	timer:start(torch_timer)
	end,
})
----------------------------------------------------------------------
minetest.register_node("mytorcheshd:torch_dim", {
	description = "Torch",
	inventory_image = "",
	wield_image = "",
	tiles = {
		{name="mytorch_torch_med.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
	},
	drawtype = "mesh",
	mesh = "mytorch_torch_dim.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	damage_per_second = 1,
	drop = "default:stick",
	light_source = 8,
	groups = {dig_immediate=3, not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.03, 0.0625, 0, 0.03},
			{-0.03, -0.5, -0.0625, 0.03, 0, 0.0625},
		}
	},
	on_timer = function(pos, elapsed)
	local timer = minetest.get_node_timer(pos)
	minetest.set_node(pos, {name = "mytorcheshd:torch_out"})
	timer:start(torch_timer)
	end,
})
minetest.register_node("mytorcheshd:torch_dim_wall", {
	description = "Torch",
	tiles = {
		{name="mytorch_torch_wall_med.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
	},
	drawtype = "mesh",
	mesh = "mytorch_torch_wall_dim.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	damage_per_second = 1,
	drop = "default:stick",
	light_source = 8,
	groups = {dig_immediate=3, not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.125, 0.125, 0.0625, 0, 0.25},
			{-0.0625, -0.1875, 0.1875, 0.0625, -0.0625, 0.3125},
			{-0.0625, -0.25, 0.25, 0.0625, -0.125, 0.375},
			{-0.0625, -0.3125, 0.3125, 0.0625, -0.1875, 0.4375},
			{-0.0625, -0.375, 0.375, 0.0625, -0.25, 0.5},
		}
	},
	on_timer = function(pos, elapsed)
	local node = minetest.get_node(pos)
	local timer = minetest.get_node_timer(pos)
	minetest.set_node(pos, {name = "mytorcheshd:torch_out_wall", param2 = node.param2})
	timer:start(torch_timer)
	end,
})
minetest.register_node("mytorcheshd:torch_dim_ceiling", {
	description = "Torch",
	tiles = {
		{name="mytorch_torch_ceiling.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
	},
	drawtype = "mesh",
	mesh = "mytorch_torch_ceiling_dim.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "default:stick",
	walkable = false,
	damage_per_second = 1,
	light_source = 8,
	groups = {dig_immediate=3, not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, 0, -0.03, 0.0625, 0.5, 0.03},
			{-0.03, 0, -0.0625, 0.03, 0.5, 0.0625},
		}
	},
	on_timer = function(pos, elapsed)
	local timer = minetest.get_node_timer(pos)
	minetest.set_node(pos, {name = "mytorcheshd:torch_out_ceiling"})
	timer:start(10)
	end,
})
----------------------------------------------------------------------
----------------------------------------------------------------------
minetest.register_node("mytorcheshd:torch_out", {
	description = "Torch",
	inventory_image = "",
	wield_image = "",
	tiles = {
		"mytorch_torch_out.png",
	},
	drawtype = "mesh",
	mesh = "mytorch_torch_out.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	drop = "",
	groups = {dig_immediate=3, not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.03, 0.0625, -0.25, 0.03},
			{-0.03, -0.5, -0.0625, 0.03, -0.25, 0.0625},
		}
	},
	on_timer = function(pos, elapsed)
	minetest.set_node(pos, {name = "air"})
	end,
})
minetest.register_node("mytorcheshd:torch_out_wall", {
	description = "Torch",
	tiles = {
		"mytorch_torch_out.png",
	},
	drawtype = "mesh",
	mesh = "mytorch_torch_wall_out.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	drop = "",
	groups = {dig_immediate=3, not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.3125, 0.3125, 0.0625, -0.1875, 0.4375},
			{-0.0625, -0.375, 0.375, 0.0625, -0.25, 0.5},
		}
	},
	on_timer = function(pos, elapsed)
	minetest.set_node(pos, {name = "air"})
	end,

})
minetest.register_node("mytorcheshd:torch_out_ceiling", {
	description = "Torch",
	tiles = {
		"mytorch_torch_black.png",
	},
	drawtype = "mesh",
	mesh = "mytorch_torch_ceiling_out.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "",
	walkable = false,
	groups = {dig_immediate=3, not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, 0.25, -0.03, 0.0625, 0.5, 0.03},
			{-0.03, 0.25, -0.0625, 0.03, 0.5, 0.0625},
		}
	},
	on_timer = function(pos, elapsed)
	minetest.set_node(pos, {name = "air"})
	end,
})


minetest.register_abm({
	nodenames = {"default:torch","mytorcheshd:torch_med","mytorcheshd:torch_dim","mytorcheshd:torch_out"},
	interval = 0.1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
			local p = {x = pos.x,y=pos.y-1,z=pos.z}
			local n = minetest.get_node(p).name
			local nd = node.name
			if n == "air" then
				if nd == "default:torch" then
					minetest.spawn_item(pos, "default:torch")
					minetest.remove_node(pos)
				elseif nd == "mytorcheshd:torch_med" then
					minetest.spawn_item(pos, "default:stick")
					minetest.remove_node(pos)
				elseif nd == "mytorcheshd:torch_dim" then
					minetest.spawn_item(pos, "default:stick")
					minetest.remove_node(pos)
				elseif nd == "mytorcheshd:torch_out" then
					minetest.remove_node(pos)
				end
			
			end
		end
})
else
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
minetest.override_item("default:torch", {
	description = "Torch",
	inventory_image = "",
	wield_image = "",
	tiles = {
		{name="mytorches_torch_top.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
		"mytorches_torch_bottom.png",
		{name="mytorches_torch1.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
		{name="mytorches_torch1.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
		{name="mytorches_torch1.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
		{name="mytorches_torch1.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	damage_per_second = 1,
	drop = "default:torch",
	light_source = 14,
	groups = {dig_immediate=3},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.03, 0.0625, 0.4375, 0.03},
			{-0.03, -0.5, -0.0625, 0.03, 0.4375, 0.0625},
			{-0.03, 0.3125, -0.03, 0.03, 0.5, 0.03},
			{-0.095, 0.125, -0.0625, 0.095, 0.375, 0.0625},
			{-0.0625, 0.125, -0.095, 0.0625, 0.3125, 0.095},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.03, 0.0625, 0.4375, 0.03},
			{-0.03, -0.5, -0.0625, 0.03, 0.4375, 0.0625},
			{-0.03, 0.3125, -0.03, 0.03, 0.5, 0.03},
			{-0.095, 0.125, -0.0625, 0.095, 0.375, 0.0625},
			{-0.0625, 0.125, -0.095, 0.0625, 0.3125, 0.095},
		}
	},
on_place = function(itemstack, placer, pointed_thing)
	local timer = minetest.get_node_timer(pointed_thing.above)
		timer:start(torch_timer)
	if pointed_thing.type ~= "node" then
		return itemstack
	end

	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	local dir = {
		x = p1.x - p0.x,
		y = p1.y - p0.y,
		z = p1.z - p0.z
		}
		
	local that = minetest.get_node(pointed_thing.above).name
	if that == "air" then
		if p0.y>p1.y then
			minetest.add_node(p1, {name="mytorcheshd:torch_ceiling"})
		elseif p0.y<p1.y then
			minetest.add_node(p1, {name="default:torch"})
		else
			minetest.add_node(p1, {name="mytorcheshd:torch_wall", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		end
	end
	itemstack:take_item()
		return itemstack
end,
})

minetest.register_node("mytorcheshd:torch_wall", {
	description = "Torch",
	tiles = {
		{name="mytorches_torch_top2.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
		"mytorches_torch_bottom2.png",
		{name="mytorches_torch1.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
		{name="mytorches_torch1.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
		{name="mytorches_torch1.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
		{name="mytorches_torch1.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	drop = "default:torch",
	damage_per_second = 1,
	light_source = 14,
	groups = {dig_immediate=3, not_in_creavive_inventory = 1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, 0.125, -0.03, 0.0625, 0.4375, 0.03},
			{-0.03, 0.3125, -0.03, 0.03, 0.5, 0.03},
			{-0.095, 0.125, -0.0625, 0.095, 0.375, 0.0625},
			{-0.0625, 0.125, -0.095, 0.0625, 0.3125, 0.00},
			{-0.03, 0.125, -0.0625, 0.03, 0.4375, 0.0625},
			{-0.0625, 0.0625, -0.0625, 0.0625, 0.1875, 0.0625},
			{-0.0625, 0, 0, 0.0625, 0.125, 0.125},
			{-0.0625, -0.0625, 0.0625, 0.0625, 0.0625, 0.1875},
			{-0.0625, -0.125, 0.125, 0.0625, 0, 0.25},
			{-0.0625, -0.1875, 0.1875, 0.0625, -0.0625, 0.3125},
			{-0.0625, -0.25, 0.25, 0.0625, -0.125, 0.375},
			{-0.0625, -0.3125, 0.3125, 0.0625, -0.1875, 0.4375},
			{-0.0625, -0.375, 0.375, 0.0625, -0.25, 0.5},
		}
	},
})
minetest.register_node("mytorcheshd:torch_ceiling", {
	description = "Torch",
	tiles = {
		"mytorches_torch_bottom.png",
		{name="mytorches_torch_top.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
		{name="mytorches_torch2.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
		{name="mytorches_torch2.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
		{name="mytorches_torch2.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
		{name="mytorches_torch2.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=0.5}},
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "default:torch",
	walkable = false,
	damage_per_second = 1,
	light_source = 14,
	groups = {dig_immediate=3, not_in_creavive_inventory = 1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.4375, -0.03, 0.0625, 0.5, 0.03},
			{-0.03, -0.4375, -0.0625, 0.03, 0.5, 0.0625},
			{-0.095, -0.125, -0.0625, 0.095, -0.375, 0.0625},
			{-0.0625, -0.125, -0.095, 0.0625, -0.3125, 0.095},
			
		}
	},
})

end
