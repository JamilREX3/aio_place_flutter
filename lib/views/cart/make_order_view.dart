import 'package:aio_place/controllers/make_order_controller.dart';
import 'package:aio_place/utils/enum_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../models/address_model.dart';


class MakeOrderView extends StatelessWidget {
  final num finalPrice;
  final String cartId;
  const MakeOrderView({Key? key , required this.finalPrice , required this.cartId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MakeOrderController());
    return  Material(
      color: Colors.transparent,
      child: GetBuilder<MakeOrderController>(
        initState: (_){
          Get.find<MakeOrderController>().getUserAddresses();
        },
        builder: (controller)=>Obx(() => controller.currentState.value==CurrentState.loading?Container(
          decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: BorderRadius.circular(20)
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 270),
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
          child: Container(padding:const EdgeInsets.symmetric(horizontal: 100,vertical: 50),child: const CircularProgressIndicator()),
        ):Container(
          decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: BorderRadius.circular(20)
          ),
          margin: controller.selectedAddress==null? const EdgeInsets.symmetric(horizontal: 20,vertical: 260):const EdgeInsets.symmetric(horizontal: 20,vertical: 200),
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('Make Order' , style: GoogleFonts.lobsterTwo(fontStyle: FontStyle.italic , fontSize: 24),)),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Price : ',style: TextStyle(color: Colors.grey,fontSize: 18),),
                  Text(finalPrice.toStringAsFixed(2) , style: const TextStyle(fontWeight: FontWeight.w700 , fontSize: 20),),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Shipping address : '),
                  const SizedBox(width: 10),
                  DropdownButton<AddressModel>(
                    value: controller.selectedAddress,
                    onChanged: (AddressModel? newValue) {
                      controller.selectedAddress = newValue;
                      controller.update();
                    },
                    items: controller.addressList
                        .map<DropdownMenuItem<AddressModel>>(
                            (AddressModel value) {
                          return DropdownMenuItem<AddressModel>(
                            value: value,
                            child: Text(value.alias!),
                          );
                        }).toList(),
                  ),
                ],
              ),
              controller.selectedAddress!=null?Column(
                children: [
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text('Alias : ',style: TextStyle(color: Colors.grey),),
                      Text(controller.selectedAddress?.alias??'' , style: const TextStyle(fontWeight: FontWeight.w700),),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Phone : ' , style: TextStyle(color: Colors.grey)),
                      Text(controller.selectedAddress?.phone??'',style: const TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('City : ',style: TextStyle(color: Colors.grey)),
                      Text(controller.selectedAddress?.city??'',style: const TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Details : ',style: TextStyle(color: Colors.grey)),
                      Text(controller.selectedAddress?.details??'',style: const TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Postal code : ' , style: TextStyle(color: Colors.grey)),
                      Text(controller.selectedAddress?.postalCode??'',style: const TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ):const SizedBox(),
              const Expanded(child: SizedBox()),
              Center(child: ElevatedButton(onPressed: (){
                controller.makeOrder(cartId);
              }, child: const Text('Make Order'))),
            ],
          ),
        )),
      ),
    );
  }
}
