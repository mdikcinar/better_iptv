import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'base_state.dart';

class BaseCubit<State extends BaseState> extends Cubit<State> {
  BaseCubit(super.initialState);
}
