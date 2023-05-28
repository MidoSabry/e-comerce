import 'package:ecomerce/features/cart/presentation/cubit/cubit/cart_cubit.dart';
import 'package:ecomerce/features/product/presentation/cubit/cubit/product_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/cubit/cubit/auth_cubit.dart';
import '../../features/home/presentation/cubit/cubit/home_cubit.dart';

GetIt di = GetIt.instance;

Future<void> initializeDependency() async {
  di.registerLazySingleton<AuthCubit>(() => AuthCubit());
  di.registerLazySingleton<HomeCubit>(() => HomeCubit());
  di.registerLazySingleton<ProductCubit>(() => ProductCubit());
  di.registerLazySingleton<CartCubit>(() => CartCubit());
}
