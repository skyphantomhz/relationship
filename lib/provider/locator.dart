import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:relationship/repositories/dao/relationshipdao.dart';
import 'package:relationship/repositories/filerepository.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton<RelationShipDao>(() => RelationShipDao());
  getIt.registerLazySingleton<FileRepository>(() => FileRepository());
  getIt.registerLazySingleton<JsonDecoder>(() => JsonDecoder());
  getIt.registerLazySingleton<JsonEncoder>(() => JsonEncoder());
}