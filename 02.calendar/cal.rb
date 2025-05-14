#!/usr/bin/env ruby
require 'date'

start_date = Date.new(2025, 5, 1)
end_date = Date.new(2025, 5, -1)

while start_date <= end_date
    current_day = start_date.day
    current_date = start_date

    formatted_output =
        if current_day < 10
            " #{current_day}" # 一桁の場合、前にスペースを追加
        else
            print "#{current_day}"
        end

    if current_date.saturday?
        puts formatted_output #改行
    else
        print formatted_output, "  "
    end
    start_date = start_date.next_day
end