local M = {}

-- 仅在 setup 或 enable 时加载，避免启动瞬间的循环引用
local function get_deps()
    local ok_wk, wk = pcall(require, "which-key")
    local translate = require("lazyvim_chinese.translate")
    local dashboard = require("lazyvim_chinese.dashboard")
    return ok_wk, wk, translate, dashboard
end

local enabled = false

local function apply(trans_map, mode)
    local wk_ok, wk, translate, _ = get_deps()
    if not wk_ok then return end
    
    local regs = {}
    for lhs, name in pairs(trans_map) do
        table.insert(regs, { lhs, desc = name, mode = mode or "n" })
    end
    wk.add(regs)
end

function M.enable()
    if enabled then return end
    enabled = true
    local _, _, translate, dashboard = get_deps()
    apply(translate.cn)
    apply(translate.cn_v, "v")
    dashboard.apply(true)
end

function M.disable()
    if not enabled then return end
    enabled = false
    local _, _, translate, dashboard = get_deps()
    apply(translate.en)
    apply(translate.en_v, "v")
    dashboard.apply(false)
end

function M.toggle()
    if enabled then M.disable() else M.enable() end
end

function M.setup()
    -- 注意：这里不要在顶级作用域 require 自身
    vim.keymap.set("n", "<leader>uC", function()
        M.toggle()
    end, { desc = "菜单汉化切换" })

    M.enable()

    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            if enabled then
                local _, _, translate, _ = get_deps()
                apply(translate.cn)
                apply(translate.cn_v, "v")
            end
        end,
    })
end

return M
