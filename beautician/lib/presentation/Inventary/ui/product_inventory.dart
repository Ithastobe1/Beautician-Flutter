import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/repositories/API_Calling/api_calling.dart';
import '../model/Inventory_model.dart/transferDetails.dart';

class ProductInventory extends StatefulWidget {
  final String tranferid;
  const ProductInventory({super.key, required this.tranferid});

  @override
  State<ProductInventory> createState() => _ProductInventoryState();
}

class _ProductInventoryState extends State<ProductInventory> {
  TextEditingController quantitycontroller = TextEditingController();
  late Future<TransferDetailsModel?> transferDetailsModel;

  @override
  void initState() {
    // TODO: implement initState
    transferDetailsModel = CallApi.getTransferDetails(widget.tranferid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Transfer Details"),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // Add your refresh logic here
            setState(() {
              transferDetailsModel =
                  CallApi.getTransferDetails(widget.tranferid);
            });
          },
          child: FutureBuilder<TransferDetailsModel?>(
            future: transferDetailsModel,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child:
                        CircularProgressIndicator()); // Or any loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // Use the data to build your ListView

                return ListView.builder(
                  itemCount: snapshot.data!.transferDetails!.length,
                  itemBuilder: (context, index) {
                    var transferDetailsdata =
                        snapshot.data!.transferDetails![index];
                    return Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child:
                                //       Text(transferDetailsdata.id.toString()),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(transferDetailsdata.productName
                                      .toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      transferDetailsdata.tquantity.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(transferDetailsdata.expiryDate
                                      .toString()),
                                ),
                                // TextField(
                                //   controller: quantitycontroller,
                                //   decoration:
                                //       InputDecoration(labelText: "Quantity"),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CupertinoButton(
                                    child: Text("back"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }, // <-- Add this comma
                );
              } else {
                return Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }
}
