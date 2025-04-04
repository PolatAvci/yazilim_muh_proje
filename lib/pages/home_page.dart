import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Services/Product_service.dart';
import 'package:yazilim_muh_proje/Services/user_service.dart';
import 'package:yazilim_muh_proje/components/product_card.dart';
import 'package:yazilim_muh_proje/pages/address_page.dart';
import 'package:yazilim_muh_proje/pages/cart_page.dart';
import 'package:yazilim_muh_proje/pages/category_page.dart';
import 'package:yazilim_muh_proje/pages/favorite_page.dart';
import 'package:yazilim_muh_proje/pages/login_page.dart';
import 'package:yazilim_muh_proje/pages/orders_page.dart.dart';
import 'package:yazilim_muh_proje/pages/product_detail_page.dart';

class HomePage extends StatefulWidget {
  List<Map<String, dynamic>>? products = [];
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ProductService.getProducts().then((value) {
      setState(() {
        widget.products = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 130,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue.shade400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Menü',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    UserService.user?.id == null
                        ? SizedBox()
                        : Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "${UserService.user!.name} ${UserService.user!.surname}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.blue.shade400),
              title: Text('Ana Sayfa'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            UserService.user?.id != null
                ? SizedBox()
                : ListTile(
                  leading: Icon(Icons.login, color: Colors.blue.shade400),
                  title: Text("Giriş Yap / Kayıt ol"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    ).then((_) {
                      setState(() {});
                    });
                  },
                ),
            UserService.user?.id == null
                ? SizedBox()
                : ListTile(
                  leading: Icon(
                    Icons.shopping_bag,
                    color: Colors.blue.shade400,
                  ),
                  title: Text('Siparişlerim'),
                  onTap: () {
                    Navigator.pop(context); // Drawer kapatmak için
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrdersPage()),
                    ).then((_) {
                      setState(() {});
                    });
                    ;
                  },
                ),
            UserService.user?.id == null
                ? SizedBox()
                : ListTile(
                  leading: Icon(Icons.location_on, color: Colors.blue.shade400),
                  title: Text('Adreslerim'),
                  onTap: () {
                    Navigator.pop(context); // Drawer kapatmak için
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddressPage()),
                    ).then((_) {
                      setState(() {});
                    });
                    ;
                  },
                ),
            UserService.user?.id == null
                ? SizedBox()
                : ListTile(
                  leading: Icon(Icons.favorite, color: Colors.blue.shade400),
                  title: Text('Favorilerim'),
                  onTap: () {
                    Navigator.pop(context); // Drawer kapatmak için
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                FavoritePage(userId: UserService.user!.id),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                ),
            UserService.user?.id == null
                ? SizedBox()
                : ListTile(
                  leading: Icon(Icons.category, color: Colors.blue.shade400),
                  title: Text('Kategoriler'),
                  onTap: () {
                    Navigator.pop(context); // Drawer kapatmak için
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoryPage()),
                    ).then((_) {
                      setState(() {});
                    });
                    ;
                  },
                ),
            UserService.user?.id == null ? SizedBox() : Divider(),
            UserService.user?.id == null
                ? SizedBox()
                : ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.blue.shade400),
                  title: Text("Oturumu kapat"),
                  onTap: () {
                    setState(() {
                      UserService.logout();
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Başarıyla çıkış yapıldı"),
                        showCloseIcon: true,
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        leading: Builder(
          builder:
              (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu, color: Colors.white),
              ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopify, size: 30, color: Colors.white),
                  SizedBox(width: 8),
                  Text("TrakStore", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                if (UserService.user?.id != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  ).then((_) {
                    setState(() {});
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Lütfen giriş yapın!"),
                      showCloseIcon: true,
                    ),
                  );
                }
              },
              icon: Icon(Icons.shopping_cart, color: Colors.white),
            ),
          ],
        ),
      ),
      body:
          widget.products!.isEmpty
              ? Center(child: CircularProgressIndicator())
              : SizedBox(
                height: 350,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.products!.length,
                  itemBuilder: (context, i) {
                    var item = widget.products![i];
                    return SizedBox(
                      width: 200,
                      child: ProductCard(
                        id: item["id"],
                        category: "Sonra kaldırılacak",
                        details: item["details"],
                        imagePath: item["image"],
                        image: SizedBox(
                          height: 250,
                          child: Image.asset(
                            item["image"],
                            fit: BoxFit.contain,
                          ),
                        ),
                        name: item["name"],
                        price: item["price"],
                        onpressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ProductDetailPage(
                                    id: item["id"],
                                    name: item["name"],
                                    details: item["details"],
                                    imagePath: item["image"],
                                    price: item["price"],
                                  ),
                            ),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
