#!/usr/bin/env ruby
# 1. カレントディレクトリ取得機能を実装
current_directory = Dir.pwd

# 2. ディレクトリ内容取得機能を実装
contents = Dir.children(current_directory)
puts contents