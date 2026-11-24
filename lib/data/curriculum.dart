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
])
];
