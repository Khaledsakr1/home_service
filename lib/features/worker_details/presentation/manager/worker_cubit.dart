// features/worker/presentation/manager/worker_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:home_service/features/worker_details/presentation/manager/worker_state.dart';
import '../../domain/usecases/get_worker_by_id.dart';


class WorkerCubit extends Cubit<WorkerState> {
  final GetWorkerById getWorkerByIdUseCase;

  WorkerCubit({required this.getWorkerByIdUseCase}) : super(WorkerInitial());

  Future<void> fetchWorker(int id) async {
    emit(WorkerLoading());
    final result = await getWorkerByIdUseCase(id);
    result.fold(
      (failure) => emit(WorkerError('Failed to fetch worker')),
      (worker) => emit(WorkerLoaded(worker)),
    );
  }
}
