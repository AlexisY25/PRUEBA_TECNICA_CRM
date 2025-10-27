## Integración y Reporte de Actividad Comercial CRM.

En esta prueba se desarrollaron diferente soluciones a als integraciones de actividad en el CRM

## Inicio.
Hay diferentes carpetas las cuales almacenas las diferentes partes necesarias para completar el proyecto

**Prerequisitos**
- .Net 8
- Integration services
- Sqlserver

**Instalacion**

1. Clonar repositorio

``` Clon de git https://github.com/AlexisY25/PRUEBA_TECNICA_CRM.git ```

2. Explicacion de archivos

- En la carpeta "BaseDeDatos" contiene un archivo ".bacpac" el cual almacena toda la estructuracion utilizada y squemas de las base de datos para este proyecto.
- En la carpeta "CONSULTASQL" tiene un archivo sql el cual cumple con la primera parte requerida del proyecto, el cual es una consulta de tablas combinadas que mide la productividad.
- En la carpeta "REPORTESDTS" contiene el dataflow que se utilizo para para generar los reportes de la parte 2 y parte 3.
- En la carpeta "PRUEBA_TECNICA" contiene la API, la cual consulta a una vista en la base de datos y devuelve el Kpi y la consulta de la parte 1.

3. explicacion de instalacion.

- Parte1:
   Habiendo abordado la estructuracion del repositorio proceder a buscar el archivo ".bacpac" dentro de la carpeta "BaseDeDatos" e importar a SQLserver la estruturacion con sus base de datos.

   Luego de haberlo instalado y comprobar que funciona, puede proceder a probar la consulta del archivo "CONSULTASQL" y correr el script en la base de datos hecho anteriormente.

4. explicacion del archivo "REPORTESDTS".

   Descargar el archivo "REPORTESDTS" y abrirlo con Visual studio, dentro vera dos archivos dts que son " LoadVentas y Reporte".

   - Parte 2 utilizaremos "LoadVentas.dtsx":
     Dentro de este ajustar el objeto "CM_OLEDB_CRM" que se encuentra en el administrador de conexiones ya que este administra la conexion a nuestra base de datos local.
     Luego corregir las rutas de los obejtos de los documentos y llamar "ventas.csv" al documentoq ue se cargara a la bd.

   - Parte 3 utilizaremos "Reporte.dtsx":
     Dentro de este archivo se corregira las conexion de la base de datos en el administrador de conexiones, del objeto "PRUEBA" que contiene la conexion a la base de datos"
     Luego crear una carpeta con una plantilla la cual contendra la menera en que se obtendra el reporte, luego tomar la ruta y colocarla en el administrador de conexiones en el objeto "Excel_reporte"

5. explicacion del archivo "PRUEBA_TECNICA"
   Luego de descargar el archivo, abrirlo con visual studio con la version .NET8

   Abrieto el proyecto en el visual studio entrar a la carpeta "appsettings.json" y ajustar la conexion de la base de datos a la suya local.
   
  Luego correr la API, la cual sera visible en el siguiente enlace "https://localhost:7119/swagger/index.html"

6. explicacion del archivo "DASHBOARD"
   Esta parte es el bonus, la cual es un dashboard donde se compara las "visitas y las ventas"


     
