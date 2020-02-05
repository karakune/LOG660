CREATE TABLE Client (
    id Number NOT NULL,
    noCiv Number NOT NULL,
    rue VARCHAR2(50) NOT NULL,
    ville VARCHAR2(50) NOT NULL,
    province VARCHAR2(50) NOT NULL,
    codePostal VARCHAR2(50) NOT NULL,
    prenom VARCHAR2(50) NOT NULL,
    nomFam VARCHAR2(50) NOT NULL,
    courriel VARCHAR2(50) UNIQUE NOT NULL,
    noTel VARCHAR2(50) NOT NULL,
    dateNaiss DATE NOT NULL 
        CHECK ((EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM dateNaiss)) >= 18),
    motDePasse VARCHAR2(50) NOT NULL CHECK (LENGTH (motDePasse) > 5),
    PRIMARY KEY (id),
    FOREIGN KEY (codeForfait) REFERENCES Forfait(code)
);

CREATE TABLE CarteCredit (
    typeCarte VARCHAR(20) NOT NULL CHECK (typeCarte IN ('VISA', 'MasterCard', 'Amex')),
    numero VARCHAR2(16) NOT NULL,
    dateExp DATE NOT NULL,
    cvv VARCHAR2(3) NOT NULL,
    PRIMARY KEY (numero)
);

CREATE TABLE Employe (
    matricule VARCHAR2(50) NOT NULL,
    PRIMARY KEY (matricule),
    FOREIGN KEY (idClient) REFERENCES Client(id)
);

CREATE TABLE Forfait (
    nom VARCHAR2(50) NOT NULL,
    coutMois FLOAT NOT NULL,
    maxLocations NUMBER NOT NULL,
    maxDuree NUMBER NOT NULL,
    code VARCHAR2(50) NOT NULL,
    PRIMARY KEY (code)
);

CREATE TABLE Inventaire (
    noCopie NUMBER NOT NULL,
    PRIMARY KEY (noCopie),
    FOREIGN KEY (idFilm) REFERENCES Film(id)
);

CREATE TABLE Location (
    id NUMBER NOT NULL,
    dateLocation DATE NOT NULL,
    etat VARCHAR2(50) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (noCopie) REFERENCES Inventaire(noCopie)
);

CREATE TABLE Film (
    id NUMBER NOT NULL,
    titre VARCHAR2(50) NOT NULL,
    anneeSortie NUMBER NOT NULL,
    langueOG VARCHAR2(50) NOT NULL,
    duree NUMBER NOT NULL,
    resume VARCHAR2(50) NOT NULL,
    affiche VARCHAR2(50) NOT NULL,
    PRIMARY KEY (name),
    FOREIGN KEY (idRealisateur) REFERENCES Crew(id)
);

CREATE TABLE FilmPays (
    PRIMARY KEY (film, pays),
    FOREIGN KEY (film) REFERENCES Film(id),
    FOREIGN KEY (pays) REFERENCES Pays(nom)
);

CREATE TABLE Pays (
    nom VARCHAR2(50) NOT NULL,
    PRIMARY KEY (nom)
);

CREATE TABLE FilmGenre (
    PRIMARY KEY (film, genre),
    FOREIGN KEY (film) REFERENCES Film(id),
    FOREIGN KEY (genre) REFERENCES Genre(nom)
);

CREATE TABLE Genre (
    nom VARCHAR2(50) NOT NULL,
    PRIMARY KEY (nom)
);

CREATE TABLE FilmBA (
    PRIMARY KEY (film, BA),
    FOREIGN KEY (film) REFERENCES Film(id),
    FOREIGN KEY (BA) REFERENCES BandeAnnonce(lien)
);

CREATE TABLE BandeAnnonce (
    lien VARCHAR2(500) NOT NULL,
    PRIMARY KEY (lien)
);

CREATE TABLE Crew (
    id NUMBER NOT NULL,
    prenom VARCHAR2(50) NOT NULL,
    nomFamille VARCHAR2(50) NOT NULL,
    dateNaissance DATE NOT NULL,
    photo VARCHAR2(500) NOT NULL,
    bio VARCHAR2(500) NOT NULL,
    lieuNaissance VARCHAR2(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Scenariste (
    PRIMARY KEY (crew, film),
    FOREIGN KEY (film) REFERENCES Film(id),
    FOREIGN KEY (crew) REFERENCES Crew(id)
);

CREATE TABLE Role (
    personnage VARCHAR2(50) NOT NULL,
    PRIMARY KEY (crew, film),
    FOREIGN KEY (film) REFERENCES Film(id),
    FOREIGN KEY (crew) REFERENCES Crew(id)
);


