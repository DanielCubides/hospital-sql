--MEDICOS--
--GRUPO02 DATOS PARA LA BASE DE DATOS DE HOSPITAL UN
--EPS--

create table EPS(
nombre char(30),
direccion varchar(30),
telefonos numeric check(telefonos >=5710000000 and telefonos <=5799999999 ),
regimen varchar(30),
web varchar(30),
Primary Key (nombre)
);


--Consultorios

create table CONSULTORIOS(
especialidad varchar(30),
consultorio varchar(4) Not Null Unique
);


--Medicos

create table MEDICOS 
(
nombre varchar(30) not null, 
cedula char(11) check (regexp_like(cedula,'[0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ]')),
sueldo numeric null, 
direccion varchar(30) null, 
telefono numeric not null check(telefono >=5710000000 and telefono <=5799999999 ), 
celular numeric not null check((celular >= 3000000000 and celular <= 3029999999) or (celular >= 3100000000 and celular <= 3129999999) or (celular >= 3150000000 and celular <= 3169999999)),
fecha_nacimiento date not null,
fecha_grado date not null,
fecha_ingreso date not null,
especialidad varchar(30) not NULL,
primary Key (cedula)
);

--PACIENTES--

create table PACIENTES (
nombre varchar(30) not null,
cedula char(11) check (regexp_like(cedula,'[0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ]')),
direccion varchar(30) not null,
telefono numeric not null check(telefono >=5710000000 and telefono <=5799999999 ),
celular numeric not null check((celular >= 3000000000 and celular <= 3029999999) or (celular >= 3100000000 and celular <= 3129999999) or (celular >= 3150000000 and celular <= 3169999999)),
fecha_nacimiento date,
EPS varchar(30) not NULL,
Primary Key(cedula));


--Citas Medicas

create table CITAS_MEDICAS(
cedula_medico char(11) references MEDICOS(cedula),
cedula_paciente char(11) references PACIENTES(cedula),
Id_consult varchar(4) references CONSULTORIOS(consultorio),
fecha_hora_cita date,
Primary Key(cedula_medico,cedula_paciente));

CREATE INDEX Indice_Eps ON EPS (nombre);

--Ejecutar por separado

CREATE VIEW medico_especialidad as SELECT MEDICOS.nombre, MEDICOS.especialidad FROM MEDICOS;
