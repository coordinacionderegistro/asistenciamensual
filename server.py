from flask import Flask, request, jsonify
import sqlite3
import os

app = Flask(__name__)
DB_NAME = 'politecnico.db'

def init_sqlite_db():
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS usuarios (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT,
            nombre TEXT,
            role TEXT
        )
    ''')
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS estudiantes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            rne TEXT UNIQUE,
            fecha_nacimiento TEXT,
            nombres TEXT,
            apellidos TEXT,
            grado TEXT,
            seccion TEXT
        )
    ''')
    # Usuario Admin por defecto
    cursor.execute("INSERT OR IGNORE INTO usuarios (username, password, nombre, role) VALUES ('admin', '123456', 'Administrador Master', 'Administrador')")
    conn.commit()
    conn.close()

@app.route('/api/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute("SELECT username, nombre, role FROM usuarios WHERE username=? AND password=?", (username, password))
    user = cursor.fetchone()
    conn.close()
    if user:
        return jsonify({"success": True, "user": {"username": user[0], "nombre": user[1], "role": user[2]}})
    return jsonify({"success": False, "message": "Credenciales inválidas"}), 401

@app.route('/api/estudiantes', methods=['GET'])
def get_estudiantes():
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM estudiantes")
    rows = cursor.fetchall()
    conn.close()
    return jsonify(rows)

if __name__ == '__main__':
    init_sqlite_db()
    print("Base de datos SQLite inicializada. Servidor iniciado en http://localhost:5000")
    app.run(port=5000, debug=True)
