require './Converter.rb'

arr = ['ruby','rails','perl','psgi']
converter = Context.new(Comma_Converter.new())

puts '1.カンマコンバーターの出力'
converter.output_line(arr)

puts "\n"

converter.set_converter(Tab_Converter.new())
puts '2.タブコンバーターの出力'
converter.output_line(arr)
