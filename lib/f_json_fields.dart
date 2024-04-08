
part of 'f_json_editor.dart';

class FJsonField extends StatefulWidget {
  final dynamic initialValue;
  final FieldValueChanged fieldChanged;
  const FJsonField({
    super.key,
    required this.initialValue,
    required this.fieldChanged,
  });
  @override
  State<FJsonField> createState() => _FJsonFieldState();
}
class _FJsonFieldState extends State<FJsonField> {
  late final _focusNode = FocusNode(skipTraversal: true);
  bool _isFocused = false;
  late dynamic _value;
  final InputDecoration _inputDecoration = const InputDecoration(
    constraints: BoxConstraints(minWidth: 80, maxWidth: 200),
    border: InputBorder.none,
    fillColor: Colors.transparent,
    filled: true,
    isDense: true,
    contentPadding:  EdgeInsets.all(3),
    focusedBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(width: 0.3),
    ),
  );


  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Widget _intBuild(BuildContext context){
    return TextFormField(
      initialValue: widget.initialValue.toString(),
      focusNode: _focusNode,
      onChanged: (value) => _value = value,
      autocorrect: false,
      cursorWidth: 1,
      cursorHeight: 12,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration:_inputDecoration,
      onEditingComplete: () {
        setState(() {
          _isFocused = false;
        });
        widget.fieldChanged(_value);
      },
    );
  }
  Widget _textBuild(BuildContext context){
    return TextFormField(
      initialValue: widget.initialValue.toString(),
      focusNode: _focusNode,
      onChanged: (value) => _value = value,
      autocorrect: false,
      cursorWidth: 1,
      cursorHeight: 12,
      decoration: _inputDecoration,
      onEditingComplete: () {
        setState(() {
          _isFocused = false;
        });
        widget.fieldChanged(_value);
      },
    );
  }
  Widget _boolBuild(BuildContext context){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 0.75,
          child: Checkbox(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            value: _value,
            onChanged: (value) {
                _value = value;
                setState(() {
                  _isFocused = false;
                });
                widget.fieldChanged(_value);
            },
          ),
        ),
        Text(_value.toString()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if(!_isFocused){
      return InkWell(
        onTap: () {
          setState(() {
            _isFocused = true;
          });
          _focusNode.requestFocus();
        },
        mouseCursor: MaterialStateMouseCursor.textable,
        child: _value.toString().isEmpty ? const SizedBox(width: 200, height: 18,):Text(_value.toString()),
      );
    }

    switch(widget.initialValue.runtimeType){
      case String:
        return _textBuild(context);
      case int:
        return _intBuild(context);
      case bool:
        return _boolBuild(context);
      default:
        return const Text("Error val");
    }
  }
}
