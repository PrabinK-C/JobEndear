//Create Graph

class Graph<T> {
  final Map<T, Set<T>> _edges = {};
  final Map<T, Map<T, double>> _weights = {};

  void addEdge(T source, T target, double weight) {
    _edges.putIfAbsent(source, () => {});
    _edges[source]?.add(target);
    _weights.putIfAbsent(source, () => {});
    _weights[source]?[target] = weight;
  }

  Map<T, double> pageRank({double dampingFactor = 0.85, int numIterations = 100}) {
    final N = _edges.length;
    var pr = Map<T, double>.fromIterable(_edges.keys, value: (_) => 1 / N);
    final incomingWeights = Map<T, double>.fromIterable(_edges.keys, value: (_) => 0.0);
    for (final source in _edges.keys) {
      for (final target in _edges[source]!) {
       
        incomingWeights[target] ??= 0.0;
        incomingWeights[target] = (incomingWeights[target] ?? 0) + (_weights[source]?[target] ?? 0);
        
      }
    }
    for (var i = 0; i < numIterations; i++) {
      final newPr = Map<T, double>.fromIterable(_edges.keys, value: (_) => (1 - dampingFactor) / N);
      for (final source in _edges.keys) {
        final sum = incomingWeights.keys
          .where((target) => _edges[target]!.contains(source))
          .map((target) => newPr[target]! * _weights[target]![source]! / incomingWeights[target]!)
          .fold(0.0, (a, b) => a + b);
        newPr[source] = newPr[source]! + dampingFactor * sum;
      }
      pr.clear();
      pr.addAll(newPr);
    }
       
    return pr;
  }

}

