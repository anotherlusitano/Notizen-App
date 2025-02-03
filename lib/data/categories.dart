enum Category {
  todas("Todas", enabled: true),
  trabalho("Trabalho"),
  pessoal("Pessoal"),
  estudo("Estudo"),
  tecnologia("Tecnologia"),
  jardinagem("Jardinagem"),
  culinaria("Culinária"),
  arte("Arte"),
  musica("Música"),
  jogos("Jogos"),
  desporto("Desporto"),
  mecanica("Mecânica"),
  roubo("Roubo");

  const Category(
    this.text, {
    this.enabled = false,
  });
  final String text;
  final bool enabled;
}
