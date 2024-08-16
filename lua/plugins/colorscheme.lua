return {
	"wolke/tokyonight.nvim",
  	lazy = false,
 	priority = 1000,


    config = function()
        vim.cmd [[colorscheme tokyonight-night]]
        
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	    
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
     end
}
