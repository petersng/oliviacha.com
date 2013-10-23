module Jekyll
    module TableFilter
        def drop_next_row(position, num_items_row)
            result = to_number(position) % to_number(num_items_row)
            if result == 0
                "<tr></tr>"
            else
                ""
            end
        end
    end
end
Liquid::Template.register_filter(Jekyll::TableFilter)
