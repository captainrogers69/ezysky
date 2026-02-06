enum DioMethod { delete, getr, patch, post, put }

extension DioMethods on DioMethod {
  String? get value {
    switch (this) {
      case DioMethod.delete:
        return 'DELETE';
      case DioMethod.getr:
        return 'GET';
      case DioMethod.patch:
        return 'PATCH';
      case DioMethod.post:
        return 'POST';
      case DioMethod.put:
        return 'PUT';
      // default:
      //   return null;
    }
  }
}
