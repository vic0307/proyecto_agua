import '../../domain/entities/activity.dart';
import '../../domain/entities/payment.dart';
import '../../domain/entities/request_type.dart';
import '../../domain/entities/service_request.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/water_repository.dart';

/// Guarda todo en memoria (sin datos precargados).
/// Sustituir por API/BD real implementando [WaterRepository].
class InMemoryWaterRepository implements WaterRepository {
  UserProfile? _profile;
  double _balance = 0;
  int _payments = 0;
  int _requestsCount = 0;
  final List<ServiceRequest> _requests = [];
  final List<Activity> _activities = [];

  @override
  Future<UserProfile?> getProfile() async => _profile;

  @override
  Future<double> getBalance() async => _balance;

  @override
  Future<List<ServiceRequest>> getRequests() async => List.of(_requests);

  @override
  Future<List<Activity>> getActivities() async => List.of(_activities);

  @override
  Future<void> register(UserProfile profile, double balance) async {
    _profile = profile;
    _balance = balance;
  }

  @override
  Future<Payment> payBalance() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_balance <= 0) throw StateError('No hay saldo pendiente');
    final payment = Payment(
      folio: 'AGP-${100000 + ++_payments}',
      date: DateTime.now(),
      total: _balance,
    );
    _balance = 0;
    _activities.insert(
        0,
        Activity(
            type: ActivityType.payment,
            title: 'Pago recibido',
            date: payment.date));
    return payment;
  }

  @override
  Future<ServiceRequest> sendRequest({
    required RequestType type,
    required String address,
    String notes = '',
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final request = ServiceRequest(
      id: 'SOL-${1000 + ++_requestsCount}',
      type: type,
      address: address,
      notes: notes,
      createdAt: DateTime.now(),
    );
    _requests.insert(0, request);
    _activities.insert(
        0,
        Activity(
            type: ActivityType.request,
            title: 'Solicitud enviada: ${type.label}',
            date: request.createdAt));
    return request;
  }

  @override
  Future<void> signOut() async {
    _profile = null;
    _balance = 0;
    _payments = 0;
    _requestsCount = 0;
    _requests.clear();
    _activities.clear();
  }
}
