import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  const NoInternetWidget({Key? key,required this.message,required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            icon: Icon(Icons.wifi),
            onPressed: onPressed ,
            label: Text('Reload'),
          ),
        ],
      ),
    );
  }
}
