import 'dart:io';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:project/components/Product.dart';

class AddProductScreen extends StatefulWidget {
  final String? productId;
  final Map<String, dynamic>? product;

  const AddProductScreen({Key? key, this.productId, this.product})
      : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  File? _image; // Variable to store the selected image
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection("Products");

  // Controllers to handle form input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _usageController = TextEditingController();
  final TextEditingController _warningController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    // If editing, prefill the form with existing product data
    if (widget.product != null) {
      _nameController.text = widget.product!['name'] ?? '';
      _detailsController.text = widget.product!['details'] ?? '';
      _usageController.text = widget.product!['usage'] ?? '';
      _warningController.text = widget.product!['warning'] ?? '';
      _categoryController.text = widget.product!['category'] ?? '';
      _quantityController.text = widget.product!['quantity'] ?? '';
      _priceController.text = widget.product!['price'] ?? '';
      _imageUrl = widget.product!['imageUrl'];
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save form fields into Product object

      String? downloadUrl =
          _imageUrl; // Use existing image URL if no new image is selected

      if (_image != null) {
        // Upload new image to Firebase Storage if a new one is selected
        String fileName = path.basename(_image!.path);
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('products/$fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
        TaskSnapshot taskSnapshot = await uploadTask;
        downloadUrl = await taskSnapshot.ref.getDownloadURL();
      }

      try {
        // Prepare product data
        Product productData = Product(
          name: _nameController.text,
          details: _detailsController.text,
          usage: _usageController.text,
          warning: _warningController.text,
          category: _categoryController.text,
          quantity: _quantityController.text,
          price: _priceController.text,
          imageUrl: downloadUrl,
        );

        // If editing, update existing document
        if (widget.productId != null) {
          await _productCollection
              .doc(widget.productId)
              .update(productData.toJson());
        } else {
          // If adding new product, create a new document
          await _productCollection.add(productData.toJson());
        }

        // Show success message and navigate back
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product saved successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        print('Error saving product: $e');
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save product. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productId != null ? 'Edit Product' : 'Add Product'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          )
                        : _imageUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  _imageUrl!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              )
                            : Center(
                                child: Icon(Icons.add_photo_alternate,
                                    color: Colors.teal, size: 50),
                              ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  style:
                      TextStyle(color: Colors.black), // Set text color to black
                  decoration: InputDecoration(
                    labelText: "ชื่อยา",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: RequiredValidator(errorText: "กรุณาป้อนชื่อยา"),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _detailsController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "รายละเอียด",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator:
                      RequiredValidator(errorText: "กรุณาป้อนรายละเอียด"),
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _usageController,
                  style:
                      TextStyle(color: Colors.black), // Set text color to black
                  decoration: InputDecoration(
                    labelText: "วิธีใช้",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20), // Label text color to black
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: RequiredValidator(errorText: "กรุณาป้อนวิธีใช้"),
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _warningController,
                  style:
                      TextStyle(color: Colors.black), // Set text color to black
                  decoration: InputDecoration(
                    labelText: "คำเตือน",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20), // Label text color to black
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: RequiredValidator(errorText: "กรุณาป้อนคำเตือน"),
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _categoryController,
                  style:
                      TextStyle(color: Colors.black), // Set text color to black
                  decoration: InputDecoration(
                    labelText: "หมวดหมู่",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20), // Label text color to black
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: RequiredValidator(errorText: "กรุณาป้อนหมวดหมู่"),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _quantityController,
                  style:
                      TextStyle(color: Colors.black), // Set text color to black
                  decoration: InputDecoration(
                    labelText: "ปริมาณ",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20), // Label text color to black
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: RequiredValidator(errorText: "กรุณาป้อนปริมาณ"),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _priceController,
                  style:
                      TextStyle(color: Colors.black), // Set text color to black
                  decoration: InputDecoration(
                    labelText: "ราคา",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20), // Label text color to black
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: RequiredValidator(errorText: "กรุณาป้อนราคา"),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _saveProduct,
                  child: Text('บันทึกข้อมูล',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
