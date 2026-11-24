class FormulaParser {
  static Map<String, int> parse(String formula) {
    final source = formula.replaceAll(' ', '');
    if (source.isEmpty) throw FormatException('A fórmula está vazia.');
    var index = 0;
    Map<String,int> group() {
      final result = <String,int>{};
      while (index < source.length && source[index] != ')') {
        if (source[index] == '(' || source[index] == '[') {
          final close = source[index] == '(' ? ')' : ']';
          index++;
          final nested = <String,int>{};
          while (index < source.length && source[index] != close) {
            if (RegExp(r'[A-Z]').hasMatch(source[index])) {
              final symbol = source[index++];
              if (index < source.length && RegExp(r'[a-z]').hasMatch(source[index])) {
                nested[symbol + source[index++]] = 1;
              } else { nested[symbol] = 1; }
              final start=index;
              while(index<source.length && RegExp(r'[0-9]').hasMatch(source[index])) index++;
              if(index>start) nested[symbol + (nested.keys.last.length>1 ? nested.keys.last.substring(1) : '')] = nested.values.last * int.parse(source.substring(start,index));
            } else if (source[index] == '(' || source[index] == '[') {
              final inner=group(); final multiplier=readNumber();
              inner.forEach((k,v)=>nested[k]=(nested[k]??0)+v*multiplier);
            } else { throw FormatException('Carácter inesperado na fórmula: ${source[index]}'); }
          }
          if(index>=source.length || source[index]!=close) throw FormatException('Parênteses não fechados na fórmula.');
          index++;
          final multiplier=readNumber();
          nested.forEach((k,v)=>result[k]=(result[k]??0)+v*multiplier);
        } else if (RegExp(r'[A-Z]').hasMatch(source[index])) {
          final start=index++;
          if(index<source.length && RegExp(r'[a-z]').hasMatch(source[index])) index++;
          final symbol=source.substring(start,index);
          final count=readNumber();
          result[symbol]=(result[symbol]??0)+count;
        } else { throw FormatException('Fórmula inválida perto de "${source[index]}".'); }
      }
      return result;
    }
    int readNumber() {
      final start=index;
      while(index<source.length && RegExp(r'[0-9]').hasMatch(source[index])) index++;
      if(start==index) return 1;
      final n=int.parse(source.substring(start,index));
      if(n<1) throw FormatException('Os índices devem ser positivos.');
      return n;
    }
    final parsed=group();
    if(index!=source.length || parsed.isEmpty) throw FormatException('Fórmula química inválida.');
    return parsed;
  }
}
