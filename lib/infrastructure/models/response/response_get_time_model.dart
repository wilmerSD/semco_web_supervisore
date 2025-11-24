class ResponseGetTimeModel {
    bool? success;
    int? statusCode;
    String? statusMessage;
    String? data;

    ResponseGetTimeModel({
        this.success,
        this.statusCode,
        this.statusMessage,
        this.data,
    });

    factory ResponseGetTimeModel.fromJson(Map<String, dynamic> json) => ResponseGetTimeModel(
        success: json["success"],
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        data: json["data"],
    );
}