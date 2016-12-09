-- DML für die GEO Datenbank

--erstelle Daten für die Tabelle Staat
INSERT INTO staat(staat_id, sname, bodenflaeche, anzahl_einwohner)
VALUES (staat_seq.NEXTVAL, 'Deutschland', '40.3', '82.11');

INSERT INTO bundesland(Bundesland_id, bname, bodenflaeche, anzahl_einwohner)
VALUES (bundesland_seq.NEXTVAL, 'NRW', '5.3', '17.11');
