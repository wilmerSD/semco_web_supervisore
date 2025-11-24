class ResponseGeneralModel {
    bool succes;
    int? statusCode;
    String? statusMessage;

    ResponseGeneralModel({
        required this.succes,
        this.statusCode,
        this.statusMessage,
    });

    factory ResponseGeneralModel.fromJson(Map<String, dynamic> json) => ResponseGeneralModel(
        succes: json["succes"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
    );

    Map<String, dynamic> toJson() => {
        "succes": succes,
        "statusCode": statusCode,
        "statusMessage": statusMessage,
    };
}