CREATE TABLE ARTISTA
(
NOMBRE VARCHAR2(50) PRIMARY KEY NOT NULL,
PAIS VARCHAR2(20),
ANIOS VARCHAR2(10)
);

CREATE TABLE CANCION 
(
IDCANCION NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
ARTISTA VARCHAR2(105),
NOMBRE VARCHAR2(300),
ALBUM VARCHAR2(100),
ANO_PUB INT,
GENERO VARCHAR2(20),
DURACION VARCHAR2(5),
LYRICS VARCHAR2(4000),
RATING VARCHAR2(1),
FOREIGN KEY (ARTISTA) REFERENCES ARTISTA(NOMBRE)
);



CREATE TABLE USUARIO
(
ID_USER VARCHAR2(20) PRIMARY KEY NOT NULL,
PASS VARCHAR2(20),
NOMBRE VARCHAR2(50),
BIRTH DATE,
PAIS VARCHAR2(20),
MAIL VARCHAR2(50)
);

CREATE TABLE REPRODUCCION
(
IDEN NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
USERID VARCHAR2(20),
MUSICA INT,
FECHA DATE,
HORA VARCHAR2(8),
FOREIGN KEY (USERID) REFERENCES USUARIO(ID_USER),
FOREIGN KEY (MUSICA) REFERENCES CANCION(IDCANCION)
);