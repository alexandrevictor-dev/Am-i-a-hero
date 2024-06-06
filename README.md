# Am i a hero
## Jogo que estou criando para aprender a programar jogos em Godot!
## Usarei esse ReadMe para fazer anotações e passos a seguir.
---
- Godot funciona com Nodes, juntamos alguns nodes em um uma cena para formar fases, menus, personagens, objetos, etc.
---

## Gráficos 2D:
- Caso o jogo inicie com um "blur" ao invés de uma imagem clean, faça o seguinte:
- configurações do projeto
    - Renderização > Textura > Default Texture Filter > Nearest

## Cena2D (mundo)
* Crie uma Cena2D - renomeie de Game ou fase1(como desejar, é aqui que o jogo irá rodar e onde você ira arrastar todos os objetos desejados (monstros, itens, player etc))
* Crie uma Camera2D - Dê o zoom que desejar para aumentar ou diminuir a tela
   * Arraste-o para o centro do Player(no meio do sprite do personagem)
   * no GameTree, arraste a Camera para dentro do Player no gameTree
   * no Inspector (Lateral direita): 
      * Position Smoothing: ENABLE ON 

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
* no Inspector > Ordering: Coloque Z Index por volta de 5, para que o jogador sempre seja o primeiro no GameTree, sempre renderizado primeiro.
* no Inspector > Collision: Coloque o player no Layer 2, para diferenciar do restante dos itens. (Agora todos os objetos que quiser colidir só com o player, coloque-os em Mask 2)

## Morte:
* Na Camera2D > Inspector(lateral direita):
   * Limit: Use a ferramenta de medição "R" e meça do eixo X até onde você quer que seja a zona de morte e aplique esse valor em Bottom / pode marcar smoothed tbm
* Cria uma nova cena > Area 2D node
   * no Inspector, Collision Mask 2 (onde o player vai reconhecer que tocou)
   * Ele precisa de um collisionShape, porém, como o código será reutilizado para diversas mortes como inimigos, espinhos e precipícios;  iremos adicionar o CollisionShape ao importar o Killzone para o game.
      * Para precipício/buracos: WorldBoundaries
   * Na Scene Killzone (raiz) > Criar script (Object Empty) e não esqueça de salvar na pasta correta de scripts!
      * em Node (ao lado do Inspector) > Area2D conecte body_enteredbody, isso irá criar uma função nova
      * Para o jogo não reiniciar imediatamente, na Scene Killzone > crie Timer e no Inspector você pode selecionar o tempo que desejar e marque One Shot (para não entrar em loop)
      * No Script Killzone, devemos referenciar esse timer; para isso, arrastamos o timer para o codigo segurando ctrl na hora de soltar, isso irá criar um @onready var timer = $Timer (se criar algo diferente disso foi pq errou no ctrl)
         * significado: criou uma variável chamada timer que automaticamente acha o node $Timer. isso se chama "Path" (caminho) ele especifica um caminho pra chegar de um node para outro node na mesma Tree.
            * **EXEMPLO** 
               * Game <------------ Para o Game acessar a Camera, o path seria: $Player/Camera, pois há um node entre os 2
                  * Player
                     * Camera <------------
                  * Killzone <------------ Para Killzone acessar o Timer, opath seria: $Timer, pois não há nada entre eles na Tree
                     * Timer <------------
      * Abaixo da função on_body_entered > timer.start() para iniciar o Timer; agora precisamos de um trigger para ativar algo quando o timer acabar:
         * Com o Timer selecionado na Scene, vamos novamente em Node (ao lado de Inspector) e vamos conectar ao timeout(), isso irá criar uma nova função _on_timer_timeout(), é aqui que iremos reiniciar nosso jogo!
            * Para fazer isso, teremos de acessar a Game Tree e reiniciar a cena atual, então abaixo da função: get_tree().reload_current_scene() 

            



