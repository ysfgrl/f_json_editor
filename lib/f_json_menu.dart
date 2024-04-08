part of  'f_json_editor.dart';

class FJsonMenu extends StatelessWidget {
  const FJsonMenu.map({
    super.key,
    required this.onSelected,
    this.type = FJSONMenuTypes.map,
  } );
  const FJsonMenu.list({
    super.key,
    required this.onSelected,
    this.type = FJSONMenuTypes.list,
  } );
  const FJsonMenu.field({
    super.key,
    required this.onSelected,
    this.type = FJSONMenuTypes.field,
  } );
  final FJSONMenuTypes type;
  final void Function(FJSONMenuOptions) onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<FJSONMenuOptions>(
      tooltip: 'Edit',
      padding: EdgeInsets.zero,
      onSelected: onSelected,
      itemBuilder: (context) {
        switch(type){

          case FJSONMenuTypes.map:
            return _mapBuild(context);
          case FJSONMenuTypes.list:
            return _lisBuild(context);
          case FJSONMenuTypes.field:
            return _fieldBuild(context);
        }

      },
      child: const Icon(Icons.more_horiz, size: 16),
    );
  }

   List<PopupMenuEntry<FJSONMenuOptions>> _mapBuild(BuildContext context){
      return [

        const PopupMenuItem<FJSONMenuOptions>(
          height: 28,
          padding: EdgeInsets.only(left: 18, right: 18),
          value: FJSONMenuOptions.string,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.abc),
              SizedBox(width: 10),
              Text("String", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const PopupMenuItem<FJSONMenuOptions>(
          height: 28,
          padding: EdgeInsets.only(left: 18, right: 18),
          value: FJSONMenuOptions.number,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.onetwothree),
              SizedBox(width: 10),
              Text("Number", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const PopupMenuItem<FJSONMenuOptions>(
          height: 28,
          padding: EdgeInsets.only(left: 18, right: 18),
          value: FJSONMenuOptions.bool,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_rounded),
              SizedBox(width: 10),
              Text("Boolean", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const PopupMenuItem<FJSONMenuOptions>(
          height: 28,
          padding: EdgeInsets.only(left: 18, right: 18),
          value: FJSONMenuOptions.map,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.data_object),
              SizedBox(width: 10),
              Text("Object", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const PopupMenuItem<FJSONMenuOptions>(
          height: 28,
          padding: EdgeInsets.only(left: 18, right: 18),
          value: FJSONMenuOptions.list,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.abc),
              SizedBox(width: 10),
              Text("List", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const PopupMenuItem<FJSONMenuOptions>(
          value: FJSONMenuOptions.delete,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 5),
              Icon(Icons.delete),
              SizedBox(width: 10),
              Text("delete", style: TextStyle(fontSize: 14)),
            ],
          ),
        )
      ];
  }
   List<PopupMenuEntry<FJSONMenuOptions>> _lisBuild(BuildContext context){
      return [
        const PopupMenuItem<FJSONMenuOptions>(
          height: 28,
          padding: EdgeInsets.only(left: 18, right: 18),
          value: FJSONMenuOptions.string,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.abc),
              SizedBox(width: 10),
              Text("String", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const PopupMenuItem<FJSONMenuOptions>(
          height: 28,
          padding: EdgeInsets.only(left: 18, right: 18),
          value: FJSONMenuOptions.number,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.onetwothree),
              SizedBox(width: 10),
              Text("Number", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const PopupMenuItem<FJSONMenuOptions>(
          height: 28,
          padding: EdgeInsets.only(left: 18, right: 18),
          value: FJSONMenuOptions.bool,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_rounded),
              SizedBox(width: 10),
              Text("Boolean", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const PopupMenuItem<FJSONMenuOptions>(
          height: 28,
          padding: EdgeInsets.only(left: 18, right: 18),
          value: FJSONMenuOptions.map,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.data_object),
              SizedBox(width: 10),
              Text("Object", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const PopupMenuItem<FJSONMenuOptions>(
          height: 28,
          padding: EdgeInsets.only(left: 18, right: 18),
          value: FJSONMenuOptions.list,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.data_array),
              SizedBox(width: 10),
              Text("List", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const PopupMenuItem<FJSONMenuOptions>(
          value: FJSONMenuOptions.delete,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 5),
              Icon(Icons.delete),
              SizedBox(width: 10),
              Text("delete", style: TextStyle(fontSize: 14)),
            ],
          ),
        )
      ];
  }
    List<PopupMenuEntry<FJSONMenuOptions>> _fieldBuild(BuildContext context) {
      return [
        const PopupMenuItem<FJSONMenuOptions>(
          value: FJSONMenuOptions.delete,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 5),
              Icon(Icons.delete),
              SizedBox(width: 10),
              Text("delete", style: TextStyle(fontSize: 14)),
            ],
          ),
        )
      ];
    }
}