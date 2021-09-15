class RealtimeDbPath {
  static String userRealtimeLocation(String userId) =>
      'realtime_locations/$userId';
  static String allRealtimeLocations() => 'realtime_locations';
}
