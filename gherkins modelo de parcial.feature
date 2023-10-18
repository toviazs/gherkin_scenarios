Feature: Autenticar Usuario

    Scenario Outline:
        Given existen los siguientes usuarios registrados en el sistema:
            | User  | Password |
            | Tovi  | tobi     |
            | Santi | santy    |
        When ingreso el User <user> y el Password <password>
        Then se muestra el mensaje <mensaje>

        Examples:
            | user  | password | mensaje                     |
            | Tovi  | tobi     | Inicio de sesión exitoso    |
            | Santi | tobias   | La contraseña es incorrecta |
            | Lucs  | luks     | El usuario no existe        |

    Scenario: Autenticar usuario administrador
        Given existen los siguientes usuarios registrados en el sistema:
            | User  | Password | rol           |
            | Tovi  | tobi     | administrador |
            | Santi | santy    | aguatero      |
        When ingreso el User "Tovi" el Password "tobi"
        Then se muestra el mensaje "Inicio de sesión exitoso"
        And ingreso al sistema con el rol de administrador
