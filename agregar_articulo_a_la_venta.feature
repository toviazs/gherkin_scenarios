Feature: Agregar articulo a la venta

    Como vendedor
    Quiero agregar articulos a la venta
    Para reflejar la seleccion del cliente y conocer el total


    Scenario: Listar combinaciones de talle y stock e información de articulo existente
        Given una venta en proceso
        And existe un articulo con el codigo 123, con la informacion:
            | Codigo | Marca   | Descripcion    |
            | 123    | Lacoste | Remera fachera |
        And existen las siguientes combinaciones de talle y color para el articulo 123:
            | Talle | Color  | Stock |
            | 32    | negro  | 5     |
            | 36    | blanco | 4     |
            | 38    | rosa   | 0     |
        When ingreso el codigo 123
        Then se debe mostrar la siguiente informacion del articulo:
            | Marca   | Descripcion    | Precio |
            | Lacoste | Remera fachera | $7000  |
        And Se deben listar las siguientes combinaciones de talle y color con stock mayor a 0:
            | Talle | Color  | Stock |
            | 32    | negro  | 5     |
            | 36    | blanco | 4     |


    Scenario: Exito al agregar el articulo a la venta
        Given una venta en proceso
        And existe un artículo con el código 123
        And se muestra la información del artículo 123 con las combinacinoes con stock mayor a 0
        When selecciono 2 unidades de la combinación
            | Talle | Color |
            | 32    | negro |
        Then Se agrega la combinación seleccionada como linea de venta
            | Codigo | Talle | Color | Cantidad | Importe |
            | 123    | 32    | negro | 2        | $14000  |
        And el subtotal de la venta es $14000
        And el total de la venta es $16940


    Scenario: Error al listar articulo inexistente
        Given una venta en proceso
        And existe un articulo con codigo 100
        When el vendedor ingresa el codigo 321
        Then se muestra el mensaje "No existe un articulo con el codigo 321"


    Scenario: Agregar un artículo a la venta que ya tiene un artículo
        Given una venta en proceso con la combinación:
            | Codigo | Talle | Color | Cantidad | Importe |
            | 123    | 32    | negro | 3        | $21000  |
        And el subtotal de la venta es $21000
        And el total de la venta es $25410
        When creo la linea de venta
            | Codigo | Talle | Color  | Cantidad | Importe |
            | 456    | 40    | blanco | 2        | $20000  |
        Then la combinación seleccionada se agrega como linea de venta:
            | Codigo | Talle | Color  | Cantidad | Importe |
            | 123    | 32    | negro  | 3        | $21000  |
            | 456    | 40    | blanco | 2        | $20000  |
        And al subtotal de la venta es $41000
        And el total de la venta es $49610


    Scenario: Exito al modificar la cantidad de un articulo en la venta
        Given una venta en proceso con la linea de venta:
            | Codigo | Talle | Color | Cantidad | Importe |
            | 123    | 32    | negro | 4        | $28000  |
        And el total de la venta es $33880
        When modifico la cantidad de la linea de venta a 2
        Then la linea de venta se modifica:
            | Codigo | Talle | Color | Cantidad | Importe |
            | 123    | 32    | negro | 2        | $14000  |
        And el subtotal de la venta es $14000
        And el total de la venta es $16940


    Scenario: Cantidad de stock insuficiente al agregar artículo:
        Given una venta en proceso
        And se listan las combinaciones:
            | Talle | Color | Stock |
            | 32    | negro | 3     |
        When selecciono 4 unidades de esa combinación
        Then se muestra el mensaje "Stock insuficiente para la cantidad indicada"










