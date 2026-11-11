local last_custom_command = ''

-- Turn one output line into a picker item. Understands `file:line:col:text`,
-- `file:line:text` and bare paths; anything else stays a plain text item.
local function parse_command_line(item, cwd)
  local text = item.text
  item.cwd = cwd

  if vim.uv.fs_stat(vim.fs.joinpath(cwd, text)) or vim.uv.fs_stat(text) then
    item.file = text
    return item
  end

  local file, line, col, rest = text:match '^(.-):(%d+):(%d+):(.*)$'
  if not file then
    file, line, rest = text:match '^(.-):(%d+):(.*)$'
  end
  if file and file ~= '' then
    item.file = file
    item.pos = { tonumber(line), col and tonumber(col) - 1 or 0 }
    item.line = rest
  end
  return item
end

local M = {}

function M.run()
  Snacks.input({
    prompt = 'Command (rg/fd/...)',
    default = last_custom_command,
    completion = 'shellcmdline',
  }, function(cmd)
    if not cmd or vim.trim(cmd) == '' then
      return
    end
    last_custom_command = cmd

    -- Make rg print positions so results can be jumped to.
    local shell_cmd = cmd:gsub(
      '^rg%s',
      'rg --color=never --no-heading --with-filename --column ',
      1
    )
    local cwd = vim.uv.cwd() or '.'

    Snacks.picker {
      title = cmd,
      finder = function(opts, ctx)
        return require('snacks.picker.source.proc').proc(
          ctx:opts {
            cmd = 'sh',
            args = { '-c', shell_cmd },
            cwd = cwd,
            notify = false, -- rg exits with 1 when nothing matched
            transform = function(item)
              return parse_command_line(item, cwd)
            end,
          },
          ctx
        )
      end,
      format = function(item, picker)
        if item.file then
          return Snacks.picker.format.file(item, picker)
        end
        return { { item.text } }
      end,
      preview = function(ctx)
        if ctx.item.file then
          return Snacks.picker.preview.file(ctx)
        end
        ctx.preview:reset()
        ctx.preview:set_lines { ctx.item.text }
      end,
    }
  end)
end

return M
