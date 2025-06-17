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
  contents = Dir.entries(current_directory).sort
  contents = contents.reverse if options[:r]
  contents = contents.reject { |name| name.start_with?('.') } unless options[:a]
  rows, col_widths = format_as_table(contents, col_count)
  display_filenames_table(rows, col_widths)
end

def extract_options
  options = {
    a: false,
    r: false
  }
  opts = OptionParser.new do |opt|
    opt.on('-a', 'Show all files') { options[:a] = true }
    opt.on('-r', 'Reverse file order') { options[:r] = true }
  end
  opts.parse!
  options
end

options = extract_options
display_filenames(DEFAULT_COLUMN_COUNT, options)
