import 'package:flutter/material.dart';

import '../../../data/repositories/API_Calling/api_calling.dart';
import '../model/stockmodel.dart';

class StockPage extends StatefulWidget {
  final String beauticianId;
  const StockPage({super.key, required this.beauticianId});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  TextEditingController quantitycontroller = TextEditingController();
  late Future<StockModel?> stockModelDetails;

  @override
  void initState() {
    // TODO: implement initState
    stockModelDetails = CallApi.getStockDetails(widget.beauticianId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Stock Available"),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // Add your refresh logic here
            setState(() {
              stockModelDetails = CallApi.getStockDetails(widget.beauticianId);
            });
          },
          child: FutureBuilder<StockModel?>(
            future: stockModelDetails,
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
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    var stockDetailsdata = snapshot.data!.data![index];
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Sr.no."),
                                      Text(" Name"),
                                      Text("Quantity"),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${index + 1}"),
                                      Text(stockDetailsdata.productName
                                          .toString()),
                                      Text(
                                          stockDetailsdata.quantity.toString()),
                                    ],
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
