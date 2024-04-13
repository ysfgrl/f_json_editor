part of 'f_json_editor.dart';


class FJSONController{
  late final FJSONNotifier _state;

  void setState(FJSONNotifier state){
    _state = state;
  }
  void dispose() {
    _state.dispose();
  }
  void setJsonData(Map<String, dynamic> data) => _state.setData(data);
  Map<String, dynamic>  getJsonData() => _state.getData();

  late bool error = false;
  bool get getError {
    return error;
  }
  void setError(bool err) => _state.setError(err);
}

class FJSONNotifier extends ChangeNotifier{

  FJSONNotifier({
     required this.jsonData,
    FJSONController? controller
  }): _controller = controller ?? FJSONController(){
    _controller.setState(this);
  }
  late int id=1;
  final FJSONController _controller;
  late bool error = false;
  bool get getError {
    return error;
  }
  
  void setError(bool err){
    if(err == error){
      return;
    }
    error = err;
    notifyListeners();
  }
  Map<String, dynamic> jsonData;

  Map<String, dynamic> getData(){
    return jsonData;
  }

  void setData(Map<String, dynamic> data){
    id +=1;
    jsonData = data;
    notifyListeners();
  }
}