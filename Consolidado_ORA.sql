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
check (fecha_nacimiento < fecha_grado and fecha_grado < fecha_ingreso)
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

--CONTROL B
create table CONTROLB(
fechaOper date,
usuarioOper varchar(30),
maquinaOper varchar(30),
operacion varchar (30)
)

--Triggers

CREATE OR REPLACE TRIGGER check_fechas
  BEFORE INSERT OR UPDATE ON MEDICOS
  FOR EACH ROW
BEGIN
  IF( :new.fecha_ingreso > SYSDATE )
  THEN
    RAISE_APPLICATION_ERROR( -20001, 
          'La fecha de Ingreso no puede ser en el futuro' || 
          to_char( :new.fecha_ingreso, 'YYYY-MM-DD HH24:MI:SS' ) );
  END IF;
  IF( :new.fecha_nacimiento > SYSDATE )
  THEN
    RAISE_APPLICATION_ERROR( -20001, 
          'La fecha de Nacimiento no puede ser en el futuro' || 
          to_char( :new.fecha_nacimiento, 'YYYY-MM-DD HH24:MI:SS' ) );
  END IF;
  IF( (:new.fecha_ingreso - :new.fecha_grado) < 1460 )
  THEN
    RAISE_APPLICATION_ERROR( -20002, 
         'La experiencia minima es de 4 años Grado:' || 
         to_char( :new.fecha_grado, 'YYYY-MM-DD HH24:MI:SS' ) ||
			'Ingreso: ' || to_char( :new.fecha_ingreso, 'YYYY-MM-DD HH24:MI:SS' ) );
  END IF;
  IF( (TRUNC(SYSDATE) - :new.fecha_ingreso) < 0 )
  THEN
    RAISE_APPLICATION_ERROR( -20002, 
          'La fecha de ingreso no puede estar en el futuro ' || 
          to_char( :new.fecha_ingreso, 'YYYY-MM-DD HH24:MI:SS' ) );
  END IF;
END;

CREATE OR REPLACE TRIGGER registro_Citas_Insert AFTER INSERT ON CITAS
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (systimestamp,user,null,'CITAS','INSERT');
END registro_Citas_Insert;
CREATE OR REPLACE TRIGGER registro_Citas_Update AFTER UPDATE ON CITAS
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'CITAS','UPDATE');
END registro_Citas_Update;
CREATE OR REPLACE TRIGGER registro_Citas_Delete AFTER DELETE ON CITAS
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'CITAS','DELETE');
END egistro_Citas_Delete;


CREATE OR REPLACE TRIGGER registro_Medicos_Insert AFTER INSERT ON MEDICOS
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'MEDICOS','INSERT');
END registro_Medicos_Insert;
CREATE OR REPLACE TRIGGER registro_Medicos_Update AFTER UPDATE ON MEDICOS
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'MEDICOS','UPDATE');
END registro_Medicos_Update;
CREATE OR REPLACE TRIGGER registro_Medicos_Delete AFTER DELETE ON MEDICOS
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'MEDICOS','DELETE');
END registro_Medicos_Delete;

CREATE OR REPLACE TRIGGER registro_Pacientes_Insert AFTER INSERT ON PACIENTES
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'PACIENTES','INSERT');
END registro_Pacientes_Insert;
CREATE OR REPLACE TRIGGER registro_Pacientes_Update AFTER UPDATE ON PACIENTES
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'PACIENTES','UPDATE');
END registro_Pacientes_Update;
CREATE OR REPLACE TRIGGER registro_Pacientes_Delete AFTER DELETE ON PACIENTES
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'PACIENTES','DELETE');
END registro_Pacientes_Delete;

CREATE OR REPLACE TRIGGER registro_Consultorios_Insert AFTER INSERT ON CONSULTORIOS
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'CONSULTORIOS','INSERT');
END registro_Consultorios_Insert;
CREATE OR REPLACE TRIGGER registro_Consultorios_Update AFTER UPDATE ON CONSULTORIOS
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'CONSULTORIOS','UPDATE');
END registro_Consultorios_Update;
CREATE OR REPLACE TRIGGER registro_Consultorios_Delete AFTER DELETE ON CONSULTORIOS
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'CONSULTORIOS','DELETE');
END registro_Consultorios_Delete;

CREATE OR REPLACE TRIGGER registro_EPS_Insert AFTER INSERT ON EPS
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'EPS','INSERT');
END registro_EPS_Insert;
CREATE OR REPLACE TRIGGER registro_EPS_Update AFTER UPDATE ON EPS
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'EPS','UPDATE');
END registro_EPS_Update;
CREATE OR REPLACE TRIGGER registro_EPS_Delete AFTER DELETE ON EPS
BEGIN
insert into BITACORA(fechaOper,usuarioOper,maquinaOper,tablaAfec,operacion)
values (SYSTIMESTAMP,user,null,'EPS','DELETE');
END registro_EPS_Delete;

CREATE OR REPLACE TRIGGER registro_Bitacora_Delete AFTER DELETE ON BITACORA
BEGIN
insert into CONTROLB(fechaOper,usuarioOper,maquinaOper,operacion)
values (SYSTIMESTAMP,user,null,'DELETE');
END registro_Bitacora_Delete;
CREATE OR REPLACE TRIGGER registro_Bitacora_Insert AFTER INSERT ON BITACORA
BEGIN
insert into CONTROLB(fechaOper,usuarioOper,maquinaOper,operacion)
values (SYSTIMESTAMP,user,null,'INSERT');
END registro_Bitacora_Insert;
CREATE OR REPLACE TRIGGER registro_Bitacora_Update AFTER UPDATE ON BITACORA
BEGIN
insert into CONTROLB(fechaOper,usuarioOper,maquinaOper,operacion)
values (SYSTIMESTAMP,user,null,'UPDATE');
END registro_Bitacora_Update;
