#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

DEFAULT_COLUMN_COUNT = 3
CONVERT_FILE_TYPE = {
  '01' => 'p',
  '02' => 'c',
  '04' => 'd',
  '06' => 'b',
  '10' => '-',
  '12' => 'l',
  '14' => 's'
}.freeze

CONVERT_FILE_MODE = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

RIGHT_ALIGN_KEYS = %i[nlink size month day time].freeze

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

def mode_to_symbolic(mode)
  file_type = CONVERT_FILE_TYPE[mode[0...2]]
  special_privilege = mode[2].to_i

  user_perm = CONVERT_FILE_MODE[mode[3]].dup
  group_perm = CONVERT_FILE_MODE[mode[4]].dup
  other_perm = CONVERT_FILE_MODE[mode[5]].dup

  suid   = (special_privilege & 0b100) != 0
  sgid   = (special_privilege & 0b010) != 0
  sticky = (special_privilege & 0b001) != 0

  if suid
    user_perm[-1] = user_perm[-1] == 'x' ? 's' : 'S'
  end

  if sgid
    group_perm[-1] = group_perm[-1] == 'x' ? 's' : 'S'
  end

  if sticky
    other_perm[-1] = other_perm[-1] == 'x' ? 't' : 'T'
  end

  file_type + user_perm + group_perm + other_perm
end

def format_file_data(file_data)
  keys = file_data.first.keys
  max_width = keys.each_with_object({}) do |key, hash|
    hash[key] = file_data.map { |d| d[key].to_s.size }.max
  end

  file_data.map do |f|
    keys.map do |key|
      data = f[key].to_s
      RIGHT_ALIGN_KEYS.include?(key) ? data.rjust(max_width[key]) : data.ljust(max_width[key])
    end.join(' ')
  end
end

def extract_file_data(contents)
  total_blocks = 0
  file_data = []
  contents.map do |file|
    file_info = File.lstat(file)
    mode = mode_to_symbolic(file_info.mode.to_s(8).rjust(6, '0'))
    nlink = file_info.nlink
    owner_name = Etc.getpwuid(file_info.uid).name + ' '
    group_name = Etc.getgrgid(file_info.gid).name + ' '
    size = file_info.size.to_i
    total_blocks += file_info.blocks
    mtime = file_info.mtime
    month = mtime.month.to_s.rjust(2, ' ')
    day = mtime.day
    time = "#{mtime.hour.to_s.rjust(2, '0')}:#{mtime.min.to_s.rjust(2, '0')}"
    file_data << { mode:, nlink:, owner_name:, group_name:, size:, month:, day:, time:, file: }
  end

  total_blocks = "total #{total_blocks}"
  file_data = { total_blocks:, file_info: format_file_data(file_data) }
end

def display_filenames(col_count, options)
  current_directory = Dir.pwd
  contents = Dir.entries(current_directory).sort
  contents = contents.reverse if options[:r]
  contents = contents.reject { |name| name.start_with?('.') } unless options[:a]
  if options[:l]
    file_data = extract_file_data(contents)
    puts file_data[:total_blocks]
    puts file_data[:file_info]
    return
  end

  rows, col_widths = format_as_table(contents, col_count)
  display_filenames_table(rows, col_widths)
end

def extract_options
  options = {
    a: false,
    r: false,
    l: false
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
