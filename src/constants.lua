
MOUSE_SIZE = 1.25
GROUND_OFFSET = 50
MAP = 7925577
MAP_NAME = '<O><b>Timbermouse</b></O> <BL>by</BL> <V>Khajiitos</V><G>#0000</G>'

enum = {
    treeBlocks = {
        TREE = 0,
        TREE_LEFT = 1,
        TREE_RIGHT = 2
    },
    textArea = {
        HELP = 1,
        START_GAME = 2,
        SCORE = 3,
        TIME_LEFT = 4,
        TIME_TOTAL = 5,
        GAME_OVER = 6,
        GAME_OVER_CLOSE = 7,
        HELP_CONTENT = 8,
        HELP_CLOSE = 9,
        HELP_TAB_DESCRIPTION = 10,
        WOOD_COINS = 11,

        SHOP_BUTTON = 12,
        SHOP_BACKGROUND = 13,
        SHOP_BUTTON_BACK = 14,
        SHOP_BUTTON_FORWARD = 15,
        SHOP_BUTTON_CLOSE = 16,

        -- there's gonna be 5 each of those
        SHOP_AXE_NAME = 17,
        SHOP_AXE_IMAGE_FRAME = 22,
        SHOP_AXE_DESCRIPTION = 27,
        SHOP_AXE_BUTTON = 32,
    },
    helpTab = {
        CLOSED = 0,
        DESCRIPTION = 1
    }
}

images = {
    tombstone = {
        name = '1860ee51e37.png',
        width = 583,
        height = 738
    },
    default_root = {
        name = '18646498027.png',
        width = 210,
        height = 54
    },
    default_wood = {
        name = '1864649cd21.png',
        width = 100,
        height = 100,
    },
    default_branch_left = {
        name = '186464bec81.png',
        width = 200,
        height = 157,
    },
    default_branch_right = {
        name = '186464932ab.png',
        width = 200,
        height = 157,
    },
    birch_root = {
        name = '186464a6727.png',
        width = 210,
        height = 54
    },
    birch_wood = {
        name = '186464a1a20.png',
        width = 100,
        height = 100,
    },
    birch_branch_left = {
        name = '186464ab42a.png',
        width = 200,
        height = 157,
    },
    birch_branch_right = {
        name = '186464b0120.png',
        width = 200,
        height = 157,
    },
    cherryblossom_branch_left = {
        name = '186464b9d42.png',
        width = 200,
        height = 157,
    },
    cherryblossom_branch_right = {
        name = '186464b5041.png',
        width = 200,
        height = 157,
    },
    default_axe_left = {
        name = '186464c864e.png',
        width = 108,
        height = 94,
    },
    default_axe_right = {
        name = '186464c393a.png',
        width = 108,
        height = 94,
    },
    golden_axe_left = {
        name = '186865bcff5.png',
        width = 108,
        height = 94,
    },
    golden_axe_right = {
        name = '186865c1d25.png',
        width = 108,
        height = 94,
    },
    diamond_axe_left = {
        name = '186865c6a7e.png',
        width = 108,
        height = 94,
    },
    diamond_axe_right = {
        name = '186865cb73f.png',
        width = 108,
        height = 94,
    },
    sword_left = {
        name = '186865d5123.png',
        width = 146,
        height = 16,
    },
    sword_right = {
        name = '186865d0433.png',
        width = 146,
        height = 16,
    },
    chainsaw_left = {
        name = '186865d9e2c.png',
        width = 96,
        height = 52,
    },
    chainsaw_right = {
        name = '186865deb25.png',
        width = 96,
        height = 52,
    },
    wood_coin = {
        name = '186464cd336.png',
        width = 120,
        height = 69,
    }
}

axes = {
    {
        name = "Default",
        description = "The default axe",
        price = 0,
        image_left = images.default_axe_left,
        image_right = images.default_axe_right
    },
    {
        name = "<font color='#FFD700'>Golden axe</font>",
        description = "A golden axe",
        price = 50,
        image_left = images.golden_axe_left,
        image_right = images.golden_axe_right
    },
    {
        name = "<font color='#B9F2FF'>Diamond axe</font>",
        description = "A diamond axe",
        price = 100,
        image_left = images.diamond_axe_left,
        image_right = images.diamond_axe_right
    },
    {
        name = "<font color='#AAA9AD'>Sword</font>",
        description = "Because axes are overrated",
        price = 250,
        image_left = images.sword_left,
        image_right = images.sword_right
    },
    {
        name = "<font color='#CC6600'>Chainsaw</font>",
        description = "Free infinite gasoline included",
        price = 500,
        image_left = images.chainsaw_left,
        image_right = images.chainsaw_right
    }
}

trees = {
    default = {
        name = "Default",
        scoreTextColor = '#FFFFFF',
        images = {
            root = images.default_root,
            wood = images.default_wood,
            branch_left = images.default_branch_left,
            branch_right = images.default_branch_right
        }
    },
    birch = {
        name = "Birch",
        scoreTextColor = '#777777',
        images = {
            root = images.birch_root,
            wood = images.birch_wood,
            branch_left = images.birch_branch_left,
            branch_right = images.birch_branch_right
        }
    },
    cherryblossom = {
        name = "Cherry Blossom",
        scoreTextColor = "#FFFFFF",
        images = {
            root = images.default_root,
            wood = images.default_wood,
            branch_left = images.cherryblossom_branch_left,
            branch_right = images.cherryblossom_branch_right
        }
    }
}

treeTypes = {}
for treeType, _ in pairs(trees) do
    treeTypes[#treeTypes + 1] = treeType
end