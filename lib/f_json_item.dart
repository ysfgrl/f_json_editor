part of 'f_json_editor.dart';

class FJSONItem extends StatefulWidget {
  const FJSONItem({
    super.key,
    required this.itemKey,
    required this.data,
    required this.paddingLeft,
    required this.valueChanged,
    required this.keyChanged,
    required this.menuEvent,
    required this.isEditable,
    this.isExpanded = false,
  });

  final dynamic itemKey;
  final ItemValueChanged valueChanged;
  final ItemKeyChanged keyChanged;
  final FJSONMenuEvent menuEvent;
  final dynamic data;
  final double paddingLeft;
  final bool isExpanded;
  final bool isEditable;

  @override
  State<FJSONItem> createState() => _FJSONItemState();
}

class _FJSONItemState extends State<FJSONItem> {
  late bool isExpanded = widget.isExpanded;

  void _toggleState() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void onValueChanged(dynamic key, dynamic val){
    widget.data[key] = val;
    setState(() {});
  }

  void onKeyChanged(String oldKey, String newKey){
      dynamic val = widget.data.remove(oldKey);
      widget.data[newKey] = val;
      setState(() { });
  }

  void subItemMenuEvent(FJSONMenuOptions selectedItem, dynamic key) {
    debugPrint("menuEvent:${selectedItem.toString()} => ${widget.itemKey} => $key");
    switch (selectedItem) {
      case FJSONMenuOptions.delete:
        if (widget.data is Map) {
          widget.data.remove(key);
        } else {
          widget.data.removeAt(key);
        }
        break;
      default:
        break;
    }
    setState(() {

    });
  }
  void menuEvent(FJSONMenuOptions selectedItem) {
    debugPrint("menuEvent:${selectedItem.toString()} => ${widget.itemKey}");
    switch(selectedItem){
      case FJSONMenuOptions.delete:
        widget.menuEvent(selectedItem, widget.itemKey);
        break;
      case FJSONMenuOptions.string:
        if(widget.data is Map){
          widget.data["newKey"] = "";
        }else if(widget.data is List){
          widget.data.add("");
        }
        break;
      case FJSONMenuOptions.number:
        if(widget.data is Map){
          widget.data["newKey"] = 0;
        }else if(widget.data is List){
          widget.data.add(0);
        }
        break;
      case FJSONMenuOptions.bool:
        if(widget.data is Map){
          widget.data["newKey"] = false;
        }else if(widget.data is List){
          widget.data.add(false);
        }
        break;
      case FJSONMenuOptions.map:
        if(widget.data is Map){
          widget.data["newKey"] = {};
        }else if(widget.data is List){
          widget.data.add({});
        }
      case FJSONMenuOptions.list:
        if(widget.data is Map){
          widget.data["newKey"] = [];
        }else if(widget.data is List){
          widget.data.add([]);
        }
        break;
      default:
        break;
    }
    setState(() {

    });
    // widget.parentState(() {
    //
    // },);
    // if (selectedItem == _OptionItems.delete) {
    //   if (widget.parentObject is Map) {
    //     widget.parentObject.remove(widget.keyName);
    //   } else {
    //     widget.parentObject.removeAt(widget.keyName);
    //   }
    //
    //   widget.setState(() {});
    // } else if (selectedItem == _OptionItems.map) {
    //   if (widget.data is Map) {
    //     widget.data[_newKey] = {};
    //   } else {
    //     widget.data.add({});
    //   }
    //
    //   setState(() {});
    // } else if (selectedItem == _OptionItems.list) {
    //   if (widget.data is Map) {
    //     widget.data[_newKey] = [];
    //   } else {
    //     widget.data.add([]);
    //   }
    //
    //   setState(() {});
    // } else {
    //   if (widget.data is Map) {
    //     widget.data[_newKey] = _newDataValue[selectedItem];
    //   } else {
    //     widget.data.add(_newDataValue[selectedItem]);
    //   }
    //
    //   setState(() {});
    // }

    // widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data is Map) {
      final childList = <Widget>[];
      Text  title = Text("${widget.itemKey}  {${widget.data.length}}");
      FJsonMenu menu = FJsonMenu.map(onSelected:menuEvent,);
      final List keys = widget.data.keys.toList();
      keys.sort();
      for (var key in keys) {
        childList.add(FJSONItem(
          key: Key(key),
          data: widget.data[key],
          itemKey: key,
          valueChanged: onValueChanged,
          keyChanged: onKeyChanged,
          paddingLeft: widget.paddingLeft + _space,
          isEditable: widget.isEditable,
          menuEvent: subItemMenuEvent,
        ));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: _rowPadding),
            child: Row(
              children: [
                const SizedBox(width: _expandIconWidth),
                menu,
                SizedBox(width: widget.paddingLeft),
                InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: _toggleState,
                  child: isExpanded ? _itemArrowDown : _itemArrowRight,
                ),
                const SizedBox(width: _expandIconWidth),
                widget.itemKey == "newKey"?
                FJsonField(
                  initialValue: widget.itemKey,
                  fieldChanged: (val) {
                    widget.keyChanged(widget.itemKey, val);
                    setState(() {});
                  },
                )
                    :
                title,
              ],
            ),
          ),
          if (isExpanded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: childList,
            ),
        ],
      );
    }if (widget.data is List) {
      final childList = <Widget>[];
      FJsonMenu menu = FJsonMenu.list(onSelected: menuEvent);
      Text title = Text("${widget.itemKey}  [${widget.data.length}]");
      for (int i = 0; i < widget.data.length; i++) {
        childList.add(FJSONItem(
          key: Key(i.toString()),
          itemKey: i,
          data: widget.data[i],
          valueChanged: onValueChanged,
          keyChanged: (oldKey, newKey) {

          },
          paddingLeft: widget.paddingLeft + _space,
          isEditable: widget.isEditable,
          menuEvent: subItemMenuEvent,
        ));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: _rowPadding),
            child: Row(
              children: [
                const SizedBox(width: _expandIconWidth),
                menu,
                SizedBox(width: widget.paddingLeft),
                InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: _toggleState,
                  child: isExpanded ? _itemArrowDown : _itemArrowRight,
                ),
                const SizedBox(width: _expandIconWidth),
                widget.itemKey == "newKey"?
                FJsonField(
                  initialValue: widget.itemKey,
                  fieldChanged: (val) {
                    widget.keyChanged(widget.itemKey, val);
                    setState(() {});
                  },
                )
                :
                title,
              ],
            ),
          ),
          if (isExpanded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: childList,
            ),
        ],
      );
    } else {
      return _fieldBuild(context);
    }
  }

  Widget _fieldBuild(BuildContext context){
    FJsonMenu menu = FJsonMenu.field(onSelected: menuEvent,);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _rowPadding),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: _expandIconWidth),
          menu,
          SizedBox(
            width: widget.paddingLeft + (_expandIconWidth * 2),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(widget.itemKey == "newKey")
                FJsonField(
                  initialValue: widget.itemKey,
                  fieldChanged: (val) {
                    widget.keyChanged(widget.itemKey, val);
                    setState(() {});
                  },
                )
              else
                Text('${widget.itemKey} :')
              ,
              _textSpacer,
              widget.isEditable ?
              FJsonField(
                initialValue: widget.data,
                fieldChanged: (val) {
                  widget.valueChanged(widget.itemKey, val);
                  setState(() {});
                },
              )
                  :
              Text(widget.data.toString()),
              _textSpacer,
            ],
          ),
        ],
      ),
    );
  }
}

