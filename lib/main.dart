import 'package:cryptocurrency/core/constants/app/app_constants.dart';
import 'package:cryptocurrency/core/init/navigator/app_router.dart';
import 'package:cryptocurrency/core/init/navigator/routes.dart';
import 'package:cryptocurrency/core/init/theme/app_theme/app_theme_dark.dart';
import 'package:cryptocurrency/product/bloc/coin/coin_bloc.dart';
import 'package:cryptocurrency/product/bloc/price/price_bloc.dart';
import 'package:cryptocurrency/product/repository/coin_repository.dart';
import 'package:cryptocurrency/product/service/coin_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CoinBloc(repository: CoinRepository(service: CoinService())),
        ),
        BlocProvider(
          create: (context) =>
              PriceBloc(repository: CoinRepository(service: CoinService())),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appTitle,
        theme: AppThemeDark.instance!.appTheme,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: homeRoute,
      ),
    );
  }
}
