// To parse this JSON data, do
//
//     final categoriasDart = categoriasDartFromJson(jsonString);

import 'dart:convert';

CategoriasDart categoriasDartFromJson(String str) => CategoriasDart.fromJson(json.decode(str));

String categoriasDartToJson(CategoriasDart data) => json.encode(data.toJson());

class CategoriasDart {
    List<ListadoCategoria> listadoCategorias;

    CategoriasDart({
        required this.listadoCategorias,
    });

    factory CategoriasDart.fromJson(Map<String, dynamic> json) => CategoriasDart(
        listadoCategorias: List<ListadoCategoria>.from(json["Listado Categorias"].map((x) => ListadoCategoria.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Listado Categorias": List<dynamic>.from(listadoCategorias.map((x) => x.toJson())),
    };
}

class ListadoCategoria {
    int categoryId;
    String categoryName;
    String categoryState;

    ListadoCategoria({
        required this.categoryId,
        required this.categoryName,
        required this.categoryState,
    });

    factory ListadoCategoria.fromJson(Map<String, dynamic> json) => ListadoCategoria(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryState: json["category_state"],
    );

    Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_state": categoryState,
    };

      ListadoCategoria copy() => ListadoCategoria(
       categoryId: categoryId,
       categoryName: categoryName,
       categoryState: categoryState,);
}
