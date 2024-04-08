library f_json_editor;


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'f_json_const.dart';
part 'f_json_item.dart';
part 'f_json_fields.dart';
part 'f_json_menu.dart';

class FJSONEditor extends StatefulWidget {
  const FJSONEditor({
    super.key,
    required this.jsonData,
    required this.actionCallback,
    this.isEditable = false,
    this.title = const Text("JSON Editor"),
    this.topActions = const [],
    this.showHeader = true
  });
  final Map<String, dynamic> jsonData;
  final Text title;
  final bool showHeader;
  final bool isEditable;
  final List<FJSONAction> topActions;
  final FJSONActionCallback actionCallback;
  @override
  State<FJSONEditor> createState() => _FJSONEditorState();
}

class _FJSONEditorState extends State<FJSONEditor> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
      ),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              visible: widget.showHeader,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: null),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      widget.title,
                      const Spacer(),
                      const SizedBox(width: 20),
                      ...widget.topActions.map((e) => InkWell(
                        onTap: () {
                          widget.actionCallback(e.key, widget.jsonData);
                        },
                        child: Tooltip(
                          message: e.label,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: e.icon,
                          ),
                        ),
                      ))
                      ,
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FJSONItem(
                    key: const Key("root"),
                    data: widget.jsonData,
                    itemKey: "root",
                    paddingLeft: _space,
                    isExpanded: true,
                    valueChanged: (key, val) {
                      // widget.jsonData[key] = val;
                      // setState(() {});
                    },
                    keyChanged: (oldKey, newKey) {

                    },
                    menuEvent: (options, key) {
                      setState(() {});
                    },
                    isEditable: widget.isEditable,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





