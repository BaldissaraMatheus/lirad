class Simulado {
  final String title;
  final List<String> quizesTitle;

  Simulado(this.title, this.quizesTitle);

  factory Simulado.fromMap(Map<String, dynamic> snippet) {
    return Simulado(
      snippet['title'],
      snippet['quizesTitle'].cast<String>()
    );
  }
}