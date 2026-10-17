import 'package:flutter/foundation.dart';

import '../../domain/entities/activity.dart';
import '../../domain/entities/payment.dart';
import '../../domain/entities/request_type.dart';
import '../../domain/entities/service_request.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/water_repository.dart';

/// Estado global de la app; la UI se reconstruye al notificar.
class AppController extends ChangeNotifier {
  AppController(this._repo);
  final WaterRepository _repo;

  bool loading = true;
  UserProfile? profile;
  double balance = 0;
  List<ServiceRequest> requests = [];
  List<Activity> activities = [];

  ServiceRequest? get latestRequest =>
      requests.isEmpty ? null : requests.first;

  Future<void> load() async {
    await _sync();
    loading = false;
    notifyListeners();
  }

  Future<void> register(UserProfile p, double amount) async {
    await _repo.register(p, amount);
    await _refresh();
  }

  Future<Payment> pay() async {
    final payment = await _repo.payBalance();
    await _refresh();
    return payment;
  }

  Future<void> sendRequest(
      {required RequestType type, required String address, String notes = ''}) async {
    await _repo.sendRequest(type: type, address: address, notes: notes);
    await _refresh();
  }

  Future<void> signOut() async {
    await _repo.signOut();
    await _refresh();
  }

  Future<void> _sync() async {
    profile = await _repo.getProfile();
    balance = await _repo.getBalance();
    requests = await _repo.getRequests();
    activities = await _repo.getActivities();
  }

  Future<void> _refresh() async {
    await _sync();
    notifyListeners();
  }
}
