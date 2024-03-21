import 'package:aio_place/component/order_log_tile.dart';
import 'package:aio_place/controllers/orders_controller.dart';
import 'package:aio_place/utils/enum_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersController());
    return GetBuilder<OrdersController>(
      initState: (_) {
        Get.find<OrdersController>().getOrders();
      },
      builder: (controller) =>
          Obx(() => controller.currentState.value == CurrentState.loading
              ? const Center(child: CircularProgressIndicator())
              : controller.currentState.value == CurrentState.empty
                  ? Center(
                      child: SvgPicture.asset(
                        'assets/svgs/emptyWishList.svg',
                        width: Get.width * 0.8,
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.ordersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return OrderLogTile(
                            orderModel: controller.ordersList[index]);
                      },
                    )),
    );
  }
}
