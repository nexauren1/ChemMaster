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
