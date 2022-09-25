import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:machine_learning_example_app/methodSelect.dart';
import 'package:path_provider/path_provider.dart';

class RegressionResultPage extends StatefulWidget {
  var mse;
  List inputName, outputName, w, b;
  var model;
  RegressionResultPage({
    Key? key,
    required this.inputName,
    required this.outputName,
    required this.mse,
    required this.w,
    required this.b,
    required this.model,
  }) : super(key: key);

  @override
  State<RegressionResultPage> createState() => _RegressionResultPageState();
}

class _RegressionResultPageState extends State<RegressionResultPage> {
  final inputKey = TextEditingController();
  var result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.red,
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          "Result Screen",
          style: TextStyle(
            color: Colors.brown,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.inputName[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: inputKey,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Değeri giriniz',
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: widget.inputName.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 10,
              shadowColor: Colors.black,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              result == null
                                  ? " Nan "
                                  : " Result : " + result.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.w[0].length,
                              itemBuilder: ((context, index) {
                                return Center(
                                  child: Text(
                                    " Weight$index :  ${widget.w[0][index]}  ",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                );
                              }),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              " Bias :  ${widget.b[0]}",
                              style: const TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      child: Text("Predict"),
                      onPressed: () {
                        debugPrint(inputKey.text.toString());
                        result = widget.model
                            .predict(inputKey.text, widget.w[0], widget.b[0])
                            .toString();

                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
