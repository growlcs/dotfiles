vim.cmd.packadd("mellifluous.nvim")

if vim.fn.has("mac") == 1 then
    local appearance = vim.system({ "/usr/bin/defaults", "read", "-g", "AppleInterfaceStyle" }, { text = true }):wait()
    vim.o.background = vim.trim(appearance.stdout or "") == "Dark" and "dark" or "light"
end

vim.cmd.colorscheme("mellifluous")
