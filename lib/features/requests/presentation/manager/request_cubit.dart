import 'package:bloc/bloc.dart';
import 'package:home_service/features/requests/domain/usecases/add_review.dart';
import 'package:home_service/features/requests/domain/usecases/approve_final_offer.dart';
import 'package:home_service/features/requests/domain/usecases/complete_request.dart';
import 'package:home_service/features/requests/domain/usecases/get_customer_requests.dart';
import 'package:home_service/features/requests/presentation/manager/request_state.dart';
import '../../domain/usecases/send_request.dart';
import '../../domain/usecases/cancel_request.dart';



class RequestCubit extends Cubit<RequestState> {
  final SendRequest sendRequestUseCase;
  final CancelRequest cancelRequestUseCase;
  final GetCustomerRequests getCustomerRequestsUseCase;
  final CompleteRequest completeRequestUseCase;
  final AddReview addReviewUseCase;
  final ApproveFinalOffer approveFinalOfferUseCase;


  RequestCubit({
    required this.sendRequestUseCase,
    required this.cancelRequestUseCase,
    required this.getCustomerRequestsUseCase,
    required this.completeRequestUseCase,
    required this.addReviewUseCase,
    required this.approveFinalOfferUseCase,
  }) : super(RequestInitial());

  Future<void> sendRequest(int workerId, int projectId) async {
    emit(RequestLoading());
    final result = await sendRequestUseCase(SendRequestParams(workerId: workerId, projectId: projectId));
    result.fold(
      (failure) => emit(RequestError(failure.message ?? "Failed to send request")),
      (request) => emit(RequestSent(request)),
    );
  }

  Future<void> cancelRequest(int requestId) async {
    emit(RequestLoading());
    final result = await cancelRequestUseCase(CancelRequestParams(requestId: requestId));
    result.fold(
      (failure) => emit(RequestError(failure.message ?? "Failed to cancel request")),
      (request) => emit(RequestCancelled(request)),
    );
  }

Future<void> fetchCustomerRequests({int? status}) async {
  emit(RequestLoading());
  final result = await getCustomerRequestsUseCase(status);
  result.fold(
    (failure) => emit(RequestError(failure.message ?? "Failed to load requests")),
    (requests) => emit(RequestsLoaded(requests)),
  );
}

 Future<void> completeRequest(int requestId) async {
    emit(RequestLoading());
    final result = await completeRequestUseCase(CompleteRequestParams(requestId: requestId));
    result.fold(
      (failure) => emit(RequestError(failure.message ?? "Failed to complete request")),
      (request) => emit(RequestCompleted(request)),
    );
  }

   Future<void> addReview(int workerId, String comment, int rating) async {
    emit(RequestLoading());
    final result = await addReviewUseCase(AddReviewParams(
      workerId: workerId,
      comment: comment,
      rating: rating,
    ));
    result.fold(
      (failure) => emit(RequestError(failure.message ?? "Failed to add review")),
      (review) => emit(ReviewAdded(review)),
    );
  }

Future<void> approveFinalOffer(int requestId, bool isApprove) async {
  emit(RequestLoading());
  final result = await approveFinalOfferUseCase(ApproveFinalOfferParams(requestId: requestId, isApprove: isApprove));
  result.fold(
    (failure) => emit(RequestError(failure.message ?? "Failed to approve/reject offer")),
    (request) {
      if (isApprove) {
        emit(RequestApproved(request));
      } else {
        emit(RequestCancelled(request));
      }
    },
  );
}


}
