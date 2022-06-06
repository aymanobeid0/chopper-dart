import 'package:chopper/chopper.dart';
import 'package:chopper_example/data/mobile_data_interceptor.dart';
part 'post_api_service.chopper.dart';

// we will create the service with methods
// and create a method that returns object from the service

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response> getPosts();

  @Get(path: '/{id}')
  // it will pass the id param to the path
  Future<Response> getPost(@Path('id') int id);

  @Post()
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [_$PostApiService()],
      interceptors: [
        MobileDataInterceptor(),
        const HeadersInterceptor({'Cache-Control': 'no-cache'}),
        HttpLoggingInterceptor(),
      ],
      converter: const JsonConverter(),
    );
    return _$PostApiService(client);
  }
}
