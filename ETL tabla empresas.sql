-- Nueva versión de la tabla empresa

USE ProyectoUsuarios;

-- Se creará una tabla de categoría

CREATE TABLE Categoria(
	Categoria_ID INT PRIMARY KEY,
	Categoria_Nombre VARCHAR(30)
);

INSERT INTO Categoria
SELECT ROW_NUMBER() OVER (ORDER BY CategoriaEmpresa ASC) AS Categoria_ID, CategoriaEmpresa FROM Empresa
GROUP BY CategoriaEmpresa;

-- Se realizan pruebas de que se insertaron los registros

SELECT * FROM Categoria;

-- Creación de la tabla de empresa
-- Por el momento se llamará como Empresa_Prueba

CREATE TABLE Empresa_Prueba(
	Empresa_ID INT PRIMARY KEY,
	Nombre_Empresa VARCHAR(30),
	Categoria_ID INT,
	CONSTRAINT FK_CATEGORIA FOREIGN KEY (Categoria_ID) REFERENCES Categoria(Categoria_ID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

INSERT INTO Empresa_Prueba
SELECT e.IdEmpresa, e.NombreEmpresa, c.Categoria_ID FROM Empresa e INNER JOIN Categoria c 
ON c.Categoria_Nombre = e.CategoriaEmpresa;

SELECT * FROM Empresa_Prueba;

-- Se cambia el nombre de la tabla de Empresa_Prueba

EXEC sp_rename Empresa_Prueba, Compania;