import 'package:flutter/material.dart';

class BlueRoundedButton extends StatelessWidget {

  final Widget child ;
  final Color color;

  const BlueRoundedButton({Key? key, required this.color, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: (){},
          child: child,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(4),
          ),
      ),
    );
  }
}


