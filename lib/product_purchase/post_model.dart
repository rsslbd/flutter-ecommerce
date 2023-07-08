// To parse this JSON data, do
//
//     final purchaseModel = purchaseModelFromJson(jsonString);

import 'dart:convert';

PurchaseModel purchaseModelFromJson(String str) => PurchaseModel.fromJson(json.decode(str));
List<PurchaseModel>purchaseFromJson(String str)=>List<PurchaseModel>.from(json.decode(str).map((x)=>PurchaseModel.fromJson(x)));
String purchaseModelToJson(PurchaseModel data) => json.encode(data.toJson());

class PurchaseModel {
    int? id;
    String? catagory;
    String? subCatagory;
    String? brandName;
    String? productName;
    String? sku;
    String? supplierName;
    String? status;
    int? qty;
    String? unit;
    int? purchasePrice;
    int? total;
    int? paid;
    String? paymentStatus;
    String? date;

    PurchaseModel({
        this.id,
        this.catagory,
        this.subCatagory,
        this.brandName,
        this.productName,
        this.sku,
        this.supplierName,
        this.status,
        this.qty,
        this.unit,
        this.purchasePrice,
        this.total,
        this.paid,
        this.paymentStatus,
        this.date,
    });

    factory PurchaseModel.fromJson(Map<String, dynamic> json) => PurchaseModel(
        id: json["id"],
        catagory: json["catagory"],
        subCatagory: json["sub_catagory"],
        brandName: json["brand_name"],
        productName: json["product_name"],
        sku: json["sku"],
        supplierName: json["supplier_name"],
        status: json["status"],
        qty: json["qty"],
        unit: json["unit"],
        purchasePrice: json["purchase_price"],
        total: json["total"],
        paid: json["paid"],
        paymentStatus: json["payment_status"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "catagory": catagory,
        "sub_catagory": subCatagory,
        "brand_name": brandName,
        "product_name": productName,
        "sku": sku,
        "supplier_name": supplierName,
        "status": status,
        "qty": qty,
        "unit": unit,
        "purchase_price": purchasePrice,
        "total": total,
        "paid": paid,
        "payment_status": paymentStatus,
        "date": date,
    };
}
