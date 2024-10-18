import 'dart:convert';


ProveedoresDart proveedoresDartFromJson(String str) => ProveedoresDart.fromJson(json.decode(str));

String proveedoresDartToJson(ProveedoresDart data) => json.encode(data.toJson());

class ProveedoresDart {
    List<ListadoProveedor> listadoProveedores;

    ProveedoresDart({
        required this.listadoProveedores,
    });

    factory ProveedoresDart.fromJson(Map<String, dynamic> json) => ProveedoresDart(
        listadoProveedores: List<ListadoProveedor>.from(json["Proveedores Listado"].map((x) => ListadoProveedor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Proveedores Listado": List<dynamic>.from(listadoProveedores.map((x) => x.toJson())),
    };
}

class ListadoProveedor {
    int providerId;
    String providerName;
    String providerLastName;
    String providerMail;
    String providerState;

    ListadoProveedor({
        required this.providerId,
        required this.providerName,
        required this.providerLastName,
        required this.providerMail,
        required this.providerState,
    });

    factory ListadoProveedor.fromJson(Map<String, dynamic> json) => ListadoProveedor(
        providerId: json["providerid"],
        providerName: json["provider_name"],
        providerLastName: json["provider_last_name"],
        providerMail: json["provider_mail"],
        providerState: json["provider_state"],
    );

    Map<String, dynamic> toJson() => {
        "provider_id": providerId,
        "provider_name": providerName,
        "provider_last_name": providerLastName,
        "provider_mail": providerMail,
        "provider_state": providerState,
    };

    ListadoProveedor copy() => ListadoProveedor(
        providerId: providerId,
        providerName: providerName,
        providerLastName: providerLastName,
        providerMail: providerMail,
        providerState: providerState,
    );
}
