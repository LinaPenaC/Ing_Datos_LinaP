/*CONSULTAS*/

/* Crear la base de datos*/
create database TechCorp;
use TechCorp;

/* Crear tabla departamento*/
CREATE TABLE departamento (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

/* Insertar algunos departamentos*/
INSERT INTO departamento VALUES (1,'Ventas'), (2,'IT'), (3,'Recursos Humanos'), (4,'Marketing');

/* Crear tabla empleado*/
CREATE TABLE empleado (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    edad INT NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES departamento(id)
);

/* Insertar algunos empleados*/
INSERT INTO empleado (nombre, edad, salario, fecha_contratacion, departamento_id) VALUES
('Ana Pérez', 35, 4500.00, '2018-05-12', 1),
('Carlos Gómez', 29, 3500.00, '2021-08-15', 2),
('Pedro Fernández', 45, 5500.00, '2019-06-22', 3),
('Claudia Romero', 32, 4800.00, '2022-01-10', 4),
('Luis Martínez', 37, 4600.00, '2017-11-30', 1),
('Andrés Sánchez', 28, 4000.00, '2021-04-02', 2),
('Lucía García', 42, 5200.00, '2020-10-10', 3),
('Carolina López', 34, 4100.00, '2021-07-22', 4);

/*Obtengo nombres, edades y salarios de todos los empleados*/
select nombre, edad, salario from empleado;

/*Empleados con salario mayor a 4000*/
SELECT nombre from empleado where salario > 4000;

/*Empleados cuyo departamento es 'Ventas'*/
/*Identifico Id del departamento de ventas*/
select id from departamento where nombre = 'Ventas'; 
SELECT nombre from empleado where departamento_id = 1;

/*Empleados entre 30 y 40 años*/
SELECT nombre from empleado where edad >= 30 and edad <=40;

/*Empleados contratados despues del 2020*/
Select nombre from empleado where fecha_contratacion >= '2021-01-01';

/*Cantidad empleados por departamento*/
select count(departamento_id) as 'Numero de empleados de ventas' from empleado where departamento_id=1;
select count(departamento_id) as 'Numero de empleados de IT' from empleado where departamento_id=2;
select count(departamento_id) as 'Numero de empleados de Recursos Humanos' from empleado where departamento_id=3;
select count(departamento_id) as 'Numero de empleados de Marketing' from empleado where departamento_id=4;

/*Salario promedio de la empresa*/
select AVG(salario) from empleado;

/*Empleados cuyos nombres comiezan por 'A' o por 'C'*/
select * from empleado where nombre like 'A%' or nombre like 'C%';

/*Empleados que no pertenecen al departamento 'IT'*/
SELECT id from departamento where nombre = 'IT'; /*Para saber el id del departamento*/
SELECT * from empleado where departamento_id != 2;

/*Empleado con el salario más alto*/
select nombre,salario from empleado where salario = (select max(salario) from empleado);
