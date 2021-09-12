import 'package:hooks_riverpod/hooks_riverpod.dart';

final missingServiceHandler = Provider.autoDispose(
  (ref) => ServiceErrorHandler(
    read: ref.read,
  ),
);

class ServiceErrorHandler {
  ServiceErrorHandler({required this.read});
  final Reader read;
}
