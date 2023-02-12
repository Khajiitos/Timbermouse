
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
    axe_left = {
        name = '186464c864e.png',
        width = 108,
        height = 94,
    },
    axe_right = {
        name = '186464c393a.png',
        width = 108,
        height = 94,
    },
    wood_coin = {
        name = '186464cd336.png',
        width = 120,
        height = 69,
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