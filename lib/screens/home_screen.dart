import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _formKey = GlobalKey<FormState>();
//Controllers
final nameController = TextEditingController();
final priceController = TextEditingController();
final quantityController = TextEditingController();

CollectionReference products =
    FirebaseFirestore.instance.collection('products');

enableDialog(context) {
  showModalBottomSheet(
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      clipBehavior: Clip.antiAlias,
      context: context,
      builder: (ctx) {
        return Material(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: nameController,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: priceController,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: "Price",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: quantityController,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: "Quantity",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    width: MediaQuery.of(context).size.width,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                width: 1,
                              ))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          products.add({
                            "name": nameController.text,
                            "price": priceController.text,
                            "quantity": quantityController.text
                          });
                          nameController.clear();
                          priceController.clear();
                          quantityController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Save"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
      });
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: OutlinedButton(
        style: OutlinedButton.styleFrom(
            elevation: 0.0,
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
            shape: const CircleBorder(
                side: BorderSide(
              width: 1,
            ))),
        onPressed: () {
          enableDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Firestore Level-up"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: StreamBuilder(
            stream: products.snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                // DocumentSnapshot documentSnapshot = snapshot.data!.docs;
                // print("here is data list: ${documentSnapshot["name"]}");
                return SizedBox(
                  height: 500,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs!.length,
                      itemBuilder: (ctx, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        return Card(
                          child: ListTile(
                              onLongPress: () {},
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                              ),
                              title: Text("${documentSnapshot["name"]}")),
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                print("Here is the error please !${snapshot.error}");
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
