import 'package:flutter/material.dart';

import '../chemistry/electron_configuration.dart';
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
  final TextEditingController _input =
      TextEditingController(text: 'CO2 + H2O');
  ReactionPrediction? _prediction;
  String? _message;
  bool _searched = false;

  void _discover([String? example]) {
    if (example != null) _input.text = example;
    FocusScope.of(context).unfocus();
    try {
      final result = ReactionPredictor.predict(_input.text);
      setState(() {
        _prediction = result;
        _message = result == null
            ? 'Ainda não tenho uma regra química suficientemente segura para estes reagentes. O produto pode depender da concentração, temperatura, pressão, solvente ou de um catalisador.'
            : null;
        _searched = true;
      });
    } on FormatException catch (error) {
      setState(() {
        _prediction = null;
        _message = error.message.toString();
        _searched = true;
      });
    } catch (_) {
      setState(() {
        _prediction = null;
        _message = 'Não consegui interpretar esta entrada. Verifica as fórmulas e separa os reagentes com +.';
        _searched = true;
      });
    }
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Descobrir produtos')),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'Escreve apenas os reagentes. O ChemMaster procura uma reacção conhecida, prevê os produtos e ajusta a equação.',
              style: TextStyle(fontSize: 15, height: 1.45),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _input,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _discover(),
              decoration: const InputDecoration(
                labelText: 'Reagentes',
                hintText: 'Ex.: CO2 + H2O',
                helperText: 'Não precisas de escrever a seta nem os produtos.',
                prefixIcon: Icon(Icons.science_outlined),
              ),
            ),
            const SizedBox(height: 10),
            FilledButton.icon(
              onPressed: _discover,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Descobrir produtos'),
            ),
            const SizedBox(height: 12),
            const Text('Experimenta um exemplo', style: TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ActionChip(label: const Text('CO2 + H2O'), onPressed: () => _discover('CO2 + H2O')),
                ActionChip(label: const Text('HCl + KOH'), onPressed: () => _discover('HCl + KOH')),
                ActionChip(label: const Text('CaO + H2O'), onPressed: () => _discover('CaO + H2O')),
                ActionChip(label: const Text('CH4 + O2'), onPressed: () => _discover('CH4 + O2')),
                ActionChip(label: const Text('Sabão'), onPressed: () => _discover('Sabão')),
              ],
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
                      const Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.orange),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Ainda não é possível determinar o produto',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(_message!, style: const TextStyle(height: 1.45)),
                      const SizedBox(height: 10),
                      const Text(
                        'Uma lista de elementos, por si só, não define uma reacção única. É preciso conhecer os reagentes reais e, em alguns casos, as condições da reacção.',
                        style: TextStyle(fontSize: 12, color: Colors.amber, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 18),
            const _InfoPanel(
              title: 'O que esta ferramenta faz',
              body: 'Reconhece padrões de reacções químicas guardados no próprio app. Funciona offline. A base de reacções será ampliada com exemplos e explicações revistos.',
            ),
          ],
        ),
      );
}

class _PredictionResult extends StatelessWidget {
  final ReactionPrediction prediction;
  const _PredictionResult({required this.prediction});

  @override
  Widget build(BuildContext context) => Card(
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
                      prediction.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(prediction.reactionType, style: const TextStyle(color: _chemCyan)),
              const SizedBox(height: 15),
              const Text('Equação', style: TextStyle(fontWeight: FontWeight.w800)),
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
                  prediction.equation,
                  style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900, height: 1.5),
                ),
              ),
              const SizedBox(height: 12),
              Text(prediction.productSummary, style: const TextStyle(height: 1.45)),
              const SizedBox(height: 14),
              const Text('Explicação passo a passo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              ...prediction.explanations.asMap().entries.map(
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
              if (prediction.note != null) ...[
                const Divider(height: 22),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb_outline, color: Colors.orange, size: 19),
                    const SizedBox(width: 8),
                    Expanded(child: Text(prediction.note!, style: const TextStyle(fontSize: 12, height: 1.45))),
                  ],
                ),
              ],
              if (prediction.isGeneralReaction)
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Equação geral: R representa uma cadeia orgânica variável.',
                    style: TextStyle(fontSize: 12, color: Colors.amber),
                  ),
                ),
            ],
          ),
        ),
      );
}

class AtomicStructureScreen extends StatefulWidget {
  const AtomicStructureScreen({super.key});

  @override
  State<AtomicStructureScreen> createState() => _AtomicStructureScreenState();
}

class _AtomicStructureScreenState extends State<AtomicStructureScreen> {
  ChemicalElement _selected = periodicElements.first;
  late final TextEditingController _massNumber;

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
      appBar: AppBar(title: const Text('Estrutura atómica')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Escolhe um elemento e indica o número de massa A do isótopo. O app calcula Z, protões, neutrões e electrões.',
            style: TextStyle(height: 1.45),
          ),
          const SizedBox(height: 14),
          _ElementPicker(
            selected: _selected,
            onSelected: (element) => setState(() {
              _selected = element;
              _massNumber.text = _suggestedMass(element).toString();
            }),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _massNumber,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              labelText: 'Número de massa (A)',
              helperText: 'Exemplos: C-12, Na-23, Cl-35',
              prefixIcon: Icon(Icons.numbers),
            ),
          ),
          const SizedBox(height: 16),
          if (validMass == null)
            const Text(
              'O número de massa A tem de ser um número inteiro igual ou superior ao número atómico Z.',
              style: TextStyle(color: Colors.orange),
            ),
          if (validMass != null) ...[
            Wrap(
              spacing: 9,
              runSpacing: 9,
              children: [
                _NumberCard(label: 'Z • número atómico', value: _selected.number.toString(), icon: Icons.bubble_chart),
                _NumberCard(label: 'A • número de massa', value: validMass.toString(), icon: Icons.scale),
                _NumberCard(label: 'N • neutrões', value: neutrons.toString(), icon: Icons.grain),
                _NumberCard(label: 'Protões', value: _selected.number.toString(), icon: Icons.add_circle_outline),
                _NumberCard(label: 'Electrões', value: _selected.number.toString(), icon: Icons.electric_bolt),
              ],
            ),
            const SizedBox(height: 15),
            _InfoPanel(
              title: 'Como se calcula?',
              body: 'Z é o número de protões. A é a soma de protões e neutrões. Portanto, N = A − Z = ' + validMass.toString() + ' − ' + _selected.number.toString() + ' = ' + neutrons.toString() + '. Como estamos a considerar um átomo neutro, o número de electrões é igual a Z.',
            ),
          ],
          const SizedBox(height: 12),
          const _InfoPanel(
            title: 'Atenção aos isótopos',
            body: 'O mesmo elemento pode ter vários isótopos. Todos têm o mesmo Z, mas podem ter valores diferentes de A e N. O valor inicial sugerido é apenas um isótopo representativo; confirma o isótopo pedido no exercício.',
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

  @override
  Widget build(BuildContext context) {
    final result =
        ElectronConfigurationCalculator.calculate(_selected.number);

    return Scaffold(
      appBar: AppBar(title: const Text('Distribuição electrónica')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Escolhe um elemento. O ChemMaster usa o número atómico para calcular a configuração electrónica e a distribuição por camadas.',
            style: TextStyle(height: 1.45),
          ),
          const SizedBox(height: 14),
          _ElementPicker(
            selected: _selected,
            onSelected: (element) => setState(() => _selected = element),
          ),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selected.symbol + ' • ' + _selected.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  Text('Número atómico Z = ' + _selected.number.toString()),
                  const SizedBox(height: 14),
                  const Text('Configuração electrónica', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  SelectableText(
                    result.configuration,
                    style: const TextStyle(fontSize: 17, height: 1.65, color: _chemCyan),
                  ),
                  const Divider(height: 24),
                  const Text('Distribuição por camadas', style: TextStyle(fontWeight: FontWeight.w800)),
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
                    'Total de electrões: ' + result.totalElectrons.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  if (result.isApproximate) ...[
                    const SizedBox(height: 10),
                    const Text(
                      'Nota: para este elemento pesado, a configuração é uma previsão pela regra de preenchimento e pode diferir de tabelas especializadas do estado fundamental.',
                      style: TextStyle(color: Colors.orange, fontSize: 12, height: 1.4),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const _InfoPanel(
            title: 'Como o app chega à distribuição?',
            body: '1. Num átomo neutro, o número de electrões é igual a Z. 2. Os electrões ocupam primeiro os subníveis de menor energia, seguindo a ordem de preenchimento ensinada pela regra de Aufbau. 3. Cada subnível tem uma capacidade máxima: s comporta 2, p comporta 6, d comporta 10 e f comporta 14 electrões. 4. A distribuição por camadas soma os electrões que têm o mesmo número quântico principal.',
          ),
          const SizedBox(height: 8),
          const _InfoPanel(
            title: 'Importante',
            body: 'A configuração apresentada é para o átomo neutro. Iões têm outro número de electrões. Alguns elementos de transição e elementos pesados apresentam excepções à ordem simplificada; por isso, o app assinala os casos em que o resultado deve ser confirmado.',
          ),
        ],
      ),
    );
  }
}

class _ElementPicker extends StatelessWidget {
  final ChemicalElement selected;
  final ValueChanged<ChemicalElement> onSelected;

  const _ElementPicker({
    required this.selected,
    required this.onSelected,
  });

  String _label(ChemicalElement element) =>
      element.symbol + ' — ' + element.name + ' (Z=' + element.number.toString() + ')';

  @override
  Widget build(BuildContext context) => Autocomplete<ChemicalElement>(
        initialValue: TextEditingValue(text: _label(selected)),
        displayStringForOption: _label,
        optionsBuilder: (value) {
          final query = value.text.trim().toLowerCase();
          if (query.isEmpty) return periodicElements.take(20);
          return periodicElements.where((element) =>
              element.name.toLowerCase().contains(query) ||
              element.symbol.toLowerCase().contains(query) ||
              element.number.toString() == query).take(20);
        },
        onSelected: onSelected,
        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) =>
            TextField(
          controller: controller,
          focusNode: focusNode,
          onSubmitted: (_) => onFieldSubmitted(),
          decoration: const InputDecoration(
            labelText: 'Pesquisar elemento',
            hintText: 'Ex.: Carbono, C ou 6',
            prefixIcon: Icon(Icons.search),
          ),
        ),
      );
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
