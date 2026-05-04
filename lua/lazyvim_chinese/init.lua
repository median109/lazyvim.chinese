local M = {}

local wk_ok, wk = pcall(require, "which-key")
local translate = require("lazyvim_chinese.translate")
local dashboard = require("lazyvim_chinese.dashboard")

local enabled = false

local function apply(trans_map, mode)
    if not wk_ok then
        return
    end
    local regs = {}
    for lhs, name in pairs(trans_map) do
        -- 核心修复：使用 desc 而不是 group
        -- 同时将 mode 直接放入每个条目中，符合 v3 规范
        table.insert(regs, { lhs, desc = name, mode = mode or "n" })
    end
    -- v3 规范：直接传入 table，不需要第二个参数
    wk.add(regs)
end

function M.enable()
    if enabled then
        return
    end
    enabled = true
    -- 只有当 which-key 加载后才执行，防止启动时崩溃
    if wk_ok then
        apply(translate.cn)
        apply(translate.cn_v, "v")
    end
    dashboard.apply(true)
end

function M.disable()
    if not enabled then
        return
    end
    enabled = false
    if wk_ok then
        apply(translate.en)
        apply(translate.en_v, "v")
    end
    dashboard.apply(false)
end

function M.toggle()
    if enabled then
        M.disable()
    else
        M.enable()
    end
end

function M.setup()
    -- 设置切换快捷键
    vim.keymap.set(
        "n",
        "<leader>uC",
        function()
            require("lazyvim_chinese").toggle()
        end,
        { desc = "菜单汉化切换" }
    )

    -- 初始启用
    M.enable()

    -- 确保在 VeryLazy 阶段重新应用，以覆盖插件定义的英文描述
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            -- 重新获取一次 wk，确保 VeryLazy 时它已加载
            wk_ok, wk = pcall(require, "which-key")
            if enabled then
                apply(translate.cn)
                apply(translate.cn_v, "v")
            end
        end,
    })

    vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
            dashboard.apply(enabled)
        end,
    })
end

return M
