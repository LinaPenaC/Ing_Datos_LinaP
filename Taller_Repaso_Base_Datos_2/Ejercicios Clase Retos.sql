create database BDMental;

use BDMental;

CREATE TABLE Usuario (
    idUsuario INT primary key,
    nombre VARCHAR(100) not null,
    contrasenia varchar(10) not null,
    correo varchar(10) not null,
    fechaNacimiento  date not null,
    genero enum('F', 'M'),
    carrera varchar(100),
    fechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP
);

create table SesionesMindfulness(
idSesion INT PRIMARY KEY AUTO_INCREMENT,
titulo varchar(100) not null,
duracion int not null,
nivelDificultad enum('basico','intermedio','avanzado') not null,
descripcion text,
idUsuarioFK int not null,
foreign key (idUsuarioFK) references Usuario(idUsuario)
);

create table bitacoraAnimo(
idBitacora INT PRIMARY KEY AUTO_INCREMENT,
estadoEmocional varchar(100) not null,
fecha date not null,
nota text,
recomendaciones text,
idUsuarioFK int not null,
foreign key (idUsuarioFK) references Usuario(idUsuario)
);

create table recordatorio(
idRecordatorio INT PRIMARY KEY AUTO_INCREMENT,
recordatorio varchar(100),
idUsuarioFK int not null,
foreign key (idUsuarioFK) references Usuario(idUsuario)
);

create table tareaAcademica(
idTarea INT PRIMARY KEY AUTO_INCREMENT,
fechaTarea date not null,
descripcion text not null,
prioridad varchar(20) not null,
estado enum('pendiente','en proceso', 'completado'),
idUsuarioFK int not null,
foreign key (idUsuarioFK) references Usuario(idUsuario)
);

create table gruposApoyo(
idGrupo INT PRIMARY KEY AUTO_INCREMENT,
tematicaGrupo varchar(100) not null
);

create Table detallesGrupos(
idDetalles INT PRIMARY KEY AUTO_INCREMENT,
idUsuarioFK int not null,
idGrupoFK int not null,
foreign key (idUsuarioFK) references Usuario(idUsuario),
foreign key (idGrupoFK) references gruposApoyo(idGrupo)
);

alter table SesionesMindfulness add fechaFinal date not null;
alter table SesionesMindfulness add estado enum('sin iniciar','en proceso', 'completado');

/*Inserciones*/
insert into usuario values (1,'Luis', '1pp','luis@gmail.com','1987-03-21','F','Sociologia',''),
(2,'Luisa', '1fp','luisa@gmail.com','1985-02-11','M','Sociologia',''),
(3,'Luigi', '10p','luigi@gmail.com','1997-05-01','F','Sociologia','');

insert into sesionesMindfulness values ('','Ayuda mental', 30,'avanzado','Ayuda urgente para toma de decisión',
3,'sin iniciar','completado'),('','Asesoria colsulta', 40,'basico','Asesoria para tomer decision',
1,'en proceso','completado');

insert into bitacoraAnimo values ('','triste','2023-12-23','No me gustó este dia','Meditar',2),
('','feliz','2022-12-20','Me gustó este dia','Meditar más',3);

desc gruposApoyo;
insert into tareaAcademica values ('','2025-12-23', 'Escribir caracteristicas','Alta','pendiente',3),
('','2025-12-13', 'Escribir notas','Baja','pendiente',1);

insert into recordatorio values ('','beber agua',1),('','tomar pasta',2),('','comer almuerzo',3);

insert into gruposApoyo values ('','Baile'),('','Yoga'),('','Arte');

insert into detallesGrupos values ('',1,1),('',2,1), ('',3,3);

select * from bitacoraAnimo;

select u.nombre, g.tematicaGrupo from Usuario u inner join detallesGrupos d on d.idUsuarioFK = u.idUsuario
inner join gruposApoyo g on g.idGrupo = d.idGrupoFK;

/*Lista sesiones mindfulnes completadas por un usuario*/
desc tareaAcademica;
 
/**/
create view vista_actividades_usuario as select u.nombre,u.correo, count(t.idTarea) as TareasPendientes
from usuario u left join tareaAcademica t on u.idUsuario = t.idUsuarioFK where t.estado = 'pendiente';

select g.idGrupo, COUNT(d.idDetalles) as cantidadUsuarios from gruposApoyo g 
inner join detallesGrupos d on g.idGrupo = d.idGrupoFK 
GROUP BY g.idGrupo order by cantidadUsuarios desc;

DELIMITER //
CREATE PROCEDURE agregar_bitacora(in p_estado varchar(100), in p_fecha date, in p_nota text, in p_reco text,
in idUs int )
BEGIN
    insert into bitacoraAnimo values ('',p_estado,p_fecha,p_nota,p_reco,idUs);
END //
DELIMITER ;

call agregar_bitacora('triste','2023-12-23','No me gustó este dia','Meditar',2);

