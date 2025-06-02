#!/usr/bin/env ruby
# 1. カレントディレクトリ取得機能を実装
current_directory = Dir.pwd

# 2. ディレクトリ内容取得機能を実装
contents = Dir.children(current_directory)
row_number = 3

# 3. 表示形式を整える
def format_columns(contents, column_number)
  # 要素数から行数を計算
  row_count = (contents.size.to_f / column_number).ceil
  sorted_contents = contents.sort

  # 縦(列)で分割
  columns = sorted_contents.each_slice(row_count).to_a;
  # 横 (行)で分割
  rows = columns.transpose

  rows.each do |row|
    puts row.join(" ")
  end
end

format_columns(contents, row_number);
