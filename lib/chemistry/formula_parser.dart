class FormulaParser {
  static Map<String,int> parse(String formula) {
    final source=formula.replaceAll(' ','');
    if(source.isEmpty) throw FormatException('A fórmula está vazia.');
    var index=0;
    int number() {
      final start=index;
      while(index<source.length && RegExp(r'[0-9]').hasMatch(source[index])) index++;
      if(start==index)return 1;
      final value=int.parse(source.substring(start,index));
      if(value<1)throw FormatException('Os índices devem ser positivos.');
      return value;
    }
    Map<String,int> group({bool nested=false}) {
      final result=<String,int>{};
      while(index<source.length && source[index]!=')') {
        if(source[index]=='(') {
          index++;
          final inner=group(nested:true);
          if(index>=source.length || source[index]!=')')throw FormatException('Parênteses não fechados.');
          index++;
          final multiplier=number();
          inner.forEach((k,v)=>result[k]=(result[k]??0)+v*multiplier);
        } else if(RegExp(r'[A-Z]').hasMatch(source[index])) {
          final start=index++;
          if(index<source.length && RegExp(r'[a-z]').hasMatch(source[index]))index++;
          final symbol=source.substring(start,index);
          final count=number();
          result[symbol]=(result[symbol]??0)+count;
        } else {
          throw FormatException('Carácter inesperado na fórmula: ${source[index]}');
        }
      }
      if(!nested && index<source.length)throw FormatException('Parêntese de fecho sem abertura.');
      return result;
    }
    final result=group();
    if(index!=source.length || result.isEmpty)throw FormatException('Fórmula química inválida.');
    return result;
  }
}
