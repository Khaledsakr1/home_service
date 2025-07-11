// features/worker_search/presentation/manager/worker_search_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/search_workers.dart';

part 'worker_search_state.dart';

class WorkerSearchCubit extends Cubit<WorkerSearchState> {
  final SearchWorkers searchWorkersUseCase;

  WorkerSearchCubit({required this.searchWorkersUseCase}) : super(WorkerSearchInitial());

  Future<void> search(String query, {int topK = 5, String? city}) async {
    emit(WorkerSearchLoading());
    final result = await searchWorkersUseCase(SearchWorkersParams(query: query, topK: topK, preferredCity: city));
    result.fold(
      (failure) => emit(WorkerSearchError('Search failed')),
      (workerIds) => emit(WorkerSearchLoaded(workerIds)),
    );
  }

  void clear() {
  emit(WorkerSearchInitial());
}

}
