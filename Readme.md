# rn

Plantilla para comenzar con el Trabajo Práctico Integrador de la cursada 2020 de la materia
Taller de Tecnologías de Producción de Software - Opción Ruby, de la Facultad de Informática
de la Universidad Nacional de La Plata.

Ruby Notes, o simplemente `rn`, es un gestor de notas concebido como un clon simplificado
de la excelente herramienta [TomBoy](https://wiki.gnome.org/Apps/Tomboy).

Este proyecto es simplemente una plantilla para comenzar a implementar la herramienta e
intenta proveer un punto de partida para el desarrollo, simplificando el _bootstrap_ del
proyecto que puede ser una tarea que consume mucho tiempo y conlleva la toma de algunas
decisiones que pueden tener efectos tanto positivos como negativos en el proyecto.

## Uso de `rn`

Para ejecutar el comando principal de la herramienta se utiliza el script `bin/rn`, el cual
puede correrse de las siguientes manera:

```bash
$ ruby bin/rn [args]
```

O bien:

```bash
$ bundle exec bin/rn [args]
```

O simplemente:

```bash
$ bin/rn [args]
```

> Notá que para la ejecución de la herramienta, es necesario tener una versión reciente de Ruby (2.5 o posterior) y tener instaladas sus dependencias, las cuales se manejan con Bundler. Para más información sobre la instalación de las dependencias, consultar la siguiente sección ("Desarrollo").
>Utiliza para su uso una gema llamada tty-editor
>Cuando se ejecute creara en el Home del usuario del sistema una carpeta llamada .my_rns y dentro de ellas dos carpetas mas destinadas al guardado de los Books y de las Notes generales