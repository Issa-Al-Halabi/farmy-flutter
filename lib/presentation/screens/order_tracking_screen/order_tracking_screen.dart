import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma/bloc/tracking_bloc/tracking_bloc.dart';
import 'package:pharma/bloc/tracking_bloc/tracking_event.dart';
import 'package:pharma/bloc/tracking_bloc/tracking_state.dart';
import 'package:pharma/core/utils/firebase_notifications_handler.dart';
import 'package:pharma/models/track_model.dart';
import 'package:pharma/presentation/resources/assets_manager.dart';
import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/resources/style_app.dart';
import 'package:pharma/presentation/screens/order_tracking_screen/widgets/order_status_container.dart';
import 'package:pharma/presentation/widgets/custom_error_screen.dart';
import 'package:pharma/presentation/widgets/custom_loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';
  import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../translations.dart';
import '../../widgets/custom_app_bar_screen.dart';
import '../../widgets/custom_button.dart';
import 'package:web_socket_channel/status.dart' as status;

class OrderTrackingScreen extends StatelessWidget {
  final int orderId;
  final channel = WebSocketChannel.connect(Uri.parse('ws://example.com'));

  OrderTrackingScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final bloc = TrackingBloc()
      ..setOrderId(orderId)
      ..add(const GetOrderStatus());
    FirebaseNotificationsHandler().bloc = bloc;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarScreen(
              sectionName: AppLocalizations.of(context)!.track_Order,
            ),
            Expanded(
              child: BlocConsumer<TrackingBloc, TrackingState>(
                  bloc: bloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is TrackingError) {
                      return CustomErrorScreen(onTap: () {
                        context
                            .read<TrackingBloc>()
                            .add(const GetOrderStatus());
                      });
                    } else if (state is TrackingSuccess ||
                        state is TrackingUpdate) {
                      TrackingModel trackingModel = bloc.trackingModel!;

                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 19.h,
                              horizontal: 30.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.delivery_time,
                                  style: getBoldStyle(
                                    color: ColorManager.grayForMessage,
                                    fontSize: 14,
                                  ),
                                ),
                                Expanded(
                                  child: FittedBox(
                                    child: Text(
                                      "15 إلى 20 دقيقة",
                                      style: getRegularStyle(
                                        color: ColorManager.grayForMessage,
                                        fontSize: 14,
                                      ),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          OrderStatusContainer(
                            text: AppLocalizations.of(context)!
                                .your_order_has_received,
                            image: ImageManager.status_1,
                            isActive: true,
                          ),
                          OrderStatusContainer(
                            text: AppLocalizations.of(context)!
                                .your_order_is_being_processed,
                            image: ImageManager.status_2,
                            isActive: trackingModel.status! > 1,
                          ),
                          OrderStatusContainer(
                            text: AppLocalizations.of(context)!
                                .your_order_is_out_for_delivery,
                            image: ImageManager.status_3,
                            isActive: trackingModel.status! > 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 72,
                              vertical: 20,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomButton(
                                    label: AppLocalizations.of(context)!
                                        .track_your_order_on_the_map,
                                    onTap: () async {
                                      await channel.ready;
                                      channel.stream.listen((message) {
                                        channel.sink.add('received!');
                                        channel.sink.close(status.goingAway);
                                      });
                                      // AppRouter.push(
                                      //   context,
                                      //   const TrackingScreen(),
                                      // );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomButton(
                                    label: AppLocalizations.of(context)!
                                        .contact_delivery_driver,
                                    isFilled: true,
                                    borderColor: ColorManager.primaryGreen,
                                    fillColor: Colors.white,
                                    labelColor: ColorManager.primaryGreen,
                                    onTap: () async {
                                      Uri url = Uri.parse(
                                          "tel://${trackingModel.driverPhone}");
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    }

                    return const CustomLoadingWidget();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
