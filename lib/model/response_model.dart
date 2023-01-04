//----------------------------Custom Response Model--------------------------------//

class ResponseModel<T> {
  bool? isStatus;
  String? message;
  T? responseData;

  ResponseModel({this.isStatus, this.message, this.responseData});
}
