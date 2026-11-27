import 'formula_parser.dart';

class _Q {
  final int n,d;
  _Q(int numerator,[int denominator=1]) : n = denominator<0 ? -numerator : numerator, d = denominator<0 ? -denominator : denominator {
    if(denominator==0) throw StateError('Divisão por zero');
  }
  static int gcd(int a,int b)=>b==0?a.abs():gcd(b,a%b);
  _Q norm() { final g=gcd(n,d); return _Q(n~/g,d~/g); }
  _Q operator +(_Q b)=>_Q(n*b.d+b.n*d,d*b.d).norm();
  _Q operator -(_Q b)=>_Q(n*b.d-b.n*d,d*b.d).norm();
  _Q operator *(_Q b)=>_Q(n*b.n,d*b.d).norm();
  _Q operator /(_Q b)=>_Q(n*b.d,d*b.n).norm();
  bool get zero=>n==0;
}
class EquationBalancer {
  static String balance(String input) {
    final normalized=input.replaceAll('→','->').replaceAll('⇒','->').replaceAll('⇌','->').replaceAll('=>','->').replaceAll('=','->').replaceAll('＋','+');
    final sides=normalized.split('->');
    if(sides.length!=2) throw FormatException('Separa reagentes e produtos com ->.');
    final left=sides[0].split('+').map((x)=>FormulaParser.normalize(x.trim())).toList();
    final right=sides[1].split('+').map((x)=>FormulaParser.normalize(x.trim())).toList();
    final formulas=[...left,...right];
    if(left.isEmpty||right.isEmpty||formulas.any((x)=>x.isEmpty)||formulas.length>10) throw FormatException('Número de substâncias inválido.');
    final parsed=formulas.map(FormulaParser.parse).toList();
    final elements=parsed.expand((m)=>m.keys).toSet().toList()..sort();
    if(elements.length>12) throw FormatException('Equação demasiado complexa para esta versão.');
    final matrix=elements.map((e)=>List.generate(formulas.length,(j)=>_Q((j<left.length?1:-1)*(parsed[j][e]??0)))).toList();
    final rows=matrix.length, cols=formulas.length;
    var pivotRow=0; final pivots=<int>[];
    for(var col=0;col<cols && pivotRow<rows;col++){
      var selected=pivotRow;
      while(selected<rows && matrix[selected][col].zero) selected++;
      if(selected==rows) continue;
      final temp=matrix[pivotRow]; matrix[pivotRow]=matrix[selected]; matrix[selected]=temp;
      final pivot=matrix[pivotRow][col];
      for(var c=0;c<cols;c++) matrix[pivotRow][c]=matrix[pivotRow][c]/pivot;
      for(var r=0;r<rows;r++) {
        if(r==pivotRow) continue;
        final factor=matrix[r][col];
        if(factor.zero) continue;
        for(var c=0;c<cols;c++) matrix[r][c]=matrix[r][c]-factor*matrix[pivotRow][c];
      }
      pivots.add(col); pivotRow++;
    }
    final free=List.generate(cols,(i)=>i).where((i)=>!pivots.contains(i)).toList();
    if(free.isEmpty) throw FormatException('Não existe solução não nula para esta equação.');
    List<int>? solution;
    // Test integer combinations for free variables; this covers common equations with one or two degrees of freedom.
    final limits=free.length==1?12:free.length==2?8:4;
    void search(int at,List<int> values) {
      if(solution!=null) return;
      if(at<free.length) {
        for(var v=1;v<=limits;v++){search(at+1,[...values,v]);if(solution!=null)return;}
        return;
      }
      final x=List<_Q>.filled(cols,_Q(0));
      for(var i=0;i<free.length;i++) x[free[i]]=_Q(values[i]);
      for(var r=0;r<pivots.length;r++){
        var sum=_Q(0);
        for(var c=0;c<cols;c++){if(c!=pivots[r])sum=sum+matrix[r][c]*x[c];}
        x[pivots[r]]=_Q(0)-sum;
      }
      if(x.any((v)=>v.n==0)) return;
      final sign=x.first.n<0?-1:1;
      final signed=x.map((v)=>v.n*sign).toList();
      if(signed.any((v)=>v<=0)) return;
      var lcm=1;
      for(final v in x){final d=v.d; lcm=(lcm~/_Q.gcd(lcm,d))*d;}
      final ints=x.map((v)=>v.n*(lcm~/v.d)*sign).toList();
      var g=ints.reduce(_Q.gcd);
      final reduced=ints.map((v)=>v~/g).toList();
      if(reduced.every((v)=>v>0)) solution=reduced;
    }
    search(0,[]);
    final coeff=solution;
    if(coeff==null) throw FormatException('Não foi encontrada solução inteira positiva. Verifica as fórmulas e o estado físico indicado.');
    String side(List<String> fs,int offset)=>List.generate(fs.length,(i)=>(coeff[offset+i]==1?'':coeff[offset+i].toString())+fs[i]).join(' + ');
    return side(left,0)+' → '+side(right,left.length);
  }
}
