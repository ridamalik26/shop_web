import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shop_web/controllers/category_controller.dart';
import 'package:shop_web/controllers/subcategory_controller.dart';
import 'package:shop_web/models/category.dart';

class SubcategoryScreen extends StatefulWidget {
  static const String id = 'subCategoryScreen';

  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  final SubCategoryController subCategoryController = SubCategoryController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CategoryController _categoryController = CategoryController();
  late Future<List<Category>> futureCategories;
  late String name;

  Category? selectedCategory;
  String subCategoryName = '';
  dynamic _image;

  @override
  void initState() {
    super.initState();
    futureCategories = _categoryController.loadCategories();
  }

  /// Pick image
  Future<void> pickImage() async {
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
          /// TITLE
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Subcategories',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Divider(color: Colors.grey),

          /// CATEGORY DROPDOWN
          FutureBuilder<List<Category>>(
            future: futureCategories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No Category'));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<Category>(
                    isExpanded: true,
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
                    },
                  ),
                );
              }
            },
          ),

          const SizedBox(height: 20),

          /// IMAGE + TEXTFIELD + BUTTONS (SAME ROW)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE PICKER
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: _image != null
                        ? Image.memory(_image, fit: BoxFit.cover)
                        : const Text('Pick Image'),
                  ),
                ),
              ),

              const SizedBox(width: 20),

              /// SUBCATEGORY NAME
              SizedBox(
                width: 250,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter Subcategory Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter subcategory name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    subCategoryName = value;
                  },
                ),
              ),

              const SizedBox(width: 20),

              /// CANCEL BUTTON
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _image = null;
                      subCategoryName = '';
                      selectedCategory = null;
                    });
                  },
                  child: const Text('Cancel'),
                ),
              ),

              const SizedBox(width: 10),

              /// SAVE BUTTON
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      subCategoryController.uploadSubCategory(categoryId: selectedCategory!.id, categoryName: selectedCategory!.name, subCategoryName: name, pickedImage: _image, context: context);
                    };

                    if (selectedCategory == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a category'),
                        ),
                      );
                      return;
                    }

                    if (_image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please pick an image'),
                        ),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Subcategory is saved'),
                      ),
                    );
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
