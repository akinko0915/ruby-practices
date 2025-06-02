#!/usr/bin/env ruby
def display_table(rows, column_width)
  rows.each do |row|
    row.each_with_index do |item, col_index|
      print item.ljust(column_width[col_index] + 2)
    end
    puts
  end
end

def format_table(contents, col_count)
  row_count = (contents.size.to_f / col_count).ceil
  sorted_contents = contents.sort
  columns = sorted_contents.each_slice(row_count).to_a;
  rows = columns.each{ |col| col[row_count - 1] = " " if col.length < row_count }.transpose
  column_width = columns.map do |col|
    length_array = col.map do |c|
      c.length
    end
    length_array.max
  end
  [rows, column_width]
end

def display_directory_listing(col_count = 3)
  current_directory = Dir.pwd
  contents = Dir.children(current_directory)
  rows, widths = format_table(contents, col_count);
  display_table(rows, widths)
end

display_directory_listing
