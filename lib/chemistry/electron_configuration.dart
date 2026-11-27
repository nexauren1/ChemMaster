class ShellElectronCount {
  final int principalLevel;
  final int electrons;
  const ShellElectronCount(this.principalLevel, this.electrons);

  String get label =>
      const ['K', 'L', 'M', 'N', 'O', 'P', 'Q'][principalLevel - 1];
}

class ElectronConfigurationResult {
  final int atomicNumber;
  final String configuration;
  final List<ShellElectronCount> shells;
  final bool isApproximate;

  const ElectronConfigurationResult({
    required this.atomicNumber,
    required this.configuration,
    required this.shells,
    required this.isApproximate,
  });

  int get totalElectrons =>
      shells.fold(0, (total, shell) => total + shell.electrons);

  int get outerShellElectrons =>
      shells.isEmpty ? 0 : shells.last.electrons;

  String get shellDistribution => shells
      .map((shell) => shell.label + '=' + shell.electrons.toString())
      .join('  •  ');
}

class ElectronConfigurationCalculator {
  static const List<(String, int)> _order = [
    ('1s', 2),
    ('2s', 2),
    ('2p', 6),
    ('3s', 2),
    ('3p', 6),
    ('4s', 2),
    ('3d', 10),
    ('4p', 6),
    ('5s', 2),
    ('4d', 10),
    ('5p', 6),
    ('6s', 2),
    ('4f', 14),
    ('5d', 10),
    ('6p', 6),
    ('7s', 2),
    ('5f', 14),
    ('6d', 10),
    ('7p', 6),
  ];

  // Ground-state exceptions commonly taught at school level.
  static const Map<int, Map<String, int>> _exceptions = {
    24: {'3d': 5, '4s': 1}, // Cr
    29: {'3d': 10, '4s': 1}, // Cu
    41: {'4d': 4, '5s': 1}, // Nb
    42: {'4d': 5, '5s': 1}, // Mo
    44: {'4d': 7, '5s': 1}, // Ru
    45: {'4d': 8, '5s': 1}, // Rh
    46: {'4d': 10, '5s': 0}, // Pd
    47: {'4d': 10, '5s': 1}, // Ag
    57: {'4f': 0, '5d': 1}, // La
    58: {'4f': 1, '5d': 1}, // Ce
    64: {'4f': 7, '5d': 1}, // Gd
    71: {'4f': 14, '5d': 1}, // Lu
    78: {'5d': 9, '6s': 1}, // Pt
    79: {'5d': 10, '6s': 1}, // Au
    89: {'5f': 0, '6d': 1}, // Ac
    90: {'5f': 0, '6d': 2}, // Th
    91: {'5f': 2, '6d': 1}, // Pa
    92: {'5f': 3, '6d': 1}, // U
    93: {'5f': 4, '6d': 1}, // Np
    94: {'5f': 6, '6d': 0}, // Pu
  };

  static const Map<String, String> _superscript = {
    '0': '⁰',
    '1': '¹',
    '2': '²',
    '3': '³',
    '4': '⁴',
    '5': '⁵',
    '6': '⁶',
    '7': '⁷',
    '8': '⁸',
    '9': '⁹',
  };

  static String _power(int value) =>
      value.toString().split('').map((digit) => _superscript[digit]!).join();

  static ElectronConfigurationResult calculate(int atomicNumber) {
    if (atomicNumber < 1 || atomicNumber > 118) {
      throw RangeError.range(atomicNumber, 1, 118, 'atomicNumber');
    }

    final occupancy = <String, int>{};
    var remaining = atomicNumber;

    for (final orbital in _order) {
      if (remaining == 0) break;
      final filled = remaining < orbital.$2 ? remaining : orbital.$2;
      occupancy[orbital.$1] = filled;
      remaining -= filled;
    }

    final exception = _exceptions[atomicNumber];
    if (exception != null) {
      occupancy.addAll(exception);
    }

    final total = occupancy.values.fold<int>(0, (sum, value) => sum + value);
    if (total != atomicNumber) {
      throw StateError(
        'A distribuição calculada contém $total electrões em vez de $atomicNumber.',
      );
    }

    final configuration = _order.where((orbital) {
      return (occupancy[orbital.$1] ?? 0) > 0;
    }).map((orbital) {
      final orbitalName = orbital.$1;
      final electrons = occupancy[orbitalName]!;
      return orbitalName + _power(electrons);
    }).join('  ');

    final byShell = <int, int>{};
    for (final orbital in _order) {
      final electrons = occupancy[orbital.$1] ?? 0;
      if (electrons == 0) continue;
      final level = int.parse(orbital.$1.substring(0, 1));
      byShell[level] = (byShell[level] ?? 0) + electrons;
    }

    final shells = byShell.keys.toList()..sort();
    final shellCounts = shells
        .map((level) => ShellElectronCount(level, byShell[level]!))
        .toList();

    return ElectronConfigurationResult(
      atomicNumber: atomicNumber,
      configuration: configuration,
      shells: shellCounts,
      isApproximate:
          atomicNumber > 36 && !_exceptions.containsKey(atomicNumber),
    );
  }
}
