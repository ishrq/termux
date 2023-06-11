return {
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "gaoDean/autolist.nvim",
        ft = {"markdown","text"},
        event = "InsertEnter",
        config = true
    },
    {
        "NvChad/nvim-colorizer.lua",
        ft = {"html","css","js","lua"},
        event = "VeryLazy",
        cmd = "Colorizer",
        config = true
    },
}
