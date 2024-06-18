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
    * para adicionar novas animações, clique no primeiro botão perto do Autoplay e repita todo o processo.
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

            

## Melhorando controles e animação do Player:
* Barra superior > Projeto > Configurações de projeto > mapa de entrada:
   * Adicionar Nova Ação: é aqui que adicionaremos os botões do jogo.
   * adicione pulo, esquerda, direita, interação, ataque e o que mais desejar
   * no "+" ao lado dos botões,  é onde designamos os botões para esses movimentos. Podemos usar 2 botões para a mesma ação, ex: andar para a direita "->" e "D"
* Por padrão, o Script do Godot usa controles que foram feitos para  navegar pela UI. Agora que criamos os botões, podemos substituí-los no Script (onde estiver amarelo fazendo menção a UI, colocamos os nomes dos botões)
* Para girar o personagem junto com a direção:
   * No Script do Player, precisamos referenciar o node AnimatedSprite (arrastar pra dentro do script com CTRL)
   * Na parte de movimentação que acabamos de trocar os nomes (var direction), criaremos linhas para girar o sprite
   * if direction > 0:
      * animated_sprite.flip_h = false
   * elif direction < 0:
      * animated_sprite.flip_h = true

* Para trocar a animação dependendo da animação: (é bom separar por blocos e comentários, como no python!)
* Para diferenciar o pulo dos passos, temos que chegar se o personagem está no chão:
   * if  is_on_floor():    
      * if direction == 0:
         * animated_sprite.play("idle")
      * else:
         * animated_sprite.play("run")
   
   else:
		if velocity.y <0:
			animated_sprite_2d.play("jump")
		elif velocity.y >200:     <-------------------- adicionei essa linha: Se a velocidade em y for menor que 0, toca o  jump, senão, toca o fall
			animated_sprite_2d.play("fall")


## Parallax:
* Crie um ParallaxBackground
   * Crie um ParallaxLayer
      * Crie um Sprite
* Multiplique o ParallaxLayer de acordo com quantos background irão compor o cenário
* Arraste o background para dentro de Sprite> Texture
* Caso a imagem seja menor que o cenário, altere o scale em Sprite
* No Inspector>  Mirroring> coloque o valor da largura da imagem escolhida multiplicando pelo scale (caso tenha alterado no Sprite2D)  
* desmarque a corrente e altere o scale somente em X
* Caso tenha problema na renderização do parallax, duplique o sprite, o mirroring e arraste a segunda imagem para o lado, no meio do espaço entre a imagem espelhada
* ParallaxLayer, No Inspector> Scale> é onde determinamos a intensidade do movimento (Use números quebrados para não atrapalhar o restante do jogo: 0.1, 0.2, 0.3....)/ colocar as nuvens em 0, já que elas não tem que se mover apenas quando caminhamos.
   * Quanto maior o valor, mais próximo ele está de você
* Para as nuvens, Adicione um Script no ParallaxLayer dela:
   * export(float) var CLOUD_SPEED = -15
   * func _process(delta) -> void:
      * self.motion_offset.x += CLOUD_SPEED * delta


## Luz e Sombras:
* Crie um CanvasModulate
   * Escolha uma cor mais escura
* No scene Player (e onde quiser adicionar a luz):
   * Crie um PointLight2D
      * No Inspector: Carregue a imagem de light ou Crie um em Texture> NewGradient2D > Fill > Radial > em Gradient: inverta as cores, arraste o círculo para o meio do quadrado e diminua até o círculo caber dentro do quadrado
      * Configure o tamanho e força da luz como quiser
      * Shadow Enabled
* No Tilemap > Tileset (Inspector) > Rendering > Occlusion Layer > Add Element (lembrando que é bom para objetos, móveis, plataformas etc.)
   * Em Tileset(Em baixo) > Rendering > Occlusion Layer 0 (parecido com a criação de tileset)
   * filter: PCF13 / filter smooth: 1,5 ou como desejar


## Pulo Duplo:
* Declare uma variável chamada MAX_JUMP = 1
* Declare uma variável chamada jump_count = 0
* Na área de pulo, substitua o "is_on_floor" como condicional para pular por (jump counter < MAX_JUMP)
   * adicione jump_count += 1
* Na área de Add gravity tem um if, coloque um else (ou  seja, está no chão), jump_count = 0