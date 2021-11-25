import 'package:carouse_slider/models/products.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        title: 'CarouselSlider',
        debugShowCheckedModeBanner: false,
        home: ProductCardScreen(),
      ),
    );

class ProductCardScreen extends StatefulWidget {
  const ProductCardScreen({Key? key}) : super(key: key);

  @override
  _ProductCardScreenState createState() => _ProductCardScreenState();
}

class _ProductCardScreenState extends State<ProductCardScreen> {
  late CarouselController _controller;
  Map<String, String> _selectedProduct = {};

  @override
  void initState() {
    super.initState();
    _controller = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('슬라이드 카드'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey.shade800,
      floatingActionButton: _selectedProduct.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.arrow_forward_ios),
            )
          : null,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
              height: 450,
              aspectRatio: 10 / 9,
              enlargeCenterPage: true,
              viewportFraction: 0.7,
              pageSnapping: true,
              enableInfiniteScroll: false,
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                print('Current index: $index');
              }),
          items: products.asMap().entries.map(
            (item) {
              var idx = item.key;
              var product = item.value;
              return GestureDetector(
                onTap: () {
                  print('Tapped on $idx');

                  setState(() {
                    if (_selectedProduct == product) {
                      _selectedProduct = {};
                    } else {
                      _selectedProduct = product;
                      _controller.animateToPage(idx);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      product == _selectedProduct
                          ? BoxShadow(
                              color: Colors.blue.shade100,
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          : BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                    ],
                    border: Border.all(
                      color: product == _selectedProduct ? Colors.blue : Colors.transparent,
                      width: 5.0,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(product['image']!),
                        ),
                        SizedBox(height: 20),
                        Text(
                          product['title']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          product['description']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
