class Product {
  int id;
  String nombre;
  int valorNeto;
  int valorBruto;
  int cantidad;

  Product({
    this.id,
    this.nombre,
    this.valorNeto,
    this.valorBruto,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': nombre,
      'netCost': valorNeto,
      'grossCost': valorBruto
    };
    return map;
  }

  Product.fromMap(Map<String, dynamic> map, int q) {
    id = map['id'];
    nombre = map['name'];
    valorNeto = map['netCost'];
    valorBruto = map['grossCost'];
    cantidad = q;
  }
}
