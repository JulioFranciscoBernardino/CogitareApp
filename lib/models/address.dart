class Address {
  final int? id;
  final String? city;
  final String? neighborhood;
  final String? street;
  final String? number;
  final String? complement;
  final String? zipCode;

  Address({
    this.id,
    this.city,
    this.neighborhood,
    this.street,
    this.number,
    this.complement,
    this.zipCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'Cidade': city,
      'Bairro': neighborhood,
      'Rua': street,
      'Numero': number,
      'Complemento': complement,
      'Cep': zipCode,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['IdEndereco'],
      city: json['Cidade'],
      neighborhood: json['Bairro'],
      street: json['Rua'],
      number: json['Numero'],
      complement: json['Complemento'],
      zipCode: json['Cep'],
    );
  }
}
