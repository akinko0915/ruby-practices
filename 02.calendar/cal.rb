#!/usr/bin/env ruby
require 'date'
require 'optparse'

def format_day(current_day)
    formatted_output =
        if current_day < 10
            " #{current_day}"
        else
            "#{current_day}"
        end
end

def display_calendar(month, year)
    start_date = Date.new(year, month, 1)
    end_date = Date.new(year, month, -1)
    calendar_week = Array.new(7, "  ")

    month_year = start_date.month.to_s + "月" + "　" + start_date.year.to_s
    puts month_year.center(25)
    week_name = ["日", "月", "火", "水", "木", "金", "土"]
    puts week_name.join("  ")

    while start_date <= end_date
        current_day = start_date.day
        current_date = start_date
        wday_position = current_date.wday

        formatted_output = format_day(current_day)
        calendar_week[wday_position] = formatted_output

        if wday_position == 6
            puts calendar_week.join("  ")
            calendar_week = Array.new(7, "  ")
        end
        start_date = start_date.next_day
    end

    unless calendar_week.empty?
        puts calendar_week.join("  ")
    end
end

def get_calendar
    params = ARGV.getopts("m:y:")
    if params["m"]
        month = params["m"].to_i
    else
        month = Date.today.month
    end
    if params["y"]
        year = params["y"].to_i
    else
        year = Date.today.year
    end

    display_calendar(month, year)
end

get_calendar()