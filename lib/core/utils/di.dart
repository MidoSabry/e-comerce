import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/cubit/cubit/auth_cubit.dart';
import '../../features/home/presentation/cubit/cubit/home_cubit.dart';



GetIt di = GetIt.instance;

Future<void> initializeDependency() async {
   di.registerLazySingleton<AuthCubit>(() => AuthCubit());
   di.registerLazySingleton<HomeCubit>(() => HomeCubit());
}
