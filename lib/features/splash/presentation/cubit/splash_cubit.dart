
import '../../../../core/global/global_static_strings.dart';
import '../../../../core/widgets/globally_used_widgets.dart';
import '../../domain/entities/getStaticStrings_splash_params_entity.dart';
import '../../domain/usecases/getStaticStrings_splash_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import './splash_state.dart';


class SplashCubit extends Cubit<SplashState> {
  Future<void> getstaticstringsSplash(GetstaticstringsSplashParamsEntity params) async {
    emit(SplashLoading());
    _getstaticstringsSplashUseCase.call(params).listen((event) {
      event.fold((fail) {
        emit(GetstaticstringsSplashError(fail.toString()));
      }, (success) async {
        print('success');
        print(success.message);
        GlobalStaticStrings.updateStaticStrings(success.data!);
        await storeStringsInSharedPreference('is_app_language_selected_by_user',params.lang);
        emit(GetstaticstringsSplashSuccess(success.message,success.data!));
      });
    });
  }

  final GetstaticstringsSplashUseCase _getstaticstringsSplashUseCase;

  // Initialize use cases or repository here

  SplashCubit( this._getstaticstringsSplashUseCase,) : super(InitialSplashState());

  // Add methods here
}
