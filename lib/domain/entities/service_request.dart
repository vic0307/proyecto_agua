import 'request_stage.dart';
import 'request_type.dart';

class ServiceRequest {
  const ServiceRequest({
    required this.id,
    required this.type,
    required this.address,
    required this.createdAt,
    this.notes = '',
    this.stage = RequestStage.recibida,
  });
  final String id;
  final RequestType type;
  final String address;
  final String notes;
  final DateTime createdAt;
  final RequestStage stage;
}
