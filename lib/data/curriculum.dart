class Lesson {
  final String id,title,summary,body,example;
  const Lesson(this.id,this.title,this.summary,this.body,this.example);
}
class CurriculumUnit {
  final String title; final List<Lesson> lessons;
  const CurriculumUnit(this.title,this.lessons);
}
class CurriculumClass {
  final String grade; final List<CurriculumUnit> units;
  const CurriculumClass(this.grade,this.units);
}
const mozambiqueCurriculum=<CurriculumClass>[
CurriculumClass('7.ª classe',[
CurriculumUnit('I — Introdução ao estudo da Química',[
Lesson('7-i-1','O que é a Química?','Conceito e objecto de estudo.','A Química é a ciência que estuda as substâncias, a sua composição, propriedades e transformações. Está presente nos alimentos, medicamentos, vestuário, produtos de limpeza, construção e combustíveis.','A ferrugem é uma transformação química que envolve o ferro e o oxigénio.'),
Lesson('7-i-2','História da Química','Da Alquimia à Química moderna.','A Química desenvolveu-se gradualmente a partir de práticas antigas, da Alquimia e da investigação experimental. A ciência moderna exige observação, medição, experiências e comunicação de resultados.','Uma investigação deve registar materiais, procedimento, observações e conclusão.'),
Lesson('7-i-3','Segurança e relatório experimental','Higiene, segurança e comunicação.','Nunca provar reagentes, não cheirar directamente, usar protecção adequada e seguir instruções do professor. Um relatório inclui título, objectivo, materiais, procedimento, observações, resultados e conclusão.','Uma experiência escolar só deve ser realizada com orientação docente.')
]),
CurriculumUnit('II — Matéria e suas propriedades',[
Lesson('7-ii-1','Matéria, corpo e objecto','Conceitos e propriedades gerais.','Matéria é tudo o que tem massa e ocupa espaço. Corpo é uma porção limitada de matéria; objecto é um corpo com utilidade. Propriedades gerais incluem massa, volume, inércia, impenetrabilidade, divisibilidade, elasticidade e compressibilidade.','Uma pedra é um corpo; uma pedra talhada para servir de peso pode ser um objecto.'),
Lesson('7-ii-2','Estados físicos e mudanças','Sólido, líquido e gasoso.','A matéria pode apresentar-se nos estados sólido, líquido e gasoso. Fusão, solidificação, vaporização, condensação e sublimação são mudanças físicas de estado.','O gelo funde e transforma-se em água líquida.'),
Lesson('7-ii-3','Substâncias e misturas','Substâncias puras e misturas.','Substâncias têm composição característica. Misturas combinam duas ou mais substâncias e podem ser homogéneas ou heterogéneas.','Água com sal dissolvido é uma mistura homogénea; água e óleo formam mistura heterogénea.'),
Lesson('7-ii-4','Separação de misturas','Métodos e aplicações quotidianas.','Catação, peneiração, decantação, filtração e separação magnética são usadas em misturas heterogéneas. Evaporação, cristalização e destilação simples podem separar componentes de misturas homogéneas.','A filtração pode separar areia da água; a evaporação pode recuperar sal de uma solução.')
]),
CurriculumUnit('III — Estrutura da matéria e reacções químicas',[
Lesson('7-iii-1','Átomo, elemento e molécula','Constituição e símbolos.','O átomo é constituído por núcleo e electrões. O número atómico identifica o elemento. Moléculas são agrupamentos de átomos ligados.','H2O representa uma molécula com dois átomos de hidrogénio e um de oxigénio.'),
Lesson('7-iii-2','Fórmulas e valência','Leitura e escrita de fórmulas simples.','Uma fórmula química representa os elementos e a proporção dos seus átomos. A valência ajuda a estabelecer fórmulas de compostos binários.','NaCl representa proporção 1:1 entre sódio e cloro.'),
Lesson('7-iii-3','Reacções e conservação da massa','Equações químicas e acerto.','Numa reacção química, reagentes transformam-se em produtos. A equação deve respeitar a conservação dos átomos: ajustam-se coeficientes, nunca os índices das fórmulas.','2H2 + O2 → 2H2O.'),
Lesson('7-iii-4','Tipos de reacções','Combinação, decomposição, exotérmica, endotérmica e redox.','As reacções podem ser classificadas pelo padrão de transformação e pela energia envolvida. Oxidação-redução envolve transferência de electrões ou alteração dos números de oxidação.','2H2O2 → 2H2O + O2 é uma decomposição.')
]),
CurriculumUnit('IV — Água e V — Soluções',[
Lesson('7-iv-1','Água, hidrogénio e oxigénio','Propriedades e importância.','A água é essencial à vida e participa em numerosos processos. Hidrogénio e oxigénio são elementos que formam a molécula de água.','A fórmula da água é H2O.'),
Lesson('7-v-1','Soluções e concentração','Soluto, solvente e concentração.','Uma solução é uma mistura homogénea. O solvente dissolve o soluto. A concentração expressa a quantidade de soluto numa dada quantidade de solução.','Concentração percentual em massa = massa do soluto / massa da solução × 100.')
])]),
CurriculumClass('8.ª classe',[
CurriculumUnit('I — Química no quotidiano',[
Lesson('8-i-1','Química e sociedade','Desenvolvimento sustentável e ambiente.','A Química contribui para saúde, agricultura, indústria e tratamento de água. O uso inadequado de substâncias pode causar poluição. Compostagem transforma resíduos orgânicos em material útil.','Separar resíduos e compostar matéria orgânica reduz o lixo enviado para deposição.')
]),
CurriculumUnit('II — Misturas',[
Lesson('8-ii-1','Separação e destilação','Métodos de separação e impacto social.','A escolha do método depende das propriedades dos componentes. A destilação simples e fraccionada permitem separar líquidos com base nas diferenças de volatilidade e pontos de ebulição.','A destilação fraccionada é usada para separar componentes de misturas de líquidos com pontos de ebulição próximos.')
]),
CurriculumUnit('III — Reacções químicas e velocidade das reacções',[
Lesson('8-iii-1','Reacções químicas','Evidências e equações.','Uma reacção química produz novas substâncias. Evidências podem incluir formação de gás, precipitado, mudança de cor ou variação de temperatura.','A equação química representa reagentes e produtos.'),
Lesson('8-iii-2','Cálculos químicos','Massa, quantidade de matéria e proporções.','A quantidade de matéria é medida em mol. A relação entre massa, massa molar e quantidade de matéria é n = m/M.','Para 18 g de água, com M ≈ 18 g/mol, n ≈ 1 mol.'),
Lesson('8-iii-3','Velocidade das reacções','Factores que influenciam a velocidade.','Concentração, temperatura, superfície de contacto e catalisadores podem alterar a velocidade de uma reacção.','Um sólido pulverizado tende a reagir mais depressa que um bloco do mesmo material, em condições comparáveis.')
]),
CurriculumUnit('IV — Estrutura atómica e tabela periódica',[
Lesson('8-iv-1','Estrutura atómica','Protões, neutrões e electrões.','O núcleo contém protões e neutrões; os electrões ocupam regiões em torno do núcleo. O número atómico é o número de protões.','Um átomo neutro de sódio tem 11 protões e 11 electrões.'),
Lesson('8-iv-2','Tabela periódica','Períodos, grupos e propriedades.','Os elementos estão organizados por número atómico. Elementos do mesmo grupo apresentam semelhanças químicas importantes.','Na e K pertencem ao grupo dos metais alcalinos.')
]),
CurriculumUnit('V — Ligação química',[
Lesson('8-v-1','Lewis e regra do octeto','Representação e tipos de ligação.','A ligação iónica envolve atracção entre iões; a covalente envolve partilha de pares de electrões; a metálica envolve electrões deslocalizados.','NaCl é predominantemente iónico; H2 é covalente.')
]),
CurriculumUnit('VI — Introdução às reacções de oxidação-redução',[
Lesson('8-vi-1','Oxidação e redução','Número de oxidação e combustíveis.','Oxidação e redução ocorrem simultaneamente. A combustão é uma transformação química que liberta energia.','Na formação de MgO, o magnésio é oxidado e o oxigénio é reduzido.')
])
]),
CurriculumClass('9.ª classe',[
CurriculumUnit('I — Classes dos compostos inorgânicos',[
Lesson('9-i-1','Óxidos','Compostos binários com oxigénio.','Óxidos são compostos binários em que o oxigénio se combina com outro elemento. A nomenclatura depende da composição e, para alguns metais, do número de oxidação.','CO2 — dióxido de carbono; Fe2O3 — óxido de ferro (III).'),
Lesson('9-i-2','Ácidos','Composição, propriedades e nomenclatura.','Ácidos são substâncias que, em água, aumentam a concentração de H3O+. A nomenclatura varia conforme a composição.','HCl(aq) — ácido clorídrico; H2SO4 — ácido sulfúrico.'),
Lesson('9-i-3','Bases','Hidróxidos e nomenclatura.','Muitas bases estudadas são hidróxidos metálicos. Em água, podem fornecer iões OH−.','KOH — hidróxido de potássio; NaOH — hidróxido de sódio.'),
Lesson('9-i-4','Sais e neutralização','Reacções ácido-base.','Sais são compostos iónicos. Uma neutralização entre ácido e base pode formar sal e água.','HCl + KOH → KCl + H2O.')
]),
CurriculumUnit('II — Cinética química e equilíbrio químico',[
Lesson('9-ii-1','Cinética química','Velocidade e factores.','A velocidade de reacção descreve a variação da concentração dos reagentes ou produtos ao longo do tempo.','Temperatura mais elevada pode aumentar a velocidade de muitas reacções.'),
Lesson('9-ii-2','Equilíbrio químico','Equilíbrio dinâmico.','Em equilíbrio químico, as velocidades das reacções directa e inversa são iguais; as concentrações permanecem constantes.','Alterar concentração, pressão ou temperatura pode deslocar o equilíbrio.')
]),
CurriculumUnit('III — Cloro e elementos do grupo VIIA',[
Lesson('9-iii-1','Halogéneos e cloro','Propriedades e compostos.','Os halogéneos pertencem ao grupo 17. O cloro forma cloreto de hidrogénio; em solução aquosa, este é o ácido clorídrico.','H2 + Cl2 → 2HCl.'),
Lesson('9-iii-2','Volume molar e cálculos','Relações entre mol e volume de gases.','O volume molar depende das condições de temperatura e pressão. Os cálculos devem indicar as condições usadas.','Não usar um valor de volume molar sem declarar as condições.')
]),
CurriculumUnit('IV — Carbono e elementos do grupo IVA',[
Lesson('9-iv-1','Carbono e silício','Elementos do grupo 14.','O carbono forma uma grande diversidade de compostos. O silício e os seus compostos são importantes em minerais e materiais tecnológicos.','O dióxido de silício é um componente importante da areia e do quartzo.')
]),
CurriculumUnit('V — Introdução à Química Orgânica',[
Lesson('9-v-1','Cadeias carbónicas','Tipos de cadeia e fórmulas.','A Química Orgânica estuda principalmente compostos de carbono. As cadeias podem ser abertas ou fechadas, normais ou ramificadas.','CH4 é a fórmula molecular do metano.')
]),
CurriculumUnit('VI — Hidrocarbonetos',[
Lesson('9-vi-1','Alcanos, alcenos e alcinos','Hidrocarbonetos e petróleo.','Hidrocarbonetos contêm carbono e hidrogénio. Alcanos têm ligações simples; alcenos têm pelo menos uma ligação dupla; alcinos têm pelo menos uma ligação tripla.','Etano: C2H6; eteno: C2H4; etino: C2H2.')
])
]),

CurriculumClass('10.ª classe',[
CurriculumUnit('I — Fundamentos de Química',[
Lesson('10-i-1','Química e método científico','Conceitos fundamentais e investigação.','A Química estuda as substâncias, as suas propriedades e transformações. O método científico envolve observação, formulação de problemas e hipóteses, experimentação, análise de resultados e conclusão.','Uma investigação sobre a velocidade de dissolução deve controlar as condições e registar os resultados.'),
Lesson('10-i-2','Linguagem química e estequiometria','Equações, leis ponderais e cálculos.','A linguagem química utiliza símbolos, fórmulas, equações, coeficientes e índices. Os cálculos estequiométricos aplicam a conservação da massa, as proporções definidas e a relação entre mol, massa e volume.','Na equação 2H2 + O2 → 2H2O, a proporção molar H2:O2:H2O é 2:1:2.')
]),
CurriculumUnit('II — Enxofre e elementos do VI grupo principal',[
Lesson('10-ii-1','Enxofre e seus compostos','Ocorrência, propriedades e aplicações.','O enxofre ocorre na natureza e forma óxidos como SO2 e SO3. O ácido sulfúrico tem importância industrial e agrícola. Compostos de enxofre incluem sulfuretos, sulfitos e sulfatos.','SO3 + H2O → H2SO4 é uma representação simplificada da formação de ácido sulfúrico.')
]),
CurriculumUnit('III — Nitrogénio e elementos do V grupo principal',[
Lesson('10-iii-1','Nitrogénio e fósforo','Elementos do grupo VA e fertilizantes.','O nitrogénio e o fósforo formam compostos importantes para a vida e a agricultura. O estudo inclui propriedades dos elementos, compostos de nitrogénio e fósforo e adubos.','Os fertilizantes fornecem nutrientes essenciais às plantas; a sua aplicação deve respeitar as doses recomendadas.')
]),
CurriculumUnit('IV — Funções orgânicas oxigenadas',[
Lesson('10-iv-1','Álcoois, fenóis e éteres','Grupos funcionais oxigenados.','As funções orgânicas são identificadas pelos grupos funcionais. Álcoois possuem grupo hidroxilo ligado a carbono saturado; fenóis têm hidroxilo ligado directamente a anel aromático; éteres apresentam oxigénio entre dois grupos orgânicos.','Etanol: CH3CH2OH; dimetil éter: CH3OCH3.')
])
]),
CurriculumClass('11.ª classe',[
CurriculumUnit('I — Estrutura atómica',[
Lesson('11-i-1','Modelos atómicos e mecânica quântica','Partículas fundamentais e modelos.','O estudo da estrutura atómica aborda protões, neutrões e electrões, radioactividade, experiência de Rutherford, postulados de Bohr e introdução à mecânica quântica.','O número atómico corresponde ao número de protões do núcleo.')
]),
CurriculumUnit('II — Tabela periódica',[
Lesson('11-ii-1','Lei periódica e propriedades','Organização e tendências periódicas.','A tabela periódica moderna organiza os elementos por número atómico. As propriedades periódicas variam ao longo dos períodos e grupos e ajudam a explicar o comportamento químico.','Elementos do mesmo grupo tendem a apresentar semelhanças químicas.')
]),
CurriculumUnit('III — Ligação química',[
Lesson('11-iii-1','Ligações e estrutura de Lewis','Ligação iónica, covalente e metálica.','A ligação química pode ser iónica, covalente ou metálica. As estruturas de Lewis representam electrões de valência e ajudam a interpretar ligações.','NaCl é um exemplo de composto predominantemente iónico; H2 apresenta ligação covalente.')
]),
CurriculumUnit('IV — Classes principais dos compostos inorgânicos',[
Lesson('11-iv-1','Óxidos, ácidos, bases e sais','Nomenclatura e propriedades.','As funções inorgânicas incluem óxidos, ácidos, bases e sais. A classificação, nomenclatura e reacções típicas permitem prever produtos em transformações químicas.','HCl + KOH → KCl + H2O é uma neutralização.')
]),
CurriculumUnit('V — Soluções',[
Lesson('11-v-1','Concentração e diluição','Tipos de solução e cálculos.','As soluções podem ser descritas por diferentes formas de concentração. Na diluição, a quantidade de soluto permanece constante: C1V1 = C2V2, para unidades compatíveis.','Uma solução de 2 mol/L diluída de 50 mL para 100 mL passa a 1 mol/L.')
]),
CurriculumUnit('VI — Termoquímica',[
Lesson('11-vi-1','Energia nas reacções','Entalpia e efeito energético.','As reacções podem ser exotérmicas ou endotérmicas. A variação de entalpia representa a energia transferida sob pressão constante.','Uma reacção exotérmica apresenta variação de entalpia negativa.')
])
]),
CurriculumClass('12.ª classe',[
CurriculumUnit('I — Cinética química',[
Lesson('12-i-1','Velocidade e mecanismo de reacção','Lei da velocidade e factores.','A cinética estuda a velocidade das reacções, os mecanismos e as leis de velocidade. A concentração e a temperatura podem afectar a rapidez das transformações.','A velocidade média pode ser calculada pela variação de concentração dividida pelo intervalo de tempo.')
]),
CurriculumUnit('II — Equilíbrio químico',[
Lesson('12-ii-1','Equilíbrio e constante','Equilíbrio dinâmico e Kc/Kp.','No equilíbrio dinâmico, as velocidades directa e inversa são iguais. A constante de equilíbrio relaciona as concentrações ou pressões parciais dos participantes, conforme a expressão aplicável.','Para aA + bB ⇌ cC, Kc = [C]^c / ([A]^a[B]^b), omitindo sólidos e líquidos puros.')
]),
CurriculumUnit('III — Equilíbrio químico em solução aquosa',[
Lesson('12-iii-1','Ácidos, bases e pH','Brønsted-Lowry, Ka, Kb, Kw e tampões.','A teoria de Brønsted-Lowry define ácido como dador de protões e base como aceitador. O estudo inclui Ka, Kb, Kw, pH, pOH, soluções tampão, indicadores, solubilidade e titulação.','A 25 °C, pH = −log[H3O+] e pH + pOH = 14, em condições usuais.')
]),
CurriculumUnit('IV — Reacções redox e electroquímica',[
Lesson('12-iv-1','Oxidação-redução','Número de oxidação e semi-equações.','Reacções redox envolvem transferência de electrões e variação dos números de oxidação. O acerto pode usar semi-equações ou variação do número de oxidação.','Numa pilha galvânica, a oxidação ocorre no ânodo e a redução no cátodo.'),
Lesson('12-iv-2','Células electroquímicas','Pilha, força electromotriz e electrólise.','A electroquímica estuda células galvânicas e electrolíticas. A pilha converte energia química em eléctrica; a electrólise utiliza energia eléctrica para provocar uma reacção não espontânea.','A pilha de Daniell é um exemplo clássico de célula galvânica.')
]),
CurriculumUnit('V — Química orgânica',[
Lesson('12-v-1','Funções orgânicas e biomoléculas','Revisão e aprofundamento.','O estudo inclui hidrocarbonetos, álcoois, fenóis, éteres, aldeídos, cetonas, ácidos carboxílicos, ésteres, aminas, amidas, lípidos, aminoácidos, proteínas, carboidratos e polímeros sintéticos.','As proteínas são macromoléculas formadas por aminoácidos ligados por ligações peptídicas.')
])
])
];
