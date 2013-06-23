--MEDICOS--
--GRUPO02 DATOS PARA LA BASE DE DATOS DE HOSPITAL UN
--EPS--

CREATE OR REPLACE PROCEDURE borrarTablas IS
   s_sql    VARCHAR2(500);
BEGIN
      s_sql := 'DROP TABLE CITAS cascade constraints';
   EXECUTE IMMEDIATE s_sql;
   s_sql := 'DROP TABLE CONSULTORIOS cascade constraints';
   EXECUTE IMMEDIATE s_sql;
   s_sql := 'DROP TABLE EPS cascade constraints';
   EXECUTE IMMEDIATE s_sql;
   s_sql := 'DROP TABLE MEDICOS cascade constraints';
   EXECUTE IMMEDIATE s_sql;
   s_sql := 'DROP TABLE PACIENTES cascade constraints';
   EXECUTE IMMEDIATE s_sql;
   s_sql := 'DROP TABLE BITACORA cascade constraints';
   EXECUTE IMMEDIATE s_sql;
EXCEPTION
   WHEN OTHERS THEN
       NULL;
end borrarTablas;

execute borrarTablas;

create table EPS(
nombre varchar(45) not null unique,
direccion varchar(45) not null,
telefono numeric check( telefono >= 5710000000 and telefono <= 5799999999) not null,
regimen varchar(45) not null,
web varchar(45) not null
);

--Consultorios

create table CONSULTORIOS(
especialidad varchar(45) not null check(especialidad = 'Medicina General' or especialidad = 'Ginecología' or especialidad = 'Traumatología' or especialidad = 'Pediatría'),
consultorio varchar(4) unique not null
);

--Medicos

create table MEDICOS 
(
nombre varchar(45) not null, 
cedula char(11) not null unique check (regexp_like(cedula,'[0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ][0-9, ]')),
sueldo numeric null, 
direccion varchar(45) null, 
telefono numeric not null check(telefono >=5710000000 and telefono <=5799999999 ), 
celular numeric not null check((celular >= 3000000000 and celular <= 3029999999) or (celular >= 3100000000 and celular <= 3129999999) or (celular >= 3150000000 and celular <= 3169999999)),
fecha_nacimiento date not null,
fecha_grado date not null,
fecha_ingreso date not null,
especialidad varchar(45) not null check(especialidad = 'Medicina General' or especialidad = 'Ginecología' or especialidad = 'Traumatología' or especialidad = 'Pediatría')
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
Primary Key(cedula),
foreign key (EPS) references EPS(nombre));


--Citas Medicas

create table CITAS(
cedulaMedico char(11),
cedulaPaciente char(11),
consultorio varchar(4),
fecha date not null,
foreign key (cedulaMedico) references MEDICOS(cedula),
foreign key (cedulaPaciente) references PACIENTES(cedula),
foreign key (consultorio) references CONSULTORIOS(consultorio)
--check(cedulaMedico <> cedulaPaciente)
);

--Bitacora

create table BITACORA(
fechaOper date,
usuarioOper varchar(30),
maquinaOper varchar(30),
tablaAfec varchar(30),
operacion varchar (30)
)

