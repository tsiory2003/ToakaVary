-- Fournisseur
CREATE TABLE Fournisseur (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  telephone VARCHAR(20),
  adresse TEXT,
  CONSTRAINT unique_nom_fournisseur UNIQUE (nom)
);

-- Type de client
CREATE TABLE Type_Client (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL UNIQUE
);

-- Client
CREATE TABLE Client (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  id_type_client INT,
  email VARCHAR(100),
  telephone VARCHAR(20),
  adresse TEXT,
  FOREIGN KEY (id_type_client) REFERENCES Type_Client(id),
  CONSTRAINT unique_nom_client UNIQUE (nom)
);

-- Type de mouvement
CREATE TABLE Type_Mouvement (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL UNIQUE
);

-- Matières premières
CREATE TABLE Matiere_Premiere (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  description TEXT,
  CONSTRAINT unique_nom_matiere UNIQUE (nom)
);

-- Départements
CREATE TABLE Departement (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL UNIQUE,
  description TEXT
);

-- Statut d'employé
CREATE TABLE Statut_Employe (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL UNIQUE
);

-- Employés
CREATE TABLE Employe (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  poste VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  telephone VARCHAR(20),
  id_statut_employe INT DEFAULT 1,
  id_departement INT NOT NULL,
  FOREIGN KEY (id_statut_employe) REFERENCES Statut_Employe(id),
  FOREIGN KEY (id_departement) REFERENCES Departement(id),
  CONSTRAINT unique_nom_employe UNIQUE (nom)
);
-- Table pour l'authentification des utilisateurs
CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_employe INT NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    pswd VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_employe) REFERENCES Employe(id),
    CONSTRAINT check_username_length CHECK (LENGTH(username) >= 3)
);
-- Détails des mouvements de stock des matières premières
CREATE TABLE Detail_Mouvement_Stock_Matiere_Premiere (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_fournisseur INT NULL,
  id_employe INT NULL,
  id_lot INT NULL,
  date_reception DATE,
  date_expiration DATE,
  commentaire TEXT,
  FOREIGN KEY (id_fournisseur) REFERENCES Fournisseur(id),
  FOREIGN KEY (id_employe) REFERENCES Employe(id),
  FOREIGN KEY (id_lot) REFERENCES Lot_Production(id)
);

-- Mouvements de stock des matières premières
CREATE TABLE Mouvement_Stock_Matiere_Premiere (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_matiere INT NOT NULL,
  id_type_mouvement INT NOT NULL,
  id_detail_mouvement INT NOT NULL,
  quantite DECIMAL(10,2) NOT NULL,
  date_mouvement DATETIME NOT NULL,
  FOREIGN KEY (id_matiere) REFERENCES Matiere_Premiere(id),
  FOREIGN KEY (id_type_mouvement) REFERENCES Type_Mouvement(id),
  FOREIGN KEY (id_detail_mouvement) REFERENCES Detail_Mouvement_Stock_Matiere_Premiere(id),
  CONSTRAINT check_quantite_positive CHECK (quantite > 0)
);


-- Type de matériel
CREATE TABLE Type_Materiel (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL UNIQUE
);

-- Matériel
CREATE TABLE Materiel (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(50) NOT NULL,
  id_type_materiel INT NOT NULL,
  capacite DECIMAL(10,2),
  description TEXT,
  FOREIGN KEY (id_type_materiel) REFERENCES Type_Materiel(id),
  CONSTRAINT unique_code_materiel UNIQUE (code)
);

-- Type de bouteille
CREATE TABLE Type_Bouteille (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL,
  capacite DECIMAL(10,2) NOT NULL,
  CONSTRAINT unique_nom_bouteille UNIQUE (nom),
  CONSTRAINT check_capacite_positive CHECK (capacite > 0)
);

-- Statut de lot
CREATE TABLE Statut_Lot (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL UNIQUE
);

-- Lots de production
CREATE TABLE Lot_Production (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_gamme INT NOT NULL, -- anciennement id_recette
  id_bouteille INT NOT NULL,
  date_debut DATE NOT NULL,
  date_mise_en_bouteille DATE,
  date_commercialisation DATE,
  nombre_bouteilles INT,
  -- id_statut_lot INT DEFAULT 1,
  FOREIGN KEY (id_gamme) REFERENCES Gamme(id), -- anciennement Recette(id)
  -- FOREIGN KEY (id_statut_lot) REFERENCES Statut_Lot(id),
  FOREIGN KEY (id_bouteille) REFERENCES Type_Bouteille(id)
  
);

-- Détails des lots de production
CREATE TABLE Detail_Lot_Production (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_lot INT NOT NULL,
  id_employe INT NULL,
  date_enregistrement DATETIME NOT NULL,
  parametres_production TEXT,
  remarques TEXT,
  FOREIGN KEY (id_lot) REFERENCES Lot_Production(id),
  FOREIGN KEY (id_employe) REFERENCES Employe(id)
);

-- Détails des mouvements de stock des produits finis
CREATE TABLE Detail_Mouvement_Produits (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_employe INT NULL,
  id_lot INT NOT NULL,
  emplacement VARCHAR(100),
  commentaire TEXT,
  FOREIGN KEY (id_employe) REFERENCES Employe(id),
  FOREIGN KEY (id_lot) REFERENCES Lot_Production(id)
);

-- Mouvements de stock des produits finis
CREATE TABLE Mouvement_Produits (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_lot INT NOT NULL,
  id_detail_mouvement INT NOT NULL,
  quantite_bouteilles INT NOT NULL,
  date_mouvement DATETIME NOT NULL,
  stock_actuel INT DEFAULT 0,
  seuil_minimum INT DEFAULT 0,
  date_mise_a_jour DATE,
  FOREIGN KEY (id_lot) REFERENCES Lot_Production(id),
  FOREIGN KEY (id_detail_mouvement) REFERENCES Detail_Mouvement_Produits(id),
  CONSTRAINT check_quantite_bouteilles_positive CHECK (quantite_bouteilles > 0),
  CONSTRAINT check_stock_bouteilles_non_negatif CHECK (stock_actuel >= 0)
);

-- Contrôle qualité
CREATE TABLE Controle_Qualite (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_lot INT NOT NULL,
  date_controle DATE NOT NULL,
  resultat VARCHAR(100) NOT NULL,
  remarque TEXT,
  id_employe INT,
  FOREIGN KEY (id_lot) REFERENCES Lot_Production(id),
  FOREIGN KEY (id_employe) REFERENCES Employe(id)
);

-- Statut de commande
CREATE TABLE Statut_Commande (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL UNIQUE
);

-- Commandes
CREATE TABLE Commande (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_client INT NOT NULL,
  date_commande DATE NOT NULL,
  date_livraison DATE,
  id_statut_commande INT DEFAULT 1,
  total DECIMAL(10,2) DEFAULT 0,
  FOREIGN KEY (id_client) REFERENCES Client(id),
  FOREIGN KEY (id_statut_commande) REFERENCES Statut_Commande(id),
  CONSTRAINT check_total_non_negatif CHECK (total >= 0)
);

-- Détails de commande
CREATE TABLE Ligne_Commande (
  id_commande INT,
  id_lot INT,
  quantite_bouteilles INT NOT NULL,
  prix_unitaire DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_commande, id_lot),
  FOREIGN KEY (id_commande) REFERENCES Commande(id),
  FOREIGN KEY (id_lot) REFERENCES Lot_Production(id),
  CONSTRAINT check_quantite_bouteilles_cmd_positive CHECK (quantite_bouteilles > 0),
  CONSTRAINT check_prix_unitaire_non_negatif CHECK (prix_unitaire >= 0)
);
-- Table d'association entre Mouvement_Produits et Commande
CREATE TABLE Mouvement_Produits_Commande (
    id_mouvement_produit INT,
    id_commande INT,
    quantite INT NOT NULL,
    date_association DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_mouvement_produit, id_commande),
    FOREIGN KEY (id_mouvement_produit) REFERENCES Mouvement_Produits(id),
    FOREIGN KEY (id_commande) REFERENCES Commande(id),
    CONSTRAINT check_quantite_positive CHECK (quantite > 0)
);
-- Ventes
CREATE TABLE Vente (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_commande INT NOT NULL,
  date_vente DATE NOT NULL,
  montant DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_commande) REFERENCES Commande(id),
  CONSTRAINT check_montant_positive CHECK (montant >= 0)
);

-- Gammes (anciennement Recettes)
CREATE TABLE Gamme (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  description TEXT,
  fermentation_jours INT NOT NULL,
  vieillissement_jours INT NOT NULL,
  CONSTRAINT unique_nom_gamme UNIQUE (nom)
);

-- Gamme - Matière première (N:N) (anciennement Recette_Matiere)
CREATE TABLE Gamme_Matiere (
  id_gamme INT,
  id_matiere INT,
  quantite DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_gamme, id_matiere),
  FOREIGN KEY (id_gamme) REFERENCES Gamme(id),
  FOREIGN KEY (id_matiere) REFERENCES Matiere_Premiere(id),
  CONSTRAINT check_quantite_matiere_positive CHECK (quantite > 0)
);
