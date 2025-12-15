import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:shop_web/models/banners.dart';
import 'package:http/http.dart' as http;
import 'package:shop_web/services/manage_http_response.dart';

import '../global_variables.dart';


class BannerController{
  uploadBanner({required dynamic pickedImage, required context}) async{
    try{
      final cloudinary = CloudinaryPublic("dirmrl8zi", 'category_preset');

      CloudinaryResponse imageResponse =  await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage, identifier: 'pickedImage', folder: 'banners' )
      );

      String image = imageResponse.secureUrl;

      BannerModel bannerModel = BannerModel(id: '', image: image);
      
      http.Response response = await http.post(Uri.parse("$uri/api/Banner"),
      body: bannerModel.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
          
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackBar(context, 'Banner Uploaded');
      });
    }catch(e) {
      print(e);
    }
  }
}