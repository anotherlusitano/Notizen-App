<div align="center">
  <h1>Notizen</h1>
  <img src="./assets/notizen.png" height=300 width=300 />
</div>

## Descrição

O Notizen é uma aplicação Android para gestão de tarefas, criada como trabalho final da disciplina de Computação Móvel.

## Funcionalidades
| **Funcionalidade**               | **Descrição**                                                                 |
|---------------------------|-------------------------------------------------------------------------------|
| 🔐 Autenticação           | Registo e login com uma base de dados SQLite                                            |
| 📥 Criar Tarefas          | Adicione tarefas com uma categoria                                    |
| ✏️ Edição de Tarefas        | Modifique o conteúdo das tarefas existentes                                      |
| 🗑️ Eliminação de Tarefas        | Elimine tarefas concluidas                                 |
| ✅ Concluir Tarefas       | Marque tarefas como concluídas com um toque                                   |
| 📑 Divisão por Categorias              | Acesse todas as tarefas de uma determinada categoria                                           |
| 🔒 Tarefas Isoladas | Cada utilizador tem as suas próprias tarefas                           |

## Instalação

A forma mais fácil de instalar esta aplicação é através da [instalação do apk](https://github.com/anotherlusitano/Notizen-App/releases/download/v1.0.0/notizen.apk).

Mas, se não confiares num APK desconhecido da internet, podes sempre seguir estes passos para compilar o APK da aplicação:

1. **Clone do repositório**  
   No terminal, executa o seguinte comando:  
   ```sh
   git clone https://github.com/anotherlusitano/Notizen-App.git
   ```  

1. **Build do APK**  
   Depois basta ir para dentro do repositório e dar build ao apk:  
   ```sh
   cd Notizen-App/
   flutter build apk --release
   ```
   O apk vai encontrar-se em `build/app/outputs/flutter-apk/app-release.apk`

2. **Instalar o APK no dispositivo**  
   A maneira mais fácil de instalares o apk é conectar o teu telemóvel Android via USB e executar o comando:  
   ```sh
   flutter install apk
   ```
   Mas, também podes só transferir o apk para o teu telemóvel e instala-lo aí.
