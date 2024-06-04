# Am i a hero
 Jogo que estou criando para aprender a programar jogos em Godot!
 Usarei esse ReadMe para fazer anotações e passos a seguir.
---
 -Godot funciona com Nodes, juntamos alguns nodes em um uma cena para formar fases, menus, personagens, objetos, etc.
---
# Gráficos 2D:
- Caso o jogo inicie com um "blur" ao invés de uma imagem clean, faça o seguinte:
- configurações do projeto
- Renderização > Textura > Default Texture Filter > Nearest

# Cena2D
* Crie uma Cena2D - renomeie de Game
* Crie uma Camera2D - Dê o zoom que desejar para aumentar ou diminuir a tela



 # Criando um player:
 * Como mencionado anteriormente, deve-se criar uma Nova Cena
 * Character Body - renomeie de Player
 * Animated Sprite - e arrasta os sprites desejados para a área (tilesheet ou diversos frames)
    * Coloque autoplay para a animação iniciar junto com o jogo
    * A partir daqui pode testar a animação e adicionar a velocidade ou diminuir, como desejar.
    * Para uma boa prática de programação, renomeie as animações de acordo "Idle, run, death, hit..."
    * Arraste a imagem para cima da linha
* CollisionShape
   * em Shape, adicione o formato desejado (NewCircle,NewCapsule...)


