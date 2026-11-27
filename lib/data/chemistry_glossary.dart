enum GlossaryCategory {
  foundations,
  atoms,
  reactions,
  compounds,
  calculations,
}

class ChemistryTerm {
  final String id;
  final String termPt;
  final String termEn;
  final String definitionPt;
  final String definitionEn;
  final String examplePt;
  final String exampleEn;
  final GlossaryCategory category;

  const ChemistryTerm({
    required this.id,
    required this.termPt,
    required this.termEn,
    required this.definitionPt,
    required this.definitionEn,
    required this.examplePt,
    required this.exampleEn,
    required this.category,
  });
}

const List<ChemistryTerm> chemistryGlossary = [
  ChemistryTerm(id:'matter',termPt:'Matéria',termEn:'Matter',definitionPt:'Tudo aquilo que tem massa e ocupa espaço.',definitionEn:'Anything that has mass and occupies space.',examplePt:'Água, ar, madeira e ferro são exemplos de matéria.',exampleEn:'Water, air, wood and iron are examples of matter.',category:GlossaryCategory.foundations),
  ChemistryTerm(id:'substance',termPt:'Substância',termEn:'Substance',definitionPt:'Tipo de matéria com composição química característica.',definitionEn:'A kind of matter with a characteristic chemical composition.',examplePt:'A água pura é uma substância composta.',exampleEn:'Pure water is a chemical compound.',category:GlossaryCategory.foundations),
  ChemistryTerm(id:'mixture',termPt:'Mistura',termEn:'Mixture',definitionPt:'Combinação de duas ou mais substâncias sem formar necessariamente uma nova substância.',definitionEn:'A combination of two or more substances that does not necessarily form a new substance.',examplePt:'Água salgada é uma mistura homogénea.',exampleEn:'Salt water is a homogeneous mixture.',category:GlossaryCategory.foundations),
  ChemistryTerm(id:'element',termPt:'Elemento químico',termEn:'Chemical element',definitionPt:'Tipo de átomo definido pelo mesmo número de protões no núcleo.',definitionEn:'A type of atom defined by the same number of protons in its nucleus.',examplePt:'Todos os átomos com Z = 8 são oxigénio.',exampleEn:'All atoms with Z = 8 are oxygen.',category:GlossaryCategory.atoms),
  ChemistryTerm(id:'atom',termPt:'Átomo',termEn:'Atom',definitionPt:'Unidade de um elemento que conserva a sua identidade química; tem núcleo e electrões.',definitionEn:'A unit of an element that retains its chemical identity; it has a nucleus and electrons.',examplePt:'Um átomo neutro de carbono tem 6 protões e 6 electrões.',exampleEn:'A neutral carbon atom has 6 protons and 6 electrons.',category:GlossaryCategory.atoms),
  ChemistryTerm(id:'molecule',termPt:'Molécula',termEn:'Molecule',definitionPt:'Conjunto definido de dois ou mais átomos ligados quimicamente.',definitionEn:'A defined group of two or more atoms chemically bonded together.',examplePt:'H₂O é uma molécula com dois átomos de hidrogénio e um de oxigénio.',exampleEn:'H₂O is a molecule with two hydrogen atoms and one oxygen atom.',category:GlossaryCategory.atoms),
  ChemistryTerm(id:'proton',termPt:'Protão',termEn:'Proton',definitionPt:'Partícula subatómica com carga eléctrica positiva, localizada no núcleo.',definitionEn:'A positively charged subatomic particle found in the nucleus.',examplePt:'O número de protões determina o número atómico Z.',exampleEn:'The number of protons determines the atomic number Z.',category:GlossaryCategory.atoms),
  ChemistryTerm(id:'neutron',termPt:'Neutrão',termEn:'Neutron',definitionPt:'Partícula subatómica sem carga eléctrica, localizada no núcleo.',definitionEn:'An electrically neutral subatomic particle found in the nucleus.',examplePt:'N = A − Z calcula o número de neutrões.',exampleEn:'N = A − Z calculates the number of neutrons.',category:GlossaryCategory.atoms),
  ChemistryTerm(id:'electron',termPt:'Electrão',termEn:'Electron',definitionPt:'Partícula subatómica com carga eléctrica negativa, encontrada em regiões à volta do núcleo.',definitionEn:'A negatively charged subatomic particle found in regions around the nucleus.',examplePt:'Num átomo neutro, o número de electrões é igual a Z.',exampleEn:'In a neutral atom, the number of electrons equals Z.',category:GlossaryCategory.atoms),
  ChemistryTerm(id:'atomic-number',termPt:'Número atómico (Z)',termEn:'Atomic number (Z)',definitionPt:'Número de protões no núcleo. Identifica o elemento químico.',definitionEn:'The number of protons in the nucleus. It identifies the chemical element.',examplePt:'O carbono tem Z = 6.',exampleEn:'Carbon has Z = 6.',category:GlossaryCategory.atoms),
  ChemistryTerm(id:'mass-number',termPt:'Número de massa (A)',termEn:'Mass number (A)',definitionPt:'Soma do número de protões e neutrões no núcleo de um isótopo.',definitionEn:'The total number of protons and neutrons in the nucleus of an isotope.',examplePt:'No carbono-12, A = 12 e Z = 6.',exampleEn:'In carbon-12, A = 12 and Z = 6.',category:GlossaryCategory.atoms),
  ChemistryTerm(id:'isotope',termPt:'Isótopo',termEn:'Isotope',definitionPt:'Átomos do mesmo elemento com igual Z e diferentes números de neutrões.',definitionEn:'Atoms of the same element with the same Z but different numbers of neutrons.',examplePt:'Carbono-12 e carbono-14 são isótopos do carbono.',exampleEn:'Carbon-12 and carbon-14 are isotopes of carbon.',category:GlossaryCategory.atoms),
  ChemistryTerm(id:'electron-configuration',termPt:'Configuração electrónica',termEn:'Electron configuration',definitionPt:'Descrição da distribuição dos electrões pelos subníveis de energia de um átomo ou ião.',definitionEn:'A description of how electrons occupy energy subshells in an atom or ion.',examplePt:'O oxigénio tem configuração 1s² 2s² 2p⁴.',exampleEn:'Oxygen has the configuration 1s² 2s² 2p⁴.',category:GlossaryCategory.atoms),
  ChemistryTerm(id:'valence-electron',termPt:'Electrão de valência',termEn:'Valence electron',definitionPt:'Electrão da camada mais externa que pode participar nas ligações químicas.',definitionEn:'An electron in the outer shell that can participate in chemical bonding.',examplePt:'O sódio tem um electrão de valência.',exampleEn:'Sodium has one valence electron.',category:GlossaryCategory.atoms),
  ChemistryTerm(id:'reactant',termPt:'Reagente',termEn:'Reactant',definitionPt:'Substância presente no início de uma reacção química.',definitionEn:'A substance present at the start of a chemical reaction.',examplePt:'Em 2H₂ + O₂ → 2H₂O, H₂ e O₂ são reagentes.',exampleEn:'In 2H₂ + O₂ → 2H₂O, H₂ and O₂ are reactants.',category:GlossaryCategory.reactions),
  ChemistryTerm(id:'product',termPt:'Produto',termEn:'Product',definitionPt:'Substância formada numa reacção química.',definitionEn:'A substance formed in a chemical reaction.',examplePt:'Na reacção 2H₂ + O₂ → 2H₂O, a água é o produto.',exampleEn:'In 2H₂ + O₂ → 2H₂O, water is the product.',category:GlossaryCategory.reactions),
  ChemistryTerm(id:'coefficient',termPt:'Coeficiente',termEn:'Coefficient',definitionPt:'Número colocado antes de uma fórmula numa equação; indica a proporção de partículas ou moles.',definitionEn:'A number placed before a formula in an equation; it gives the ratio of particles or moles.',examplePt:'Em 2H₂O, o coeficiente 2 indica duas moléculas de água.',exampleEn:'In 2H₂O, the coefficient 2 indicates two water molecules.',category:GlossaryCategory.reactions),
  ChemistryTerm(id:'subscript',termPt:'Índice',termEn:'Subscript',definitionPt:'Número pequeno dentro da fórmula que indica quantos átomos de um elemento existem na unidade representada.',definitionEn:'A small number within a formula that indicates how many atoms of an element are present in the represented unit.',examplePt:'Em H₂O, o índice 2 indica dois átomos de hidrogénio.',exampleEn:'In H₂O, the subscript 2 indicates two hydrogen atoms.',category:GlossaryCategory.reactions),
  ChemistryTerm(id:'balanced-equation',termPt:'Equação equilibrada',termEn:'Balanced equation',definitionPt:'Equação em que cada elemento tem o mesmo número de átomos nos reagentes e nos produtos.',definitionEn:'An equation in which each element has the same number of atoms in the reactants and products.',examplePt:'2H₂ + O₂ → 2H₂O conserva quatro H e dois O em cada lado.',exampleEn:'2H₂ + O₂ → 2H₂O conserves four H and two O atoms on each side.',category:GlossaryCategory.reactions),
  ChemistryTerm(id:'conservation-mass',termPt:'Conservação da massa',termEn:'Conservation of mass',definitionPt:'Numa reacção química em sistema fechado, a massa total dos reagentes é igual à massa total dos produtos.',definitionEn:'In a chemical reaction in a closed system, the total mass of the reactants equals the total mass of the products.',examplePt:'Os átomos reorganizam-se, mas não são criados nem destruídos numa reacção química comum.',exampleEn:'Atoms are rearranged but are not created or destroyed in an ordinary chemical reaction.',category:GlossaryCategory.reactions),
  ChemistryTerm(id:'neutralisation',termPt:'Neutralização',termEn:'Neutralisation',definitionPt:'Reacção entre um ácido e uma base. Em muitos exemplos escolares forma um sal e água.',definitionEn:'A reaction between an acid and a base. Many school-level examples form a salt and water.',examplePt:'HCl + KOH → KCl + H₂O.',exampleEn:'HCl + KOH → KCl + H₂O.',category:GlossaryCategory.reactions),
  ChemistryTerm(id:'precipitate',termPt:'Precipitado',termEn:'Precipitate',definitionPt:'Sólido que se forma numa solução durante uma reacção, geralmente por ser pouco solúvel.',definitionEn:'A solid that forms in a solution during a reaction, usually because it is poorly soluble.',examplePt:'AgCl pode formar um precipitado branco quando Ag⁺ encontra Cl⁻.',exampleEn:'AgCl can form a white precipitate when Ag⁺ meets Cl⁻.',category:GlossaryCategory.reactions),
  ChemistryTerm(id:'catalyst',termPt:'Catalisador',termEn:'Catalyst',definitionPt:'Substância que altera a velocidade de uma reacção sem ser consumida globalmente.',definitionEn:'A substance that changes the rate of a reaction without being consumed overall.',examplePt:'Um catalisador pode acelerar uma reacção ao oferecer um caminho com menor energia de activação.',exampleEn:'A catalyst can speed up a reaction by providing a pathway with lower activation energy.',category:GlossaryCategory.reactions),
  ChemistryTerm(id:'oxidation',termPt:'Oxidação',termEn:'Oxidation',definitionPt:'Processo associado à perda de electrões ou ao aumento do número de oxidação.',definitionEn:'A process associated with loss of electrons or an increase in oxidation number.',examplePt:'Mg → Mg²⁺ + 2e⁻ é uma semi-reacção de oxidação.',exampleEn:'Mg → Mg²⁺ + 2e⁻ is an oxidation half-reaction.',category:GlossaryCategory.reactions),
  ChemistryTerm(id:'reduction',termPt:'Redução',termEn:'Reduction',definitionPt:'Processo associado ao ganho de electrões ou à diminuição do número de oxidação.',definitionEn:'A process associated with gain of electrons or a decrease in oxidation number.',examplePt:'Cu²⁺ + 2e⁻ → Cu é uma semi-reacção de redução.',exampleEn:'Cu²⁺ + 2e⁻ → Cu is a reduction half-reaction.',category:GlossaryCategory.reactions),
  ChemistryTerm(id:'acid',termPt:'Ácido',termEn:'Acid',definitionPt:'Segundo Brønsted–Lowry, espécie que doa protões (H⁺). Em água, muitos ácidos aumentam H₃O⁺.',definitionEn:'Under Brønsted–Lowry theory, a species that donates protons (H⁺). In water, many acids increase H₃O⁺.',examplePt:'HCl é um ácido forte em água.',exampleEn:'HCl is a strong acid in water.',category:GlossaryCategory.compounds),
  ChemistryTerm(id:'base',termPt:'Base',termEn:'Base',definitionPt:'Segundo Brønsted–Lowry, espécie que aceita protões (H⁺).',definitionEn:'Under Brønsted–Lowry theory, a species that accepts protons (H⁺).',examplePt:'NH₃ aceita um protão e forma NH₄⁺.',exampleEn:'NH₃ accepts a proton and forms NH₄⁺.',category:GlossaryCategory.compounds),
  ChemistryTerm(id:'oxide',termPt:'Óxido',termEn:'Oxide',definitionPt:'Composto binário em que o oxigénio está combinado com outro elemento.',definitionEn:'A binary compound in which oxygen is combined with another element.',examplePt:'CO₂ é dióxido de carbono; CaO é óxido de cálcio.',exampleEn:'CO₂ is carbon dioxide; CaO is calcium oxide.',category:GlossaryCategory.compounds),
  ChemistryTerm(id:'salt',termPt:'Sal',termEn:'Salt',definitionPt:'Composto iónico formado por catiões e aniões; muitos resultam de reacções ácido-base.',definitionEn:'An ionic compound made of cations and anions; many are formed in acid-base reactions.',examplePt:'NaCl é cloreto de sódio.',exampleEn:'NaCl is sodium chloride.',category:GlossaryCategory.compounds),
  ChemistryTerm(id:'mole',termPt:'Mol',termEn:'Mole',definitionPt:'Unidade SI da quantidade de matéria; um mol contém exactamente 6,02214076 × 10²³ entidades elementares.',definitionEn:'The SI unit for amount of substance; one mole contains exactly 6.02214076 × 10²³ elementary entities.',examplePt:'Um mol de moléculas de água contém 6,02214076 × 10²³ moléculas.',exampleEn:'One mole of water molecules contains 6.02214076 × 10²³ molecules.',category:GlossaryCategory.calculations),
  ChemistryTerm(id:'molar-mass',termPt:'Massa molar',termEn:'Molar mass',definitionPt:'Massa por unidade de quantidade de matéria, normalmente expressa em g/mol.',definitionEn:'Mass per amount of substance, commonly expressed in g/mol.',examplePt:'A massa molar aproximada da água é 18,015 g/mol.',exampleEn:'The approximate molar mass of water is 18.015 g/mol.',category:GlossaryCategory.calculations),
  ChemistryTerm(id:'concentration',termPt:'Concentração molar',termEn:'Molar concentration',definitionPt:'Quantidade de matéria do soluto dividida pelo volume da solução, em mol/L.',definitionEn:'Amount of solute divided by the volume of solution, expressed in mol/L.',examplePt:'C = n/V.',exampleEn:'C = n/V.',category:GlossaryCategory.calculations),
  ChemistryTerm(id:'dilution',termPt:'Diluição',termEn:'Dilution',definitionPt:'Processo de diminuir a concentração de uma solução, adicionando solvente.',definitionEn:'The process of lowering a solution concentration by adding solvent.',examplePt:'Para uma diluição simples, C₁V₁ = C₂V₂.',exampleEn:'For a simple dilution, C₁V₁ = C₂V₂.',category:GlossaryCategory.calculations),
  ChemistryTerm(id:'density',termPt:'Densidade',termEn:'Density',definitionPt:'Massa por unidade de volume.',definitionEn:'Mass per unit volume.',examplePt:'d = m/V.',exampleEn:'d = m/V.',category:GlossaryCategory.calculations),
];

String glossaryCategoryName(GlossaryCategory category, bool english) {
  if (english) {
    switch (category) {
      case GlossaryCategory.foundations: return 'Foundations';
      case GlossaryCategory.atoms: return 'Atoms & elements';
      case GlossaryCategory.reactions: return 'Reactions';
      case GlossaryCategory.compounds: return 'Substances';
      case GlossaryCategory.calculations: return 'Calculations';
    }
  }
  switch (category) {
    case GlossaryCategory.foundations: return 'Fundamentos';
    case GlossaryCategory.atoms: return 'Átomos e elementos';
    case GlossaryCategory.reactions: return 'Reacções';
    case GlossaryCategory.compounds: return 'Substâncias';
    case GlossaryCategory.calculations: return 'Cálculos';
  }
}
