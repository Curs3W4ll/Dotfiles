return function()

    require("lint").linters_by_ft = require("plugins.mason-tools").linter.listLintersByFt()

end
