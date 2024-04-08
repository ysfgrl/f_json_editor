
# f_json_editor

## Getting started

```yaml
dependencies:
    f_json_editor: ^1.0.0
```

## Usage

```dart
import 'package:f_json_editor/f_json_editor.dart';

FJSONEditor(
    title: Text("FJSON Example"),
    actionCallback: (actionKey, jsonData) async {
        if(actionKey == "copy"){
            await Clipboard.setData(
            ClipboardData(text: jsonEncode(jsonData)),
            );
        }
    },
    topActions: [
        FJSONAction(
            key: "copy",
            icon: Icon(Icons.copy, size: 20),
            label: "Copyy"
        ),
        FJSONAction(
            key: "save",
            icon: Icon(Icons.save, size: 20),
            label: "Save"
        )
    ],
    isEditable: true,
    jsonData: {
        "key1":"value1",
        "key2":2,
        "key3": {
            "key4": "value4",
            "key5": false,
            "key6": [
                "1",
                "iki"
                ]
        }
    },
)
```

# License

