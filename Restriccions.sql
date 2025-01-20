CREATE DATABASE videogames;

USE Videogames;

-- 1. Crear la taula **Generes** amb la columna `nom_genere` única
CREATE TABLE Generes (
    id_genere INT PRIMARY KEY,
    nom_genere VARCHAR(100) UNIQUE
);

CREATE TABLE plataformes (
    id_plataforma INT AUTO_INCREMENT PRIMARY KEY,
    nom_plataforma VARCHAR(100) NOT NULL,
    fabricant VARCHAR(100) NOT NULL,
    any_lançament YEAR NOT NULL
);

CREATE TABLE desenvolupadors (
    id_desenvolupador INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    país VARCHAR(50) NOT NULL,
    any_fundació YEAR NOT NULL
);

CREATE TABLE videojocs (
    id_videojoc INT AUTO_INCREMENT PRIMARY KEY,
    titol VARCHAR(100) NOT NULL,
    id_genere INT NOT NULL,
    id_desenvolupador INT NOT NULL,
    id_plataforma INT NOT NULL,
    data_lançament DATE NOT NULL,
    preu DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_genere) REFERENCES generes(id_genere),
    FOREIGN KEY (id_desenvolupador) REFERENCES desenvolupadors(id_desenvolupador),
    FOREIGN KEY (id_plataforma) REFERENCES plataformes(id_plataforma)
);

-- Restricciones

-- 1. Hacer `nom_genere` en Generes única
ALTER TABLE generes
ADD CONSTRAINT unique_nom_genere UNIQUE (nom_genere);

-- 2. Restringir `any_fundació` en Desenvolupadors a un valor superior a 1900
ALTER TABLE desenvolupadors
ADD CONSTRAINT check_any_fundacio CHECK (any_fundació > 1900);

-- 3. Configurar un valor predeterminado de 59.99 para `preu` en Videojocs
ALTER TABLE videojocs
MODIFY COLUMN preu DECIMAL(10,2) DEFAULT 59.99;

-- 4. Establecer ON DELETE CASCADE en las claves foráneas de Videojocs
ALTER TABLE videojocs
DROP FOREIGN KEY videojocs_ibfk_1; -- Eliminar clave foránea existente (si ya existe)
ALTER TABLE videojocs
ADD CONSTRAINT fk_videojocs_generes FOREIGN KEY (id_genere)
REFERENCES generes(id_genere) ON DELETE CASCADE;

ALTER TABLE videojocs
DROP FOREIGN KEY videojocs_ibfk_2; -- Eliminar clave foránea existente
ALTER TABLE videojocs
ADD CONSTRAINT fk_videojocs_desenvolupadors FOREIGN KEY (id_desenvolupador)
REFERENCES desenvolupadors(id_desenvolupador) ON DELETE CASCADE;

ALTER TABLE videojocs
DROP FOREIGN KEY videojocs_ibfk_3; -- Eliminar clave foránea existente
ALTER TABLE videojocs
ADD CONSTRAINT fk_videojocs_plataformes FOREIGN KEY (id_plataforma)
REFERENCES plataformes(id_plataforma) ON DELETE CASCADE;

-- 5. Restringir `any_lançament` en Plataformes a un valor superior a 1970
ALTER TABLE plataformes
ADD CONSTRAINT check_any_lançament CHECK (any_lançament > 1970);

-- 6. Configurar valor predeterminado 'Desconegut' para `país` en Desenvolupadors
ALTER TABLE desenvolupadors
MODIFY COLUMN país VARCHAR(50) DEFAULT 'Desconegut';

-- 7. Restringir `preu` en Videojocs a valores iguales o superiores a 0
ALTER TABLE videojocs
ADD CONSTRAINT check_preu CHECK (preu >= 0);

-- 8. Hacer `nom_plataforma` en Plataformes única
ALTER TABLE plataformes
ADD CONSTRAINT unique_nom_plataforma UNIQUE (nom_plataforma);

-- 9. Hacer `nom` en Desenvolupadors único
ALTER TABLE desenvolupadors
ADD CONSTRAINT unique_nom_desenvolupador UNIQUE (nom);

