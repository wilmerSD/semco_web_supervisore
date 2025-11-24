class ParticipantModel {
    final String? personalId;
    final String? fullName;
    final String? rol;
    final String? state;

    ParticipantModel({
        this.personalId,
        this.fullName,
        this.rol,
        this.state,
    });

    factory ParticipantModel.fromJson(Map<String, dynamic> json) => ParticipantModel(
        personalId: json["personalId"],
        fullName: json["fullName"],
        rol: json["rol"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "personalId": personalId,
        "fullName": fullName,
        "rol": rol,
        "state": state,
    };
}