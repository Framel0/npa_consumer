import 'package:npa_user/model/add_new_cylinder_request_product.dart';

class AddNewCylinderRequest {
  int consumerId;
  List<AddNewCylinderRequestProduct> addNewCylinderRequestProduct;

  Map<String, dynamic> toJson() => {
        "consumerId": consumerId,
        "consumerProduct":
            addNewCylinderRequestProduct.map((p) => p.toJson()).toList()
      };
}
