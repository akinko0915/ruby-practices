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

  # 縦(列)の幅(列の中で1番長いファイル/ディレクトリの名前の長さ)を決める
  column_width = columns.map do |col|
    length_array = col.map do |c|
      c.length
    end
    length_array.max
  end
  # 横 (行)で分割 (指定した配列の長さまでなかったら最後尾に空白の要素を入れる)
  rows = columns.each{ |col| col[row_count - 1] = " " if col.length < row_count }.transpose

  # 各行ずつ表示していく
  rows.each do |row|
    row.each_with_index do |item, col_index|
      print item.ljust(column_width[col_index] + 2)
    end
    puts
  end
end

format_columns(contents, row_number);
