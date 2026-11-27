import 'package:flutter/material.dart';

import '../core/chem_language.dart';
import '../data/chemical_catalog.dart';

enum ChemicalPickerMode { all, elementsOnly, compoundsOnly }

class ChemicalPicker {
  static Future<ChemicalSpecies?> show(
    BuildContext context, {
    ChemicalPickerMode mode = ChemicalPickerMode.all,
    String? title,
  }) {
    return showModalBottomSheet<ChemicalSpecies>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (context) => ChemicalPickerSheet(mode: mode, title: title),
    );
  }
}

class ChemicalPickerSheet extends StatefulWidget {
  final ChemicalPickerMode mode;
  final String? title;

  const ChemicalPickerSheet({super.key, this.mode = ChemicalPickerMode.all, this.title});

  @override
  State<ChemicalPickerSheet> createState() => _ChemicalPickerSheetState();
}

class _ChemicalPickerSheetState extends State<ChemicalPickerSheet> {
  final TextEditingController _search = TextEditingController();
  bool _elements = true;
  ChemicalGroup? _group;
  String _query = '';

  static const List<ChemicalGroup> _elementGroups = [
    ChemicalGroup.alkaliMetals,
    ChemicalGroup.alkalineEarthMetals,
    ChemicalGroup.transitionMetals,
    ChemicalGroup.postTransitionMetals,
    ChemicalGroup.metalloids,
    ChemicalGroup.nonmetals,
    ChemicalGroup.halogens,
    ChemicalGroup.nobleGases,
    ChemicalGroup.lanthanides,
    ChemicalGroup.actinides,
  ];

  static const List<ChemicalGroup> _compoundGroups = [
    ChemicalGroup.water,
    ChemicalGroup.simpleSubstances,
    ChemicalGroup.oxides,
    ChemicalGroup.acids,
    ChemicalGroup.bases,
    ChemicalGroup.salts,
    ChemicalGroup.organicCompounds,
    ChemicalGroup.otherCompounds,
  ];

  bool get _english => isEnglish(context);
  bool get _canSwitch => widget.mode == ChemicalPickerMode.all;

  @override
  void initState() {
    super.initState();
    _elements = widget.mode != ChemicalPickerMode.compoundsOnly;
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<ChemicalSpecies> get _source {
    if (widget.mode == ChemicalPickerMode.elementsOnly) return periodicSpecies;
    if (widget.mode == ChemicalPickerMode.compoundsOnly) return commonSubstances;
    return _elements ? periodicSpecies : commonSubstances;
  }

  List<ChemicalSpecies> get _items {
    final query = _query.trim().toLowerCase();
    final filtered = _source.where((item) {
      final matchesGroup = _group == null || item.group == _group;
      final matchesSearch = query.isEmpty ||
          item.namePt.toLowerCase().contains(query) ||
          item.nameEn.toLowerCase().contains(query) ||
          item.formula.toLowerCase().contains(query) ||
          (item.atomicNumber?.toString() == query);
      return matchesGroup && matchesSearch;
    }).toList();
    filtered.sort((a, b) {
      if (_elements) return (a.atomicNumber ?? 0).compareTo(b.atomicNumber ?? 0);
      return a.name(_english).compareTo(b.name(_english));
    });
    return filtered;
  }

  List<ChemicalGroup> get _visibleGroups =>
      _elements ? _elementGroups : _compoundGroups;

  void _switchTab(bool elements) {
    setState(() {
      _elements = elements;
      _group = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Center(
            child: Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: .25),
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title ??
                        (_english ? 'Choose a chemical substance' : 'Escolher substância química'),
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  tooltip: _english ? 'Close' : 'Fechar',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: TextField(
              controller: _search,
              onChanged: (value) => setState(() {
                _query = value;
                _group = null;
              }),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: _english
                    ? 'Search by name, symbol or atomic number'
                    : 'Pesquisar por nome, símbolo ou número atómico',
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _search.clear();
                          setState(() {
                            _query = '';
                            _group = null;
                          });
                        },
                        icon: const Icon(Icons.clear),
                      ),
              ),
            ),
          ),
          if (_canSwitch) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SegmentedButton<bool>(
                segments: [
                  ButtonSegment(
                    value: true,
                    label: Text(_english ? 'Elements' : 'Elementos'),
                    icon: const Icon(Icons.scatter_plot_outlined),
                  ),
                  ButtonSegment(
                    value: false,
                    label: Text(_english ? 'Compounds' : 'Compostos'),
                    icon: const Icon(Icons.hub_outlined),
                  ),
                ],
                selected: {_elements},
                onSelectionChanged: (value) => _switchTab(value.first),
              ),
            ),
          ],
          const SizedBox(height: 10),
          SizedBox(
            height: 43,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: ChoiceChip(
                    label: Text(_english ? 'All' : 'Todos'),
                    selected: _group == null,
                    onSelected: (_) => setState(() => _group = null),
                  ),
                ),
                ..._visibleGroups.map(
                  (group) => Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: ChoiceChip(
                      label: Text(categoryName(group, _english)),
                      selected: _group == group,
                      onSelected: (_) => setState(
                        () => _group = _group == group ? null : group,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _elements
                        ? (_english ? 'Periodic table • atomic number order' : 'Tabela periódica • ordem do número atómico')
                        : (_english ? 'Common substances • grouped by family' : 'Substâncias comuns • organizadas por família'),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(_items.length.toString(), style: theme.textTheme.labelMedium),
              ],
            ),
          ),
          Expanded(
            child: _items.isEmpty
                ? Center(
                    child: Text(
                      _english ? 'No matching substances found.' : 'Não foram encontradas substâncias.',
                    ),
                  )
                : _elements
                    ? GridView.builder(
                        padding: const EdgeInsets.fromLTRB(14, 4, 14, 22),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: .96,
                        ),
                        itemCount: _items.length,
                        itemBuilder: (context, index) => _ElementCard(
                          item: _items[index],
                          english: _english,
                          onTap: () => Navigator.pop(context, _items[index]),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(14, 4, 14, 22),
                        itemCount: _items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 7),
                        itemBuilder: (context, index) => _CompoundCard(
                          item: _items[index],
                          english: _english,
                          onTap: () => Navigator.pop(context, _items[index]),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

class _ElementCard extends StatelessWidget {
  final ChemicalSpecies item;
  final bool english;
  final VoidCallback onTap;

  const _ElementCard({required this.item, required this.english, required this.onTap});

  Color _familyColor(BuildContext context) {
    switch (item.group) {
      case ChemicalGroup.alkaliMetals:
      case ChemicalGroup.alkalineEarthMetals:
        return const Color(0xFFFF9F43);
      case ChemicalGroup.transitionMetals:
      case ChemicalGroup.postTransitionMetals:
        return const Color(0xFF3D8BFF);
      case ChemicalGroup.metalloids:
        return const Color(0xFF26BFA4);
      case ChemicalGroup.nonmetals:
      case ChemicalGroup.halogens:
        return const Color(0xFF8F68E8);
      case ChemicalGroup.nobleGases:
        return const Color(0xFFDC6C9C);
      case ChemicalGroup.lanthanides:
      case ChemicalGroup.actinides:
        return const Color(0xFFBE83D7);
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = _familyColor(context);
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.atomicNumber.toString(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .65),
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: Text(
                  item.formula,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: accent),
                ),
              ),
              const SizedBox(height: 3),
              Center(
                child: Text(
                  item.name(english),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 2),
              Center(
                child: Text(
                  categoryName(item.group, english),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 8,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .68),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompoundCard extends StatelessWidget {
  final ChemicalSpecies item;
  final bool english;
  final VoidCallback onTap;

  const _CompoundCard({required this.item, required this.english, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.secondary;
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 66,
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(13),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              prettyFormula(item.formula),
              style: TextStyle(color: accent, fontSize: 17, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        title: Text(item.name(english), style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(item.detail(english)),
        trailing: const Icon(Icons.add_circle_outline),
      ),
    );
  }
}
