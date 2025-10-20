class Cuidador {
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

  Cuidador({
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
      'endereco_id': addressId,
      'cpf': cpf,
      'nome': name,
      'email': email,
      'telefone': phone,
      'senha': password,
      'data_nascimento': birthDate?.toIso8601String().split('T')[0],
      'foto_url': photoUrl,
      'biografia': biography,
      'fumante': smokes,
      'tem_filhos': hasChildren,
      'possui_cnh': hasDrivingLicense,
      'tem_carro': hasCar,
    };
  }

  factory Cuidador.fromJson(Map<String, dynamic> json) {
    return Cuidador(
      id: json['id'],
      addressId: json['endereco_id'],
      cpf: json['cpf'],
      name: json['nome'],
      email: json['email'],
      phone: json['telefone'],
      password: json['senha'],
      birthDate: json['data_nascimento'] != null
          ? DateTime.parse(json['data_nascimento'])
          : null,
      photoUrl: json['foto_url'],
      biography: json['biografia'],
      smokes: json['fumante'],
      hasChildren: json['tem_filhos'],
      hasDrivingLicense: json['possui_cnh'],
      hasCar: json['tem_carro'],
    );
  }

  Cuidador copyWith({
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
    return Cuidador(
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
