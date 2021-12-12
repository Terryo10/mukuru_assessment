import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mukuru_app/bloc/currency_list_bloc/currencylist_bloc.dart';

class ErrorBuild extends StatelessWidget {
  final String message;
  const ErrorBuild({Key? key, required this.message}) : super(key: key);

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
            BlocProvider.of<CurrencylistBloc>(context).add(GetCurrencies());
          },
          child: const Text('Retry'),
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
