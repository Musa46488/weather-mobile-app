import '../helpers/helper_functions.dart';

class ConditionModel {
  final String text;
  final String icon;
  final int code;

  ConditionModel({required this.text, required this.icon, required this.code});

  factory ConditionModel.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return ConditionModel.empty();
    }
    return ConditionModel(
      text: HelperFunctions.toStrings(json['text']),
      icon: HelperFunctions.toStrings(json['icon']),
      code: HelperFunctions.toInt(json['code']),
    );
  }

  factory ConditionModel.empty() => ConditionModel(text: '', icon: '', code: 0);
}
