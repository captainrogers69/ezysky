class ApiStatus<T> {
  final String? error;
  final T? data;

  ApiStatus({this.error, this.data});

  factory ApiStatus.success({required T data}) => Success(data: data);

  factory ApiStatus.error({required String error}) => Error(error: error);

  factory ApiStatus.loading() => Loading();
}

class Success<T> extends ApiStatus<T> {
  Success({required T data}) : super(data: data);
}

class Error<T> extends ApiStatus<T> {
  Error({required String error}) : super(error: error);
}

class Loading<T> extends ApiStatus<T> {}
