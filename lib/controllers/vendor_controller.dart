import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_web/models/vendor.dart';

import '../global_variables.dart';

class VendorController {
  Future<List<Vendor>> loadVendors() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/vendors'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Vendor> Vendors =
        data.map((vendor) => Vendor.fromMap(vendor)).toList();

        return Vendors;
      } else {
        throw Exception('Failed to load Vendors');
      }
    } catch (e) {
      throw Exception('Error loading Vendors: $e');
    }
  }
}