# Am i a hero
Jogo que estou criando para aprender a programar jogos em Godot!
Usarei esse ReadMe para fazer anotações e passos a seguir.
---
 -Godot funciona com Nodes, juntamos alguns nodes em um uma cena para formar fases, menus, personagens, objetos, etc.
---
## Gráficos 2D:
- Caso o jogo inicie com um "blur" ao invés de uma imagem clean, faça o seguinte:
- configurações do projeto
- Renderização > Textura > Default Texture Filter > Nearest

## Cena2D
* Crie uma Cena2D - renomeie de Game ou fase1(como desejar, é aqui que o jogo irá rodar e onde você ira arrastar todos os objetos desejados (monstros, itens, player etc))
* Crie uma Camera2D - Dê o zoom que desejar para aumentar ou diminuir a tela
   * Arraste-o para cima do Player
   * no GameTree, arraste a Camera para dentro do Player
   * no Inspector (Lateral direita): Position Smoothing: ENABLE ON
* Crie um Tilemap
   * em Tileset, selecione NewTileSet
   * configure o TileSize de acordo com o tileset a ser usado!
   * Na parte de baixo, em TileSet, arraste as imagens tiles desejados
   * Apague e selecione corretamente cada tile (arvores por exemplo podem ser usados como um tile só)
   * Na parte lateral em Tileset > **Physics Layer**:
      * Add Element e agora na parte de baixo:
      * Clique em Paint > Paint Properties e seleciona o layer que quer que tenha física
      * pinte os tiles
   * no GameTree,arraste o TileMap para o topo (fica fácil de achar)



 ## Criando um player:
 * Como mencionado anteriormente, deve-se criar uma Nova Cena (SEMPRE PARA QUALQUER NOVO ITEM, OBJETO, FASE)
 * Character Body - renomeie de Player
 * Animated Sprite - e arrasta os sprites desejados para a área (tilesheet ou diversos frames)
    * Coloque autoplay para a animação iniciar junto com o jogo
    * A partir daqui pode testar a animação e adicionar a velocidade ou diminuir, como desejar.
    * Para uma boa prática de programação, renomeie as animações de acordo "Idle, run, death, hit..."
    * Arraste a imagem para cima da linha
* CollisionShape -
   * em Shape, adicione o formato desejado (NewCircle,NewCapsule...)
* No Node principal (player)
   * Adicione Script e salve-o na pasta correta (scripts)
   * Pode adicionar o template já pronto para facilitar, mas futuramente altere para ficar bem de acordo com o tipo de jogo.


