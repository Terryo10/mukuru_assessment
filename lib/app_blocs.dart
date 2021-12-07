import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mukuru_app/bloc/currency_list_bloc/currencylist_bloc.dart';

class AppBlocs extends StatelessWidget {
  final Widget app;
    final FlutterSecureStorage storage;
  const AppBlocs({ Key? key, required this.app, required this.storage }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrencylistBloc(
            // jobsRepository: RepositoryProvider.of<JobsRepository>(context),
          ),
        ),
         ],
      child: app,
    );
  }
}