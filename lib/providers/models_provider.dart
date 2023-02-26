import 'package:flutter/material.dart';
import 'package:chatgpt_flutter/models/models_model.dart';

class ModelsProvider with ChangeNotifier {
  List<ModelsModel> modelsList = [];
  String currentModel = 'text-davinci-003';

  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }
}
