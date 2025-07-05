import '../../domain/entities/request.dart';

class RequestModel extends Request {
  const RequestModel({
    required int id,
    required int workerId,
    required int customerId,
    required int projectId,
    required String status,
    required String projectName,
    required String service,
    required String date,
    required String location,
    required int statusCode,
    required String apartmentType,
    required String apartmentSize,
    required String preferredStyle,
    required String materialQuality,
    required double minBudget,
    required double maxBudget,
    required String projectDetails,
    required List<String> projectImages,
  }) : super(
          id: id,
          workerId: workerId,
          customerId: customerId,
          projectId: projectId,
          status: status,
          projectName: projectName,
          service: service,
          date: date,
          location: location,
          statusCode: statusCode,
          apartmentType: apartmentType,
          apartmentSize: apartmentSize,
          preferredStyle: preferredStyle,
          materialQuality: materialQuality,
          minBudget: minBudget,
          maxBudget: maxBudget,
          projectDetails: projectDetails,
          projectImages: projectImages,
        );

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    int statusCode = 0;
    String statusString = 'pending';

    if (json['status'] != null) {
      if (json['status'] is int) {
        statusCode = json['status'];
      } else if (json['status'] is String) {
        statusString = json['status'].toLowerCase();
        switch (statusString) {
          case 'pending':
            statusCode = 0;
            break;
          case 'accepted':
            statusCode = 1;
            break;
          case 'rejected':
            statusCode = 2;
            break;
          case 'cancelled':
            statusCode = 3;
            break;
          case 'completed':
            statusCode = 4;
            break;
          default:
            statusCode = 0;
        }
      }
    }

    // Parse images array
    List<String> images = [];
    if (json['projectImageUrls'] != null && json['projectImageUrls'] is List) {
      images =
          List<String>.from(json['projectImageUrls'].where((i) => i != null));
    }

    return RequestModel(
      id: json['id'] ?? 0,
      workerId: json['workerId'] ?? 0,
      customerId: json['customerId'] ?? 0,
      projectId: json['projectId'] ?? 0,
      status: statusString,
      projectName: json['projectName'] ?? '',
      service: json['serviceName'] ?? '',
      date: json['requestDate'] ?? '',
      location: (json['customerCity'] ?? '') +
          ((json['customerAddress'] != null &&
                  json['customerAddress'].toString().isNotEmpty)
              ? ' ,${json['customerAddress']}'
              : '') +
          (json['buildingNumber'] != null &&
                  json['buildingNumber'].toString().isNotEmpty
              ? ' ${json['buildingNumber']}'
              : ''),
      statusCode: statusCode,
      apartmentType: json['apartmentType'] ?? '',
      apartmentSize: json['apartmentSize']?.toString() ?? '',
      preferredStyle: json['preferredStyle'] ?? '',
      materialQuality: json['materialQuality'] ?? '',
      minBudget: json['minBudget'] ?? 0,
      maxBudget: json['maxBudget'] ?? 0,
      projectDetails: json['projectDetails'] ?? '',
      projectImages: images,
    );
  }
}
