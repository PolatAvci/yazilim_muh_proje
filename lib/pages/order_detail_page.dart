import 'package:flutter/material.dart';
import 'package:yazilim_muh_proje/Models/order.dart';
import 'package:yazilim_muh_proje/Services/comment_service.dart';
import 'package:yazilim_muh_proje/Services/user_service.dart';
import 'package:yazilim_muh_proje/components/button.dart';

class OrderDetailPage extends StatefulWidget {
  final Order order;

  const OrderDetailPage({super.key, required this.order});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final TextEditingController commentController = TextEditingController();

  int star = 0;

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
            _buildCard(
              'Müşteri Adı:',
              "${UserService.user!.name} ${UserService.user!.surname}",
              Colors.black,
              FontWeight.bold,
            ),
            _buildCard(
              'Ürün:',
              widget.order.name,
              Colors.black,
              FontWeight.bold,
            ),
            _buildCard(
              'Fiyat:',
              '\$${widget.order.price.toStringAsFixed(2)}',
              Colors.red,
              FontWeight.bold,
            ),
            _buildCard(
              'Durum:',
              widget.order.status,
              _getStatusColor(widget.order.status),
              FontWeight.bold,
            ),
            _buildStatusCard(widget.order.status),
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: "Yorum yap",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ), // Çerçeve rengi siyah
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ), // Normal durum için siyah çerçeve
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ), // Odaklandığında siyah çerçeve ve kalınlık artırıldı
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => IconButton(
                        onPressed: () {
                          setState(() {
                            star = index + 1;
                          });
                        },
                        icon:
                            star > index
                                ? Icon(Icons.star, color: Colors.blue.shade400)
                                : Icon(
                                  Icons.star_border,
                                  color: Colors.blue.shade400,
                                ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Button(
                      text: 'Kaydet',
                      buttonColor: Colors.blue.shade400,
                      fontSize: 15,
                      textColor: Colors.white,
                      onPressed: () async {
                        CommentService.addComment(
                          star,
                          commentController.text.trim(),
                          widget.order.id,
                        ).then((response) {
                          if (response.statusCode == 201) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Yorum eklendi"),
                                showCloseIcon: true,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Hata: Yorum eklenemedi"),
                                showCloseIcon: true,
                              ),
                            );
                          }
                        });

                        setState(() {
                          star = 0;
                        });
                        commentController.clear();
                      },
                      icon: Icons.add_circle_outline_sharp,
                    ),
                  ),
                ],
              ),
            ),
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
