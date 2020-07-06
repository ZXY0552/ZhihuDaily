class NetResponse<T> {
  T data;
  String errorMessage;
  bool isSuccess;

  NetResponse(this.isSuccess, {this.data, this.errorMessage});
}
