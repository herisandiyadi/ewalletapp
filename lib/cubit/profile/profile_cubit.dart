import 'package:ewallet_app/models/profile_response.dart';
import 'package:ewallet_app/models/update_request.dart';
import 'package:ewallet_app/models/update_response.dart';
import 'package:ewallet_app/services/profile/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;
  ProfileCubit(this.profileRepository) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final result = await profileRepository.getProfile();
      emit(ProfileLoaded(result));
    } catch (e) {
      emit(ProfileFailed(e.toString()));
    }
  }

  Future<void> updateProfile(UpdateRequest request) async {
    emit(ProfileLoading());
    try {
      final result = await profileRepository.updateProfile(request);
      emit(UpdateProfileLoaded(result));
    } catch (e) {
      emit(ProfileFailed(e.toString()));
    }
  }
}
