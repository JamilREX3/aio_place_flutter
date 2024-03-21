import 'package:aio_place/models/user_model.dart';
import 'package:aio_place/views/global%20view.dart';
import 'package:aio_place/views/login_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import '../utils/api_request.dart';

class AuthController extends GetxController {
  auth()async{
    var token = await GetStorage().read('token');
    if(token==null){
      print('Please');
      Get.offAll( LoginView());
    }else{
      dio.Response? response =await ApiRequest().get(path: '/users/me');
      if(response.statusCode==200){
        UserModel userModel = UserModelReq.fromJson(response.data).userModel!;
        Get.offAll(GlobalView(userModel: userModel));
      }else{
        //GetStorage().remove('token');
        Get.offAll(LoginView());
      }
    }
  }
}