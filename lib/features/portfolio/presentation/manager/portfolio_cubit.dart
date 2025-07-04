import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import 'package:home_service/features/portfolio/domain/entities/project.dart';
import 'package:home_service/features/portfolio/domain/usecases/add_portfolio.dart';
import 'package:home_service/features/portfolio/domain/usecases/add_portfolio_images.dart';
import 'package:home_service/features/portfolio/domain/usecases/delete_portfolio.dart';
import 'package:home_service/features/portfolio/domain/usecases/get_portfolios.dart';
import 'package:home_service/features/portfolio/domain/usecases/update_portfolio.dart';
import 'dart:io';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final AddPortfolio addPortfolioUseCase;
  final UpdatePortfolio updatePortfolioUseCase;
  final AddPortfolioImages addPortfolioImagesUseCase;
  final GetPortfolios getPortfoliosUseCase;
  final DeletePortfolio deletePortfolioUseCase;

  PortfolioCubit({
    required this.addPortfolioUseCase,
    required this.updatePortfolioUseCase,
    required this.addPortfolioImagesUseCase,
    required this.getPortfoliosUseCase,
    required this.deletePortfolioUseCase,
  }) : super(PortfolioInitial());

Future<void> addPortfolio({
  required String name,
  required String description,
  required List<File> images,
}) async {
  emit(PortfolioLoading());
  final failureOrSuccess = await addPortfolioUseCase(
    AddPortfolioParams(name: name, description: description, images: images),
  );
  failureOrSuccess.fold(
    (failure) => emit(PortfolioError(_mapFailureToMessage(failure))),
    (message) => emit(PortfolioActionSuccess(message)), // <--- use new state here!
  );
}


  Future<void> updatePortfolio(int id, String name, String description) async {
    emit(PortfolioLoading());
    final failureOrSuccess = await updatePortfolioUseCase(UpdatePortfolioParams(id: id, name: name, description: description));
    failureOrSuccess.fold(
      (failure) => emit(PortfolioError(_mapFailureToMessage(failure))),
      (success) => emit(PortfolioUpdated(success)),
    );
  }

  Future<void> addPortfolioImages(int id, List<File> images) async {
    emit(PortfolioLoading());
    final failureOrSuccess = await addPortfolioImagesUseCase(AddPortfolioImagesParams(id: id, images: images));
    failureOrSuccess.fold(
      (failure) => emit(PortfolioError(_mapFailureToMessage(failure))),
      (success) => emit(PortfolioImagesAdded(success)),
    );
  }

  Future<void> getPortfolios() async {
    emit(PortfolioLoading());
    final failureOrPortfolios = await getPortfoliosUseCase(NoParams());
    failureOrPortfolios.fold(
      (failure) => emit(PortfolioError(_mapFailureToMessage(failure))),
      (portfolios) => emit(PortfolioLoaded(portfolios)),
    );
  }

  Future<void> deletePortfolio(int id) async {
    emit(PortfolioLoading());
    final failureOrSuccess = await deletePortfolioUseCase(id);
    failureOrSuccess.fold(
      (failure) => emit(PortfolioError(_mapFailureToMessage(failure))),
      (success) => emit(PortfolioDeleted(success)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      case NetworkFailure:
        return 'Network Failure';
      default:
        return 'Unexpected Error';
    }
  }
}


