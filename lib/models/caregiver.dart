class Caregiver {
  final int? id;
  final int? addressId;
  final String? cpf;
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final DateTime? birthDate;
  final String? photoUrl;
  final String? biography;
  final String? smokes;
  final String? hasChildren;
  final String? hasDrivingLicense;
  final String? hasCar;

  Caregiver({
    this.id,
    this.addressId,
    this.cpf,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.birthDate,
    this.photoUrl,
    this.biography,
    this.smokes = 'Não',
    this.hasChildren = 'Não',
    this.hasDrivingLicense = 'Não',
    this.hasCar = 'Não',
  });

  Map<String, dynamic> toJson() {
    return {
      'IdEndereco': addressId,
      'Cpf': cpf,
      'Nome': name,
      'Email': email,
      'Telefone': phone,
      'Senha': password,
      'DataNascimento': birthDate?.toIso8601String().split('T')[0],
      'FotoUrl': photoUrl,
      'Biografia': biography,
      'Fumante': smokes,
      'TemFilhos': hasChildren,
      'PossuiCNH': hasDrivingLicense,
      'TemCarro': hasCar,
    };
  }

  factory Caregiver.fromJson(Map<String, dynamic> json) {
    return Caregiver(
      id: json['IdCuidador'],
      addressId: json['IdEndereco'],
      cpf: json['Cpf'],
      name: json['Nome'],
      email: json['Email'],
      phone: json['Telefone'],
      password: json['Senha'],
      birthDate: json['DataNascimento'] != null
          ? DateTime.parse(json['DataNascimento'])
          : null,
      photoUrl: json['FotoUrl'],
      biography: json['Biografia'],
      smokes: json['Fumante'],
      hasChildren: json['TemFilhos'],
      hasDrivingLicense: json['PossuiCNH'],
      hasCar: json['TemCarro'],
    );
  }

  Caregiver copyWith({
    int? id,
    int? addressId,
    String? cpf,
    String? name,
    String? email,
    String? phone,
    String? password,
    DateTime? birthDate,
    String? photoUrl,
    String? biography,
    String? smokes,
    String? hasChildren,
    String? hasDrivingLicense,
    String? hasCar,
  }) {
    return Caregiver(
      id: id ?? this.id,
      addressId: addressId ?? this.addressId,
      cpf: cpf ?? this.cpf,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      birthDate: birthDate ?? this.birthDate,
      photoUrl: photoUrl ?? this.photoUrl,
      biography: biography ?? this.biography,
      smokes: smokes ?? this.smokes,
      hasChildren: hasChildren ?? this.hasChildren,
      hasDrivingLicense: hasDrivingLicense ?? this.hasDrivingLicense,
      hasCar: hasCar ?? this.hasCar,
    );
  }
}
