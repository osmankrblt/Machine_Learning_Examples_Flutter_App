import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'dart:math';

class LinearRegression {
  List inputs = [];
  List targets = [];
  late List inputName = [];
  late List outputName = [];
  late double mse;
  List weights = [];
  double bias = 0;
  late double meanTarget = meanTargets(targets);

  predict(x, w, b) {
    double temp = 0;
    for (int i = 0; i < w.length; i++) {
      temp += w[i] * double.parse(x);
    }
    temp += b;

    return temp;
  }

  run() {
    calculate();
    return [inputName, outputName, mse, weights, bias];
  }

  uploadFile(filePath) {
    if (filePath.endsWith(".csv")) {
      preprocessCsv(filePath);
    } else {
      preprocessTxt(filePath);
    }
  }

  preprocessCsv(filePath) async {
    try {
      final csvFile = new File(filePath).openRead();
      List csv = await csvFile
          .transform(utf8.decoder)
          .transform(
            CsvToListConverter(),
          )
          .toList();

      for (int i = 0; i < csv[0].length - 1; i++) {
        inputName.add(csv[0][i].toString());

        List temp = getIndexColumns(csv, i);
        temp.removeAt(0);
        inputs.addAll([temp]);
      }

      List temp = getIndexColumns(csv, csv[0].length - 1);

      outputName.add(temp[0].toString());
      temp.removeAt(0);
      targets.addAll(temp);
    } on Exception catch (e) {
      // TODO
      print("error: " + e.toString());
    }
  }

  getIndexColumns(List liste, int index) {
    List temp = [];

    liste.forEach((element) {
      temp.add(element[index]);
    });

    return temp;
  }

  getIndex(List liste, int index) {
    return liste[index];
  }

  calculate() {
    for (int i = 0; i < inputs.length; i++) {
      print("İndex $i");
      calculateWight(inputs[i], targets);
      calculateBias(inputs[i], targets, weights[i]);
    }

    print("Weight " + weights.toString());
    print("Bias " + bias.toString());

    var y_pred = pred();

    print(y_pred);

    mse = MSE(y_pred);

    print("mse " + mse.toString());
  }

  pred() {
    List y_pred = [];

    for (int i = 0; i < inputs[0].length; i++) {
      double temp = 0;
      for (int k = 0; k < weights.length; k++) {
        temp += (getIndex(inputs[k], i)) * weights[k] + bias;
      }
      y_pred.add(temp);
    }

    return y_pred;
  }

  MSE(List y_pred) {
    late double mse;

    if (y_pred.length == targets.length) {
      double temp = 0.0;
      for (int i = 0; i < targets.length; i++) {
        temp += pow((targets[i] - y_pred[i]), 2);
      }
      mse = temp / targets.length;
    }

    return mse;
  }

  calculateWight(inputTemp, outputTemp) {
    var w = (sumMultiplyInputsTargets(inputTemp, outputTemp) -
            ((sumInputs(inputTemp) * sumTargets(outputTemp)) /
                inputTemp.length)) /
        (sumInputsPow(inputTemp) -
            (pow(sumInputs(inputTemp), 2) / inputTemp.length));
    weights.add(w);
  }

  calculateBias(inputTemp, outputTemp, w) {
    bias += meanTarget - ((sumInputs(inputTemp) / inputTemp.length) * w);
  }

  double meanTargets(List outputTemp) {
    return (sumTargets(outputTemp) / outputTemp.length);
  }

  sumInputs(inputTemp) {
    double temp = 0.0;
    inputTemp.forEach((element) {
      temp += element;
    });

    return temp;
  }

  sumInputsPow(inputTemp) {
    double temp = 0.0;
    inputTemp.forEach((element) {
      temp += pow(element, 2);
    });

    return temp;
  }

  sumTargets(outputTemp) {
    double temp = 0.0;
    outputTemp.forEach((element) {
      temp += element;
    });

    return temp;
  }

  sumMultiplyInputsTargets(inputTemp, outputTemp) {
    try {
      double temp = 0.0;
      for (int i = 0; i < outputTemp.length; i++) {
        temp += outputTemp[i] * inputTemp[i];
      }

      return temp;
    } catch (e) {
      print("Error : " + e.toString());
    }
  }

  preprocessTxt(filePath) {}
}
