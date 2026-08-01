class RideLocationState {
  final bool myLocationEnabled;
  final bool isLocating;

  const RideLocationState({
    this.myLocationEnabled = false,
    this.isLocating = false,
  });

  RideLocationState copyWith({bool? myLocationEnabled, bool? isLocating}) =>
      RideLocationState(
        myLocationEnabled: myLocationEnabled ?? this.myLocationEnabled,
        isLocating: isLocating ?? this.isLocating,
      );
}
