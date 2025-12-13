
import 'package:flutter/cupertino.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:shop_web/views/side_bar_screen/buyers_screen.dart';
import 'package:shop_web/views/side_bar_screen/category_screen.dart';
import 'package:shop_web/views/side_bar_screen/orders_screen.dart';
import 'package:shop_web/views/side_bar_screen/products_screen.dart';
import 'package:shop_web/views/side_bar_screen/upload_banner_screen.dart';
import 'package:shop_web/views/side_bar_screen/vendors_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = VendorsScreen();

  screenSelector(item){
    switch(item.route){
      case BuyersScreen.id:
        setState(() {
          _selectedScreen = BuyersScreen();
        });
        break;
      case VendorsScreen.id:
        setState(() {
          _selectedScreen = VendorsScreen();
        });
        break;
      case OrdersScreen.id:
        setState(() {
          _selectedScreen = OrdersScreen();
        });
        break;
      case CategoryScreen.id:
        setState(() {
          _selectedScreen = CategoryScreen();
        });
        break;
      case UploadBannerScreen.id:
        setState(() {
          _selectedScreen = UploadBannerScreen();
        });
        break;
      case ProductsScreen.id:
        setState(() {
          _selectedScreen = ProductsScreen();
        });
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Management"),
      ),
        body: _selectedScreen ,
      sideBar: SideBar(
        header: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
          ),
          child: Center(child: Text('Multi Vendor Admin', style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold,
            letterSpacing: 1.7,
            color: Colors.white
          ),),
          ),
        ),
        items: const [
        AdminMenuItem(title: 'Vendors', route: VendorsScreen.id ,icon: CupertinoIcons.person_3),
        AdminMenuItem(title: 'Buyers', route: BuyersScreen.id ,icon: CupertinoIcons.person),
        AdminMenuItem(title: 'Orders', route: OrdersScreen.id ,icon: CupertinoIcons.shopping_cart),
        AdminMenuItem(title: 'Categories', route: CategoryScreen.id ,icon: Icons.category),
        AdminMenuItem(title: 'Upload Banners', route: UploadBannerScreen.id ,icon: CupertinoIcons.add),
        AdminMenuItem(title: 'Product', route: ProductsScreen.id ,icon: Icons.store),

      ], selectedRoute: '',
        onSelected: (item){
          screenSelector(item);
        },
      ),
    );
  }
}
