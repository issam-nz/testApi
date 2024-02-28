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
    nombre INT NOT NULL
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
    id_tipo_usuario INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
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