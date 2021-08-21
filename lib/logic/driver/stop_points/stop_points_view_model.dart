import 'package:hooks_riverpod/hooks_riverpod.dart';

final stopPointsViewModel = Provider.autoDispose<StopPointsViewModel>(
    (ref) => StopPointsViewModel(ref.read));

class StopPointsViewModel {
  StopPointsViewModel(this.read);
  final Reader read;
}
