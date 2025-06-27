
part of 'portfolio_cubit.dart';

abstract class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object> get props => [];
}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioActionSuccess extends PortfolioState {
  final String message;
  const PortfolioActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}


class PortfolioAdded extends PortfolioState {
  final String message;

  const PortfolioAdded(this.message);

  @override
  List<Object> get props => [message];
}

class PortfolioUpdated extends PortfolioState {
  final bool success;

  const PortfolioUpdated(this.success);

  @override
  List<Object> get props => [success];
}

class PortfolioImagesAdded extends PortfolioState {
  final bool success;

  const PortfolioImagesAdded(this.success);

  @override
  List<Object> get props => [success];
}

class PortfolioLoaded extends PortfolioState {
  final List<Project> portfolios;

  const PortfolioLoaded(this.portfolios);

  @override
  List<Object> get props => [portfolios];
}

class PortfolioDeleted extends PortfolioState {
  final bool success;

  const PortfolioDeleted(this.success);

  @override
  List<Object> get props => [success];
}

class PortfolioError extends PortfolioState {
  final String message;

  const PortfolioError(this.message);

  @override
  List<Object> get props => [message];
}


