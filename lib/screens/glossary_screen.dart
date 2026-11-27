import 'package:flutter/material.dart';

import '../core/chem_language.dart';
import '../data/chemistry_glossary.dart';

class GlossaryScreen extends StatefulWidget {
  const GlossaryScreen({super.key});

  @override
  State<GlossaryScreen> createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen> {
  final TextEditingController _search = TextEditingController();
  String _query = '';
  GlossaryCategory? _category;

  bool get _english => isEnglish(context);

  String _fold(String value) => value
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

  List<ChemistryTerm> get _results {
    final query = _fold(_query.trim());
    return chemistryGlossary.where((term) {
      final matchesCategory = _category == null || term.category == _category;
      final matchesQuery = query.isEmpty ||
          _fold(term.termPt).contains(query) ||
          _fold(term.termEn).contains(query) ||
          _fold(term.definitionPt).contains(query) ||
          _fold(term.definitionEn).contains(query);
      return matchesCategory && matchesQuery;
    }).toList()
      ..sort((a, b) => (_english ? a.termEn : a.termPt)
          .compareTo(_english ? b.termEn : b.termPt));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    return Scaffold(
      appBar: AppBar(
        title: Text(_english ? 'Chemistry glossary' : 'Glossário de Química'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            _english
                ? 'A quick, clear explanation of the words used in Chemistry lessons and exercises.'
                : 'Explicações simples dos termos que aparecem nas aulas e nos exercícios de Química.',
            style: const TextStyle(height: 1.45),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _search,
            onChanged: (value) => setState(() => _query = value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: _english
                  ? 'Search a term or meaning'
                  : 'Pesquisar termo ou significado',
              suffixIcon: _query.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _search.clear();
                        setState(() => _query = '');
                      },
                      icon: const Icon(Icons.clear),
                    ),
            ),
          ),
          const SizedBox(height: 11),
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: ChoiceChip(
                    label: Text(_english ? 'All' : 'Todos'),
                    selected: _category == null,
                    onSelected: (_) => setState(() => _category = null),
                  ),
                ),
                ...GlossaryCategory.values.map(
                  (category) => Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: ChoiceChip(
                      label: Text(glossaryCategoryName(category, _english)),
                      selected: _category == category,
                      onSelected: (_) => setState(
                        () => _category = _category == category ? null : category,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 8, 2, 7),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _english ? 'TERMS' : 'TERMOS',
                    style: const TextStyle(
                      color: Color(0xFF16D9F5),
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Text(results.length.toString()),
              ],
            ),
          ),
          if (results.isEmpty)
            Padding(
              padding: const EdgeInsets.all(25),
              child: Center(
                child: Text(
                  _english
                      ? 'No glossary terms match this search.'
                      : 'Nenhum termo corresponde à pesquisa.',
                ),
              ),
            )
          else
            ...results.map(
              (term) => Card(
                child: ExpansionTile(
                  leading: const Icon(Icons.menu_book_outlined, color: Color(0xFF16D9F5)),
                  title: Text(
                    _english ? term.termEn : term.termPt,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  subtitle: Text(glossaryCategoryName(term.category, _english)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _english ? term.definitionEn : term.definitionPt,
                          style: const TextStyle(height: 1.45),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(14, 2, 14, 14),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary.withValues(alpha: .10),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _english ? 'EXAMPLE' : 'EXEMPLO',
                            style: const TextStyle(
                              color: Color(0xFF16D9F5),
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _english ? term.exampleEn : term.examplePt,
                            style: const TextStyle(height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 10),
          Text(
            _english
                ? 'Keep exploring: choose a term, read the explanation and connect it to the example.'
                : 'Continua a explorar: escolhe um termo, lê a explicação e relaciona-a com o exemplo.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .65),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
