local M = {}

-- 按钮配置模板
M.buttons = {
  zh = {
    { icon = " ", key = "f", desc = "查找文件", action = ":lua Snacks.dashboard.pick('files')" },
    { icon = " ", key = "n", desc = "新建文件", action = ":ene | startinsert" },
    { icon = " ", key = "g", desc = "查找文本", action = ":lua Snacks.dashboard.pick('live_grep')" },
    { icon = " ", key = "r", desc = "最近文件", action = ":lua Snacks.dashboard.pick('oldfiles')" },
    { icon = " ", key = "c", desc = "配置文件", action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })" },
    { icon = " ", key = "s", desc = "恢复会话", section = "session" },
    { icon = "󰒲 ", key = "L", desc = "插件管理", action = ":Lazy" },
    { icon = " ", key = "q", desc = "退    出", action = ":qa" },
  },
  en = {
    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
    { icon = " ", key = "g", desc = "Grep Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
    { icon = " ", key = "r", desc = "Recent", action = ":lua Snacks.dashboard.pick('oldfiles')" },
    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })" },
    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
  }
}

function M.apply(is_chinese)
  -- 1. 处理新版 Snacks Dashboard
  local status_snacks, snacks = pcall(require, "snacks")
  if status_snacks then
    -- 直接修改 Snacks 的配置选项
    local lang = is_chinese and "zh" or "en"
    if snacks.config and snacks.config.dashboard then
      snacks.config.dashboard.preset = snacks.config.dashboard.preset or {}
      snacks.config.dashboard.preset.keys = M.buttons[lang]
      
      -- 如果当前已经在 Dashboard 页面，刷新它
      if vim.bo.filetype == "snacks_dashboard" then
        pcall(require("snacks.dashboard").open)
      end
    end
  end

  -- 2. 处理旧版 Alpha (保留兼容性)
  local status_alpha, alpha = pcall(require, "alpha")
  if status_alpha then
    local alpha_dashboard = require("alpha.themes.dashboard")
    -- 这里可以使用之前的 gsub 逻辑，或者直接重写 buttons
    pcall(vim.cmd, "AlphaRedraw")
  end
end

return M
