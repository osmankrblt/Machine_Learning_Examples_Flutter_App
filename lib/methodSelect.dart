import 'package:flutter/material.dart';

import 'FileSelect.dart';

class MethodSelectPage extends StatelessWidget {
  const MethodSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Method Select Screen",
          style: TextStyle(
            color: Colors.brown,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        SelectionsPage(selectedMethod: "linearRegression"),
                  ),
                );
              },
              child: const Text("Linear Regression"),
            ),
            Visibility(
              visible: false,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SelectionsPage(
                          selectedMethod: "multiLinearRegression"),
                    ),
                  );
                },
                child: const Text("Multi Regression"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
