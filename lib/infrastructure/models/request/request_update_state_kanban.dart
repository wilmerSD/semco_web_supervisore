class RequestUpdateStateKanban {
    String? pCampanaId;
    String? pClienteId;
    String? pCompaniaId;
    String? pState;
    String? pOrdenProduccionId;

    RequestUpdateStateKanban({
        this.pCampanaId,
        this.pClienteId,
        this.pCompaniaId,
        this.pState,
        this.pOrdenProduccionId,
    });

    factory RequestUpdateStateKanban.fromJson(Map<String, dynamic> json) => RequestUpdateStateKanban(
        pCampanaId: json["pCampanaId"],
        pClienteId: json["pClienteId"],
        pCompaniaId: json["pCompaniaId"],
        pState: json["pState"],
        pOrdenProduccionId: json["pOrdenProduccionId"],
    );

    Map<String, dynamic> toJson() => {
        "iCampanaId": pCampanaId,
        "iClienteId": pClienteId,
        "iCompaniaId": pCompaniaId,
        "iState": pState,
        "iOrdenproduccionId": pOrdenProduccionId,
    };
}
