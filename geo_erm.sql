-- GEO ER-Modell zur Praktikumsaufgabe 1
-- @author Jonas Jansen
--blablatest
--Tabllen löschen
DROP TABLE kontinent CASCADE CONSTRAINTS;
DROP TABLE organisation CASCADE CONSTRAINTS;
DROP TABLE staat CASCADE CONSTRAINTS;
DROP TABLE bundesland CASCADE CONSTRAINTS;
DROP TABLE stadt CASCADE CONSTRAINTS;
DROP TABLE kontinent_staat CASCADE CONSTRAINTS;
DROP TABLE ist_mitglied CASCADE CONSTRAINTS;
DROP TABLE staat_staat CASCADE CONSTRAINTS;
DROP SEQUENCE bundesland_seq;
DROP SEQUENCE staat_seq;

CREATE TABLE kontinent (
  kontinent_id INTEGER PRIMARY KEY,
  kname VARCHAR2(255) NOT NULL,
  bodenflaeche DECIMAL(30,2) NOT NULL,
  anzahl_einwohner DECIMAL(30,2) NOT NULL
);

CREATE TABLE organisation (
  organisation_id INTEGER PRIMARY KEY,
  abkuerzung VARCHAR2(3),
  oname VARCHAR2(255) NOT NULL,
  gruendungsdatum DATE
);

CREATE TABLE staat (
  staat_id INTEGER PRIMARY KEY,
  sname VARCHAR2(50) NOT NULL,
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
    ON DELETE CASCADE,
  CONSTRAINT typ_ck check (lower(typ) in ('Anwaerter', 'Gast', 'Mitglied','Beobachter'))
);

ALTER TABLE ist_mitglied ADD CONSTRAINT ist_mitglied_org_fk FOREIGN KEY (organisation_id) REFERENCES organisation (organisation_id);
ALTER TABLE ist_mitglied ADD CONSTRAINT ist_mitglied_st_fk FOREIGN KEY (staat_id) REFERENCES staat (staat_id);


CREATE TABLE staat_staat (
  staat_id INTEGER PRIMARY KEY,
  CONSTRAINT staat_fk1 FOREIGN KEY (staat_id)
    REFERENCES staat (staat_id)
);

CREATE TABLE stadt (
  stadt_id INTEGER PRIMARY KEY,
  sname VARCHAR2(255) NOT NULL,
  anzahl_einwohner DECIMAL(30,2),
  laengengrad DECIMAL (3,4),
  breitengrad DECIMAL (3,4),
  bundesland_id INTEGER NOT NULL
);

CREATE TABLE bundesland (
  bundesland_id INTEGER PRIMARY KEY,
  bname VARCHAR2(255) NOT NULL,
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
  ADD CONSTRAINT bundesland_fk FOREIGN KEY (bundesland_id)
    REFERENCES bundesland (Bundesland_id);

SET CONSTRAINT ALL IMMEDIATE;

--eindeutiger INDEX

CREATE INDEX sname_idx ON staat (sname);

--Sequenz für zwei Tabellen erstellen
CREATE SEQUENCE staat_seq;
START WITH 1
INCREMENT BY 1;
CREATE SEQUENCE bundesland_seq;
START WITH 1
INCREMENT BY 1;



--1b) Was ist zu beachten, wenn die Fremdschlüssel mittels der CREATE TABLE-Befehle erstellt werden?
--    Es können keine Tabellen mit Fremdschlüssel erstellt werden, wenn die Tabelle mit den PK's auf die sich die FK's beziehen
--    noch nicht existieren
--    Bei welchem SQL-DDL-Befehl tritt dieses Problem nicht auf?
--    Bei dem ALTER TABLE Befehl wird erst nachträglich der Fremdschlüssel hinzugefügt
--1h) Um welche Befehle sollte so eine Skript-Datei auf jeden Fall ergänzt werden, damit sie im Fehlerfall wie-derholt ausgeführt werden kann?
--    Welche spezielle Klausel wird hier notwendig, sobald Fremdschlüssel im Modell angelegt werden?
--    Skript Datei sollte am Anfang Befehle beinhalten mit denen die alte Tabelle gelöscht wird, sonst erhält man Fehlermeldungen
--    werden FK's benutzt so muss auf die Abhängigkeit zu anderen Tabellen geachtet werden. Dies lässt sich mit "DROP TABLE xyz CASCADE CONSTRAINTS" realisieren
