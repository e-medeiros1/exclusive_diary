import 'package:flutter/material.dart';

class LineSeparator extends StatelessWidget {
  const LineSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width * .38,
            color: Colors.grey[500],
          ),
          const SizedBox(height: 2),
          Text(
            '  ou  ',
            style: TextStyle(
                color: Colors.grey[500], letterSpacing: -.5, fontSize: 16),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width * .38,
            color: Colors.grey[500],
          ),
        ],
      ),
    );
  }
}
