library f_json_editor;


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

part 'f_json_const.dart';
part 'f_json_item.dart';
part 'f_json_fields.dart';
part 'f_json_menu.dart';
part 'f_json_controller.dart';

class FJSONEditor extends StatelessWidget {

  const FJSONEditor({
    super.key,
    required this.jsonData,
    this.actionCallback,
    this.keyChanged,
    this.valueChanged,
    this.menuEvent,
    this.controller,
    this.isEditable = false,
    this.title = const Text("JSON Editor"),
    this.topActions = const [],
    this.showHeader = true,

  });
  final FJSONController? controller;
  final Map<String, dynamic> jsonData;
  final Text title;
  final bool showHeader;
  final bool isEditable;
  final List<FJSONAction> topActions;
  final FJSONActionCallback? actionCallback;
  final ItemKeyChangedCallback? keyChanged;
  final ItemValueChangedCallback? valueChanged;
  final FJSONMenuEventCallback? menuEvent;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FJSONNotifier>(
      create: (context) => FJSONNotifier(
          jsonData: jsonData,
          controller: controller
      ),
      builder: (context, child) {
        var state = context.read<FJSONNotifier>();

        return Card.outlined(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if(showHeader)
                  Card.filled(
                    margin: EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          title,
                          const Spacer(),
                          const SizedBox(width: 20),
                          ...topActions.map((e) => InkWell(
                            onTap: () => actionCallback!=null ? actionCallback!(e.key, jsonData): null,
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
                  )
                ,
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FJSONItem(
                        key: const Key("root"),
                        data: state.jsonData,
                        itemKey: "root",
                        paddingLeft: _space,
                        isExpanded: true,
                        valueChanged: (key, val, toParent){
                          if(valueChanged != null) valueChanged!(key, val);
                        },
                        keyChanged: (oldKey, newKey, toParent) {
                          if(keyChanged != null) keyChanged!(oldKey, newKey);
                        },
                        menuEvent: (options, key, toParent) {
                          if(menuEvent != null) menuEvent!(options, key);
                        },
                        isEditable: isEditable,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}