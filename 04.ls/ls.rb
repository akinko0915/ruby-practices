#!/usr/bin/env ruby
# frozen_string_literal: true

def display_table(rows, column_width)
  rows.each do |row|
    print row.each_with_index.map { |item, col_index| item.ljust(column_width[col_index] + 2) }.join
    puts
  end
end

def format_table(contents, col_count)
  row_count = (contents.size.to_f / col_count).ceil
  columns = contents.sort.each_slice(row_count).map { |col| col.fill('', col.size...row_count) }
  rows = columns.transpose
  col_widths = columns.map { |col| col.map(&:length).max }
  [rows, col_widths]
end

def display_directory_listing(col_count = 3)
  current_directory = Dir.pwd
  contents = Dir.children(current_directory)
  rows, widths = format_table(contents, col_count)
  display_table(rows, widths)
end

display_directory_listing
