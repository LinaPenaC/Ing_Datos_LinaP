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

/*Consultar valor dentro de una lista de valores*/
select * from empleado where departamento_id in (1,2,4);

/*Si un campo es nulo*/
select * from empleado where edad is null;

/*RETOS :)*/
select salario from empleado order by salario desc; /*mayor a menor salario*/
select * from empleado where departamento_id is null; /*empleados sin departamentos asociados*/
select *, (2025-year(fecha_contratacion)) from empleado; /*Cuantos años lleva tarbajando el empleado*/
select nombre,fecha_contratacion, timestampdiff(year, fecha_contratacion,curdate()) as 'Años trabajados' from empleado; /*Cuantos años lleva tarbajando el empleado*/

select * from empleado order by salario desc limit 3;
select *, salario*0.1 as 'Bono' from empleado where (2025-year(fecha_contratacion)) >= 5;

/*Cuantos empleados ganan mas que el salario promedio*/
select count(*) as 'Numero de empleados que ganan mas del promedio' from empleado where salario > (select avg(salario) from empleado); 

/*Consutar el d´partamento con mas empleaedos y ordenar d4e mayor a menor*/
select departamento_id as 'Departamento con mas empleados' from empleados
select nombre,(select count(*) from empleado where departamento_id =id) from departamento order by (select count(*) from empleado where departamento_id=id) desc;

/*EMPLEAODS MAS ANTIGUOS Y MEJORES PAGADOS*/
/*select * from empleado order by (select timestampdiff(year, fecha_contratacion,curdate()) as 'Años trabajados' from empleado) and salario desc;*/

select departamento_id, count(*) as 'total empleados' from empleado group by departamento_id having count(*) >=5;


/*ACTUALIZAR DATOS*/
/*Sintaxis update nombreTabla set campo1 'valordeReemplazo', campo2 'valorderemplazo' where llave primaria='valor' */
update empleado set nombre = 'Gabriel' where id = 2;

select * from empleado;

/*DELETE eliminar*/
/*sintaxis delete from nombreTable where condicion*/


