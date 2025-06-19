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
  if options[:l]
    # contentsの中身を一つずつ見ていく
    # mode, nlink, uid, gid, size, mtimeを文字列で結合させたものに変換する
    #　変換したものを配列にする
    contents.map do |path|
      content_info = File::Stat.new(path)
      mode = mode_to_symbolic(content_info.mode.to_s(8).rjust(6, '0'))
      puts mode
    end
  end
  rows, col_widths = format_as_table(contents, col_count)
  display_filenames_table(rows, col_widths)
end

def mode_to_symbolic(mode)
  convert_file_type = {
    '01' => 'p',
    '02' => 'c',
    '04' => 'd',
    '06' => 'b',
    '10' => '-',
    '12' => 'l',
    '14' => 's'
  }

  convert_file_mode = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }

  file_type = convert_file_type[mode[0...2]]
  special_privilege = mode[2].to_i

  user_perm = convert_file_mode[mode[3]]
  group_perm = convert_file_mode[mode[4]]
  other_perm = convert_file_mode[mode[5]]

  suid   = (special_privilege & 0b100) != 0
  sgid   = (special_privilege & 0b010) != 0
  sticky = (special_privilege & 0b001) != 0

  if suid
    user_perm[-1] == "x" ? user_perm[-1] = "s" : user_perm[-1] = "S"
  end

  if sgid
    group_perm[-1] == "x" ? group_perm[-1] = "s" : group_perm[-1] = "S"
  end

  if sticky
    other_perm[-1] == "x" ? other_perm[-1] = "t" : other_perm[-1] = "T"
  end

  file_type + user_perm + group_perm + other_perm
end

def extract_options
  options = {
    a: false,
    r: false,
    l: false,
  }
  opts = OptionParser.new do |opt|
    opt.on('-a', 'Show all files') { options[:a] = true }
    opt.on('-r', 'Reverse file order') { options[:r] = true }
    opt.on('-l', 'Long listing format') { options[:l] = true }
  end
  opts.parse!
  options
end

options = extract_options
display_filenames(DEFAULT_COLUMN_COUNT, options)
