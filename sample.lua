--- sample.lua – filter to include Markdown files
---
--- Copyright: © 2021–2022 Contributors

-- Makes sure users know if their pandoc version is too old for this
-- filter.
PANDOC_VERSION:must_be_at_least '2.17'

--- Replaces the contents of a document with a simple greeting.
local function say_hello (doc)
  doc.meta.title = pandoc.Inlines 'Greetings!'
  doc.blocks = pandoc.Blocks{pandoc.Para 'Hello from the Lua filter!'}
  return doc
end

return {
  -- Apply the `say_hello` function to the main Pandoc document.
  { Pandoc = say_hello }
}
