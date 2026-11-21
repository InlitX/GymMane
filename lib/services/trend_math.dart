class TrendFit {
  const TrendFit(this.origin, this.intercept, this.slopePerDay);

  final DateTime origin;
  final double intercept;
  final double slopePerDay;

  double at(DateTime d) => intercept + slopePerDay * d.difference(origin).inMinutes / 1440;
}

TrendFit? fitTrend(List<({DateTime date, double value})> points) {
  if (points.length < 2) return null;
  final origin = points.first.date;
  final xs = [for (final p in points) p.date.difference(origin).inMinutes / 1440];
  final n = points.length;
  final mx = xs.reduce((a, b) => a + b) / n;
  final my = points.fold(0.0, (a, p) => a + p.value) / n;
  var sxy = 0.0, sxx = 0.0;
  for (var i = 0; i < n; i++) {
    sxy += (xs[i] - mx) * (points[i].value - my);
    sxx += (xs[i] - mx) * (xs[i] - mx);
  }
  if (sxx < 1e-9) return null;
  final slope = sxy / sxx;
  return TrendFit(origin, my - slope * mx, slope);
}

bool trendIsFlat(TrendFit fit, List<({DateTime date, double value})> points) {
  final span = points.last.date.difference(points.first.date).inMinutes / 1440;
  final mean = points.fold(0.0, (a, p) => a + p.value.abs()) / points.length;
  if (mean < 1e-9) return true;
  return (fit.slopePerDay * span).abs() < mean * 0.02;
}

List<({DateTime date, double value})> pointsSince(List<({DateTime date, double value})> all, int days, DateTime now) {
  if (days <= 0) return all;
  final today = DateTime(now.year, now.month, now.day);
  final from = DateTime(today.year, today.month, today.day - (days - 1));
  return [for (final p in all) if (!p.date.isBefore(from)) p];
}
