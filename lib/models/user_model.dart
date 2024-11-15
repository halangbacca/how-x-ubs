class User {
  int? id;
  String nomeCompleto;
  String dataNascimento;
  String cpf;
  String telefone;
  String email;
  String senha;
  String sus;
  String endereco;
  String unidadeSaude;

  User({
    this.id,
    required this.nomeCompleto,
    required this.dataNascimento,
    required this.cpf,
    required this.telefone,
    required this.email,
    required this.senha,
    required this.sus,
    required this.endereco,
    required this.unidadeSaude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeCompleto': nomeCompleto,
      'dataNascimento': dataNascimento,
      'cpf': cpf,
      'telefone': telefone,
      'email': email,
      'senha': senha,
      'sus': sus,
      'endereco': endereco,
      'unidadeSaude': unidadeSaude,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nomeCompleto: map['nomeCompleto'],
      dataNascimento: map['dataNascimento'],
      cpf: map['cpf'],
      telefone: map['telefone'],
      email: map['email'],
      senha: map['senha'],
      sus: map['sus'],
      endereco: map['endereco'],
      unidadeSaude: map['unidadeSaude'],
    );
  }
}
