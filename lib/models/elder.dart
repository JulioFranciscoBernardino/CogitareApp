class Elder {
  final int? id;
  final int? guardianId;
  final int? mobilityId;
  final int? autonomyLevelId;
  final String? name;
  final DateTime? birthDate;
  final String? gender;
  final String? medicalCare;
  final String? extraDescription;
  final String? photoUrl;

  Elder({
    this.id,
    this.guardianId,
    this.mobilityId,
    this.autonomyLevelId,
    this.name,
    this.birthDate,
    this.gender,
    this.medicalCare,
    this.extraDescription,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'IdResponsavel': guardianId,
      'IdMobilidade': mobilityId,
      'IdNivelAutonomia': autonomyLevelId,
      'Nome': name,
      'DataNascimento': birthDate?.toIso8601String().split('T')[0],
      'Sexo': gender,
      'CuidadosMedicos': medicalCare,
      'DescricaoExtra': extraDescription,
      'FotoUrl': photoUrl,
    };
  }

  factory Elder.fromJson(Map<String, dynamic> json) {
    return Elder(
      id: json['IdIdoso'],
      guardianId: json['IdResponsavel'],
      mobilityId: json['IdMobilidade'],
      autonomyLevelId: json['IdNivelAutonomia'],
      name: json['Nome'],
      birthDate: json['DataNascimento'] != null
          ? DateTime.parse(json['DataNascimento'])
          : null,
      gender: json['Sexo'],
      medicalCare: json['CuidadosMedicos'],
      extraDescription: json['DescricaoExtra'],
      photoUrl: json['FotoUrl'],
    );
  }

  Elder copyWith({
    int? id,
    int? guardianId,
    int? mobilityId,
    int? autonomyLevelId,
    String? name,
    DateTime? birthDate,
    String? gender,
    String? medicalCare,
    String? extraDescription,
    String? photoUrl,
  }) {
    return Elder(
      id: id ?? this.id,
      guardianId: guardianId ?? this.guardianId,
      mobilityId: mobilityId ?? this.mobilityId,
      autonomyLevelId: autonomyLevelId ?? this.autonomyLevelId,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      medicalCare: medicalCare ?? this.medicalCare,
      extraDescription: extraDescription ?? this.extraDescription,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
