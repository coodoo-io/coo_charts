// You can shift the painted chart area by setting padding values.
class ChartPadding {
  const ChartPadding({
    this.top = 50, // Space for top labels
    this.right = 50,
    this.bottom = 50, // Space for bottom labels
    this.left = 50, // Space for left labels
  });

  final int left;
  final int right;
  final int top;
  final int bottom;
}
