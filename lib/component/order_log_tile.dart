import 'package:aio_place/models/order_model.dart';
import 'package:aio_place/views/order_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrderLogTile extends StatelessWidget {
  final OrderModel orderModel;
  const OrderLogTile({Key? key , required this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(orderModel.sId??'');
    return  GestureDetector(
      onTap: (){
        Get.to(OrderDetailsView(orderModel: orderModel) , duration: const Duration(milliseconds: 100));
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
            margin: const EdgeInsets.symmetric(vertical: 8 , horizontal: 8),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey.withOpacity(0.15) : Colors.white,
            ),
            child: Column(
              children: [
                //qr and address
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(orderModel.totalOrderPrice.toString()),
                        Row(
                          children: [
                            const Text('Phone : ' , style: TextStyle(color: Colors.grey)),
                            Text(orderModel.shippingAddress?.phone??'',style: const TextStyle(fontWeight: FontWeight.w700)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('City : ',style: TextStyle(color: Colors.grey)),
                            Text(orderModel.shippingAddress?.city??'',style: const TextStyle(fontWeight: FontWeight.w700)),
                          ],
                        ),
                        SizedBox(
                          width: 220,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Details : ', style: TextStyle(color: Colors.grey)),
                              Flexible(
                                child: Text(
                                  orderModel.shippingAddress?.details ?? '',
                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Text('Postal code : ' , style: TextStyle(color: Colors.grey)),
                            Text(orderModel.shippingAddress?.postalCode??'',style: const TextStyle(fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    QrImageView(
                      data: orderModel.sId!,
                      version: QrVersions.auto,
                      size: 70,
                      gapless: false,
                      embeddedImage: const AssetImage('assets/images/my_embedded_image.png'),
                      embeddedImageStyle: const QrEmbeddedImageStyle(
                        size: Size(80, 80),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Text('items' , style: TextStyle(color: Colors.grey),),
                  ],
                ),
                SizedBox(
                  //color: Colors.red,
                  width: Get.width*0.9,
                  height: 30,
                  child: ListView.separated(
                    //physics: const NeverScrollableScrollPhysics(),
                    //shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: orderModel.cartItems!.length,
                    itemBuilder: (context,index){
                      return  Text(orderModel.cartItems![index].product!.title.toString());
                    }, separatorBuilder: (BuildContext context, int index) { return const Text(' , '); },
                  ),
                ),
                const SizedBox(height: 10),

              ],
            ),
          ),
          Positioned(bottom: 10,right: 20,child: Row(
            children: [
              const Icon(Icons.access_time_rounded,color: Colors.grey,size: 15,),
              const SizedBox(width: 4),
              Text(
                timeago.format(
                    DateTime.parse(orderModel.updatedAt.toString()),
                    locale: 'en_short'),
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ],
          ),)
        ],
      ),
    );
  }
}
