/*Creación de las tablas*/
drop database votaciones2503816;

create database votaciones2503816;
use votaciones2503816;
create table Curso(
  idCurso int primary key,
  nomCurso int not null,
  estadoCu bool not null
);

CREATE TABLE Genero(
  idGenero int primary key,
  nomGenero varchar(15) not null,
  estadoG bool not null
);

create table Jornada(
  idJornada int primary key,
  nomJornada varchar(15) not null,
  estadoJ bool not null
);

create table TipoDocumento(
  idTipoDoc int primary key,
  nomTipoDoc varchar(20) not null,
  estadoTD bool not null
);

create table Concejo(
  idConcejo int primary key,
  nomConcejo varchar(20) not null,
  estadoCO bool not null
);

create table TipoMiembro(
  idTipoMiembro int primary key,
  nomTipoMiembro varchar(15) not null,
  estadoTM bool not null
);

create table Cargo(
  idCargo int primary key,
  nomCargo varchar(15) not null,
  idConcejoFK int not null,
  estadoC bool not null,
  FOREIGN KEY (idConcejoFK) REFERENCES Concejo(idConcejo)
);

create table Eleccion(
  idEleccion int primary key,
  fechaEleccion date not null,
  anioEleccion year not null,
  estadoEl bool not null
);

create table Usuario(
  idUsuario int primary key,
  noDocUsuario int not null,
  idTipoDocFK int not null,
  nombreUsuario varchar(50) not null,
  apellidoUsuario varchar(50) not null,
  idGeneroFK int not null,
  fechaNacUsuario date not null,
  emailUsuario varchar(50) not null,
  passwordUsuario varchar(30) not null,
  fotoUsuario blob null,
  idJornadaFK int not null,
  idTipoMiembroFK int not null,
  idCursoFK int not null,
  estadoU bool not null,
  FOREIGN key (idTipoDocFK) references TipoDocumento(idTipoDoc),
  FOREIGN key (idGeneroFK) references Genero(idGenero),
  FOREIGN key (idJornadaFK) references Jornada(idJornada),
  FOREIGN key (idTipoMiembroFK) references TipoMiembro(idTipoMiembro),
  FOREIGN key (idCursoFK) references Curso(idCurso)
);

Create table Postulacion_Candidato(
  idPostCandidato int primary key,
  idUsuarioFK int not null,
  idEleccionFK int not null,
  idCargoFK int not null,
  propuestas varchar(100),
  totalVotos int not null,
  estadoCan bool not null,
  FOREIGN key (idUsuarioFK) REFERENCES Usuario(idUsuario),
  FOREIGN key (idEleccionFK) REFERENCES Eleccion(idEleccion),
  FOREIGN key (idCargoFK) REFERENCES Cargo(idCargo)
);

create table Votacion(
  idVotacion int primary key,
  horaVotacion time not null,
  idUsuarioVotanteFK int not null,
  idPostCandidatoFK int not null,
  estadoV bool not null,
  FOREIGN key (idUsuarioVotanteFK) references Usuario(idUsuario),
  FOREIGN key (idPostCandidatoFK) references Postulacion_Candidato(idPostCandidato)
);

/*Inserción de Datos a las tablas*/

insert into Genero values (1,'Femenino',true), (2,'Masculino',true);
Insert into Jornada Values (1,'Mañana',true),(2,'Tarde',true),(3,'Noche',true);
Insert into TipoDocumento values (1,'Tarjeta de Identidad',true),(2,'Cédula Ciudadanía',true),
(3,'Cédula Extranjeria',true),(4,'Pasaporte',true),(5,'NUIP',false);
insert into TipoMiembro values (1,'Estudiante',true), (2,'Profesor',true), (3,'Acudiente',true);
insert into Curso VALUES (1,'901',true), (2,'902',true), (3,'1001',true), (4,'1002',true), (5,'1003',false),
(6,'1101',true), (7,'1102',true), (8,'1103',false);
insert into Concejo values (1,'Concejo Académico',true), (2,'Concejo Directivo',true),(3,'Concejo Convivencia',true);
INSERT into Cargo VALUES (1,'Personero',1,true), (2,'Contralor',1,true), (3,'Cabildante',1,true);
insert into Eleccion values (1,'2020-04-20',2020,true), (2,'2019-04-15',2019,true), (3,'2019-04-12',2019,false), 
(4,'2018-04-14',2018,true), (5,'2017-04-12',2017,true);
/*Insertar Usuarios*/
insert into Usuario values (1,1,1,'VOTO','BLANCO',2,'0000-00-00','','',null,1,1,3,true),
(2,1010123456,1,'DAVID SANTIAGO','LÓPEZ MORA',2,	'2004-10-11','davidLopez456@hotmail.com','David2004',null,1,1,1,true),
(3,1010123789,1,'LAURA MILENA','GOMEZ BONILLA',1,'2004-03-17','lauragomez@gmail.com','Gomez2004',null,1,1,1,true),
(4,1010123741,1,'DIEGO FERNANDO','CAÑON VARGAS',2,'2003-05-20',	'diegocanon@hotmail.com','Diego2003',null,1,1,1,true),
(5,1010123852,1,'TATIANA','VARGAS CABRERA',1,'2003-11-28','tatacabrera@gmail.com','Cabrera2003',null,1,1,3,true),
(6,1010123963,1,'LEYDY KATHERINE','FERNANDEZ RODRIGUEZ',1,'2004-06-28','leydy2004@gmail.com','Leydy2004',null,1,1,4,true),
(7,1010123654,2,'MAURICIO','BERMUDEZ AMAYA',2,'2002-01-26','maobermudez@gmail.com','Amaya2002',null,1,1,4,true),
(8,1010741258,1,'ANDRES FELIPE','RODRIGUEZ PEREZ',2,'2004-03-23','andyrodriguez@gmail.com','Arodriguez2004',null,1,1,3,true),
(9,1010236859,1,'MARIA ANGÉLICA','TRIVIÑO LATORRE',1,'2002-02-04','angelicatri@gmail.com','Trivino2002',null,1,1,3,true),
(10,1010236963,1,'GENARO','VASQUEZ RODRIGUEZ',2,'2002-11-14','gevasquez@gmail.com','Vasquez123', null,1,1,3,false);
insert into Postulacion_Candidato values (1,1,1,1,'Mejorar entrega refrigerios, Alargar descansos',0,true),
(2,5,1,1,'Mejorar entrega refrigerios, Alargar descansos',0,true),
(3,7,1,1,'Mejorar sala de informática, Construir piscina',0,true);
insert into Votacion values (1,'12:08:15',1,1,true), (2,'12:12:35',2,3,true), (3,'12:14:18',3,2,true),
(4,'12:15:58',4,2,true), (5,'12:18:02',5,3,true),(6,'12:24:22',6,3,true), (7,'12:28:02',7,3,true), 
(8,'12:30:14',8,2,true), (9,'12:40:20',9,2,true), (10,'12:45:20',10,2,true);

/*Consulta que muestra el nombre de cada Concejo, que tenga asignado un cargo con el nombre 
del cargo al que pertenece y el estado actual del mismo*/
select  nomConcejo, nomcargo, estadoC from Cargo inner JOIN Concejo  on Cargo.idConcejoFK = Concejo.idConcejo;

/*Consulta que muestra el nombre de cada concejo, el nombre del cargo al que pertenece y el estado actual del mismo tenga o no cargo asignado*/
SELECT nomConcejo, nomcargo, estadoc From Concejo c left join Cargo ca on ca.idConcejoFK = c.idConcejo ;

/*Consulta que muestre cada usuario con su jornada, tipo de miembro y curso*/
select u.nombreusuario,u.apellidousuario,j.nomjornada,tm.nomTipoMiembro,cu.nomcurso from Usuario u inner join Jornada j ON
u.idjornadafk = j.idJornada inner join TipoMiembro tm on u.idtipomiembrofk = tm.idtipomiembro inner join Curso cu on 
u.idcursofk = cu.idCurso;

/*Agregue el campo a la tabla estudiante llamada profesión*/
ALTER table Usuario add COLUMN profesion varchar(50) null;

/*Realice una consulta que muestre la cantidad de votos obtenidos por cada candidato en las votaciones registradas. */
SELECT u.nombreusuario, u.apellidousuario, count(v.idvotacion) as totalvotos 
FROM Postulacion_Candidato p 
JOIN Usuario u ON u.idUsuario =  p.idUsuarioFK
LEFT join Votacion v on v.idPostCandidatoFK = p.idPostCandidato 
group by p.idPostCandidato, u.nombreusuario, u.apellidousuario 
order by totalvotos desc;

/*Implementación procedimientos almacenados*/
DELIMITER //
CREATE procedure InactivarUusuario(in p_ideUsuario INT)
BEGIN
	update Usuario
    set estadou = false
    where idusuario = p_ideUsuario;
END//
DELIMITER ;
CALL InactivarUusuario(3);

DELIMITER //
CREATE PROCEDURE ConsultarCantidadUsuariosCurso(IN p_idCurso int)
BEGIN
    SELECT c.nomCurso AS 'Curso', COUNT(u.idUsuario) AS 'Cantidad Usuarios' FROM Usuario u
    INNER JOIN Curso c ON u.idCursoFK = c.idCurso WHERE u.idCursoFK = p_idCurso
    GROUP BY c.nomCurso;
END//
DELIMITER ;
CALL ConsultarCantidadUsuariosCurso(1);

DELIMITER //
CREATE PROCEDURE EliminarCandidato(IN p_idCandidato INT)
BEGIN
    DELETE FROM Postulacion_Candidato
    WHERE idpostcandidato = p_idCandidato;
END//
DELIMITER ;
call EliminarCandidato(2);

/*Implementación vistas*/
CREATE VIEW CandidatosVotos AS
SELECT u.nombreusuario, u.apellidousuario, count(idvotacion) as totalvotos 
FROM Postulacion_Candidato p JOIN Usuario u ON u.idUsuario =  p.idUsuarioFK
LEFT join Votacion v on v.idPostCandidatoFK = p.idPostCandidato 
group by p.idPostCandidato, u.nombreusuario, u.apellidousuario order by totalvotos desc;
SELECT * FROM CandidatosVotos;

CREATE VIEW UsuariosVotaronPorCandidato AS
SELECT u.idUsuario, u.nombreUsuario, u.apellidoUsuario, u.emailUsuario, c.idPostCandidato,
c.propuestas AS 'Propuestas del Candidato', v.estadoV AS 'Voto Válido'
FROM Votacion v JOIN Usuario u ON v.idUsuarioVotanteFK = u.idUsuario
JOIN Postulacion_Candidato c ON v.idPostCandidatoFK = c.idPostCandidato
WHERE v.estadoV = TRUE;
SELECT * FROM UsuariosVotaronPorCandidato;

CREATE VIEW CandidatosPorCargoYEleccion AS
SELECT u.nombreusuario,  u.apellidousuario, c.nomCargo,
e.fechaEleccion, e.anioEleccion
FROM Postulacion_Candidato p
JOIN Usuario u ON u.idUsuario = p.idUsuarioFK
JOIN Cargo c ON c.idCargo = p.idCargoFK
JOIN Eleccion e ON e.idEleccion = p.idEleccionFK;
SELECT * FROM CandidatosPorCargoYEleccion;

/*Implementación Subconsultas*/
SELECT nombreusuario, apellidousuario, totalvotos
FROM CandidatosVotos
WHERE totalvotos = (SELECT MAX(totalvotos) FROM CandidatosVotos);


