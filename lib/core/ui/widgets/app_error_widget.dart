import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final VoidCallback? refreshCallback;

  const AppErrorWidget({
    Key? key,
    required this.refreshCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        iconSize: 50,
        color: Theme.of(context).primaryColor,
        icon: const Icon(Icons.refresh),
        onPressed: refreshCallback,
      ),
    );
  }
}
