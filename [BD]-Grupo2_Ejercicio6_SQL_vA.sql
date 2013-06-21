create procedure borrarTablas
as
drop table CITAS
drop table CONSULTORIOS
drop table PACIENTES
drop table MEDICOS
drop table EPS;

create table EPS(
nombre varchar(45) not null unique,
direccion varchar(45) not null,
telefono numeric check( telefono >= 5710000000 and telefono <= 5799999999) not null,
regimen varchar(45) not null,
web varchar(45) not null
);

--EPS--

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Compensar EPS','Av. El Dorado No. 55B-48',5714285088,'www.compensar.com','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Famisanar LTDA','Calle 78 No. 13A-07',5716500200,'www.famisanar.com.co','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Colmédica','Cra. 8 No. 38-31',5717568000,'www.colmedica.com','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Humana Vivir','Clle 26 No 82–54',5717462040,'www.humanavivir.com.co','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Salud Coop','Autopista Norte 94-10',5716511000,'www.saludcoopEPS.com.co','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Coomeva','Avenida 68 No. 17-12',5712184706,'www.EPS.coomeva.com.co','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Cruz Blanca','Autopista Norte No. 94-10',5716446100,'','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Saludvida','Calle 40a No. 13-06',5713274141,'www.saludvidaEPS.com','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Red Salud','Calle 100 No. 19-61 piso 8',5716353538,'www.redsaludEPS.com','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Salud Colpatria','Avenida 19 No. 114-65',5714235757,'www.colpatria.com','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Salud Total','Calle 100 No. 61-18', 5714854555,'www.saludtotal.com.co','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Solsalud','Avenida 39 No. 13-70',5712320117,'www.solsalud.com.co','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Sanitas','Calle 22B No. 66-46',5713759000,'www.colsanitas.com','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Cafesalud','Autopista norte No. 91-Esquina',5716510777,'www.saludcoopEPS.com.co','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('SOS','Av Las Américas N° 23 N-55',5714898686,'www.sos.com.co','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Golden Group S.A.','Carrera 11A # 98–50 Piso 3',5716910953,'www.EPSgoldengroup.com','Contributivo');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Unicajas','Calle 53 No. 10-39 piso 6',5713481068,'www.comfacundi.com.co','Subsidiado');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Humanavivir','(Av. Dorado) Calle 26 No. 82-54',5717460920,'www.humanavivir.com.co','Subsidiado');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Ecoopsos','1 B No 13-02 Candelaria',5717164956,'www.ecoopsos.com.co','Subsidiado');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Caprecom','Cra 69 No. 47-34',5712943333,'www.caprecom.gov.co','Subsidiado');

INSERT INTO EPS (nombre,direccion,telefono,web,regimen)
VALUES('Colsubsidio','Cra. 17 No. 36-74',5712878710,'www.colsubsidio.com','Subsidiado');

create table MEDICOS( -- creacion tabla medicos
nombre varchar(45) not null,
cedula varchar(11) not null unique check( CAST(cedula as int) <= 99999999999),
sueldo money null,
direccion varchar(45) null,
telefono numeric check( telefono >= 5710000000 and telefono <= 5799999999) not null,
celular numeric not null check((celular >= 3000000000 and celular <= 3029999999) or (celular >= 3100000000 and celular <= 3129999999) or (celular >= 3150000000 and celular <= 3169999999)),
fecha_nacimiento date not null,
fecha_grado date default cast(getdate() as date) not null,
fecha_ingreso date not null,
especialidad varchar(45) not null check(especialidad = 'Medicina General' or especialidad = 'Ginecología' or especialidad = 'Traumatología' or especialidad = 'Pediatría'),
check(fecha_nacimiento < fecha_grado and fecha_grado < fecha_ingreso and fecha_ingreso < CAST(getdate() as date) and (datediff(day,fecha_grado,cast(getdate() as date))) > (365*4)
));

--Medicos--
INSERT INTO MEDICOS (nombre,cedula,sueldo,direccion,telefono,celular,fecha_nacimiento,fecha_grado,fecha_ingreso,especialidad)
VALUES ('DORIS DUQUE PINEDA','22139246',1320000,'Cr 12 No. 123 - 54',5716537462,3002113456,'2/02/1945','11/12/2000','11/12/2003','Ginecología');

INSERT INTO MEDICOS (nombre,cedula,sueldo,direccion,telefono,celular,fecha_nacimiento,fecha_grado,fecha_ingreso,especialidad)
VALUES ('FATIMA MAZO JARAMILLO','43055231',1500000,'Cr 122 No. 10 - 48',5716535672,3112219956,'3/02/1970','11/12/2007','1/01/2012','Ginecología');

INSERT INTO MEDICOS (nombre,cedula,sueldo,direccion,telefono,celular,fecha_nacimiento,fecha_grado,fecha_ingreso,especialidad)
VALUES ('MARIA VIRGELLINA BUSTAMANTE','3550661',2100000,'Cr 112 No. 83 - 84',5716899462,3117564026,'3/05/1960','1/02/1999','1/12/2001','Traumatología');

INSERT INTO MEDICOS (nombre,cedula,sueldo,direccion,telefono,celular,fecha_nacimiento,fecha_grado,fecha_ingreso,especialidad)
VALUES ('JAIME DE JESUS MADRID','22187842',4100000,'Cr 152 No. 27 - 79',5712117462,3118764056,'2/10/1980','1/12/2001','1/12/2002','Medicina General');

INSERT INTO MEDICOS (nombre,cedula,sueldo,direccion,telefono,celular,fecha_nacimiento,fecha_grado,fecha_ingreso,especialidad)
VALUES ('ORLANDO ZAPATA','70876033',1200000,'Cr 182 No. 18 - 47',5716787462,3129098456,'12/02/1979','10/03/1997','11/12/1998','Traumatología');

INSERT INTO MEDICOS (nombre,cedula,sueldo,direccion,telefono,celular,fecha_nacimiento,fecha_grado,fecha_ingreso,especialidad)
VALUES ('LUIS ARTURO ESTRADA','43523751',1820000,'Cr 192 No. 18 - 59',5716541621,3113094656,'11/09/1983','2/02/2007','1/12/2011','Traumatología');

INSERT INTO MEDICOS (nombre,cedula,sueldo,direccion,telefono,celular,fecha_nacimiento,fecha_grado,fecha_ingreso,especialidad)
VALUES ('BEATRIZ ESPINOSA','1241818',2150000,'Cr 2 No. 37 - 45',5717807462,3012000256,'6/08/1955','03/01/2008','1/12/2013','Pediatría');

INSERT INTO MEDICOS (nombre,cedula,sueldo,direccion,telefono,celular,fecha_nacimiento,fecha_grado,fecha_ingreso,especialidad)
VALUES ('LUIS EDUARDO SUAREZ','71678440',3300000,'Cr 62 No. 12 - 53',5715417462,3122119986,'1/05/1981','9/12/2000','1/12/2004','Pediatría');

INSERT INTO MEDICOS (nombre,cedula,sueldo,direccion,telefono,celular,fecha_nacimiento,fecha_grado,fecha_ingreso,especialidad)
VALUES ('CLAUDIA PATRICIA VELEZ','3303796',3240000,'Cr 72 No. 23 - 34',5714057462,3163343456,'1/07/1962','3/08/2001','1/12/2003','Pediatría');

INSERT INTO MEDICOS (nombre,cedula,sueldo,direccion,telefono,celular,fecha_nacimiento,fecha_grado,fecha_ingreso,especialidad)
VALUES ('JAIME DE JESUS MADRID','221878420',4250000,'Cr 28 No. 13 - 35',5716003462,3122673456,'3/11/1977','5/07/1996','1/12/2000','Medicina General');



create table PACIENTES(
nombre varchar(30) not null,
cedula varchar(11) not null unique check(CAST(cedula as int)<= 99999999999),
direccion varchar(30) not null,
telefono numeric not null check(telefono >=5710000000 and telefono <=5799999999 ),
celular numeric not null check((celular >= 3000000000 and celular <= 3029999999) or (celular >= 3100000000 and celular <= 3129999999) or (celular >= 3150000000 and celular <= 3169999999)),
fecha_nacimiento date,
EPS varchar(45) references EPS(nombre)
);


--pacientes

INSERT INTO PACIENTES (cedula,nombre,telefono,celular,direccion,fecha_nacimiento,EPS)
VALUES ('39168186', 'BLANCA CECILIA HENAO',5714325433,3104132567,'Cr 232 No.2-44','02/05/2001','Famisanar LTDA');

INSERT INTO PACIENTES (cedula,nombre,telefono,celular,direccion,fecha_nacimiento,EPS)
VALUES ('71622458', 'GUILLERMO LEON QUIROZ',5712345433,3003214647,'Cr 3 No.42-24','02/03/2001','Colmédica');

INSERT INTO PACIENTES (cedula,nombre,telefono,celular,direccion,fecha_nacimiento,EPS)
VALUES ('70191308', 'FRANCISCO JAVIER PEÑA',5713423543,3108456321,'Cr 23 No.42-44','02/03/2001','Humana Vivir');

INSERT INTO PACIENTES (cedula,nombre,telefono,celular,direccion,fecha_nacimiento,EPS)
VALUES ('39207688', 'ALBA IRENE CARO',5718739843,3018243566,'Cr 13 No.12-44','02/05/2001','Coomeva');

INSERT INTO PACIENTES (cedula,nombre,telefono,celular,direccion,fecha_nacimiento,EPS)
VALUES ('22010611', 'SENOBIA RIVERA',5712567547,3125485697,'Cr 22 No.22-24','02/05/2001','Saludvida');

INSERT INTO PACIENTES (cedula,nombre,telefono,celular,direccion,fecha_nacimiento,EPS)
VALUES ('21658273', 'LILA MARGARITA JARAMILLO',5715643789,3007055432,'Cr 55 No.62-84','02/05/2001','Salud Colpatria');

INSERT INTO PACIENTES (cedula,nombre,telefono,celular,direccion,fecha_nacimiento,EPS)
VALUES ('70120491', 'ELIECER MORALES',5718642180,3115548896,'Cr 33 No.32-35','02/03/2001','Salud Total');

INSERT INTO PACIENTES (cedula,nombre,telefono,celular,direccion,fecha_nacimiento,EPS)
VALUES ('83947325', 'RUBEN DARIO RESTREPO',5717634579,3014567777,'Cr 29 No.92-49','02/03/2001','Solsalud');
INSERT INTO PACIENTES (cedula,nombre,telefono,celular,direccion,fecha_nacimiento,EPS)
VALUES ('71383956', 'OSCAR DAVID RIOS',5716742765,3169500595,'Cr 13 No.32-11','02/03/2001','Solsalud');

INSERT INTO PACIENTES (cedula,nombre,telefono,celular,direccion,fecha_nacimiento,EPS)
VALUES ('43010404', 'MARTA CECILIA ESTRADA',5718876547,3154566565,'Cr 223 No.4-11','02/05/2001','Salud Colpatria');

INSERT INTO PACIENTES (cedula,nombre,telefono,celular,direccion,fecha_nacimiento,EPS)
VALUES ('42970764', 'GLORIA ESTELLA OSPINA',5717452365,3108765445,'Cr 63 No.46-64','02/05/2001','Cruz Blanca');


create table CONSULTORIOS(
especialidad varchar(45) not null check(especialidad = 'Medicina General' or especialidad = 'Ginecología' or especialidad = 'Traumatología' or especialidad = 'Pediatría'),
consultorio varchar(4) unique not null
);


INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES ('Medicina General','G101');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES ('Medicina General','G102');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES ('Medicina General','G103');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES ('Medicina General','G207');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES ('Medicina General','G209');

INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Ginecología','G104');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Ginecología','G105');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Ginecología','G204');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Ginecología','G205');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Ginecología','G206'); 

INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Traumatología','T106');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Traumatología','T107');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Traumatología','T208');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Traumatología','T210');

INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Pediatría','P108');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Pediatría','P109');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Pediatría','P110');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Pediatría','P201');
INSERT INTO CONSULTORIOS (especialidad, consultorio)
VALUES('Pediatría','P309');

create table CITAS(
cedulaMedico varchar(11) references MEDICOS(cedula),
cedulaPaciente varchar(11) references PACIENTES(cedula),
consultorio varchar(4) references CONSULTORIOS(consultorio),
fecha date not null,
check(cedulaMedico <> cedulaPaciente)
);

create table BITACORA(
fechaOper date,
usuarioOper varchar(30),
maquinaOper varchar(30) null,
tablaAfec varchar(30) null,
operacion varchar (30)
);

INSERT INTO CITAS VALUES('3550661','39168186','G204','02/02/2013');
INSERT INTO CITAS VALUES('3550661','39168186','G204','5/12/2013');
INSERT INTO CITAS VALUES('22187842','39207688','G204','2/12/2013');

create view RESUMEN_CITAS
as
select MEDICOS.nombre as medico, PACIENTES.nombre as paciente, consultorio, MEDICOS.especialidad as especialidad
from CITAS, PACIENTES, MEDICOS
where cedulaMedico = MEDICOS.cedula and cedulaPaciente = PACIENTES.cedula;

create index INDICE_EPS ON EPS (nombre);

--**************************** TRIGGERS*******************************
create trigger registro on CITAS
for insert
as
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (GETDATE(),user,null,null,'update');

--select * from BITACORA;
