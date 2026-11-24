# ChemMaster

ChemMaster is an Android-first chemistry learning app. The first release is designed around the Mozambique school context, with a data structure intended to expand to other curricula and countries later.

## Current prototype

- Portuguese-first interface and dark/light theme.
- Home, Academy, Tools, Progress and Settings navigation.
- Learning topic entry screens.
- Reaction-type reference cards, including neutralization.
- Equation balancing prototype for simple formulas without parentheses.
- Molar-mass calculator with an initial element-weight table.
- Initial periodic-table sample (not yet all 118 elements).
- Nomenclature examples for oxides, acids, bases and salts.
- Conceptual neutralization demonstration.

## Important scope notes

This is an early source-code foundation, not a finished or store-ready release. Progress persistence, a complete curriculum, all 118 elements, advanced formula parsing, robust equation balancing, full calculator suite, downloadable lesson packs, and real content synchronization still need implementation and tests. The virtual lab is an educational simulation, not a physical experiment.

Content for each class must be checked against current official Mozambican curriculum documents before being labelled as official curriculum coverage.

## Technical direction

- Flutter / Dart, Android first.
- Offline-first content model: local content is the source available to the learner; remote content packs can be added later.
- Keep chemistry rules and content data separate from UI as the project grows.
- Add automated tests for chemical calculations and content validation.

## Run locally

Install Flutter, then run:

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

To create an Android APK after validation:

```bash
flutter build apk --release
```

## References

- Flutter app architecture: https://docs.flutter.dev/app-architecture
- Flutter offline-first pattern: https://docs.flutter.dev/app-architecture/design-patterns/offline-first
- Mozambique, INDE, Chemistry programme for 8th and 9th classes (2022): https://biblioteca.eso.edu.mz/bitstreams/cfe0d670-dd99-443b-ba2a-093aaa054273/download
