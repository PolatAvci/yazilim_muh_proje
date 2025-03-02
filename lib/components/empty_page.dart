import "package:flutter/material.dart";

class EmptyPage extends StatelessWidget {
  final String title1;
  final String title2;
  final String imagePath;
  final String description;
  final String? button;
  final Function? onPress;
  const EmptyPage({
    super.key,
    required this.button,
    required this.description,
    required this.imagePath,
    required this.onPress,
    required this.title1,
    required this.title2,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10.0,
              left: 15.0,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.clear),
                    color: const Color.fromRGBO(250, 0, 80, 1),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    title1,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 270,
                    height: 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(imagePath, width: 540, height: 300),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text(
                      title2,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      description,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),
                  button != null
                      ? ElevatedButton(
                        onPressed: () => onPress!(),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(250, 0, 80, 1),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                        ),
                        child: Text(
                          button ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
