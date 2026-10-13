-- Pandoc custom reader: GFM in which YAML frontmatter and raw HTML/XML tags
-- remain visible. Usage: pandoc -f skillmd.lua -t gfm FILE | glow -

local TAG_LINE = '^%s*</?%a[^<>]*>%s*$'

local function is_raw(el) return el and el.t == 'RawInline' and el.format == 'html' end

-- Inline tags become literal text (the writer escapes '<' and '>').
-- A soft break adjacent to a tag becomes a hard break, so the tag keeps its line.
local function inlines(list)
  for i, el in ipairs(list) do
    if el.t == 'SoftBreak' and (is_raw(list[i - 1]) or is_raw(list[i + 1])) then
      list[i] = pandoc.LineBreak()
    end
  end
  for i, el in ipairs(list) do
    if is_raw(el) then list[i] = pandoc.Str(el.text) end
  end
  return list
end

-- Raw markup that survives a second parse (comments, CDATA, declarations)
-- becomes a fenced block. This case terminates the recursion in raw_block.
local function verbatim(el)
  if el.format == 'html' then
    return pandoc.CodeBlock((el.text:gsub('\n+$', '')), pandoc.Attr('', { 'html' }))
  end
end

-- A CommonMark HTML block runs from a tag-only line to the next blank line.
-- Tag-only lines become literal text; the lines between are parsed as GFM.
-- A run of tag lines attaches to the following paragraph when there is one,
-- else to the preceding paragraph, joined by hard line breaks so the source
-- line structure is kept. Otherwise it stands as its own paragraph.
local function raw_block(el)
  if el.format ~= 'html' then return nil end
  local items, pending, tags = {}, {}, {}
  local function flush_tags()
    if #tags > 0 then items[#items + 1] = { tags = tags }; tags = {} end
  end
  local function flush_pending()
    if #pending == 0 then return end
    local doc = pandoc.read(table.concat(pending, '\n'), 'gfm')
    items[#items + 1] = { blocks = doc:walk{ Inlines = inlines, RawBlock = verbatim }.blocks }
    pending = {}
  end
  for line in el.text:gmatch('[^\n]+') do
    if line:match(TAG_LINE) then
      flush_pending()
      tags[#tags + 1] = pandoc.Str((line:gsub('^%s+', ''):gsub('%s+$', '')))
    else
      flush_tags()
      pending[#pending + 1] = line
    end
  end
  flush_pending(); flush_tags()

  local function joined(strs)
    local list = pandoc.Inlines{}
    for i, str in ipairs(strs) do
      if i > 1 then list:insert(pandoc.LineBreak()) end
      list:insert(str)
    end
    return list
  end
  local out = pandoc.Blocks{}
  for i, item in ipairs(items) do
    if item.blocks then
      out:extend(item.blocks)
    else
      local nxt, prev = items[i + 1], items[i - 1]
      local tail = out[#out]
      if nxt and nxt.blocks and nxt.blocks[1] and nxt.blocks[1].t == 'Para' then
        local para = nxt.blocks[1]
        para.content = joined(item.tags) .. { pandoc.LineBreak() } .. para.content
      elseif prev and prev.blocks and tail and tail.t == 'Para' then
        tail.content = tail.content .. { pandoc.LineBreak() } .. joined(item.tags)
      else
        out:insert(pandoc.Para(joined(item.tags)))
      end
    end
  end
  return out
end

-- Frontmatter is defined by position (line 1 through the next '---' or '...'
-- line), not by markdown grammar. It is split off unparsed, so YAML that a
-- strict parser rejects is still displayed.
local function split_frontmatter(src)
  if not src:match('^%-%-%-[ \t]*\r?\n') then return nil, src end
  for _, close in ipairs{ '%-%-%-', '%.%.%.' } do
    local yaml, rest = src:match('^%-%-%-[ \t]*\r?\n(.-)\r?\n' .. close .. '[ \t]*\r?\n(.*)$')
    if yaml then return yaml, rest end
  end
  return nil, src
end

function Reader(input)
  local yaml, body = split_frontmatter(tostring(input))
  local doc = pandoc.read(body, 'gfm'):walk{ Inlines = inlines, RawBlock = raw_block }
  if yaml then
    doc.blocks:insert(1, pandoc.CodeBlock(yaml, pandoc.Attr('', { 'yaml' })))
  end
  return doc
end
