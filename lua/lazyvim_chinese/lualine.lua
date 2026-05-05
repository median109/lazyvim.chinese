local mode_map = {
  ["NORMAL"] = "普通",
  ["INSERT"] = "插入",
  ["VISUAL"] = "可视",
  ["V-LINE"] = "行可视",
  ["V-BLOCK"] = "块可视",
  ["SELECT"] = "选择",
  ["S-LINE"] = "行选择",
  ["S-BLOCK"] = "块选择",
  ["REPLACE"] = "替换",
  ["COMMAND"] = "命令",
  ["TERMINAL"] = "终端",
}

function M.setup_lualine()
  local status_lualine, lualine = pcall(require, "lualine")
  if not status_lualine then return end

  lualine.setup({
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            return mode_map[str] or str
          end,
        },
      },
    },
  })
end
