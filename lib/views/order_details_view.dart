import 'package:aio_place/models/order_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';

class OrderDetailsView extends StatelessWidget {
  final OrderModel orderModel;

  const OrderDetailsView({Key? key, required this.orderModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order Details',
          style:
              GoogleFonts.lobsterTwo(fontSize: 35, fontStyle: FontStyle.italic),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImageView(
                  data: orderModel.sId.toString(),
                  version: QrVersions.auto,
                  size: 160,
                  gapless: false,
                  foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
                  embeddedImageStyle: const QrEmbeddedImageStyle(
                    size: Size(80, 80),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),


            // addresses
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigoAccent.shade700,
                    Colors.indigoAccent.shade100
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Address',
                      style: TextStyle(
                          fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        // const Text('Phone : ',
                        //     style: TextStyle(color: Colors.grey)),
                        const Icon(Icons.phone, color: Colors.white,size: 18,),
                        const SizedBox(width: 8.0),
                        Text(orderModel.shippingAddress?.phone ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ],
                    ),
                    Row(
                      children: [
                        // const Text('City : ',
                        //     style: TextStyle(color: Colors.grey)),

                        const Icon(Icons.location_city, color: Colors.white,size: 18,),
                        const SizedBox(width: 8.0),
                        Text(orderModel.shippingAddress?.city ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                      width: 220,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text('Details : ',
                          //     style: TextStyle(color: Colors.grey)),

                          const Icon(Icons.home, color: Colors.white,size: 18,),
                          const SizedBox(width: 8.0),


                          Flexible(
                            child: Text(
                              orderModel.shippingAddress?.details ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        // Text('Postal code : ',
                        //     style: TextStyle(color: Colors.grey)),

                        const Icon(Icons.mail, color: Colors.white,size: 18,),
                        const SizedBox(width: 8.0),


                        Text(orderModel.shippingAddress?.postalCode ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // created at updated at
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigoAccent.shade700,
                    Colors.indigoAccent.shade100
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        const Icon(Icons.create_rounded, color: Colors.white,size: 18,),
                        const SizedBox(width: 8.0),
                        Text(DateFormat('dd/MM/yyyy h:mm a').format(DateTime.parse(orderModel.createdAt!)),
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ],
                    ),

                    Row(
                      children: [
                        const Icon(Icons.update_rounded, color: Colors.white,size: 18,),
                        const SizedBox(width: 8.0),
                        Text(DateFormat('dd/MM/yyyy h:mm a').format(DateTime.parse(orderModel.updatedAt!)),
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigoAccent.shade700,
                    Colors.indigoAccent.shade100
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        const Icon(Icons.price_check, color: Colors.white,size: 18,),
                        const SizedBox(width: 8.0),
                        Text(orderModel.totalOrderPrice.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ],
                    ),



                  ],
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: orderModel.isDelivered==false?LinearGradient(
                        colors: [
                          Colors.orange.shade800,
                          Colors.orange.shade300
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ):LinearGradient(
                        colors: [
                          Colors.green.shade800,
                          Colors.green.shade300
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(child: Text(orderModel.isDelivered==true?'Delivered':'Not Delivered Yet',style: const TextStyle(color: Colors.white),),),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: orderModel.isPaid==false?LinearGradient(
                        colors: [
                          Colors.orange.shade800,
                          Colors.orange.shade300
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ):LinearGradient(
                        colors: [
                          Colors.green.shade800,
                          Colors.green.shade300
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(child: Text(orderModel.isPaid==true?'Paid':'Not Paid Yet',style: const TextStyle(color: Colors.white),),),
                  ),
                ),
              ],
            ),
            ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: orderModel.cartItems!.length,
              itemBuilder: (context, index) {
                print('jjj');
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderModel.cartItems![index].product!.title
                              .toString(),
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        orderModel.cartItems![index].size != null
                            ? Row(
                                children: [
                                  const Text(
                                    'size : ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(orderModel.cartItems![index].size
                                      .toString()),
                                ],
                              )
                            : const SizedBox(),
                        orderModel.cartItems?[index].color != null
                            ? Row(
                                children: [
                                  const Text(
                                    'color : ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(orderModel.cartItems![index].color
                                      .toString()),
                                ],
                              )
                            : const SizedBox(),
                        Row(
                          children: [
                            const Text(
                              'quantity : ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(orderModel.cartItems![index].quantity
                                .toString()),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'price : ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(orderModel.cartItems![index].price.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'total : ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text((orderModel.cartItems![index].price!
                                        .toDouble() *
                                    orderModel.cartItems![index].quantity!
                                        .toInt())
                                .toStringAsFixed(2)),
                          ],
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        orderModel.cartItems![index].product!.imageCover
                            .toString(),
                      ),
                      minRadius: 32,
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
