import 'periodic_elements.dart';

enum ChemicalGroup {
  alkaliMetals,
  alkalineEarthMetals,
  transitionMetals,
  postTransitionMetals,
  metalloids,
  nonmetals,
  halogens,
  nobleGases,
  lanthanides,
  actinides,
  water,
  simpleSubstances,
  oxides,
  acids,
  bases,
  salts,
  organicCompounds,
  otherCompounds,
}

class ChemicalSpecies {
  final String id;
  final String formula;
  final String namePt;
  final String nameEn;
  final String detailPt;
  final String detailEn;
  final ChemicalGroup group;
  final bool isElement;
  final String? elementSymbol;
  final int? atomicNumber;

  const ChemicalSpecies({
    required this.id,
    required this.formula,
    required this.namePt,
    required this.nameEn,
    required this.detailPt,
    required this.detailEn,
    required this.group,
    this.isElement = false,
    this.elementSymbol,
    this.atomicNumber,
  });

  String name(bool english) => english ? nameEn : namePt;
  String detail(bool english) => english ? detailEn : detailPt;
}

const elementEnglishNames = <String, String>{
  'H':'Hydrogen','He':'Helium','Li':'Lithium','Be':'Beryllium','B':'Boron',
  'C':'Carbon','N':'Nitrogen','O':'Oxygen','F':'Fluorine','Ne':'Neon',
  'Na':'Sodium','Mg':'Magnesium','Al':'Aluminium','Si':'Silicon','P':'Phosphorus',
  'S':'Sulfur','Cl':'Chlorine','Ar':'Argon','K':'Potassium','Ca':'Calcium',
  'Sc':'Scandium','Ti':'Titanium','V':'Vanadium','Cr':'Chromium','Mn':'Manganese',
  'Fe':'Iron','Co':'Cobalt','Ni':'Nickel','Cu':'Copper','Zn':'Zinc',
  'Ga':'Gallium','Ge':'Germanium','As':'Arsenic','Se':'Selenium','Br':'Bromine',
  'Kr':'Krypton','Rb':'Rubidium','Sr':'Strontium','Y':'Yttrium','Zr':'Zirconium',
  'Nb':'Niobium','Mo':'Molybdenum','Tc':'Technetium','Ru':'Ruthenium','Rh':'Rhodium',
  'Pd':'Palladium','Ag':'Silver','Cd':'Cadmium','In':'Indium','Sn':'Tin',
  'Sb':'Antimony','Te':'Tellurium','I':'Iodine','Xe':'Xenon','Cs':'Caesium',
  'Ba':'Barium','La':'Lanthanum','Ce':'Cerium','Pr':'Praseodymium','Nd':'Neodymium',
  'Pm':'Promethium','Sm':'Samarium','Eu':'Europium','Gd':'Gadolinium','Tb':'Terbium',
  'Dy':'Dysprosium','Ho':'Holmium','Er':'Erbium','Tm':'Thulium','Yb':'Ytterbium',
  'Lu':'Lutetium','Hf':'Hafnium','Ta':'Tantalum','W':'Tungsten','Re':'Rhenium',
  'Os':'Osmium','Ir':'Iridium','Pt':'Platinum','Au':'Gold','Hg':'Mercury',
  'Tl':'Thallium','Pb':'Lead','Bi':'Bismuth','Po':'Polonium','At':'Astatine',
  'Rn':'Radon','Fr':'Francium','Ra':'Radium','Ac':'Actinium','Th':'Thorium',
  'Pa':'Protactinium','U':'Uranium','Np':'Neptunium','Pu':'Plutonium','Am':'Americium',
  'Cm':'Curium','Bk':'Berkelium','Cf':'Californium','Es':'Einsteinium','Fm':'Fermium',
  'Md':'Mendelevium','No':'Nobelium','Lr':'Lawrencium','Rf':'Rutherfordium','Db':'Dubnium',
  'Sg':'Seaborgium','Bh':'Bohrium','Hs':'Hassium','Mt':'Meitnerium','Ds':'Darmstadtium',
  'Rg':'Roentgenium','Cn':'Copernicium','Nh':'Nihonium','Fl':'Flerovium','Mc':'Moscovium',
  'Lv':'Livermorium','Ts':'Tennessine','Og':'Oganesson',
};

ChemicalGroup _elementGroup(String category) {
  switch (category) {
    case 'Metal alcalino': return ChemicalGroup.alkaliMetals;
    case 'Metal alcalino-terroso': return ChemicalGroup.alkalineEarthMetals;
    case 'Metal de transição': return ChemicalGroup.transitionMetals;
    case 'Metal pós-transição': return ChemicalGroup.postTransitionMetals;
    case 'Semimetal': return ChemicalGroup.metalloids;
    case 'Não metal': return ChemicalGroup.nonmetals;
    case 'Halogéneo': return ChemicalGroup.halogens;
    case 'Gás nobre': return ChemicalGroup.nobleGases;
    case 'Lantanídeo': return ChemicalGroup.lanthanides;
    case 'Actinídeo': return ChemicalGroup.actinides;
    default: return ChemicalGroup.otherCompounds;
  }
}

final List<ChemicalSpecies> periodicSpecies = periodicElements.map((element) {
  return ChemicalSpecies(
    id: 'element-' + element.symbol,
    formula: element.symbol,
    namePt: element.name,
    nameEn: elementEnglishNames[element.symbol] ?? element.symbol,
    detailPt: 'Elemento químico • ' + element.category,
    detailEn: 'Chemical element • ' + element.category,
    group: _elementGroup(element.category),
    isElement: true,
    elementSymbol: element.symbol,
    atomicNumber: element.number,
  );
}).toList(growable: false);

const List<ChemicalSpecies> commonSubstances = [
  ChemicalSpecies(id:'water',formula:'H2O',namePt:'Água',nameEn:'Water',detailPt:'Composto essencial • solvente',detailEn:'Essential compound • solvent',group:ChemicalGroup.water),
  ChemicalSpecies(id:'hydrogen-gas',formula:'H2',namePt:'Hidrogénio molecular',nameEn:'Hydrogen gas',detailPt:'Substância simples • gás diatómico',detailEn:'Elemental substance • diatomic gas',group:ChemicalGroup.simpleSubstances),
  ChemicalSpecies(id:'oxygen-gas',formula:'O2',namePt:'Oxigénio molecular',nameEn:'Oxygen gas',detailPt:'Substância simples • gás diatómico',detailEn:'Elemental substance • diatomic gas',group:ChemicalGroup.simpleSubstances),
  ChemicalSpecies(id:'nitrogen-gas',formula:'N2',namePt:'Azoto molecular',nameEn:'Nitrogen gas',detailPt:'Substância simples • gás diatómico',detailEn:'Elemental substance • diatomic gas',group:ChemicalGroup.simpleSubstances),
  ChemicalSpecies(id:'chlorine-gas',formula:'Cl2',namePt:'Cloro molecular',nameEn:'Chlorine gas',detailPt:'Substância simples • gás diatómico',detailEn:'Elemental substance • diatomic gas',group:ChemicalGroup.simpleSubstances),
  ChemicalSpecies(id:'hydrogen-peroxide',formula:'H2O2',namePt:'Peróxido de hidrogénio',nameEn:'Hydrogen peroxide',detailPt:'Peróxido',detailEn:'Peroxide',group:ChemicalGroup.otherCompounds),
  ChemicalSpecies(id:'carbon-dioxide',formula:'CO2',namePt:'Dióxido de carbono',nameEn:'Carbon dioxide',detailPt:'Óxido não metálico',detailEn:'Non-metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'carbon-monoxide',formula:'CO',namePt:'Monóxido de carbono',nameEn:'Carbon monoxide',detailPt:'Óxido não metálico',detailEn:'Non-metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'sulfur-dioxide',formula:'SO2',namePt:'Dióxido de enxofre',nameEn:'Sulfur dioxide',detailPt:'Óxido não metálico',detailEn:'Non-metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'sulfur-trioxide',formula:'SO3',namePt:'Trióxido de enxofre',nameEn:'Sulfur trioxide',detailPt:'Óxido não metálico',detailEn:'Non-metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'calcium-oxide',formula:'CaO',namePt:'Óxido de cálcio',nameEn:'Calcium oxide',detailPt:'Óxido metálico',detailEn:'Metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'magnesium-oxide',formula:'MgO',namePt:'Óxido de magnésio',nameEn:'Magnesium oxide',detailPt:'Óxido metálico',detailEn:'Metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'aluminium-oxide',formula:'Al2O3',namePt:'Óxido de alumínio',nameEn:'Aluminium oxide',detailPt:'Óxido metálico',detailEn:'Metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'iron-iii-oxide',formula:'Fe2O3',namePt:'Óxido de ferro (III)',nameEn:'Iron(III) oxide',detailPt:'Óxido metálico',detailEn:'Metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'copper-ii-oxide',formula:'CuO',namePt:'Óxido de cobre (II)',nameEn:'Copper(II) oxide',detailPt:'Óxido metálico',detailEn:'Metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'sodium-oxide',formula:'Na2O',namePt:'Óxido de sódio',nameEn:'Sodium oxide',detailPt:'Óxido metálico',detailEn:'Metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'hydrochloric-acid',formula:'HCl',namePt:'Ácido clorídrico',nameEn:'Hydrochloric acid',detailPt:'Ácido',detailEn:'Acid',group:ChemicalGroup.acids),
  ChemicalSpecies(id:'sulfuric-acid',formula:'H2SO4',namePt:'Ácido sulfúrico',nameEn:'Sulfuric acid',detailPt:'Ácido',detailEn:'Acid',group:ChemicalGroup.acids),
  ChemicalSpecies(id:'nitric-acid',formula:'HNO3',namePt:'Ácido nítrico',nameEn:'Nitric acid',detailPt:'Ácido',detailEn:'Acid',group:ChemicalGroup.acids),
  ChemicalSpecies(id:'phosphoric-acid',formula:'H3PO4',namePt:'Ácido fosfórico',nameEn:'Phosphoric acid',detailPt:'Ácido',detailEn:'Acid',group:ChemicalGroup.acids),
  ChemicalSpecies(id:'carbonic-acid',formula:'H2CO3',namePt:'Ácido carbónico',nameEn:'Carbonic acid',detailPt:'Ácido fraco',detailEn:'Weak acid',group:ChemicalGroup.acids),
  ChemicalSpecies(id:'sulfurous-acid',formula:'H2SO3',namePt:'Ácido sulfuroso',nameEn:'Sulfurous acid',detailPt:'Ácido fraco • representação escolar',detailEn:'Weak acid • school-level representation',group:ChemicalGroup.acids),
  ChemicalSpecies(id:'sodium-hydroxide',formula:'NaOH',namePt:'Hidróxido de sódio',nameEn:'Sodium hydroxide',detailPt:'Base forte • corrosiva',detailEn:'Strong base • corrosive',group:ChemicalGroup.bases),
  ChemicalSpecies(id:'potassium-hydroxide',formula:'KOH',namePt:'Hidróxido de potássio',nameEn:'Potassium hydroxide',detailPt:'Base forte • corrosiva',detailEn:'Strong base • corrosive',group:ChemicalGroup.bases),
  ChemicalSpecies(id:'calcium-hydroxide',formula:'Ca(OH)2',namePt:'Hidróxido de cálcio',nameEn:'Calcium hydroxide',detailPt:'Base',detailEn:'Base',group:ChemicalGroup.bases),
  ChemicalSpecies(id:'magnesium-hydroxide',formula:'Mg(OH)2',namePt:'Hidróxido de magnésio',nameEn:'Magnesium hydroxide',detailPt:'Base pouco solúvel',detailEn:'Sparingly soluble base',group:ChemicalGroup.bases),
  ChemicalSpecies(id:'sodium-chloride',formula:'NaCl',namePt:'Cloreto de sódio',nameEn:'Sodium chloride',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'potassium-chloride',formula:'KCl',namePt:'Cloreto de potássio',nameEn:'Potassium chloride',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'calcium-chloride',formula:'CaCl2',namePt:'Cloreto de cálcio',nameEn:'Calcium chloride',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'sodium-sulfate',formula:'Na2SO4',namePt:'Sulfato de sódio',nameEn:'Sodium sulfate',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'potassium-nitrate',formula:'KNO3',namePt:'Nitrato de potássio',nameEn:'Potassium nitrate',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'sodium-nitrate',formula:'NaNO3',namePt:'Nitrato de sódio',nameEn:'Sodium nitrate',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'calcium-carbonate',formula:'CaCO3',namePt:'Carbonato de cálcio',nameEn:'Calcium carbonate',detailPt:'Carbonato',detailEn:'Carbonate',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'sodium-carbonate',formula:'Na2CO3',namePt:'Carbonato de sódio',nameEn:'Sodium carbonate',detailPt:'Carbonato',detailEn:'Carbonate',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'sodium-bicarbonate',formula:'NaHCO3',namePt:'Hidrogenocarbonato de sódio',nameEn:'Sodium bicarbonate',detailPt:'Bicarbonato',detailEn:'Bicarbonate',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'silver-nitrate',formula:'AgNO3',namePt:'Nitrato de prata',nameEn:'Silver nitrate',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'silver-chloride',formula:'AgCl',namePt:'Cloreto de prata',nameEn:'Silver chloride',detailPt:'Sal pouco solúvel',detailEn:'Sparingly soluble salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'barium-chloride',formula:'BaCl2',namePt:'Cloreto de bário',nameEn:'Barium chloride',detailPt:'Sal • tóxico',detailEn:'Salt • toxic',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'barium-sulfate',formula:'BaSO4',namePt:'Sulfato de bário',nameEn:'Barium sulfate',detailPt:'Sal pouco solúvel',detailEn:'Sparingly soluble salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'copper-sulfate',formula:'CuSO4',namePt:'Sulfato de cobre (II)',nameEn:'Copper(II) sulfate',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'iron-sulfide',formula:'FeS',namePt:'Sulfureto de ferro (II)',nameEn:'Iron(II) sulfide',detailPt:'Sal binário',detailEn:'Binary compound',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'lead-nitrate',formula:'Pb(NO3)2',namePt:'Nitrato de chumbo (II)',nameEn:'Lead(II) nitrate',detailPt:'Sal • tóxico',detailEn:'Salt • toxic',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'potassium-iodide',formula:'KI',namePt:'Iodeto de potássio',nameEn:'Potassium iodide',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'ammonia',formula:'NH3',namePt:'Amoníaco',nameEn:'Ammonia',detailPt:'Composto molecular',detailEn:'Molecular compound',group:ChemicalGroup.otherCompounds),
  ChemicalSpecies(id:'methane',formula:'CH4',namePt:'Metano',nameEn:'Methane',detailPt:'Hidrocarboneto • alcano',detailEn:'Hydrocarbon • alkane',group:ChemicalGroup.organicCompounds),
  ChemicalSpecies(id:'ethane',formula:'C2H6',namePt:'Etano',nameEn:'Ethane',detailPt:'Hidrocarboneto • alcano',detailEn:'Hydrocarbon • alkane',group:ChemicalGroup.organicCompounds),
  ChemicalSpecies(id:'propane',formula:'C3H8',namePt:'Propano',nameEn:'Propane',detailPt:'Hidrocarboneto • alcano',detailEn:'Hydrocarbon • alkane',group:ChemicalGroup.organicCompounds),
  ChemicalSpecies(id:'ethanol',formula:'C2H6O',namePt:'Etanol',nameEn:'Ethanol',detailPt:'Álcool',detailEn:'Alcohol',group:ChemicalGroup.organicCompounds),
  ChemicalSpecies(id:'glucose',formula:'C6H12O6',namePt:'Glicose',nameEn:'Glucose',detailPt:'Glícido simples',detailEn:'Simple carbohydrate',group:ChemicalGroup.organicCompounds),
  ChemicalSpecies(id:'glycerol',formula:'C3H8O3',namePt:'Glicerol (glicerina)',nameEn:'Glycerol (glycerin)',detailPt:'Álcool • produto da saponificação',detailEn:'Alcohol • product of saponification',group:ChemicalGroup.organicCompounds),

  ChemicalSpecies(id:'ammonium-chloride',formula:'NH4Cl',namePt:'Cloreto de amónio',nameEn:'Ammonium chloride',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'zinc-chloride',formula:'ZnCl2',namePt:'Cloreto de zinco',nameEn:'Zinc chloride',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'aluminium-chloride',formula:'AlCl3',namePt:'Cloreto de alumínio',nameEn:'Aluminium chloride',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'iron-ii-chloride',formula:'FeCl2',namePt:'Cloreto de ferro (II)',nameEn:'Iron(II) chloride',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'magnesium-chloride',formula:'MgCl2',namePt:'Cloreto de magnésio',nameEn:'Magnesium chloride',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'potassium-sulfate',formula:'K2SO4',namePt:'Sulfato de potássio',nameEn:'Potassium sulfate',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'sodium-phosphate',formula:'Na3PO4',namePt:'Fosfato de sódio',nameEn:'Sodium phosphate',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'zinc-oxide',formula:'ZnO',namePt:'Óxido de zinco',nameEn:'Zinc oxide',detailPt:'Óxido metálico',detailEn:'Metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'potassium-oxide',formula:'K2O',namePt:'Óxido de potássio',nameEn:'Potassium oxide',detailPt:'Óxido metálico',detailEn:'Metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'dinitrogen-pentoxide',formula:'N2O5',namePt:'Pentóxido de dinitrogénio',nameEn:'Dinitrogen pentoxide',detailPt:'Óxido não metálico',detailEn:'Non-metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'diphosphorus-pentoxide',formula:'P2O5',namePt:'Pentóxido de difósforo',nameEn:'Diphosphorus pentoxide',detailPt:'Óxido não metálico',detailEn:'Non-metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'hydrogen-sulfide',formula:'H2S',namePt:'Sulfureto de hidrogénio',nameEn:'Hydrogen sulfide',detailPt:'Composto molecular',detailEn:'Molecular compound',group:ChemicalGroup.otherCompounds),
  ChemicalSpecies(id:'nitrogen-dioxide',formula:'NO2',namePt:'Dióxido de azoto',nameEn:'Nitrogen dioxide',detailPt:'Óxido não metálico',detailEn:'Non-metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'nitric-oxide',formula:'NO',namePt:'Monóxido de azoto',nameEn:'Nitric oxide',detailPt:'Óxido não metálico',detailEn:'Non-metal oxide',group:ChemicalGroup.oxides),
  ChemicalSpecies(id:'calcium-phosphate',formula:'Ca3(PO4)2',namePt:'Fosfato de cálcio',nameEn:'Calcium phosphate',detailPt:'Sal',detailEn:'Salt',group:ChemicalGroup.salts),
  ChemicalSpecies(id:'sodium-acetate',formula:'C2H3NaO2',namePt:'Acetato de sódio',nameEn:'Sodium acetate',detailPt:'Sal orgânico',detailEn:'Organic salt',group:ChemicalGroup.salts),
];

final List<ChemicalSpecies> chemicalCatalog = [
  ...periodicSpecies,
  ...commonSubstances,
];

const Map<String, String> diatomicElementFormulas = {
  'H':'H2','N':'N2','O':'O2','F':'F2','Cl':'Cl2','Br':'Br2','I':'I2','P':'P4','S':'S8',
};

String formulaForReaction(ChemicalSpecies species) {
  if (!species.isElement) return species.formula;
  return diatomicElementFormulas[species.elementSymbol] ?? species.formula;
}

String categoryName(ChemicalGroup group, bool english) {
  if (english) {
    switch (group) {
      case ChemicalGroup.alkaliMetals: return 'Alkali metals';
      case ChemicalGroup.alkalineEarthMetals: return 'Alkaline earth metals';
      case ChemicalGroup.transitionMetals: return 'Transition metals';
      case ChemicalGroup.postTransitionMetals: return 'Post-transition metals';
      case ChemicalGroup.metalloids: return 'Metalloids';
      case ChemicalGroup.nonmetals: return 'Nonmetals';
      case ChemicalGroup.halogens: return 'Halogens';
      case ChemicalGroup.nobleGases: return 'Noble gases';
      case ChemicalGroup.lanthanides: return 'Lanthanides';
      case ChemicalGroup.actinides: return 'Actinides';
      case ChemicalGroup.water: return 'Water';
      case ChemicalGroup.simpleSubstances: return 'Simple substances';
      case ChemicalGroup.oxides: return 'Oxides';
      case ChemicalGroup.acids: return 'Acids';
      case ChemicalGroup.bases: return 'Bases';
      case ChemicalGroup.salts: return 'Salts';
      case ChemicalGroup.organicCompounds: return 'Organic compounds';
      case ChemicalGroup.otherCompounds: return 'Other compounds';
    }
  }
  switch (group) {
    case ChemicalGroup.alkaliMetals: return 'Metais alcalinos';
    case ChemicalGroup.alkalineEarthMetals: return 'Metais alcalino-terrosos';
    case ChemicalGroup.transitionMetals: return 'Metais de transição';
    case ChemicalGroup.postTransitionMetals: return 'Metais pós-transição';
    case ChemicalGroup.metalloids: return 'Semimetais';
    case ChemicalGroup.nonmetals: return 'Não metais';
    case ChemicalGroup.halogens: return 'Halogéneos';
    case ChemicalGroup.nobleGases: return 'Gases nobres';
    case ChemicalGroup.lanthanides: return 'Lantanídeos';
    case ChemicalGroup.actinides: return 'Actinídeos';
    case ChemicalGroup.water: return 'Água';
    case ChemicalGroup.simpleSubstances: return 'Substâncias simples';
    case ChemicalGroup.oxides: return 'Óxidos';
    case ChemicalGroup.acids: return 'Ácidos';
    case ChemicalGroup.bases: return 'Bases';
    case ChemicalGroup.salts: return 'Sais';
    case ChemicalGroup.organicCompounds: return 'Compostos orgânicos';
    case ChemicalGroup.otherCompounds: return 'Outros compostos';
  }
}
