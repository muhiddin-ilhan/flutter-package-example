import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  final String errorText;

  const ErrorTextWidget({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline,
              size: 16, color: Theme.of(context).colorScheme.error),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              errorText,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).colorScheme.error),
            ),
          )
        ],
      ),
    );
  }
}
