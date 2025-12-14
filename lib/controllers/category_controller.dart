import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:shop_web/services/manage_http_response.dart';
import '../global_variables.dart';
import '../models/category.dart';
import 'package:http/http.dart' as http;



class CategoryController{
  uploadCategory({required dynamic pickedImage,
    required dynamic pickedBanner,
    required String name,
    required context,
  }
  )
  async {
    try{
      final cloudinary = CloudinaryPublic("dirmrl8zi", 'category_preset');

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage, identifier: 'pickedImage', folder: 'categoryImages'),
      );
      String image = imageResponse.secureUrl;

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(
              pickedBanner, identifier: 'pickedBanner', folder: 'categoryImages' ));
      String banner =  bannerResponse.secureUrl;

      Category category = Category(
          id: " " ,
          name: name ,
          image: image ,
          banner: banner
      );
      http.Response response = await http.post(Uri.parse("$uri/api/categories"),
      body: category.toJson(),
      headers: <String, String>{
        "Content-Type": 'application/json; charset=UTF-8'
    },
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackBar(context, 'Uploaded Category');
      });
    }catch(e){
      print('Error uploading to cloudinary: $e');
    }
  }
}