import 'package:aio_place/component/customTextField.dart';
import 'package:aio_place/controllers/cart_controller.dart';
import 'package:aio_place/utils/api_request.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ApplyCouponDialog extends StatefulWidget {
  const ApplyCouponDialog({Key? key}) : super(key: key);

  @override
  State<ApplyCouponDialog> createState() => _ApplyCouponDialogState();
}

class _ApplyCouponDialogState extends State<ApplyCouponDialog> {
  final TextEditingController couponTextEditingController = TextEditingController();
  bool loading = false;

  applyCoupon()async{
    setState(() {
      loading = true;
    });
   var response = await ApiRequest().put(path: '/cart/applyCoupon',body: {
     'coupon' : couponTextEditingController.text,
   });
   if(response.statusCode.toString().startsWith(RegExp(r'2'))){
     if(Get.isDialogOpen==true){
       Get.back();
       Get.find<CartController>().initCartController();
     }
   }
   setState(() {
     loading = false;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: loading==false?Container(
        decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(20)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 270),
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
        child: Column(
          children: [
            Text('Apply Coupon' , style: GoogleFonts.lobsterTwo(fontStyle: FontStyle.italic , fontSize: 24),),
            const SizedBox(height: 24),
            CustomTextFormField(
              controller: couponTextEditingController,
              contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 16),
            ),
            const Expanded(child: SizedBox()),
            ElevatedButton(onPressed: (){applyCoupon();}, child: const Text('Apply Coupon')),
          ],
        ),
      ):Container(
        decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
          //color: Colors.red,
            borderRadius: BorderRadius.circular(20)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 270),
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
        child: Container(padding:const EdgeInsets.symmetric(horizontal: 100,vertical: 50),child: const CircularProgressIndicator()),
      ),
    );
  }
}
