import 'package:hooks_riverpod/hooks_riverpod.dart';

// TODO: Add relevant providers
final riderManagerViewModel =
    Provider.autoDispose((ref) => RiderManagerViewModel(
          read: ref.read,
        ));

// TODO: Add constructors to relevant providers
class RiderManagerViewModel {
  RiderManagerViewModel({required this.read});
  final Reader read;

  void initState() {}
  // *! Temporary list to maintain provider logic
  var riderList = ['Christian Gonzales, Blithe Gonzales', 'Charles Ausejo'];

  void dispose() {}
}
