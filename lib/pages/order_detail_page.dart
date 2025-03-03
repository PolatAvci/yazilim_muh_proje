import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/order.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Siparişlerim',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade400,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCard('Sipariş ID:', order.id, Colors.black, FontWeight.bold),
            _buildCard(
              'Müşteri Adı:',
              order.customerName,
              Colors.black,
              FontWeight.bold,
            ),
            _buildCard('Ürün:', order.product, Colors.black, FontWeight.bold),
            _buildCard(
              'Fiyat:',
              '\$${order.price.toStringAsFixed(2)}',
              Colors.red,
              FontWeight.bold,
            ),
            _buildCard(
              'Durum:',
              order.status,
              _getStatusColor(order.status),
              FontWeight.bold,
            ),
            _buildStatusCard(order.status),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    String label,
    String value,
    Color textColor,
    FontWeight fontWeight,
  ) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: fontWeight,
                color: textColor,
              ),
            ),
          ],
        ),
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

  Widget _buildStatusCard(String status) {
    IconData icon;
    Color color;

    switch (status) {
      case 'Teslim Edildi':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'Hazırlanıyor':
        icon = Icons.build;
        color = Colors.orange;
        break;
      case 'Kargo Bekliyor':
        icon = Icons.local_shipping;
        color = Colors.blue.shade600;
        break;
      default:
        icon = Icons.error;
        color = Colors.red;
    }

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 8),
            Text(
              status,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
