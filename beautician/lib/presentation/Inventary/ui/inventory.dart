import 'dart:developer';

import 'package:beautician/data/repositories/API_Calling/api_calling.dart';
import 'package:beautician/presentation/Inventary/ui/product_inventory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Inventory_model.dart/Inventory_model.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  late Future<InventoryModel?> inventoryModel;

  @override
  void initState() {
    // TODO: implement initState
    inventoryModel = CallApi.getTransferList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Transaction Assigned"),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // Add your refresh logic here
            setState(() {
              inventoryModel = CallApi.getTransferList();
            });
          },
          child: FutureBuilder<InventoryModel?>(
            future: inventoryModel,
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
                  itemCount: snapshot.data!.transferList!.length,
                  itemBuilder: (context, index) {
                    var inventorydata = snapshot.data!.transferList![index];
                    return Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      inventorydata.transferRef.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      inventorydata.transferDate.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      inventorydata.beauticianId.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(inventorydata.status.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Text(inventorydata.createdAt.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Text(inventorydata.updatedAt.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CupertinoButton(
                                    child: Text("View"),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductInventory(
                                            tranferid:
                                                inventorydata.id.toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    color: Colors.black,
                                  ),
                                ),
                                (inventorydata.status.toString() ==
                                        "not-accepted")
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CupertinoButton(
                                          child: Text("Accept"),
                                          onPressed: () {
                                            log(inventorydata.beauticianId
                                                .toString());
                                            log(inventorydata.id.toString());
                                            CallApi.acceptProduct(
                                                inventorydata.beauticianId
                                                    .toString(),
                                                inventorydata.id.toString(),
                                                context);
                                            setState(() {
                                              inventoryModel =
                                                  CallApi.getTransferList();
                                            });
                                          },
                                          color: Colors.black,
                                        ),
                                      )
                                    : Container()
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
