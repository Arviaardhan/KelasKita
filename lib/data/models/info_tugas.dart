// To parse this JSON data, do
//
//     final infoTugasModel = infoTugasModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<InfoTugasModel> infoTugasModelFromJson(String str) => List<InfoTugasModel>.from(json.decode(str).map((x) => InfoTugasModel.fromJson(x)));

String infoTugasModelToJson(List<InfoTugasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoTugasModel {
  int idTugas;
  int idKelas;
  String nama;
  String guru;
  DateTime deadline;
  String ketentuan;
  DateTime createdAt;
  DateTime updatedAt;

  InfoTugasModel({
    required this.idTugas,
    required this.idKelas,
    required this.nama,
    required this.guru,
    required this.deadline,
    required this.ketentuan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InfoTugasModel.fromJson(Map<String, dynamic> json) => InfoTugasModel(
    idTugas: json["id_tugas"],
    idKelas: json["id_kelas"],
    nama: json["nama"],
    guru: json["guru"],
    deadline: DateTime.parse(json["deadline"]),
    ketentuan: json["ketentuan"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_tugas": idTugas,
    "id_kelas": idKelas,
    "nama": nama,
    "guru": guru,
    "deadline": "${deadline.year.toString().padLeft(4, '0')}-${deadline.month.toString().padLeft(2, '0')}-${deadline.day.toString().padLeft(2, '0')}",
    "ketentuan": ketentuan,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
