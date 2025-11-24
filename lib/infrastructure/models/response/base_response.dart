class BaseResponse<T> {
  final bool success;
  final int statusCode;
  final String statusMessage;
  final T? data;

  const BaseResponse({
    required this.success,
    required this.statusCode,
    required this.statusMessage,
    this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return BaseResponse<T>(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      statusMessage: json['statusMessage'] ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}
