import 'package:aio_place/controllers/add_to_cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToCartView extends StatelessWidget {
  final String productId;
  const AddToCartView({Key? key , required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AddToCartController());
    return GetBuilder<AddToCartController>(
      initState: (_){
        Get.find<AddToCartController>().getProductsDetails(productId);
      },
      builder:(controller)=> Material(
        color: Colors.transparent,
        child: Obx(() =>controller.loading.value==false? Container(
          decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: BorderRadius.circular(20)
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              controller.availableSizes.isNotEmpty?
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      const Text('Size' , style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 18),),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(27),
                              borderSide: const BorderSide(
                                style: BorderStyle.solid,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.all(16),
                            fillColor: Colors.transparent,
                          ),
                          value: controller.selectedSize,
                          onChanged: (String? newValue) {
                            controller.selectedSize = newValue;
                            controller.update();
                          },
                          items: controller.availableSizes.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ):const SizedBox(),
              controller.availableColors.isNotEmpty?
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      const Text('Color',style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 18)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(27),
                              borderSide: const BorderSide(
                                style: BorderStyle.solid,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.all(16),
                            fillColor: Colors.transparent,
                          ),
                          value: controller.selectedColor,
                          onChanged: (String? newValue) {
                            controller.selectedColor = newValue;
                            controller.update();
                          },
                          items: controller.availableColorsStrings.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ):const SizedBox(),
              Row(
                children: [
                  const Text('Quantity',style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 18)),
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:[
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: (){
                              controller.changeQuantity('Dec');
                            },
                          ),
                          Text(controller.selectedQuantity.value.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: (){
                              controller.changeQuantity('Inc');
                            },
                          ),
                        ]
                    ),
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  const Text('total price : ',style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 18)),
                  const SizedBox(width: 10),
                  Text(controller.totalPrice.value.toStringAsFixed(2),style: const TextStyle(fontWeight: FontWeight.w700 , fontSize: 18)),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: (){
                controller.addToCart();

              }, child: const Text('Add to cart'))
            ],
          ),
        ):Container(
          decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: BorderRadius.circular(20)
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Container(padding:const EdgeInsets.symmetric(horizontal: 105,vertical: 130),child: const CircularProgressIndicator()),
        )),
      ),
    );
  }
}
