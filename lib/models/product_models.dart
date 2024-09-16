class ProductModels {
  final String id;
  final String ProductName;
  final String ProductCode;
  final String Img;
  final String Qty;
  final String TotalPrice;
  final String CreatedDate;

  ProductModels(
      {required this.id,
      required this.ProductName,
      required this.ProductCode,
      required this.Img,
      required this.Qty,
      required this.TotalPrice,
      required this.CreatedDate});
}
