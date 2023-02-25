import 'package:chatgpt_flutter/constants/constants.dart';
import 'package:chatgpt_flutter/services/api_service.dart';
import 'package:chatgpt_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ModalDropDownWidget extends StatefulWidget {
  const ModalDropDownWidget({super.key});

  @override
  State<ModalDropDownWidget> createState() => _ModalDropDownWidgetState();
}

class _ModalDropDownWidgetState extends State<ModalDropDownWidget> {
  String currentModel = 'Model1';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService.getModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: TextWidget(
              label: snapshot.error.toString(),
            ));
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : DropdownButton(
                  dropdownColor: scaffoldBackgroundColor,
                  iconEnabledColor: Colors.white,
                  items: getModelsItem,
                  value: currentModel,
                  onChanged: (value) {
                    setState(() {
                      currentModel = value.toString();
                    });
                  });
        });
  }
}

/* 
  DropdownButton(
        dropdownColor: scaffoldBackgroundColor,
        iconEnabledColor: Colors.white,
        items: getModelsItem,
        value: currentModel,
        onChanged: (value) {
          setState(() {
            currentModel = value.toString();
          });
        });

*/
