create database TechCorp;
use TechCorp;

/* Crear tabla departamento*/
CREATE TABLE departamento (
    idDep INT PRIMARY KEY,
    nombreDep VARCHAR(100) NOT NULL
);

/* Insertar algunos departamentos*/
INSERT INTO departamento VALUES (1,'Ventas'), (2,'IT'), (3,'Recursos Humanos'), (4,'Marketing'), (5,'Tecnologia');

/* Crear tabla empleado*/
CREATE TABLE empleado (
    idEmpleado INT AUTO_INCREMENT PRIMARY KEY,
    nombreEmp VARCHAR(100) NOT NULL,
    edad INT NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    departamento_idFK INT not null,
    idCargoFK varchar(100) not null,
    FOREIGN KEY (departamento_idFK) REFERENCES departamento(idDep),
    FOREIGN KEY (idCargoFK) REFERENCES cargo(idCargo)
);

create table cargo(
idCargo varchar(100) primary key,
nombreCargo varchar(100) not null,
rango varchar(100) not null,
descripcion varchar(100) not null
);

INSERT INTO cargo VALUES (1,'Gerente','alto', 'Encargado de gerencia'),(2,'Vendedor','bajo', 'Encargado de ventas'),
(3,'Supervisor','medio', 'Supervisa vendendedores'),(4,'Director general','alto', 'Dirige departamentos'),
(5,'Coordinador','medio', 'Coordina vendedores');

/* Insertar algunos empleados*/
INSERT INTO empleado VALUES
('','Ana Pérez', 35, 4500.00, '2018-05-12', 1,1),
('','Carlos Gómez', 29, 3500.00, '2021-08-15', 2,2),
('','Pedro Fernández', 45, 5500.00, '2019-06-22', 3,2),
('','Claudia Romero', 32, 4800.00, '2022-01-10', 4,3),
('','Luis Martínez', 37, 4600.00, '2017-11-30', 1,4),
('','Andrés Sánchez', 28, 4000.00, '2021-04-02', 2,5),
('','Lucía García', 42, 5200.00, '2020-10-10', 3,2),
('','Ana', 29, 4000.00, '2021-10-10', 3,2),
('','Carolina López', 34, 4100.00, '2021-07-22', 4,5);

/*Consulta de nombres de empleados y depeartamentos a los que pertenecen */
select nombreEmp as 'Nombre Empleado',nombreDep as 'Nombre departamento 'from empleado inner join departamento 
on empleado.departamento_idFK=departamento.idDep;

/*CONSULTA TODOS LOS CARGOS CON UN RANGO ESPECíIFICO*/
select nombreCargo as 'Cargos de rango alto' from cargo where rango='alto';

/*MOSTRAR EN PANTALLA EMPLEADOS CON UN CARGO ESPECÍFICO*/
/*select nombreEmp as 'Empleados con cargo vendedor' from empleado where idCargoFK=2;
select nombreEmp as 'Empleados con cargo vendedor', nombreCargo as 'Cargo Vendedor' from empleado inner join cargo 
on empleado.idCargoFK=cargo.idCargo where nombreCargo = 'Vendedor';*/
select nombreEmp as 'Empleados con cargo vendedor' from empleado inner join cargo 
on empleado.idCargoFK=cargo.idCargo where nombreCargo = 'Vendedor';


/*EMPLEADOS CON ANTIGUEDAD DE MÁS DE 3 AÑOS Y A QUE DEPARTAMENTO PERTENECES, QUE SALARIO TIENE Y QUE CARGO TIENE*/
select nombreEmp as 'Nombre Empleado ',fecha_contratacion as 'Fecha contratación', nombreDep as 'Nombre departamento ', 
salario as 'Salario', nombreCargo as 'Cargo'
from empleado inner join departamento on empleado.departamento_idFK=departamento.idDep
inner join cargo on empleado.idCargoFK=cargo.idCargo where (2025-year(fecha_contratacion)) > 3;

/*MOSTRAR NOMBRE, FECHA CONTRATACION, DEPARTAMENTO CONTRATADO, AÑOS ANTIGUEDAD, CARGO ACTUALMENTE Y RANGO*/
select nombreEmp as 'Nombre Empleado ',fecha_contratacion as 'Fecha contratación', nombreDep as 'Nombre departamento ', 
timestampdiff(year, fecha_contratacion,curdate()) as 'Años trabajados', nombreCargo as 'Cargo Actual', rango as 'Rango' 
from empleado inner join departamento on empleado.departamento_idFK=departamento.idDep
inner join cargo on empleado.idCargoFK=cargo.idCargo;

/*Departamento sin empleados asignados*/
select * from departamento inner join empleado on departamento.idDep=empleado.departamento_idFK where (select count(departamento_idFK) from empleado) = 0;

/*Cargos sin empleados asignados*/
select * from cargo inner join empleado on cargo.idCargo=empleado.idCargoFK where idCargoFK is null;

/*Obtengo nombres, edades y salarios de todos los empleados*/
select nombreEmp, edad, salario from empleado;

/*Empleados con salario mayor a 4000*/
SELECT nombreEmp from empleado where salario > 4000;

/*Empleados cuyo departamento es 'Ventas'*/
/*Identifico Id del departamento de ventas*/
select idDep from departamento where nombreDep = 'Ventas'; 
SELECT nombreDep from empleado where departamento_idFK = 1;

/*Empleados entre 30 y 40 años*/
SELECT nombreEmp from empleado where edad >= 30 and edad <=40;

/*Empleados contratados despues del 2020*/
Select nombreEmp from empleado where fecha_contratacion >= '2021-01-01';

/*Cantidad empleados por departamento*/
select count(departamento_idFK) as 'Numero de empleados de ventas' from empleado where departamento_idFK=1;
select count(departamento_idFK) as 'Numero de empleados de IT' from empleado where departamento_idFK=2;
select count(departamento_idFK) as 'Numero de empleados de Recursos Humanos' from empleado where departamento_idFK=3;
select count(departamento_idFK) as 'Numero de empleados de Marketing' from empleado where departamento_idFK=4;

/*Salario promedio de la empresa*/
select AVG(salario) from empleado;

/*Empleados cuyos nombres comiezan por 'A' o por 'C'*/
select * from empleado where nombreEmp like 'A%' or nombreEmp like 'C%';

/*Empleados que no pertenecen al departamento 'IT'*/
SELECT id from departamento where nombreDep = 'IT'; /*Para saber el id del departamento*/
SELECT * from empleado where departamento_idFK != 2;

/*Empleado con el salario más alto*/
select nombre,salario from empleado where salario = (select max(salario) from empleado);

/*Consultar valor dentro de una lista de valores*/
select * from empleado where departamento_idFK in (1,2,4);

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
select departamento_idFK as 'Departamento con mas empleados' from empleado;

/*EMPLEAODS MAS ANTIGUOS Y MEJORES PAGADOS*/
/*select * from empleado order by (select timestampdiff(year, fecha_contratacion,curdate()) as 'Años trabajados' from empleado) and salario desc;*/

select departamento_idFK, count(*) as 'total empleados' from empleado group by departamento_idFK having count(*) >=5;

/*ACTUALIZAR DATOS*/
/*Sintaxis update nombreTabla set campo1 'valordeReemplazo', campo2 'valorderemplazo' where llave primaria='valor' */
update empleado set nombre = 'Gabriel' where id = 2;






