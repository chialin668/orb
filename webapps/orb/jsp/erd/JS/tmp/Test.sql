
CREATE TABLE E_1 (
       e1_id                CHAR(18) NOT NULL
);

CREATE UNIQUE INDEX XPKE_1 ON E_1
(
       e1_id                          ASC
);


ALTER TABLE E_1
       ADD  ( PRIMARY KEY (e1_id) ) ;


CREATE TABLE E_1_E_4 (
       e1_id                CHAR(18) NOT NULL,
       e4_id                NUMBER NOT NULL
);

CREATE UNIQUE INDEX XPKE_1_E_4 ON E_1_E_4
(
       e1_id                          ASC,
       e4_id                          ASC
);

CREATE INDEX XIF4E_1_E_4 ON E_1_E_4
(
       e1_id                          ASC
);

CREATE INDEX XIF5E_1_E_4 ON E_1_E_4
(
       e4_id                          ASC
);


ALTER TABLE E_1_E_4
       ADD  ( PRIMARY KEY (e1_id, e4_id) ) ;


CREATE TABLE E_2 (
       e2_ie                NUMBER NOT NULL,
       e1_id                CHAR(18) NOT NULL
);

CREATE UNIQUE INDEX XPKE_2 ON E_2
(
       e2_ie                          ASC,
       e1_id                          ASC
);

CREATE INDEX XIF1E_2 ON E_2
(
       e1_id                          ASC
);


ALTER TABLE E_2
       ADD  ( PRIMARY KEY (e2_ie, e1_id) ) ;


CREATE TABLE E_3 (
       e3_id                NUMBER NOT NULL,
       e1_id                CHAR(18) NULL
);

CREATE UNIQUE INDEX XPKE_3 ON E_3
(
       e3_id                          ASC
);

CREATE INDEX XIF2E_3 ON E_3
(
       e1_id                          ASC
);


ALTER TABLE E_3
       ADD  ( PRIMARY KEY (e3_id) ) ;


CREATE TABLE E_4 (
       e4_id                NUMBER NOT NULL
);

CREATE UNIQUE INDEX XPKE_4 ON E_4
(
       e4_id                          ASC
);


ALTER TABLE E_4
       ADD  ( PRIMARY KEY (e4_id) ) ;


ALTER TABLE E_1_E_4
       ADD  ( FOREIGN KEY (e4_id)
                             REFERENCES E_4 ) ;


ALTER TABLE E_1_E_4
       ADD  ( FOREIGN KEY (e1_id)
                             REFERENCES E_1 ) ;


ALTER TABLE E_2
       ADD  ( FOREIGN KEY (e1_id)
                             REFERENCES E_1 ) ;


ALTER TABLE E_3
       ADD  ( FOREIGN KEY (e1_id)
                             REFERENCES E_1 ) ;

