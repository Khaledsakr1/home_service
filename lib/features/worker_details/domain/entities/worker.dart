// features/worker/domain/entities/worker.dart

import 'package:equatable/equatable.dart';

class Worker extends Equatable {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String companyName;
  final int experienceYears;
  final String email;
  final String city;
  final String phoneNumber;
  final String profilePictureUrl;
  final int age;
  final String address;
  final String serviceName;
  final double rating;
  final int completedRequests;
  final bool isBlocked;
  final List<Review> reviews;
  final List<PortfolioItem> portfolioItems;

  const Worker({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.companyName,
    required this.experienceYears,
    required this.email,
    required this.city,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.age,
    required this.address,
    required this.serviceName,
    required this.rating,
    required this.completedRequests,
    required this.isBlocked,
    required this.reviews,
    required this.portfolioItems,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    name,
    description,
    companyName,
    experienceYears,
    email,
    city,
    phoneNumber,
    profilePictureUrl,
    age,
    address,
    serviceName,
    rating,
    completedRequests,
    isBlocked,
    reviews,
    portfolioItems,
  ];
}

class Review extends Equatable {
  final int id;
  final int customerId;
  final String customerName;
  final String comment;
  final double rating;

  const Review({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.comment,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, customerId, customerName, comment, rating];
}

class PortfolioItem extends Equatable {
  final int id;
  final String name;
  final String description;
  final List<String> imageUrls;

  const PortfolioItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrls,
  });

  @override
  List<Object?> get props => [id, name, description, imageUrls];
}

