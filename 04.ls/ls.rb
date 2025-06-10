#!/usr/bin/env ruby
# frozen_string_literal: true
require 'optparse'
DEFAULT_COLUMN_COUNT = 3

def display_filenames_table(rows, col_widths)
  rows.each do |row|
    print row.each_with_index.map { |item, col_index| item.ljust(col_widths[col_index] + 2) }.join
    puts
  end
end

def format_as_table(contents, col_count)
  return [[], []] if contents.empty?
  row_count = (contents.size.to_f / col_count).ceil
  columns = contents.each_slice(row_count).map { |col| col.fill('', col.size...row_count) }
  rows = columns.transpose
  col_widths = columns.map { |col| col.map(&:length).max }
  [rows, col_widths]
end

def display_filenames(col_count, options)
  current_directory = Dir.pwd
  contents = Dir.children(current_directory).sort
  contents = contents.reject { |name| name.start_with?('.') } unless options[:a]
  rows, col_widths = format_as_table(contents, col_count)
  display_filenames_table(rows, col_widths)
end

options = {
  a: false
}
opts = OptionParser.new do |opt|
  opt.on('-a', '--all', "Show all files") do
    options[:a] = true
  end
end
opts.parse!

display_filenames(DEFAULT_COLUMN_COUNT, options)
