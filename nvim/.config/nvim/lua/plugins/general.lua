return {
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = true
    },
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = true
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = true
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
