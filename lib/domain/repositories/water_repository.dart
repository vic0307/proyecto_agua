import '../entities/activity.dart';
import '../entities/payment.dart';
import '../entities/request_type.dart';
import '../entities/service_request.dart';
import '../entities/user_profile.dart';

/// Contrato de datos. La UI solo depende de esta clase.
abstract class WaterRepository {
  Future<UserProfile?> getProfile();
  Future<double> getBalance();
  Future<List<ServiceRequest>> getRequests(); // más reciente primero
  Future<List<Activity>> getActivities(); // más reciente primero

  Future<void> register(UserProfile profile, double balance);
  Future<Payment> payBalance();
  Future<ServiceRequest> sendRequest(
      {required RequestType type, required String address, String notes});
  Future<void> signOut();
}
