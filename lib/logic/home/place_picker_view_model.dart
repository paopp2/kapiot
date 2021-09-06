import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/shared/view_model.dart';

final placePickerViewModel = Provider.autoDispose(
  (ref) => PlacePickerViewModel(read: ref.read),
);

class PlacePickerViewModel extends ViewModel {
  PlacePickerViewModel({required Reader read}) : super(read);
}
