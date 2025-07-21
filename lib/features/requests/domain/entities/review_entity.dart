class Review {
  final int? id;
  final int workerId;
  final String customerName;
  final String workerName;
  final String comment;
  final int rating;

  const Review({
    this.id,
    required this.workerId,
    required this.customerName,
    required this.workerName,
    required this.comment,
    required this.rating,
  });
}