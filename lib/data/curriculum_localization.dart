import 'curriculum.dart';

class LessonTranslation {
  final String title;
  final String summary;
  final String body;
  final String example;

  const LessonTranslation({
    required this.title,
    required this.summary,
    required this.body,
    required this.example,
  });
}

const englishGrades = <String, String>{
  '7.ª classe':'7th grade',
  '8.ª classe':'8th grade',
  '9.ª classe':'9th grade',
  '10.ª classe':'10th grade',
  '11.ª classe':'11th grade',
  '12.ª classe':'12th grade',
};

const englishUnits = <String, String>{
  'I — Introdução ao estudo da Química':'I — Introduction to Chemistry',
  'II — Matéria e suas propriedades':'II — Matter and its properties',
  'III — Estrutura da matéria e reacções químicas':'III — Structure of matter and chemical reactions',
  'IV — Água e V — Soluções':'IV — Water and V — Solutions',
  'I — Química no quotidiano':'I — Chemistry in everyday life',
  'II — Misturas':'II — Mixtures',
  'III — Reacções químicas e velocidade das reacções':'III — Chemical reactions and reaction rates',
  'IV — Estrutura atómica e tabela periódica':'IV — Atomic structure and the periodic table',
  'V — Ligação química':'V — Chemical bonding',
  'VI — Introdução às reacções de oxidação-redução':'VI — Introduction to oxidation-reduction reactions',
  'I — Classes dos compostos inorgânicos':'I — Classes of inorganic compounds',
  'II — Cinética química e equilíbrio químico':'II — Chemical kinetics and chemical equilibrium',
  'III — Cloro e elementos do grupo VIIA':'III — Chlorine and Group 17 elements',
  'IV — Carbono e elementos do grupo IVA':'IV — Carbon and Group 14 elements',
  'V — Introdução à Química Orgânica':'V — Introduction to Organic Chemistry',
  'VI — Hidrocarbonetos':'VI — Hydrocarbons',
  'I — Fundamentos de Química':'I — Fundamentals of Chemistry',
  'II — Enxofre e elementos do VI grupo principal':'II — Sulfur and Group 16 elements',
  'III — Nitrogénio e elementos do V grupo principal':'III — Nitrogen and Group 15 elements',
  'IV — Funções orgânicas oxigenadas':'IV — Oxygen-containing organic functional groups',
  'I — Estrutura atómica':'I — Atomic structure',
  'II — Tabela periódica':'II — The periodic table',
  'III — Ligação química':'III — Chemical bonding',
  'IV — Classes principais dos compostos inorgânicos':'IV — Main classes of inorganic compounds',
  'V — Soluções':'V — Solutions',
  'VI — Termoquímica':'VI — Thermochemistry',
  'I — Cinética química':'I — Chemical kinetics',
  'II — Equilíbrio químico':'II — Chemical equilibrium',
  'III — Equilíbrio químico em solução aquosa':'III — Chemical equilibrium in aqueous solution',
  'IV — Reacções redox e electroquímica':'IV — Redox reactions and electrochemistry',
  'V — Química orgânica':'V — Organic Chemistry',
};

const englishLessons = <String, LessonTranslation>{
  '7-i-1': LessonTranslation(title:'What is Chemistry?',summary:'Concept and scope of the subject.',body:'Chemistry is the science that studies substances, their composition, properties and transformations. It is present in food, medicines, clothing, cleaning products, construction materials and fuels.',example:'Rust is a chemical transformation involving iron and oxygen.'),
  '7-i-2': LessonTranslation(title:'History of Chemistry',summary:'From alchemy to modern Chemistry.',body:'Chemistry developed gradually from ancient practices, alchemy and experimental investigation. Modern science requires observation, measurement, experiments and communication of results.',example:'An investigation should record its materials, procedure, observations and conclusion.'),
  '7-i-3': LessonTranslation(title:'Laboratory safety and reports',summary:'Hygiene, safety and scientific communication.',body:'Never taste reagents, do not smell them directly, wear suitable protective equipment and follow the teacher’s instructions. A laboratory report includes a title, aim, materials, procedure, observations, results and conclusion.',example:'A school experiment should only be carried out under a teacher’s supervision.'),
  '7-ii-1': LessonTranslation(title:'Matter, bodies and objects',summary:'Definitions and general properties.',body:'Matter is anything that has mass and occupies space. A body is a limited portion of matter; an object is a body made for a particular use. General properties include mass, volume, inertia, impenetrability, divisibility, elasticity and compressibility.',example:'A stone is a body; a shaped stone used as a paperweight is an object.'),
  '7-ii-2': LessonTranslation(title:'States of matter and changes',summary:'Solid, liquid and gas.',body:'Matter can exist as a solid, liquid or gas. Melting, freezing, vaporisation, condensation and sublimation are physical changes of state.',example:'Ice melts and becomes liquid water.'),
  '7-ii-3': LessonTranslation(title:'Substances and mixtures',summary:'Pure substances and mixtures.',body:'Substances have a characteristic composition. Mixtures combine two or more substances and can be homogeneous or heterogeneous.',example:'Salt dissolved in water is a homogeneous mixture; water and oil form a heterogeneous mixture.'),
  '7-ii-4': LessonTranslation(title:'Separating mixtures',summary:'Methods and everyday applications.',body:'Hand sorting, sieving, decantation, filtration and magnetic separation are used for heterogeneous mixtures. Evaporation, crystallisation and simple distillation can separate components of homogeneous mixtures.',example:'Filtration can separate sand from water; evaporation can recover salt from a solution.'),
  '7-iii-1': LessonTranslation(title:'Atoms, elements and molecules',summary:'Structure and chemical symbols.',body:'An atom consists of a nucleus and electrons. The atomic number identifies the element. Molecules are groups of bonded atoms.',example:'H₂O represents a molecule containing two hydrogen atoms and one oxygen atom.'),
  '7-iii-2': LessonTranslation(title:'Formulas and valency',summary:'Reading and writing simple formulas.',body:'A chemical formula represents the elements in a substance and the ratio of their atoms. Valency helps establish formulas for binary compounds.',example:'NaCl represents a 1:1 ratio between sodium and chlorine.'),
  '7-iii-3': LessonTranslation(title:'Reactions and conservation of mass',summary:'Chemical equations and balancing.',body:'In a chemical reaction, reactants are transformed into products. The equation must obey conservation of atoms: adjust coefficients, never the subscripts inside chemical formulas.',example:'2H₂ + O₂ → 2H₂O.'),
  '7-iii-4': LessonTranslation(title:'Types of chemical reactions',summary:'Combination, decomposition, exothermic, endothermic and redox reactions.',body:'Reactions can be classified by their transformation pattern and the energy involved. Oxidation-reduction involves electron transfer or a change in oxidation numbers.',example:'2H₂O₂ → 2H₂O + O₂ is a decomposition reaction.'),
  '7-iv-1': LessonTranslation(title:'Water, hydrogen and oxygen',summary:'Properties and importance.',body:'Water is essential to life and participates in many processes. Hydrogen and oxygen are elements that form the water molecule.',example:'The formula for water is H₂O.'),
  '7-v-1': LessonTranslation(title:'Solutions and concentration',summary:'Solute, solvent and concentration.',body:'A solution is a homogeneous mixture. The solvent dissolves the solute. Concentration expresses the amount of solute in a given amount of solution.',example:'Mass percentage concentration = mass of solute / mass of solution × 100.'),
  '8-i-1': LessonTranslation(title:'Chemistry and society',summary:'Sustainable development and the environment.',body:'Chemistry contributes to health, agriculture, industry and water treatment. Improper use of substances can cause pollution. Composting transforms organic waste into useful material.',example:'Sorting waste and composting organic matter reduces the amount of rubbish sent to landfill.'),
  '8-ii-1': LessonTranslation(title:'Separation and distillation',summary:'Separation methods and their social impact.',body:'The method depends on the properties of the components. Simple and fractional distillation separate liquids based on differences in volatility and boiling points.',example:'Fractional distillation is used to separate components of liquid mixtures with similar boiling points.'),
  '8-iii-1': LessonTranslation(title:'Chemical reactions',summary:'Evidence of chemical change and equations.',body:'A chemical reaction produces new substances. Evidence may include gas formation, a precipitate, a colour change or a temperature change.',example:'A chemical equation represents the reactants and products.'),
  '8-iii-2': LessonTranslation(title:'Chemical calculations',summary:'Mass, amount of substance and ratios.',body:'The amount of substance is measured in moles. The relationship between mass, molar mass and amount of substance is n = m/M.',example:'For 18 g of water, with M ≈ 18 g/mol, n ≈ 1 mol.'),
  '8-iii-3': LessonTranslation(title:'Reaction rates',summary:'Factors that influence reaction speed.',body:'Concentration, temperature, surface area and catalysts can change the rate of a reaction.',example:'A powdered solid tends to react faster than a block of the same material under comparable conditions.'),
  '8-iv-1': LessonTranslation(title:'Atomic structure',summary:'Protons, neutrons and electrons.',body:'The nucleus contains protons and neutrons; electrons occupy regions around the nucleus. The atomic number is the number of protons.',example:'A neutral sodium atom has 11 protons and 11 electrons.'),
  '8-iv-2': LessonTranslation(title:'The periodic table',summary:'Periods, groups and properties.',body:'Elements are organised by increasing atomic number. Elements in the same group show important chemical similarities.',example:'Sodium (Na) and potassium (K) belong to the alkali-metal group.'),
  '8-v-1': LessonTranslation(title:'Lewis structures and the octet rule',summary:'Representations and types of chemical bonds.',body:'An ionic bond involves attraction between ions; a covalent bond involves sharing electron pairs; a metallic bond involves delocalised electrons.',example:'NaCl is predominantly ionic; H₂ is covalent.'),
  '8-vi-1': LessonTranslation(title:'Oxidation and reduction',summary:'Oxidation numbers and fuels.',body:'Oxidation and reduction occur together. Combustion is a chemical transformation that releases energy.',example:'When MgO forms, magnesium is oxidised and oxygen is reduced.'),
  '9-i-1': LessonTranslation(title:'Oxides',summary:'Binary compounds containing oxygen.',body:'Oxides are binary compounds in which oxygen is combined with another element. Naming depends on composition and, for some metals, the oxidation number.',example:'CO₂ — carbon dioxide; Fe₂O₃ — iron(III) oxide.'),
  '9-i-2': LessonTranslation(title:'Acids',summary:'Composition, properties and nomenclature.',body:'Acids are substances that increase the concentration of H₃O⁺ in water. Their names depend on their composition.',example:'HCl(aq) — hydrochloric acid; H₂SO₄ — sulfuric acid.'),
  '9-i-3': LessonTranslation(title:'Bases',summary:'Hydroxides and nomenclature.',body:'Many bases studied at this level are metal hydroxides. In water, they can provide OH⁻ ions.',example:'KOH — potassium hydroxide; NaOH — sodium hydroxide.'),
  '9-i-4': LessonTranslation(title:'Salts and neutralisation',summary:'Acid-base reactions.',body:'Salts are ionic compounds. A neutralisation reaction between an acid and a base can produce a salt and water.',example:'HCl + KOH → KCl + H₂O.'),
  '9-ii-1': LessonTranslation(title:'Chemical kinetics',summary:'Reaction rate and influencing factors.',body:'Reaction rate describes the change in reactant or product concentration over time.',example:'A higher temperature can increase the rate of many reactions.'),
  '9-ii-2': LessonTranslation(title:'Chemical equilibrium',summary:'Dynamic equilibrium.',body:'At chemical equilibrium, the forward and reverse reaction rates are equal; concentrations remain constant.',example:'Changing concentration, pressure or temperature can shift the equilibrium position.'),
  '9-iii-1': LessonTranslation(title:'Halogens and chlorine',summary:'Properties and compounds.',body:'Halogens belong to Group 17. Chlorine forms hydrogen chloride; in aqueous solution, it is called hydrochloric acid.',example:'H₂ + Cl₂ → 2HCl.'),
  '9-iii-2': LessonTranslation(title:'Molar volume and calculations',summary:'Relationships between moles and gas volume.',body:'Molar volume depends on temperature and pressure. Calculations must state the conditions being used.',example:'Do not use a molar-volume value without stating the conditions.'),
  '9-iv-1': LessonTranslation(title:'Carbon and silicon',summary:'Elements of Group 14.',body:'Carbon forms a wide variety of compounds. Silicon and its compounds are important in minerals and technological materials.',example:'Silicon dioxide is a major component of sand and quartz.'),
  '9-v-1': LessonTranslation(title:'Carbon chains',summary:'Types of carbon chains and formulas.',body:'Organic Chemistry mainly studies carbon compounds. Carbon chains can be open or cyclic, straight or branched.',example:'CH₄ is the molecular formula of methane.'),
  '9-vi-1': LessonTranslation(title:'Alkanes, alkenes and alkynes',summary:'Hydrocarbons and petroleum.',body:'Hydrocarbons contain carbon and hydrogen. Alkanes have single bonds; alkenes have at least one double bond; alkynes have at least one triple bond.',example:'Ethane: C₂H₆; ethene: C₂H₄; ethyne: C₂H₂.'),
  '10-i-1': LessonTranslation(title:'Chemistry and the scientific method',summary:'Fundamental concepts and investigation.',body:'Chemistry studies substances, their properties and transformations. The scientific method includes observation, formulating questions and hypotheses, experimentation, analysing results and drawing conclusions.',example:'An investigation into the rate of dissolving should control conditions and record the results.'),
  '10-i-2': LessonTranslation(title:'Chemical language and stoichiometry',summary:'Equations, mass laws and calculations.',body:'Chemical language uses symbols, formulas, equations, coefficients and subscripts. Stoichiometric calculations apply conservation of mass, definite proportions and relationships between moles, mass and volume.',example:'In 2H₂ + O₂ → 2H₂O, the mole ratio H₂:O₂:H₂O is 2:1:2.'),
  '10-ii-1': LessonTranslation(title:'Sulfur and its compounds',summary:'Occurrence, properties and applications.',body:'Sulfur occurs naturally and forms oxides such as SO₂ and SO₃. Sulfuric acid is important in industry and agriculture. Sulfur compounds include sulfides, sulfites and sulfates.',example:'SO₃ + H₂O → H₂SO₄ is a simplified representation of sulfuric acid formation.'),
  '10-iii-1': LessonTranslation(title:'Nitrogen and phosphorus',summary:'Group 15 elements and fertilisers.',body:'Nitrogen and phosphorus form compounds that are important for life and agriculture. The topic includes element properties, nitrogen and phosphorus compounds, and fertilisers.',example:'Fertilisers provide essential nutrients to plants; application should follow recommended amounts.'),
  '10-iv-1': LessonTranslation(title:'Alcohols, phenols and ethers',summary:'Oxygen-containing functional groups.',body:'Organic functions are identified by their functional groups. Alcohols have a hydroxyl group attached to a saturated carbon; phenols have a hydroxyl group directly attached to an aromatic ring; ethers have an oxygen atom between two organic groups.',example:'Ethanol: CH₃CH₂OH; dimethyl ether: CH₃OCH₃.'),
  '11-i-1': LessonTranslation(title:'Atomic models and quantum mechanics',summary:'Fundamental particles and atomic models.',body:'The study of atomic structure includes protons, neutrons and electrons, radioactivity, Rutherford’s experiment, Bohr’s postulates and an introduction to quantum mechanics.',example:'The atomic number is the number of protons in the nucleus.'),
  '11-ii-1': LessonTranslation(title:'Periodic law and properties',summary:'Periodic organisation and trends.',body:'The modern periodic table organises elements by atomic number. Periodic properties vary across periods and down groups and help explain chemical behaviour.',example:'Elements in the same group tend to show similar chemical properties.'),
  '11-iii-1': LessonTranslation(title:'Chemical bonds and Lewis structures',summary:'Ionic, covalent and metallic bonding.',body:'Chemical bonding can be ionic, covalent or metallic. Lewis structures represent valence electrons and help explain bonding.',example:'NaCl is an example of a predominantly ionic compound; H₂ has a covalent bond.'),
  '11-iv-1': LessonTranslation(title:'Main classes of inorganic compounds',summary:'Nomenclature and properties.',body:'Inorganic functions include oxides, acids, bases and salts. Classification, nomenclature and typical reactions help predict products in chemical transformations.',example:'HCl + KOH → KCl + H₂O is a neutralisation reaction.'),
  '11-v-1': LessonTranslation(title:'Solutions and dilution',summary:'Types of solutions and calculations.',body:'Solutions can be described using different concentration units. During dilution, the amount of solute remains constant: C₁V₁ = C₂V₂, using compatible units.',example:'A 2 mol/L solution diluted from 50 mL to 100 mL becomes 1 mol/L.'),
  '11-vi-1': LessonTranslation(title:'Energy in chemical reactions',summary:'Enthalpy and energy changes.',body:'Reactions can be exothermic or endothermic. The enthalpy change represents energy transferred at constant pressure.',example:'An exothermic reaction has a negative enthalpy change.'),
  '12-i-1': LessonTranslation(title:'Reaction rates and mechanisms',summary:'Rate laws and influencing factors.',body:'Kinetics studies reaction rates, mechanisms and rate laws. Concentration and temperature can affect how quickly transformations occur.',example:'Average rate can be calculated from the change in concentration divided by the time interval.'),
  '12-ii-1': LessonTranslation(title:'Equilibrium and equilibrium constants',summary:'Dynamic equilibrium and Kc/Kp.',body:'At dynamic equilibrium, the forward and reverse reaction rates are equal. The equilibrium constant relates concentrations or partial pressures of participants, depending on the applicable expression.',example:'For aA + bB ⇌ cC, Kc = [C]^c / ([A]^a[B]^b), omitting pure solids and liquids.'),
  '12-iii-1': LessonTranslation(title:'Acids, bases and pH',summary:'Brønsted–Lowry theory, Ka, Kb, Kw and buffers.',body:'Brønsted–Lowry theory defines an acid as a proton donor and a base as a proton acceptor. The topic includes Ka, Kb, Kw, pH, pOH, buffer solutions, indicators, solubility and titration.',example:'At 25 °C, pH = −log[H₃O⁺] and pH + pOH = 14 under usual conditions.'),
  '12-iv-1': LessonTranslation(title:'Oxidation-reduction reactions',summary:'Oxidation numbers and half-equations.',body:'Redox reactions involve electron transfer and changes in oxidation numbers. Equations can be balanced using half-reactions or changes in oxidation numbers.',example:'In a galvanic cell, oxidation occurs at the anode and reduction occurs at the cathode.'),
  '12-iv-2': LessonTranslation(title:'Electrochemical cells',summary:'Galvanic cells, electromotive force and electrolysis.',body:'Electrochemistry studies galvanic and electrolytic cells. A galvanic cell converts chemical energy into electrical energy; electrolysis uses electrical energy to drive a non-spontaneous reaction.',example:'The Daniell cell is a classic example of a galvanic cell.'),
  '12-v-1': LessonTranslation(title:'Organic functional groups and biomolecules',summary:'Review and advanced topics.',body:'The topic includes hydrocarbons, alcohols, phenols, ethers, aldehydes, ketones, carboxylic acids, esters, amines, amides, lipids, amino acids, proteins, carbohydrates and synthetic polymers.',example:'Proteins are macromolecules formed from amino acids joined by peptide bonds.'),
};

String localizedGrade(String grade, bool english) =>
    english ? (englishGrades[grade] ?? grade) : grade;

String localizedUnitTitle(String title, bool english) =>
    english ? (englishUnits[title] ?? title) : title;

String localizedLessonTitle(Lesson lesson, bool english) =>
    english ? (englishLessons[lesson.id]?.title ?? lesson.title) : lesson.title;

String localizedLessonSummary(Lesson lesson, bool english) =>
    english ? (englishLessons[lesson.id]?.summary ?? lesson.summary) : lesson.summary;

String localizedLessonBody(Lesson lesson, bool english) =>
    english ? (englishLessons[lesson.id]?.body ?? lesson.body) : lesson.body;

String localizedLessonExample(Lesson lesson, bool english) =>
    english ? (englishLessons[lesson.id]?.example ?? lesson.example) : lesson.example;
