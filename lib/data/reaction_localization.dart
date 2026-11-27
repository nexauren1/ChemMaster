import '../chemistry/reaction_predictor.dart';

class ReactionText {
  final String title;
  final String type;
  final String summary;
  final List<String> explanations;
  final String? note;

  const ReactionText({
    required this.title,
    required this.type,
    required this.summary,
    required this.explanations,
    this.note,
  });
}

const Map<String, ReactionText> _englishReactions = {
  'Formação do ácido carbónico': ReactionText(
    title:'Formation of carbonic acid',
    type:'Synthesis • acidic oxide + water',
    summary:'Carbon dioxide reacts partly with water to form weak carbonic acid (H₂CO₃).',
    explanations:[
      'Carbon dioxide (CO₂) is an acidic oxide.',
      'When CO₂ dissolves in water, a portion reacts to form carbonic acid (H₂CO₃).',
      'The balanced equation conserves 1 carbon, 2 hydrogen and 3 oxygen atoms on each side.',
    ],
    note:'In water this is a reversible equilibrium: CO₂ + H₂O ⇌ H₂CO₃. Not all dissolved CO₂ is converted to carbonic acid.',
  ),
  'Formação do ácido sulfuroso': ReactionText(
    title:'Formation of sulfurous acid',
    type:'Synthesis • acidic oxide + water',
    summary:'The school-level representation shows sulfurous acid (H₂SO₃) forming.',
    explanations:[
      'SO₂ is an acidic oxide of sulfur.',
      'Its reaction with water is represented as the formation of H₂SO₃.',
      'Sulfur, hydrogen and oxygen atoms are conserved on both sides.',
    ],
    note:'Dissolved sulfur dioxide forms an equilibrium mixture of species; this equation is a simplified school-level representation.',
  ),
  'Formação do ácido sulfúrico': ReactionText(
    title:'Formation of sulfuric acid',
    type:'Synthesis • acidic oxide + water',
    summary:'Sulfur trioxide reacts with water to form sulfuric acid (H₂SO₄).',
    explanations:[
      'SO₃ is an acidic oxide.',
      'Combining SO₃ with water gives H₂SO₄.',
      'The molecular ratio is one SO₃ molecule to one water molecule.',
    ],
  ),
  'Formação do ácido nítrico': ReactionText(
    title:'Formation of nitric acid',
    type:'Synthesis • acidic oxide + water',
    summary:'Dinitrogen pentoxide reacts with water to form nitric acid (HNO₃).',
    explanations:[
      'N₂O₅ is the acid anhydride corresponding to nitric acid.',
      'Water supplies hydrogen and oxygen for HNO₃.',
      'Two HNO₃ molecules are needed to conserve the two nitrogen atoms.',
    ],
  ),
  'Formação do ácido fosfórico': ReactionText(
    title:'Formation of phosphoric acid',
    type:'Synthesis • acidic oxide + water',
    summary:'Phosphorus(V) oxide reacts with water to form phosphoric acid.',
    explanations:[
      'P₂O₅ is an acidic oxide of phosphorus.',
      'It can react with water to form H₃PO₄.',
      'The balanced equation uses 3H₂O and 2H₃PO₄ to conserve P, H and O.',
    ],
  ),
  'Formação do hidróxido de cálcio': ReactionText(
    title:'Formation of calcium hydroxide',
    type:'Synthesis • basic oxide + water',
    summary:'Calcium oxide and water form calcium hydroxide, Ca(OH)₂.',
    explanations:[
      'CaO is a basic oxide.',
      'It reacts with water to form calcium hydroxide.',
      'The OH group appears twice because the formula is Ca(OH)₂.',
    ],
    note:'The reaction releases heat. This is a chemistry explanation, not an instruction to mix substances.',
  ),
  'Formação do hidróxido de sódio': ReactionText(
    title:'Formation of sodium hydroxide',
    type:'Synthesis • basic oxide + water',
    summary:'Sodium oxide reacts with water to form sodium hydroxide (NaOH).',
    explanations:[
      'Na₂O is a basic oxide.',
      'Its reaction with water produces NaOH.',
      'Two NaOH units are required to conserve the two sodium atoms.',
    ],
  ),
  'Formação do hidróxido de potássio': ReactionText(
    title:'Formation of potassium hydroxide',
    type:'Synthesis • basic oxide + water',
    summary:'Potassium oxide reacts with water to form potassium hydroxide (KOH).',
    explanations:[
      'K₂O is a basic oxide.',
      'It reacts with water to form KOH.',
      'The balanced equation places 2KOH among the products.',
    ],
  ),
  'Formação da água': ReactionText(
    title:'Formation of water',
    type:'Synthesis',
    summary:'Hydrogen and oxygen combine to form water.',
    explanations:[
      'Elemental hydrogen is H₂ and elemental oxygen is O₂.',
      'The product is H₂O.',
      'The balanced equation is 2H₂ + O₂ → 2H₂O: each side has four H atoms and two O atoms.',
    ],
    note:'The reaction between hydrogen and oxygen can release a great deal of energy. Do not attempt it experimentally.',
  ),
  'Formação do óxido de magnésio': ReactionText(
    title:'Formation of magnesium oxide',
    type:'Synthesis • metal + oxygen',
    summary:'Magnesium combines with oxygen to form magnesium oxide (MgO).',
    explanations:[
      'Magnesium combines with molecular oxygen.',
      'The binary product is MgO.',
      'The balanced equation is 2Mg + O₂ → 2MgO.',
    ],
  ),
  'Combustão completa do carbono': ReactionText(
    title:'Complete combustion of carbon',
    type:'Combustion',
    summary:'With sufficient oxygen, carbon forms carbon dioxide (CO₂).',
    explanations:[
      'Carbon reacts with molecular oxygen.',
      'In complete combustion, the product is CO₂.',
      'One carbon atom and two oxygen atoms are present on each side.',
    ],
    note:'With limited oxygen, carbon monoxide (CO) may form instead.',
  ),
  'Combustão completa do metano': ReactionText(
    title:'Complete combustion of methane',
    type:'Hydrocarbon combustion',
    summary:'Methane forms carbon dioxide and water when enough oxygen is available.',
    explanations:[
      'Methane (CH₄) contains carbon and hydrogen.',
      'In complete combustion, carbon forms CO₂ and hydrogen forms H₂O.',
      'The balanced equation is CH₄ + 2O₂ → CO₂ + 2H₂O.',
      'Check: 1 C, 4 H and 4 O atoms are present on each side.',
    ],
    note:'Incomplete combustion can produce carbon monoxide and/or carbon. The products depend on oxygen availability.',
  ),
  'Neutralização: ácido clorídrico + hidróxido de sódio': ReactionText(
    title:'Neutralisation: hydrochloric acid + sodium hydroxide',
    type:'Acid-base neutralisation',
    summary:'Sodium chloride (NaCl) and water are formed.',
    explanations:[
      'HCl is the acid and NaOH is the base.',
      'H⁺ from the acid combines with OH⁻ from the base to form water.',
      'Na⁺ and Cl⁻ form the salt NaCl.',
      'The molecular ratio is 1:1:1:1.',
    ],
  ),
  'Neutralização: ácido clorídrico + hidróxido de potássio': ReactionText(
    title:'Neutralisation: hydrochloric acid + potassium hydroxide',
    type:'Acid-base neutralisation',
    summary:'Potassium chloride (KCl) and water are formed.',
    explanations:[
      'HCl is the acid and KOH is the base.',
      'H⁺ combines with OH⁻ to form H₂O.',
      'K⁺ and Cl⁻ form the salt KCl.',
      'The equation is already balanced with coefficients of 1.',
    ],
  ),
  'Neutralização: ácido sulfúrico + hidróxido de sódio': ReactionText(
    title:'Neutralisation: sulfuric acid + sodium hydroxide',
    type:'Acid-base neutralisation',
    summary:'Sodium sulfate (Na₂SO₄) and water are formed.',
    explanations:[
      'One H₂SO₄ molecule can supply two H⁺ ions.',
      'Each NaOH supplies one OH⁻, so two NaOH units are needed.',
      'The products are Na₂SO₄ and 2H₂O.',
    ],
  ),
  'Neutralização: ácido nítrico + hidróxido de potássio': ReactionText(
    title:'Neutralisation: nitric acid + potassium hydroxide',
    type:'Acid-base neutralisation',
    summary:'Potassium nitrate (KNO₃) and water are formed.',
    explanations:[
      'HNO₃ is nitric acid and KOH is potassium hydroxide.',
      'H⁺ and OH⁻ combine to form H₂O.',
      'K⁺ and NO₃⁻ form the salt KNO₃.',
    ],
  ),
  'Neutralização: hidróxido de cálcio + ácido clorídrico': ReactionText(
    title:'Neutralisation: calcium hydroxide + hydrochloric acid',
    type:'Acid-base neutralisation',
    summary:'Calcium chloride (CaCl₂) and water are formed.',
    explanations:[
      'Ca(OH)₂ contains two hydroxide groups.',
      'Two HCl molecules supply the two H⁺ ions needed.',
      'The products are CaCl₂ and 2H₂O.',
    ],
  ),
  'Formação do sulfureto de ferro': ReactionText(
    title:'Formation of iron sulfide',
    type:'Synthesis',
    summary:'Iron and sulfur combine to form iron(II) sulfide (FeS).',
    explanations:[
      'Iron and sulfur combine in a 1:1 ratio in this example.',
      'The compound formed is FeS.',
      'Fe + S → FeS conserves one atom of each element.',
    ],
  ),
  'Carbonato + ácido': ReactionText(
    title:'Carbonate + acid',
    type:'Acid + carbonate reaction',
    summary:'A salt, carbon dioxide and water are formed.',
    explanations:[
      'The carbonate reacts with the acid.',
      'Calcium and chloride form CaCl₂.',
      'The carbonate group produces CO₂ and water; two HCl molecules are needed.',
    ],
  ),
  'Formação de um precipitado': ReactionText(
    title:'Formation of a precipitate',
    type:'Double displacement • precipitation',
    summary:'Silver chloride (AgCl), a white precipitate, and sodium nitrate are formed.',
    explanations:[
      'The ions exchange partners: Ag⁺ combines with Cl⁻.',
      'AgCl is poorly soluble in water and precipitates.',
      'Na⁺ and NO₃⁻ remain in solution as sodium nitrate.',
    ],
  ),
  'Carbonato de sódio + ácido clorídrico': ReactionText(
    title:'Sodium carbonate + hydrochloric acid',
    type:'Acid + carbonate reaction',
    summary:'Sodium chloride, carbon dioxide and water are formed.',
    explanations:[
      'The carbonate reacts with the acid and releases CO₂.',
      'Sodium and chloride form NaCl.',
      'The balanced equation uses 2HCl and 2NaCl.',
    ],
  ),
  'Metal + ácido': ReactionText(
    title:'Metal + acid',
    type:'Single displacement',
    summary:'Magnesium displaces hydrogen from the acid, forming MgCl₂ and H₂.',
    explanations:[
      'Magnesium is more reactive than hydrogen.',
      'Magnesium forms Mg²⁺ while hydrogen forms H₂.',
      'Two HCl molecules provide two chlorine and two hydrogen atoms.',
    ],
    note:'The reaction can release flammable hydrogen. Do not try it experimentally.',
  ),
  'Formação do cloreto de sódio': ReactionText(
    title:'Formation of sodium chloride',
    type:'Synthesis • metal + halogen',
    summary:'Sodium and chlorine form sodium chloride (NaCl).',
    explanations:[
      'Sodium forms Na⁺ ions and chlorine forms Cl⁻ ions.',
      'The charges balance in a 1:1 ratio, forming NaCl.',
      'Elemental chlorine is diatomic (Cl₂), so the equation uses 2Na and 2NaCl.',
    ],
    note:'The direct reaction is highly energetic. This is a theoretical example, not a home experiment.',
  ),
  'Formação do cloreto de potássio': ReactionText(
    title:'Formation of potassium chloride',
    type:'Synthesis • metal + halogen',
    summary:'Potassium and chlorine form potassium chloride (KCl).',
    explanations:[
      'Potassium forms K⁺ ions and chlorine forms Cl⁻ ions.',
      'The ions combine in a 1:1 ratio.',
      'The balanced equation is 2K + Cl₂ → 2KCl.',
    ],
    note:'This reaction is highly energetic and is shown as a theoretical example only.',
  ),
  'Formação do cloreto de cálcio': ReactionText(
    title:'Formation of calcium chloride',
    type:'Synthesis • metal + halogen',
    summary:'Calcium chloride (CaCl₂) is formed.',
    explanations:[
      'Calcium forms Ca²⁺ ions.',
      'Two Cl⁻ ions are needed to balance the calcium charge.',
      'The compound formula is CaCl₂.',
    ],
  ),
  'Formação do cloreto de magnésio': ReactionText(
    title:'Formation of magnesium chloride',
    type:'Synthesis • metal + halogen',
    summary:'Magnesium chloride (MgCl₂) is formed.',
    explanations:[
      'Magnesium forms the Mg²⁺ ion.',
      'Two chloride ions, Cl⁻, balance its charge.',
      'The equation is Mg + Cl₂ → MgCl₂.',
    ],
  ),
  'Formação do óxido de cálcio': ReactionText(
    title:'Formation of calcium oxide',
    type:'Synthesis • metal + oxygen',
    summary:'Calcium reacts with oxygen to form calcium oxide (CaO).',
    explanations:[
      'Calcium forms Ca²⁺ ions and oxygen forms O²⁻ ions in the ionic compound.',
      'A 1:1 ratio balances the charges, so the formula is CaO.',
      'The balanced equation is 2Ca + O₂ → 2CaO.',
    ],
  ),
  'Formação do óxido de alumínio': ReactionText(
    title:'Formation of aluminium oxide',
    type:'Synthesis • metal + oxygen',
    summary:'Aluminium oxide (Al₂O₃) is formed.',
    explanations:[
      'Aluminium commonly forms Al³⁺ ions and oxygen forms O²⁻ ions.',
      'The neutral formula is Al₂O₃.',
      'Balancing gives 4Al + 3O₂ → 2Al₂O₃.',
    ],
  ),
  'Formação do óxido de zinco': ReactionText(
    title:'Formation of zinc oxide',
    type:'Synthesis • metal + oxygen',
    summary:'Zinc oxide (ZnO) is formed.',
    explanations:[
      'Zinc commonly forms Zn²⁺ and oxygen forms O²⁻.',
      'The compound formula is ZnO.',
      'The balanced equation is 2Zn + O₂ → 2ZnO.',
    ],
  ),
  'Formação do óxido de ferro (III)': ReactionText(
    title:'Formation of iron(III) oxide',
    type:'Synthesis • oxidation',
    summary:'In this school-level model, iron(III) oxide (Fe₂O₃) is formed.',
    explanations:[
      'Iron combines with oxygen.',
      'The product represented in this reaction is Fe₂O₃.',
      'The balanced equation is 4Fe + 3O₂ → 2Fe₂O₃.',
    ],
    note:'Iron can form other oxides, including FeO and Fe₃O₄. The actual product depends on oxidation conditions.',
  ),
  'Formação do óxido de cobre (II)': ReactionText(
    title:'Formation of copper(II) oxide',
    type:'Synthesis • oxidation',
    summary:'In this example, copper forms copper(II) oxide (CuO).',
    explanations:[
      'Copper reacts with oxygen.',
      'The product considered is CuO, where copper has oxidation state +2.',
      'The balanced equation is 2Cu + O₂ → 2CuO.',
    ],
    note:'Copper can also form Cu₂O. The product depends on the conditions and oxygen availability.',
  ),
  'Zinco + ácido clorídrico': ReactionText(
    title:'Zinc + hydrochloric acid',
    type:'Single displacement',
    summary:'Zinc forms zinc chloride and releases hydrogen.',
    explanations:[
      'Zinc is more reactive than hydrogen.',
      'Zinc forms Zn²⁺ and combines with two chloride ions.',
      'Two HCl molecules are needed to provide two H atoms and two Cl atoms.',
    ],
    note:'The reaction can release flammable hydrogen. Do not mix acids and metals outside a supervised laboratory.',
  ),
  'Alumínio + ácido clorídrico': ReactionText(
    title:'Aluminium + hydrochloric acid',
    type:'Single displacement',
    summary:'Aluminium chloride and hydrogen are formed.',
    explanations:[
      'Aluminium commonly forms Al³⁺ ions.',
      'Three chloride ions balance the charge of each Al³⁺.',
      'Balancing gives 2Al + 6HCl → 2AlCl₃ + 3H₂.',
    ],
    note:'The reaction can be vigorous and release flammable hydrogen. This is a theoretical study example.',
  ),
  'Ferro + ácido clorídrico': ReactionText(
    title:'Iron + hydrochloric acid',
    type:'Single displacement',
    summary:'With dilute hydrochloric acid, iron can form iron(II) chloride and hydrogen.',
    explanations:[
      'Iron displaces hydrogen from the acid.',
      'In this example, iron forms Fe²⁺, which combines with two Cl⁻ ions.',
      'The balanced equation is Fe + 2HCl → FeCl₂ + H₂.',
    ],
    note:'The product depends on the acid and conditions. This example assumes dilute, non-oxidising hydrochloric acid.',
  ),
  'Decomposição do peróxido de hidrogénio': ReactionText(
    title:'Decomposition of hydrogen peroxide',
    type:'Decomposition',
    summary:'Hydrogen peroxide decomposes into water and oxygen.',
    explanations:[
      'One starting substance breaks down into two simpler substances.',
      'Two H₂O₂ molecules are needed for the balanced equation.',
      'The equation is 2H₂O₂ → 2H₂O + O₂.',
    ],
    note:'The rate depends on light, temperature and catalysts. Do not mix chemicals to try to reproduce this reaction.',
  ),
  'Decomposição térmica do carbonato de cálcio': ReactionText(
    title:'Thermal decomposition of calcium carbonate',
    type:'Decomposition • heating',
    summary:'When heated sufficiently, calcium carbonate forms calcium oxide and carbon dioxide.',
    explanations:[
      'CaCO₃ decomposes into CaO and CO₂.',
      'Calcium, carbon and oxygen atoms are conserved.',
      'CaCO₃ → CaO + CO₂ is already balanced.',
    ],
    note:'A high temperature is required. The extent of the transformation depends on the conditions.',
  ),
  'Decomposição do hidrogenocarbonato de sódio': ReactionText(
    title:'Decomposition of sodium bicarbonate',
    type:'Decomposition • heating',
    summary:'When heated, sodium bicarbonate can form sodium carbonate, carbon dioxide and water.',
    explanations:[
      'Two NaHCO₃ units provide two sodium atoms.',
      'The remaining atoms are distributed among Na₂CO₃, CO₂ and H₂O.',
      'The balanced equation is 2NaHCO₃ → Na₂CO₃ + CO₂ + H₂O.',
    ],
  ),
  'Precipitação do sulfato de bário': ReactionText(
    title:'Precipitation of barium sulfate',
    type:'Double displacement • precipitation',
    summary:'Barium sulfate, a white precipitate, and sodium chloride are formed.',
    explanations:[
      'Ba²⁺ and SO₄²⁻ ions combine to form poorly soluble BaSO₄.',
      'Na⁺ and Cl⁻ ions remain as sodium chloride in solution.',
      'Two NaCl units are needed to balance sodium and chlorine.',
    ],
    note:'Soluble barium salts are toxic. This is an example for learning precipitation, not for practical preparation.',
  ),
  'Hidrogenocarbonato + ácido': ReactionText(
    title:'Bicarbonate + acid',
    type:'Acid + carbonate reaction',
    summary:'A salt, carbon dioxide and water are formed.',
    explanations:[
      'The acid supplies H⁺ and the bicarbonate reacts, releasing CO₂.',
      'Sodium and chloride form NaCl.',
      'NaHCO₃ + HCl → NaCl + CO₂ + H₂O is balanced.',
    ],
  ),
  'Formação do cloreto de amónio': ReactionText(
    title:'Formation of ammonium chloride',
    type:'Acid-base reaction',
    summary:'Ammonia and hydrogen chloride form ammonium chloride.',
    explanations:[
      'Ammonia (NH₃) accepts a proton H⁺ and forms the ammonium ion NH₄⁺.',
      'Hydrogen chloride supplies H⁺ and forms Cl⁻.',
      'NH₄⁺ and Cl⁻ combine in a 1:1 ratio to form NH₄Cl.',
    ],
    note:'This represents a reaction between gases. Do not mix ammonia and acids outside controlled laboratory conditions.',
  ),
  'Síntese do amoníaco': ReactionText(
    title:'Synthesis of ammonia',
    type:'Synthesis • Haber process',
    summary:'Nitrogen and hydrogen can form ammonia.',
    explanations:[
      'Molecular nitrogen is N₂ and molecular hydrogen is H₂.',
      'Each NH₃ molecule contains one nitrogen atom and three hydrogen atoms.',
      'The balanced equation is N₂ + 3H₂ ⇌ 2NH₃.',
    ],
    note:'The industrial Haber process uses controlled pressure and temperature and a catalyst. The equation is reversible.',
  ),
  'Formação do cloreto de hidrogénio': ReactionText(
    title:'Formation of hydrogen chloride',
    type:'Synthesis',
    summary:'Hydrogen and chlorine form hydrogen chloride.',
    explanations:[
      'Elemental hydrogen and chlorine are diatomic molecules.',
      'Each HCl molecule contains one hydrogen atom and one chlorine atom.',
      'The balanced equation is H₂ + Cl₂ → 2HCl.',
    ],
    note:'This reaction can be violent in the presence of light. It is a theoretical example only.',
  ),
  'Combustão completa do etano': ReactionText(
    title:'Complete combustion of ethane',
    type:'Hydrocarbon combustion',
    summary:'Ethane burns in sufficient oxygen to form carbon dioxide and water.',
    explanations:[
      'Ethane (C₂H₆) contains carbon and hydrogen.',
      'In complete combustion, carbon forms CO₂ and hydrogen forms H₂O.',
      'The balanced equation is 2C₂H₆ + 7O₂ → 4CO₂ + 6H₂O.',
    ],
    note:'With limited oxygen, incomplete combustion may occur.',
  ),
  'Combustão completa do propano': ReactionText(
    title:'Complete combustion of propane',
    type:'Hydrocarbon combustion',
    summary:'Propane forms carbon dioxide and water during complete combustion.',
    explanations:[
      'Propane (C₃H₈) contains three carbon atoms and eight hydrogen atoms.',
      'Three CO₂ molecules conserve carbon and four H₂O molecules conserve hydrogen.',
      'The balanced equation is C₃H₈ + 5O₂ → 3CO₂ + 4H₂O.',
    ],
  ),
  'Combustão completa do etanol': ReactionText(
    title:'Complete combustion of ethanol',
    type:'Alcohol combustion',
    summary:'Ethanol forms carbon dioxide and water during complete combustion.',
    explanations:[
      'Ethanol has the molecular formula C₂H₆O.',
      'Carbon forms CO₂ and hydrogen forms H₂O.',
      'The balanced equation is C₂H₆O + 3O₂ → 2CO₂ + 3H₂O.',
    ],
  ),
  'Oxidação completa da glicose': ReactionText(
    title:'Complete oxidation of glucose',
    type:'Oxidation • overall reaction',
    summary:'Complete oxidation of glucose produces carbon dioxide and water.',
    explanations:[
      'Glucose contains six carbon atoms and twelve hydrogen atoms.',
      'Six CO₂ molecules and six H₂O molecules are formed.',
      'The balanced overall equation is C₆H₁₂O₆ + 6O₂ → 6CO₂ + 6H₂O.',
    ],
    note:'This is a simplified overall equation for glucose oxidation, not a single biochemical step.',
  ),
  'Neutralização: ácido nítrico + hidróxido de sódio': ReactionText(
    title:'Neutralisation: nitric acid + sodium hydroxide',
    type:'Acid-base neutralisation',
    summary:'Sodium nitrate and water are formed.',
    explanations:[
      'HNO₃ is the acid and NaOH is the base.',
      'H⁺ combines with OH⁻ to form water.',
      'Na⁺ and NO₃⁻ form NaNO₃.',
    ],
  ),
  'Neutralização: ácido sulfúrico + hidróxido de potássio': ReactionText(
    title:'Neutralisation: sulfuric acid + potassium hydroxide',
    type:'Acid-base neutralisation',
    summary:'Potassium sulfate and water are formed.',
    explanations:[
      'One H₂SO₄ molecule can supply two protons.',
      'Two KOH molecules are needed to supply two OH⁻ ions.',
      'The balanced equation is H₂SO₄ + 2KOH → K₂SO₄ + 2H₂O.',
    ],
  ),
  'Neutralização completa do ácido fosfórico': ReactionText(
    title:'Complete neutralisation of phosphoric acid',
    type:'Acid-base neutralisation',
    summary:'Complete neutralisation forms sodium phosphate and water.',
    explanations:[
      'H₃PO₄ can supply three protons in complete neutralisation.',
      'Three NaOH molecules are required.',
      'The balanced equation is H₃PO₄ + 3NaOH → Na₃PO₄ + 3H₂O.',
    ],
    note:'With different amounts of base, acid salts such as NaH₂PO₄ or Na₂HPO₄ may form.',
  ),
  'Equação balanceada': ReactionText(
    title:'Balanced equation',
    type:'Conservation of atoms',
    summary:'The equation has been adjusted to conserve every element.',
    explanations:[
      'The app read the reactants and products you selected.',
      'The balancing engine calculated positive integer coefficients.',
      'Subscripts inside formulas were not changed; only coefficients in front of formulas can change.',
    ],
    note:'Balancing confirms conservation of atoms; it does not by itself prove that the reaction occurs under real conditions.',
  ),
  'Como se forma o sabão?': ReactionText(
    title:'How is soap formed?',
    type:'Saponification • base hydrolysis of triglycerides',
    summary:'Oils or fats react with a strong base to form soap and glycerol.',
    explanations:[
      'Oils and fats mainly contain triglycerides, molecules built from glycerol and fatty acids.',
      'During saponification, a triglyceride reacts with sodium hydroxide (NaOH) or potassium hydroxide (KOH).',
      'NaOH forms fatty-acid sodium salts, commonly solid soaps. KOH forms potassium salts, often used in softer or liquid soaps.',
      'The other main product is glycerol (glycerin).',
    ],
    note:'R represents a variable fatty-acid chain, so this is a general equation rather than one formula for every oil. NaOH and KOH are corrosive. This is a conceptual explanation, not a soap-making recipe.',
  ),
};

ReactionText localizedReactionText(ReactionPrediction prediction, bool english) {
  if (!english) {
    return ReactionText(
      title:prediction.title,
      type:prediction.reactionType,
      summary:prediction.productSummary,
      explanations:prediction.explanations,
      note:prediction.note,
    );
  }
  return _englishReactions[prediction.title] ??
      ReactionText(
        title:prediction.title,
        type:prediction.reactionType,
        summary:prediction.productSummary,
        explanations:prediction.explanations,
        note:prediction.note,
      );
}
