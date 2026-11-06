============================================================
SISTEMA DE CONTROL DE ASISTENCIA Y BASE DE DATOS SQL
Politécnico Profesor Máximo Pérez Florián
============================================================

Archivos incluidos en este paquete:
1. schema.sql        -> Código fuente SQL para crear la base de datos en MySQL, PostgreSQL o Supabase.
2. server.py        -> Servidor Backend listo en Python/Flask que crea automáticamente la base de datos `politecnico.db` (SQLite).
3. index.html       -> Aplicación Web con panel de usuarios y conexión a la base de datos.

CÓMO CREAR Y EJECUTAR LA BASE DE DATOS:

OPCIÓN A: Usar Servidor Local Python (Forma más rápida)
1. Instale Python en su computadora si no lo tiene.
2. Ejecute en su consola/terminal:
   pip install flask
   python server.py
3. El archivo de base de datos 'politecnico.db' se creará automáticamente en su carpeta.

OPCIÓN B: Cargar en MySQL / PhpMyAdmin / Supabase
1. Abra PhpMyAdmin o su gestor MySQL/PostgreSQL.
2. Cree una base de datos llamada `politecnico_db`.
3. Vaya a la pestaña "Importar" o "SQL" y pegue/cargue el contenido del archivo `schema.sql`.
4. Ejecute el script. La base de datos, tablas, usuarios y datos de prueba quedarán creados al instante.
