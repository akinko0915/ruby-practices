#!/usr/bin/env ruby
require 'date'

start_date = Date.new(2025, 5, 1)
end_date = Date.new(2025, 5, -1)
calendar_week = Array.new(7, "  ") #週ごとに配列を作る

month_year = start_date.month.to_s + "月" + "　" + start_date.year.to_s
puts month_year.center(25)
week_name = ["日", "月", "火", "水", "木", "金", "土"]
puts week_name.join("  ")

while start_date <= end_date
    current_day = start_date.day
    current_date = start_date
    wday_position = current_date.wday

    formatted_output =
        if current_day < 10
            " #{current_day}" # 一桁の場合、前にスペースを追加
        else
            "#{current_day}"
        end

    calendar_week[wday_position] = formatted_output

    if wday_position == 6   # 6=土曜日
        puts calendar_week.join("  ") #これまでに挿入してきた要素の値を2つのスペースを空けて出力する
        calendar_week = Array.new(7, "  ") #次の週に行くため、配列を初期化する
    end

    start_date = start_date.next_day
end