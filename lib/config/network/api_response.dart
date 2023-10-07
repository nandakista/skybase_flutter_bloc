class ApiResponse<T> {
  final bool success;
  final String message;
  final int status;
  final String? error;
  final T? data;
  final Meta? meta;

  ApiResponse({
    required this.success,
    required this.message,
    required this.status,
    this.meta,
    this.error,
    this.data,
  });

  factory ApiResponse.fromJson(Map<dynamic, dynamic> json) {
    late bool isErrorNotEmpty;
    if (json['error'] is List) {
      isErrorNotEmpty = (json['error'] as List).isNotEmpty;
    } else {
      isErrorNotEmpty = json['error'] != null;
    }

    return ApiResponse(
      success: json['success'],
      error: isErrorNotEmpty ? json['error'] : json['message'],
      data: (json['data'] != null) ? json['data'] : null,
      message: json['message'],
      status: json['status'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }
}

class Meta {
  final int? from;
  final int? to;
  final int? currentPage;
  final int? lastPage;
  final int? perPage;
  final int? total;

  Meta({
    this.from,
    this.to,
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    from: json["from"],
    to: json["to"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
    "total": total,
  };
}
