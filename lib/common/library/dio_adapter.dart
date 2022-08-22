import 'package:dio/dio.dart';
import 'interface.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    Uri uri = await request.uri();

    var options = Options(headers: request.header);
    Response? response;
    var error;

    var url = uri.toString();
    print(url);
    print(options.headers);

    try {
      switch (request.httpMethod()) {
        case HttpMethod.GET:
          response = await Dio().get(url, options: options);
          break;
        case HttpMethod.POST:
          response = await Dio().post(
              url, data: request.params, options: options);
          break;
        case HttpMethod.DELETE:
          response = await Dio().delete(
              url, data: request.params, options: options);
          break;
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    } catch(e) {
      error = e;
    }

    if (error != null) {
      throw error;
    }

    return buildRes(response, request);
  }

  ///构建HiNetResponse
  Future<HiNetResponse<T>> buildRes<T>(Response? response,
      BaseRequest request) {
    return Future.value(HiNetResponse(
      //?.防止response为空
        data: response?.data,
        request: request,
        statusCode: response?.statusCode ?? 0,
        extra: response));
  }
}