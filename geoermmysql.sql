DROP DATABASE if exists geo;
create DATABASE geo;
	use geo;

CREATE TABLE kontinent (
  kontinent_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  kname VARCHAR(255) NOT NULL,
  bodenflaeche DECIMAL(30,2) NOT NULL,
  anzahl_einwohner DECIMAL(30,2) NOT NULL
);

CREATE TABLE organisation (
  organisation_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  abkuerzung varchar(3),
  oname varchar(255),
  gruendungsdatum DATE
);

CREATE TABLE staat (
  staat_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  sname varchar(50),
  bodenflaeche DECIMAL(3,1),
  anzahl_einwohner DECIMAL(4,2),
  hauptstadt_id INTEGER
);

CREATE TABLE kontinent_staat (
  kontinent_id INTEGER NOT NULL,
  staat_id INTEGER NOT NULL,
  CONSTRAINT kontinent_fk PRIMARY KEY (kontinent_id, staat_id)
);

ALTER TABLE kontinent_staat ADD CONSTRAINT kontinent_staat_kon_fk FOREIGN KEY (kontinent_id) REFERENCES kontinent (kontinent_id);
ALTER TABLE kontinent_staat ADD CONSTRAINT kontinent_staat_st_fk FOREIGN KEY (staat_id) REFERENCES staat (staat_id);

CREATE TABLE ist_mitglied (
  organisation_id INTEGER NOT NULL,
  staat_id INTEGER NOT NULL,
  typ VARCHAR(50),
  CONSTRAINT ist_mitglied_fk PRIMARY KEY (organisation_id, staat_id),
  CONSTRAINT typ_ck CHECK (typ LIKE 'Anwaerter' OR typ LIKE 'Gast' OR typ LIKE 'Mitglied' OR typ LIKE 'Beobachter')
);

ALTER TABLE ist_mitglied ADD CONSTRAINT ist_mitglied_org_fk FOREIGN KEY (organisation_id) REFERENCES organisation (organisation_id);
ALTER TABLE ist_mitglied ADD CONSTRAINT ist_mitglied_st_fk FOREIGN KEY (staat_id) REFERENCES staat (staat_id);


CREATE TABLE staat_staat (
  staat_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  CONSTRAINT staat_fk1 FOREIGN KEY (staat_id)
    REFERENCES staat (staat_id)
);

CREATE TABLE stadt (
  stadt_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  sname varchar(255) NOT NULL,
  anzahl_einwohner DECIMAL(30,2) NOT NULL,
  laengengrad DECIMAL (7,4) NOT NULL,
  breitengrad DECIMAL (7,4) NOT NULL,
  bundesland_id INTEGER NOT NULL
);

CREATE TABLE bundesland (
  bundesland_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  bname varchar(255),
  bodenflaeche DECIMAL(2,1),
  anzahl_einwohner DECIMAL(4,2),
  staat_id INTEGER,
  hauptstadt_id INTEGER,
  CONSTRAINT staat_fk2 FOREIGN KEY (staat_id)
    REFERENCES staat (staat_id),
  CONSTRAINT hauptstadt_fk FOREIGN KEY (hauptstadt_id)
    REFERENCES stadt (stadt_id)
);

ALTER TABLE staat
  ADD CONSTRAINT hauptstadt_fk2 FOREIGN KEY (hauptstadt_id)
    REFERENCES stadt (stadt_id);

ALTER TABLE stadt
  ADD CONSTRAINT bundesland_fk FOREIGN KEY (Bundesland_id)
    REFERENCES bundesland (Bundesland_id);

/*		#Aufgabe 2:
		# MySQL Datenbank Unterschiede
		# 1. Es werden keine Sequenzen benötigt, MySQL besitzt den die Möglichkeit über AUTO_INCREMENT den Index hochzuzählen
		# 2. andere Datentypen varchar2 existiert nicht, nur varchar
		# 3.
*/
