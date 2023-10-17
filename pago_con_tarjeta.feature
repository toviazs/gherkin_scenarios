Feature: Pago con Tarjeta

    Como vendedor
    Quiero registrar un pago con tarjeta
    Para garantizar transparencia financiera y facilitar la conciliación contable


    Scenario: Ingresar tarjeta como medio de pago
        Given una tarjeta con los datos válidos:
            | Número de tarjeta         | 1234 5678 9012 3456 |
            | Fecha de vencimiento      | 12/25               |
            | Titular de la tarjeta     | Juan Pérez          |
            | Código de seguridad (CVV) | 123                 |
        When ingreso la tarjeta como medio de pago
        Then el sistema registra la tarjeta


    Scenario: Enviar solicitud de autorización de pago
        Given una tarjeta valida ingresada
        When el sistema simula el envío de una solicitud de autorización al sistema externo de autorización de pagos
        Then los datos son enviados correctamente


    Scenario: Pago con tarjeta rechazado por falta de fondos
        Given una tarjeta válida ingresada 
        When el sistema simula el envío de autorización al sistema externo de autorización de pagos
        And el sistema simula el rechazo por fondos insuficientes por parte del sistema externo
        Then el sistema gestiona el rechazo y muestra el mensaje "Pago rechazado por fondos insuficientes"

    Scenario Outline: Ingreso de tarjeta como medio de pago
    Examples:    
            | <tarjeta_num>         | <fecha_venc>  | <nom_titular> | <cod_seguridad>   | mensaje_mostrado                  |
            | 1234 5678 9012 3456   | 12/25         | Juan Pérez    | 123               | Tarjeta ingresada correctamente   |
            | 0000 06               | 12/25         | Juan Pérez    | 123               | Tarjeta inválida                  |
            | 1234 5678 9012 3456   | abcd          | Juan Pérez    | 487523            | Tarjeta inválida                  |

        Given una tarjeta con los siguientes datos: 
            | Número de tarjeta         | <tarjeta_num>         |
            | Fecha de vencimiento      | <fecha_venc>          |
            | Titular de la tarjeta     | <nom_titular>         |
            | Código de seguridad (CVV) | <cod_seguridad>       |
        When ingreso la tarjeta como medio de pago 
        Then el sistema muestra el mensaje <mensaje_mostrado>

    Scenario: Recepción de autorización de pago
        Given efectué un pago con tarjeta
        And el sistema envía la solicitud de autorización del pago 
        When se recibe la autorización del mismo
        Then se muestra el mensaje de pago autorizado
        And se desencadena la lógica de emisión de comprobante
            