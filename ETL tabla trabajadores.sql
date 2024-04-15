-- Proceso de mejora a la base de datos de ProyectoUsuarios

USE ProyectoUsuarios;

-- Consulta para simular una tabla de modalidad de trabajo

SELECT ROW_NUMBER() OVER (ORDER BY ModalidadTrabajo DESC) AS Modalidad_Id, ModalidadTrabajo FROM Trabajadores
GROUP BY ModalidadTrabajo;

-- Creación de la tabla de ModalidadTrabajo
CREATE TABLE ModalidadTrabajo(
	Modalidad_Id INT PRIMARY KEY,
	ModalidadTrabajo VARCHAR(30) NOT NULL
);

-- Insertando los registros

INSERT INTO ModalidadTrabajo
SELECT ROW_NUMBER() OVER (ORDER BY ModalidadTrabajo DESC) AS Modalidad_Id, ModalidadTrabajo FROM Trabajadores
GROUP BY ModalidadTrabajo;

-- Probando que los registros se encuentran en la tabla

SELECT * FROM ModalidadTrabajo;
 
SELECT DISTINCT Cargo FROM Trabajadores;

-- Corrigiendo datos inconsistentes

UPDATE Trabajadores SET Cargo = 'Ingeniero de ciberseguridad' WHERE Cargo = 'Ingenierode ciberseguridad';
UPDATE Trabajadores SET Cargo = 'Desarrollador Fullstack' WHERE Cargo = 'Desarrollador web fullstack';

-- Creación de la tabla de cargo de empleados

CREATE TABLE CargoEmpleado(
	Cargo_Id INT PRIMARY KEY,
	Nombre_Cargo VARCHAR(30) NOT NULL
);

INSERT INTO CargoEmpleado
SELECT ROW_NUMBER() OVER (ORDER BY Cargo ASC) AS Cargo_Id, Cargo FROM Trabajadores GROUP BY Cargo;

SELECT * FROM CargoEmpleado;

-- Creación de la tabla de departamentos

CREATE TABLE Departamentos(
	Departamento_ID INT PRIMARY KEY IDENTITY(1, 1),
	Nombre_Departamento VARCHAR(30)
);

-- Insertando registros en la tabla de departamentos

INSERT INTO Departamentos VALUES
('Atlantico'),
('Bogota D.C'),
('Santander'),
('Valle del Cauca'),
('Antioquia');

SELECT * FROM Departamentos;

-- Creación de la tabla de ciudad

SELECT ROW_NUMBER() OVER (ORDER BY Ciudad ASC) AS Ciudad_ID, Ciudad FROM Trabajadores GROUP BY Ciudad;

CREATE TABLE Ciudad(
	Ciudad_ID INT PRIMARY KEY,
	Nombre_Ciudad VARCHAR(30),
	Departamento_ID INT,
	CONSTRAINT FK_DEPARTAMENTO FOREIGN KEY (Departamento_ID) REFERENCES Departamentos(Departamento_ID)
		ON UPDATE CASCADE
);

-- Insertando registros

INSERT INTO Ciudad
SELECT ROW_NUMBER() OVER (ORDER BY Ciudad ASC) AS Ciudad_ID, Ciudad, NULL AS Departamento_ID FROM Trabajadores 
GROUP BY Ciudad;

-- Realizando algunos ajustes

UPDATE ciudad
SET departamento_id = CASE 
    WHEN Ciudad_ID = 1 THEN 1
    WHEN Ciudad_ID = 2 THEN 2
    WHEN Ciudad_ID = 3 THEN 3
	WHEN Ciudad_ID = 4 THEN 4
	WHEN Ciudad_ID = 5 THEN 5
END;

SELECT * FROM Ciudad;

SELECT t.Nombre, t.ModalidadTrabajo, md.Modalidad_Id FROM Trabajadores t INNER JOIN ModalidadTrabajo md
ON t.ModalidadTrabajo = md.ModalidadTrabajo;

SELECT * FROM Trabajadores;

-- Creando tabla de usuarios o trabajadores. Se decide reestructurar toda la tabla porque un usuario puede tener uno o más trabajos

CREATE TABLE Usuarios(
	Trabajador_ID INT PRIMARY KEY,
	Nombre_Usuario VARCHAR(30)
);

-- Insertando registros

INSERT INTO Usuarios
SELECT IdTrabajador, Nombre FROM Trabajadores;

-- Prueba de registros insertados

SELECT * FROM Usuarios;

-- Tabla que indica el tipo de contrato

CREATE TABLE TipoContrato(
	Tipo_ID INT PRIMARY KEY IDENTITY(1, 1),
	Contrato_Nombre VARCHAR(30)
);

-- Insertando registros en la tabla de tipo de contrato

INSERT INTO TipoContrato
VALUES
('Indefinido'), ('Obra labor'), ('Prestacion de servicios'), ('Freenlance');

-- Prueba de registros ingresados

SELECT * FROM TipoContrato;

-- Se crea una tabla que brinda los detalles del trabajo que realiza cada usuario

CREATE TABLE DetalleTrabajo(
	Detalle_ID INT PRIMARY KEY IDENTITY(1, 1),
	Trabajador_ID INT NOT NULL,
	Modalidad_ID INT,
	Cargo_ID INT NOT NULL,
	Empresa_ID INT NOT NULL,
	Contrato_ID INT,
	Ciudad_ID INT,
	Fecha_Ingreso DATE,
	
	-- Clave foranea con trabajador

	CONSTRAINT FK_TRABAJADOR FOREIGN KEY (Trabajador_ID) REFERENCES Usuarios(Trabajador_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,

	-- Clave foranea con modalidad de trabajo

	CONSTRAINT FK_MODALIDAD_TRABAJO FOREIGN KEY (Modalidad_ID) REFERENCES ModalidadTrabajo(Modalidad_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	
	-- Clave foranea con compañia

	CONSTRAINT FK_EMPRESA_TRABAJA FOREIGN KEY (Empresa_ID) REFERENCES Compania(Empresa_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,

	-- Clave foranea con cargo o puesto de trabajo

	CONSTRAINT FK_PUESTO_TRABAJO FOREIGN KEY (Cargo_ID) REFERENCES CargoEmpleado(Cargo_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,

	-- Clave foranea con tipo de contrato

	CONSTRAINT FK_TIPO_CONTRATO FOREIGN KEY (Contrato_ID) REFERENCES TipoContrato(Tipo_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,

	-- Clave foranea con ciudad

	CONSTRAINT FK_CIUDAD FOREIGN KEY (Ciudad_ID) REFERENCES Ciudad(Ciudad_ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
);