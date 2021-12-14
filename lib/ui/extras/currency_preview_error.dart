import 'package:flutter/material.dart';


class CurrencyPreviewError extends StatelessWidget {
  final String message;
  const CurrencyPreviewError({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            // ignore: deprecated_member_use
            child: RaisedButton(
          color: const Color(0xfff7892b), // backgrounds
          textColor: Colors.white, // foreground
          onPressed: () {
          Navigator.pop(context);
          },
          child: const Text('Go Back'),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
