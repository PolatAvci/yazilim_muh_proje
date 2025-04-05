import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yazilim_muh_proje/Models/cart_items.dart';
import 'package:yazilim_muh_proje/Models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yazilim_muh_proje/Services/user_service.dart';

class PaymentPage extends StatefulWidget {
  final List<Product> items;
  final double shippingCost;
  const PaymentPage({
    super.key,
    required this.items,
    required this.shippingCost,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _currentStep = 0; // Track current step

  // Controllers for the inputs
  final cardController = MaskedTextController(mask: '0000 0000 0000 0000');
  final dateController = MaskedTextController(mask: '00/00');
  final cvvController = MaskedTextController(mask: '000');
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final addressController = TextEditingController();
  String? _selectedCargoCompany; // Store selected cargo company

  // List of cargo companies
  final List<String> cargoCompanies = [
    'Yurtiçi Kargo',
    'PTT Kargo',
    'Aras Kargo',
    'MNG Kargo',
    'Sürat Kargo',
  ];

  // Calculate total cart price
  double _calculateTotalPrice() {
    double total = 0.0;
    for (var item in widget.items) {
      total += item.price * item.quantity;
    }
    return total + widget.shippingCost;
  }

  // Step on continue validation
  bool _validateStep(int step) {
    switch (step) {
      case 0: // Kişisel Bilgiler
        if (nameController.text.isEmpty ||
            emailController.text.isEmpty ||
            phoneController.text.isEmpty) {
          _showErrorDialog("Lütfen tüm kişisel bilgilerinizi doldurun.");
          return false;
        }
        break;
      case 1: // Adres Bilgileri
        if (cityController.text.isEmpty ||
            districtController.text.isEmpty ||
            addressController.text.isEmpty) {
          _showErrorDialog("Lütfen adres bilgilerinizi doldurun.");
          return false;
        }
        break;
      case 2: // Kart Bilgileri
        if (cardController.text.isEmpty ||
            dateController.text.isEmpty ||
            cvvController.text.isEmpty) {
          _showErrorDialog("Lütfen kart bilgilerinizi doldurun.");
          return false;
        }
        break;
      case 3: // Kargo Firması
        if (_selectedCargoCompany == null) {
          _showErrorDialog("Lütfen bir kargo firması seçin.");
          return false;
        }
        break;
      default:
        break;
    }
    return true;
  }

  // Error Dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hata', style: GoogleFonts.poppins()),
          content: Text(message, style: GoogleFonts.poppins()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tamam', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  // Confirmation Dialog with total price
  void _showConfirmationDialog() {
    double totalPrice = _calculateTotalPrice();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Bilgilerinizi Onaylıyor Musunuz?',
            style: GoogleFonts.poppins(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Adınız: ${nameController.text}\nE-Posta: ${emailController.text}\nTelefon: ${phoneController.text}\nİl: ${cityController.text}\nİlçe: ${districtController.text}\nAdres: ${addressController.text}\nKargo Firması: $_selectedCargoCompany',
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 20),
              Text(
                'Sepet Toplamı: ₺${totalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('İptal', style: GoogleFonts.poppins()),
            ),
            TextButton(
              onPressed: () {
                // Send order data to the API
                _submitOrder();
              },
              child: Text('Onayla', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  // Submit order to the API
  Future<void> _submitOrder() async {
    for (int i = 0; i < widget.items.length; i++) {
      final orderData = {
        "userId": UserService.user!.id,
        "productId": widget.items[i].id,
        "status": "Kargo Bekliyor",
      };

      try {
        final response = await http.post(
          Uri.parse('https://localhost:7212/api/UserProduct'),
          headers: {"Content-Type": "application/json"},
          body: json.encode(orderData),
        );

        if (response.statusCode == 201) {
          CartItems.items.clear();
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Ödeme başarıyla tamamlandı!"),
              backgroundColor: Colors.green,
              showCloseIcon: true,
            ),
          );
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          _showErrorDialog("Sipariş gönderilemedi. Lütfen tekrar deneyin.");
          return;
        }
      } catch (e) {
        _showErrorDialog("Bir hata oluştu: $e");
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Ödemeyi Tamamla",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade400,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stepper(
          currentStep: _currentStep,
          onStepTapped: (step) {
            setState(() {
              _currentStep = step;
            });
          },
          onStepContinue: () {
            if (_validateStep(_currentStep)) {
              if (_currentStep < 3) {
                setState(() {
                  _currentStep++;
                });
              } else {
                // Show confirmation dialog after final step
                _showConfirmationDialog();
              }
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
              });
            }
          },
          stepIconBuilder: (stepIndex, stepState) {
            if (_currentStep == stepIndex) {
              return Icon(Icons.edit, color: Colors.blue.shade400);
            } else if (_currentStep > stepIndex) {
              return Icon(Icons.check_circle, color: Colors.green);
            }
            return null;
          },
          controlsBuilder: (context, details) {
            return Row(
              children: [
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.blue.shade400,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  child: Text("İleri", style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 15),
                TextButton(
                  onPressed: details.onStepCancel,
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    foregroundColor: WidgetStateProperty.all(
                      Colors.blue.shade400,
                    ),
                  ),
                  child: Text("İptal"),
                ),
              ],
            );
          },
          steps: [
            Step(
              title: Text('Kişisel Bilgiler', style: GoogleFonts.poppins()),
              stepStyle: StepStyle(color: Colors.transparent),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildTextField(
                      label: "Ad Soyad",
                      icon: Icons.person,
                      controller: nameController,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      label: "E-Posta",
                      icon: Icons.email,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      label: "Telefon Numarası",
                      icon: Icons.phone,
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
            ),
            Step(
              title: Text('Adres Bilgileri', style: GoogleFonts.poppins()),
              stepStyle: StepStyle(color: Colors.transparent),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildTextField(
                      label: "İl",
                      icon: Icons.location_city,
                      controller: cityController,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      label: "İlçe",
                      icon: Icons.map,
                      controller: districtController,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      label: "Adres",
                      icon: Icons.home,
                      controller: addressController,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            Step(
              title: Text('Kart Bilgileri', style: GoogleFonts.poppins()),
              stepStyle: StepStyle(color: Colors.transparent),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildTextField(
                      label: "Kart Numarası",
                      icon: Icons.credit_card,
                      controller: cardController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            label: "Son Kullanma",
                            icon: Icons.calendar_today,
                            controller: dateController,
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildTextField(
                            label: "CVV",
                            icon: Icons.lock,
                            controller: cvvController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Step(
              title: Text('Kargo Firması', style: GoogleFonts.poppins()),
              stepStyle: StepStyle(color: Colors.transparent),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Kargo Firması Seçin",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      value: _selectedCargoCompany,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCargoCompany = newValue;
                        });
                      },
                      items:
                          cargoCompanies.map((company) {
                            return DropdownMenuItem<String>(
                              value: company,
                              child: Text(company),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Şık TextField
  Widget _buildTextField({
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool obscureText = false,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: Colors.blue.shade400),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      obscureText: obscureText,
    );
  }
}
