library f_json_editor;


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

part 'f_json_const.dart';
part 'f_json_item.dart';
part 'f_json_fields.dart';
part 'f_json_menu.dart';
part 'f_json_controller.dart';

class FJSONEditor extends StatefulWidget {

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
  State createState() => _FJSONEditorState();

}


class _FJSONEditorState extends State<FJSONEditor>{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FJSONNotifier>(
      create: (context) => FJSONNotifier(
          jsonData: widget.jsonData,
          controller: widget.controller
      ),
      builder: (context, child) {
        return Card.outlined(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if(widget.showHeader)
                  Card.filled(
                    margin: EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          widget.title,
                          const Spacer(),
                          const SizedBox(width: 20),
                          ...widget.topActions.map((e) => InkWell(
                            onTap: () => widget.actionCallback!=null ? widget.actionCallback!(e.key, {}): null,
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
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Consumer<FJSONNotifier>(
        builder: (context, state, child) {
          return FJSONItem(
            key: Key("root${state.id.toString()}"),
            data: state.getData(),
            itemKey: "root",
            paddingLeft: _space,
            isExpanded: true,
            valueChanged: (key, val, toParent){
              if(widget.valueChanged != null) widget.valueChanged!(key, val);
            },
            keyChanged: (oldKey, newKey, toParent) {
              if(widget.keyChanged != null) widget.keyChanged!(oldKey, newKey);
            },
            menuEvent: (options, key, toParent) {
              if(widget.menuEvent != null) widget.menuEvent!(options, key);
            },
            isEditable: widget.isEditable,
          );
        },
      ),
    );
  }
}