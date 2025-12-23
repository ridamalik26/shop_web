import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shop_web/controllers/banner_controller.dart';
import 'package:shop_web/views/side_bar_screen/widgets/banner_widget.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String id = '/BannersScreen';
  const UploadBannerScreen({super.key});

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final BannerController _bannerController = BannerController();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topLeft,
            child: const Text(
              "Banners",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
          ),
        ),

        const Divider(
          color: Colors.grey,
          thickness: 2,
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
                    : const Text('Category image'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () async{
                await _bannerController.uploadBanner(pickedImage: _image, context: context);
              },
                child: Text('Save'),),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: (){
              pickImage();
            },
            child: const Text("Pick Image"),
          ),
        ),
        Divider(color: Colors.grey,),
        BannerWidget(),
      ],
    );
  }
}
