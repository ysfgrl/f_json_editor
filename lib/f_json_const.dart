part of 'f_json_editor.dart';

const _space = 18.0;
const _expandIconWidth = 10.0;
const _rowPadding = 5.0;
const _textSpacer = SizedBox(width: 5);
const _itemArrowDown = SizedBox(
  width: 10,
  child: Icon(Icons.keyboard_arrow_down_outlined, size: 16),
);
const _itemArrowRight = SizedBox(
  width: 10,
  child: Icon(Icons.keyboard_arrow_right_outlined, size: 16),
);

enum FJSONMenuOptions { map, list, string, number, bool,  delete }
enum FJSONMenuTypes { map, list, field }



typedef FieldValueChanged = void Function(dynamic val);
typedef ItemValueChanged = void Function(dynamic key, dynamic val);
typedef ItemKeyChanged = void Function(String oldKey, String newKey);
typedef FJSONMenuEvent = void Function(FJSONMenuOptions options, dynamic key);
typedef FJSONActionCallback = void Function(String actionKey, Map<String, dynamic> jsonData);


class FJSONAction{
  final String key;
  final Icon icon;
  final String label;
  FJSONAction({
     required this.key,
     required this.icon,
     required this.label
  });
}