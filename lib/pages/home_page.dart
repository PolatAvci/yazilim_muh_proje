import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/product_items.dart';
import 'package:yazilim_muh_proje/components/product_card.dart';
import 'package:yazilim_muh_proje/pages/address_page.dart';
import 'package:yazilim_muh_proje/pages/cart_page.dart';
import 'package:yazilim_muh_proje/pages/favorite_page.dart';
import 'package:yazilim_muh_proje/pages/login_page.dart';
import 'package:yazilim_muh_proje/pages/orders_page.dart.dart';

class HomePage extends StatelessWidget {
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
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Kayıt ol / Giriş yap",
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
            ListTile(
              leading: Icon(Icons.shopping_bag, color: Colors.blue.shade400),
              title: Text('Siparişlerim'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.blue.shade400),
              title: Text('Adreslerim'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.blue.shade400),
              title: Text('Favorilerim'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritePage()),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              icon: Icon(Icons.shopping_cart, color: Colors.white),
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: 350,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ProductItems.items.length,
          itemBuilder: (context, i) {
            var item = ProductItems.items[i];
            return SizedBox(
              width: 200,
              child: ProductCard(
                id: item.id,
                category: item.category,
                details: item.category,
                imagePath: item.image,
                image: SizedBox(
                  height: 250,
                  child: Image.asset(item.image, fit: BoxFit.cover),
                ),
                name: item.name,
                price: item.price,
                onpressed: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
