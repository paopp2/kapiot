import 'dart:core';

class FirestorePath {
  // COLLECTION paths
  static String colActiveDrivers() => 'active_drivers';
  static String colActiveRiders() => 'active_riders';
  static String colRequestingRiders(String driverId) =>
      'active_drivers/$driverId/requests';
  static String colAcceptedRiders(String driverId) =>
      'active_drivers/$driverId/accepted';

  // DOCUMENT paths
  static String docActiveDriver(String driverId) => 'active_drivers/$driverId';
  static String docActiveRider(String riderId) => 'active_riders/$riderId';
  static String docActiveDriverRequest(String driverId, String riderId) =>
      'active_drivers/$driverId/requests/$riderId';
  static String docActiveDriverAccepted(String driverId, String riderId) =>
      'active_drivers/$driverId/accepted/$riderId';
}
