import 'package:flutter/material.dart';

import '../core/chem_language.dart';
import '../data/chemical_catalog.dart';
import '../data/reaction_localization.dart';
import '../widgets/chemical_picker.dart';

import '../chemistry/electron_configuration.dart';
import '../chemistry/equation_analysis.dart';
import '../chemistry/reaction_predictor.dart';
import '../data/periodic_elements.dart';

const Color _chemBlue = Color(0xFF087BFF);
const Color _chemCyan = Color(0xFF16D9F5);
const Color _chemViolet = Color(0xFF762BFF);

class ProductDiscoveryScreen extends StatefulWidget {
  const ProductDiscoveryScreen({super.key});

  @override
  State<ProductDiscoveryScreen> createState() => _ProductDiscoveryScreenState();
}

class _ProductDiscoveryScreenState extends State<ProductDiscoveryScreen> {
  final List<ChemicalSpecies> _reactants = [];
  ReactionPrediction? _prediction;
  String? _message;
  bool _searched = false;

  bool get _english => isEnglish(context);

  Future<void> _addReactant() async {
    if (_reactants.length >= 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_english
            ? 'Choose up to four reactants for this tool.'
            : 'Escolhe até quatro reagentes nesta ferramenta.')),
      );
      return;
    }
    final item = await ChemicalPicker.show(context);
    if (!mounted || item == null) return;
    setState(() {
      if (!_reactants.any((existing) => formulaForReaction(existing) == formulaForReaction(item))) {
        _reactants.add(item);
      }
      _prediction = null;
      _message = null;
      _searched = false;
    });
  }

  void _loadExample(List<String> formulas) {
    final items = formulas.map((formula) => chemicalCatalog.firstWhere(
      (item) => item.formula == formula,
    )).toList();
    setState(() {
      _reactants
        ..clear()
        ..addAll(items);
      _prediction = null;
      _message = null;
      _searched = false;
    });
  }

  void _removeReactant(ChemicalSpecies item) {
    setState(() {
      _reactants.remove(item);
      _prediction = null;
      _message = null;
      _searched = false;
    });
  }

  void _discover() {
    if (_reactants.isEmpty) {
      setState(() {
        _prediction = null;
        _message = _english
            ? 'Choose at least one reactant or starting substance.'
            : 'Escolhe pelo menos um reagente ou substância inicial.';
        _searched = true;
      });
      return;
    }
    try {
      final formulas = _reactants.map(formulaForReaction).toList();
      final result = ReactionPredictor.predict(formulas.join(' + '));
      setState(() {
        _prediction = result;
        _message = result == null
            ? (_english
                ? 'This combination is not yet in the verified reaction library. Products may depend on temperature, concentration, pressure, solvent or a catalyst. The app will not guess.'
                : 'Esta combinação ainda não está na biblioteca de reacções verificadas. Os produtos podem depender da temperatura, concentração, pressão, solvente ou catalisador. O app não vai adivinhar.')
            : null;
        _searched = true;
      });
    } on FormatException catch (error) {
      setState(() {
        _prediction = null;
        _message = _english
            ? 'I could not interpret this selection. Check the chosen substances and try again.'
            : error.message.toString();
        _searched = true;
      });
    } catch (_) {
      setState(() {
        _prediction = null;
        _message = _english
            ? 'I could not interpret this selection. Choose the substances again.'
            : 'Não consegui interpretar esta selecção. Escolhe novamente as substâncias.';
        _searched = true;
      });
    }
  }

  void _showSoap() {
    setState(() {
      _prediction = ReactionPredictor.soap();
      _message = null;
      _searched = true;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(_english ? 'Discover products' : 'Descobrir produtos'),
    ),
    body: ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(
          _english
              ? 'Tap + and select the reactants. ChemMaster searches its offline reaction library, predicts known products and balances the equation.'
              : 'Toca em + e escolhe os reagentes. O ChemMaster consulta a biblioteca offline de reacções, apresenta produtos conhecidos e equilibra a equação.',
          style: const TextStyle(fontSize: 15, height: 1.45),
        ),
        const SizedBox(height: 15),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.science_outlined, color: _chemCyan),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _english ? 'Selected reactants' : 'Reagentes escolhidos',
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    Text(
                      _reactants.length.toString() + '/4',
                      style: const TextStyle(color: _chemCyan, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (_reactants.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Center(
                      child: Text(
                        _english ? 'No reactants selected yet' : 'Ainda não escolheste reagentes',
                      ),
                    ),
                  )
                else
                  ..._reactants.map(
                    (item) => Container(
                      margin: const EdgeInsets.only(bottom: 7),
                      decoration: BoxDecoration(
                        color: _chemBlue.withValues(alpha: .10),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: ListTile(
                        dense: true,
                        leading: Text(
                          prettyFormula(formulaForReaction(item)),
                          style: const TextStyle(color: _chemCyan, fontWeight: FontWeight.w900, fontSize: 17),
                        ),
                        title: Text(item.name(_english), style: const TextStyle(fontWeight: FontWeight.w800)),
                        subtitle: Text(item.isElement
                            ? (_english ? 'Element • usual reaction form' : 'Elemento • forma habitual na reacção')
                            : categoryName(item.group, _english)),
                        trailing: IconButton(
                          onPressed: () => _removeReactant(item),
                          icon: const Icon(Icons.close),
                          tooltip: _english ? 'Remove' : 'Remover',
                        ),
                      ),
                    ),
                  ),
                OutlinedButton.icon(
                  onPressed: _addReactant,
                  icon: const Icon(Icons.add_circle_outline),
                  label: Text(_english ? 'Add reactant from catalog' : 'Adicionar reagente do catálogo'),
                  style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 13),
        Text(
          _english ? 'Try a guided example' : 'Experimenta um exemplo',
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ActionChip(
              label: const Text('CO₂ + H₂O'),
              onPressed: () => _loadExample(['CO2', 'H2O']),
            ),
            ActionChip(
              label: const Text('HCl + KOH'),
              onPressed: () => _loadExample(['HCl', 'KOH']),
            ),
            ActionChip(
              label: const Text('CaO + H₂O'),
              onPressed: () => _loadExample(['CaO', 'H2O']),
            ),
            ActionChip(
              label: const Text('CH₄ + O₂'),
              onPressed: () => _loadExample(['CH4', 'O2']),
            ),
            ActionChip(
              label: const Text('H₂O₂'),
              onPressed: () => _loadExample(['H2O2']),
            ),
            ActionChip(
              label: const Text('CaCO₃'),
              onPressed: () => _loadExample(['CaCO3']),
            ),
            ActionChip(
              label: Text(_english ? 'Soap' : 'Sabão'),
              onPressed: _showSoap,
            ),
          ],
        ),
        const SizedBox(height: 14),
        FilledButton.icon(
          onPressed: _discover,
          icon: const Icon(Icons.auto_awesome),
          label: Text(_english ? 'Discover products' : 'Descobrir produtos'),
        ),
        if (_searched && _prediction != null) ...[
          const SizedBox(height: 18),
          _PredictionResult(prediction: _prediction!),
        ],
        if (_searched && _message != null) ...[
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.orange),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _english
                              ? 'The result needs more chemistry data'
                              : 'Ainda não é possível determinar o produto',
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(_message!, style: const TextStyle(height: 1.45)),
                  const SizedBox(height: 10),
                  Text(
                    _english
                        ? 'Elements are not magic ingredients: not every pair reacts, and one pair can form different products under different conditions.'
                        : 'Os elementos não são ingredientes mágicos: nem todos os pares reagem, e o mesmo par pode formar produtos diferentes em condições diferentes.',
                    style: const TextStyle(fontSize: 12, color: Colors.amber, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 18),
        _InfoPanel(
          title: _english ? 'How this tool works' : 'Como esta ferramenta funciona',
          body: _english
              ? 'The offline library contains curated school-level reactions. It is designed to give reliable explanations, not to invent products for every possible mixture. New reactions can be added as reviewed learning modules.'
              : 'A biblioteca offline contém reacções escolares seleccionadas e revistas. Foi criada para dar explicações fiáveis, não para inventar produtos para qualquer mistura. Novas reacções podem ser acrescentadas como módulos de aprendizagem revistos.',
        ),
      ],
    ),
  );
}

class _PredictionResult extends StatelessWidget {
  final ReactionPrediction prediction;
  const _PredictionResult({required this.prediction});

  @override
  Widget build(BuildContext context) {
    final english = isEnglish(context);
    final text = localizedReactionText(prediction, english);
    final atomCounts = prediction.isGeneralReaction
        ? <String, AtomBalance>{}
        : EquationAnalysis.analyze(prediction.equation);
    final displayedEquation = prediction.isGeneralReaction && english
        ? 'Triglyceride + 3NaOH → 3RCOONa + C₃H₈O₃'
        : prettyEquation(prediction.equation);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle, color: _chemCyan),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    text.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(text.type, style: const TextStyle(color: _chemCyan)),
            const SizedBox(height: 15),
            Text(english ? 'Equation' : 'Equação', style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 7),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: _chemBlue.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _chemCyan.withValues(alpha: .45)),
              ),
              child: SelectableText(
                displayedEquation,
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900, height: 1.5),
              ),
            ),
            const SizedBox(height: 12),
            Text(text.summary, style: const TextStyle(height: 1.45)),
            if (atomCounts.isNotEmpty) ...[
              const Divider(height: 26),
              Text(
                english ? 'Atom conservation check' : 'Verificação da conservação dos átomos',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              ...atomCounts.entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 34,
                        child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w900)),
                      ),
                      Expanded(
                        child: Text((english ? 'Reactants: ' : 'Reagentes: ') + entry.value.reactants.toString()),
                      ),
                      Expanded(
                        child: Text((english ? 'Products: ' : 'Produtos: ') + entry.value.products.toString()),
                      ),
                      Icon(
                        entry.value.isBalanced ? Icons.check_circle : Icons.error,
                        color: entry.value.isBalanced ? Colors.green : Colors.red,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                english
                    ? 'The number of atoms of each element is the same on both sides.'
                    : 'O número de átomos de cada elemento é igual nos dois lados.',
                style: const TextStyle(fontSize: 12, height: 1.4),
              ),
            ],
            const SizedBox(height: 14),
            Text(
              english ? 'Step-by-step explanation' : 'Explicação passo a passo',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            ...text.explanations.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _chemViolet.withValues(alpha: .22),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        (entry.key + 1).toString(),
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(child: Text(entry.value, style: const TextStyle(height: 1.4))),
                  ],
                ),
              ),
            ),
            if (text.note != null) ...[
              const Divider(height: 22),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_outline, color: Colors.orange, size: 19),
                  const SizedBox(width: 8),
                  Expanded(child: Text(text.note!, style: const TextStyle(fontSize: 12, height: 1.45))),
                ],
              ),
            ],
            if (prediction.isGeneralReaction)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  english
                    ? 'General equation: R represents a variable organic chain.'
                    : 'Equação geral: R representa uma cadeia orgânica variável.',
                  style: const TextStyle(fontSize: 12, color: Colors.amber),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AtomicStructureScreen extends StatefulWidget {
  const AtomicStructureScreen({super.key});

  @override
  State<AtomicStructureScreen> createState() => _AtomicStructureScreenState();
}

class _AtomicStructureScreenState extends State<AtomicStructureScreen> {
  ChemicalElement _selected = periodicElements.first;
  late final TextEditingController _massNumber;
  bool get _english => isEnglish(context);

  Future<void> _pickElement() async {
    final item = await ChemicalPicker.show(
      context,
      mode: ChemicalPickerMode.elementsOnly,
      title: _english ? 'Choose an element' : 'Escolher elemento',
    );
    if (!mounted || item == null) return;
    final element = periodicElements.firstWhere((e) => e.symbol == item.elementSymbol);
    setState(() {
      _selected = element;
      _massNumber.text = _suggestedMass(element).toString();
    });
  }

  int _suggestedMass(ChemicalElement element) {
    final rounded = element.atomicMass.round();
    return rounded < element.number ? element.number : rounded;
  }

  @override
  void initState() {
    super.initState();
    _massNumber = TextEditingController(text: _suggestedMass(_selected).toString());
  }

  @override
  void dispose() {
    _massNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parsedMass = int.tryParse(_massNumber.text.trim());
    final validMass = parsedMass != null && parsedMass >= _selected.number
        ? parsedMass
        : null;
    final neutrons = validMass == null ? 0 : validMass - _selected.number;

    return Scaffold(
      appBar: AppBar(title: Text(_english ? 'Atomic structure' : 'Estrutura atómica')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            _english
                ? 'Choose an element and enter the isotope mass number A. The app calculates Z, protons, neutrons and electrons.'
                : 'Escolhe um elemento e indica o número de massa A do isótopo. O app calcula Z, protões, neutrões e electrões.',
            style: const TextStyle(height: 1.45),
          ),
          const SizedBox(height: 14),
          _ElementPicker(selected: _selected, onTap: _pickElement),
          const SizedBox(height: 12),
          TextField(
            controller: _massNumber,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: _english ? 'Mass number (A)' : 'Número de massa (A)',
              helperText: _english ? 'Examples: C-12, Na-23, Cl-35' : 'Exemplos: C-12, Na-23, Cl-35',
              prefixIcon: Icon(Icons.numbers),
            ),
          ),
          const SizedBox(height: 16),
          if (validMass == null)
            Text(
              _english
                  ? 'Mass number A must be an integer equal to or greater than atomic number Z.'
                  : 'O número de massa A tem de ser um número inteiro igual ou superior ao número atómico Z.',
              style: const TextStyle(color: Colors.orange),
            ),
          if (validMass != null) ...[
            Wrap(
              spacing: 9,
              runSpacing: 9,
              children: [
                _NumberCard(label: _english ? 'Z • atomic number' : 'Z • número atómico', value: _selected.number.toString(), icon: Icons.bubble_chart),
                _NumberCard(label: _english ? 'A • mass number' : 'A • número de massa', value: validMass.toString(), icon: Icons.scale),
                _NumberCard(label: _english ? 'N • neutrons' : 'N • neutrões', value: neutrons.toString(), icon: Icons.grain),
                _NumberCard(label: _english ? 'Protons' : 'Protões', value: _selected.number.toString(), icon: Icons.add_circle_outline),
                _NumberCard(label: _english ? 'Electrons' : 'Electrões', value: _selected.number.toString(), icon: Icons.electric_bolt),
              ],
            ),
            const SizedBox(height: 15),
            _InfoPanel(
              title: _english ? 'How is it calculated?' : 'Como se calcula?',
              body: _english
                  ? 'Z is the number of protons. A is the sum of protons and neutrons. Therefore, N = A − Z = ' + validMass.toString() + ' − ' + _selected.number.toString() + ' = ' + neutrons.toString() + '. For a neutral atom, the number of electrons equals Z.'
                  : 'Z é o número de protões. A é a soma de protões e neutrões. Portanto, N = A − Z = ' + validMass.toString() + ' − ' + _selected.number.toString() + ' = ' + neutrons.toString() + '. Como estamos a considerar um átomo neutro, o número de electrões é igual a Z.',
            ),
          ],
          const SizedBox(height: 12),
          _InfoPanel(
            title: _english ? 'About isotopes' : 'Atenção aos isótopos',
            body: _english
                ? 'The same element can have several isotopes. They all have the same Z but can have different A and N values. The suggested starting value is only a representative isotope; check which isotope your exercise asks for.'
                : 'O mesmo elemento pode ter vários isótopos. Todos têm o mesmo Z, mas podem ter valores diferentes de A e N. O valor inicial sugerido é apenas um isótopo representativo; confirma o isótopo pedido no exercício.',
          ),
        ],
      ),
    );
  }
}

class ElectronDistributionScreen extends StatefulWidget {
  const ElectronDistributionScreen({super.key});

  @override
  State<ElectronDistributionScreen> createState() =>
      _ElectronDistributionScreenState();
}

class _ElectronDistributionScreenState
    extends State<ElectronDistributionScreen> {
  ChemicalElement _selected = periodicElements.first;
  bool get _english => isEnglish(context);

  Future<void> _pickElement() async {
    final item = await ChemicalPicker.show(
      context,
      mode: ChemicalPickerMode.elementsOnly,
      title: _english ? 'Choose an element' : 'Escolher elemento',
    );
    if (!mounted || item == null) return;
    final element = periodicElements.firstWhere((e) => e.symbol == item.elementSymbol);
    setState(() => _selected = element);
  }

  @override
  Widget build(BuildContext context) {
    final result =
        ElectronConfigurationCalculator.calculate(_selected.number);

    return Scaffold(
      appBar: AppBar(title: Text(_english ? 'Electron configuration' : 'Distribuição electrónica')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            _english
                ? 'Choose an element. ChemMaster uses its atomic number to calculate the electron configuration and shell distribution.'
                : 'Escolhe um elemento. O ChemMaster usa o número atómico para calcular a configuração electrónica e a distribuição por camadas.',
            style: const TextStyle(height: 1.45),
          ),
          const SizedBox(height: 14),
          _ElementPicker(selected: _selected, onTap: _pickElement),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selected.symbol + ' • ' + (_english ? (elementEnglishNames[_selected.symbol] ?? _selected.name) : _selected.name),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  Text((_english ? 'Atomic number Z = ' : 'Número atómico Z = ') + _selected.number.toString()),
                  const SizedBox(height: 14),
                  Text(_english ? 'Electron configuration' : 'Configuração electrónica', style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  SelectableText(
                    result.configuration,
                    style: const TextStyle(fontSize: 17, height: 1.65, color: _chemCyan),
                  ),
                  const Divider(height: 24),
                  Text(_english ? 'Shell distribution' : 'Distribuição por camadas', style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: result.shells.map((shell) => _ShellBadge(
                      label: shell.label,
                      electrons: shell.electrons,
                    )).toList(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    (_english ? 'Total electrons: ' : 'Total de electrões: ') + result.totalElectrons.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  if (result.isApproximate) ...[
                    const SizedBox(height: 10),
                    Text(
                      _english
                          ? 'Note: for this heavy element, the configuration is an Aufbau prediction and may differ from specialist ground-state reference tables.'
                          : 'Nota: para este elemento pesado, a configuração é uma previsão pela regra de preenchimento e pode diferir de tabelas especializadas do estado fundamental.',
                      style: TextStyle(color: Colors.orange, fontSize: 12, height: 1.4),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _InfoPanel(
            title: _english ? 'How does the app calculate it?' : 'Como o app chega à distribuição?',
            body: _english
                ? '1. In a neutral atom, the number of electrons equals Z. 2. Electrons fill lower-energy subshells first, following the Aufbau order. 3. Each subshell has a maximum capacity: s holds 2, p holds 6, d holds 10 and f holds 14 electrons. 4. Shell distribution adds the electrons that share the same principal quantum number.'
                : '1. Num átomo neutro, o número de electrões é igual a Z. 2. Os electrões ocupam primeiro os subníveis de menor energia, seguindo a ordem de preenchimento ensinada pela regra de Aufbau. 3. Cada subnível tem uma capacidade máxima: s comporta 2, p comporta 6, d comporta 10 e f comporta 14 electrões. 4. A distribuição por camadas soma os electrões que têm o mesmo número quântico principal.',
          ),
          const SizedBox(height: 8),
          _InfoPanel(
            title: _english ? 'Important' : 'Importante',
            body: _english
                ? 'The displayed configuration is for a neutral atom. Ions have different numbers of electrons. Some transition and heavy elements do not follow the simplified filling order; the app flags results that need confirmation.'
                : 'A configuração apresentada é para o átomo neutro. Iões têm outro número de electrões. Alguns elementos de transição e elementos pesados apresentam excepções à ordem simplificada; por isso, o app assinala os casos em que o resultado deve ser confirmado.',
          ),
        ],
      ),
    );
  }
}

class _ElementPicker extends StatelessWidget {
  final ChemicalElement selected;
  final VoidCallback onTap;

  const _ElementPicker({required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final english = isEnglish(context);
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: _chemBlue.withValues(alpha: .16),
          child: Text(
            selected.symbol,
            style: const TextStyle(color: _chemCyan, fontWeight: FontWeight.w900),
          ),
        ),
        title: Text(
          english ? (elementEnglishNames[selected.symbol] ?? selected.name) : selected.name,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        subtitle: Text(
          (english ? 'Atomic number Z = ' : 'Número atómico Z = ') + selected.number.toString(),
        ),
        trailing: const Icon(Icons.expand_more),
      ),
    );
  }
}

class _NumberCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _NumberCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 155,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: _chemCyan),
                const SizedBox(height: 8),
                Text(label, style: const TextStyle(fontSize: 11)),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ),
      );
}

class _ShellBadge extends StatelessWidget {
  final String label;
  final int electrons;

  const _ShellBadge({required this.label, required this.electrons});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: _chemBlue.withValues(alpha: .16),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _chemCyan.withValues(alpha: .35)),
        ),
        child: Text(
          '$label: $electrons',
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      );
}

class _InfoPanel extends StatelessWidget {
  final String title;
  final String body;

  const _InfoPanel({required this.title, required this.body});

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
              const SizedBox(height: 7),
              Text(body, style: const TextStyle(height: 1.45)),
            ],
          ),
        ),
      );
}
