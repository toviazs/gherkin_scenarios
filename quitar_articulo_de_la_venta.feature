Feature: Quitar articulo de la venta

    Como vendedor
    Quiero quitar articulos de la venta
    Para reflejar los cambios en la seleccion del cliente

    Background:
        Given una venta en proceso con la línea de venta:
            | Código | Talle | Color | Cantidad | Importe |
            | 123    | 32    | negro | 3        | $7000   |
        And el total de la venta es $8470


    Scenario: Borrar una línea de venta reduciendo a cero su cantidad
        When modifico la cantidad de la línea de venta a 0
        Then la línea de venta se borra
        And el subtotal de la venta es $0
        And el total de la venta es $0


    Scenario: Borrar una línea de venta seleccionando la opción de cruz o equis
        When selecciono la opción de borrar sobre la línea de venta
        Then la línea de venta se borra
        And el subtotal de la venta es $0
        And el total de la venta es $0
