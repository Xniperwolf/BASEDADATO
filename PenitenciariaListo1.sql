CREATE TABLE visitantes (
    id_visitante NUMBER(3),
    rut_visitante VARCHAR2(10) NOT NULL,
    nombres VARCHAR2(35) NOT NULL,
    apellido VARCHAR2(35) NOT NULL,
    sexo CHAR(1) NOT NULL,
    CONSTRAINT VISITA_PK PRIMARY KEY (id_visitante),
    CONSTRAINT UN_RUT UNIQUE (rut_visitante)

);

CREATE TABLE penitenciaria (
    id_penitenciaria NUMBER(3) GENERATED ALWAYS AS IDENTITY START WITH 1 INCREMENT BY 1,
    nombre VARCHAR2(35) NOT NULL,
    direccion VARCHAR2(50) NOT NULL,
    capacidad NUMBER(3) NOT NULL,
    num_internos NUMBER(3) NOT NULL,
    comuna VARCHAR2(30) NOT NULL,
    CONSTRAINT PENITENCIARIA_PK PRIMARY KEY (id_penitenciaria),
    CONSTRAINT UN_NOMBRE UNIQUE (nombre),
    CONSTRAINT CHK_CAPACIDAD CHECK (capacidad >= 80 AND capacidad <= 500),
    CONSTRAINT CHK_NUM_INTERNOS CHECK (num_internos <= 800)

);

CREATE SEQUENCE SQ_ID_PENA START WITH 1 INCREMENT BY 1;
CREATE TABLE pena (
    id_pena NUMBER(3),
    descripcion VARCHAR2(45) NOT NULL,
    CONSTRAINT PENA_PK PRIMARY KEY (id_pena)

);

CREATE TABLE imputados (
    id_imputado NUMBER(3),
    rut_imputado VARCHAR2(10) NOT NULL,
    nombre VARCHAR2(45) NOT NULL,
    apellido VARCHAR2(45) NOT NULL,
    sexo CHAR(1) NULL,
    f_nacimiento DATE NOT NULL ,
    CONSTRAINT IMPUTADOS_PK PRIMARY KEY (id_imputado),
    CONSTRAINT IMPUTADOS_UN UNIQUE (rut_imputado),
    CONSTRAINT CHK_F_NACIMIENTO CHECK (f_nacimiento >= '01/01/1900')

);



CREATE TABLE delito(
    id_delito NUMBER GENERATED ALWAYS AS IDENTITY START WITH 1 INCREMENT BY 1,
    descripcion VARCHAR2(35),
    id_pena NUMBER(3),
    CONSTRAINT DELITO_PK PRIMARY KEY (id_delito),
    CONSTRAINT DELITO_PENA_FK FOREIGN KEY (id_pena) REFERENCES pena(id_pena)
);

CREATE TABLE delito_imputado (
    id_delito_imputado NUMBER(3),
    id_delito NUMBER,
    id_imputado NUMBER(3),
    CONSTRAINT DELITO_IMPUTADO_PK PRIMARY KEY (id_delito_imputado),
    CONSTRAINT DELITO_IMPUT_IMPUT FOREIGN KEY  (id_imputado) REFERENCES imputados(id_imputado)
    
);

CREATE TABLE condena(
    id_condena NUMBER(3),
    fecha_condena DATE NULL,
    annos NUMBER(2) NOT NULL,
    libertad_vigilada CHAR(1),
    id_penitenciaria NUMBER(3),
    CONSTRAINT CONDENA_PK PRIMARY KEY (id_condena),
    CONSTRAINT CONDENA_PENITENCIARIA_FK FOREIGN KEY (id_penitenciaria) REFERENCES penitenciaria(id_penitenciaria)
    
);

CREATE TABLE visita (
    id_visita NUMBER(3),
    fecha DATE DEFAULT SYSDATE,
    id_visitante NUMBER(3),
    id_condena NUMBER(3),
    CONSTRAINT VISITA_REGISTRO_PK PRIMARY KEY (id_visita),
    CONSTRAINT VISITA_CONDENA_FK FOREIGN KEY (id_condena) REFERENCES condena(id_condena),
    CONSTRAINT VISITA_VISITANTES_FK FOREIGN KEY (id_visitante) REFERENCES visitantes(id_visitante)

);

CREATE TABLE condena_imputados (
    id_condena NUMBER(3),
    id_delito_imputado NUMBER(3),
    CONSTRAINT COND_IMPUT_PK PRIMARY KEY (id_condena, id_delito_imputado),
    CONSTRAINT CONDENA_IMPUTADOS_FK FOREIGN KEY (id_condena) REFERENCES condena(id_condena),
    CONSTRAINT IMPUTADOS_DELIT_FK FOREIGN KEY (id_delito_imputado) REFERENCES delito_imputado(id_delito_imputado)

);

SELECT * FROM penitenciaria;

INSERT INTO visitantes VALUES ('1','12121212-3','Jorge Andres','Tapia Solis','M');
INSERT INTO visitantes VALUES ('2','23652223-7','Marcos Antonio','Candia Perez','M');
INSERT INTO visitantes VALUES ('3','10215421-1','Marcela Andrea','Solis Diaz','F');
INSERT INTO visitantes VALUES ('4','19745125-2','Raul Alfonso','Fuentes Ducco','M');
INSERT INTO visitantes VALUES ('5','08451254-1','Diego Mauricio','Ramirez Lara','M');
INSERT INTO visitantes VALUES ('6','09452145-3','Samanta Veronica','Segovia Salinas','F');
INSERT INTO visitantes VALUES ('7','11215410-2','Raul Pablo','Pedrero Fuentes','M');

ALTER TABLE imputados DROP CONSTRAINT CHK_F_NACIMIENTO;
ALTER TABLE imputados ADD CONSTRAINT CHK_F_NACIMIENTO CHECK (f_nacimiento >= '01/01/1900');

INSERT INTO imputados VALUES ('1','11111111-1','Jose','Perez','M','10/12/70');
INSERT INTO imputados VALUES ('2','22222222-2','Andres','Ortega','M','04/06/68');
INSERT INTO imputados VALUES ('3','33333333-3','Marcos','Lara','M','01/03/55');
INSERT INTO imputados VALUES ('4','44444444-4','Aldo','Rios','M','12/08/70');
INSERT INTO imputados VALUES ('5','55555555-5','Martin','Lita','M','09/04/66');
INSERT INTO imputados VALUES ('6','66666666-6','Raul','Fariña','M','20/08/75');
INSERT INTO imputados VALUES ('7','77777777-7','Dunis','Teron','M','11/04/80');
INSERT INTO imputados VALUES ('8','88888888-8','Hugo','Peron','M','18/04/90');
INSERT INTO imputados VALUES ('9','99999999-9','Ramis','Lorca','M','08/09/66');
INSERT INTO imputados VALUES ('10','12343234-8','Person','Lobis','M','19/01/78');
INSERT INTO imputados VALUES ('11','16987678-7','Ronev','Usthon','M','11/05/80');
INSERT INTO imputados VALUES ('12','19876578-K','Andrea','Tamavo','F','12/07/90');
INSERT INTO imputados VALUES ('13','23476556-3','Thania','Rivas','F','19/09/99');
INSERT INTO imputados VALUES ('14','21764367-K','Pamela','Machuca','F','28/08/88');


INSERT INTO penitenciaria (nombre, direccion, capacidad, num_internos, comuna) VALUES ('Colina 1', 'Carretera General San Martin 665','300','100','Colina');
INSERT INTO penitenciaria (nombre, direccion, capacidad, num_internos, comuna) VALUES ('Colina 2', 'Carretera General San Martin 765','400','140','Colina');
INSERT INTO penitenciaria (nombre, direccion, capacidad, num_internos, comuna) VALUES ('Punta Peuco', 'Camino Quilapilum. Parcela 25','80','10','TilTil');
INSERT INTO penitenciaria (nombre, direccion, capacidad, num_internos, comuna) VALUES ('Puente Alto', 'Irarrazabal 991','300','100','Puente Alto');
INSERT INTO penitenciaria (nombre, direccion, capacidad, num_internos, comuna) VALUES ('Santiago 1', 'Av. Nueva Centenario 1879','340','101','Santiago');
INSERT INTO penitenciaria (nombre, direccion, capacidad, num_internos, comuna) VALUES ('Santiago Sur', 'Av. Pedro Montt 1902','230','80','Santiago');
INSERT INTO penitenciaria (nombre, direccion, capacidad, num_internos, comuna) VALUES ('San Miguel', 'San Francisco 4759','380','90','San Miguel');

INSERT INTO pena VALUES (sq_id_pena.nextval,'Presidio');
INSERT INTO pena VALUES (sq_id_pena.nextval,'Reclusion');
INSERT INTO pena VALUES (sq_id_pena.nextval,'Confinamiento');
INSERT INTO pena VALUES (sq_id_pena.nextval,'Inhabilitacion');
INSERT INTO pena VALUES (sq_id_pena.nextval,'Presidio Menor');
INSERT INTO pena VALUES (sq_id_pena.nextval,'Reclusion Menor');
INSERT INTO pena VALUES (sq_id_pena.nextval,'Confinamiento Menor');
INSERT INTO pena VALUES (sq_id_pena.nextval,'Suspencion de Cargo');
INSERT INTO pena VALUES (sq_id_pena.nextval,'Prision');

INSERT INTO condena VALUES ('1','10/04/15','15','S','2');
INSERT INTO condena VALUES ('2','03/08/00','5','N','1');
INSERT INTO condena VALUES ('3','09/06/00','10','N','2');
INSERT INTO condena VALUES ('4','11/04/15','6','N','2');
INSERT INTO condena VALUES ('5','26/11/12','7','N','1');
INSERT INTO condena VALUES ('6','20/01/03','11','S','2');
INSERT INTO condena VALUES ('7','04/09/08','10','S','3');
INSERT INTO condena VALUES ('8','10/11/17','8','S','1');
INSERT INTO condena VALUES ('9','01/09/01','5','N','2');
INSERT INTO condena VALUES ('10','14/07/02','7','S','1');
INSERT INTO condena VALUES ('11','16/04/08','9','N','2');
INSERT INTO condena VALUES ('12','25/12/01','5','S','4');
INSERT INTO condena VALUES ('13','01/02/99','10','N','4');
INSERT INTO condena VALUES ('14','14/05/06','6','S','5');

INSERT INTO delito (descripcion, id_pena) VALUES ('Parricidio','1');
INSERT INTO delito (descripcion, id_pena) VALUES ('Homicidio','1');
INSERT INTO delito (descripcion, id_pena) VALUES ('Infanticidio','1');
INSERT INTO delito (descripcion, id_pena) VALUES ('Secuestro','2');
INSERT INTO delito (descripcion, id_pena) VALUES ('Robo Lugar Deshabitado','9');
INSERT INTO delito (descripcion, id_pena) VALUES ('Hurto','5');
INSERT INTO delito (descripcion, id_pena) VALUES ('Soborno','8');
INSERT INTO delito (descripcion, id_pena) VALUES ('Encubrimiento','7');
INSERT INTO delito (descripcion, id_pena) VALUES ('Asalto','5');

UPDATE delito_imputado SET id_delito='9' WHERE id_delito_imputado = '1';
INSERT INTO delito_imputado (id_delito_imputado,id_imputado) VALUES ('1','8');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('2','1','10');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('3','1','4');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('4','9','9');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('5','3','6');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('6','4','5');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('7','2','1');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('8','2','4');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('9','6','3');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('10','5','7');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('11','5','9');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('12','9','11');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('13','3','12');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('14','1','3');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('15','2','7');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('16','2','7');
INSERT INTO delito_imputado (id_delito_imputado,id_delito,id_imputado) VALUES ('17','1','9');

INSERT INTO condena_imputados VALUES ('1','1');
INSERT INTO condena_imputados VALUES ('1','4');
INSERT INTO condena_imputados VALUES ('1','12');
INSERT INTO condena_imputados VALUES ('2','16');
INSERT INTO condena_imputados VALUES ('2','8');
INSERT INTO condena_imputados VALUES ('6','15');
INSERT INTO condena_imputados VALUES ('2','7');
INSERT INTO condena_imputados VALUES ('3','9');
INSERT INTO condena_imputados VALUES ('4','13');
INSERT INTO condena_imputados VALUES ('4','5');
INSERT INTO condena_imputados VALUES ('5','2');
INSERT INTO condena_imputados VALUES ('5','14');
INSERT INTO condena_imputados VALUES ('5','3');
INSERT INTO condena_imputados VALUES ('5','17');
INSERT INTO condena_imputados VALUES ('6','11');
INSERT INTO condena_imputados VALUES ('6','10');
INSERT INTO condena_imputados VALUES ('6','6');

INSERT INTO visita VALUES ('1','10/05/15','1','1');
INSERT INTO visita VALUES ('2','08/06/15','2','1');
INSERT INTO visita VALUES ('5','25/05/16','1','1');
INSERT INTO visita VALUES ('6','10/08/00','4','2');
INSERT INTO visita VALUES ('11','21/02/01','4','2');
INSERT INTO visita VALUES ('12','10/07/00','5','3');
INSERT INTO visita VALUES ('18','15/05/12','1','3');
INSERT INTO visita VALUES ('19','20/05/01','6','4');
INSERT INTO visita VALUES ('20','06/06/01','2','4');

commit;





