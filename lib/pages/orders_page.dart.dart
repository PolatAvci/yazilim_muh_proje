import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/order.dart';
import 'package:yazilim_muh_proje/Services/order_service.dart';
import 'package:yazilim_muh_proje/pages/order_detail_page.dart';

class OrdersPage extends StatefulWidget {
  final int userId;
  List<Order>? _orders = [];
  bool _isLoading = true;
  OrdersPage({super.key, required this.userId});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Future<void> _fetchOrders() async {
    try {
      List<Order>? orders = await OrderService.fetchOrders(widget.userId);
      setState(() {
        widget._orders = orders ?? [];
        widget._isLoading = false;
      });
    } catch (e) {
      // Hata durumunda kullanıcıya bilgi verebilirsiniz
      print('Error fetching orders: $e');
      setState(() {
        widget._isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
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
      body:
          widget._isLoading
              ? Center(child: CircularProgressIndicator())
              : widget._orders == null || widget._orders!.isEmpty
              ? Center(
                child: Text(
                  "Mevcut siparişiniz bulunmuyor",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              )
              : ListView.builder(
                itemCount: widget._orders!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => OrderDetailPage(
                                order: widget._orders![index],
                              ),
                        ),
                      );
                    },
                    child: Card(
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
                            widget._orders![index].name,
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
                                    "Sabit Ad",
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
                                'Durum: ${widget._orders![index].status}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: _getStatusColor(
                                    widget._orders![index].status,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${widget._orders![index].price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade600,
                                ),
                              ),
                              SizedBox(width: 30),
                              Icon(
                                _getStatusIcon(widget._orders![index].status),
                                color: _getStatusColor(
                                  widget._orders![index].status,
                                ),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
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
