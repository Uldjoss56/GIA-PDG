import 'dart:convert';

class ProductAuthData {
    final bool? status;
    final String? message;
    final Product? product;

    ProductAuthData({
        this.status,
        this.message,
        this.product,
    });

    factory ProductAuthData.fromRawJson(String str) => ProductAuthData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductAuthData.fromJson(Map<String, dynamic> json) => ProductAuthData(
        status: json["status"],
        message: json["message"],
        product: json["Product"] == null ? null : Product.fromJson(json["Product"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Product": product?.toJson(),
    };
}

class ProductData {
    final bool? status;
    final String? message;
    final List<Product>? products;

    ProductData({
        this.status,
        this.message,
        this.products,
    });

    factory ProductData.fromRawJson(String str) => ProductData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        status: json["status"],
        message: json["message"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    };
}

class Product {
    final int? id;
    final String? refProduit;
    final String? picture;
    final String? isActived;
    final DateTime? activedDate;
    final String? isAssociatedWith;
    final int? idCmd;
    final int? idSeller;
    final int? idBuyers;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final DateTime? expirateAt;

    Product({
        this.id,
        this.refProduit,
        this.picture,
        this.isActived,
        this.activedDate,
        this.isAssociatedWith,
        this.idCmd,
        this.idSeller,
        this.idBuyers,
        this.createdAt,
        this.updatedAt,
        this.expirateAt,
    });

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        refProduit: json["ref_produit"],
        picture: json["picture"],
        isActived: json["is_actived"],
        activedDate: json["actived_date"] == null ? null : DateTime.parse(json["actived_date"]),
        isAssociatedWith: json["is_associated_with"],
        idCmd: json["id_cmd"],
        idSeller: json["id_seller"],
        idBuyers: json["id_buyers"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        expirateAt: json["expirate_at"] == null ? null : DateTime.parse(json["expirate_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ref_produit": refProduit,
        "picture": picture,
        "is_actived": isActived,
        "actived_date": activedDate?.toIso8601String(),
        "is_associated_with": isAssociatedWith,
        "id_cmd": idCmd,
        "id_seller": idSeller,
        "id_buyers": idBuyers,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "expirate_at": expirateAt?.toIso8601String(),
    };
}

