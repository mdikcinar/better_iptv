import 'package:equatable/equatable.dart';

/// A generic class that holds a value with its current status.
///
/// Used in Bloc/Cubit states to represent a value that can be null.
class Nullable<T> extends Equatable {
  const Nullable(this.value);

  const Nullable.empty() : value = null;

  final T? value;

  bool get isNull => value == null;
  bool get isNotNull => value != null;

  @override
  List<Object?> get props => [value];
}
