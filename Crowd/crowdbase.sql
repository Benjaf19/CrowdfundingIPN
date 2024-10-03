drop database if exists crowdfunding;

create database crowdfunding;
use crowdfunding;
create table UsuarioN(
boleta int not null primary key,
nombre nvarchar(100) not null,
apellidos nvarchar(100) not null,
escuela nvarchar(300) not null,
edad int not null,
correo nvarchar(100) not null,
paswd nvarchar(128) not null,
fRegistro date
);
drop table if exists proyectos;
create table proyectos(
idProyecto int primary key not null, 
nombre nvarchar(120) not null ,
descripcion nvarchar(800) not null,
imagen longblob,
financiacion float not null, 
plazotiempo int not null,
recompensas nvarchar(800) not null,
categoria nvarchar(32) not null
);

CREATE TABLE IF NOT EXISTS Colaborador(
  idColaborador INT PRIMARY KEY NOT NULL,
  Carrera NVARCHAR(100) NOT NULL,
  infoExtra NVARCHAR(600) ,
  foto longblob );
  drop table if exists SolicitudColaborador;
  create table SolicitudColaborador(
  idSolicitud int not null primary key,
  idProyecto int not null, 
  idColaborador int not null, 
  boleta int not null,
  validar boolean not null default false,foreign key(idColaborador) references Colaborador(idColaborador),
  foreign key(boleta) references UsuarioN(boleta),
  foreign key(idProyecto) references proyectos(idProyecto)
  
  );
  
CREATE TABLE IF NOT EXISTS Paypal (
  idPaypal INT PRIMARY KEY NOT NULL,
  CorreoPP NVARCHAR(200) NOT NULL,
  contraseña NVARCHAR(120) NOT NULL
  );
drop table if exists Tarjeta;
CREATE TABLE IF NOT EXISTS Tarjeta (
  idTarjeta INT PRIMARY KEY NOT NULL,
  NumTrajeta nvarchar(16) not NULL,
  CodigoSeg INT(3) NOT NULL,
  fechaVence nvarchar(120) NOT NULL,
  Direccion NVARCHAR(200) NOT NULL,
  TipoTag NVARCHAR(16) NOT NULL
  );
  drop table if exists Carreras;
CREATE TABLE IF NOT EXISTS Carreras (
   idCarrera int not null primary key auto_increment,
  CECYT nvarchar(10) NOT NULL,
  carrera nvarchar(200) NOT NULL
  
  );
  
  create table relColabUsN(
  idrelColabUsN int primary key not null, idColaborador int not null, boleta int not null,
  foreign key(idColaborador) references Colaborador(idColaborador),
  foreign key(boleta) references UsuarioN(boleta)
  );
  
  create table relUsNProyect(
  idrelUsNProyect int primary key not null, boleta int(10) not null, idProyecto int not null,
  foreign key(boleta) references UsuarioN(boleta),
  foreign key(idProyecto) references proyectos(idProyecto)
  );
  create table relPaypalusn(
   idrelPaypalusn int,
   idPaypal int,
   boleta int,
   foreign key(boleta) references UsuarioN(boleta),
    foreign key(idPaypal) references Paypal(idPaypal)
  );
  drop table if exists relTarjetausn;
  create table relTarjetausn(
   idrelTarjetausn int,
   idTarjeta int,
   boleta int,
   foreign key(boleta) references UsuarioN(boleta),
    foreign key(idTarjeta) references Tarjeta(idTarjeta)
  );
  create table donacion(
  idDonacion int primary key not null,
  idProyecto int not null,
  boleta int not null,
dineroDonado double not null,
foreign key(boleta) references UsuarioN(boleta),
foreign key(idProyecto) references proyectos(idProyecto)
   
  );
  drop table if exists faq;
  create table faq(
  idfaq int not null primary key, 
  pregunta nvarchar(1000) not null,
  respuesta nvarchar(1000) default 'Pendiente',
  validar boolean not null);
  
  drop table if exists tickets;
  create table tickets(
  folio int(6) primary key not null,
  remitente int(10) not null,
  receptor nvarchar(200) not null,
  problema nvarchar(5000) not null,
  estado nvarchar(60) not null,
  fecha date not null,
  asunto nvarchar(500) not null,
  tipoProblema nvarchar(100) not null,
  avances nvarchar(1000) not null default 'Pendiente',
  foreign key(remitente) references UsuarioN(boleta)
  );
  
  drop table if exists Foro;
  create table Foro (
  idForo int not null primary key,
  pregunta nvarchar(1000) not null,
  creador nvarchar(120) not null,
  fecha date not null,
  asunto nvarchar(300) not null, 
  categoria nvarchar(200) not null,
  imagen longblob
  
  
  );
  
  drop table if exists RespuestaForo;
  create table RespuestaForo(
  idRespuesta int not null primary key,
  respuesta nvarchar(1000) not null,
  usuario nvarchar(120) not null,
  idForo int not null,
  foreign key(idForo) references Foro(idForo)
  );
  drop table if exists RespuestaRes;
  create table RespuestaRes(
  idRespuestares int not null primary key,
  respuesta nvarchar(1000) not null,
  usuario nvarchar(120) not null,
  idRespuesta int not null,
  foreign key(idRespuesta) references RespuestaForo(idRespuesta)
  );
  
  
 /* drop table if exists metodosPago;
  create table metodosPago(
  idmetodosPago int primary key not null, idTarjeta int not null, idPaypal int default null, boleta int(10) not null,
  foreign key(boleta) references UsuarioN(boleta),
  foreign key(idTarjeta) references Tarjeta(idTarjeta),
  foreign key(idPaypal) references Paypal(idPaypal)
  );*/
  
insert into Carreras (CECYT,carrera)values('CECYT 1','Construcción');
insert into Carreras (CECYT,carrera)values('CECYT 1','Procesos industriales');
insert into Carreras (CECYT,carrera)values('CECYT 1','Sistemas de Control Eléctrico');
insert into Carreras (CECYT,carrera)values('CECYT 1','Sistemas Digitales');

insert into Carreras (CECYT,carrera)values('CECYT 2','Aeronáutica');
insert into Carreras (CECYT,carrera)values('CECYT 2','Dibujo Asistido por Computadora');
insert into Carreras (CECYT,carrera)values('CECYT 2','Diseño Gráfico Digital');
insert into Carreras (CECYT,carrera)values('CECYT 2','Máquinas con Sistemas Automatizados');
insert into Carreras (CECYT,carrera)values('CECYT 2','Metalurgia');
insert into Carreras (CECYT,carrera)values('CECYT 2','Sistemas Automotrices');

insert into Carreras (CECYT,carrera)values('CECYT 3','Sistemas Digitales');
insert into Carreras (CECYT,carrera)values('CECYT 3','Computación');
insert into Carreras (CECYT,carrera)values('CECYT 3','Sistemas de Control Eléctrico');
insert into Carreras (CECYT,carrera)values('CECYT 3','Manufactura Asistida por Computadora');
insert into Carreras (CECYT,carrera)values('CECYT 3','Aeronáutica');
insert into Carreras (CECYT,carrera)values('CECYT 3','Sistemas Automotrices');

insert into Carreras (CECYT,carrera)values('CECYT 4','Aeronáutica');
insert into Carreras (CECYT,carrera)values('CECYT 4','Construcción');
insert into Carreras (CECYT,carrera)values('CECYT 4','Instalaciones y Mantenimiento Eléctrico');
insert into Carreras (CECYT,carrera)values('CECYT 4','Procesos Industriales');
insert into Carreras (CECYT,carrera)values('CECYT 4','Sistemas Automotrices');

insert into Carreras (CECYT,carrera)values('CECYT 5','Comercio Internacional');
insert into Carreras (CECYT,carrera)values('CECYT 5','Contaduría');
insert into Carreras (CECYT,carrera)values('CECYT 5','Informática');

insert into Carreras (CECYT,carrera)values('CECYT 6','Ecología');
insert into Carreras (CECYT,carrera)values('CECYT 6','Enfermería');
insert into Carreras (CECYT,carrera)values('CECYT 6','Laboratorista Clínico');
insert into Carreras (CECYT,carrera)values('CECYT 6','Laboratorista Químico');
insert into Carreras (CECYT,carrera)values('CECYT 6','Nutrición Humana');
insert into Carreras (CECYT,carrera)values('CECYT 6','Químico Farmaceutico');

insert into Carreras (CECYT,carrera)values('CECYT 7','Aeronáutica');
insert into Carreras (CECYT,carrera)values('CECYT 7','Construcción´');
insert into Carreras (CECYT,carrera)values('CECYT 7','Instalaciones y Mantenimiento Eléctrico');
insert into Carreras (CECYT,carrera)values('CECYT 7','Mantenimiento Industrial');
insert into Carreras (CECYT,carrera)values('CECYT 7','Sistemas Automotrices');
insert into Carreras (CECYT,carrera)values('CECYT 7','Soldadura Industrial');

insert into Carreras (CECYT,carrera)values('CECYT 8','Plásticos');
insert into Carreras (CECYT,carrera)values('CECYT 8','Mantenimiento Industrial');
insert into Carreras (CECYT,carrera)values('CECYT 8','Computación');
insert into Carreras (CECYT,carrera)values('CECYT 8','Sistemas Automotrices');

insert into Carreras (CECYT,carrera)values('CECyT 9','Programación');
insert into Carreras (CECYT,carrera)values('CECyT 9','Sistemas Digitales');
insert into Carreras (CECYT,carrera)values('CECyT 9','Maquinas con Sistemas Automatizados');

insert into Carreras (CECYT,carrera)values('CECYT 10','Diagnóstico y Mejoramiento Ambiental');
insert into Carreras (CECYT,carrera)values('CECYT 10','Metrología y Control de Calidad');
insert into Carreras (CECYT,carrera)values('CECYT 10','Telecomunicaciones');

insert into Carreras (CECYT,carrera)values('CECYT 11','Construcción');
insert into Carreras (CECYT,carrera)values('CECYT 11','Instalaciones y Mantenimiento Eléctrico');
insert into Carreras (CECYT,carrera)values('CECYT 11','Procesos Industriales');
insert into Carreras (CECYT,carrera)values('CECYT 11','Telecomunicaciones');

insert into Carreras (CECYT,carrera)values('CECYT 12','Administración');
insert into Carreras (CECYT,carrera)values('CECYT 12','Contaduría');
insert into Carreras (CECYT,carrera)values('CECYT 12','Informática');

insert into Carreras (CECYT,carrera)values('CECYT 13','Administración');
insert into Carreras (CECYT,carrera)values('CECYT 13','Administración de Empresas Turísticas');
insert into Carreras (CECYT,carrera)values('CECYT 13','Contaduría');
insert into Carreras (CECYT,carrera)values('CECYT 13','Informática');

insert into Carreras (CECYT,carrera)values('CECYT 14','Contaduría');
insert into Carreras (CECYT,carrera)values('CECYT 14','Informática');
insert into Carreras (CECYT,carrera)values('CECYT 14','Administración de Recursos Humanos');
insert into Carreras (CECYT,carrera)values('CECYT 14','Mercadotecnia');

insert into Carreras (CECYT,carrera)values('CECYT 15','Alimentos');
insert into Carreras (CECYT,carrera)values('CECYT 15','Ecología');
insert into Carreras (CECYT,carrera)values('CECYT 15','Nutrición Humana');

insert into Carreras (CECYT,carrera)values('CECYT 16','Mantenimiento Industrial');
insert into Carreras (CECYT,carrera)values('CECYT 16','Máquinas con Sistemas Automatizados');
insert into Carreras (CECYT,carrera)values('CECYT 16','Procesos Industriales');
insert into Carreras (CECYT,carrera)values('CECYT 16','Enfermería');
insert into Carreras (CECYT,carrera)values('CECYT 16','Laboratorista Clínico');
insert into Carreras (CECYT,carrera)values('CECYT 16','Administración');
insert into Carreras (CECYT,carrera)values('CECYT 16','Comercio Internacional');

insert into Carreras (CECYT,carrera)values('CECYT 17','Aeronáutica');
insert into Carreras (CECYT,carrera)values('CECYT 17','Metrología y Control de Calidad');
insert into Carreras (CECYT,carrera)values('CECYT 17','Sistemas Automotrices');
insert into Carreras (CECYT,carrera)values('CECYT 17','Alimentos');
insert into Carreras (CECYT,carrera)values('CECYT 17','Administración de Empresas Turísticas');
insert into Carreras (CECYT,carrera)values('CECYT 17','Comercio Internacional');

insert into Carreras (CECYT,carrera)values('CECYT 18','Sistemas Digitales');
insert into Carreras (CECYT,carrera)values('CECYT 18','Laboratorista Químico');

insert into Carreras (CECYT,carrera)values('CET 1','Automatización y Control Eléctrico Industrial');
insert into Carreras (CECYT,carrera)values('CET 1','Redes de Cómputo');
insert into Carreras (CECYT,carrera)values('CET 1','Sistemas Automotrices');
insert into Carreras (CECYT,carrera)values('CET 1','Sistemas Constructivos Asistidos por Computadora');
insert into Carreras (CECYT,carrera)values('CET 1','Sistemas Mecánicos Industriales');
insert into Carreras (CECYT,carrera)values('CET 1','Sistemas Computacionales');


drop procedure if exists spGuardaUsuarioN;

delimiter **
create procedure spGuardaUsuarioN(in id int,in bol int, in nom nvarchar(100), in ape nvarchar(100), in esc nvarchar(300), in edad int ,in mail nvarchar(100), in pass nvarchar(128))
begin

declare err int;
declare msj nvarchar(100);
declare fecha date;
declare exis int;
if(id= 0)then
	set exis = (select count(*) from UsuarioN where (correo = mail)or(boleta = bol));
	if(exis =0)then
    set fecha = (select now());
	
	insert into UsuarioN values(bol, nom, ape,esc,edad,mail, pass,fecha);
    set err = bol;
    set msj = 'alta shida';
    else
    set err = -1;
    set msj = 'usuario ya existe';
    end if;
	
    else
    set exis = (select count(*) from UsuarioN where (correo = mail)or(boleta = bol));
    if(exis = 1) then
    update UsuarioN set nombre = nom, apellidos = ape, escuela = esc, edad = edad, correo = mail, paswd = pass where boleta = bol;
	set msj = 'actualizado';
    set err = bol;
    else
    set msj = 'no existe';
    set err = -1;
    
    end if;
end if;


select err, msj;

end;**
delimiter ;

drop procedure if exists spRecuperaContra;

delimiter **
create procedure spRecuperaContra(in mail nvarchar(200), in contranueva nvarchar(120))
begin
declare msj nvarchar(100);
declare id int;

set id=(select boleta from UsuarioN where correo = mail);
	update UsuarioN set paswd = contranueva where boleta = id; 
    set msj='actualizado';
    select id, msj;
    
end;**
delimiter ;

drop procedure if exists spGuardaProyectos;

delimiter **
create procedure spGuardaProyectos(in id int, in nom nvarchar(120), in descrip nvarchar(800), in img longblob, in money float, in tiempo int, in reward nvarchar(800), in categ nvarchar(32),in boleta int)
begin

declare num int;
declare msj nvarchar(100);
declare exis int;
declare num2 int;
if(id= 0)then
	set exis = (select count(*) from proyectos where (nombre = nom)or(imagen = img));
	if(exis =0)then
    
	set num = (select ifnull(max(idProyecto),0)+1 from proyectos);
	insert into proyectos values(num,nom,descrip,img,money,tiempo,reward,categ);
    set num2 = (select ifnull(max(idrelUsNProyect),0)+1 from relusnproyect);
    insert into relusnproyect values(num2,boleta,num);
    
    set msj = 'alta shida';
    else
    set num = -1;
    set msj = 'proyecto ya existe';
    end if;
	
    else
     set msj = 'no quiere una alta';
    set num = -1;
    set exis = (select count(*) from proyectos where nombre = nom);
    if(exis = 1) then
    update proyectos set  descripcion = descrip, imagen = img, financiacion= money, plazotiempo = tiempo, recompensas = reward, categoria= categ where nombre = nom ;
	set msj = 'actualizado';
    set num = exis;
    else
    set msj = 'no existe';
    set num = -1;
    
    end if;
end if;


select num, msj;

end;**
delimiter ;

drop procedure if exists spEliminaProyecto;
delimiter **
create procedure spEliminaProyecto(in idPro int)
begin
declare id int;
declare msj nvarchar(100);
	delete from relusnproyect where idProyecto = idPro;
    delete from proyectos where idProyecto = idPro;
    set msj = 'Eliminado';
    set id = 1;
select id,msj;
end;**
delimiter ;


drop procedure if exists spGuardaColaborador;
delimiter **
create procedure  spGuardaColaborador(in accion int, in carre nvarchar(120), in info nvarchar(600), in img longblob,in bol int)
begin
declare msj nvarchar(120);
declare id int;
declare id2 int;
if(accion = 0) then
	set id = (select ifnull(max(idColaborador),0)+1 from colaborador);
	insert into colaborador values (id,carre,info,img);
    
    set id2 = (select ifnull(max(idrelColabUsN),0)+1 from relcolabusn);
    insert into relcolabusn values(id2,id,bol);
    set msj= 'jurulo'; 
else
	set msj = 'no quiere alta';
    set id = accion;
    if(accion != 0)then
    update colaborador set Carrera = carre, infoExtra = info, foto = img where idColaborador=accion;
    else
    set msj = 'Kha';
    set id= -1;
    end if;
    
end if;
select id, msj;
end;**
delimiter ;

drop procedure if exists spGuardaTarjeta;
delimiter **
create procedure spGuardaTarjeta(in id int,in numT nvarchar(16),in codseg int,in fechaV nvarchar(120),in direc nvarchar(300),in tiptag nvarchar(64),in bol int)
begin
declare msj nvarchar(120);
declare id2 int;
declare id3 int;
if(id = 0) then
	set id2 = (select ifnull(max(idTarjeta),0)+1 from Tarjeta);
	insert into Tarjeta values (id2,numT,codseg,fechaV,direc,tiptag);
    
    set id3 = (select ifnull(max(idrelTarjetausn),0)+1 from relTarjetausn);
    insert into relTarjetausn values(id3,id2,bol);
    set msj= 'jurulo'; 
else
	set msj = 'no jurulo';
    set id = -1;
end if;
select id, msj;
end;**
delimiter ;

drop procedure if exists spGuardaPaypal;
delimiter **
create procedure spGuardaPaypal(in id int,in mail nvarchar(200),in contra nvarchar(120),in bol int)
begin
declare msj nvarchar(120);
declare id2 int;
declare id3 int;
if(id = 0) then
	set id2 = (select ifnull(max(idPaypal),0)+1 from paypal);
	insert into paypal values (id2,mail,contra);
    
    set id3 = (select ifnull(max(idrelPaypalusn),0)+1 from relPaypalusn);
    insert into relPaypalusn values(id3,id2,bol);
    set msj= 'jurulo'; 
else
	set msj = 'no jurulo';
    set id = -1;
end if;
select id, msj;
end;**
delimiter ;

drop procedure if exists spRealizaDonacion;
delimiter **
create procedure spRealizaDonacion(in idPro int,in bole int,in dinero double)
begin
declare msj nvarchar(120);
declare id int;


	set id = (select ifnull(max(idDonacion),0)+1 from donacion);
	insert into donacion values (id,idPro,bole,dinero);
    set msj= 'jurulo';

select id, msj;
end;**
delimiter ;

drop procedure if exists spRealizaSolicitud;
delimiter **
create procedure  spRealizaSolicitud(in accion int, in idColab int, in idProy int,in bol int)
begin
declare msj nvarchar(120);
declare id int;

if(accion = 0) then
	set id = (select ifnull(max(idSolicitud),0)+1 from SolicitudColaborador);
	insert into SolicitudColaborador (idSolicitud,idProyecto,idColaborador,boleta)values (id,idProy,idColab,bol);
    
    
    set msj= 'jurulo'; 
else

if(accion=1)then
update solicitudcolaborador set validar=true where idSolicitud=bol;
set msj = 'actualizo';
    set id = bol;
else
if(accion=2) then
delete from solicitudcolaborador where idSolicitud = bol;
set msj = 'borrado';
    set id = bol;
else
set msj = 'mal';
    set id = -1;
end if;
end if;
	
end if;
select id, msj;
end;**
delimiter ;
drop procedure if exists spFAQ;
delimiter **
create procedure spFAQ(in idFAQ int,in preg nvarchar(1000),in resp nvarchar(1000), in vald boolean)
begin
declare msj nvarchar(120);
declare id int;

if(idFAQ=1) then
	set id = (select ifnull(max(idfaq),0)+1 from faq);
	insert into faq values (id,preg,resp,vald);
    set msj= 'jurulo';
    else
    if(idFAQ=2)then
    
    update faq set respuesta = resp,validar=vald where pregunta = preg;
    set msj = 'actualizar';
    else
    set msj= 'nel';
    set id=-1;
    end if;
    end if;

select id, msj;
end;**
delimiter ;

drop procedure if exists spGuardaTicket;
delimiter **
create procedure spGuardaTicket(in id int, in recep nvarchar(100), in remi int, in problem nvarchar(5000),in estatus nvarchar(100),in asun nvarchar(500), in tipo nvarchar(100),in avance nvarchar(1000))
begin

declare err int;
declare msj nvarchar(100);
declare fecha date;
declare fol int;
if(id= 0)then
	
	
    set fecha = (select now());
	set fol = (select ifnull(max(folio),0)+1 from tickets);
	insert into tickets values(fol, remi, recep,problem,estatus,fecha, asun,tipo,avance);
    set err = fol;
    set msj = 'alta shida';
    
    
    
	
    else
    
    if(id=1) then
    update tickets set estado = estatus, avances = avance where problema = problem ;
    else
    set err = -1;
    set msj = 'error';
    end if;
    /*set exis = (select count(*) from UsuarioN where (correo = mail)or(boleta = bol));
    if(exis = 1) then
    update UsuarioN set nombre = nom, apellidos = ape, escuela = esc, edad = edad, correo = mail, paswd = pass where boleta = bol;
	set msj = 'actualizado';
    set err = bol;
    else
    set msj = 'no existe';
    set err = -1;
    
    end if;*/
end if;


select err, msj;

end;**
delimiter ;

drop procedure if exists spGuardaForo;
delimiter **
create procedure spGuardaForo(in accion int,in pregun nvarchar(1000), in creator nvarchar(120), in asunt nvarchar(300), in categ nvarchar(120), in img longblob)
begin
declare msj nvarchar(120);
declare id int;
declare fecha date;
if(accion=0) then
set fecha = (select now());

	set id = (select ifnull(max(idForo),0)+1 from Foro);
	insert into Foro values (id,pregun,creator,fecha,asunt,categ,img);
    set msj= 'jurulo';
    else
    set msj = 'nojurulo';
    set id=-1;
    end if;

select id, msj;
end;**
delimiter ;

drop procedure if exists spRespondeForo;
delimiter **
create procedure spRespondeForo(in accion int,in respu nvarchar(1000), in usu nvarchar(120), in idFor int)
begin
declare msj nvarchar(120);
declare id int;

if(accion=0) then


	set id = (select ifnull(max(idRespuesta),0)+1 from RespuestaForo);
	insert into RespuestaForo values (id,respu,usu,idFor);
    set msj= 'jurulo';
    else
    set msj = 'nojurulo';
    set id=-1;
    end if;

select id, msj;
end;**
delimiter ;

/*Guardar usuario 2017090841 y contraseña: 12345*/
call spGuardaUsuarioN(0,2017090841,'Benjamin','Campos','CECyT 9',17,'benjaminjcf15&#x40;hotmail.com','hk7kCun9i+ZKEJanpg0hZA==');
/*EXTRAS ESTO NO SE EJECUTA PARA CREAR LA BASE SON APARTE :v*/

call spGuardaColaborador(0,'progra','nada mas',2017090841);
call spRecuperaContra('mail','nel');
call spGuardaProyectos(0,'ve','qw','er',90,30,'nada','art',2017090841);

call spRealizaDonacion(8,2017090841,600.00);
select * from proyectos;	
call spFAQ(1,'mkm','Pendiente',false);
describe proyectos;
select * from Tarjeta;
delete from Tarjeta where idTarjeta = 1;
select * from paypal;
describe Tarjeta;
select * from relTarjetausn;
select * from relpaypalusn;
select * from colaborador;
select * from tickets;
truncate tickets;
select folio from tickets where remitente =2017090841 and folio like '%2%';
select count(*) from UsuarioN where (correo = 'mai')or(boleta = 2017090842);
update UsuarioN set nombre = 'Benjamoin', apellidos = 'Flores', escuela = 'Batiz', edad = 18, correo = 'micorreo', paswd = '12345' where boleta = 2017090841;
select * from colaborador;
select count(*) as Ver from relcolabusn where boleta = 2017090841;
SHOW TABLES;
truncate table relPaypalusn;
truncate table Paypal;
truncate table faq;
SELECT PREGUNTA FROM FAQ WHERE VALIDAR = FALSE;
delete from Paypal where idPaypal = 2;
select * from UsuarioN;
select * from faq;
SELECT * FROM FAQ WHERE VALIDAR = TRUE;
SELECT * FROM relusnproyect;
insert into faq values (3,'intento','respuestA',false);
describe relusnproyect;
truncate table proyectos;
select *from proyectos;
select * from donacion;
select pp.correoPP, tag.numTrajeta from relpaypalusn inner join PayPal as pp ON relpaypalusn.idPaypal = pp.idPaypal inner join Tarjeta as tag on relTarjetausn.idTarjeta = tag.idTrajeta where boleta = 2017090831;
select * from proyectos;
select carrera from carreras ;
select us.boleta,us.nombre,us.apellidos,us.edad,us.escuela, col.carrera,col.foto,col.infoExtra from relcolabusn as co inner join usuarion as us on us.boleta= co.boleta inner join colaborador as col on col.idColaborador = co.idColaborador where ((co.idColaborador not in(select idColaborador from relcolabusn where boleta=2017090843))and(co.idColaborador not in(select idColaborador from solicitudcolaborador where boleta=2017090843))and((infoExtra like'%%') or (Carrera like'%%'))); 
select us.* from relcolabusn as co inner join usuarion as us on us.boleta= co.boleta inner join colaborador as col on col.idColaborador = co.idColaborador where co.idColaborador=2;
select * from donacion;
select * from faq;
select us.correo from solicitudcolaborador as sol inner join relcolabusn as rel on rel.idColaborador = sol.idColaborador  inner join usuarion as us on us.boleta= rel.boleta where sol.idSolicitud=1;
select * from solicitudcolaborador;
truncate solicitudcolaborador;
select us.nombre,us.apellidos,us.escuela, pro.nombre,sol.idSolicitud,us.correo from solicitudcolaborador as sol inner join usuarion as us on us.boleta= sol.boleta inner join proyectos as pro on sol.idProyecto = pro.idProyecto where idColaborador=1; 
select sol.boleta from solicitudcolaborador as sol  where idColaborador =1;
select * from colaborador where ((idColaborador not in(select idColaborador from relcolabusn where boleta=0))and((infoExtra like'%w%') or (Carrera like'%i%')));
DELETE FROM usuarion WHERE boleta=2017090841;

select sum(dineroDonado) from donacion where idProyecto = 1 and boleta = 2017090841;
select ifnull(max(idfaq),0)+1 from faq;
select * from foro;
select * from foro where pregunta like '%b%' or asunto like '%b%' or categoria like '%b%' or creador like '%b%';
select * from foro where idForo=2;
select us.correo from solicitudcolaborador as sol inner join relcolabusn as rel on rel.idColaborador = sol.idColaborador  inner join usuarion as us on us.boleta= sol.boleta where sol.idSolicitud=1;
select pp.nombre, pp.descripcion, pp.imagen, pp.financiacion, pp.plazotiempo, pp.recompensas,pp.categoria from proyectos as pp inner join relusnproyect as rel on rel.idProyecto = pp.idProyecto   where boleta = 2017090842;
select DISTINCT pp.* ,sum(dineroDonado) as suma from donacion as don inner join proyectos as pp on pp.idProyecto = don.idProyecto where boleta = 2017090842;
select  sum(dineroDonado) from donacion as don inner join proyectos as pp on pp.idProyecto = don.idProyecto where boleta = 2017090841;
select sum(dineroDonado) as suma from donacion where idProyecto = 1;
select * from proyectos where nombre like'%z%' or descripcion like '%z%' or categoria like '%ar%';
select pp.idPaypal,pp.CorreoPP, pp.contraseña from paypal as pp inner join relpaypalusn as rel on rel.idPaypal = pp.idPaypal where rel.boleta = 2017090842;
SELECT * FROM PROYECTOS LIMIT 10;
select * from respuestaForo;
select count(*)from donacion as d inner join proyectos as pp on d.idProyecto=pp.idProyecto  ;
select distinct pp.* from donacion as don inner join proyectos as pp on don.idProyecto=pp.idProyecto where (don.idProyecto not in(select idProyecto from relusnproyect where boleta=0)) order by don.dineroDonado DESC ;
select tag.idTarjeta, tag.NumTrajeta, tag.CodigoSeg, tag.fechaVence, tag.Direccion, tag.TipoTag from Tarjeta as tag inner join reltarjetausn as rel on rel.idTarjeta = tag.idTarjeta where rel.boleta = 2017090841;
select * from usuarion where boleta = 2017090841;
select pp.* from relusnproyect as rel inner join proyectos as pp on pp.idProyecto = rel.idProyecto where not boleta = 2017090841 and (pp.nombre like'%o%' or pp.descripcion like '%ja%' or pp.categoria like '%z%');
select pp.* from donacion as don inner join proyectos as pp on pp.idProyecto = don.idProyecto where boleta = 2017090842;