# ChemMaster

**ChemMaster** is an offline-first Chemistry learning and problem-solving app built with Flutter. It starts with the Mozambique secondary-school curriculum (grades 7–12) and supports **Português** and **English**.

The product is designed around a practical learning problem: learners should not need to memorise exact formula spelling before they can explore a reaction. They choose substances from a visual catalogue, build a reaction, see the balanced equation and check why it is balanced.

## Product experience

### Chemistry Lab

The former generic tools list is organised as a Chemistry Lab, grouped by the task the learner wants to complete:

- **Reactions & equations:** discover known products from selected reactants; build both sides of an equation; balance it; explore reaction types.
- **Elements & atoms:** periodic table, atomic structure (Z, A, N, protons and electrons), and electron configuration.
- **Calculations & solutions:** molar mass, amount of substance, molar concentration, density, mass percentage and dilution.
- **Learn & practise:** nomenclature, curriculum lessons, worked examples and multiple-choice exercises with explanations.

### Shared visual chemical catalogue

The reusable chemical picker is a bottom-sheet catalogue used by reaction discovery, equation building, atomic tools and formula selection in calculators.

It separates:
- the 118 chemical elements, ordered by atomic number and filtered by periodic family;
- common chemical substances, organised into water, simple substances, oxides, acids, bases, salts, organic compounds and other compounds.

The picker supports name, symbol, formula and atomic-number search. Selection is possible without typing a chemical formula. The catalogue is local to the app and works offline.

When an element is selected for a reaction, the app uses common elemental forms where appropriate (for example H₂, O₂, N₂, Cl₂, P₄ and S₈). This is distinct from the atomic symbol shown in the periodic table.

### Reaction discovery and balancing

The offline reaction library contains more than fifty curated school-level rules and examples, covering:

- synthesis and decomposition;
- complete combustion of common hydrocarbons and glucose (as an overall equation);
- acid-base neutralisation;
- reactions of acids with carbonates and bicarbonates;
- precipitation and double displacement;
- common metal + acid and metal + oxygen examples;
- selected industrial and environmental examples, such as the Haber equilibrium;
- saponification as a general reaction.

The learner selects reactants, taps **Discover products**, and receives a known product set, the balanced equation, a reaction classification, step-by-step explanation and relevant caveats. Unknown combinations are not guessed.

The separate equation builder allows the learner to choose the reactants and products from the catalogue, then balance the equation. It explains that balancing changes coefficients, not formula subscripts. A shared equation-analysis service checks and displays atom counts on both sides.

### Atomic learning tools

- **Atomic structure:** selecting an element and entering an isotope mass number A calculates Z, N = A − Z, proton count and electron count for a neutral atom.
- **Electron configuration:** selecting an element calculates the orbital configuration and shell distribution. Common exceptions are included; approximate cases are identified.
- **Periodic table:** 118 elements with atomic number, mass data, category and bilingual element names.

### Languages and offline operation

Portuguese and English are available from Settings. The selected language is saved locally. Menus, the chemical catalogue, curriculum lesson text, quiz questions and explanations, reaction explanations and key tool screens support both languages.

Core tools and content are stored in the application; they do not require a live connection. Progress is saved on the device using SharedPreferences. There is no account or cloud synchronisation in this version.

## Curriculum

The curriculum structure follows the Mozambique INDE/MEC secondary Chemistry programme for the 1st cycle (7th, 8th and 9th grades) and 2nd cycle (10th, 11th and 12th grades).

Programme references:
- 1st cycle: https://ieda.gov.mz/site/wp-content/uploads/2020/10/ANEXO_X_PROGRAMA_QUIMICA_ES_I_CICLO_GM_11_02_26_assinado.pdf
- 2nd cycle: https://ieda.gov.mz/site/wp-content/uploads/2020/10/ANEXO_X_PROGRAMA_QUIMICA_ES_II_CICLO_GM_11_02_26_assinado.pdf

The app currently contains 50 introductory lessons and 22 multiple-choice questions across the six grades. This is a starting content set, not complete coverage of every learning objective, term or teaching-hour requirement in the official programme. Lesson material is newly written to support the curriculum topics; it is not a reproduction of the full official programme. Teachers should review and expand it before formal school adoption.

## Scientific scope and limitations

- **Product prediction is curated, not universal.** The app matches selected reactant sets against an offline reaction library. It does not claim that every pair of elements reacts or that every combination has one unique product.
- **Conditions matter.** Temperature, concentration, pressure, solvent, oxidation environment and catalysts can change the outcome. Some equations are labelled as simplified, reversible, industrial or condition-dependent.
- **Saponification is a general equation.** Oils and fats contain mixtures of triglycerides, so R represents a variable fatty-acid chain. The explanation is conceptual and is not a soap-making recipe. Sodium hydroxide and potassium hydroxide are corrosive.
- **Equation balancing is algebraic.** The solver handles ordinary molecular equations and uses rational arithmetic. It is not yet a specialised ionic/redox balancer for equations with explicit charges, electrons or acidic/basic half-reactions.
- **Formula parsing is intentionally limited.** It supports the elements, common case variations, spaces, Unicode subscripts and parentheses. Hydrates, explicit ionic charges and isotope notation in formulas are not yet supported.
- **Atomic mass is not isotope mass number.** Neutron calculations use an explicitly selected integer A. The periodic-table atomic mass is an average/representative value and must not be substituted blindly for a specified isotope.
- **Electron configurations need specialist review for some heavy elements.** The calculator applies the filling order and common exceptions; approximate cases are flagged rather than presented as certain.
- **Educational content requires subject-matter review.** The reaction bank, atomic data, exercises and lesson summaries should be reviewed by Chemistry teachers and cross-checked against reliable references before public educational use.
- **Safety first.** Chemical examples are learning content, not instructions to perform reactions. Hazardous reactions and substances include warnings where relevant. Practical work must follow school laboratory procedures and teacher supervision.

## Architecture

- lib/data/periodic_elements.dart — periodic element data.
- lib/data/chemical_catalog.dart — bilingual catalogue of elements and common substances.
- lib/widgets/chemical_picker.dart — reusable visual selection panel.
- lib/chemistry/formula_parser.dart — formula normalisation and atom counting.
- lib/chemistry/equation_balancer.dart — rational-arithmetic equation balancer.
- lib/chemistry/equation_analysis.dart — reusable atom-conservation report.
- lib/chemistry/reaction_predictor.dart — curated offline reaction library.
- lib/data/reaction_localization.dart — Portuguese/English reaction explanations.
- lib/data/curriculum_localization.dart and quiz_bank_localization.dart — bilingual teaching content.
- lib/screens/reaction_workbench.dart — visual equation builder.
- lib/screens/advanced_chemistry_screens.dart — product discovery and atomic tools.

## Development

Requires Flutter stable and the Dart SDK range declared in pubspec.yaml.

    flutter pub get
    flutter analyze
    flutter test
    flutter build apk --release

GitHub Actions runs analysis, tests and an Android release build for the main branch, feature branches and pull requests targeting main. A successful build uploads the signed APK as a workflow artifact.
