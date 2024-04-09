
# f_json_editor

![FJSON Editor](https://raw.githubusercontent.com/ysfgrl/f_json_editor/master/screenshot/Screenshot1.png)
![FJSON Editor](https://raw.githubusercontent.com/ysfgrl/f_json_editor/master/screenshot/Screenshot2.png)
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

[@licence](https://github.com/ysfgrl/f_json_editor/blob/master/LICENSE)

# Reference

[@SanjaySodani](https://github.com/SanjaySodani)