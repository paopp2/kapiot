import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/post_trip/post_trip_summary_view_state.dart';
import 'package:kapiot/logic/post_trip/post_trip_summary_view_model.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'components/driver_photo.dart';
import 'components/reward_points_backdrop.dart';
import 'components/reward_points_confetti.dart';
import 'components/transaction_info_panel.dart';

class PostTripSummaryView extends HookConsumerWidget {
  const PostTripSummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = ref.watch(transactionProvider).state;
    final model = ref.watch(postTripSummaryViewModel);
    final isDriver = ref.watch(isDriverProvider);
    final driver = transaction.driver!.user;

    useEffect(() {
      model.initState();
      model.showRateDriverDialog(
        dialog: AlertDialog(
          title: const Text('Driver Rating'),
          content: SizedBox(
            height: 100,
            child: Column(
              children: [
                RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (_, __) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  updateOnDrag: true,
                  onRatingUpdate: model.setRating,
                ),
                TextButton(
                  onPressed: model.updateDriverRating,
                  child: const Text('Ok'),
                ),
              ],
            ),
          ),
        ),
      );
      return model.dispose;
    }, []);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body: Center(
              child: Stack(
                children: [
                  Column(
                    children: [
                      RewardPointsBackdrop(constraints: constraints),
                      TransactionInfoPanel(
                        model: model,
                        constraints: constraints,
                        transaction: transaction,
                        isDriver: isDriver,
                        driver: driver,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isDriver,
                    child: DriverPhoto(
                      constraints: constraints,
                      driver: driver,
                    ),
                  ),
                  RewardPointsConfetti(constraints: constraints),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
