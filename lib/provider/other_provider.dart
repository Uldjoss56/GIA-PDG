import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/models/other_models.dart';

class DeviceNotifier extends StateNotifier<List<Device>> {
  DeviceNotifier(List<Device> devices) : super(devices);

  void updateListDevice(List<Device> devices) {
    state = devices;
  }
}

final devicesProvider = StateNotifierProvider<DeviceNotifier, List<Device>>(
  (ref) => DeviceNotifier(
    List.empty(),
  ),
);

class RoleNotifier extends StateNotifier<List<Role>> {
  RoleNotifier(List<Role> roles) : super(roles);

  void updateRole(List<Role> roles) {
    state = roles;
  }
}

final roleProvider = StateNotifierProvider<RoleNotifier, List<Role>>(
  (ref) => RoleNotifier(
    List.empty(),
  ),
);

class CountryNotifier extends StateNotifier<List<Country>> {
  CountryNotifier(List<Country> countries) : super(countries);

  void updateCountry(List<Country> countries) {
    state = countries;
  }
}

final countriesProvider = StateNotifierProvider<CountryNotifier, List<Country>>(
  (ref) => CountryNotifier(
    List.empty(),
  ),
);
