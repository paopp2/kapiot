import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';

const uscLogo =
    'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png';

class DriveInfoPanel extends HookConsumerWidget {
  const DriveInfoPanel({
    Key? key,
    required this.constraints,
  }) : super(key: key);
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDriverConfig =
        ref.watch(currentRouteConfigProvider).state as ForDriver;
    final _expand = useState(false);
    final maxRiderCount = currentDriverConfig.maxRiderCount;
    final currentRiderCount = currentDriverConfig.currentRiderCount;
    final driverPoints = ref.watch(driverPointsProvider).state;
    final acceptedRidersStream = ref.watch(acceptedRidersStreamProvider);
    return InkWell(
      onTap: () => (_expand.value = !_expand.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInToLinear,
        margin: EdgeInsets.symmetric(
          vertical: constraints.maxHeight * 0.015,
        ),
        height: _expand.value ? constraints.maxHeight * 0.25 : 50,
        width: _expand.value ? constraints.maxWidth * 0.8 : 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ListTile(
              dense: true,
              title: Text(
                driverPoints.toStringAsFixed(2),
                style: GoogleFonts.montserrat(
                  color: const Color(0xff414141),
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                '$currentRiderCount/$maxRiderCount',
                style: GoogleFonts.montserrat(
                  color: (currentRiderCount == maxRiderCount)
                      ? Colors.red
                      : Colors.green,
                  fontSize: 16,
                ),
              ),
              leading: const Icon(
                FontAwesomeIcons.handHoldingHeart,
                size: 16,
                color: Color(0xffcccccc),
              ),
              minLeadingWidth: 10,
            ),
            _expand.value
                ? Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 100,
                      child: acceptedRidersStream.when(
                        error: (_, __) => const SizedBox(),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        data: (acceptedRiders) {
                          return acceptedRiders.isEmpty
                              ? Center(
                                  child: Text(
                                    'No Passengers',
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      color: const Color(0xFF333333),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: acceptedRiders.length,
                                  itemBuilder: (context, index) {
                                    final rider = acceptedRiders[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xffF2F3F8),
                                          width: 2,
                                        ),
                                        color: const Color(0xffF8F9FD),
                                      ),
                                      child: ListTile(
                                        leading: Container(
                                          width: 40,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                              rider.photoUrl ?? uscLogo,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color(0xFF5F45A4),
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          rider.displayName ?? '',
                                          style: GoogleFonts.montserrat(
                                            color: const Color(0xff333333),
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                        ),
                                        subtitle: Text(
                                          rider.userType!.description,
                                          style: GoogleFonts.montserrat(
                                            color: const Color(0xff333333),
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                        },
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
