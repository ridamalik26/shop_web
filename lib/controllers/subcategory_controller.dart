import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global_variables.dart';
import '../models/subcategory.dart';
import '../services/manage_http_response.dart';

class SubCategoryController {

  /// 🔹 UPLOAD SUBCATEGORY
  Future<void> uploadSubCategory({
    required String categoryId,
    required String categoryName,
    required String subCategoryName,
    required dynamic pickedImage,
    required BuildContext context,
  }) async {
    try {
      // 🔹 Cloudinary instance
      final cloudinary = CloudinaryPublic(
        'dirmrl8zi',        // your cloud name
        'sub_category_preset',         // your upload preset
      );

      // 🔹 Upload image to Cloudinary
      CloudinaryResponse imageResponse =
      await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedImage,
          identifier: 'subcategoryImage',
          folder: 'subcategoryImages',
        ),
      );

      String image = imageResponse.secureUrl;

      // 🔹 Create model
      Subcategory subcategory = Subcategory(
        id: '',
        categoryId: categoryId,
        categoryName: categoryName,
        image: image,
        subCategoryName: subCategoryName,
      );

      // 🔹 Send to backend
      http.Response response = await http.post(
        Uri.parse('$uri/api/subcategories'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(subcategory.toMap()),
      );


      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Subcategory Uploaded')),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  /// 🔹 LOAD SUBCATEGORIES
  Future<List<Subcategory>> loadSubCategories() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/subcategories'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        return data
            .map((e) => Subcategory.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load subcategories');
      }
    } catch (e) {
      throw Exception('Error loading subcategories: $e');
    }
  }
}
