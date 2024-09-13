import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/screens/Pharmacist_Side/AddProductScreen.dart';

class PharmacistProducts extends StatefulWidget {
  const PharmacistProducts({super.key});
  @override
  State<PharmacistProducts> createState() => _PharmacistProductsState();
}

class _PharmacistProductsState extends State<PharmacistProducts> {
  final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 80, left: 30, right: 30, bottom: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 66, 230, 148),
                  Color.fromARGB(255, 59, 178, 184)
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "ค้นหาในแอป PharmaDrop",
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      prefixIcon: Icon(Icons.search, size: 30),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddProductScreen();
                      }));
                    },
                    iconSize: 30,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _productCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error fetching products'));
                }

                final productDocs = snapshot.data?.docs ?? [];

                if (productDocs.isEmpty) {
                  return Center(child: Text('No products available.'));
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: productDocs.length,
                  itemBuilder: (context, index) {
                    var product =
                        productDocs[index].data() as Map<String, dynamic>;
                    return _buildProductCard(product, productDocs[index].id);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, String productId) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(product['imageUrl'] ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'] ?? 'No Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    product['details'] ?? 'No Details',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${product['price']} บาท',
                    style: TextStyle(fontSize: 16, color: Colors.teal),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.teal),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProductScreen(
                      productId: productId,
                      product: product,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _deleteProduct(productId);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteProduct(String productId) async {
    try {
      await _productCollection.doc(productId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product deleted successfully')),
      );
    } catch (e) {
      print('Error deleting product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product. Please try again.')),
      );
    }
  }
}
