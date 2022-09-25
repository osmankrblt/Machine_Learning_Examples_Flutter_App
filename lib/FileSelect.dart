import "package:file_picker/file_picker.dart";
import 'package:flutter/material.dart';
import 'package:machine_learning_example_app/Machine%20Learning%20Formula/LinearRegression.dart';

import 'package:machine_learning_example_app/regressionResult.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:path_provider/path_provider.dart';

class SelectionsPage extends StatefulWidget {
  String selectedMethod;

  SelectionsPage({
    Key? key,
    required this.selectedMethod,
  }) : super(key: key);

  @override
  State<SelectionsPage> createState() => _SelectionsPageState();
}

class _SelectionsPageState extends State<SelectionsPage> {
  late List result;
  var method;
  late bool runnableButton;

  @override
  void initState() {
    super.initState();
    method = getMethod(widget.selectedMethod);
    runnableButton = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.red,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Machine Learning App",
            style: TextStyle(
              color: Colors.brown,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text("Select CSV"),
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result == null ||
                          result.files.single.path
                                  .toString()
                                  .endsWith(".csv") !=
                              true) {
                        setState(() {
                          runnableButton = false;
                        });
                        showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              title: const Text("Dosya yükleme hatası"),
                              content: const Text(
                                  "Dosya türü hatalı veya okunamadı"),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Tamam'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                      ;
                      if (result != null) {
                        method = getMethod(widget.selectedMethod);

                        String filePath = result.files.single.path!;
                        method.uploadFile(filePath);
                        runnableButton = true;
                        setState(() {});
                      }
                    },
                  ),
                  Visibility(
                    visible: runnableButton,
                    child: ElevatedButton(
                      child: const Text("Run"),
                      onPressed: () async {
                        result = method.run();
                        runnableButton = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RegressionResultPage(
                              inputName: result[0],
                              outputName: result[1],
                              mse: result[2],
                              w: [result[3]],
                              b: [result[4]],
                              model: method,
                            ),
                          ),
                        );
                        setState(
                          () {},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  static getMethod(sm) {
    switch (sm) {
      case "linearRegression":
        {
          return LinearRegression();
        }
    }
  }
}
