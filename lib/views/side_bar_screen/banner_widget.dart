import 'package:flutter/cupertino.dart';
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
      }else{
        final banners = snapshot.data!;
        return SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: banners.length,
            itemBuilder: (context, index){
              final banner = banners[index];
              return Image.network(
                width: 40,
                height: 40,
                banner.image,
              );
            }
          ),
        );
      }
    });
  }
}
