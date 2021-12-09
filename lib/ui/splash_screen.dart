import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mukuru_app/bloc/currency_list_bloc/currencylist_bloc.dart';
import 'package:mukuru_app/ui/add_currency.dart';
import 'package:mukuru_app/ui/extras/error_build.dart';
import 'package:mukuru_app/ui/global_currency_convetor.dart';
import 'package:mukuru_app/ui/my_currencies.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrencylistBloc, CurrencylistState>(
      listener: (context, state) {
        if (state is CurrencylistErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Oops Failed to get Currencies')));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Currency Exchange'),
          backgroundColor: Colors.amber[800],
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GlobalCurrencyConvetor()),
                    );
                  },
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Column(
                        children: const [
                          Icon(Icons.paid),
                          Text('Convert'),
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<CurrencylistBloc, CurrencylistState>(
          builder: (context, state) {
            if (state is CurrencylistLoadingState) {
              return loading();
            } else if (state is CurrencylistErrorState) {
              return ErrorBuild(message: state.message);
            } else if (state is CurrencylistLoadedState) {
              return const MyCurrencies();
            }
            return const ErrorBuild(message: 'Oops Somethings Happened');
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddCurrency()),
            );
          },
          backgroundColor: Colors.amber[800],
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget loading() {
    return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: Stack(
                children: const <Widget>[
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        backgroundColor: Color(0xfff7892b),
                      ),
                    ),
                  ),
                  Center(
                      child: Text(
                    'Loading ...',
                    style: TextStyle(color: Colors.black),
                  )),
                ],
              ),
            ),
          ],
        ));
  }
}
