import 'package:ecomerce/features/cart/presentation/cubit/cubit/cart_cubit.dart';
import 'package:ecomerce/features/product/presentation/cubit/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'core/utils/di.dart';
import 'features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/home/presentation/cubit/cubit/home_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => di<AuthCubit>(),
        ),
        BlocProvider<HomeCubit>(
            create: (context) => di<HomeCubit>()
              ..getListOfCategories()
              ..getProductsListWithLimit()),
        BlocProvider<ProductCubit>(
          create: (context) => di<ProductCubit>(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => di<CartCubit>(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: AppRoutes.navigatorKey,
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        builder: (context, child) {
          return MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
        home: SplashScreen(),
      ),
    );
  }
}
