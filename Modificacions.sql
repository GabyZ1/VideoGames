-- Modificaciones

-- 1. Agregar columna `popularitat` a Videojocs con valores entre 1 y 100
ALTER TABLE videojocs
ADD COLUMN popularitat TINYINT UNSIGNED CHECK (popularitat BETWEEN 1 AND 100);

-- 2. Modificar longitud de `fabricant` en Plataformes a 150 caracteres
ALTER TABLE plataformes
MODIFY COLUMN fabricant VARCHAR(150) NOT NULL;

-- 3. Cambiar nombre de `nom_genere` a `tipus_genere` en Generes
ALTER TABLE generes
CHANGE COLUMN nom_genere tipus_genere VARCHAR(50) NOT NULL;

-- 4. Añadir restricción adicional a `any_fundació` para aceptar valores > 1950
ALTER TABLE desenvolupadors
DROP CONSTRAINT check_any_fundacio;
ALTER TABLE desenvolupadors
ADD CONSTRAINT check_any_fundacio CHECK (any_fundació > 1950);

-- 5. Eliminar columna `país` de Desenvolupadors
ALTER TABLE desenvolupadors
DROP COLUMN país;

-- 6. Crear la tabla Editors
CREATE TABLE editors (
    id_editor INT PRIMARY KEY,
    nom_editor VARCHAR(100) NOT NULL
);

-- 7. Añadir columna `id_editor` a Videojocs y crear clave foránea con ON DELETE SET NULL
ALTER TABLE videojocs
ADD COLUMN id_editor INT NULL,
ADD CONSTRAINT fk_videojocs_editors FOREIGN KEY (id_editor)
REFERENCES editors(id_editor) ON DELETE SET NULL;

-- 8. Modificar el valor predeterminado de `preu` en Videojocs a 49.99
ALTER TABLE videojocs
MODIFY COLUMN preu DECIMAL(10,2) DEFAULT 49.99;

-- 9. Eliminar completamente la tabla Generes
ALTER TABLE videojocs
DROP FOREIGN KEY fk_videojocs_generes;
DROP TABLE IF EXISTS generes;

-- 10. Cambiar el nombre de la tabla Desenvolupadors a Estudis
RENAME TABLE desenvolupadors TO estudis;

-- 11. Añadir restricción UNIQUE a la columna `títol` en Videojocs
ALTER TABLE videojocs
ADD CONSTRAINT unique_titol UNIQUE (titol);
