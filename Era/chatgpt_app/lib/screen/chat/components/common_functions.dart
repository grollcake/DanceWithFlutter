String buildCostString(int tokens) {
  final String dollar = (tokens * 0.002 / 1000).toStringAsFixed(3);
  final String won = (tokens * 0.002 / 1000 * 1300).toInt().toString();
  return 'Token $tokens   |   \$ $dollar   |   $won원';
}