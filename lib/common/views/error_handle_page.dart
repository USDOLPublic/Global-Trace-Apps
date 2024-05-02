import 'package:flutter/material.dart';

class ErrorHandlePage {
  static Widget getErrorWidget(
      BuildContext context, FlutterErrorDetails error) {
    return Center(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Icon(
              Icons.error,
              color: Colors.orangeAccent,
              size: 60,
            ),
            const Text("Oops..."),
            const Text("Something went wrong!"),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  child: const Text("Go to home"),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
