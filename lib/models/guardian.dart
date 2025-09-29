class Guardian {
  final int? id;
  final int? addressId;
  final String? cpf;
  final String? name;
  final String? email;
  final String? phone;
  final DateTime? birthDate;
  final String? photoUrl;

  Guardian({
    this.id,
    this.addressId,
    this.cpf,
    this.name,
    this.email,
    this.phone,
    this.birthDate,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'IdEndereco': addressId,
      'Cpf': cpf,
      'Nome': name,
      'Email': email,
      'Telefone': phone,
      'DataNascimento': birthDate?.toIso8601String().split('T')[0],
      'FotoUrl': photoUrl,
    };
  }

  factory Guardian.fromJson(Map<String, dynamic> json) {
    return Guardian(
      id: json['IdResponsavel'],
      addressId: json['IdEndereco'],
      cpf: json['Cpf'],
      name: json['Nome'],
      email: json['Email'],
      phone: json['Telefone'],
      birthDate: json['DataNascimento'] != null
          ? DateTime.parse(json['DataNascimento'])
          : null,
      photoUrl: json['FotoUrl'],
    );
  }

  Guardian copyWith({
    int? id,
    int? addressId,
    String? cpf,
    String? name,
    String? email,
    String? phone,
    DateTime? birthDate,
    String? photoUrl,
  }) {
    return Guardian(
      id: id ?? this.id,
      addressId: addressId ?? this.addressId,
      cpf: cpf ?? this.cpf,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
