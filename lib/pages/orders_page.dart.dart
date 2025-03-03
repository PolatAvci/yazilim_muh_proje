import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/order.dart';
import 'package:yazilim_muh_proje/pages/order_detail_page.dart';
import 'package:yazilim_muh_proje/pages/home_page.dart';

class OrdersPage extends StatefulWidget {
  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final List<Order> orders = [
    Order(
      id: '1',
      customerName: 'Ahmet Yılmaz',
      product: 'Laptop',
      price: 1500.0,
      status: 'Teslim Edildi',
    ),
    Order(
      id: '2',
      customerName: 'Meryem Kılıç',
      product: 'Telefon',
      price: 750.0,
      status: 'Hazırlanıyor',
    ),
    Order(
      id: '3',
      customerName: 'Ali Veli',
      product: 'Tablet',
      price: 1200.0,
      status: 'Kargo Bekliyor',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: Text(
          'Siparişlerim',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.blue.shade400,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text(
                  orders[index].product,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Müşteri: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${orders[index].customerName}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Durum: ${orders[index].status}',
                      style: TextStyle(
                        fontSize: 16,
                        color: _getStatusColor(orders[index].status),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$${orders[index].price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade600,
                      ),
                    ),
                    SizedBox(width: 30),

                    Icon(
                      _getStatusIcon(orders[index].status),
                      color: _getStatusColor(orders[index].status),
                      size: 20,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => OrderDetailPage(order: orders[index]),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Teslim Edildi':
        return Colors.green;
      case 'Hazırlanıyor':
        return Colors.orange;
      case 'Kargo Bekliyor':
        return Colors.blue.shade600;
      default:
        return Colors.black;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Teslim Edildi':
        return Icons.check_circle;
      case 'Hazırlanıyor':
        return Icons.build;
      case 'Kargo Bekliyor':
        return Icons.local_shipping;
      default:
        return Icons.error;
    }
  }
}
