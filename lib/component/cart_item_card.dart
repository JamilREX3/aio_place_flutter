

import 'package:aio_place/models/cart_model.dart';
import 'package:aio_place/utils/custom_colors_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CartItemCard extends StatelessWidget {
  final CartItems cartItem;
  final void Function()? addPiece;
  final void Function()? removePiece;
  final void Function()? deleteItem;
  const CartItemCard({Key? key , required this.cartItem , required this.addPiece, required this.removePiece , required this.deleteItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),child: CachedNetworkImage(imageUrl: cartItem.product!.imageCover! , fit: BoxFit.fitWidth,)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartItem.product!.title!),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Price : '),
                    Text(cartItem.price!.toStringAsFixed(2)),
                    const Text(' x '),
                    Text(cartItem.quantity.toString()),
                    const Text(' = '),
                    Text((cartItem.quantity!*cartItem.price!.toDouble()).toStringAsFixed(2),style: const TextStyle(fontWeight: FontWeight.w800),),
                    const Text(' \$',style: TextStyle(fontWeight: FontWeight.w800)),
                  ],
                ),
                const SizedBox(height: 10),
                cartItem.color!=null?Row(
                  children: [
                    const Text('Color :   '),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).brightness ==
                                Brightness.light
                                ? Colors.grey.withOpacity(0.5)
                                : Colors.white.withOpacity(0.5),
                            spreadRadius: 0.1,
                            blurRadius: 2,
                            offset: const Offset(0, 0.5),
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: CustomColorsUtils().getColorsFromStrings([cartItem.color!])[0],
                      ),
                    ),
                  ],
                ):const SizedBox(),
                const SizedBox(height: 10),
                cartItem.size!=null?Row(
                  children: [
                    const Text('Size : '),
                    Text(cartItem.size.toString(),style: const TextStyle(fontWeight: FontWeight.w800),),
                  ],
                ):const SizedBox(),
                const SizedBox(height: 10),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: addPiece,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade900,
                             Colors.green.shade500,
                             // Colors.green.shade300,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Text('+ Add piece',style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 3),
                    InkWell(
                      onTap: removePiece,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade900,
                              Colors.blue.shade500,
                              //Colors.blue.shade300,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Text('- Remove piece',style: TextStyle(color: Colors.white)),
                      ),
                    ),

                    const Expanded(child: SizedBox()),
                    InkWell(
                      onTap:deleteItem,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.red.shade900,
                              Colors.red.shade500,
                              //Colors.red.shade300,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Text('Delete' , style: TextStyle(color: Colors.white),),
                      ),
                    ),



                    // ElevatedButton(onPressed: (){}, child: const Text('add piece')),
                    // ElevatedButton(onPressed: (){}, child: const Text('remove piece')),
                    // ElevatedButton(onPressed: (){}, child: const Text('Delete')),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
