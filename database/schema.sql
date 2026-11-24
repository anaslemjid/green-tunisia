
-- ==========================================
-- PROJET GREEN TUNISIA
-- Base de donnees commune - Groupe de 5
-- ==========================================

CREATE DATABASE IF NOT EXISTS green_tunisia
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE green_tunisia;

-- ==========================================
-- ETUDIANT 1 : ARTICLES ET CATEGORIES
-- ==========================================

CREATE TABLE Categorie (
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    description TEXT
) ENGINE=InnoDB;

CREATE TABLE Article (
    id_article INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    contenu TEXT NOT NULL,
    date_publication DATETIME DEFAULT CURRENT_TIMESTAMP,
    image VARCHAR(255),
    id_categorie INT NOT NULL,

    CONSTRAINT fk_article_categorie
    FOREIGN KEY (id_categorie)
    REFERENCES Categorie(id_categorie)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;


-- ==========================================
-- ETUDIANT 2 : CAMPAGNES
-- ==========================================

CREATE TABLE Campagne (
    id_campagne INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    description TEXT,
    date DATE NOT NULL,
    lieu VARCHAR(255),
    objectif VARCHAR(255)
) ENGINE=InnoDB;


-- ==========================================
-- ETUDIANT 3 : BENEVOLES
-- ==========================================

CREATE TABLE Benevole (
    id_benevole INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    telephone VARCHAR(20)
) ENGINE=InnoDB;


-- ==========================================
-- ETUDIANTS 2 ET 3 : PARTICIPATIONS
-- Table partagee entre les deux modules
-- ==========================================

CREATE TABLE Participation (
    id_participation INT AUTO_INCREMENT PRIMARY KEY,
    id_campagne INT NOT NULL,
    id_benevole INT NOT NULL,
    date_inscription DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_participation_campagne
    FOREIGN KEY (id_campagne)
    REFERENCES Campagne(id_campagne)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    CONSTRAINT fk_participation_benevole
    FOREIGN KEY (id_benevole)
    REFERENCES Benevole(id_benevole)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    UNIQUE (id_campagne, id_benevole)
) ENGINE=InnoDB;


-- ==========================================
-- ETUDIANT 4 : DONS ET PARTENARIATS
-- ==========================================

CREATE TABLE Donateur (
    id_donateur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    telephone VARCHAR(20)
) ENGINE=InnoDB;

CREATE TABLE `Don` (
    id_don INT AUTO_INCREMENT PRIMARY KEY,
    montant DECIMAL(10,2) NOT NULL,
    date_don DATE NOT NULL,
    type_don VARCHAR(100),
    id_donateur INT NOT NULL,

    CONSTRAINT fk_don_donateur
    FOREIGN KEY (id_donateur)
    REFERENCES Donateur(id_donateur)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE Partenaire (
    id_partenaire INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    telephone VARCHAR(20)
) ENGINE=InnoDB;

CREATE TABLE Convention (
    id_convention INT AUTO_INCREMENT PRIMARY KEY,
    date_debut DATE NOT NULL,
    date_fin DATE,
    description TEXT,
    id_partenaire INT NOT NULL,

    CONSTRAINT fk_convention_partenaire
    FOREIGN KEY (id_partenaire)
    REFERENCES Partenaire(id_partenaire)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;


-- ==========================================
-- ETUDIANT 5 : ADMINISTRATION ET STATISTIQUES
-- ==========================================

CREATE TABLE Role (
    id_role INT AUTO_INCREMENT PRIMARY KEY,
    nom_role VARCHAR(100) NOT NULL,
    description TEXT
) ENGINE=InnoDB;

CREATE TABLE Utilisateur (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL,
    id_role INT NOT NULL,

    CONSTRAINT fk_utilisateur_role
    FOREIGN KEY (id_role)
    REFERENCES Role(id_role)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE Activite (
    id_activite INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(255) NOT NULL,
    date_action DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_user INT NOT NULL,

    CONSTRAINT fk_activite_utilisateur
    FOREIGN KEY (id_user)
    REFERENCES Utilisateur(id_user)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;


-- ==========================================
-- FIN DU SCHEMA GREEN TUNISIA
-- ==========================================
