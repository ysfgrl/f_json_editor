part of 'f_json_editor.dart';

const _space = 18.0;
const _expandIconWidth = 10.0;
const _rowPadding = 5.0;
const _textSpacer = SizedBox(width: 5);
const _newKey = "new_key_added";
const _itemArrowDown = SizedBox(
  width: 10,
  child: Icon(CupertinoIcons.arrowtriangle_down_fill, size: 14),
);
const _itemArrowRight = SizedBox(
  width: 10,
  child: Icon(CupertinoIcons.arrowtriangle_right_fill, size: 14),
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