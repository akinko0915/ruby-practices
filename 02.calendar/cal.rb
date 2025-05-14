#!/usr/bin/env ruby
require 'date'

start_date = Date.new(2025, 5, 1)
end_date = Date.new(2025, 5, -1)

while start_date <= end_date
    print start_date.day, "  "
    start_date = start_date.next_day
end