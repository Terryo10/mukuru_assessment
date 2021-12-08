import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mukuru_app/bloc/currency_list_bloc/currencylist_bloc.dart';

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
        // TODO: implement listener
      },
      child: Scaffold(
        body: BlocBuilder<CurrencylistBloc, CurrencylistState>(
          builder: (context, state) {
            if (state is CurrencylistLoadingState) {
              return loading();
            } else if (state is CurrencylistErrorState) {
              return buildError(message: state.message);
            }
            return const Center(
              child: Text('kkkkk'),
            );
          },
        ),
      ),
    );
  }

  Widget loading() {
    return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: new CircularProgressIndicator(
                        backgroundColor: Color(0xfff7892b),
                      ),
                    ),
                  ),
                  const Center(
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

  Widget buildError({String? message}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: RaisedButton(
          color: Color(0xfff7892b), // backgrounds
          textColor: Colors.white, // foreground
          onPressed: () {},
          child: Text('Retry'),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message ?? ' Failed to upload please try again ',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
