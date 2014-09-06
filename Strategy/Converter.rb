#インターフェースとなる抽象クラス
cass AbsConverter
  def output_line(arr)
    raise "this method is abstract class method!!"
  end
end

#具象クラス カンマ出力
class Comma_Converter < AbsConverter
  def output_line(arr)
    puts arr.join(',')
  end
end

#具象クラス タブ出力
class Tab_Converter < AbsConverter
  def output_line(arr)
    puts arr.join("\t")
  end
end

#切り替えクラス
class Context
  def initialize(converter)
    @converter = converter
  end
  def set_converter(converter)
    @converter = converter
  end
  def output_line(arr)
    @converter.output_line(arr)
  end
end

