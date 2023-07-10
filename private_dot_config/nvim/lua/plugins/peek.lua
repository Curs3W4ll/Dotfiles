return function()

    require("peek").setup({
        -- Auto start preview when entering markdown buffer
        auto_load = true,
        -- Close preview window on buffer delete
        close_on_bdelete = true,
        -- Application used to display webpage
        app = "webview",
    })

end
