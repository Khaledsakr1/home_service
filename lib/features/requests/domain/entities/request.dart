import 'package:equatable/equatable.dart';

class Request extends Equatable {
  final int id;
  final int workerId;
  final int customerId;
  final int projectId;
  final String customerName;
  final String status;
  final String projectName;
  final String service;
  final String date;
  final String location;
  final int statusCode;

  // ADD NEW FIELDS FOR FULL DETAILS:
  final String apartmentType;
  final String apartmentSize;
  final String preferredStyle;
  final String materialQuality;
  final double minBudget;
  final double maxBudget;
  final String projectDetails;
  final List<String> projectImages;
  final double? workerOfferedPrice;

  const Request({
    required this.id,
    required this.workerId,
    required this.customerId,
    required this.projectId,
    required this.customerName,
    required this.status,
    required this.projectName,
    required this.service,
    required this.date,
    required this.location,
    required this.statusCode,
    required this.apartmentType,
    required this.apartmentSize,
    required this.preferredStyle,
    required this.materialQuality,
    required this.minBudget,
    required this.maxBudget,
    required this.projectDetails,
    required this.projectImages,
    this.workerOfferedPrice,
  });

  @override
  List<Object?> get props => [
        id,
        workerId,
        customerId,
        projectId,
        status,
        projectName,
        service,
        date,
        location,
        statusCode,
        apartmentType,
        apartmentSize,
        preferredStyle,
        materialQuality,
        minBudget,
        maxBudget,
        projectDetails,
        projectImages,
        workerOfferedPrice,
        customerName,
      ];
}
