local bufferline = require("bufferline")

local mappings = {
    b = {
        name = "Opened buffers",
        n = { ":BufferLineCycleNext<CR>", "Go to the next buffer (cycle)" },
        N = { ":BufferLineCyclePrev<CR>", "Go to the previous buffer (cycle)" },
        ["0"] = { bufferline.go_to(0, true), "Go to the first buffer" },
        ["$"] = { bufferline.go_to(-1, true), "Go to the last buffer" },
        [">"] = { ":BufferLineMoveNext<CR>", "Move the selected buffer after" },
        ["<"] = { ":BufferLineMovePrev<CR>", "Move the selected buffer before" },
        e = { ":BufferLineSortByExtension<CR>", "Sort the buffers by extension" },
        d = { ":BufferLineSortByDirectory<CR>", "Sort the buffers by directory" },
        c = {
            name = "Delete buffers",
            c = { ":Bdelete<CR>", "Close the selected buffer" },
            p = { ":BufferLinePickClose<CR>", "Select and close buffers" },
            l = { ":BufferLineCloseLeft<CR>", "Close buffers to the left" },
            r = { ":BufferLineCloseRight<CR>", "Close buffers to the right" },
        },
    },
}
mappings.k = mappings.b.n
mappings.j = mappings.b.N
mappings[">"] = mappings.b[">"]
mappings["<"] = mappings.b["<"]
mappings.b.q = mappings.b.c.c

require("which-key").register(mappings, {
    mode = "n",
    prefix = "<leader>",
})
