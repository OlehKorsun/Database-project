-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2025-01-21 23:56:50.088

-- foreign keys
ALTER TABLE Adres DROP CONSTRAINT Adres_Miasto;

ALTER TABLE Firma DROP CONSTRAINT Firma_Wlasciciel_Konta;

ALTER TABLE Transakcja DROP CONSTRAINT HistoriaOperacji_Operacja;

ALTER TABLE Konto DROP CONSTRAINT Konto_TypKonta;

ALTER TABLE Konto DROP CONSTRAINT Konto_Waluta;

ALTER TABLE Miasto DROP CONSTRAINT Miasto_Kraj;

ALTER TABLE Osoba DROP CONSTRAINT Osoba_Adres;

ALTER TABLE Osoba DROP CONSTRAINT Osoba_Wlasciciel_Konta;

ALTER TABLE Przelew DROP CONSTRAINT Przelew_Konto_1;

ALTER TABLE Przelew DROP CONSTRAINT Przelew_Konto_2;

ALTER TABLE Przelew DROP CONSTRAINT Przelew_Status_Transakcji;

ALTER TABLE Wlascicel_Konto DROP CONSTRAINT Table_19_Konto;

ALTER TABLE Ubezpieczenie DROP CONSTRAINT Table_7_Ubiezpieczenie;

ALTER TABLE Transakcja DROP CONSTRAINT Transakcja_Adres;

ALTER TABLE Transakcja DROP CONSTRAINT Transakcja_Konto;

ALTER TABLE Transakcja DROP CONSTRAINT Transakcja_Status_Transakcji;

ALTER TABLE Ubezpieczenie DROP CONSTRAINT Ubezpieczenie_Konto;

ALTER TABLE Wlasciciel_Konta DROP CONSTRAINT Wlasciciel_Konta_Adres;

ALTER TABLE Wlascicel_Konto DROP CONSTRAINT Wlasciciel_Konta_Konto;

-- tables
DROP TABLE Adres;

DROP TABLE BANK_GEN;

DROP TABLE Firma;

DROP TABLE Konto;

DROP TABLE Kraj;

DROP TABLE Miasto;

DROP TABLE Operacja;

DROP TABLE Osoba;

DROP TABLE Przelew;

DROP TABLE Status_Operacji;

DROP TABLE Transakcja;

DROP TABLE Typ_Konta;

DROP TABLE Typ_Ubezpieczenia;

DROP TABLE Ubezpieczenie;

DROP TABLE Waluta;

DROP TABLE Wlascicel_Konto;

DROP TABLE Wlasciciel_Konta;

-- End of file.




-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2025-01-21 23:56:50.088

-- tables
-- Table: Adres
CREATE TABLE Adres (
    ID int  NOT NULL,
    Ulica varchar(50)  NOT NULL,
    Miasto_ID int  NOT NULL,
    NrDomu int  NOT NULL,
    NrMieszkania int  NULL,
    CONSTRAINT Adres_pk PRIMARY KEY  (ID)
);

-- Table: BANK_GEN
CREATE TABLE BANK_GEN (
    NR_ROZLICZENIOWY varchar(4)  NOT NULL,
    KOD_KRAJU varchar(2)  NOT NULL,
    OSTATNI_ID_KLIENTA varchar(4)  NOT NULL,
    OSTATNI_NR_ID_KLIENTA varchar(16)  NOT NULL
);

-- Table: Firma
CREATE TABLE Firma (
    Wlasciciel_Konta_ID int  NOT NULL,
    Nazwa varchar(100)  NOT NULL,
    CONSTRAINT Firma_pk PRIMARY KEY  (Wlasciciel_Konta_ID)
);

-- Table: Konto
CREATE TABLE Konto (
    ID int  NOT NULL,
    NrKonta varchar(26)  NOT NULL,
    Waluta_ID int  NOT NULL,
    IBAN varchar(28)  NOT NULL,
    NazwaRachunku varchar(50)  NOT NULL,
    Balans money  NOT NULL,
    Data_Aktywowania date  NOT NULL,
    Data_Utworzenia date  NOT NULL,
    TypKonta_ID int  NOT NULL,
    CONSTRAINT NrKonta UNIQUE (NrKonta),
    CONSTRAINT IBAN UNIQUE (IBAN),
    CONSTRAINT Konto_pk PRIMARY KEY  (ID)
);

CREATE INDEX Konto_idx_1 on Konto (Balans ASC)
;

-- Table: Kraj
CREATE TABLE Kraj (
    ID int  NOT NULL,
    Nazwa varchar(50)  NOT NULL,
    CONSTRAINT Kraj_pk PRIMARY KEY  (ID)
);

-- Table: Miasto
CREATE TABLE Miasto (
    ID int  NOT NULL,
    Nazwa varchar(50)  NOT NULL,
    Kraj_ID int  NOT NULL,
    CONSTRAINT Miasto_pk PRIMARY KEY  (ID)
);

-- Table: Operacja
CREATE TABLE Operacja (
    ID int  NOT NULL,
    Nazwa varchar(50)  NOT NULL,
    CONSTRAINT Operacja_pk PRIMARY KEY  (ID)
);

-- Table: Osoba
CREATE TABLE Osoba (
    Wlasciciel_Konta_ID int  NOT NULL,
    Imie varchar(50)  NOT NULL,
    Nazwisko varchar(50)  NOT NULL,
    NR_Dokumentu varchar(50)  NOT NULL,
    PESEL varchar(11)  NULL,
    NR_Telefonu varchar(20)  NOT NULL,
    AdresMail varchar(50)  NOT NULL,
    AdresZamieszkania_ID int  NOT NULL,
    CONSTRAINT Osoba_ak_1 UNIQUE (NR_Dokumentu, PESEL),
    CONSTRAINT Osoba_pk PRIMARY KEY  (Wlasciciel_Konta_ID)
);

-- Table: Przelew
CREATE TABLE Przelew (
    ID int  NOT NULL,
    KontoSkad_ID int  NOT NULL,
    KontoDokad_ID int  NOT NULL,
    Kwota numeric(30,2)  NOT NULL,
    Czas datetime  NOT NULL,
    Status_Operacji_ID int  NOT NULL,
    CONSTRAINT Przelew_pk PRIMARY KEY  (ID)
);

-- Table: Status_Operacji
CREATE TABLE Status_Operacji (
    ID int  NOT NULL,
    Nazwa varchar(50)  NOT NULL,
    CONSTRAINT Status_Operacji_pk PRIMARY KEY  (ID)
);

-- Table: Transakcja
CREATE TABLE Transakcja (
    ID int  NOT NULL,
    Konto_ID int  NOT NULL,
    Operacja_ID int  NOT NULL,
    NrKonta varchar(26)  NULL,
    Adres_ID int  NOT NULL,
    Kwota money  NOT NULL,
    Czas datetime  NOT NULL,
    Status_Operacji_ID int  NOT NULL,
    CONSTRAINT Transakcja_pk PRIMARY KEY  (ID)
);

-- Table: Typ_Konta
CREATE TABLE Typ_Konta (
    ID int  NOT NULL,
    Nazwa varchar(50)  NOT NULL,
    Oprocentowanie numeric(3,2)  NOT NULL,
    CONSTRAINT Typ_Konta_pk PRIMARY KEY  (ID)
);

-- Table: Typ_Ubezpieczenia
CREATE TABLE Typ_Ubezpieczenia (
    ID int  NOT NULL,
    Nazwa varchar(50)  NOT NULL,
    CONSTRAINT Typ_Ubezpieczenia_pk PRIMARY KEY  (ID)
);

-- Table: Ubezpieczenie
CREATE TABLE Ubezpieczenie (
    ID int  NOT NULL,
    Konto_ID int  NOT NULL,
    Ubezpieczenie_ID int  NOT NULL,
    Kwota money  NOT NULL,
    DataStart date  NOT NULL,
    DataKoniec date  NOT NULL,
    CONSTRAINT Ubezpieczenie_pk PRIMARY KEY  (ID)
);

-- Table: Waluta
CREATE TABLE Waluta (
    ID int  NOT NULL,
    Nazwa varchar(10)  NOT NULL,
    CONSTRAINT Waluta_pk PRIMARY KEY  (ID)
);

-- Table: Wlascicel_Konto
CREATE TABLE Wlascicel_Konto (
    Konto_ID int  NOT NULL,
    Wlasciciel_Konta_ID int  NOT NULL,
    CONSTRAINT Wlascicel_Konto_pk PRIMARY KEY  (Konto_ID,Wlasciciel_Konta_ID)
);

-- Table: Wlasciciel_Konta
CREATE TABLE Wlasciciel_Konta (
    ID int  NOT NULL,
    Adres_Korespondencji int  NOT NULL,
    CONSTRAINT Wlasciciel_Konta_pk PRIMARY KEY  (ID)
);

-- foreign keys
-- Reference: Adres_Miasto (table: Adres)
ALTER TABLE Adres ADD CONSTRAINT Adres_Miasto
    FOREIGN KEY (Miasto_ID)
    REFERENCES Miasto (ID);

-- Reference: Firma_Wlasciciel_Konta (table: Firma)
ALTER TABLE Firma ADD CONSTRAINT Firma_Wlasciciel_Konta
    FOREIGN KEY (Wlasciciel_Konta_ID)
    REFERENCES Wlasciciel_Konta (ID);

-- Reference: HistoriaOperacji_Operacja (table: Transakcja)
ALTER TABLE Transakcja ADD CONSTRAINT HistoriaOperacji_Operacja
    FOREIGN KEY (Operacja_ID)
    REFERENCES Operacja (ID);

-- Reference: Konto_TypKonta (table: Konto)
ALTER TABLE Konto ADD CONSTRAINT Konto_TypKonta
    FOREIGN KEY (TypKonta_ID)
    REFERENCES Typ_Konta (ID);

-- Reference: Konto_Waluta (table: Konto)
ALTER TABLE Konto ADD CONSTRAINT Konto_Waluta
    FOREIGN KEY (Waluta_ID)
    REFERENCES Waluta (ID);

-- Reference: Miasto_Kraj (table: Miasto)
ALTER TABLE Miasto ADD CONSTRAINT Miasto_Kraj
    FOREIGN KEY (Kraj_ID)
    REFERENCES Kraj (ID);

-- Reference: Osoba_Adres (table: Osoba)
ALTER TABLE Osoba ADD CONSTRAINT Osoba_Adres
    FOREIGN KEY (AdresZamieszkania_ID)
    REFERENCES Adres (ID);

-- Reference: Osoba_Wlasciciel_Konta (table: Osoba)
ALTER TABLE Osoba ADD CONSTRAINT Osoba_Wlasciciel_Konta
    FOREIGN KEY (Wlasciciel_Konta_ID)
    REFERENCES Wlasciciel_Konta (ID);

-- Reference: Przelew_Konto_1 (table: Przelew)
ALTER TABLE Przelew ADD CONSTRAINT Przelew_Konto_1
    FOREIGN KEY (KontoSkad_ID)
    REFERENCES Konto (ID);

-- Reference: Przelew_Konto_2 (table: Przelew)
ALTER TABLE Przelew ADD CONSTRAINT Przelew_Konto_2
    FOREIGN KEY (KontoDokad_ID)
    REFERENCES Konto (ID);

-- Reference: Przelew_Status_Transakcji (table: Przelew)
ALTER TABLE Przelew ADD CONSTRAINT Przelew_Status_Transakcji
    FOREIGN KEY (Status_Operacji_ID)
    REFERENCES Status_Operacji (ID);

-- Reference: Table_19_Konto (table: Wlascicel_Konto)
ALTER TABLE Wlascicel_Konto ADD CONSTRAINT Table_19_Konto
    FOREIGN KEY (Konto_ID)
    REFERENCES Konto (ID);

-- Reference: Table_7_Ubiezpieczenie (table: Ubezpieczenie)
ALTER TABLE Ubezpieczenie ADD CONSTRAINT Table_7_Ubiezpieczenie
    FOREIGN KEY (Ubezpieczenie_ID)
    REFERENCES Typ_Ubezpieczenia (ID);

-- Reference: Transakcja_Adres (table: Transakcja)
ALTER TABLE Transakcja ADD CONSTRAINT Transakcja_Adres
    FOREIGN KEY (Adres_ID)
    REFERENCES Adres (ID);

-- Reference: Transakcja_Konto (table: Transakcja)
ALTER TABLE Transakcja ADD CONSTRAINT Transakcja_Konto
    FOREIGN KEY (Konto_ID)
    REFERENCES Konto (ID);

-- Reference: Transakcja_Status_Transakcji (table: Transakcja)
ALTER TABLE Transakcja ADD CONSTRAINT Transakcja_Status_Transakcji
    FOREIGN KEY (Status_Operacji_ID)
    REFERENCES Status_Operacji (ID);

-- Reference: Ubezpieczenie_Konto (table: Ubezpieczenie)
ALTER TABLE Ubezpieczenie ADD CONSTRAINT Ubezpieczenie_Konto
    FOREIGN KEY (Konto_ID)
    REFERENCES Konto (ID);

-- Reference: Wlasciciel_Konta_Adres (table: Wlasciciel_Konta)
ALTER TABLE Wlasciciel_Konta ADD CONSTRAINT Wlasciciel_Konta_Adres
    FOREIGN KEY (Adres_Korespondencji)
    REFERENCES Adres (ID);

-- Reference: Wlasciciel_Konta_Konto (table: Wlascicel_Konto)
ALTER TABLE Wlascicel_Konto ADD CONSTRAINT Wlasciciel_Konta_Konto
    FOREIGN KEY (Wlasciciel_Konta_ID)
    REFERENCES Wlasciciel_Konta (ID);

-- End of file.

