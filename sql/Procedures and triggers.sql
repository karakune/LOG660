CREATE OR REPLACE TRIGGER t_verificationAge BEFORE INSERT ON Client FOR EACH ROW
    BEGIN
        IF (trunc (months_between (SYSDATE, :NEW.dateNaiss) / 12) < 18) THEN
            RAISE_APPLICATION_ERROR(-20000, 'Must be 18 years or older.');
        END IF;
    END;
    
CREATE OR REPLACE TRIGGER t_carteCreditExpiree BEFORE INSERT ON CarteCredit FOR EACH ROW
    BEGIN
        IF (:NEW.dateExp > SYSDATE) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Credit card is expired.');
        END IF;
    END;
    
    --doesn't work
--CREATE OR REPLACE TRIGGER t_mdpAlphanumeric BEFORE INSERT ON Client FOR EACH ROW
--    DECLARE
--        v_count number;
--    BEGIN
--        SELECT REGEXP_COUNT (d.motDePasse, '[^0-9a-z]+', 1, 'i') into v_count FROM dual d;
--        IF (v_count > 0) THEN
--            RAISE_APPLICATION_ERROR(-20002, 'Password must be alphanumerical.');
--        END IF;
--    END;

CREATE OR REPLACE PROCEDURE p_ajouterClient (id NUMBER, nomFamille VARCHAR2, prenom VARCHAR2, courriel VARCHAR2, tel VARCHAR2, 
    anniv DATE, adresse VARCHAR2, ville VARCHAR2, province VARCHAR2, codePostal VARCHAR2, carte VARCHAR2, noCarte VARCHAR2, 
    expMois NUMBER, expAnnee NUMBER, motDePasse VARCHAR2, forfait VARCHAR2)
    AS
        varExpDate VARCHAR2(6);
        varNoCiv NUMBER;
        varAdresse VARCHAR2(50);
    BEGIN
        RAISE_APPLICATION_ERROR(-20000, 'No implementation yet.');
        
        --insert new entry into CarteCredit
        varExpDate := expMois + '' + expAnnee;
        if (LENGTH (varExpDate) < 6) then
            varExpDate := '0' + varExpDate;
        end if;
        
        INSERT INTO CarteCredit(typeCarte, numero, dateExp) 
            VALUES (carte, noCarte, TO_DATE(varExpDate, 'MMYYYY'));
        
        --insert new entry into Client
        varNoCiv := REGEXP_SUBSTR(adresse, '\d+');
        varAdresse := REGEXP_SUBSTR(adresse, '\D+');
        
        INSERT INTO Client(ID, NOCIV, RUE, VILLE, PROVINCE, CODEPOSTAL, PRENOM, NOMFAM, COURRIEL,
            NOTEL, DATENAISS, MOTDEPASSE, CODEFORFAIT)
            VALUES (id, TO_NUMBER(varNoCiv), varAdresse, ville, province, codePostal, prenom, nomFamille,
                courriel, tel, anniv, motDePasse, (SELECT code from Forfait f WHERE f.code = forfait));
    END;

CREATE OR REPLACE PROCEDURE p_ajouterFilm;

CREATE OR REPLACE PROCEDURE p_ajouterPersonne;