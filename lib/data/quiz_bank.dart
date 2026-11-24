class QuizQuestion {
  final String id,grade,unit,prompt,explanation;
  final List<String> options; final int answer;
  const QuizQuestion(this.id,this.grade,this.unit,this.prompt,this.options,this.answer,this.explanation);
}
const quizBank=<QuizQuestion>[
QuizQuestion('q1','7.ª classe','Estrutura da matéria','Qual é a fórmula química da água?',['H2O','CO2','O2','NaCl'],0,'A molécula de água contém dois átomos de hidrogénio e um de oxigénio.'),
QuizQuestion('q2','7.ª classe','Reacções químicas','Qual é a equação correctamente balanceada da formação da água?',['H2 + O2 → H2O','2H2 + O2 → 2H2O','H2 + 2O2 → H2O','2H2 + 2O2 → H2O'],1,'Há quatro átomos de hidrogénio e dois de oxigénio em cada lado.'),
QuizQuestion('q3','7.ª classe','Matéria e misturas','Água e óleo formam uma mistura:',['Homogénea','Heterogénea','Substância pura','Elemento'],1,'As fases são visivelmente distintas.'),
QuizQuestion('q4','8.ª classe','Estrutura atómica','O número atómico corresponde ao número de:',['Neutrões','Protões','Moléculas','Camadas'],1,'O número de protões identifica o elemento químico.'),
QuizQuestion('q5','8.ª classe','Cálculos químicos','Qual é a expressão que relaciona quantidade de matéria, massa e massa molar?',['n = m/M','n = m × M','M = n/m','m = n/M'],0,'A quantidade de matéria é a massa dividida pela massa molar.'),
QuizQuestion('q6','8.ª classe','Ligação química','Que tipo de ligação predomina no cloreto de sódio?',['Covalente','Metálica','Iónica','Nuclear'],2,'O NaCl é formado por iões Na+ e Cl−.'),
QuizQuestion('q7','9.ª classe','Neutralização','Que produtos resultam de HCl + KOH?',['KCl + H2O','KOH + Cl2','H2 + KCl','K2O + HCl'],0,'Ácido clorídrico e hidróxido de potássio formam cloreto de potássio e água.'),
QuizQuestion('q8','9.ª classe','Nomenclatura','Qual é o nome de KOH?',['Óxido de potássio','Ácido potássico','Hidróxido de potássio','Cloreto de potássio'],2,'KOH é o hidróxido de potássio.'),
QuizQuestion('q9','9.ª classe','Hidrocarbonetos','Qual destas fórmulas representa o eteno?',['C2H6','C2H4','C2H2','CH4'],1,'O eteno é um alceno com uma ligação dupla C=C.'),
QuizQuestion('q10','9.ª classe','Óxidos','Fe2O3 é denominado:',['Óxido de ferro (III)','Ácido de ferro','Hidróxido de ferro','Cloreto de ferro'],0,'O oxigénio tem número de oxidação −2; o ferro fica em +3.')
];
