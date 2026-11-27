import 'equation_balancer.dart';
import 'formula_parser.dart';

class ReactionPrediction {
  final String title;
  final String reactionType;
  final String equation;
  final String productSummary;
  final List<String> explanations;
  final String? note;
  final bool isGeneralReaction;

  const ReactionPrediction({
    required this.title,
    required this.reactionType,
    required this.equation,
    required this.productSummary,
    required this.explanations,
    this.note,
    this.isGeneralReaction = false,
  });
}

class _ReactionRule {
  final List<String> reactants;
  final List<String> products;
  final String title;
  final String type;
  final String summary;
  final List<String> explanation;
  final String? note;

  const _ReactionRule({
    required this.reactants,
    required this.products,
    required this.title,
    required this.type,
    required this.summary,
    required this.explanation,
    this.note,
  });
}

/// Offline reaction examples and patterns. This deliberately does not pretend
/// that arbitrary reactants always have one predictable product.
class ReactionPredictor {
  static const List<_ReactionRule> _rules = [
    _ReactionRule(
      reactants: ['CO2', 'H2O'],
      products: ['H2CO3'],
      title: 'Formação do ácido carbónico',
      type: 'Síntese • óxido ácido + água',
      summary: 'Forma-se ácido carbónico (H₂CO₃), um ácido fraco.',
      explanation: [
        'O dióxido de carbono (CO₂) é um óxido ácido.',
        'Quando se dissolve em água (H₂O), uma parte reage e forma ácido carbónico (H₂CO₃).',
        'A equação ajustada tem 1 átomo de carbono, 2 de hidrogénio e 3 de oxigénio em cada lado.',
      ],
      note: 'Em água, esta reacção é reversível: CO₂ + H₂O ⇌ H₂CO₃. Nem todo o CO₂ dissolvido fica convertido em ácido carbónico.',
    ),
    _ReactionRule(
      reactants: ['SO2', 'H2O'],
      products: ['H2SO3'],
      title: 'Formação do ácido sulfuroso',
      type: 'Síntese • óxido ácido + água',
      summary: 'O produto representado é o ácido sulfuroso (H₂SO₃).',
      explanation: [
        'O SO₂ é um óxido ácido de enxofre.',
        'A reacção com água é representada pela formação de H₂SO₃.',
        'Os átomos de S, H e O ficam conservados nos dois lados.',
      ],
      note: 'A química real do dióxido de enxofre dissolvido em água envolve equilíbrios entre espécies; a equação é uma representação escolar simplificada.',
    ),
    _ReactionRule(
      reactants: ['SO3', 'H2O'],
      products: ['H2SO4'],
      title: 'Formação do ácido sulfúrico',
      type: 'Síntese • óxido ácido + água',
      summary: 'Forma-se ácido sulfúrico (H₂SO₄).',
      explanation: [
        'O SO₃ é um óxido ácido.',
        'A combinação de SO₃ com água forma H₂SO₄.',
        'A proporção é 1 molécula de SO₃ para 1 molécula de água.',
      ],
    ),
    _ReactionRule(
      reactants: ['N2O5', 'H2O'],
      products: ['HNO3'],
      title: 'Formação do ácido nítrico',
      type: 'Síntese • óxido ácido + água',
      summary: 'Forma-se ácido nítrico (HNO₃).',
      explanation: [
        'O N₂O₅ é o anidrido do ácido nítrico.',
        'A água fornece hidrogénio e oxigénio para formar HNO₃.',
        'O balanceador coloca o coeficiente 2 no ácido nítrico para conservar os 2 átomos de azoto.',
      ],
    ),
    _ReactionRule(
      reactants: ['P2O5', 'H2O'],
      products: ['H3PO4'],
      title: 'Formação do ácido fosfórico',
      type: 'Síntese • óxido ácido + água',
      summary: 'Forma-se ácido fosfórico (H₃PO₄).',
      explanation: [
        'O P₂O₅ é um óxido ácido de fósforo.',
        'Ao reagir com água, pode formar ácido fosfórico.',
        'A equação ajustada usa 3H₂O e 2H₃PO₄ para conservar P, H e O.',
      ],
    ),
    _ReactionRule(
      reactants: ['CaO', 'H2O'],
      products: ['Ca(OH)2'],
      title: 'Formação do hidróxido de cálcio',
      type: 'Síntese • óxido básico + água',
      summary: 'Forma-se hidróxido de cálcio, Ca(OH)₂.',
      explanation: [
        'O CaO é um óxido básico.',
        'A água reage com o óxido e forma hidróxido de cálcio.',
        'O grupo OH aparece duas vezes porque o cálcio forma Ca(OH)₂.',
      ],
      note: 'A reacção liberta calor. Esta é uma explicação química, não uma instrução para misturar substâncias.',
    ),
    _ReactionRule(
      reactants: ['Na2O', 'H2O'],
      products: ['NaOH'],
      title: 'Formação do hidróxido de sódio',
      type: 'Síntese • óxido básico + água',
      summary: 'Forma-se hidróxido de sódio (NaOH).',
      explanation: [
        'O Na₂O é um óxido básico.',
        'A reacção com água produz NaOH.',
        'São necessários 2NaOH para conservar os dois átomos de sódio.',
      ],
    ),
    _ReactionRule(
      reactants: ['K2O', 'H2O'],
      products: ['KOH'],
      title: 'Formação do hidróxido de potássio',
      type: 'Síntese • óxido básico + água',
      summary: 'Forma-se hidróxido de potássio (KOH).',
      explanation: [
        'O K₂O é um óxido básico.',
        'A reacção com água forma KOH.',
        'O balanceamento coloca 2KOH no lado dos produtos.',
      ],
    ),
    _ReactionRule(
      reactants: ['H2', 'O2'],
      products: ['H2O'],
      title: 'Formação da água',
      type: 'Síntese',
      summary: 'O hidrogénio e o oxigénio formam água.',
      explanation: [
        'O hidrogénio molecular é H₂ e o oxigénio molecular é O₂.',
        'O produto é H₂O.',
        'A equação fica 2H₂ + O₂ → 2H₂O: há 4 H e 2 O em cada lado.',
      ],
      note: 'A reacção entre hidrogénio e oxigénio pode ser extremamente energética; não a realizes experimentalmente.',
    ),
    _ReactionRule(
      reactants: ['Mg', 'O2'],
      products: ['MgO'],
      title: 'Formação do óxido de magnésio',
      type: 'Síntese • metal + oxigénio',
      summary: 'Forma-se óxido de magnésio (MgO).',
      explanation: [
        'O magnésio combina-se com oxigénio.',
        'O produto binário é MgO.',
        'A equação ajustada é 2Mg + O₂ → 2MgO.',
      ],
    ),
    _ReactionRule(
      reactants: ['C', 'O2'],
      products: ['CO2'],
      title: 'Combustão completa do carbono',
      type: 'Combustão',
      summary: 'Com oxigénio suficiente, o carbono forma dióxido de carbono (CO₂).',
      explanation: [
        'O carbono reage com oxigénio molecular.',
        'Na combustão completa, o produto é CO₂.',
        'Há 1 átomo de carbono e 2 de oxigénio em cada lado.',
      ],
      note: 'Com pouco oxigénio pode formar-se monóxido de carbono (CO); a quantidade de oxigénio altera os produtos.',
    ),
    _ReactionRule(
      reactants: ['CH4', 'O2'],
      products: ['CO2', 'H2O'],
      title: 'Combustão completa do metano',
      type: 'Combustão de hidrocarboneto',
      summary: 'O metano forma dióxido de carbono e água quando há oxigénio suficiente.',
      explanation: [
        'O metano (CH₄) contém carbono e hidrogénio.',
        'Na combustão completa, o carbono passa para CO₂ e o hidrogénio para H₂O.',
        'O balanceamento correcto é CH₄ + 2O₂ → CO₂ + 2H₂O.',
        'Verificação: 1 C, 4 H e 4 O em cada lado.',
      ],
      note: 'A combustão incompleta pode produzir monóxido de carbono e/ou carbono. O resultado depende da disponibilidade de oxigénio.',
    ),
    _ReactionRule(
      reactants: ['HCl', 'NaOH'],
      products: ['NaCl', 'H2O'],
      title: 'Neutralização: ácido clorídrico + hidróxido de sódio',
      type: 'Neutralização ácido-base',
      summary: 'Forma-se cloreto de sódio (NaCl) e água.',
      explanation: [
        'HCl é o ácido e NaOH é a base.',
        'O H⁺ do ácido combina-se com o OH⁻ da base e forma água.',
        'Os iões Na⁺ e Cl⁻ formam o sal NaCl.',
        'A proporção é 1:1:1:1.',
      ],
    ),
    _ReactionRule(
      reactants: ['HCl', 'KOH'],
      products: ['KCl', 'H2O'],
      title: 'Neutralização: ácido clorídrico + hidróxido de potássio',
      type: 'Neutralização ácido-base',
      summary: 'Forma-se cloreto de potássio (KCl) e água.',
      explanation: [
        'HCl é o ácido e KOH é a base.',
        'H⁺ combina-se com OH⁻ e forma H₂O.',
        'K⁺ e Cl⁻ formam o sal KCl.',
        'A equação já fica ajustada com coeficientes 1.',
      ],
    ),
    _ReactionRule(
      reactants: ['H2SO4', 'NaOH'],
      products: ['Na2SO4', 'H2O'],
      title: 'Neutralização: ácido sulfúrico + hidróxido de sódio',
      type: 'Neutralização ácido-base',
      summary: 'Forma-se sulfato de sódio (Na₂SO₄) e água.',
      explanation: [
        'O H₂SO₄ pode fornecer 2 H⁺ por molécula.',
        'Cada NaOH fornece um OH⁻; são necessárias 2 unidades de NaOH.',
        'O sal formado é Na₂SO₄ e também se formam 2H₂O.',
      ],
    ),
    _ReactionRule(
      reactants: ['HNO3', 'KOH'],
      products: ['KNO3', 'H2O'],
      title: 'Neutralização: ácido nítrico + hidróxido de potássio',
      type: 'Neutralização ácido-base',
      summary: 'Forma-se nitrato de potássio (KNO₃) e água.',
      explanation: [
        'HNO₃ é o ácido nítrico e KOH é o hidróxido de potássio.',
        'H⁺ e OH⁻ formam H₂O.',
        'K⁺ e NO₃⁻ formam o sal KNO₃.',
      ],
    ),
    _ReactionRule(
      reactants: ['Ca(OH)2', 'HCl'],
      products: ['CaCl2', 'H2O'],
      title: 'Neutralização: hidróxido de cálcio + ácido clorídrico',
      type: 'Neutralização ácido-base',
      summary: 'Forma-se cloreto de cálcio (CaCl₂) e água.',
      explanation: [
        'Ca(OH)₂ possui dois grupos OH⁻.',
        'São necessárias duas moléculas de HCl para fornecer os dois H⁺.',
        'Formam-se CaCl₂ e 2H₂O.',
      ],
    ),
    _ReactionRule(
      reactants: ['Fe', 'S'],
      products: ['FeS'],
      title: 'Formação do sulfureto de ferro',
      type: 'Síntese',
      summary: 'Ferro e enxofre formam sulfureto de ferro (FeS).',
      explanation: [
        'O ferro e o enxofre combinam-se numa proporção 1:1.',
        'O composto formado é FeS.',
        'A equação Fe + S → FeS conserva um átomo de cada elemento.',
      ],
    ),
    _ReactionRule(
      reactants: ['Na', 'Cl2'],
      products: ['NaCl'],
      title: 'Formação do cloreto de sódio',
      type: 'Síntese • metal + não metal',
      summary: 'Forma-se cloreto de sódio (NaCl).',
      explanation: [
        'O sódio forma iões Na⁺ e o cloro forma iões Cl⁻.',
        'As cargas equilibram-se na proporção 1:1, formando NaCl.',
        'Como o cloro elementar é Cl₂, são necessários 2Na para formar 2NaCl.',
      ],
      note: 'A reacção directa dos elementos é muito energética; não a realizes experimentalmente.',
    ),
    _ReactionRule(
      reactants: ['CaCO3', 'HCl'],
      products: ['CaCl2', 'CO2', 'H2O'],
      title: 'Carbonato + ácido',
      type: 'Reacção de ácido com carbonato',
      summary: 'Forma-se um sal, dióxido de carbono e água.',
      explanation: [
        'O carbonato reage com o ácido.',
        'O cálcio e o cloreto formam CaCl₂.',
        'O grupo carbonato origina CO₂ e água; são necessárias 2 moléculas de HCl.',
      ],
    ),
    _ReactionRule(
      reactants: ['AgNO3', 'NaCl'],
      products: ['AgCl', 'NaNO3'],
      title: 'Formação de um precipitado',
      type: 'Dupla troca • precipitação',
      summary: 'Forma-se cloreto de prata (AgCl), um precipitado branco, e nitrato de sódio.',
      explanation: [
        'Os iões trocam parceiros: Ag⁺ combina-se com Cl⁻.',
        'O AgCl é pouco solúvel em água e precipita.',
        'Na⁺ e NO₃⁻ permanecem em solução como nitrato de sódio.',
      ],
    ),
    _ReactionRule(
      reactants: ['Na2CO3', 'HCl'],
      products: ['NaCl', 'CO2', 'H2O'],
      title: 'Carbonato de sódio + ácido clorídrico',
      type: 'Reacção de ácido com carbonato',
      summary: 'Forma-se cloreto de sódio, dióxido de carbono e água.',
      explanation: [
        'O carbonato reage com o ácido e liberta CO₂.',
        'O sódio e o cloreto formam NaCl.',
        'A equação ajustada usa 2HCl e 2NaCl.',
      ],
    ),
    _ReactionRule(
      reactants: ['Mg', 'HCl'],
      products: ['MgCl2', 'H2'],
      title: 'Metal + ácido',
      type: 'Deslocamento simples',
      summary: 'O magnésio desloca o hidrogénio do ácido e forma MgCl₂ e H₂.',
      explanation: [
        'O magnésio é mais reactivo que o hidrogénio.',
        'O magnésio passa para Mg²⁺ e o hidrogénio forma H₂.',
        'São necessárias 2 moléculas de HCl para fornecer 2 Cl e 2 H.',
      ],
      note: 'A reacção pode libertar hidrogénio inflamável. Não a realizes experimentalmente.',
    ),
    _ReactionRule(
      reactants: ['Na', 'Cl2'],
      products: ['NaCl'],
      title: 'Formação do cloreto de sódio',
      type: 'Síntese • metal + halogéneo',
      summary: 'O sódio e o cloro formam cloreto de sódio (NaCl).',
      explanation: [
        'O sódio forma iões Na⁺ e o cloro forma iões Cl⁻.',
        'As cargas equilibram-se na proporção 1:1, formando NaCl.',
        'Como o cloro elementar é diatómico (Cl₂), a equação usa 2Na e 2NaCl.',
      ],
      note: 'A reacção directa é muito energética. Este é um exemplo teórico, não uma experiência para fazer em casa.',
    ),
    _ReactionRule(
      reactants: ['K', 'Cl2'],
      products: ['KCl'],
      title: 'Formação do cloreto de potássio',
      type: 'Síntese • metal + halogéneo',
      summary: 'O potássio e o cloro formam cloreto de potássio (KCl).',
      explanation: [
        'O potássio forma iões K⁺ e o cloro forma iões Cl⁻.',
        'Os iões combinam-se numa proporção 1:1.',
        'A equação ajustada é 2K + Cl₂ → 2KCl.',
      ],
      note: 'A reacção é muito energética e é mostrada apenas como exemplo teórico.',
    ),
    _ReactionRule(
      reactants: ['Ca', 'Cl2'],
      products: ['CaCl2'],
      title: 'Formação do cloreto de cálcio',
      type: 'Síntese • metal + halogéneo',
      summary: 'Forma-se cloreto de cálcio (CaCl₂).',
      explanation: [
        'O cálcio forma iões Ca²⁺.',
        'Cada cloro forma um ião Cl⁻; são necessários dois cloretos para equilibrar a carga do cálcio.',
        'A fórmula do composto é CaCl₂.',
      ],
    ),
    _ReactionRule(
      reactants: ['Mg', 'Cl2'],
      products: ['MgCl2'],
      title: 'Formação do cloreto de magnésio',
      type: 'Síntese • metal + halogéneo',
      summary: 'Forma-se cloreto de magnésio (MgCl₂).',
      explanation: [
        'O magnésio forma o ião Mg²⁺.',
        'Dois iões cloreto Cl⁻ equilibram a carga.',
        'A equação fica Mg + Cl₂ → MgCl₂.',
      ],
    ),
    _ReactionRule(
      reactants: ['Ca', 'O2'],
      products: ['CaO'],
      title: 'Formação do óxido de cálcio',
      type: 'Síntese • metal + oxigénio',
      summary: 'O cálcio reage com oxigénio e forma óxido de cálcio (CaO).',
      explanation: [
        'O cálcio forma iões Ca²⁺ e o oxigénio forma iões O²⁻ no composto iónico.',
        'A proporção de cargas é 1:1, por isso a fórmula é CaO.',
        'A equação ajustada é 2Ca + O₂ → 2CaO.',
      ],
    ),
    _ReactionRule(
      reactants: ['Al', 'O2'],
      products: ['Al2O3'],
      title: 'Formação do óxido de alumínio',
      type: 'Síntese • metal + oxigénio',
      summary: 'Forma-se óxido de alumínio (Al₂O₃).',
      explanation: [
        'O alumínio forma normalmente iões Al³⁺ e o oxigénio forma O²⁻.',
        'A combinação que neutraliza as cargas é Al₂O₃.',
        'O balanceamento dá 4Al + 3O₂ → 2Al₂O₃.',
      ],
    ),
    _ReactionRule(
      reactants: ['Zn', 'O2'],
      products: ['ZnO'],
      title: 'Formação do óxido de zinco',
      type: 'Síntese • metal + oxigénio',
      summary: 'Forma-se óxido de zinco (ZnO).',
      explanation: [
        'O zinco forma normalmente Zn²⁺ e o oxigénio forma O²⁻.',
        'A fórmula do composto é ZnO.',
        'A equação equilibrada é 2Zn + O₂ → 2ZnO.',
      ],
    ),
    _ReactionRule(
      reactants: ['Fe', 'O2'],
      products: ['Fe2O3'],
      title: 'Formação do óxido de ferro (III)',
      type: 'Síntese • oxidação',
      summary: 'Neste modelo escolar forma-se óxido de ferro (III), Fe₂O₃.',
      explanation: [
        'O ferro combina-se com oxigénio.',
        'O produto representado nesta reacção é Fe₂O₃.',
        'A equação equilibrada é 4Fe + 3O₂ → 2Fe₂O₃.',
      ],
      note: 'O ferro pode formar outros óxidos, como FeO e Fe₃O₄. O produto real depende das condições de oxidação.',
    ),
    _ReactionRule(
      reactants: ['Cu', 'O2'],
      products: ['CuO'],
      title: 'Formação do óxido de cobre (II)',
      type: 'Síntese • oxidação',
      summary: 'Neste exemplo, o cobre forma óxido de cobre (II), CuO.',
      explanation: [
        'O cobre reage com oxigénio.',
        'O produto considerado é CuO, em que o cobre está no estado de oxidação +2.',
        'A equação ajustada é 2Cu + O₂ → 2CuO.',
      ],
      note: 'O cobre também pode formar Cu₂O. O produto depende das condições e da disponibilidade de oxigénio.',
    ),
    _ReactionRule(
      reactants: ['Zn', 'HCl'],
      products: ['ZnCl2', 'H2'],
      title: 'Zinco + ácido clorídrico',
      type: 'Deslocamento simples',
      summary: 'O zinco forma cloreto de zinco e liberta hidrogénio.',
      explanation: [
        'O zinco é mais reactivo que o hidrogénio.',
        'O zinco passa para Zn²⁺ e combina-se com dois iões cloreto.',
        'Dois H⁺ formam uma molécula de H₂; por isso são necessárias duas moléculas de HCl.',
      ],
      note: 'A reacção pode libertar hidrogénio inflamável. Não mistures ácidos com metais fora de um laboratório supervisionado.',
    ),
    _ReactionRule(
      reactants: ['Al', 'HCl'],
      products: ['AlCl3', 'H2'],
      title: 'Alumínio + ácido clorídrico',
      type: 'Deslocamento simples',
      summary: 'Forma-se cloreto de alumínio e hidrogénio.',
      explanation: [
        'O alumínio forma normalmente iões Al³⁺.',
        'Três iões cloreto equilibram a carga de cada Al³⁺.',
        'O balanceamento é 2Al + 6HCl → 2AlCl₃ + 3H₂.',
      ],
      note: 'A reacção pode ser vigorosa e libertar hidrogénio inflamável. É apresentada apenas para estudo teórico.',
    ),
    _ReactionRule(
      reactants: ['Fe', 'HCl'],
      products: ['FeCl2', 'H2'],
      title: 'Ferro + ácido clorídrico',
      type: 'Deslocamento simples',
      summary: 'Com ácido clorídrico diluído, o ferro pode formar cloreto de ferro (II) e hidrogénio.',
      explanation: [
        'O ferro desloca o hidrogénio do ácido.',
        'Neste exemplo, o ferro forma Fe²⁺, que se combina com dois Cl⁻.',
        'A equação equilibrada é Fe + 2HCl → FeCl₂ + H₂.',
      ],
      note: 'O produto depende do ácido e das condições. O exemplo considera ácido clorídrico diluído e não oxidante.',
    ),
    _ReactionRule(
      reactants: ['H2O2'],
      products: ['H2O', 'O2'],
      title: 'Decomposição do peróxido de hidrogénio',
      type: 'Decomposição',
      summary: 'O peróxido de hidrogénio decompõe-se em água e oxigénio.',
      explanation: [
        'Uma substância inicial origina duas substâncias mais simples.',
        'O balanceamento exige 2 moléculas de H₂O₂.',
        'A equação fica 2H₂O₂ → 2H₂O + O₂.',
      ],
      note: 'A velocidade depende de luz, temperatura e catalisadores. Não mistures produtos químicos para tentar reproduzir a reacção.',
    ),
    _ReactionRule(
      reactants: ['CaCO3'],
      products: ['CaO', 'CO2'],
      title: 'Decomposição térmica do carbonato de cálcio',
      type: 'Decomposição • aquecimento',
      summary: 'Ao ser aquecido suficientemente, o carbonato de cálcio forma óxido de cálcio e dióxido de carbono.',
      explanation: [
        'O composto CaCO₃ decompõe-se em CaO e CO₂.',
        'O cálcio, carbono e oxigénio estão conservados.',
        'A equação CaCO₃ → CaO + CO₂ já está equilibrada.',
      ],
      note: 'É necessária temperatura elevada. O produto e a extensão da transformação dependem das condições.',
    ),
    _ReactionRule(
      reactants: ['NaHCO3'],
      products: ['Na2CO3', 'CO2', 'H2O'],
      title: 'Decomposição do hidrogenocarbonato de sódio',
      type: 'Decomposição • aquecimento',
      summary: 'O hidrogenocarbonato de sódio pode formar carbonato de sódio, dióxido de carbono e água quando aquecido.',
      explanation: [
        'Duas unidades de NaHCO₃ fornecem dois átomos de sódio.',
        'Os restantes átomos distribuem-se por Na₂CO₃, CO₂ e H₂O.',
        'A equação equilibrada é 2NaHCO₃ → Na₂CO₃ + CO₂ + H₂O.',
      ],
    ),
    _ReactionRule(
      reactants: ['BaCl2', 'Na2SO4'],
      products: ['BaSO4', 'NaCl'],
      title: 'Precipitação do sulfato de bário',
      type: 'Dupla troca • precipitação',
      summary: 'Forma-se sulfato de bário, um precipitado branco, e cloreto de sódio.',
      explanation: [
        'Os iões Ba²⁺ e SO₄²⁻ combinam-se e formam BaSO₄ pouco solúvel.',
        'Os iões Na⁺ e Cl⁻ permanecem como cloreto de sódio em solução.',
        'São necessários 2NaCl para equilibrar o sódio e o cloro.',
      ],
      note: 'Os sais de bário solúveis são tóxicos. O exemplo é para estudo de precipitação, não para preparação prática.',
    ),
    _ReactionRule(
      reactants: ['NaHCO3', 'HCl'],
      products: ['NaCl', 'CO2', 'H2O'],
      title: 'Hidrogenocarbonato + ácido',
      type: 'Ácido + carbonato',
      summary: 'Forma-se um sal, dióxido de carbono e água.',
      explanation: [
        'O ácido fornece H⁺ e o hidrogenocarbonato reage libertando CO₂.',
        'O sódio e o cloreto formam NaCl.',
        'A equação NaHCO₃ + HCl → NaCl + CO₂ + H₂O está equilibrada.',
      ],
    ),
    _ReactionRule(
      reactants: ['NH3', 'HCl'],
      products: ['NH4Cl'],
      title: 'Formação do cloreto de amónio',
      type: 'Reacção ácido-base',
      summary: 'O amoníaco e o cloreto de hidrogénio formam cloreto de amónio.',
      explanation: [
        'O amoníaco NH₃ aceita um protão H⁺ e forma o ião amónio NH₄⁺.',
        'O cloreto de hidrogénio fornece H⁺ e forma Cl⁻.',
        'NH₄⁺ e Cl⁻ combinam-se na proporção 1:1, formando NH₄Cl.',
      ],
      note: 'A equação representa uma reacção entre gases; não mistures amoníaco e ácidos fora de condições laboratoriais controladas.',
    ),
    _ReactionRule(
      reactants: ['N2', 'H2'],
      products: ['NH3'],
      title: 'Síntese do amoníaco',
      type: 'Síntese • processo de Haber',
      summary: 'O azoto e o hidrogénio podem formar amoníaco.',
      explanation: [
        'O azoto molecular é N₂ e o hidrogénio molecular é H₂.',
        'Cada molécula de NH₃ contém um N e três H.',
        'A equação equilibrada é N₂ + 3H₂ ⇌ 2NH₃.',
      ],
      note: 'O processo industrial de Haber usa condições controladas de pressão e temperatura e um catalisador. A equação é reversível.',
    ),
    _ReactionRule(
      reactants: ['H2', 'Cl2'],
      products: ['HCl'],
      title: 'Formação do cloreto de hidrogénio',
      type: 'Síntese',
      summary: 'O hidrogénio e o cloro formam cloreto de hidrogénio.',
      explanation: [
        'O hidrogénio e o cloro elementares são moléculas diatómicas.',
        'Cada molécula de HCl contém um átomo de H e um de Cl.',
        'A equação equilibrada é H₂ + Cl₂ → 2HCl.',
      ],
      note: 'Esta reacção pode ser violenta na presença de luz. É apenas um exemplo teórico.',
    ),
    _ReactionRule(
      reactants: ['C2H6', 'O2'],
      products: ['CO2', 'H2O'],
      title: 'Combustão completa do etano',
      type: 'Combustão de hidrocarboneto',
      summary: 'O etano queima em oxigénio suficiente e forma dióxido de carbono e água.',
      explanation: [
        'O etano C₂H₆ contém carbono e hidrogénio.',
        'Na combustão completa, o carbono forma CO₂ e o hidrogénio forma H₂O.',
        'A equação equilibrada é 2C₂H₆ + 7O₂ → 4CO₂ + 6H₂O.',
      ],
      note: 'Com pouco oxigénio pode ocorrer combustão incompleta.',
    ),
    _ReactionRule(
      reactants: ['C3H8', 'O2'],
      products: ['CO2', 'H2O'],
      title: 'Combustão completa do propano',
      type: 'Combustão de hidrocarboneto',
      summary: 'O propano forma dióxido de carbono e água na combustão completa.',
      explanation: [
        'O propano C₃H₈ tem três átomos de carbono e oito de hidrogénio.',
        'São necessários 3CO₂ para conservar o carbono e 4H₂O para conservar o hidrogénio.',
        'A equação equilibrada é C₃H₈ + 5O₂ → 3CO₂ + 4H₂O.',
      ],
    ),
    _ReactionRule(
      reactants: ['C2H6O', 'O2'],
      products: ['CO2', 'H2O'],
      title: 'Combustão completa do etanol',
      type: 'Combustão de álcool',
      summary: 'O etanol forma dióxido de carbono e água na combustão completa.',
      explanation: [
        'O etanol tem fórmula molecular C₂H₆O.',
        'O carbono forma CO₂ e o hidrogénio forma H₂O.',
        'A equação equilibrada é C₂H₆O + 3O₂ → 2CO₂ + 3H₂O.',
      ],
    ),
    _ReactionRule(
      reactants: ['C6H12O6', 'O2'],
      products: ['CO2', 'H2O'],
      title: 'Oxidação completa da glicose',
      type: 'Oxidação • reacção global',
      summary: 'A oxidação completa da glicose produz dióxido de carbono e água.',
      explanation: [
        'A glicose contém seis átomos de carbono e doze de hidrogénio.',
        'São formadas 6 moléculas de CO₂ e 6 moléculas de H₂O.',
        'A equação global equilibrada é C₆H₁₂O₆ + 6O₂ → 6CO₂ + 6H₂O.',
      ],
      note: 'Esta é uma equação global simplificada da oxidação da glicose, não uma única etapa bioquímica.',
    ),
    _ReactionRule(
      reactants: ['HNO3', 'NaOH'],
      products: ['NaNO3', 'H2O'],
      title: 'Neutralização: ácido nítrico + hidróxido de sódio',
      type: 'Neutralização ácido-base',
      summary: 'Forma-se nitrato de sódio e água.',
      explanation: [
        'HNO₃ é o ácido e NaOH é a base.',
        'H⁺ combina-se com OH⁻ e forma água.',
        'Na⁺ e NO₃⁻ formam NaNO₃.',
      ],
    ),
    _ReactionRule(
      reactants: ['H2SO4', 'KOH'],
      products: ['K2SO4', 'H2O'],
      title: 'Neutralização: ácido sulfúrico + hidróxido de potássio',
      type: 'Neutralização ácido-base',
      summary: 'Forma-se sulfato de potássio e água.',
      explanation: [
        'Uma molécula de H₂SO₄ pode fornecer dois protões.',
        'São necessárias duas moléculas de KOH para fornecer dois iões OH⁻.',
        'A equação equilibrada é H₂SO₄ + 2KOH → K₂SO₄ + 2H₂O.',
      ],
    ),
    _ReactionRule(
      reactants: ['H3PO4', 'NaOH'],
      products: ['Na3PO4', 'H2O'],
      title: 'Neutralização completa do ácido fosfórico',
      type: 'Neutralização ácido-base',
      summary: 'Na neutralização completa, forma-se fosfato de sódio e água.',
      explanation: [
        'O H₃PO₄ pode fornecer três protões numa neutralização completa.',
        'São necessárias três moléculas de NaOH.',
        'A equação equilibrada é H₃PO₄ + 3NaOH → Na₃PO₄ + 3H₂O.',
      ],
      note: 'Com quantidades diferentes de base podem formar-se sais ácidos, como NaH₂PO₄ ou Na₂HPO₄.',
    ),

  ];

  static String _fold(String value) => value
      .toLowerCase()
      .replaceAll('á', 'a')
      .replaceAll('à', 'a')
      .replaceAll('ã', 'a')
      .replaceAll('â', 'a')
      .replaceAll('é', 'e')
      .replaceAll('ê', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ó', 'o')
      .replaceAll('ô', 'o')
      .replaceAll('õ', 'o')
      .replaceAll('ú', 'u')
      .replaceAll('ç', 'c');

  static String _key(Iterable<String> formulas) {
    final sorted = formulas.toList()..sort();
    return sorted.join('|');
  }

  static ReactionPrediction? predict(String input) {
    final raw = input.trim();
    if (raw.isEmpty) {
      throw const FormatException('Escreve os reagentes ou o nome do produto.');
    }

    final folded = _fold(raw);
    if (folded.contains('sabao') ||
        folded.contains('saponific') ||
        folded.contains('triglicer') ||
        (folded.contains('oleo') && folded.contains('naoh')) ||
        (folded.contains('gordura') && folded.contains('naoh'))) {
      return soap();
    }

    if (RegExp(r'(->|→|⇒|⇌|=)').hasMatch(raw)) {
      final balanced = EquationBalancer.balance(raw);
      return ReactionPrediction(
        title: 'Equação balanceada',
        reactionType: 'Conservação dos átomos',
        equation: balanced,
        productSummary: 'A equação foi ajustada para conservar cada elemento.',
        explanations: [
          'O app leu os reagentes e os produtos que escreveste.',
          'O balanceador calculou os menores coeficientes inteiros positivos encontrados.',
          'Os índices dentro das fórmulas não foram alterados; apenas os coeficientes à frente das fórmulas podem mudar.',
        ],
        note: 'O balanceamento confirma a conservação dos átomos, mas não prova por si só que a reacção ocorre nas condições reais.',
      );
    }

    final parts = raw.split('+').map((part) => part.trim()).toList();
    if (parts.isEmpty || parts.length > 4 || parts.any((part) => part.isEmpty)) {
      throw const FormatException('Escreve os reagentes separados pelo sinal +.');
    }
    final reactants = parts.map(FormulaParser.normalize).toList();
    final searchKey = _key(reactants);

    for (final rule in _rules) {
      if (_key(rule.reactants) == searchKey) {
        final left = reactants.join(' + ');
        final right = rule.products.join(' + ');
        final equation = EquationBalancer.balance('$left -> $right');
        return ReactionPrediction(
          title: rule.title,
          reactionType: rule.type,
          equation: equation,
          productSummary: rule.summary,
          explanations: [
            ...rule.explanation,
            'O balanceador ajustou os coeficientes sem mudar as fórmulas químicas.',
          ],
          note: rule.note,
        );
      }
    }

    return null;
  }

  static ReactionPrediction soap() => const ReactionPrediction(
        title: 'Como se forma o sabão?',
        reactionType: 'Saponificação • hidrólise básica de triglicéridos',
        equation: 'Triglicérido + 3NaOH → 3RCOONa + C₃H₈O₃',
        productSummary:
            'Óleos ou gorduras reagem com uma base forte e formam sabão e glicerol.',
        explanations: [
          'Os óleos e as gorduras contêm principalmente triglicéridos, moléculas construídas a partir de glicerol e ácidos gordos.',
          'Na saponificação, o triglicérido reage com hidróxido de sódio (NaOH) ou hidróxido de potássio (KOH).',
          'Com NaOH formam-se sais de sódio dos ácidos gordos, normalmente sabões sólidos. Com KOH formam-se sais de potássio, frequentemente usados em sabões mais moles ou líquidos.',
          'O outro produto principal é o glicerol (glicerina).',
        ],
        note:
            'R representa a cadeia de cada ácido gordo; por isso, esta é uma equação geral, não uma fórmula única para todos os óleos. NaOH e KOH são corrosivos. Esta explicação é conceptual e não é uma receita para preparar sabão.',
        isGeneralReaction: true,
      );
}
