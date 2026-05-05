local M = {}

-- 统一管理按钮翻译表
M.en_to_cn = {
    ["Find File"] = "查找文件",
    ["New File"] = "新建文件",
    ["Projects"] = "项目",
    ["Find Text"] = "查找文本",
    ["Grep Text"] = "全文检索",
    ["Recent Files"] = "最近文件",
    ["Config"] = "配置",
    ["Restore Session"] = "恢复会话",
    ["Lazy Extras"] = "Lazy 扩展",
    ["Lazy"] = "插件管理",
    ["Quit"] = "退出",
    ["Explore"] = "文件浏览",
}

-- 自动生成反向表
M.cn_to_en = {}
for k, v in pairs(M.en_to_cn) do
    M.cn_to_en[v] = k
end

function M.apply(is_chinese)
    -- 1. 适配 Alpha 仪表盘
    local status_alpha, alpha = pcall(require, "alpha")
    if status_alpha then
        local dashboard = require("alpha.themes.dashboard")
        for _, button in ipairs(dashboard.section.buttons.val) do
            local map = is_chinese and M.en_to_cn or M.cn_to_en
            for target, replacement in pairs(map) do
                -- 使用 plain matching 防止特殊字符干扰
                if button.val:find(target, 1, true) then
                    button.val = button.val:gsub(target, replacement)
                end
            end
        end
        pcall(vim.cmd, "AlphaRedraw")
    end

    -- 2. 适配 Snacks Dashboard (LazyVim V14+ 默认)
    -- 注意：Snacks 的仪表盘是动态渲染的，如果它没汉化，
    -- 通常是因为它直接读取了 snacks.dashboard.config
    local status_snacks, _ = pcall(require, "snacks")
    if status_snacks and is_chinese then
        -- 这里可以添加针对 Snacks 的特定 Hook，
        -- 但目前最稳妥的是在 Alpha/Dashboard 层面完成替换
    end
end

return M
