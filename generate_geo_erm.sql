
CREATE TABLE Staat
(
	Staat_id             NUMBER NOT NULL ,
	Name                 VARCHAR2(50) NULL ,
	Bodenflaeche         NUMBER NULL ,
	Anzahl_Einwohner     NUMBER NULL ,
	Hauptstadt_id        NUMBER NOT NULL
);

CREATE UNIQUE INDEX XPKStaat ON Staat
(Staat_id   ASC);

ALTER TABLE Staat
	ADD CONSTRAINT  XPKStaat PRIMARY KEY (Staat_id);

CREATE TABLE Bundesland
(
	Bundesland_id        NUMBER NOT NULL ,
	Name                 VARCHAR2(50) NULL ,
	Bodenflaeche         NUMBER NULL ,
	Anzahl_Einwohner     NUMBER NULL ,
	Staat_id             NUMBER NOT NULL ,
	Hauptstadt_id        NUMBER NOT NULL
);

CREATE UNIQUE INDEX XPKBundesland ON Bundesland
(Bundesland_id   ASC);

ALTER TABLE Bundesland
	ADD CONSTRAINT  XPKBundesland PRIMARY KEY (Bundesland_id);

CREATE TABLE Kontinent
(
	Kontinent_id         NUMBER NOT NULL ,
	Name                 VARCHAR2(50) NULL ,
	Bodenflaeche         NUMBER NULL ,
	Anzahl_Einwohner     NUMBER NULL
);

CREATE UNIQUE INDEX XPKKontinent ON Kontinent
(Kontinent_id   ASC);

ALTER TABLE Kontinent
	ADD CONSTRAINT  XPKKontinent PRIMARY KEY (Kontinent_id);

CREATE TABLE Kontinent_Staat
(
	Kontinent_id         NUMBER NOT NULL ,
	Staat_id             NUMBER NOT NULL
);

CREATE UNIQUE INDEX XPKKontinent_Staat ON Kontinent_Staat
(Kontinent_id   ASC,Staat_id   ASC);

ALTER TABLE Kontinent_Staat
	ADD CONSTRAINT  XPKKontinent_Staat PRIMARY KEY (Kontinent_id,Staat_id);

CREATE TABLE Organisation
(
	Organisation_id      NUMBER NOT NULL ,
	Abkuerzung           VARCHAR2(10) NULL ,
	Name                 VARCHAR2(50) NULL ,
	Gruendungsdatum      DATE NULL
);

CREATE UNIQUE INDEX XPKOrganisation ON Organisation
(Organisation_id   ASC);

ALTER TABLE Organisation
	ADD CONSTRAINT  XPKOrganisation PRIMARY KEY (Organisation_id);

CREATE TABLE Ist_Mitglied
(
	Organisation_id      NUMBER NOT NULL ,
	Staat_id             NUMBER NOT NULL ,
	Typ                  VARCHAR2(50) NULL
);

CREATE UNIQUE INDEX XPKIst_Mitglied ON Ist_Mitglied
(Organisation_id   ASC,Staat_id   ASC);

ALTER TABLE Ist_Mitglied
	ADD CONSTRAINT  XPKIst_Mitglied PRIMARY KEY (Organisation_id,Staat_id);

CREATE TABLE Stadt
(
	Stadt_id             NUMBER NOT NULL ,
	Name                 VARCHAR2(50) NULL ,
	Anzahl_Einwohner     NUMBER NULL ,
	Laengengrad          NUMBER NULL ,
	Breitengrad          NUMBER NULL ,
	Bundesland_id        NUMBER NOT NULL
);

CREATE UNIQUE INDEX XPKStadt ON Stadt
(Stadt_id   ASC);

ALTER TABLE Stadt
	ADD CONSTRAINT  XPKStadt PRIMARY KEY (Stadt_id);

CREATE TABLE Staat_Staat
(
	Staat_id             NUMBER NOT NULL
);

CREATE UNIQUE INDEX XPKStaat_Staat ON Staat_Staat
(Staat_id   ASC);

ALTER TABLE Staat_Staat
	ADD CONSTRAINT  XPKStaat_Staat PRIMARY KEY (Staat_id);

ALTER TABLE Staat
	ADD (CONSTRAINT R_12 FOREIGN KEY (Hauptstadt_id) REFERENCES Stadt (Stadt_id));

ALTER TABLE Bundesland
	ADD (CONSTRAINT R_4 FOREIGN KEY (Staat_id) REFERENCES Staat (Staat_id));

ALTER TABLE Bundesland
	ADD (CONSTRAINT R_11 FOREIGN KEY (Hauptstadt_id) REFERENCES Stadt (Stadt_id));

ALTER TABLE Kontinent_Staat
	ADD (CONSTRAINT R_2 FOREIGN KEY (Kontinent_id) REFERENCES Kontinent (Kontinent_id));

ALTER TABLE Kontinent_Staat
	ADD (CONSTRAINT R_3 FOREIGN KEY (Staat_id) REFERENCES Staat (Staat_id));

ALTER TABLE Ist_Mitglied
	ADD (CONSTRAINT R_8 FOREIGN KEY (Organisation_id) REFERENCES Organisation (Organisation_id));

ALTER TABLE Ist_Mitglied
	ADD (CONSTRAINT R_9 FOREIGN KEY (Staat_id) REFERENCES Staat (Staat_id));

ALTER TABLE Stadt
	ADD (CONSTRAINT R_10 FOREIGN KEY (Bundesland_id) REFERENCES Bundesland (Bundesland_id));

ALTER TABLE Staat_Staat
	ADD (CONSTRAINT R_6 FOREIGN KEY (Staat_id) REFERENCES Staat (Staat_id));

ALTER TABLE Staat_Staat
	ADD (CONSTRAINT R_7 FOREIGN KEY (Staat_id) REFERENCES Staat (Staat_id));
