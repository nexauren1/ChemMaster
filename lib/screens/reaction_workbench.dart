import 'package:flutter/material.dart';

import '../chemistry/equation_balancer.dart';
import '../chemistry/equation_analysis.dart';
import '../core/chem_language.dart';
import '../data/chemical_catalog.dart';
import '../widgets/chemical_picker.dart';

class EquationBuilderScreen extends StatefulWidget {
  const EquationBuilderScreen({super.key});

  @override
  State<EquationBuilderScreen> createState() => _EquationBuilderScreenState();
}

class _EquationBuilderScreenState extends State<EquationBuilderScreen> {
  final List<ChemicalSpecies> _reactants = [];
  final List<ChemicalSpecies> _products = [];
  String? _equation;
  String? _error;

  bool get _english => isEnglish(context);

  Future<void> _add(bool toReactants) async {
    final species = await ChemicalPicker.show(context);
    if (!mounted || species == null) return;
    setState(() {
      final destination = toReactants ? _reactants : _products;
      if (!destination.any((item) => formulaForReaction(item) == formulaForReaction(species))) {
        destination.add(species);
      }
      _equation = null;
      _error = null;
    });
  }

  void _remove(bool fromReactants, ChemicalSpecies item) {
    setState(() {
      (fromReactants ? _reactants : _products).remove(item);
      _equation = null;
      _error = null;
    });
  }

  void _loadExample() {
    ChemicalSpecies find(String formula) => chemicalCatalog.firstWhere(
      (item) => item.formula == formula,
    );
    setState(() {
      _reactants
        ..clear()
        ..addAll([find('CH4'), find('O2')]);
      _products
        ..clear()
        ..addAll([find('CO2'), find('H2O')]);
      _equation = null;
      _error = null;
    });
  }

  void _balance() {
    if (_reactants.isEmpty || _products.isEmpty) {
      setState(() {
        _equation = null;
        _error = _english
            ? 'Choose at least one reactant and one product.'
            : 'Escolhe pelo menos um reagente e um produto.';
      });
      return;
    }
    try {
      final left = _reactants.map(formulaForReaction).join(' + ');
      final right = _products.map(formulaForReaction).join(' + ');
      final result = EquationBalancer.balance('$left -> $right');
      setState(() {
        _equation = result;
        _error = null;
      });
    } catch (error) {
      setState(() {
        _equation = null;
        _error = error.toString().replaceFirst('FormatException: ', '');
      });
    }
  }


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(_english ? 'Equation builder' : 'Construtor de equações'),
      actions: [
        IconButton(
          tooltip: _english ? 'Load example' : 'Carregar exemplo',
          onPressed: _loadExample,
          icon: const Icon(Icons.lightbulb_outline),
        ),
      ],
    ),
    body: ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(
          _english
              ? 'Build both sides of the reaction by choosing substances from the catalog. No formula typing is needed.'
              : 'Constrói os dois lados da reacção escolhendo substâncias no catálogo. Não precisas de escrever fórmulas.',
          style: const TextStyle(fontSize: 15, height: 1.45),
        ),
        const SizedBox(height: 15),
        _SpeciesSection(
          title: _english ? 'Reactants' : 'Reagentes',
          subtitle: _english ? 'What goes into the reaction' : 'O que entra na reacção',
          items: _reactants,
          onAdd: () => _add(true),
          onRemove: (item) => _remove(true, item),
          english: _english,
          accent: const Color(0xFF3D8BFF),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 9),
          child: Center(child: Icon(Icons.south, size: 25)),
        ),
        _SpeciesSection(
          title: _english ? 'Products' : 'Produtos',
          subtitle: _english ? 'What is formed' : 'O que se forma',
          items: _products,
          onAdd: () => _add(false),
          onRemove: (item) => _remove(false, item),
          english: _english,
          accent: const Color(0xFF26BFA4),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: _balance,
          icon: const Icon(Icons.auto_awesome),
          label: Text(_english ? 'Balance equation' : 'Acertar e equilibrar'),
        ),
        if (_error != null) ...[
          const SizedBox(height: 12),
          _MessageCard(message: _error!, warning: true),
        ],
        if (_equation != null) ...[
          const SizedBox(height: 16),
          _BalancedEquationCard(
            equation: _equation!,
            counts: EquationAnalysis.analyze(_equation!),
            english: _english,
          ),
        ],
        const SizedBox(height: 14),
        _ExplanationCard(
          title: _english ? 'What does balancing do?' : 'O que significa equilibrar?',
          body: _english
              ? 'The number in front of a formula is a coefficient. It changes how many particles take part. The small number inside a formula is a subscript and tells how many atoms are in each particle. Balancing changes coefficients, never subscripts.'
              : 'O número colocado antes de uma fórmula é um coeficiente: indica quantas partículas participam. O número pequeno dentro da fórmula é um índice: indica quantos átomos existem em cada partícula. O balanceamento altera coeficientes, nunca os índices.',
        ),
      ],
    ),
  );
}

class _SpeciesSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<ChemicalSpecies> items;
  final VoidCallback onAdd;
  final ValueChanged<ChemicalSpecies> onRemove;
  final bool english;
  final Color accent;

  const _SpeciesSection({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.onAdd,
    required this.onRemove,
    required this.english,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(Icons.science_outlined, color: accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
                    Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              Text(items.length.toString(), style: TextStyle(color: accent, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 10),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Text(
                  english ? 'Nothing selected yet' : 'Ainda não escolheste nada',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .58)),
                ),
              ),
            )
          else
            ...items.map(
              (item) => Container(
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: ListTile(
                  dense: true,
                  leading: Text(
                    prettyFormula(formulaForReaction(item)),
                    style: TextStyle(fontWeight: FontWeight.w900, color: accent, fontSize: 16),
                  ),
                  title: Text(item.name(english), style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text(item.isElement
                      ? (english ? 'Element • reaction form' : 'Elemento • forma de reacção')
                      : categoryName(item.group, english)),
                  trailing: IconButton(
                    onPressed: () => onRemove(item),
                    icon: const Icon(Icons.close),
                    tooltip: english ? 'Remove' : 'Remover',
                  ),
                ),
              ),
            ),
          OutlinedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: Text(english ? 'Choose from catalog' : 'Escolher no catálogo'),
            style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(46)),
          ),
        ],
      ),
    ),
  );
}

class _BalancedEquationCard extends StatelessWidget {
  final String equation;
  final Map<String, AtomBalance> counts;
  final bool english;

  const _BalancedEquationCard({
    required this.equation,
    required this.counts,
    required this.english,
  });

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified, color: Color(0xFF26BFA4)),
              const SizedBox(width: 8),
              Text(
                english ? 'Balanced equation' : 'Equação equilibrada',
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SelectableText(
            prettyEquation(equation),
            style: const TextStyle(fontSize: 21, height: 1.5, fontWeight: FontWeight.w900),
          ),
          const Divider(height: 26),
          Text(
            english ? 'Atom conservation check' : 'Verificação da conservação dos átomos',
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          ...counts.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  SizedBox(width: 34, child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w900))),
                  Expanded(child: Text((english ? 'Reactants: ' : 'Reagentes: ') + entry.value.reactants.toString())),
                  Expanded(child: Text((english ? 'Products: ' : 'Produtos: ') + entry.value.products.toString())),
                  Icon(
                    entry.value.isBalanced ? Icons.check_circle : Icons.error,
                    color: entry.value.isBalanced ? Colors.green : Colors.red,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            english
                ? 'Every element has the same number of atoms on both sides. Matter is conserved.'
                : 'Cada elemento tem o mesmo número de átomos nos dois lados. A matéria é conservada.',
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    ),
  );
}

class _MessageCard extends StatelessWidget {
  final String message;
  final bool warning;

  const _MessageCard({required this.message, this.warning = false});

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(warning ? Icons.info_outline : Icons.check_circle_outline, color: warning ? Colors.orange : Colors.green),
          const SizedBox(width: 9),
          Expanded(child: Text(message, style: const TextStyle(height: 1.4))),
        ],
      ),
    ),
  );
}

class _ExplanationCard extends StatelessWidget {
  final String title;
  final String body;

  const _ExplanationCard({required this.title, required this.body});

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
