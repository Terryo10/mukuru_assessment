import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mukuru_app/bloc/currency_list_bloc/currencylist_bloc.dart';
import 'package:mukuru_app/models/refined_currency_list_model.dart';
import 'package:mukuru_app/ui/extras/rate_popup.dart';

class AddCurrency extends StatefulWidget {
  const AddCurrency({Key? key}) : super(key: key);

  @override
  _AddCurrencyState createState() => _AddCurrencyState();
}

class _AddCurrencyState extends State<AddCurrency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Currency'),
        backgroundColor: Colors.amber[800],
      ),
      body: BlocListener<CurrencylistBloc, CurrencylistState>(
        listener: (context, state) {},
        child: BlocBuilder<CurrencylistBloc, CurrencylistState>(
          builder: (context, state) {
            if (state is CurrencylistLoadedState) {
              return currencyList(data: state.data);
            }
            return const Center(
              child: Text('add curency screen'),
            );
          },
        ),
      ),
    );
  }

  Widget currencyList({required data}) {
    List<CurrencyRefinedModel> listToBeUsed = [];
    data.forEach(
        (k, v) => listToBeUsed.add(CurrencyRefinedModel(abr: k, name: v)));
    return ListView.builder(
        itemCount: listToBeUsed.length,
        itemBuilder: (BuildContext context, int index) {
          return currencyCard(listToBeUsed[index]);
        });
  }

  void _showDialog(CurrencyRefinedModel model) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return LogoutPopup(
            modelWithRate: model,
          );
        });
  }

  Widget currencyCard(CurrencyRefinedModel data) {
    return GestureDetector(
      onTap: () {
        //add currency to local storage
        _showDialog(data);
      },
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Card(
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.5),
            side: const BorderSide(
              width: 0.5,
              color: Color(0xfff7892b),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'CenturyGothicBold',
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                  const Expanded(flex: 1, child: Icon(Icons.add)),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
