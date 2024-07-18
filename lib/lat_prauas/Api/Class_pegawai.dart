class Pegawai {
  final int id;
  final String noBp;
  final String noHp;
  final String email;

  Pegawai({
    required this.id,
    required this.noBp,
    required this.noHp,
    required this.email,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      id: json['id'] as int,
      noBp: json['no_bp'] as String,
      noHp: json['no_hp'] as String,
      email: json['email'] as String,
    );
  }
}
