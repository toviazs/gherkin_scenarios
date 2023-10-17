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
        Given una tarjeta ingresada con fondos insuficientes
        When el sistea simula el envío de autorización al sistema externo de autorización de pagos
        And el sistema simula el rechazo por fondos insuficientes por parte del sistema externo
        Then el sistema gestiona el rechazo y muestra el mensaje "Pago rechazado por fondos insuficientes"