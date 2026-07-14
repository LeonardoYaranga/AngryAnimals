# Aprendido en Angry Animals

![Debug Label del Personaje](Images/LabelDebugAnimalScene.png)

## Mecánica de Arrastre ("Drag")
Cómo configurar la mecánica de lanzamiento, similar a la de Angry Birds.

La idea principal se basa en:
1. **Detección de Click:** Mientras el objeto esté siendo clickeado, se puede arrastrar dentro de una zona delimitada.
2. **Aplicación de Fuerza:** Al soltar el click, se le aplica una fuerza de impulso al `RigidBody2D`. Esta fuerza se aplica usando el vector opuesto al que se estaba arrastrando.

### Escala de la Flecha
Para dar feedback visual al jugador, se implementa una flecha que aparece al arrastrar. La escala (tamaño) de esta flecha aumenta dependiendo de qué tanto arrastres, controlando su tamaño máximo y mínimo mediante funciones matemáticas:
- **`clamp`:** Esta función sirve para limitar un valor entre un mínimo y un máximo (los "extremos"). Esto asegura que la flecha no se haga infinitamente grande ni desaparezca por completo.
- **`lerp` (Linear Interpolation):** Esta función sirve para encontrar un valor intermedio entre dos puntos, basándose en un "peso" o porcentaje (`t`). En este caso, nos permite hacer que la transición de la escala de la flecha sea mucho más suave mientras calculamos el nuevo tamaño.

## Propiedades del RigidBody2D
Aprendí bastante sobre cómo funcionan los `RigidBody2D` y las propiedades que se pueden ajustar en el Inspector:
- **Physics Material (Bounce):** Se puede añadir un material físico para definir propiedades como el rebote.
- **Freeze:** Permite "congelar" el objeto en el espacio temporalmente para que no le afecte la gravedad hasta que lo decidamos.
- **Pickable:** Es crucial activar esta opción en el Inspector para que el `RigidBody` pueda detectar eventos de entrada del mouse (como los clicks para arrastrar).

## Debugging en Tiempo Real
Aprendí a colocar un `Label` específico para el Debug. Como se ve en la imagen, este Label nos muestra información valiosa en tiempo real sobre nuestro `RigidBody2D`, como si está congelado, el vector de arrastre, el impulso calculado y la longitud del impulso. Esto facilita enormemente entender qué está sucediendo "por debajo" con la física.

## Sprite2D Region y Texturas Repetitivas

Para crear áreas grandes con un patrón que se repite (como una zona extensa de agua), podemos utilizar la propiedad **Region** de un `Sprite2D` junto con la opción de repetición de textura.
**Activando la Región:** Si habilitamos la propiedad `Sprite2D > Region > Enabled` y definimos un ancho (`w`) y un alto (`h`) mayores al tamaño de la imagen original, le estamos pidiendo al Sprite que dibuje un área más grande que su propia textura.
Si esta región es más grande que la imagen, el motor no sabe qué dibujar en ese espacio sobrante y simplemente "estira" los últimos píxeles del borde. Esto hace que se vea una mancha alargada al final:
   ![[RegionOversizeWithoutRepat.png]]
 Para arreglar esto y hacer que la textura forme un "mosaico" repitiendo su patrón infinitamente, debemos ir a `CanvasItem > Texture > Repeat` y configurarlo en **Enabled**. Así, el agua se repetirá correctamente cubriendo toda el área sin deformarse:
   ![[RegionOversizeRepeatable.png]]

## Uso de "call_deferred"
Hay momentos que el motor Godot sigue haciendo calculos con lo que esta en escena asi que no puedo llamar a cierta funcion inmediantamente, por ello se usa la funcion "call_deferred" para que Godot la ejecute cuando acabe de hacer todos los calculos previos, asi no hay errores.

Un ejemplo en el res://Scenes/Animal/Animal.gd en la funcion:
func _unhandled_input(event: InputEvent) -> void:
	if _is_dragging and event.is_action_released("drag"):
		call_deferred("start_release")
- Aqui se coloca que la funcion de lanzamiento o que aplica impulso al Animal se ejecute si ya termino los calculos de la mecanica de arrastre previa

Tambien en res://Scenes/LevelBase/LevelBase.gd en la funcion:
func spawn_animal() -> void:
	var animal: Animal = ANIMAL.instantiate() as Animal
	animal.global_position = start.global_position
	call_deferred("add_child", animal)

* no se puede agregar una instancia de una escena si la escena anterior no termina correctamente de hacer sus calculos y desaparecer, por ello lo de agregar la nueva escena de animal al arbol es algo que se debe hacer de manera segura despues de terminar los procesos de la escena Animal previa.

## Input Handling Sequence
Los imputs tienen este orden:
1. _ input: 
2. _ gui_input: Solo lo usan los "Control Nodes"
3. _ unhandled_key_input: Solo teclas del teclado
4. _ unhandled_input: 
5. _ input_event: Solo para las "Collision Shapes"

Se estuvo probando que siempre al hacer click fuera de las areas con los scripts siempre reciben la funciones _input y _ unhandled_input

Ademas aqui se comprende el comportamiento de los nodos de "Control" con sus propiedades de Mouse/Filter/ Pass, Stop and Ingnore, que esas actuan solo si el input se hace sobre dichos nodos, en este caso al hacer click sobre el cuadrado azul con la propiedad Stop la propagacion del evento se queda ahi , no pasa a la parte gris, ni pasaria a la parte del Parrot si quisieramos hacerle click a travez.
Sin embargo con una propiedad Pass el input pasa a los hijos de dicho nodo y lo que este por detras.

Finalmente la propiedad Ingnore es que dicho nodo no detectara los Inputs y los dejara pasar a los que esten atras de el.
![[MouseControlNodeProperties.png]]
OJO: Al acceder en una funcion _phyisics_process a Input.is_action_just_released("InputName") siempre sera detectado, esto es independiente de en que area clickeamos, porq estamos accediendo a la clase y se esta monitoreando todo el tiempo por la funcion en la que estamos colocando esta comprobacion.
![[InputTesting.png]]

## Inherit Scenes
Una buena de manera de crear escenas parecidas es usar la herencia, en este caso se crea la escena LevelBase que tiene las cosas basicas que todas los niveles deberian tener y posteriormente en Scene>New inherit Scene podemos llegar a crear escenas iguales a las cuales le podemos agregar otras cosas que los diferencien, como mas obstaculos, mas enemigos, entre otras cosas.
![[InheritScenes.png]]