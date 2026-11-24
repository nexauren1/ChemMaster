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
QuizQuestion('q10','9.ª classe','Óxidos','Fe2O3 é denominado:',['Óxido de ferro (III)','Ácido de ferro','Hidróxido de ferro','Cloreto de ferro'],0,'O oxigénio tem número de oxidação −2; o ferro fica em +3.'),

QuizQuestion('q11','10.ª classe','Estequiometria','Na equação 2H2 + O2 → 2H2O, qual é a proporção molar H2:O2?',['1:1','2:1','1:2','2:2'],1,'Os coeficientes indicam uma proporção de 2 mol de H2 para 1 mol de O2.'),
QuizQuestion('q12','10.ª classe','Enxofre','Qual é a fórmula do dióxido de enxofre?',['SO','SO2','SO3','H2S'],1,'Dióxido indica dois átomos de oxigénio: SO2.'),
QuizQuestion('q13','10.ª classe','Química orgânica','Qual é o grupo funcional característico dos álcoois?',['Carboxilo','Hidroxilo','Aldeído','Éster'],1,'Os álcoois possuem grupo hidroxilo ligado a carbono saturado.'),
QuizQuestion('q14','11.ª classe','Estrutura atómica','O número atómico de um elemento indica o número de:',['Neutrões','Protões','Níveis de energia','Isótopos'],1,'O número de protões define a identidade do elemento.'),
QuizQuestion('q15','11.ª classe','Ligação química','Que ligação envolve a partilha de pares de electrões?',['Iónica','Covalente','Metálica','Nuclear'],1,'Na ligação covalente, os átomos partilham pares de electrões.'),
QuizQuestion('q16','11.ª classe','Soluções','Uma solução de 2 mol/L é diluída de 50 mL para 100 mL. Qual é a concentração final?',['0,5 mol/L','1 mol/L','2 mol/L','4 mol/L'],1,'C2 = C1 × V1 / V2 = 2 × 50 / 100 = 1 mol/L.'),
QuizQuestion('q17','11.ª classe','Termoquímica','Uma reacção exotérmica apresenta, em geral:',['ΔH positivo','ΔH negativo','ΔH igual a zero','Sem troca de energia'],1,'Numa reacção exotérmica há libertação de energia e ΔH é negativo.'),
QuizQuestion('q18','12.ª classe','Cinética química','Qual destes factores pode aumentar a velocidade de muitas reacções?',['Diminuir a temperatura','Aumentar a temperatura','Retirar reagente','Diminuir a superfície de contacto'],1,'O aumento da temperatura tende a elevar a frequência de colisões eficazes.'),
QuizQuestion('q19','12.ª classe','Equilíbrio químico','No equilíbrio dinâmico, as velocidades directa e inversa são:',['Nulas','Iguais','Sempre diferentes','Desconhecidas e sem relação'],1,'As reacções continuam, mas as velocidades directa e inversa são iguais.'),
QuizQuestion('q20','12.ª classe','Ácidos e bases','A 25 °C, numa solução aquosa diluída, qual relação é usualmente válida?',['pH + pOH = 7','pH + pOH = 14','pH = pOH sempre','pH × pOH = 14'],1,'A 25 °C, o produto iónico da água conduz a pH + pOH = 14.'),
QuizQuestion('q21','12.ª classe','Electroquímica','Numa pilha galvânica, a oxidação ocorre no:',['Cátodo','Ânodo','Electrólito apenas','Ponte salina'],1,'O ânodo é o eléctrodo onde ocorre oxidação.'),
QuizQuestion('q22','12.ª classe','Química orgânica','As proteínas são polímeros naturais formados por:',['Monossacarídeos','Aminoácidos','Ácidos gordos','Nucleótidos'],1,'As proteínas são cadeias de aminoácidos unidos por ligações peptídicas.')

];
