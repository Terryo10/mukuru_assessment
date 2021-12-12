import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mukuru_app/bloc/currency_list_bloc/currencylist_bloc.dart';
import 'package:mukuru_app/models/refined_currency_list_model.dart';
import 'package:mukuru_app/ui/splash_screen.dart';

class LogoutPopup extends StatefulWidget {
  final CurrencyRefinedModel modelWithRate;
  const LogoutPopup({Key? key, required this.modelWithRate}) : super(key: key);

  @override
  _LogoutPopupState createState() => _LogoutPopupState();
}

class _LogoutPopupState extends State<LogoutPopup> {
  final rateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter Warning rate for currency',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    autofocus: true,
                    maxLength: 15,
                    maxLengthEnforcement:
                        MaxLengthEnforcement.truncateAfterCompositionEnds,
                    controller: rateController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        labelText:
                            'Enter prefered Warning Rate for ${widget.modelWithRate.abr} currency',
                        hintText: 'eg. 14.5'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _alertButton(
                  color: const Color(0xfff7892b),
                  text: 'Submit',
                  onPressed: () {
                    if (rateController.text.isEmpty) {
                     
                    } else {
                      BlocProvider.of<CurrencylistBloc>(context).add(
                        AddCurrencyToUserList(
                          currencyRefinedModel: CurrencyRefinedModel(
                            abr: widget.modelWithRate.abr,
                            name: widget.modelWithRate.name,
                            warningRate: double.parse(rateController.text),
                          ),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplashScreen()),
                      );
                      ;
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _alertButton(
      {required String text, dynamic onPressed, required Color color}) {
    // ignore: deprecated_member_use
    return FlatButton(
      color: color,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: SizedBox(
        width: 80,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
