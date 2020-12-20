class Simulado {
  final String title;
  final List<String> quizes;

  Simulado(this.title, this.quizes);

  factory Simulado.fromMap(Map<String, dynamic> snippet) {
    return Simulado(
      snippet['title'],
      snippet['quizes']
    );
  }
}