#!/usr/bin/env ruby
require 'date'
require 'optparse'

def display_calendar(month, year)
    start_date = Date.new(year, month, 1)
    end_date = Date.new(year, month, -1)

    puts "      #{month}月 #{year}      "
    puts ["日", "月", "火", "水", "木", "金", "土"].join(" ")

    print "   " * start_date.wday

    (start_date..end_date).each do |date|
        print date.day.to_s.rjust(2) + " "
        puts if date.saturday?
    end
    puts
end

def get_calendar
    params = ARGV.getopts("m:y:")
    month = params["m"] ? params["m"].to_i : Date.today.month
    year = params["y"] ? params["y"].to_i : Date.today.year
    display_calendar(month, year)
end

get_calendar
