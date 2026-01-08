# People Analytics Dashboard: Inteligencia Operativa y Rentabilidad de Capital Humano

### Descripción del Proyecto

Este proyecto consiste en la creación de una solución integral de **People Analytics** para un distribuidor minorista con múltiples franquicias. El objetivo principal fue transformar un proceso manual basado en un archivo Excel fragmentados en un ecosistema de datos automatizado y escalable, permitiendo analizar la relación entre el costo laboral y la eficiencia operativa de cada colaborador.

### Arquitectura de Datos

La solución utiliza un enfoque **ELT** dentro de **SQL Server**, estructurado en capas lógicas para garantizar el orden y la integridad de la información:

1. **Capa RAW**: Lugar para la importación mensual de archivos. Utiliza tipos de datos flexibles (`NVARCHAR`) para mitigar errores de formato desde el origen.
2. **Capa STAGING**: Repositorio histórico donde se consolidan los datos de forma acumulativa, incluyendo columnas de auditoría y claves temporales.
3. **Capa DWH / Analytics**: Creamos una VIEW final optimizada (`vw_Salarios_Analytics`) donde limpiamos y transformamos los datos, dejandolos en un estado listo para ser cargados a Power BI y crear el Dashboard.

### Desafíos Técnicos y Soluciones Implementadas

- **Normalización Dinámica (Unpivot)**: Implementé la lógica de `CROSS APPLY (VALUES...)` para transformar columnas de asistencia por sucursal en filas individuales. Esto permitió realizar análisis granulares de horas trabajadas por local sin recurrir a uniones complejas.
- **Corrección de Magnitud de Datos**: Debido a las inconsistencias y problemas al momento de importar el archivo raw, especialmente en los números referidos al dinero, diseñé una lógica condicional con `CASE` y factores multiplicadores específicos (`10`, `100`, `1000`) para corregir los valores.
- **Automatización de Carga**: Desarrollé un **Stored Procedure** (`sp_Procesar_Mes`) que automatiza la transferencia de datos de RAW a STAGING, inyectando parámetros de fecha y realizando tareas de limpieza automática capa RAW una vez cargado los datos a la capa STAGING.
- **Limpieza de Datos Granular**: Se aplicaron filtros para excluir a colaboradores de áreas no comerciales y personal fuera del alcance (ej. Promotores o E-commerce).

### Impacto en el Negocio

- **Centralización**: Consolidación de meses de datos dispersos en una serie temporal continua para análisis de tendencias.
- **Visibilidad Estratégica**: Capacidad para identificar sucursales con exceso de personal o baja performance.

### Tecnologías Utilizadas

- **Base de Datos**: SQL Server (T-SQL, Stored Procedures, Views).
- **Visualización**: Power BI (Modelado de datos, DAX avanzado).
- **Origen de Datos**: Microsoft Excel (.xlsx).

### Aviso de Confidencialidad y Privacidad

Con el objetivo de proteger la integridad de la información y cumplir con acuerdos de confidencialidad, todos los datos sensibles presentados en este repositorio han sido **anonimizados, modificados o reemplazados**.
