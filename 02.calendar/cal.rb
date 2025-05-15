#!/usr/bin/env ruby
require 'date'
require 'optparse'

def format_day(current_day)
    if current_day < 10
        " #{current_day}"
    else
        "#{current_day}"
    end
end

def display_calendar(month, year)
    week_names = ["日", "月", "火", "水", "木", "金", "土"]
    spacing = " "
    calendar_width = week_names.join(spacing).length
    start_date = Date.new(year, month, 1)
    end_date = Date.new(year, month, -1)
    calendar_week = Array.new(7, "  ")

    puts "#{month}月 #{year}".center(calendar_width)
    puts week_names.join(spacing)

    while start_date <= end_date
        wday_position = start_date.wday
        calendar_week[wday_position] = format_day(start_date.day)

        if wday_position == 6
            puts calendar_week.join(spacing)
            calendar_week = Array.new(7, "  ")
        end
        start_date = start_date.next_day
    end

    unless calendar_week.empty?
        puts calendar_week.join(spacing)
    end
end

def get_calendar
    params = ARGV.getopts("m:y:")
    month = params["m"] ? params["m"].to_i : Date.today.month
    year = params["y"] ? params["y"].to_i : Date.today.year
    display_calendar(month, year)
end

get_calendar()