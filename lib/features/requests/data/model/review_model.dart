import '../../domain/entities/review_entity.dart';

class ReviewModel extends Review {
  const ReviewModel({
    int? id,
    required int workerId,
    required String customerName,
    required String workerName,
    required String comment,
    required int rating,
  }) : super(
          id: id,
          workerId: workerId,
          customerName: customerName,
          workerName: workerName,
          comment: comment,
          rating: rating,
        );

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      workerId: json['workerId'] ?? 0,
      customerName: json['customerName'] ?? '',
      workerName: json['workerName'] ?? '',
      comment: json['comment'] ?? '',
      rating: json['rating'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workerId': workerId,
      'comment': comment,
      'rating': rating,
    };
  }
}
