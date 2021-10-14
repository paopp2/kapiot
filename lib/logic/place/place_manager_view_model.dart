import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/logic/shared/view_model.dart';

final placeManagerViewModel =
    Provider.autoDispose((ref) => PlaceManagerViewModel(read: ref.read));

class PlaceManagerViewModel extends ViewModel {
  PlaceManagerViewModel({
    required Reader read,
  }) : super(read);
  final _appRouter = AppRouter.instance;

  void gotoSavePlaceView() => _appRouter.navigateTo(Routes.savePlaceView);

  void openSavePlacePicker() => _appRouter.navigateTo(Routes.savePlacePicker);
}
