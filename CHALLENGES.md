# Desafíos en Angry Animals

## Complejidad de la Mecánica de Arrastre

El principal desafío en este punto del proyecto fue entender la lógica detrás de cómo debe funcionar realmente la mecánica de arrastre ("drag") para el personaje.

Esto involucró:
1. **Lógica de Estado y Variables:** Entender la necesidad de llevar el control de variables iniciales (como guardar la posición exacta donde se inicia el click, o `drag_start`) y variables dinámicas (como el vector de arrastre actual).
2. **Matemática de Vectores:** Fue un reto comprender el uso de vectores para esta mecánica. Específicamente, entender cómo calcular el vector de arrastre restando posiciones, cómo obtener su longitud (`length`) para saber la fuerza aplicada, y cómo invertir este vector para aplicar el impulso final al `RigidBody2D` en la dirección correcta.
