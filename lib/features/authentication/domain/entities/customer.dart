import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String email;
  final String password;
  final String? fullName;
  final String? phoneNumber;
  final String? address;

  const Customer({
    required this.email,
    required this.password,
    this.fullName,
    this.phoneNumber,
    this.address,
  });

  @override
  List<Object?> get props => [email, password, fullName, phoneNumber, address];
}


