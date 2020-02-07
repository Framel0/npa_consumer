import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:npa_user/model/consumer_product.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/consumer_product/consumer_product.dart';

class ConsumerProductRepository {
  final ConsumerProductApiClient consumerProductApiClient;
  List<ConsumerProduct> _consumerProducts = [];

  ConsumerProductRepository({@required this.consumerProductApiClient});

  Future getConsumerProducts({@required int userId}) async {
    _consumerProducts =
        await consumerProductApiClient.fetchConsumerProducts(userId: userId);
  }

  Future addNewConsumerProducts(
      {@required AddNewCylinderRequest cylinderRequest}) async {
    await consumerProductApiClient.addNewConsumerProducts(
        cylinderRequest: cylinderRequest);
  }

  List<ConsumerProduct> get consumerConsumerProducts {
    return List.from(_consumerProducts);
  }
}
