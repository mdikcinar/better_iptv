import 'package:flutter/cupertino.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    this.icon = CupertinoIcons.play,
    this.message = 'No items found',
    this.iconSize = 64,
  });

  final IconData icon;
  final String message;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: CupertinoColors.systemGrey,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
