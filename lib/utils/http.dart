import 'package:dio/dio.dart' show Dio, DioError, InterceptorsWrapper, Response;
import 'loading.dart' show Loading;
Dio dio;

class Http {
  static Dio instance() {
    if (dio != null) {
      return dio;// 实例化dio
    }
    dio = new Dio();
    // 增加拦截器
    dio.interceptors.add(
      InterceptorsWrapper(
        // 接口请求前数据处理
        onRequest: (options) {
          Loading.before('正在加速中...');
          return options;
        },
        // 接口成功返回时处理
        onResponse: (Response resp) {
          // 这里为了让数据接口返回慢一点，增加了3秒的延时
          return Future.delayed(Duration(seconds: 3), () {
            Loading.complete();
            return resp;
          });
        },
        // 接口报错时处理
        onError: (DioError error) {
          return error;
        },
      ),
    );
    return dio;
  }

  /**
   * get接口请求
   * path: 接口地址
   */
  static get(path) {
    return instance().get(path);
  }
}