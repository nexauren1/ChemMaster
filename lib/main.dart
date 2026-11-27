import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/chem_language.dart';
import 'widgets/chemical_picker.dart';
import 'screens/reaction_workbench.dart';
import 'screens/advanced_chemistry_screens.dart';
import 'chemistry/formula_parser.dart';
import 'data/curriculum.dart';
import 'data/periodic_elements.dart';
import 'data/quiz_bank.dart';
import 'data/curriculum_localization.dart';
import 'data/quiz_bank_localization.dart';
import 'services/progress_store.dart';

void main() => runApp(const ChemMasterApp());
const navy=Color(0xFF06142F),blue=Color(0xFF087BFF),cyan=Color(0xFF16D9F5),violet=Color(0xFF762BFF);
Route<T> neonRoute<T>(Widget page)=>PageRouteBuilder<T>(
  pageBuilder:(context,animation,secondaryAnimation)=>page,
  transitionDuration:const Duration(milliseconds:280),
  transitionsBuilder:(context,animation,secondaryAnimation,child){
    final curved=CurvedAnimation(parent:animation,curve:Curves.easeOutCubic);
    return FadeTransition(opacity:curved,child:ScaleTransition(
      scale:Tween<double>(begin:.975,end:1).animate(curved),child:child));
  },
);


class ChemMasterApp extends StatefulWidget {
  const ChemMasterApp({super.key});
  @override State<ChemMasterApp> createState()=>_ChemMasterAppState();
}
class _ChemMasterAppState extends State<ChemMasterApp> {
  bool dark=true;
  String language='pt';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final saved = prefs.getString('chemmaster.language') ?? 'pt';
      if (mounted && (saved == 'pt' || saved == 'en')) {
        setState(() => language = saved);
      }
    });
  }

  Future<void> changeLanguage(String value) async {
    if (value != 'pt' && value != 'en') return;
    setState(() => language = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('chemmaster.language', value);
  }

  @override Widget build(BuildContext context)=>MaterialApp(
    locale:Locale(language),
    supportedLocales:const [Locale('pt'),Locale('en')],
    debugShowCheckedModeBanner:false,title:'ChemMaster',
    theme:ThemeData(
      useMaterial3:true,
      brightness:dark?Brightness.dark:Brightness.light,
      colorScheme:ColorScheme.fromSeed(seedColor:blue,brightness:dark?Brightness.dark:Brightness.light,primary:blue,secondary:cyan,tertiary:violet,surface:dark?const Color(0xFF0B1D43):Colors.white),
      scaffoldBackgroundColor:dark?navy:const Color(0xFFF3F7FF),
      appBarTheme:AppBarTheme(backgroundColor:dark?navy:const Color(0xFFF3F7FF),foregroundColor:dark?Colors.white:const Color(0xFF071A3A),elevation:0,centerTitle:false),
      cardTheme:CardThemeData(color:dark?const Color(0xFF0D2452):Colors.white,elevation:dark?5:2,shadowColor:blue.withValues(alpha:.22),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20),side:BorderSide(color:dark?cyan.withValues(alpha:.22):blue.withValues(alpha:.10))),margin:const EdgeInsets.symmetric(vertical:7)),
      inputDecorationTheme:InputDecorationTheme(filled:true,fillColor:dark?const Color(0xFF102B5D):const Color(0xFFF0F5FF),border:OutlineInputBorder(borderRadius:BorderRadius.circular(15)),enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(15),borderSide:BorderSide(color:dark?cyan.withValues(alpha:.22):blue.withValues(alpha:.16))),focusedBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(15),borderSide:const BorderSide(color:cyan,width:1.7)),contentPadding:const EdgeInsets.symmetric(horizontal:16,vertical:15)),
      filledButtonTheme:FilledButtonThemeData(style:FilledButton.styleFrom(backgroundColor:blue,foregroundColor:Colors.white,minimumSize:const Size.fromHeight(52),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(16)),textStyle:const TextStyle(fontWeight:FontWeight.w800))),
      navigationBarTheme:NavigationBarThemeData(backgroundColor:dark?const Color(0xFF071A3A):Colors.white,indicatorColor:cyan.withValues(alpha:.18),labelTextStyle:WidgetStateProperty.all(const TextStyle(fontSize:10,fontWeight:FontWeight.w700))),
      dividerColor:dark?cyan.withValues(alpha:.12):blue.withValues(alpha:.10),
    ),
    home:AppShell(dark:dark,language:language,onTheme:()=>setState(()=>dark=!dark),onLanguage:changeLanguage));
}
class AppShell extends StatefulWidget {
  final bool dark;
  final String language;
  final VoidCallback onTheme;
  final ValueChanged<String> onLanguage;
  const AppShell({
    super.key,
    required this.dark,
    required this.language,
    required this.onTheme,
    required this.onLanguage,
  });
  @override State<AppShell> createState()=>_AppShellState();
}
class _AppShellState extends State<AppShell> {
  int tab=0;
  @override Widget build(BuildContext context)=>Scaffold(
    body:SafeArea(child:IndexedStack(index:tab,children:[
      const HomeScreen(),
      const AcademyScreen(),const ToolsScreen(),const ProgressScreen(),
      SettingsScreen(
        dark:widget.dark,
        language:widget.language,
        onTheme:widget.onTheme,
        onLanguage:widget.onLanguage,
      )])),
    bottomNavigationBar:NavigationBar(
      selectedIndex:tab,
      onDestinationSelected:(v)=>setState(()=>tab=v),
      destinations:[
        NavigationDestination(icon:const Icon(Icons.home_outlined),label:chemText(context,'Início','Home')),
        NavigationDestination(icon:const Icon(Icons.menu_book_outlined),label:chemText(context,'Academia','Academy')),
        NavigationDestination(icon:const Icon(Icons.science_outlined),label:chemText(context,'Laboratório','Lab')),
        NavigationDestination(icon:const Icon(Icons.insights_outlined),label:chemText(context,'Progresso','Progress')),
        NavigationDestination(icon:const Icon(Icons.more_horiz),label:chemText(context,'Mais','More')),
      ],
    ));
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final english = isEnglish(context);
    return ListView(padding:const EdgeInsets.all(18),children:[
      Row(children:[
        const CircleAvatar(radius:25,backgroundColor:blue,child:Icon(Icons.biotech,color:Colors.white,size:30)),
        const SizedBox(width:12),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          const Text('ChemMaster',style:TextStyle(fontSize:25,fontWeight:FontWeight.w900)),
          Text(english?'Learn • Explore • Understand':'Aprender • Explorar • Compreender',style:const TextStyle(color:cyan)),
        ])),
      ]),
      const SizedBox(height:20),
      Container(
        padding:const EdgeInsets.all(22),
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(24),
          gradient:const LinearGradient(colors:[Color(0xFF0756C9),Color(0xFF32117D),Color(0xFF091B43)]),
        ),
        child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text(english?'Chemistry, made clearer.':'Química, com mais clareza.',style:const TextStyle(fontSize:23,fontWeight:FontWeight.bold)),
          const SizedBox(height:8),
          Text(english
            ?'Choose elements and substances, explore reactions and learn why the answers work.'
            :'Escolhe elementos e substâncias, explora reacções e aprende por que razão as respostas funcionam.'),
          const SizedBox(height:12),
          Row(children:[
            const Icon(Icons.offline_bolt,color:Colors.amber),
            const SizedBox(width:8),
            Text(english?'Core tools work offline':'Ferramentas essenciais funcionam offline'),
          ]),
        ]),
      ),
      const SizedBox(height:20),
      Text(english?'Quick access':'Acesso rápido',style:const TextStyle(fontSize:19,fontWeight:FontWeight.bold)),
      const SizedBox(height:8),
      GridView.count(
        shrinkWrap:true,
        physics:const NeverScrollableScrollPhysics(),
        crossAxisCount:2,
        crossAxisSpacing:10,
        mainAxisSpacing:10,
        childAspectRatio:1.42,
        children:[
          _HomeCard(icon:Icons.auto_awesome,title:english?'Discover products':'Descobrir produtos',detail:english?'Choose reactants':'Escolher reagentes',onTap:()=>Navigator.push(context,neonRoute(const ProductDiscoveryScreen()))),
          _HomeCard(icon:Icons.functions,title:english?'Balance equation':'Equilibrar equação',detail:english?'Build both sides':'Construir os dois lados',onTap:()=>Navigator.push(context,neonRoute(const BalanceScreen()))),
          _HomeCard(icon:Icons.hub,title:english?'Atomic structure':'Estrutura atómica',detail:english?'Calculate Z, A and N':'Calcular Z, A e N',onTap:()=>Navigator.push(context,neonRoute(const AtomicStructureScreen()))),
          _HomeCard(icon:Icons.electric_bolt,title:english?'Electron configuration':'Distribuição electrónica',detail:english?'Shells and subshells':'Camadas e subníveis',onTap:()=>Navigator.push(context,neonRoute(const ElectronDistributionScreen()))),
        ],
      ),
      const SizedBox(height:12),
      Card(child:ListTile(
        leading:const Icon(Icons.grid_on,color:cyan),
        title:Text(english?'Explore the periodic table':'Explorar a tabela periódica'),
        subtitle:Text(english?'118 elements, organized by family':'118 elementos, organizados por família'),
        trailing:const Icon(Icons.chevron_right),
        onTap:()=>Navigator.push(context,neonRoute(const PeriodicScreen())),
      )),
      Card(child:ListTile(
        leading:const Icon(Icons.calculate,color:cyan),
        title:Text(english?'Chemistry calculators':'Calculadoras de Química'),
        subtitle:Text(english?'Moles, molar mass and solutions':'Moles, massa molar e soluções'),
        trailing:const Icon(Icons.chevron_right),
        onTap:()=>Navigator.push(context,neonRoute(const CalculatorsScreen())),
      )),
    ]);
  }
}
class _HomeCard extends StatelessWidget {
  final IconData icon;final String title,detail;final VoidCallback onTap;
  const _HomeCard({required this.icon,required this.title,required this.detail,required this.onTap});
  @override Widget build(BuildContext context)=>Container(
    decoration:BoxDecoration(
      borderRadius:BorderRadius.circular(20),
      gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF123879),Color(0xFF091A3D)]),
      border:Border.all(color:cyan.withValues(alpha:.34)),
      boxShadow:[BoxShadow(color:blue.withValues(alpha:.16),blurRadius:17,offset:const Offset(0,5))],
    ),
    child:InkWell(onTap:onTap,borderRadius:BorderRadius.circular(20),child:Padding(
      padding:const EdgeInsets.all(14),
      child:Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.start,children:[
        Container(width:42,height:42,decoration:BoxDecoration(borderRadius:BorderRadius.circular(14),gradient:const LinearGradient(colors:[blue,violet]),boxShadow:[BoxShadow(color:cyan.withValues(alpha:.24),blurRadius:12)]),child:Icon(icon,color:Colors.white,size:24)),
        const SizedBox(height:10),
        Text(title,style:const TextStyle(fontWeight:FontWeight.w900,color:Colors.white)),
        Text(detail,style:TextStyle(fontSize:11,color:Colors.white.withValues(alpha:.72))),
      ]),
    )),
  );
}

class AcademyScreen extends StatefulWidget {
  const AcademyScreen({super.key});
  @override State<AcademyScreen> createState()=>_AcademyScreenState();
}
class _AcademyScreenState extends State<AcademyScreen> {
  String grade='7.ª classe';
  @override
  Widget build(BuildContext context) {
    final english = isEnglish(context);
    final selected=mozambiqueCurriculum.firstWhere((c)=>c.grade==grade);
    return ListView(padding:const EdgeInsets.all(18),children:[
      Text(english?'Academy':'Academia',style:const TextStyle(fontSize:27,fontWeight:FontWeight.w900)),
      Text(english
        ?'Mozambique secondary Chemistry curriculum • grades 7–12'
        :'Programa de Química • 7.ª à 12.ª classe • Moçambique'),
      const SizedBox(height:12),
      Wrap(
        spacing:7,
        children:mozambiqueCurriculum.map((c)=>ChoiceChip(
          label:Text(localizedGrade(c.grade,english)),
          selected:grade==c.grade,
          onSelected:(_)=>setState(()=>grade=c.grade),
        )).toList(),
      ),
      const SizedBox(height:12),
      ...selected.units.map((unit)=>Card(
        child:ExpansionTile(
          leading:const Icon(Icons.menu_book,color:cyan),
          title:Text(localizedUnitTitle(unit.title,english),style:const TextStyle(fontWeight:FontWeight.bold)),
          subtitle:Text(unit.lessons.length.toString()+(english?' lessons':' lições')),
          children:unit.lessons.map((lesson)=>ListTile(
            title:Text(localizedLessonTitle(lesson,english)),
            subtitle:Text(localizedLessonSummary(lesson,english),maxLines:2,overflow:TextOverflow.ellipsis),
            trailing:const Icon(Icons.arrow_forward_ios,size:15),
            onTap:()=>Navigator.push(context,neonRoute(LessonScreen(lesson:lesson,grade:grade))),
          )).toList(),
        ),
      )),
      const SizedBox(height:8),
      Text(
        english
          ?'Introductory lessons are organised across all six grades. Detailed coverage is expanded and reviewed continuously.'
          :'Conteúdos introdutórios organizados para as seis classes. A cobertura detalhada será ampliada e revista continuamente.',
        style:const TextStyle(fontSize:12,color:Colors.amber),
      ),
    ]);
  }
}
class LessonScreen extends StatelessWidget {
  final Lesson lesson;
  final String grade;
  const LessonScreen({super.key,required this.lesson,required this.grade});
  @override
  Widget build(BuildContext context) {
    final english = isEnglish(context);
    return Scaffold(
      appBar:AppBar(title:Text(localizedLessonTitle(lesson,english))),
      body:ListView(padding:const EdgeInsets.all(18),children:[
        Text(localizedGrade(grade,english),style:const TextStyle(color:cyan,fontWeight:FontWeight.bold)),
        Text(localizedLessonSummary(lesson,english),style:const TextStyle(fontSize:19,fontWeight:FontWeight.bold)),
        const SizedBox(height:14),
        Card(child:Padding(
          padding:const EdgeInsets.all(16),
          child:Text(localizedLessonBody(lesson,english),style:const TextStyle(fontSize:16,height:1.5)),
        )),
        ExpansionTile(
          title:Text(english?'Worked example':'Exemplo explicado'),
          leading:const Icon(Icons.lightbulb_outline,color:Colors.orange),
          children:[
            Padding(
              padding:const EdgeInsets.all(16),
              child:Text(localizedLessonExample(lesson,english)),
            ),
          ],
        ),
        const SizedBox(height:16),
        FilledButton.icon(
          onPressed:()async{
            await ProgressStore.completeLesson(lesson.id);
            if(context.mounted)ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content:Text(english?'Lesson marked as completed.':'Lição marcada como concluída.')),
            );
          },
          icon:const Icon(Icons.check),
          label:Text(english?'Mark as completed':'Marcar como concluída'),
        ),
      ]),
    );
  }
}
class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final english = isEnglish(context);
    return ListView(padding:const EdgeInsets.all(18),children:[
      Text(english?'Chemistry lab':'Laboratório de Química',style:const TextStyle(fontSize:27,fontWeight:FontWeight.w900)),
      Text(english
        ?'A practical toolbox for solving, exploring and understanding chemistry.'
        :'Um conjunto de ferramentas para resolver, explorar e compreender Química.'),
      const SizedBox(height:18),
      _LabSection(
        title:english?'REACTIONS & EQUATIONS':'REACÇÕES E EQUAÇÕES',
        children:[
          _ToolTile(english?'Discover products':'Descobrir produtos',english?'Choose reactants from the catalog':'Escolhe reagentes no catálogo',Icons.auto_awesome,const ProductDiscoveryScreen()),
          _ToolTile(english?'Build and balance an equation':'Construir e equilibrar equação',english?'Choose substances on both sides':'Escolhe substâncias nos dois lados',Icons.functions,const BalanceScreen()),
          _ToolTile(english?'Reaction types':'Tipos de reacções',english?'Synthesis, decomposition, acid-base and more':'Síntese, decomposição, ácido-base e mais',Icons.sync_alt,const ReactionScreen()),
        ],
      ),
      _LabSection(
        title:english?'ELEMENTS & ATOMS':'ELEMENTOS E ÁTOMOS',
        children:[
          _ToolTile(english?'Periodic table':'Tabela periódica',english?'118 elements by family':'118 elementos por família',Icons.grid_on,const PeriodicScreen()),
          _ToolTile(english?'Atomic structure':'Estrutura atómica',english?'Calculate Z, A, neutrons and particles':'Calcular Z, A, neutrões e partículas',Icons.hub,const AtomicStructureScreen()),
          _ToolTile(english?'Electron configuration':'Distribuição electrónica',english?'Electron configuration and shells':'Configuração electrónica e camadas',Icons.electric_bolt,const ElectronDistributionScreen()),
        ],
      ),
      _LabSection(
        title:english?'CALCULATIONS & SOLUTIONS':'CÁLCULOS E SOLUÇÕES',
        children:[
          _ToolTile(english?'Chemistry calculators':'Calculadoras químicas',english?'Molar mass, moles, concentration, density and dilution':'Massa molar, mol, concentração, densidade e diluição',Icons.calculate,const CalculatorsScreen()),
        ],
      ),
      _LabSection(
        title:english?'LEARN & PRACTISE':'APRENDER E PRATICAR',
        children:[
          _ToolTile(english?'Nomenclature':'Nomenclatura',english?'Oxides, acids, bases and salts':'Óxidos, ácidos, bases e sais',Icons.spellcheck,const NomenclatureScreen()),
          _ToolTile(english?'Exercises and tests':'Exercícios e testes',english?'Check knowledge and see explanations':'Avaliar conhecimentos e ver explicações',Icons.quiz,const QuizScreen()),
        ],
      ),
    ]);
  }
}
class _LabSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _LabSection({required this.title,required this.children});
  @override
  Widget build(BuildContext context)=>Padding(
    padding:const EdgeInsets.only(top:10,bottom:9),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Padding(
        padding:const EdgeInsets.only(left:4,bottom:6),
        child:Text(title,style:const TextStyle(fontSize:11,letterSpacing:1.2,fontWeight:FontWeight.w900,color:cyan)),
      ),
      Card(child:Column(children:children)),
    ]),
  );
}
class _ToolTile extends StatelessWidget {
  final String title,detail;final IconData icon;final Widget page;
  const _ToolTile(this.title,this.detail,this.icon,this.page);
  @override Widget build(BuildContext context)=>Card(child:ListTile(leading:Icon(icon,color:cyan,size:28),title:Text(title),subtitle:Text(detail),trailing:const Icon(Icons.chevron_right),onTap:()=>Navigator.push(context,neonRoute(page))));
}

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});
  @override
  Widget build(BuildContext context) => const EquationBuilderScreen();
}

class CalculatorsScreen extends StatefulWidget {const CalculatorsScreen({super.key});@override State<CalculatorsScreen> createState()=>_CalculatorsScreenState();}
class _CalculatorsScreenState extends State<CalculatorsScreen>{
  final formula=TextEditingController(text:'H2SO4'),mass=TextEditingController(text:'10'),molar=TextEditingController(text:'98.08'),moles=TextEditingController(text:'0.5'),volume=TextEditingController(text:'2'),densityMass=TextEditingController(text:'20'),densityVolume=TextEditingController(text:'5'),solute=TextEditingController(text:'10'),solution=TextEditingController(text:'100'),c1=TextEditingController(text:'2'),v1=TextEditingController(text:'50'),v2=TextEditingController(text:'100');
  String r0='—',r1='—',r2='—',r3='—',r4='—',r5='—';
  bool get _english => isEnglish(context);

  Future<void> _selectFormula() async {
    final item = await ChemicalPicker.show(
      context,
      mode: ChemicalPickerMode.compoundsOnly,
      title: _english ? 'Choose a compound' : 'Escolher composto',
    );
    if (!mounted || item == null) return;
    setState(() => formula.text = item.formula);
  }

  Widget _formulaSelector() => OutlinedButton.icon(
    onPressed: _selectFormula,
    icon: const Icon(Icons.search),
    label: Text(
      (_english ? 'Choose formula: ' : 'Escolher fórmula: ') + prettyFormula(formula.text),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
  );
  static final weights={for(final e in periodicElements)e.symbol:e.atomicMass};
  void safe(void Function() fn){try{setState(fn);}catch(e){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.toString())));}}
  void calcMass(){
    safe(() {
      final atoms=FormulaParser.parse(formula.text);
      final total=atoms.entries.fold<double>(0.0,(sum,entry) {
        final atomicMass=weights[entry.key];
        if(atomicMass==null)throw FormatException((_english?'Atomic mass unavailable: ':'Massa atómica não disponível: ')+entry.key);
        return (sum+atomicMass*entry.value).toDouble();
      });
      r0='${total.toStringAsFixed(3)} g/mol';
    });
  }
  double val(TextEditingController c)=>double.parse(c.text.replaceAll(',','.'));
  void calcMol()=>safe((){final m=val(mass),mm=val(molar);if(m<0||mm<=0)throw FormatException('A massa deve ser não negativa e a massa molar positiva.');r1=(m/mm).toStringAsFixed(4)+' mol';});
  void calcConc()=>safe((){final n=val(moles),v=val(volume);if(n<0||v<=0)throw FormatException('A quantidade deve ser não negativa e o volume positivo.');r2=(n/v).toStringAsFixed(4)+' mol/L';});
  void calcDensity()=>safe((){final m=val(densityMass),v=val(densityVolume);if(m<0||v<=0)throw FormatException('A massa deve ser não negativa e o volume positivo.');r3=(m/v).toStringAsFixed(4)+' g/mL';});
  void calcPercent()=>safe((){final m=val(solute),total=val(solution);if(m<0||total<=0||m>total)throw FormatException('A massa do soluto deve estar entre zero e a massa total da solução.');r4=(m/total*100).toStringAsFixed(2)+' % m/m';});
  void calcDilution()=>safe((){final initial=val(c1),initialVolume=val(v1),finalVolume=val(v2);if(initial<0||initialVolume<=0||finalVolume<=0||finalVolume<initialVolume)throw FormatException('Verifica as concentrações e os volumes. O volume final deve ser maior ou igual ao inicial.');r5=(initial*initialVolume/finalVolume).toStringAsFixed(4)+' mol/L';});
  InputDecoration dec(String s)=>InputDecoration(labelText:s,border:const OutlineInputBorder());
  Widget field(TextEditingController c,String label)=>TextField(controller:c,keyboardType:const TextInputType.numberWithOptions(decimal:true),decoration:dec(label));
  Widget panel(String title,String formulaText,List<Widget> children)=>ListView(padding:const EdgeInsets.all(16),children:[Text(title,style:const TextStyle(fontSize:18,fontWeight:FontWeight.bold)),Text(formulaText,style:const TextStyle(color:cyan)),const SizedBox(height:12),...children]);
  Widget result(String s)=>Card(child:Padding(padding:const EdgeInsets.all(16),child:Text(s,style:const TextStyle(fontSize:23,fontWeight:FontWeight.bold,color:cyan))));
  @override Widget build(BuildContext context)=>DefaultTabController(length:6,child:Scaffold(appBar:AppBar(title:Text(_english?'Chemistry calculators':'Calculadoras químicas'),bottom:TabBar(isScrollable:true,tabs:[
    Tab(text:_english?'Molar mass':'Massa molar'),
    const Tab(text:'Mol'),
    Tab(text:_english?'Concentration':'Concentração'),
    Tab(text:_english?'Density':'Densidade'),
    Tab(text:_english?'Percentage':'Percentagem'),
    Tab(text:_english?'Dilution':'Diluição')
  ])),body:TabBarView(children:[
    panel(_english?'Molar mass':'Massa molar','M = Σ atomic masses', [_formulaSelector(),FilledButton(onPressed:calcMass,child:Text(_english?'Calculate':'Calcular')),result(r0)]),
    panel(_english?'Amount of substance':'Quantidade de matéria','n = m / M', [field(mass,_english?'Mass (g)':'Massa (g)'),field(molar,_english?'Molar mass (g/mol)':'Massa molar (g/mol)'),FilledButton(onPressed:calcMol,child:Text(_english?'Calculate':'Calcular')),result(r1)]),
    panel(_english?'Molar concentration':'Concentração molar','C = n / V', [field(moles,_english?'Amount (mol)':'Quantidade (mol)'),field(volume,_english?'Volume (L)':'Volume (L)'),FilledButton(onPressed:calcConc,child:Text(_english?'Calculate':'Calcular')),result(r2)]),
    panel(_english?'Density':'Densidade','d = m / V', [field(densityMass,_english?'Mass (g)':'Massa (g)'),field(densityVolume,_english?'Volume (mL)':'Volume (mL)'),FilledButton(onPressed:calcDensity,child:Text(_english?'Calculate':'Calcular')),result(r3)]),
    panel(_english?'Mass percentage concentration':'Concentração percentual em massa','% m/m = solute mass / solution mass × 100', [field(solute,_english?'Solute mass (g)':'Massa do soluto (g)'),field(solution,_english?'Solution mass (g)':'Massa da solução (g)'),FilledButton(onPressed:calcPercent,child:Text(_english?'Calculate':'Calcular')),result(r4)]),
    panel(_english?'Dilution':'Diluição','C1 × V1 = C2 × V2', [field(c1,_english?'Initial concentration (mol/L)':'Concentração inicial (mol/L)'),field(v1,_english?'Initial volume (mL)':'Volume inicial (mL)'),field(v2,_english?'Final volume (mL)':'Volume final (mL)'),FilledButton(onPressed:calcDilution,child:Text(_english?'Calculate final concentration':'Calcular concentração final')),result(r5)])
  ])));
}

class PeriodicScreen extends StatefulWidget {
  const PeriodicScreen({super.key});
  @override State<PeriodicScreen> createState()=>_PeriodicScreenState();
}
class _PeriodicScreenState extends State<PeriodicScreen>{
  final search=TextEditingController();
  String query='';
  bool get _english=>isEnglish(context);

  String _name(ChemicalElement element) =>
      _english ? (elementEnglishNames[element.symbol] ?? element.name) : element.name;

  String _category(String category) {
    if (!_english) return category;
    const names={
      'Não metal':'Nonmetal',
      'Gás nobre':'Noble gas',
      'Metal alcalino':'Alkali metal',
      'Metal alcalino-terroso':'Alkaline earth metal',
      'Semimetal':'Metalloid',
      'Halogéneo':'Halogen',
      'Metal de transição':'Transition metal',
      'Metal pós-transição':'Post-transition metal',
      'Lantanídeo':'Lanthanide',
      'Actinídeo':'Actinide',
    };
    return names[category]??category;
  }

  @override
  Widget build(BuildContext context){
    final elements=periodicElements.where((e)=>
      e.name.toLowerCase().contains(query.toLowerCase()) ||
      (elementEnglishNames[e.symbol]??'').toLowerCase().contains(query.toLowerCase()) ||
      e.symbol.toLowerCase().contains(query.toLowerCase()) ||
      e.number.toString()==query
    ).toList();
    return Scaffold(
      appBar:AppBar(title:Text(_english?'Periodic table • 118 elements':'Tabela periódica • 118 elementos')),
      body:Column(children:[
        Padding(
          padding:const EdgeInsets.all(12),
          child:TextField(
            controller:search,
            onChanged:(v)=>setState(()=>query=v),
            decoration:InputDecoration(
              prefixIcon:const Icon(Icons.search),
              hintText:_english?'Search element by name, symbol or Z':'Pesquisar elemento por nome, símbolo ou Z',
              border:const OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child:GridView.builder(
            padding:const EdgeInsets.all(10),
            itemCount:elements.length,
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:4,crossAxisSpacing:7,mainAxisSpacing:7,childAspectRatio:.95,
            ),
            itemBuilder:(context,i){
              final e=elements[i];
              return Card(
                child:InkWell(
                  onTap:()=>showDialog(
                    context:context,
                    builder:(_)=>AlertDialog(
                      title:Text(e.symbol+' — '+_name(e)),
                      content:Text(
                        (_english?'Atomic number: ':'Número atómico: ')+e.number.toString()+
                        '\n'+(_english?'Atomic mass: ':'Massa atómica: ')+e.atomicMass.toString()+' u'+
                        '\n'+(_english?'Family: ':'Família: ')+_category(e.category),
                      ),
                      actions:[
                        TextButton(onPressed:()=>Navigator.pop(context),child:Text(_english?'Close':'Fechar')),
                      ],
                    ),
                  ),
                  child:Padding(
                    padding:const EdgeInsets.all(5),
                    child:Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children:[
                        Text(e.number.toString(),style:const TextStyle(fontSize:10)),
                        Text(e.symbol,style:const TextStyle(fontSize:23,fontWeight:FontWeight.bold,color:cyan)),
                        Text(_name(e),textAlign:TextAlign.center,style:const TextStyle(fontSize:9),maxLines:2,overflow:TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
class ReactionScreen extends StatelessWidget {
  const ReactionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final english = isEnglish(context);
    final rows = english
      ?[
        ('Synthesis','A + B → AB','2H₂ + O₂ → 2H₂O','Two or more reactants combine to form one product.'),
        ('Decomposition','AB → A + B','2H₂O₂ → 2H₂O + O₂','One compound breaks into simpler substances.'),
        ('Single displacement','A + BC → AC + B','Zn + 2HCl → ZnCl₂ + H₂','A more reactive element replaces another in a compound.'),
        ('Double displacement','AB + CD → AD + CB','AgNO₃ + NaCl → AgCl + NaNO₃','Ions exchange partners; a precipitate may form.'),
        ('Neutralization','Acid + Base → Salt + Water','HCl + KOH → KCl + H₂O','An acid and a base react to form water and a salt.'),
      ]
      :[
        ('Síntese','A + B → AB','2H₂ + O₂ → 2H₂O','Duas ou mais substâncias combinam-se para formar um produto.'),
        ('Decomposição','AB → A + B','2H₂O₂ → 2H₂O + O₂','Um composto divide-se em substâncias mais simples.'),
        ('Deslocamento simples','A + BC → AC + B','Zn + 2HCl → ZnCl₂ + H₂','Um elemento mais reactivo substitui outro num composto.'),
        ('Dupla troca','AB + CD → AD + CB','AgNO₃ + NaCl → AgCl + NaNO₃','Os iões trocam parceiros; pode formar-se um precipitado.'),
        ('Neutralização','Ácido + Base → Sal + Água','HCl + KOH → KCl + H₂O','Um ácido e uma base reagem e formam água e um sal.'),
      ];
    return Scaffold(
      appBar:AppBar(title:Text(english?'Reaction types':'Tipos de reacções')),
      body:ListView(
        padding:const EdgeInsets.all(16),
        children:rows.map((r)=>Card(
          child:ExpansionTile(
            title:Text(r.$1),
            subtitle:Text(r.$2),
            leading:const Icon(Icons.science,color:cyan),
            children:[
              Padding(
                padding:const EdgeInsets.fromLTRB(16,0,16,8),
                child:Text((english?'Example: ':'Exemplo: ')+r.$3,style:const TextStyle(fontWeight:FontWeight.w800)),
              ),
              Padding(
                padding:const EdgeInsets.fromLTRB(16,0,16,16),
                child:Text(r.$4,style:const TextStyle(height:1.4)),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }
}
class NomenclatureScreen extends StatelessWidget {
  const NomenclatureScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final english = isEnglish(context);
    return Scaffold(
      appBar:AppBar(title:Text(english?'Chemical nomenclature':'Nomenclatura química')),
      body:ListView(padding:const EdgeInsets.all(16),children:[
        _NameCard(
          english?'Oxides':'Óxidos',
          english?'Binary compounds of oxygen with another element.':'Compostos binários do oxigénio com outro elemento.',
          english
            ?['CO₂ — carbon dioxide','SO₃ — sulfur trioxide','Fe₂O₃ — iron(III) oxide']
            :['CO2 — dióxido de carbono','SO3 — trióxido de enxofre','Fe2O3 — óxido de ferro (III)'],
        ),
        _NameCard(
          english?'Acids':'Ácidos',
          english?'In aqueous solution, acids increase the concentration of H₃O⁺ ions.':'Em solução aquosa, aumentam a concentração de H3O+.',
          english
            ?['HCl — hydrochloric acid','H₂SO₄ — sulfuric acid','HNO₃ — nitric acid']
            :['HCl — ácido clorídrico','H2SO4 — ácido sulfúrico','HNO3 — ácido nítrico'],
        ),
        _NameCard(
          english?'Bases':'Bases',
          english?'Bases include hydroxides that can release OH⁻ ions in water.':'Incluem hidróxidos que podem fornecer OH− em água.',
          english
            ?['NaOH — sodium hydroxide','KOH — potassium hydroxide','Ca(OH)₂ — calcium hydroxide']
            :['NaOH — hidróxido de sódio','KOH — hidróxido de potássio','Ca(OH)2 — hidróxido de cálcio'],
        ),
        _NameCard(
          english?'Salts':'Sais',
          english?'Ionic compounds made of positive and negative ions.':'Compostos iónicos constituídos por catiões e aniões.',
          english
            ?['NaCl — sodium chloride','KCl — potassium chloride','CaCO₃ — calcium carbonate']
            :['NaCl — cloreto de sódio','KCl — cloreto de potássio','CaCO3 — carbonato de cálcio'],
        ),
      ]),
    );
  }
}
class _NameCard extends StatelessWidget {
  final String title,description;final List<String> examples;
  const _NameCard(this.title,this.description,this.examples);
  @override Widget build(BuildContext context)=>Card(child:ExpansionTile(title:Text(title,style:const TextStyle(fontWeight:FontWeight.bold)),subtitle:Text(description),children:examples.map((e)=>ListTile(title:Text(e))).toList()));
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override State<QuizScreen> createState()=>_QuizScreenState();
}
class _QuizScreenState extends State<QuizScreen>{
  String grade='Todas';
  int index=0,score=0;
  int? selected;
  bool answered=false,finished=false;
  bool get _english=>isEnglish(context);

  List<QuizQuestion> get questions {
    final base=quizBank.where((q)=>grade=='Todas'||q.grade==grade).toList();
    return base.map((q)=>localizedQuizQuestion(q,_english)).toList();
  }

  void next(){
    if(selected==null)return;
    final q=questions[index];
    if(!answered){
      if(selected==q.answer)score++;
      setState(() { answered=true; });
      return;
    }
    if(index+1>=questions.length){
      setState(() { finished=true; });
      ProgressStore.saveQuiz('quiz-'+grade,score,questions.length);
    } else {
      setState(() { index++; selected=null; answered=false; });
    }
  }

  @override
  Widget build(BuildContext context){
    final qs=questions;
    final gradeOptions=['Todas','7.ª classe','8.ª classe','9.ª classe','10.ª classe','11.ª classe','12.ª classe'];
    return Scaffold(
      appBar:AppBar(title:Text(_english?'Exercises and assessments':'Exercícios e avaliações')),
      body:finished
        ?Center(
          child:Padding(
            padding:const EdgeInsets.all(24),
            child:Column(
              mainAxisSize:MainAxisSize.min,
              children:[
                const Icon(Icons.emoji_events,color:Colors.amber,size:64),
                Text(
                  (_english?'Result: ':'Resultado: ')+score.toString()+' / '+qs.length.toString(),
                  style:const TextStyle(fontSize:25,fontWeight:FontWeight.bold),
                ),
                const SizedBox(height:12),
                FilledButton(
                  onPressed:()=>setState(() {
                    index=0;score=0;selected=null;answered=false;finished=false;
                  }),
                  child:Text(_english?'Try again':'Repetir avaliação'),
                ),
              ],
            ),
          ),
        )
        :ListView(
          padding:const EdgeInsets.all(18),
          children:[
            DropdownButtonFormField<String>(
              initialValue:grade,
              decoration:InputDecoration(
                labelText:_english?'Grade':'Classe',
                border:const OutlineInputBorder(),
              ),
              items:gradeOptions.map((value)=>DropdownMenuItem(
                value:value,
                child:Text(value=='Todas'
                  ?(_english?'All grades':'Todas')
                  :localizedGrade(value,_english)),
              )).toList(),
              onChanged:(value)=>setState(() {
                grade=value!;
                index=0;score=0;selected=null;answered=false;finished=false;
              }),
            ),
            const SizedBox(height:18),
            Text(
              (_english?'Question ':'Questão ')+(index+1).toString()+
              (_english?' of ':' de ')+qs.length.toString(),
              style:const TextStyle(color:cyan),
            ),
            Text(qs[index].prompt,style:const TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
            const SizedBox(height:12),
            ...List.generate(qs[index].options.length,(i)=>Card(
              child:RadioListTile<int>(
                value:i,
                groupValue:selected,
                title:Text(qs[index].options[i]),
                onChanged:answered?null:(value)=>setState(()=>selected=value),
              ),
            )),
            if(answered)
              Card(
                child:Padding(
                  padding:const EdgeInsets.all(14),
                  child:Text(
                    (selected==qs[index].answer
                      ?(_english?'Correct! ':'Correcto! ')
                      :(_english
                        ?'Not quite. The correct answer is: '
                        :'Não está correcto. A resposta certa é: ')+qs[index].options[qs[index].answer]+'. ')+
                    qs[index].explanation,
                    style:const TextStyle(height:1.4),
                  ),
                ),
              ),
            FilledButton(
              onPressed:selected==null?null:next,
              child:Text(!answered
                ?(_english?'Check answer':'Verificar resposta')
                :index+1==qs.length
                  ?(_english?'See result':'Ver resultado')
                  :(_english?'Next question':'Próxima questão')),
            ),
          ],
        ),
    );
  }
}
class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});
  @override State<ProgressScreen> createState()=>_ProgressScreenState();
}
class _ProgressScreenState extends State<ProgressScreen>{
  late Future<Map<String,dynamic>> data;
  @override void initState(){super.initState();data=ProgressStore.read();}
  @override
  Widget build(BuildContext context) {
    final english = isEnglish(context);
    return FutureBuilder<Map<String,dynamic>>(
      future:data,
      builder:(context,s){
        final d=s.data??{};
        final lessons=List<String>.from(d['lessons']??[]);
        final scores=Map<String,dynamic>.from(d['bestScores']??{});
        return ListView(padding:const EdgeInsets.all(18),children:[
          Row(children:[
            Expanded(child:Text(english?'Your progress':'O teu progresso',style:const TextStyle(fontSize:27,fontWeight:FontWeight.w900))),
            IconButton(onPressed:()=>setState(()=>data=ProgressStore.read()),icon:const Icon(Icons.refresh)),
          ]),
          Card(child:ListTile(
            leading:const Icon(Icons.menu_book,color:cyan),
            title:Text(english?'Completed lessons':'Lições concluídas'),
            trailing:Text(lessons.length.toString()),
          )),
          Card(child:ListTile(
            leading:const Icon(Icons.quiz,color:cyan),
            title:Text(english?'Assessments completed':'Avaliações realizadas'),
            trailing:Text(scores.length.toString()),
          )),
          Text(english?'Best results':'Melhores resultados',style:const TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
          ...scores.entries.map((entry)=>ListTile(
            title:Text(entry.key),
            trailing:Text(entry.value.toString()+(english?' points':' pontos')),
          )),
          if(lessons.isEmpty&&scores.isEmpty)
            Text(english
              ?'No progress has been saved yet. Complete a lesson or take a quiz.'
              :'Ainda não há progresso guardado. Conclui uma lição ou faz uma avaliação.'),
        ]);
      },
    );
  }
}
class SettingsScreen extends StatelessWidget {
  final bool dark;
  final String language;
  final VoidCallback onTheme;
  final ValueChanged<String> onLanguage;

  const SettingsScreen({
    super.key,
    required this.dark,
    required this.language,
    required this.onTheme,
    required this.onLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final english = isEnglish(context);
    return ListView(padding:const EdgeInsets.all(18),children:[
      Text(english?'Settings':'Definições',style:const TextStyle(fontSize:28,fontWeight:FontWeight.w900)),
      Text(english
          ?'Make ChemMaster work the way you study.'
          :'Personaliza a tua experiência de aprendizagem.'),
      const SizedBox(height:16),
      _SettingsSection(title:english?'APPEARANCE':'APARÊNCIA',children:[
        SwitchListTile(
          value:dark,
          onChanged:(_)=>onTheme(),
          secondary:const Icon(Icons.dark_mode_outlined,color:cyan),
          title:Text(english?'Dark mode':'Modo escuro'),
          subtitle:Text(dark
              ?(english?'Neon blue theme active':'Tema azul neon activo')
              :(english?'Light theme active':'Tema claro activo')),
        ),
        ListTile(
          leading:const Icon(Icons.palette_outlined,color:violet),
          title:Text(english?'Visual identity':'Identidade visual'),
          subtitle:const Text('Electric blue • Cyan • Violet'),
        ),
      ]),
      _SettingsSection(title:english?'LANGUAGE':'IDIOMA',children:[
        ListTile(
          leading:const Icon(Icons.translate,color:cyan),
          title:Text(english?'App language':'Idioma do aplicativo'),
          subtitle:Text(english
              ?'Choose the language for menus and tools.'
              :'Escolhe o idioma dos menus e das ferramentas.'),
          trailing:DropdownButtonHideUnderline(
            child:DropdownButton<String>(
              value:language,
              onChanged:(value){if(value!=null)onLanguage(value);},
              items:const [
                DropdownMenuItem(value:'pt',child:Text('Português')),
                DropdownMenuItem(value:'en',child:Text('English')),
              ],
            ),
          ),
        ),
      ]),
      _SettingsSection(title:english?'PREFERENCES':'PREFERÊNCIAS',children:[
        ListTile(
          leading:const Icon(Icons.offline_pin_outlined,color:cyan),
          title:Text(english?'Offline access':'Acesso offline'),
          subtitle:Text(english
              ?'The catalog, periodic table and core tools are available without internet.'
              :'O catálogo, a tabela periódica e as ferramentas essenciais funcionam sem Internet.'),
        ),
        ListTile(
          leading:const Icon(Icons.notifications_none,color:cyan),
          title:Text(english?'Study reminders':'Lembretes de estudo'),
          subtitle:Text(english?'Coming in a future update':'Disponíveis numa actualização futura'),
        ),
      ]),
      _SettingsSection(title:english?'DATA & PRIVACY':'DADOS E PRIVACIDADE',children:[
        ListTile(
          leading:const Icon(Icons.phone_android,color:cyan),
          title:Text(english?'Local storage':'Armazenamento local'),
          subtitle:Text(english
              ?'Your progress is stored on this device.'
              :'O teu progresso é guardado neste dispositivo.'),
        ),
        ListTile(
          leading:const Icon(Icons.delete_outline,color:Colors.orange),
          title:Text(english?'Clear progress':'Limpar progresso'),
          subtitle:Text(english
              ?'Delete completed lessons and saved results.'
              :'Apagar lições concluídas e resultados guardados.'),
          onTap:()async{
            final confirmed=await showDialog<bool>(
              context:context,
              builder:(dialogContext)=>AlertDialog(
                title:Text(english?'Clear progress?':'Limpar progresso?'),
                content:Text(english
                    ?'This deletes completed lessons and saved results on this device.'
                    :'Esta acção apaga as lições concluídas e os resultados guardados neste dispositivo.'),
                actions:[
                  TextButton(
                    onPressed:()=>Navigator.pop(dialogContext,false),
                    child:Text(english?'Cancel':'Cancelar'),
                  ),
                  FilledButton(
                    onPressed:()=>Navigator.pop(dialogContext,true),
                    child:Text(english?'Clear':'Limpar'),
                  ),
                ],
              ),
            );
            if(confirmed==true){
              await ProgressStore.clear();
              if(context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content:Text(english?'Progress cleared.':'Progresso apagado.')),
                );
              }
            }
          },
        ),
      ]),
      _SettingsSection(title:english?'ABOUT':'SOBRE',children:[
        ListTile(
          leading:const Icon(Icons.science_outlined,color:cyan),
          title:const Text('ChemMaster'),
          subtitle:Text(english?'Learn • Explore • Understand':'Aprender • Explorar • Compreender'),
        ),
        ListTile(
          leading:const Icon(Icons.public,color:cyan),
          title:Text(english?'Made for Mozambique':'Desenvolvido para Moçambique'),
          subtitle:Text(english
              ?'Built to grow with students and teachers everywhere.'
              :'Com visão de expansão para estudantes e professores de todo o mundo.'),
        ),
        ListTile(
          leading:const Icon(Icons.info_outline,color:cyan),
          title:Text(english?'Version 1.0.0':'Versão 1.0.0'),
          subtitle:Text(english?'Chemistry learning platform':'Plataforma de aprendizagem de Química'),
        ),
      ]),
    ]);
  }
}
class _SettingsSection extends StatelessWidget {
  final String title;final List<Widget> children;
  const _SettingsSection({required this.title,required this.children});
  @override Widget build(BuildContext context)=>Padding(
    padding:const EdgeInsets.only(bottom:14),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Padding(padding:const EdgeInsets.only(left:5,bottom:6),child:Text(title,style:const TextStyle(fontSize:11,letterSpacing:1.4,fontWeight:FontWeight.w900,color:cyan))),
      Card(child:Column(children:children)),
    ]),
  );
}
