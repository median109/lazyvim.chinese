# lazyvim.chinese

- LazyVim 菜单汉化插件
- 修改自 https://github.com/xuxiaowei-com-cn/lazyvim.chinese
- 补全了汉化

## 功能

- 为常见 LazyVim 菜单分组提供中文名称（例如：`<leader>f` → 查找、`<leader>w` → 窗口等）
- 在 `<leader>u` 菜单下增加 `C` 切换项：开启/关闭汉化

## 安装

使用 `lazy.nvim`：

```lua
{
    -- 这一行告诉 lazy.nvim 去 GitHub 下载这个插件
  "median109/lazyvim.chinese",
    -- config 函数会在插件下载并加载后自动运行
  config = function()
    require("lazyvim_chinese").setup()
  end,
}
```

或在任意位置调用：

```lua
require("lazyvim_chinese").setup()
```

## 使用

- 安装后 WhichKey 的分组名称显示为中文，按 `<Space>uC`（`<leader>uC`）开启/关闭汉化，关闭后恢复英文

## 自定义

可在 `lua/lazyvim_chinese/translate.lua` 中按需增添/修改分组映射。

# 验证说明

1. 确保已安装 `folke/which-key.nvim`（LazyVim 默认已包含）
2. 将本插件加入 `lazy.nvim` 列表并调用 `require("lazyvim_chinese").setup()`
3. 打开 Neovim，按 `<Space>u` 打开 UI 菜单，看到新增 `C` 项
4. 按 `<Space>uC`：
    - 第一次：启用汉化，WhichKey 分组显示中文
    - 再次按：禁用汉化，恢复英文

如需扩展中文映射，编辑 [translate.lua](../lua/lazyvim_chinese/translate.lua)。

