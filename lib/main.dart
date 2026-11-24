import 'package:flutter/material.dart';

void main() => runApp(const ChemMasterApp());

const navy = Color(0xFF06142F), blue = Color(0xFF087BFF), cyan = Color(0xFF16D9F5), violet = Color(0xFF762BFF);

class ChemMasterApp extends StatefulWidget {
  const ChemMasterApp({super.key});
  @override State<ChemMasterApp> createState() => _ChemMasterAppState();
}
class _ChemMasterAppState extends State<ChemMasterApp> {
  bool dark = true;
  @override Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false, title: 'ChemMaster',
    theme: ThemeData(useMaterial3: true, brightness: dark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: dark ? navy : const Color(0xFFF3F7FF),
      colorScheme: ColorScheme.fromSeed(seedColor: blue, brightness: dark ? Brightness.dark : Brightness.light)),
    home: Shell(dark: dark, toggle: () => setState(() => dark = !dark)));
}

class Shell extends StatefulWidget {
  final bool dark; final VoidCallback toggle;
  const Shell({super.key, required this.dark, required this.toggle});
  @override State<Shell> createState() => _ShellState();
}
class _ShellState extends State<Shell> {
  int tab = 0;
  @override Widget build(BuildContext context) {
    final pages = [HomePage(open: (i) => setState(() => tab = i)), const AcademyPage(), const ToolsPage(), const ProgressPage(), SettingsPage(dark: widget.dark, toggle: widget.toggle)];
    return Scaffold(body: SafeArea(child: IndexedStack(index: tab, children: pages)),
      bottomNavigationBar: NavigationBar(selectedIndex: tab, onDestinationSelected: (i) => setState(() => tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Início'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'Academia'),
          NavigationDestination(icon: Icon(Icons.science_outlined), label: 'Ferramentas'),
          NavigationDestination(icon: Icon(Icons.insights_outlined), label: 'Progresso'),
          NavigationDestination(icon: Icon(Icons.more_horiz), label: 'Mais')]));
  }
}

class HomePage extends StatelessWidget {
  final ValueChanged<int> open;
  const HomePage({super.key, required this.open});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    Row(children: [const CircleAvatar(radius: 25, backgroundColor: blue, child: Icon(Icons.biotech, color: Colors.white, size: 30)), const SizedBox(width: 12),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('ChemMaster', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)), Text('Aprender • Praticar • Conquistar', style: TextStyle(color: cyan))]))]),
    const SizedBox(height: 22),
    Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), gradient: const LinearGradient(colors: [Color(0xFF0756C9), Color(0xFF32117D), Color(0xFF091B43)])),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('A química começa aqui.', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)), SizedBox(height: 8), Text('Estuda, experimenta e compreende o mundo à tua volta.'), SizedBox(height: 16), Row(children: [Icon(Icons.offline_bolt, color: Colors.amber), SizedBox(width: 8), Text('Pensado para funcionar offline')])])),
    const SizedBox(height: 22), const Text('Explorar ChemMaster', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)), const SizedBox(height: 10),
    GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.5, children: [
      QuickCard(icon: Icons.menu_book, title: 'Academia', detail: 'Aulas e capítulos', color: blue, tap: () => open(1)),
      QuickCard(icon: Icons.functions, title: 'Equações', detail: 'Balancear reações', color: violet, tap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BalancePage()))),
      QuickCard(icon: Icons.calculate, title: 'Calculadoras', detail: 'Massa molar', color: cyan, tap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CalculatorPage()))),
      QuickCard(icon: Icons.grid_on, title: 'Tabela periódica', detail: 'Elementos químicos', color: Colors.orange, tap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PeriodicPage())))]),
    const SizedBox(height: 18), const InfoTile(icon: Icons.water_drop, title: 'Ácidos, bases e sais', subtitle: 'Funções inorgânicas', color: cyan),
    const InfoTile(icon: Icons.sync_alt, title: 'Reações químicas', subtitle: 'Tipos, produtos e equações', color: violet)]);
}

class QuickCard extends StatelessWidget {
  final IconData icon; final String title, detail; final Color color; final VoidCallback tap;
  const QuickCard({super.key, required this.icon, required this.title, required this.detail, required this.color, required this.tap});
  @override Widget build(BuildContext context) => Card(child: InkWell(onTap: tap, borderRadius: BorderRadius.circular(18), child: Padding(padding: const EdgeInsets.all(14), child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: color, size: 28), const SizedBox(height: 8), Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), Text(detail, style: const TextStyle(fontSize: 11, color: Colors.grey))]))));
}
class InfoTile extends StatelessWidget {
  final IconData icon; final String title, subtitle; final Color color;
  const InfoTile({super.key, required this.icon, required this.title, required this.subtitle, required this.color});
  @override Widget build(BuildContext context) => Card(child: ListTile(leading: CircleAvatar(backgroundColor: color.withValues(alpha: .15), child: Icon(icon, color: color)), title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(subtitle), trailing: const Icon(Icons.chevron_right)));
}

class AcademyPage extends StatelessWidget {
  const AcademyPage({super.key});
  @override Widget build(BuildContext context) {
    final topics = ['Fundamentos da Química','Estrutura do átomo','Tabela periódica','Ligações químicas','Funções inorgânicas','Reações químicas','Nomenclatura','Estequiometria'];
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Academia', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
      const Text('Percurso de aprendizagem para Moçambique.'),
      const SizedBox(height: 14),
      Wrap(spacing: 7, children: ['7.ª','8.ª','9.ª','10.ª','11.ª','12.ª'].map((s) => ChoiceChip(label: Text(s), selected: s == '10.ª', onSelected: (_) {})).toList()),
      const SizedBox(height: 12),
      ...topics.map((t) => Card(child: ListTile(leading: const Icon(Icons.science, color: cyan), title: Text(t), subtitle: const Text('Aulas • Exemplos • Exercícios'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TopicPage(title: t)))))),
      const Text('A distribuição por classe será validada com os programas oficiais.', style: TextStyle(color: Colors.amber, fontSize: 12))]);
  }
}
class TopicPage extends StatelessWidget {
  final String title; const TopicPage({super.key, required this.title});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(title)), body: ListView(padding: const EdgeInsets.all(20), children: const [
    Text('Unidade de aprendizagem', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    Text('Esta área receberá teoria, exemplos resolvidos, exercícios e avaliação.'),
    InfoTile(icon: Icons.menu_book, title: 'Conceitos fundamentais', subtitle: 'Lição e definições', color: blue),
    InfoTile(icon: Icons.lightbulb_outline, title: 'Exemplos resolvidos', subtitle: 'Raciocínio passo a passo', color: Colors.orange),
    InfoTile(icon: Icons.edit_note, title: 'Praticar', subtitle: 'Exercícios de aplicação', color: violet)]) );
}

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});
  @override Widget build(BuildContext context) {
    final entries = <(String,String,IconData,Widget)>[
      ('Balancear equações','Ajusta coeficientes',Icons.functions,const BalancePage()),
      ('Calculadora química','Massa molar',Icons.calculate,const CalculatorPage()),
      ('Tabela periódica','Elementos e propriedades',Icons.grid_on,const PeriodicPage()),
      ('Tipos de reações','Classificação de reações',Icons.sync_alt,const ReactionPage()),
      ('Nomenclatura','Óxidos, ácidos, bases e sais',Icons.spellcheck,const NomenclaturePage()),
      ('Laboratório virtual','Demonstrações educativas',Icons.biotech,const LabPage())];
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Ferramentas', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
      const Text('Instrumentos para estudar e praticar química.'),
      const SizedBox(height: 12),
      ...entries.map((e) => Card(child: ListTile(leading: Icon(e.$3, color: cyan, size: 29), title: Text(e.$1), subtitle: Text(e.$2), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => e.$4)))))]);
  }
}

class BalancePage extends StatefulWidget { const BalancePage({super.key}); @override State<BalancePage> createState() => _BalancePageState(); }
class _BalancePageState extends State<BalancePage> {
  final input = TextEditingController(text: 'H2 + O2 -> H2O'); String result = ''; String error = '';
  void run() { try { setState(() { result = Balancer.balance(input.text); error = ''; }); } catch (e) { setState(() { result = ''; error = e.toString(); }); } }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Balancear equação')), body: ListView(padding: const EdgeInsets.all(20), children: [
    const Text('Escreve uma equação química', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    const Text('Exemplo: H2 + O2 -> H2O'), const SizedBox(height: 14),
    TextField(controller: input, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Equação')),
    const SizedBox(height: 12), FilledButton.icon(onPressed: run, icon: const Icon(Icons.auto_fix_high), label: const Text('Balancear')),
    if (result.isNotEmpty) Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Resultado', style: TextStyle(color: cyan)), const SizedBox(height: 8), SelectableText(result, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const Text('O número de átomos de cada elemento fica igual nos dois lados.')]))),
    if (error.isNotEmpty) Text(error, style: const TextStyle(color: Colors.redAccent))]));
}
class Balancer {
  static Map<String,int> parse(String f) {
    final map = <String,int>{}; final re = RegExp(r'([A-Z][a-z]?)([0-9]*)'); int end = 0;
    for (final m in re.allMatches(f)) { if (m.start != end) throw Exception('Fórmula não suportada: ' + f); final el = m.group(1)!; map[el] = (map[el] ?? 0) + (int.tryParse(m.group(2)!) ?? 1); end = m.end; }
    if (end != f.length || map.isEmpty) throw Exception('Fórmula inválida: ' + f); return map;
  }
  static int gcd(int a,int b) => b == 0 ? a : gcd(b,a%b);
  static String balance(String raw) {
    final sides = raw.replaceAll('→','->').split('->'); if (sides.length != 2) throw Exception('Usa -> para separar reagentes e produtos.');
    final l = sides[0].split('+').map((s)=>s.trim()).toList(), r = sides[1].split('+').map((s)=>s.trim()).toList();
    final fs = [...l,...r]; if (fs.any((s)=>s.isEmpty) || fs.length > 6) throw Exception('Equação inválida ou demasiado longa.');
    final maps = fs.map(parse).toList(), els = maps.expand((m)=>m.keys).toSet().toList(); if (els.length > 8) throw Exception('Equação demasiado complexa.');
    final coeff = List<int>.filled(fs.length,1); final n=l.length;
    for (int max=1; max<=10; max++) {
      String? answer;
      void search(int at) {
        if (answer != null) return;
        if (at == coeff.length) {
          for (final e in els) { int sum=0; for (int i=0;i<coeff.length;i++) { sum += (i<n?1:-1)*(maps[i][e]??0)*coeff[i]; } if (sum != 0) return; }
          int g=coeff.reduce(gcd); if (g != 1) return;
          final left = List.generate(n,(i)=>(coeff[i]==1?'':coeff[i].toString())+fs[i]).join(' + ');
          final right = List.generate(r.length,(i)=>(coeff[n+i]==1?'':coeff[n+i].toString())+fs[n+i]).join(' + ');
          answer = left + ' → ' + right; return;
        }
        for (int c=1;c<=max;c++) { coeff[at]=c; search(at+1); if (answer != null) return; }
      }
      search(0); if (answer != null) return answer!;
    }
    throw Exception('Não foi possível balancear com coeficientes até 10. Verifica as fórmulas.');
  }
}

class CalculatorPage extends StatefulWidget { const CalculatorPage({super.key}); @override State<CalculatorPage> createState()=>_CalculatorPageState(); }
class _CalculatorPageState extends State<CalculatorPage> {
  final formula=TextEditingController(text:'H2SO4'); String mass='—', detail='';
  static const weights={'H':1.008,'He':4.003,'Li':6.94,'Be':9.012,'B':10.81,'C':12.011,'N':14.007,'O':15.999,'F':18.998,'Ne':20.180,'Na':22.990,'Mg':24.305,'Al':26.982,'Si':28.085,'P':30.974,'S':32.06,'Cl':35.45,'K':39.098,'Ca':40.078,'Fe':55.845,'Cu':63.546,'Zn':65.38,'Br':79.904,'Ag':107.868,'I':126.904};
  void calc(){try{final atoms=Balancer.parse(formula.text.trim()); double total=0; final lines=<String>[]; atoms.forEach((e,n){final w=weights[e]; if(w==null) throw Exception('Massa atómica indisponível para '+e); total+=w*n; lines.add(e+': '+n.toString()+' × '+w.toString());}); setState(() { mass=total.toStringAsFixed(2)+' g/mol'; detail=lines.join('\\n'); });}catch(e){setState(() { mass='Erro'; detail=e.toString(); });}}
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Calculadora química')),body:ListView(padding:const EdgeInsets.all(20),children:[
    const Text('Calculadora de massa molar',style:TextStyle(fontSize:21,fontWeight:FontWeight.bold)),const Text('Introduz uma fórmula simples, por exemplo H2SO4.'),const SizedBox(height:14),
    TextField(controller:formula,decoration:const InputDecoration(labelText:'Fórmula química',border:OutlineInputBorder())),const SizedBox(height:12),
    FilledButton.icon(onPressed:calc,icon:const Icon(Icons.calculate),label:const Text('Calcular')),
    Card(child:Padding(padding:const EdgeInsets.all(18),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Massa molar'),Text(mass,style:const TextStyle(fontSize:27,fontWeight:FontWeight.bold,color:cyan)),const Divider(),const Text('Detalhes'),SelectableText(detail)]))),
    const Text('Limitação inicial: fórmulas sem parênteses e elementos incluídos na tabela de massas desta versão.',style:TextStyle(fontSize:12,color:Colors.amber))]));
}

class PeriodicPage extends StatelessWidget {
  const PeriodicPage({super.key});
  static const data=[('H','Hidrogénio',1,'1.008'),('He','Hélio',2,'4.003'),('Li','Lítio',3,'6.94'),('Be','Berílio',4,'9.012'),('B','Boro',5,'10.81'),('C','Carbono',6,'12.011'),('N','Azoto',7,'14.007'),('O','Oxigénio',8,'15.999'),('F','Flúor',9,'18.998'),('Ne','Néon',10,'20.180'),('Na','Sódio',11,'22.990'),('Mg','Magnésio',12,'24.305'),('Al','Alumínio',13,'26.982'),('Si','Silício',14,'28.085'),('P','Fósforo',15,'30.974'),('S','Enxofre',16,'32.06'),('Cl','Cloro',17,'35.45'),('Ar','Árgon',18,'39.948'),('K','Potássio',19,'39.098'),('Ca','Cálcio',20,'40.078'),('Fe','Ferro',26,'55.845'),('Cu','Cobre',29,'63.546'),('Zn','Zinco',30,'65.38'),('Ag','Prata',47,'107.868')];
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Tabela periódica')),body:ListView(padding:const EdgeInsets.all(16),children:[
    const Text('Elementos químicos',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),const Text('Amostra inicial; serão adicionados os 118 elementos.'),
    GridView.builder(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),itemCount:data.length,gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:4,crossAxisSpacing:8,mainAxisSpacing:8,childAspectRatio:1.05),itemBuilder:(context,i){final e=data[i];return Card(child:InkWell(onTap:()=>showDialog(context:context,builder:(_)=>AlertDialog(title:Text(e.$1+' — '+e.$2),content:Text('Número atómico: '+e.$3.toString()+'\nMassa atómica: '+e.$4+' u'))),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text(e.$3.toString(),style:const TextStyle(fontSize:10)),Text(e.$1,style:const TextStyle(fontSize:23,fontWeight:FontWeight.bold,color:cyan)),Text(e.$2,style:const TextStyle(fontSize:10),overflow:TextOverflow.ellipsis)])));})]));
}

class ReactionPage extends StatelessWidget {
  const ReactionPage({super.key});
  @override Widget build(BuildContext context){final rows=[('Síntese','A + B → AB','2H₂ + O₂ → 2H₂O'),('Decomposição','AB → A + B','2H₂O₂ → 2H₂O + O₂'),('Deslocamento simples','A + BC → AC + B','Zn + 2HCl → ZnCl₂ + H₂'),('Dupla troca','AB + CD → AD + CB','AgNO₃ + NaCl → AgCl + NaNO₃'),('Neutralização','Ácido + Base → Sal + Água','HCl + KOH → KCl + H₂O')];return Scaffold(appBar:AppBar(title:const Text('Tipos de reações')),body:ListView(padding:const EdgeInsets.all(18),children:[const Text('Reconhece os padrões das transformações químicas.',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),...rows.map((r)=>Card(child:ListTile(leading:const Icon(Icons.science,color:cyan),title:Text(r.$1),subtitle:Text(r.$2+'\nEx.: '+r.$3))))]));}
}

class NomenclaturePage extends StatefulWidget {const NomenclaturePage({super.key});@override State<NomenclaturePage> createState()=>_NomenclaturePageState();}
class _NomenclaturePageState extends State<NomenclaturePage>{
  String selected='Óxidos';
  final data={'Óxidos':('Compostos binários do oxigénio com outro elemento.',['CO2 — dióxido de carbono','SO3 — trióxido de enxofre','Fe2O3 — óxido de ferro (III)']),'Ácidos':('Substâncias que podem libertar H+ em solução aquosa.',['HCl — ácido clorídrico','H2SO4 — ácido sulfúrico','HNO3 — ácido nítrico']),'Bases':('Bases de Arrhenius libertam OH− em solução aquosa.',['NaOH — hidróxido de sódio','KOH — hidróxido de potássio','Ca(OH)2 — hidróxido de cálcio']),'Sais':('Compostos iónicos formados por catiões e aniões.',['NaCl — cloreto de sódio','KCl — cloreto de potássio','CaCO3 — carbonato de cálcio'])};
  @override Widget build(BuildContext context){final d=data[selected]!;return Scaffold(appBar:AppBar(title:const Text('Nomenclatura química')),body:ListView(padding:const EdgeInsets.all(18),children:[
    Wrap(spacing:6,children:data.keys.map((k)=>ChoiceChip(label:Text(k),selected:selected==k,onSelected:(_)=>setState(()=>selected=k))).toList()),
    Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(selected,style:const TextStyle(fontSize:22,fontWeight:FontWeight.bold,color:cyan)),Text(d.$1)]))),
    const Text('Exemplos',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),...d.$2.map((s)=>Card(child:ListTile(leading:const Icon(Icons.check_circle_outline,color:cyan),title:Text(s))))]));}
}

class LabPage extends StatefulWidget {const LabPage({super.key});@override State<LabPage> createState()=>_LabPageState();}
class _LabPageState extends State<LabPage>{bool mixed=false;
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Laboratório virtual')),body:ListView(padding:const EdgeInsets.all(20),children:[
    Container(height:170,decoration:BoxDecoration(borderRadius:BorderRadius.circular(22),gradient:const LinearGradient(colors:[Color(0xFF092F71),Color(0xFF06152F)])),child:const Center(child:Icon(Icons.science,size:100,color:cyan))),
    const SizedBox(height:14),const Text('Demonstração de neutralização',style:TextStyle(fontSize:21,fontWeight:FontWeight.bold)),const Text('Simulação conceptual de HCl com KOH. Não é uma experiência física real.'),
    const InfoTile(icon:Icons.water_drop,title:'HCl',subtitle:'Ácido clorídrico',color:blue),const InfoTile(icon:Icons.science,title:'KOH',subtitle:'Hidróxido de potássio',color:violet),
    FilledButton(onPressed:()=>setState(()=>mixed=!mixed),child:Text(mixed?'Reiniciar':'Misturar reagentes')),
    if(mixed) const Card(child:Padding(padding:EdgeInsets.all(18),child:Text('HCl + KOH → KCl + H₂O\nForma-se cloreto de potássio e água.',style:TextStyle(fontSize:19,color:cyan))))]));}
}

class ProgressPage extends StatelessWidget {const ProgressPage({super.key});@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(20),children:const[
  Text('O teu progresso',style:TextStyle(fontSize:27,fontWeight:FontWeight.w900)),Text('O histórico de aprendizagem será guardado neste dispositivo.'),
  InfoTile(icon:Icons.menu_book,title:'Lições concluídas',subtitle:'Ainda sem registos',color:blue),InfoTile(icon:Icons.quiz,title:'Exercícios resolvidos',subtitle:'Ainda sem registos',color:violet),InfoTile(icon:Icons.emoji_events,title:'Conquistas',subtitle:'As tuas conquistas aparecerão aqui',color:Colors.orange)]);}
class SettingsPage extends StatelessWidget {final bool dark;final VoidCallback toggle;const SettingsPage({super.key,required this.dark,required this.toggle});@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(20),children:[
  const Text('Mais',style:TextStyle(fontSize:27,fontWeight:FontWeight.w900)),Card(child:SwitchListTile(value:dark,onChanged:(_)=>toggle(),title:const Text('Modo escuro'),secondary:const Icon(Icons.dark_mode))),
  const Card(child:ListTile(leading:Icon(Icons.language),title:Text('Idioma'),subtitle:Text('Português — inicial'))),const Card(child:ListTile(leading:Icon(Icons.download_for_offline),title:Text('Conteúdos offline'),subtitle:Text('Preparado para pacotes locais.')))]);}
