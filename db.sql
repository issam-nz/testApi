CREATE TABLE tipo_usuario(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(10) NOT NULL
);

-- CREATE TABLE tipo_cargo(
--     id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
--     nombre VARCHAR(25) NOT NULL
-- );

CREATE TABLE idiomas(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(25) NOT NULL
);

CREATE TABLE nivel_idiomas(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(25) NOT NULL,
    id_idioma INT NOT NULL,
    FOREIGN KEY (id_idioma) REFERENCES idiomas(id)
);

CREATE TABLE tipos_practicas(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(25) NOT NULL
);

CREATE TABLE ciclos(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL
);

CREATE TABLE empresas(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nif VARCHAR(9),
    pais VARCHAR(15),
    razonSocial VARCHAR(255),
    titularidad VARCHAR(50),
    tipo_entidad VARCHAR(50),
    territorio VARCHAR(50),
    municipio VARCHAR(25),
    direccion VARCHAR(75),
    codigo_postal VARCHAR(15),
    telefono VARCHAR(15),
    fax VARCHAR(15),
    cnae VARCHAR(50),
    numero_trabajadores INT 
);

CREATE TABLE centros_trabajo(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_empresa INT NOT NULL,
    denominacion VARCHAR(255),
    pais VARCHAR(15),
    territorio VARCHAR(50),
    municipio VARCHAR(25),
    codigo_postal VARCHAR(15),
    direccion VARCHAR(75),
    telefono VARCHAR(15),
    telefono2 VARCHAR(15),
    fax VARCHAR(15),
    email VARCHAR(100),
    actividad VARCHAR(255),
    numero_trabajadores INT,
    FOREIGN KEY (id_empresa) REFERENCES empresas(id)
);

CREATE TABLE alumnos(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(9) NOT NULL UNIQUE,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    poblacion VARCHAR(25),
    email VARCHAR(100),
    otra_titulacion VARCHAR(100),
    vehiculo TINYINT(1) NOT NULL DEFAULT 0,
    id_ciclo INT NOT NULL,
    FOREIGN KEY (id_ciclo) REFERENCES ciclos(id)
);

CREATE TABLE usuarios(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(25) NOT NULL UNIQUE,
    nombre VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(20) NOT NULL,
    telefono VARCHAR(15),
    id_tipo_usuario INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_deleted TINYINT(1) DEFAULT 0,
    FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuario(id)
);

CREATE TABLE profesores(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(255) NOT NULL UNIQUE,
    nombre VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL
);

CREATE TABLE contactos(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nif VARCHAR(255) NOT NULL UNIQUE,
    nombre VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    telefono VARCHAR(15),
    movil VARCHAR(15),
    fax VARCHAR(15),
    email VARCHAR(100),
    departamento VARCHAR(50),
    responsable TINYINT(1) NOT NULL DEFAULT 0,
    id_centro INT NOT NULL,
    FOREIGN KEY (id_centro) REFERENCES centros_trabajo(id)
);

-- CREATE TABLE cargo_empresa(
--     id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
--     id_contacto INT NOT NULL,
--     id_tipoCargo INT NOT NULL,
--     FOREIGN KEY (id_contacto) REFERENCES contactos(id),
--     FOREIGN KEY (id_tipoCargo) REFERENCES tipo_cargo(id)
-- );

CREATE TABLE idioma_alumno(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT NOT NULL,
    id_nivel_idioma INT NOT NULL,
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id),
    FOREIGN KEY (id_nivel_idioma) REFERENCES nivel_idiomas(id)
);

CREATE TABLE practicas(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT NOT NULL,
    id_centro_trabajo INT NOT NULL,
    id_responsable INT NOT NULL,
    id_tutor INT NOT NULL,
    id_tipo_practica INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id),
    FOREIGN KEY (id_centro_trabajo) REFERENCES centros_trabajo(id),
    FOREIGN KEY (id_responsable) REFERENCES contactos(id),
    FOREIGN KEY (id_tutor) REFERENCES profesores(id),
    FOREIGN KEY (id_tipo_practica) REFERENCES tipos_practicas(id)
);



INSERT INTO `tipo_usuario` (`id`, `nombre`) VALUES (NULL, 'admin');
INSERT INTO `tipo_usuario` (`id`, `nombre`) VALUES (NULL, 'profesor');

INSERT INTO usuarios (username, nombre, apellidos, email, contrasena, telefono, id_tipo_usuario)
VALUES ('admin', 'admin', 'admin', 'admin@admin', 'admin', '123456789', 1);

-- INSERT INTO ciclos (nombre) VALUES ('DAW');
-- INSERT INTO ciclos (nombre) VALUES ('DAM');
-- INSERT INTO ciclos (nombre) VALUES ('ASIR');
-- INSERT INTO ciclos (nombre) VALUES ('AD');
-- INSERT INTO ciclos (nombre) VALUES ('ADE');
-- INSERT INTO ciclos (nombre) VALUES ('ASI');
-- INSERT INTO ciclos (nombre) VALUES ('AF');
-- INSERT INTO ciclos (nombre) VALUES ('EI');
-- INSERT INTO ciclos (nombre) VALUES ('MP');
-- INSERT INTO ciclos (nombre) VALUES ('DAM');
-- INSERT INTO ciclos (nombre) VALUES ('DAW');
-- INSERT INTO ciclos (nombre) VALUES ('STI');
-- INSERT INTO ciclos (nombre) VALUES ('GA');
-- INSERT INTO ciclos (nombre) VALUES ('GV');
-- INSERT INTO ciclos (nombre) VALUES ('TLYL');
-- INSERT INTO ciclos (nombre) VALUES ('TFP');
-- INSERT INTO ciclos (nombre) VALUES ('TES');
-- INSERT INTO ciclos (nombre) VALUES ('TME');
-- INSERT INTO ciclos (nombre) VALUES ('TIEA');
-- INSERT INTO ciclos (nombre) VALUES ('TSAF');
-- INSERT INTO ciclos (nombre) VALUES ('TSDAMR');


-- INSERT INTO alumnos (dni, nombre, apellidos, poblacion, email, otra_titulacion, vehiculo, id_ciclo) VALUES 
-- ('12345678A', 'Juan', 'García Pérez', 'Madrid', 'juan.garcia@example.com', 'Bachillerato', 1, 1),
-- ('98765432B', 'María', 'Martínez López', 'Barcelona', 'maria.martinez@example.com', NULL, 0, 2),
-- ('56789012C', 'Carlos', 'Fernández Rodríguez', 'Valencia', 'carlos.fernandez@example.com', 'Ciclo Formativo de Grado Medio', 1, 3),
-- ('34567890D', 'Ana', 'Sánchez Gómez', 'Sevilla', 'ana.sanchez@example.com', 'Ciclo Formativo de Grado Superior', 0, 4),
-- ('90123456E', 'Laura', 'González Martín', 'Zaragoza', 'laura.gonzalez@example.com', NULL, 1, 5),
-- ('78901234F', 'David', 'López Hernández', 'Málaga', 'david.lopez@example.com', NULL, 0, 6),
-- ('23456789G', 'Sara', 'Pérez García', 'Alicante', 'sara.perez@example.com', 'Formación Profesional Básica', 1, 7),
-- ('45678901H', 'Pedro', 'Rodríguez Martínez', 'Murcia', 'pedro.rodriguez@example.com', NULL, 0, 8),
-- ('67890123I', 'Carmen', 'Martín Sánchez', 'Bilbao', 'carmen.martin@example.com', NULL, 1, 9);
