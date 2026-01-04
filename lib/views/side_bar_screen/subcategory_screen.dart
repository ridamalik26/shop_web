import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shop_web/controllers/category_controller.dart';

import '../../models/category.dart';

class SubcategoryScreen extends StatefulWidget {
  static const String id = 'SubcategoryScreen';

  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String name;
  late Future<List<Category>> futureCategories;
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }
  dynamic _image;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Subcategories',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Divider(color: Colors.grey),
          ),
      
          FutureBuilder<List<Category>>(
            future: futureCategories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No Category'),
                );
              }
              else {
                return DropdownButton<Category>(
                  hint: const Text('Select Category'),
                  value: selectedCategory,
                  items: snapshot.data!.map((Category category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                    print(selectedCategory!.name);
                  },
                );
              }
            },
          ),
          Row(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: _image != null
                      ? Image.memory(_image)
                      : Text('SubCategory image'),
                ),
              ),
      
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  child: TextFormField(
                    onChanged: (value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return 'Please Enter subcategory Name';
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Subcategory Name',
                    ),
                  ),
                ),
              ),
      
              TextButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
      
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {

                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                pickImage();
              },
              child: Text('Pick Image'),
            ),
          ),

          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
