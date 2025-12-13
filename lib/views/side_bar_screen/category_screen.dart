import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = '\categoryScreen';

  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const Divider(color: Colors.grey),

        Row(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: Text('Category image'),
              ),
            ),

            const SizedBox(width: 12),

            SizedBox(
              width: 200,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter Category Name',
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
                onPressed: () {},
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        ElevatedButton(
          onPressed: () {
            setState(() {
              // later: image picker logic here
            });
          },
          child: const Text("Upload image"),
        ),

        const Divider(color: Colors.grey),
      ],
    );
  }
}
