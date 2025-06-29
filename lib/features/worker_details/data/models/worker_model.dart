// features/worker/data/models/worker_model.dart

import '../../domain/entities/worker.dart';

class WorkerModel extends Worker {
  const WorkerModel({
    required int id,
    required int userId,
    required String name,
    required String description,
    required String companyName,
    required int experienceYears,
    required String email,
    required String city,
    required String phoneNumber,
    required String profilePictureUrl,
    required int age,
    required String address,
    required String serviceName,
    required double rating,
    required int completedRequests,
    required bool isBlocked,
    required List<ReviewModel> reviews,
    required List<PortfolioItemModel> portfolioItems,
  }) : super(
    id: id,
    userId: userId,
    name: name,
    description: description,
    companyName: companyName,
    experienceYears: experienceYears,
    email: email,
    city: city,
    phoneNumber: phoneNumber,
    profilePictureUrl: profilePictureUrl,
    age: age,
    address: address,
    serviceName: serviceName,
    rating: rating,
    completedRequests: completedRequests,
    isBlocked: isBlocked,
    reviews: reviews,
    portfolioItems: portfolioItems,
  );

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      companyName: json['companyName'] ?? '',
      experienceYears: json['experienceYears'] ?? 0,
      email: json['email'] ?? '',
      city: json['city'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profilePictureUrl: json['profilePictureUrl'] ?? '',
      age: json['age'] ?? 0,
      address: json['address'] ?? '',
      serviceName: json['serviceName'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      completedRequests: json['completedRequests'] ?? 0,
      isBlocked: json['isBlocked'] ?? false,
      reviews: json['reviews'] == null
          ? []
          : List<ReviewModel>.from(
              json['reviews'].map((x) => ReviewModel.fromJson(x))),
      portfolioItems: json['portfolioItems'] == null
          ? []
          : List<PortfolioItemModel>.from(
              json['portfolioItems'].map((x) => PortfolioItemModel.fromJson(x))),
    );
  }
}

class ReviewModel extends Review {
  const ReviewModel({
    required int id,
    required int customerId,
    required String customerName,
    required String comment,
    required double rating,
  }) : super(
    id: id,
    customerId: customerId,
    customerName: customerName,
    comment: comment,
    rating: rating,
  );

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? 0,
      customerId: json['customerId'] ?? 0,
      customerName: json['customerName'] ?? '',
      comment: json['comment'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}

class PortfolioItemModel extends PortfolioItem {
  const PortfolioItemModel({
    required int id,
    required String name,
    required String description,
    required List<String> imageUrls,
  }) : super(
    id: id,
    name: name,
    description: description,
    imageUrls: imageUrls,
  );

  factory PortfolioItemModel.fromJson(Map<String, dynamic> json) {
    return PortfolioItemModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrls: json['imageUrls'] == null
        ? []
        : List<String>.from(json['imageUrls']),
    );
  }
}

