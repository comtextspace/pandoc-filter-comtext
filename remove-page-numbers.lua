local text = pandoc.text

local function is_page_number(page_number_start, space, page_number_end)
    return page_number_start and page_number_start.t == 'Str'
      and page_number_end and page_number_end.t == 'Str'
      and space and space.t == 'Space'
      and page_number_start.text == '[#'
      and page_number_end.text:sub(-1) == ']'
  end

  local function is_inline_page_number(page_number_start, space, page_number_end)
    return page_number_start and page_number_start.t == 'Str'
      and page_number_end and page_number_end.t == 'Str'
      and space and space.t == 'Space'
      and page_number_start.text:sub(-2) == '[#'
      --and page_number_end.text:sub(-1) == ']'
  end

  function Inlines (inlines)
    -- Go from end to start to avoid problems with shifting indices.
    for i = #inlines-2, 1, -1 do
      if is_page_number(inlines[i], inlines[i+1], inlines[i+2]) then
        inlines:remove(i+2)
        inlines:remove(i+1)
        inlines:remove(i)
      elseif is_inline_page_number(inlines[i], inlines[i+1], inlines[i+2]) then 
        inlines[i].text = inlines[i].text:sub(1, -3)
        inlines[i+2].text = inlines[i+2].text:gsub('(.-])', '')

        inlines:remove(i+1)
      end
    end
    return inlines
  end
