CREATE DATABASE DataVerse;

USE DataVerse;

-- Tabla de Usuarios
CREATE TABLE Usuarios (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) not null
);

-- Tabla de Sensores IoT
CREATE TABLE Sensores_IoT (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    tipoSensor VARCHAR(50) not null,
    ubicacion VARCHAR(255) not null,
    fechaInstalacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado bool not null
);

-- Tabla de Redes de Transporte
CREATE TABLE Redes_Transporte (
    idRed INT PRIMARY KEY AUTO_INCREMENT,
    tipoRed VARCHAR(50), --  'Metro', 'Autobús', etc.
    estado_red bool not null,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Consumo Energético
CREATE TABLE Consumo_Energetico (
    idConsumo INT PRIMARY KEY AUTO_INCREMENT,
    tipoConsumo VARCHAR(50) null, -- Ej. 'Residencial', 'Comercial', 'Industrial'
    cantidadCon double not null,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ubicacion VARCHAR(50)
);

-- Tabla de Alertas y Predicciones
CREATE TABLE AlertaPrediccion (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    fecha_alerta DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipoAlerta enum('transporte', 'seguridad','redes sociales','sensoresIoT', 'energía')
);

create table detallesAlerta (
 idDetallesAlerta int auto_increment primary key,
 idAlertaFK int not null,
 idUsuarioFK int not null,
 foreign key (idAlertaFK) references AlertaPrediccion(idAlerta),
 foreign key (idUsuarioFK) references Usuario(idUsuario)
);

CREATE TABLE Alertas_Transporte (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idAlertaFK INT NOT NULL,
    idRedFK INT NOT NULL,
    FOREIGN KEY (idAlertaFK) REFERENCES AlertaPrediccion(idAlerta),
    FOREIGN KEY (idRedFK) REFERENCES Redes_Transporte(idRed)
);

CREATE TABLE Alertas_Consumo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idAlertaFK INT NOT NULL,
    idConsumoFK INT NOT NULL,
    FOREIGN KEY (idAlertaFK) REFERENCES AlertaPrediccion(idAlerta),
    FOREIGN KEY (idConsumoFK) REFERENCES Consumo_Energetico(idConsumo)
);

CREATE TABLE Alertas_Sensores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idAlertaFK INT NOT NULL,
    idSensorFK INT NOT NULL,
    FOREIGN KEY (idAlertaFK) REFERENCES AlertaPrediccion(idAlerta),
    FOREIGN KEY (idSensorFK) REFERENCES Sensores_IoT(idSensor)
);

/*
ejemplos triggers

CREATE TRIGGER auditar_insert_empleados
AFTER INSERT ON empleados
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_empleados (accion, fecha, id_empleado, nombre)
    VALUES ('INSERT', NOW(), NEW.id_empleado, NEW.nombre);
END;

CREATE TRIGGER auditar_update_salario
BEFORE UPDATE ON empleados
FOR EACH ROW
BEGIN
    IF OLD.salario <> NEW.salario THEN
        INSERT INTO historico_salarios (id_empleado, salario_anterior, salario_nuevo, fecha)
        VALUES (OLD.id_empleado, OLD.salario, NEW.salario, NOW());
    END IF;
END;

DELIMITER //

CREATE PROCEDURE obtener_empleados_por_salario(IN salario_minimo DECIMAL)
BEGIN
    SELECT id_empleado, nombre, salario
    FROM empleados
    WHERE salario > salario_minimo;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE actualizar_salario(IN id_emp INT, IN nuevo_salario DECIMAL)
BEGIN
    UPDATE empleados
    SET salario = nuevo_salario
    WHERE id_empleado = id_emp;
END //

DELIMITER ;


*/