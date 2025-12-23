import 'package:flutter/material.dart';
import 'package:shop_web/controllers/banner_controller.dart';
import 'package:shop_web/models/banners.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {

  late Future<List<BannerModel>> futureBanners;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureBanners = BannerController().loadBanners();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: futureBanners, builder: (context, snapshot){
      if(snapshot.connectionState==ConnectionState.waiting){
        return CircularProgressIndicator();
      }else if(snapshot.hasError){
        return Center(child: Text("Error: ${snapshot.error}"),);
      }else if(!snapshot.hasData || snapshot.data!.isEmpty){
        return Center(child: Text('No Banners'),);
      }else {
        final banners = snapshot.data!;
        return Expanded(
          child: GridView.builder(
            itemCount: banners.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  banner.image,
                  height: 100,
                  width: 100,
                ),
              );
            },
          ),
        );
      }

    });
  }
}
