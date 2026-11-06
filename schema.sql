-- ============================================================
-- SCRIPT DE CREACIÓN DE BASE DE DATOS INSTITUCIONAL
-- Sistema: Politécnico Profesor Máximo Pérez Florián
-- Compatible con: MySQL 8.0+, PostgreSQL, SQLite, Supabase
-- ============================================================

CREATE DATABASE IF NOT EXISTS politecnico_db;
USE politecnico_db;

-- Tabla de Roles
CREATE TABLE IF NOT EXISTS roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO roles (nombre_rol) VALUES 
('Administrador'), 
('Docente Admin'), 
('Docente'), 
('Padre')
ON DUPLICATE KEY UPDATE nombre_rol=VALUES(nombre_rol);

-- Tabla de Usuarios del Sistema
CREATE TABLE IF NOT EXISTS usuarios (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    nombre_completo VARCHAR(100) NOT NULL,
    role_id INT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id) ON DELETE CASCADE
);

-- Usuarios por Defecto (Password inicial: '123456')
INSERT INTO usuarios (username, password_hash, nombre_completo, role_id) VALUES 
('admin', '123456', 'Director General', 1),
('docente.admin', '123456', 'Coordinador Pedagógico', 2),
('docente', '123456', 'Docente de Asignatura', 3)
ON DUPLICATE KEY UPDATE username=VALUES(username);

-- Tabla de Estudiantes
CREATE TABLE IF NOT EXISTS estudiantes (
    estudiante_id INT AUTO_INCREMENT PRIMARY KEY,
    rne VARCHAR(20) NOT NULL UNIQUE,
    fecha_nacimiento DATE NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    sexo CHAR(1) DEFAULT 'M',
    familia_profesional VARCHAR(100),
    bachillerato_tecnico VARCHAR(150),
    grado VARCHAR(10),
    seccion CHAR(1),
    tutor_nombre VARCHAR(100),
    tutor_telefono VARCHAR(20)
);

-- Datos de Ejemplo para Estudiantes
INSERT INTO estudiantes (rne, fecha_nacimiento, nombres, apellidos, sexo, familia_profesional, bachillerato_tecnico, grado, seccion, tutor_nombre, tutor_telefono) VALUES
('0901-2010-0001', '2008-05-14', 'Carlos Manuel', 'Pérez Cuevas', 'M', 'Informática y Comunicaciones', 'Desarrollo y Administración de Aplicaciones Informáticas', '4to', 'A', 'Juan Pérez', '809-555-0101'),
('0901-2010-0002', '2008-09-22', 'Ana Sofía', 'Méndez Novas', 'F', 'Informática y Comunicaciones', 'Diseño y Desarrollo de Aplicaciones Informáticas', '4to', 'B', 'María Novas', '809-555-0102'),
('0901-2009-0015', '2007-01-10', 'Luis Eduardo', 'Rivas Volquez', 'M', 'Administración y Comercio', 'Comercio y Marketing Digital', '5to', 'A', 'Pedro Rivas', '809-555-0103')
ON DUPLICATE KEY UPDATE rne=VALUES(rne);

-- Tabla de Registro de Asistencias Mensuales
CREATE TABLE IF NOT EXISTS asistencias_mensuales (
    asistencia_id INT AUTO_INCREMENT PRIMARY KEY,
    estudiante_id INT NOT NULL,
    mes VARCHAR(10) NOT NULL,
    dias_asistidos INT DEFAULT 0,
    dias_laborables INT DEFAULT 20,
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(estudiante_id) ON DELETE CASCADE,
    UNIQUE KEY uq_estudiante_mes (estudiante_id, mes)
);

-- Registros Iniciales de Asistencia
INSERT INTO asistencias_mensuales (estudiante_id, mes, dias_asistidos, dias_laborables) VALUES
(1, 'Ago', 20, 20), (1, 'Sep', 19, 20), (1, 'Oct', 20, 20), (1, 'Nov', 18, 20), (1, 'Dic', 15, 15),
(2, 'Ago', 18, 20), (2, 'Sep', 16, 20), (2, 'Oct', 15, 20), (2, 'Nov', 14, 20), (2, 'Dic', 12, 15)
ON DUPLICATE KEY UPDATE dias_asistidos=VALUES(dias_asistidos);
