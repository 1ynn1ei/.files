local db = require("dashboard")
local home = os.getenv("HOME")


local maps = {}

local function button(icon, desc, keys, action)
	table.insert(maps, {
		keys,
		action,
	})

	return {
		icon = icon,
		desc = desc,
		shortcut = keys,
		action = action,
	}
end

-- Set keymaps only when dashboard is active
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("DashboardMappings", { clear = true }),
	pattern = "dashboard",
	callback = function()
		vim.tbl_map(function(map)
			if type(map[2]) == "string" then
				map[2] = map[2] .. "<cr>"
			end

			vim.keymap.set("n", map[1], map[2], { buffer = true, silent = true, nowait = true })
		end, maps)
	end,
})

db.custom_center = {
	button("  ", "find                               ", "f", ":Telescope find_files theme=dropdown"),
	button("  ", "search                             ", "/", ":Telescope live_grep theme=dropdown"),
	button("  ", "recent                             ", "r", ":Telescope oldfiles theme=dropdown"),
	button("  ", "new                                ", "n", ":DashboardNewFile"),
  button("  ",  "terminal                           ", "t", ":Fterm"),             
	-- button("  ", "last session                       ", "l", ":SessionManager load_last_session"),
	button("  ", "configure                          ", "c", ":Telescope find_files path="..home.."./dotfiles theme=dropdown"),
	button("  ", "quit                               ", "q", ":qa"),
}

db.preview_command = 'cat | lolcat -F 0.3'
db.preview_file_path = home .. '/.config/nvim/static/neovim.cat'
db.preview_file_height = 11
db.preview_file_width = 86
