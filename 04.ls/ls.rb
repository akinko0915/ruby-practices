#!/usr/bin/env ruby
# frozen_string_literal: true

def display_filenames_table(rows, col_widths)
  rows.each do |row|
    print row.each_with_index.map { |item, col_index| item.ljust(col_widths[col_index] + 2) }.join
    puts
  end
end

def format_as_table(contents, col_count)
  row_count = (contents.size.to_f / col_count).ceil
  columns = contents.sort.each_slice(row_count).map { |col| col.fill('', col.size...row_count) }
  rows = columns.transpose
  col_widths = columns.map { |col| col.map(&:length).max }
  [rows, col_widths]
end

def display_filenames(col_count = 3)
  current_directory = Dir.pwd
  contents = Dir.children(current_directory).reject { |name| name.start_with?('.') }
  rows, col_widths = format_as_table(contents, col_count)
  display_filenames_table(rows, col_widths)
end

display_filenames
