local M = {}

-- 这里定义 Dashboard 上的按钮翻译
M.button_map = {
  ["Find File"] = "查找文件",
  ["Recent Files"] = "最近文件",
  ["Config"] = "配置",
  ["Restore Session"] = "恢复会话",
  ["Projects"] = "项目",
  ["Lazy"] = "插件管理",
  ["Quit"] = "退出",
  -- 适配新版 Snacks Dashboard
  ["Explore"] = "文件浏览",
  ["Grep Text"] = "全文检索",
}

function M.apply(is_chinese)
  -- 尝试获取 Alpha 仪表盘
  local status_alpha, alpha = pcall(require, "alpha")
  if status_alpha then
    local dashboard = require("alpha.themes.dashboard")
    for _, button in ipairs(dashboard.section.buttons.val) do
      if is_chinese then
        button.on_config = button.on_config or button.val
        for en, cn in pairs(M.button_map) do
          button.val = button.val:gsub(en, cn)
        end
      end
    end
    pcall(vim.cmd, "AlphaRedraw")
  end

  -- 尝试获取 Snacks Dashboard (新版 LazyVim 默认)
  local status_snacks, snacks = pcall(require, "snacks")
  if status_snacks then
    -- Snacks 的翻译通常在配置层处理，这里预留接口
  end
end

return M
