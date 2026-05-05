# lazyvim.chinese

LazyVim 菜单汉化插件
修改自 https://github.com/xuxiaowei-com-cn/lazyvim.chinese
补全了汉化

## 功能

- 为常见 LazyVim 菜单分组提供中文名称（例如：`<leader>f` → 查找、`<leader>w` → 窗口等）
- 在 `<leader>u` 菜单下增加 `C` 切换项：开启/关闭汉化

## 安装

使用 `lazy.nvim`：

```lua
{
  "xuxiaowei-com-cn/lazyvim.chinese",
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
