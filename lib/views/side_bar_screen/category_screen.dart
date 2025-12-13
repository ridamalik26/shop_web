import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = '\categoryScreen';

  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Categories',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold
                ),
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Divider(
            color: Colors.grey
          ),
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
              child: Center(child: Text('Category image'),) ,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Enter Category Name'
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                    'cancel'
                )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {}, child: Text(
                    'Save',
                    style: TextStyle(
                    color: Colors.white
                  ),
                  ),
              ),
            )
          ],
        ),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: (){}, child: Text("Upload image"),
        ),
        Divider(color: Colors.grey,)
      ],
    );
  }
}
