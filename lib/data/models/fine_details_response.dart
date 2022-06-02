import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:lms1/data/models/user_detail_response.dart';

class CollectFineDetailResposne extends Equatable {
  final FineDataModel fineData;
  final List<FineHistoryModel> fineHistory;

  const CollectFineDetailResposne(this.fineData, this.fineHistory);

  @override
  List<Object?> get props => [fineData, fineHistory];
}

class FineDetailResponse extends Equatable {
  final bool success;
  final FineDataModel fineData;
  const FineDetailResponse({
    required this.success,
    required this.fineData,
  });

  FineDetailResponse copyWith({
    bool? success,
    FineDataModel? fineData,
  }) {
    return FineDetailResponse(
      success: success ?? this.success,
      fineData: fineData ?? this.fineData,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'success': success});
    result.addAll({'fineData': fineData.toMap()});

    return result;
  }

  factory FineDetailResponse.fromMap(Map<String, dynamic> map) {
    return FineDetailResponse(
      success: map['success'] ?? false,
      fineData: FineDataModel.fromMap(map['fineData']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FineDetailResponse.fromJson(String source) =>
      FineDetailResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'FineDetailResponse(success: $success, fineData: $fineData)';

  @override
  List<Object> get props => [success, fineData];
}

class FineDataModel extends Equatable {
  final String id;
  final String email;
  final String fine;
  const FineDataModel({
    required this.id,
    required this.email,
    required this.fine,
  });

  FineDataModel copyWith({
    String? id,
    String? email,
    String? fine,
  }) {
    return FineDataModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fine: fine ?? this.fine,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'_id': id});
    result.addAll({'email': email});
    result.addAll({'fine': fine});

    return result;
  }

  factory FineDataModel.fromMap(Map<String, dynamic> map) {
    return FineDataModel(
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      fine: map['fine']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FineDataModel.fromJson(String source) =>
      FineDataModel.fromMap(json.decode(source));

  @override
  String toString() => 'FineDataModel(id: $id, email: $email, fine: $fine)';

  @override
  List<Object> get props => [id, email, fine];
}

class FineHistoryResponse extends Equatable {
  final bool success;
  final List<FineHistoryModel> fineHistory;
  const FineHistoryResponse({
    required this.success,
    required this.fineHistory,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'success': success});
    result.addAll({'finehistory': fineHistory.map((x) => x.toMap()).toList()});

    return result;
  }

  factory FineHistoryResponse.fromMap(Map<String, dynamic> map) {
    return FineHistoryResponse(
      success: map['success'] ?? false,
      fineHistory: List<FineHistoryModel>.from(
          map['finehistory']?.map((x) => FineHistoryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FineHistoryResponse.fromJson(String source) =>
      FineHistoryResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'FineHistoryResponse(success: $success, fineHistory: $fineHistory)';

  @override
  List<Object> get props => [success, fineHistory];
}
