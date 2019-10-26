
CREATE TYPE Type_de_contrat AS ENUM ('Administration', 'Livraison', 'Pizzaiolo', 'Technicien');
CREATE TYPE Statut AS ENUM ('Pas encore préparé', 'En préparation', 'A venir chercher', 'Encours de livraison','Cloturée', 'Annulée');
CREATE TYPE Taille AS ENUM ('Mini', 'Normale', 'Maxi');
CREATE TYPE EntreeOuSortie AS ENUM ('Entrée', 'Sortie');





CREATE TABLE public.fournisseur (
                id_fournisseur INTEGER NOT NULL,
                name VARCHAR NOT NULL,
                adresse_mail VARCHAR NOT NULL,
                num_tel VARCHAR NOT NULL,
                adresse VARCHAR NOT NULL,
                type_fourniture VARCHAR NOT NULL,
                CONSTRAINT fournisseur_pk PRIMARY KEY (id_fournisseur)
);


CREATE TABLE public.ingredient_fournisseur (
                id_ingredient_four INTEGER NOT NULL,
                name VARCHAR NOT NULL,
                prix_achat REAL NOT NULL,
                id_fournisseur INTEGER NOT NULL,
                CONSTRAINT ingredient_fournisseur_pk PRIMARY KEY (id_ingredient_four)
);


CREATE TABLE public.pizza (
                id_pizza INTEGER NOT NULL,
                name VARCHAR NOT NULL,
                prix INTEGER NOT NULL,
                recette VARCHAR NOT NULL,
                temps_preparation TIME NOT NULL,
                taille Taille NOT NULL,
                disponible BOOLEAN NOT NULL,
                CONSTRAINT pizza_pk PRIMARY KEY (id_pizza)
);


CREATE SEQUENCE public.client_id_client_seq;

CREATE TABLE public.client (
                id_client INTEGER NOT NULL DEFAULT nextval('public.client_id_client_seq'),
                name VARCHAR NOT NULL,
                adresse VARCHAR NOT NULL,
                numTelephone VARCHAR NOT NULL,
                age INTEGER NOT NULL,
                mot_de_passe VARCHAR NOT NULL,
                adresse_mail VARCHAR NOT NULL,
                CONSTRAINT client_pk PRIMARY KEY (id_client)
);


ALTER SEQUENCE public.client_id_client_seq OWNED BY public.client.id_client;

CREATE SEQUENCE public.pizzeria_id_pizzeria_seq;

CREATE TABLE public.pizzeria (
                id_pizzeria INTEGER NOT NULL DEFAULT nextval('public.pizzeria_id_pizzeria_seq'),
                name VARCHAR NOT NULL,
                adresse VARCHAR NOT NULL,
                numTel VARCHAR NOT NULL,
                horaire_ouv TIME NOT NULL,
                horaire_fer TIME NOT NULL,
                distance_max INTEGER NOT NULL,
                CONSTRAINT pizzeria_pk PRIMARY KEY (id_pizzeria)
);


ALTER SEQUENCE public.pizzeria_id_pizzeria_seq OWNED BY public.pizzeria.id_pizzeria;

CREATE SEQUENCE public.commande_id_commande_seq;

CREATE TABLE public.commande (
                id_commande INTEGER NOT NULL DEFAULT nextval('public.commande_id_commande_seq'),
                prix INTEGER NOT NULL,
                date_commande TIMESTAMP NOT NULL,
                doit_etre_livre BOOLEAN NOT NULL,
                deja_paye BOOLEAN NOT NULL,
                statut Statut NOT NULL,
                adresse_livraison VARCHAR,
                temps_preparation TIME NOT NULL,
                id_client INTEGER NOT NULL,
                id_pizzeria INTEGER NOT NULL,
                CONSTRAINT commande_pk PRIMARY KEY (id_commande)
);


ALTER SEQUENCE public.commande_id_commande_seq OWNED BY public.commande.id_commande;

CREATE SEQUENCE public.commentaire_id_commentaire_seq;

CREATE TABLE public.commentaire (
                id_commentaire INTEGER NOT NULL DEFAULT nextval('public.commentaire_id_commentaire_seq'),
                description VARCHAR NOT NULL,
                note INTEGER NOT NULL,
                id_client INTEGER NOT NULL,
                id_commande INTEGER NOT NULL,
                CONSTRAINT commentaire_pk PRIMARY KEY (id_commentaire)
);


ALTER SEQUENCE public.commentaire_id_commentaire_seq OWNED BY public.commentaire.id_commentaire;

CREATE TABLE public.pizzas_de_la_commande (
                id_commande INTEGER NOT NULL,
                id_pizza INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT pizzas_de_la_commande_pk PRIMARY KEY (id_commande, id_pizza)
);


CREATE TABLE public.stock_global (
                id_stock_global INTEGER NOT NULL,
                name VARCHAR NOT NULL,
                quantite_restante INTEGER NOT NULL,
                id_pizzeria INTEGER NOT NULL,
                CONSTRAINT stock_global_pk PRIMARY KEY (id_stock_global)
);


CREATE TABLE public.mouvement_stock (
                id_mvt INTEGER NOT NULL,
                date TIMESTAMP NOT NULL,
                date_peremption TIMESTAMP NOT NULL,
                type_fourniture VARCHAR NOT NULL,
                entre_ou_sortie EntreeOuSortie NOT NULL,
                id_ingredient_four INTEGER NOT NULL,
                id_stock_global INTEGER NOT NULL,
                CONSTRAINT mouvement_stock_pk PRIMARY KEY (id_mvt)
);


CREATE SEQUENCE public.ingredient_pizzeria_id_ingr_pizz_seq;

CREATE TABLE public.ingredient_pizzeria (
                id_ingr_pizz INTEGER NOT NULL DEFAULT nextval('public.ingredient_pizzeria_id_ingr_pizz_seq'),
                name VARCHAR NOT NULL,
                quantite_restante VARCHAR NOT NULL,
                id_mvt INTEGER NOT NULL,
                CONSTRAINT ingredient_pizzeria_pk PRIMARY KEY (id_ingr_pizz)
);


ALTER SEQUENCE public.ingredient_pizzeria_id_ingr_pizz_seq OWNED BY public.ingredient_pizzeria.id_ingr_pizz;

CREATE TABLE public.ingredients_de_la_pizza (
                id_pizza INTEGER NOT NULL,
                id_ingr_pizz INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT ingredients_de_la_pizza_pk PRIMARY KEY (id_pizza, id_ingr_pizz)
);


CREATE SEQUENCE public.employ__id_employe_seq;

CREATE TABLE public.employé (
                id_employe INTEGER NOT NULL DEFAULT nextval('public.employ__id_employe_seq'),
                name VARCHAR NOT NULL,
                num_tel VARCHAR NOT NULL,
                mot_de_passe VARCHAR NOT NULL,
                adresse_mail VARCHAR NOT NULL,
                salaire REAL NOT NULL,
                adresse VARCHAR NOT NULL,
                horaire TIME NOT NULL,
                type_de_contrat Type_de_contrat NOT NULL,
                debut_contrat TIMESTAMP NOT NULL,
                fin_contrat TIMESTAMP NOT NULL,
                id_pizzeria INTEGER NOT NULL,
                CONSTRAINT employ__pk PRIMARY KEY (id_employe)
);


ALTER SEQUENCE public.employ__id_employe_seq OWNED BY public.employé.id_employe;

CREATE TABLE public.en_charge_des_commandes (
                id_employe INTEGER NOT NULL,
                id_commande INTEGER NOT NULL,
                CONSTRAINT en_charge_des_commandes_pk PRIMARY KEY (id_employe, id_commande)
);


ALTER TABLE public.ingredient_fournisseur ADD CONSTRAINT fournisseur_ingredient_fournisseur_fk
FOREIGN KEY (id_fournisseur)
REFERENCES public.fournisseur (id_fournisseur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.mouvement_stock ADD CONSTRAINT ingredient_fournisseur_mouvement_stock_fk
FOREIGN KEY (id_ingredient_four)
REFERENCES public.ingredient_fournisseur (id_ingredient_four)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pizzas_de_la_commande ADD CONSTRAINT pizza_pizzas_de_la_commande_fk
FOREIGN KEY (id_pizza)
REFERENCES public.pizza (id_pizza)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ingredients_de_la_pizza ADD CONSTRAINT pizza_ingredients_de_la_pizza_fk
FOREIGN KEY (id_pizza)
REFERENCES public.pizza (id_pizza)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commentaire ADD CONSTRAINT client_commentaire_fk
FOREIGN KEY (id_client)
REFERENCES public.client (id_client)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT client_commande_fk
FOREIGN KEY (id_client)
REFERENCES public.client (id_client)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.employé ADD CONSTRAINT pizzeria_employ__fk
FOREIGN KEY (id_pizzeria)
REFERENCES public.pizzeria (id_pizzeria)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.stock_global ADD CONSTRAINT pizzeria_stock_global_fk
FOREIGN KEY (id_pizzeria)
REFERENCES public.pizzeria (id_pizzeria)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT pizzeria_commande_fk
FOREIGN KEY (id_pizzeria)
REFERENCES public.pizzeria (id_pizzeria)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.en_charge_des_commandes ADD CONSTRAINT commande_en_charge_des_commandes_fk
FOREIGN KEY (id_commande)
REFERENCES public.commande (id_commande)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pizzas_de_la_commande ADD CONSTRAINT commande_pizzas_de_la_commande_fk
FOREIGN KEY (id_commande)
REFERENCES public.commande (id_commande)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commentaire ADD CONSTRAINT commande_commentaire_fk
FOREIGN KEY (id_commande)
REFERENCES public.commande (id_commande)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.mouvement_stock ADD CONSTRAINT stock_global_mouvement_stock_fk
FOREIGN KEY (id_stock_global)
REFERENCES public.stock_global (id_stock_global)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ingredient_pizzeria ADD CONSTRAINT mouvement_stock_ingredient_pizzeria_fk
FOREIGN KEY (id_mvt)
REFERENCES public.mouvement_stock (id_mvt)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ingredients_de_la_pizza ADD CONSTRAINT ingredient_pizzeria_ingredients_de_la_pizza_fk
FOREIGN KEY (id_ingr_pizz)
REFERENCES public.ingredient_pizzeria (id_ingr_pizz)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.en_charge_des_commandes ADD CONSTRAINT employ__en_charge_des_commandes_fk
FOREIGN KEY (id_employe)
REFERENCES public.employé (id_employe)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
