Feature: Borrar Artículo

    Como administrador
    Quiero borrar artículos
    Para deshabilitar la disponibilidad de los artículos no existentes


    Scenario: Listar la información del artículo
        Given existe un artículo con el código 123, con la información
            | Codigo | Marca   | Descripcion    |
            | 123    | Lacoste | Remera fachera |
        When ingreso el código del artículo 123
        Then se muestra la información del artículo


    Scenario: Baja lógica de artículo existente
        Given existe un artículo 123 sin inventarios asociados
        Given se listó la información del artículo 123
        When elimino el artículo 123
        Then el artículo 123 sufre un borrado lógico


    Scenario: Baja Lógica de Articulo con inventario asociado
        Given existe un artículo 123 con los inventarios
            | Código | Talle | Color | Stock |
            | 123    | 32    | negro | 12    |
        When elimino el artículo 123
        Then se informa error al eliminar el artículo
        And el sistema muestra los inventarios asociados
            | Código | Talle | Color | Stock |
            | 123    | 32    | negro | 12    |