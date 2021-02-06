# Ruby-Note
Herramienta hecha en Rails 6.1
Ruby_note es el resultado de un trabajo integrador a ser entregado a la catedra Taller de Tecnologias de Produccion de Software (Ruby) (2020) de la Facultad de Infórmatica de UNLP.
 
## Uso de `Ruby-Note`

Se debe instalar rails y copiar este repositorio en una carpeta en su máquina.
Luego correr
```bash
$ bundle install
```
para instalar los paquetes (gemas) que se necesitan.
Se debe crear la base de datos que usara Ruby-Note
```bash
$ rails db:create
$ rails db:migrate
```
 Y si todo salio bien corremos el servidor puma de rails
 ```bash
$ rails server
```
y entrando desde un navegador web a ```http://localhost:3000```
nos encontraremos con una página de bienvenida que nos permite crearnos una cuenta en "Registrarme" y luego "Iniciar" para acceder al sistema.
Ahí podremos crear cuadernos, notas sueltas y dentro de cada cuaderno notas; tanto los cuadernos como las notas se pueden descargar en forma individual, editar y eliminar. 
En la barra de menu encontramos un boton de descarga de todas las notas y cuadernos que tenenmos creadas.

