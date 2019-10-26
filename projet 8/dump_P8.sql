--
-- PostgreSQL database dump
--

-- Dumped from database version 11.3
-- Dumped by pg_dump version 11.3

-- Started on 2019-08-14 11:13:03 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE db_p8_2;
--
-- TOC entry 3283 (class 1262 OID 24790)
-- Name: db_p8_2; Type: DATABASE; Schema: -; Owner: adm_p8_2
--

CREATE DATABASE db_p8_2 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE db_p8_2 OWNER TO adm_p8_2;

\connect db_p8_2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 617 (class 1247 OID 24824)
-- Name: entreeousortie; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.entreeousortie AS ENUM (
    'Entrée',
    'Sortie'
);


ALTER TYPE public.entreeousortie OWNER TO postgres;

--
-- TOC entry 611 (class 1247 OID 24802)
-- Name: statut; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.statut AS ENUM (
    'Pas encore préparé',
    'En préparation',
    'A venir chercher',
    'Encours de livraison',
    'Cloturée',
    'Annulée'
);


ALTER TYPE public.statut OWNER TO postgres;

--
-- TOC entry 614 (class 1247 OID 24816)
-- Name: taille; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.taille AS ENUM (
    'Mini',
    'Normale',
    'Maxi'
);


ALTER TYPE public.taille OWNER TO postgres;

--
-- TOC entry 608 (class 1247 OID 24792)
-- Name: type_de_contrat; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.type_de_contrat AS ENUM (
    'Administration',
    'Livraison',
    'Pizzaiolo',
    'Technicien'
);


ALTER TYPE public.type_de_contrat OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 200 (class 1259 OID 24855)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id_client integer NOT NULL,
    name character varying NOT NULL,
    adresse character varying NOT NULL,
    numtelephone character varying NOT NULL,
    age integer NOT NULL,
    mot_de_passe character varying NOT NULL,
    adresse_mail character varying NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 24853)
-- Name: client_id_client_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_id_client_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.client_id_client_seq OWNER TO postgres;

--
-- TOC entry 3284 (class 0 OID 0)
-- Dependencies: 199
-- Name: client_id_client_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_id_client_seq OWNED BY public.client.id_client;


--
-- TOC entry 204 (class 1259 OID 24877)
-- Name: commande; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commande (
    id_commande integer NOT NULL,
    prix integer NOT NULL,
    date_commande timestamp without time zone NOT NULL,
    doit_etre_livre boolean NOT NULL,
    deja_paye boolean NOT NULL,
    statut public.statut NOT NULL,
    adresse_livraison character varying,
    temps_preparation time without time zone NOT NULL,
    id_client integer NOT NULL,
    id_pizzeria integer NOT NULL
);


ALTER TABLE public.commande OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 24875)
-- Name: commande_id_commande_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commande_id_commande_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commande_id_commande_seq OWNER TO postgres;

--
-- TOC entry 3285 (class 0 OID 0)
-- Dependencies: 203
-- Name: commande_id_commande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commande_id_commande_seq OWNED BY public.commande.id_commande;


--
-- TOC entry 206 (class 1259 OID 24888)
-- Name: commentaire; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commentaire (
    id_commentaire integer NOT NULL,
    description character varying NOT NULL,
    note integer NOT NULL,
    id_client integer NOT NULL,
    id_commande integer NOT NULL
);


ALTER TABLE public.commentaire OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 24886)
-- Name: commentaire_id_commentaire_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commentaire_id_commentaire_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commentaire_id_commentaire_seq OWNER TO postgres;

--
-- TOC entry 3286 (class 0 OID 0)
-- Dependencies: 205
-- Name: commentaire_id_commentaire_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commentaire_id_commentaire_seq OWNED BY public.commentaire.id_commentaire;


--
-- TOC entry 214 (class 1259 OID 24936)
-- Name: employé; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."employé" (
    id_employe integer NOT NULL,
    name character varying NOT NULL,
    num_tel character varying NOT NULL,
    mot_de_passe character varying NOT NULL,
    adresse_mail character varying NOT NULL,
    salaire real NOT NULL,
    adresse character varying NOT NULL,
    horaire time without time zone NOT NULL,
    type_de_contrat public.type_de_contrat NOT NULL,
    debut_contrat timestamp without time zone NOT NULL,
    fin_contrat timestamp without time zone NOT NULL,
    id_pizzeria integer NOT NULL
);


ALTER TABLE public."employé" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 24934)
-- Name: employ__id_employe_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employ__id_employe_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employ__id_employe_seq OWNER TO postgres;

--
-- TOC entry 3287 (class 0 OID 0)
-- Dependencies: 213
-- Name: employ__id_employe_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employ__id_employe_seq OWNED BY public."employé".id_employe;


--
-- TOC entry 215 (class 1259 OID 24945)
-- Name: en_charge_des_commandes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.en_charge_des_commandes (
    id_employe integer NOT NULL,
    id_commande integer NOT NULL
);


ALTER TABLE public.en_charge_des_commandes OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 24829)
-- Name: fournisseur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fournisseur (
    id_fournisseur integer NOT NULL,
    name character varying NOT NULL,
    adresse_mail character varying NOT NULL,
    num_tel character varying NOT NULL,
    adresse character varying NOT NULL,
    type_fourniture character varying NOT NULL
);


ALTER TABLE public.fournisseur OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 24837)
-- Name: ingredient_fournisseur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredient_fournisseur (
    id_ingredient_four integer NOT NULL,
    name character varying NOT NULL,
    prix_achat real NOT NULL,
    id_fournisseur integer NOT NULL
);


ALTER TABLE public.ingredient_fournisseur OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 24920)
-- Name: ingredient_pizzeria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredient_pizzeria (
    id_ingr_pizz integer NOT NULL,
    name character varying NOT NULL,
    quantite_restante character varying NOT NULL,
    id_mvt integer NOT NULL
);


ALTER TABLE public.ingredient_pizzeria OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 24918)
-- Name: ingredient_pizzeria_id_ingr_pizz_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ingredient_pizzeria_id_ingr_pizz_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ingredient_pizzeria_id_ingr_pizz_seq OWNER TO postgres;

--
-- TOC entry 3288 (class 0 OID 0)
-- Dependencies: 210
-- Name: ingredient_pizzeria_id_ingr_pizz_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ingredient_pizzeria_id_ingr_pizz_seq OWNED BY public.ingredient_pizzeria.id_ingr_pizz;


--
-- TOC entry 212 (class 1259 OID 24929)
-- Name: ingredients_de_la_pizza; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredients_de_la_pizza (
    id_pizza integer NOT NULL,
    id_ingr_pizz integer NOT NULL,
    quantite integer NOT NULL
);


ALTER TABLE public.ingredients_de_la_pizza OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 24910)
-- Name: mouvement_stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mouvement_stock (
    id_mvt integer NOT NULL,
    date timestamp without time zone NOT NULL,
    date_peremption timestamp without time zone NOT NULL,
    type_fourniture character varying NOT NULL,
    entre_ou_sortie public.entreeousortie NOT NULL,
    id_ingredient_four integer NOT NULL,
    id_stock_global integer NOT NULL
);


ALTER TABLE public.mouvement_stock OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 24845)
-- Name: pizza; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pizza (
    id_pizza integer NOT NULL,
    name character varying NOT NULL,
    prix integer NOT NULL,
    recette character varying NOT NULL,
    temps_preparation time without time zone NOT NULL,
    taille public.taille NOT NULL,
    disponible boolean NOT NULL
);


ALTER TABLE public.pizza OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 24897)
-- Name: pizzas_de_la_commande; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pizzas_de_la_commande (
    id_commande integer NOT NULL,
    id_pizza integer NOT NULL,
    quantite integer NOT NULL
);


ALTER TABLE public.pizzas_de_la_commande OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 24866)
-- Name: pizzeria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pizzeria (
    id_pizzeria integer NOT NULL,
    name character varying NOT NULL,
    adresse character varying NOT NULL,
    numtel character varying NOT NULL,
    horaire_ouv time without time zone NOT NULL,
    horaire_fer time without time zone NOT NULL,
    distance_max integer NOT NULL
);


ALTER TABLE public.pizzeria OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 24864)
-- Name: pizzeria_id_pizzeria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pizzeria_id_pizzeria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pizzeria_id_pizzeria_seq OWNER TO postgres;

--
-- TOC entry 3289 (class 0 OID 0)
-- Dependencies: 201
-- Name: pizzeria_id_pizzeria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pizzeria_id_pizzeria_seq OWNED BY public.pizzeria.id_pizzeria;


--
-- TOC entry 208 (class 1259 OID 24902)
-- Name: stock_global; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_global (
    id_stock_global integer NOT NULL,
    name character varying NOT NULL,
    quantite_restante integer NOT NULL,
    id_pizzeria integer NOT NULL
);


ALTER TABLE public.stock_global OWNER TO postgres;

--
-- TOC entry 3087 (class 2604 OID 24858)
-- Name: client id_client; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN id_client SET DEFAULT nextval('public.client_id_client_seq'::regclass);


--
-- TOC entry 3089 (class 2604 OID 24880)
-- Name: commande id_commande; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande ALTER COLUMN id_commande SET DEFAULT nextval('public.commande_id_commande_seq'::regclass);


--
-- TOC entry 3090 (class 2604 OID 24891)
-- Name: commentaire id_commentaire; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commentaire ALTER COLUMN id_commentaire SET DEFAULT nextval('public.commentaire_id_commentaire_seq'::regclass);


--
-- TOC entry 3092 (class 2604 OID 24939)
-- Name: employé id_employe; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."employé" ALTER COLUMN id_employe SET DEFAULT nextval('public.employ__id_employe_seq'::regclass);


--
-- TOC entry 3091 (class 2604 OID 24923)
-- Name: ingredient_pizzeria id_ingr_pizz; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient_pizzeria ALTER COLUMN id_ingr_pizz SET DEFAULT nextval('public.ingredient_pizzeria_id_ingr_pizz_seq'::regclass);


--
-- TOC entry 3088 (class 2604 OID 24869)
-- Name: pizzeria id_pizzeria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizzeria ALTER COLUMN id_pizzeria SET DEFAULT nextval('public.pizzeria_id_pizzeria_seq'::regclass);


--
-- TOC entry 3262 (class 0 OID 24855)
-- Dependencies: 200
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client (id_client, name, adresse, numtelephone, age, mot_de_passe, adresse_mail) VALUES (1, 'Anne PAULIANOV', '8 rue de la guimauve, Lille', '06 54 67 12 09', 29, 'Qxk22+CT.7y', 'anne.pol@outlook.fr');
INSERT INTO public.client (id_client, name, adresse, numtelephone, age, mot_de_passe, adresse_mail) VALUES (2, 'Yassim YAOUL', '34 allée Zola, Croix', '06 89 42 67 88', 18, '3Nv3g3USz**', 'yassim@hotmail.com');
INSERT INTO public.client (id_client, name, adresse, numtelephone, age, mot_de_passe, adresse_mail) VALUES (3, 'John BLANDIN', '67 chemin de la bleutée, Valenciennes', '07 42 12 67 33', 32, '8d}L96µgNXq', 'mesjeuxenligne@hotmail.com');
INSERT INTO public.client (id_client, name, adresse, numtelephone, age, mot_de_passe, adresse_mail) VALUES (4, 'Amandine BELLINE', '310 rue du petit pont, Villeneuve dascq', '06 34 57 12 03', 81, '=Yu4/48iSVx', 'amand@gmail.com');
INSERT INTO public.client (id_client, name, adresse, numtelephone, age, mot_de_passe, adresse_mail) VALUES (5, 'Victoire RIVO', '89 rue abée Pierre, Lille', '06 67 99 23 13', 24, '37#T[iucY9P', 'rivo.perso@laposte.net');


--
-- TOC entry 3266 (class 0 OID 24877)
-- Dependencies: 204
-- Data for Name: commande; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.commande (id_commande, prix, date_commande, doit_etre_livre, deja_paye, statut, adresse_livraison, temps_preparation, id_client, id_pizzeria) VALUES (1, 12, '2019-10-08 00:00:00', true, false, 'Cloturée', '67 chemin de la bleutée, Valenciennes', '00:12:00', 3, 1);
INSERT INTO public.commande (id_commande, prix, date_commande, doit_etre_livre, deja_paye, statut, adresse_livraison, temps_preparation, id_client, id_pizzeria) VALUES (2, 32, '2019-10-09 00:00:00', true, true, 'Cloturée', '8 rue de la guimauve, Lille', '00:35:00', 1, 1);
INSERT INTO public.commande (id_commande, prix, date_commande, doit_etre_livre, deja_paye, statut, adresse_livraison, temps_preparation, id_client, id_pizzeria) VALUES (3, 15, '2019-10-09 00:00:00', false, false, 'A venir chercher', '34 allée Zola, Croix', '00:17:00', 2, 2);
INSERT INTO public.commande (id_commande, prix, date_commande, doit_etre_livre, deja_paye, statut, adresse_livraison, temps_preparation, id_client, id_pizzeria) VALUES (4, 32, '2019-10-11 00:00:00', true, false, 'Encours de livraison', '34 allée Zola, Croix', '00:32:00', 2, 3);
INSERT INTO public.commande (id_commande, prix, date_commande, doit_etre_livre, deja_paye, statut, adresse_livraison, temps_preparation, id_client, id_pizzeria) VALUES (5, 10, '2019-10-12 00:00:00', false, true, 'A venir chercher', '310 rue du petit pont, Villeneuve dascq', '00:10:00', 4, 4);
INSERT INTO public.commande (id_commande, prix, date_commande, doit_etre_livre, deja_paye, statut, adresse_livraison, temps_preparation, id_client, id_pizzeria) VALUES (6, 59, '2019-10-12 00:00:00', true, false, 'Encours de livraison', '89 rue abée Pierre, Lille', '01:01:00', 5, 4);
INSERT INTO public.commande (id_commande, prix, date_commande, doit_etre_livre, deja_paye, statut, adresse_livraison, temps_preparation, id_client, id_pizzeria) VALUES (7, 20, '2019-10-12 00:00:00', true, false, 'Annulée', '34 allée Zola, Croix', '00:20:00', 2, 4);
INSERT INTO public.commande (id_commande, prix, date_commande, doit_etre_livre, deja_paye, statut, adresse_livraison, temps_preparation, id_client, id_pizzeria) VALUES (8, 42, '2019-10-13 00:00:00', false, false, 'En préparation', '8 rue de la guimauve, Lille', '00:42:00', 1, 5);
INSERT INTO public.commande (id_commande, prix, date_commande, doit_etre_livre, deja_paye, statut, adresse_livraison, temps_preparation, id_client, id_pizzeria) VALUES (9, 27, '2019-10-15 00:00:00', true, false, 'Pas encore préparé', '67 chemin de la bleutée, Valenciennes', '00:27:00', 3, 5);


--
-- TOC entry 3268 (class 0 OID 24888)
-- Dependencies: 206
-- Data for Name: commentaire; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.commentaire (id_commentaire, description, note, id_client, id_commande) VALUES (1, 'très bonnes pizza', 18, 3, 1);
INSERT INTO public.commentaire (id_commentaire, description, note, id_client, id_commande) VALUES (2, 'hummm bonne pâte croustillante à recommander !', 19, 1, 2);
INSERT INTO public.commentaire (id_commentaire, description, note, id_client, id_commande) VALUES (3, 'pas assez de garnitures à mon gout', 13, 2, 3);
INSERT INTO public.commentaire (id_commentaire, description, note, id_client, id_commande) VALUES (4, 'bonne découverte', 16, 2, 4);
INSERT INTO public.commentaire (id_commentaire, description, note, id_client, id_commande) VALUES (5, 'plusieurs problème technique au niveau de lapplication recontactez moi pour plus de détails', 5, 4, 5);
INSERT INTO public.commentaire (id_commentaire, description, note, id_client, id_commande) VALUES (6, 'temps dattente un peu long', 11, 5, 6);
INSERT INTO public.commentaire (id_commentaire, description, note, id_client, id_commande) VALUES (7, 'tout était PARFAIT', 20, 2, 7);
INSERT INTO public.commentaire (id_commentaire, description, note, id_client, id_commande) VALUES (8, 'très bon mais personnel peu aimable', 14, 1, 8);
INSERT INTO public.commentaire (id_commentaire, description, note, id_client, id_commande) VALUES (9, 'jai adoré', 18, 3, 9);


--
-- TOC entry 3276 (class 0 OID 24936)
-- Dependencies: 214
-- Data for Name: employé; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (1, 'Jean ROUGI', '07 56 32 54 34', 'JeSuisUnMDP28!', 'jean.rougi@ocpizza.fr', 1230, '23 rue du chateau, Villeneuve dascq', '08:00:00', 'Livraison', '2018-09-15 00:00:00', '2020-01-01 00:00:00', 1);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (3, 'Laura PAUV', '06 45 32 54 34', 'UUIOisshè8!', 'laura.pauv@ocpizza.fr', 1230, '81 rue pate, Lille', '08:00:00', 'Pizzaiolo', '2018-07-18 00:00:00', '2020-01-01 00:00:00', 1);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (4, 'Chantal MONTALLET', '06 58 32 43 89', 'AsZdZdZDe52é', 'chantal.montallet@ocpizza.fr', 1230, '45 rue de la vermine, WASQUEHAL', '08:00:00', 'Administration', '2018-07-21 00:00:00', '2020-01-01 00:00:00', 1);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (5, 'Josette LAMOGNET', '07 58 27 04 34', 'c1:9R!uJPZCA', 'josette.lamognet@ocpizza.fr', 1230, '201 rue Moliere, Lille', '08:00:00', 'Technicien', '2018-07-30 00:00:00', '2020-01-01 00:00:00', 1);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (6, 'Kevan ALBINTO', '06 56 92 59 56', 'THO6b"4oT{i;', 'kevant.albinto@ocpizza.fr', 1230, '12 allée du sapin, VILLENEUVE DASCQ', '08:00:00', 'Livraison', '2018-07-12 00:00:00', '2020-01-01 00:00:00', 2);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (7, 'Diego ROCHENIE', '07 00 32 02 34', '(eH(8bD%jX:)', 'diego.rochenie@ocpizza.fr', 1230, '88 rue saugrenue, Lille', '08:00:00', 'Pizzaiolo', '2018-07-13 00:00:00', '2020-01-01 00:00:00', 2);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (8, 'Alberic JOUVELON', '06 67 32 45 99', '%O31MIIvgnyP', 'alberic.jouvelon@ocpizza.fr', 1230, '09 rue parc de la vieille, Lille', '08:00:00', 'Administration', '2018-07-18 00:00:00', '2020-01-01 00:00:00', 2);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (9, 'Noë CHAVANNE', '06 56 99 63 94', 'KvbCEJYV]E/[', 'noe.chavanne@ocpizza.fr', 1230, '102 allée Saint-Handrieux, Croix', '08:00:00', 'Technicien', '2018-07-27 00:00:00', '2020-01-01 00:00:00', 2);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (10, 'Marcus LAUMA', '07 52 39 84 97', 'HHcQNT-{!*a/', 'marcus.lauma@ocpizza.fr', 1230, '65 rue Amour, Lille', '08:00:00', 'Livraison', '2018-07-01 00:00:00', '2020-01-01 00:00:00', 3);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (11, 'Raphaël ALI', '06 11 32 52 30', '}3]vu*?B6M(<', 'raphael.ali@ocpizza.fr', 1230, '23 rue Orger, Croix', '08:00:00', 'Pizzaiolo', '2018-07-01 00:00:00', '2020-01-01 00:00:00', 3);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (12, 'Bryan RAVINIE', '06 76 54 12 45', 'WGQ-mRD\x53a', 'bryan.ravinie@ocpizza.fr', 1230, '109 chemin de la poiscaille, Lille', '08:00:00', 'Administration', '2018-07-10 00:00:00', '2020-01-01 00:00:00', 3);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (13, 'Hendrick SAUGRE', '06 87 11 32 56', 'X/k%cJflHp4!', 'hendrick.saugre@ocpizza.fr', 1230, '23 rue petit berger, Wasquehal', '08:00:00', 'Technicien', '2018-07-18 00:00:00', '2020-01-01 00:00:00', 3);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (14, 'Remi GINEMONT', '06 67 98 17 09', 'P#0K<)R]WG_"', 'remi.ginemont@ocpizza.fr', 1230, '32 allée du genévrier, Lille', '08:00:00', 'Livraison', '2018-07-06 00:00:00', '2020-01-01 00:00:00', 4);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (15, 'Melissa NODIEU', '07 53 56 78 12', '3vbC)*\hW;=p', 'melissa.nodieu@ocpizza.fr', 1230, '67 rue feuille de chanvre, Wasquehal', '08:00:00', 'Pizzaiolo', '2018-07-28 00:00:00', '2020-01-01 00:00:00', 4);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (16, 'Erwann PRISH', '07 56 43 12 77', 'VD2?9(>wLl4n', 'erwann.prish@ocpizza.fr', 1230, '23 allée romarin, Lille', '08:00:00', 'Administration', '2018-07-29 00:00:00', '2020-01-01 00:00:00', 4);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (17, 'Agnes POLANNES', '06 98 65 77 66 ', '2T87\~]_GmQV', 'agnes.polannes@ocpizza.fr', 1230, '201 chemin de la chance, Lille', '08:00:00', 'Technicien', '2018-07-30 00:00:00', '2020-01-01 00:00:00', 4);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (18, 'Marcellin PRICK', '06 14 32 67 91', 'E3br:n..>[g>', 'marcellin.prick@ocpizza.fr', 1230, '2 rue Goldstein, Croix', '08:00:00', 'Livraison', '2018-07-05 00:00:00', '2020-01-01 00:00:00', 5);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (19, 'William PADUTOU', '06 78 45 89 54', 'cvD[4Hr[zs.Q', 'william.padutou@ocpizza.fr', 1230, '9 allée du romarin, Lille', '08:00:00', 'Pizzaiolo', '2018-07-11 00:00:00', '2020-01-01 00:00:00', 5);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (20, 'Marielle MILANN', '07 78 98 22 17', 'QJlPwPPuOY/7', 'marielle.milann@ocpizza.fr', 1230, '28 rue Palefrenier, Villeneuve dascq', '08:00:00', 'Administration', '2018-07-23 00:00:00', '2020-01-01 00:00:00', 5);
INSERT INTO public."employé" (id_employe, name, num_tel, mot_de_passe, adresse_mail, salaire, adresse, horaire, type_de_contrat, debut_contrat, fin_contrat, id_pizzeria) VALUES (21, 'Ibrahim EL AMAL', '06 29 48 46 20', ':wxBbMxZL1<i', 'ibrahim.elamal@ocpizza.fr', 1230, '310 rue Goya, Lille', '08:00:00', 'Technicien', '2018-08-12 00:00:00', '2020-01-01 00:00:00', 5);


--
-- TOC entry 3277 (class 0 OID 24945)
-- Dependencies: 215
-- Data for Name: en_charge_des_commandes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (3, 1);
INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (1, 1);
INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (3, 2);
INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (1, 2);
INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (7, 3);
INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (11, 4);
INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (10, 4);
INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (15, 5);
INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (17, 5);
INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (15, 6);
INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (14, 6);
INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (19, 8);
INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (19, 9);
INSERT INTO public.en_charge_des_commandes (id_employe, id_commande) VALUES (18, 9);


--
-- TOC entry 3258 (class 0 OID 24829)
-- Dependencies: 196
-- Data for Name: fournisseur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.fournisseur (id_fournisseur, name, adresse_mail, num_tel, adresse, type_fourniture) VALUES (1, 'La Bonne Pate', 'bonnepate@laposte.net', '06 78 22 46 94', '34 rue de solferino, Lille', 'pâte à pizza');
INSERT INTO public.fournisseur (id_fournisseur, name, adresse_mail, num_tel, adresse, type_fourniture) VALUES (4, 'Le bourreau des appétits', 'lebourreau@hotmail.com', '06 87 31 55 89', '39 allée du luxe, Croix', 'viandes/poissons');
INSERT INTO public.fournisseur (id_fournisseur, name, adresse_mail, num_tel, adresse, type_fourniture) VALUES (2, 'La Joie De Vivre', 'joiedevivre@outlook.fr', '06 67 33 56 67', '12 rue jules guesdes, Villeneuve dascq', 'légumes/épices');
INSERT INTO public.fournisseur (id_fournisseur, name, adresse_mail, num_tel, adresse, type_fourniture) VALUES (3, 'La Sauce Qui Coule', 'saucecoulante@laposte.net', '07 59 34 75 88', '2 allée Rimbaud , Lille', 'sauces');
INSERT INTO public.fournisseur (id_fournisseur, name, adresse_mail, num_tel, adresse, type_fourniture) VALUES (5, 'Le Fromage Frais', 'fromagefrais@laposte.net', '07 50 23 42 67', '3 rue Gorgonzola, Lille', 'frômage');


--
-- TOC entry 3259 (class 0 OID 24837)
-- Dependencies: 197
-- Data for Name: ingredient_fournisseur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (1, 'Pâte à pizza', 0.150000006, 1);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (2, 'Sauce tomate', 0.100000001, 3);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (3, 'Mozzarella', 0.5, 5);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (4, 'Basilic', 0.100000001, 2);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (5, 'Ail', 0.100000001, 2);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (6, 'Origan', 0.100000001, 2);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (7, 'Anchois', 0.5, 4);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (8, 'Jambon cuit', 1, 4);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (9, 'Artichauts', 0.100000001, 2);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (10, 'Champignons de Paris', 0.200000003, 2);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (11, 'Olives Noires', 0.200000003, 2);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (12, 'Huile d’olive', 0.200000003, 2);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (13, 'Gorgonzola', 0.5, 5);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (14, 'Fontina', 0.5, 5);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (15, 'Parmesan', 0.5, 5);
INSERT INTO public.ingredient_fournisseur (id_ingredient_four, name, prix_achat, id_fournisseur) VALUES (16, 'Sauce piquante', 0.100000001, 3);


--
-- TOC entry 3273 (class 0 OID 24920)
-- Dependencies: 211
-- Data for Name: ingredient_pizzeria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (1, 'Pâte à pizza', '20', 81);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (2, 'Sauce tomate', '20', 86);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (3, 'Mozzarella', '20', 91);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (4, 'Basilic', '20', 96);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (5, 'Ail', '20', 101);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (6, 'Origan', '20', 106);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (7, 'Anchois', '20', 111);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (8, 'Jambon cuit', '20', 116);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (9, 'Artichauts', '20', 121);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (10, 'Champignons de Paris', '20', 126);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (11, 'Olives Noires', '20', 131);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (12, 'Huile d’olive', '20', 136);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (13, 'Gorgonzola', '20', 141);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (14, 'Fontina', '20', 146);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (15, 'Parmesan', '20', 151);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (16, 'Sauce piquante', '20', 156);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (17, 'Pâte à pizza', '20', 82);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (18, 'Sauce tomate', '20', 87);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (19, 'Mozzarella', '20', 92);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (20, 'Basilic', '20', 97);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (21, 'Ail', '20', 102);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (22, 'Origan', '20', 107);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (23, 'Anchois', '20', 112);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (24, 'Jambon cuit', '20', 117);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (25, 'Artichauts', '20', 122);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (26, 'Champignons de Paris', '20', 127);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (27, 'Olives Noires', '20', 132);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (28, 'Huile d’olive', '20', 137);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (29, 'Gorgonzola', '20', 142);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (30, 'Fontina', '20', 147);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (31, 'Parmesan', '20', 152);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (32, 'Sauce piquante', '20', 157);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (33, 'Pâte à pizza', '20', 83);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (34, 'Sauce tomate', '20', 88);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (35, 'Mozzarella', '20', 93);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (36, 'Basilic', '20', 98);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (37, 'Ail', '20', 103);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (38, 'Origan', '20', 108);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (39, 'Anchois', '20', 113);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (40, 'Jambon cuit', '20', 118);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (41, 'Artichauts', '20', 123);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (42, 'Champignons de Paris', '20', 128);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (43, 'Olives Noires', '20', 133);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (44, 'Huile d’olive', '20', 138);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (45, 'Gorgonzola', '20', 143);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (46, 'Fontina', '20', 148);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (47, 'Parmesan', '20', 153);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (48, 'Sauce piquante', '20', 158);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (49, 'Pâte à pizza', '20', 84);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (50, 'Sauce tomate', '20', 89);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (51, 'Mozzarella', '20', 94);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (52, 'Basilic', '20', 99);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (53, 'Ail', '20', 104);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (54, 'Origan', '20', 109);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (55, 'Anchois', '20', 114);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (56, 'Jambon cuit', '20', 119);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (57, 'Artichauts', '20', 124);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (58, 'Champignons de Paris', '20', 129);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (59, 'Olives Noires', '20', 134);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (60, 'Huile d’olive', '20', 139);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (61, 'Gorgonzola', '20', 144);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (62, 'Fontina', '20', 149);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (63, 'Parmesan', '20', 154);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (64, 'Sauce piquante', '20', 159);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (65, 'Pâte à pizza', '20', 85);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (66, 'Sauce tomate', '20', 90);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (67, 'Mozzarella', '20', 95);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (68, 'Basilic', '20', 100);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (69, 'Ail', '20', 105);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (70, 'Origan', '20', 110);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (71, 'Anchois', '20', 115);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (72, 'Jambon cuit', '20', 120);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (73, 'Artichauts', '20', 125);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (74, 'Champignons de Paris', '20', 130);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (75, 'Olives Noires', '20', 135);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (76, 'Huile d’olive', '20', 140);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (77, 'Gorgonzola', '20', 145);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (78, 'Fontina', '20', 150);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (79, 'Parmesan', '20', 155);
INSERT INTO public.ingredient_pizzeria (id_ingr_pizz, name, quantite_restante, id_mvt) VALUES (80, 'Sauce piquante', '20', 160);


--
-- TOC entry 3274 (class 0 OID 24929)
-- Dependencies: 212
-- Data for Name: ingredients_de_la_pizza; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (1, 1, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (1, 2, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (1, 3, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (1, 4, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (1, 12, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (2, 1, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (2, 2, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (2, 5, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (2, 6, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (2, 12, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (3, 1, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (3, 2, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (3, 3, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (3, 7, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (3, 12, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (3, 6, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (4, 1, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (4, 3, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (4, 13, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (4, 14, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (4, 15, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (5, 1, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (5, 2, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (5, 3, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (5, 8, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (5, 9, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (5, 10, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (5, 11, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (5, 12, 1);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (6, 1, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (6, 2, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (6, 3, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (6, 4, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (6, 12, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (7, 1, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (7, 2, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (7, 5, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (7, 6, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (7, 12, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (8, 1, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (8, 2, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (8, 3, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (8, 7, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (8, 12, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (8, 6, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (9, 1, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (9, 3, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (9, 13, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (9, 14, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (9, 15, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (10, 1, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (10, 2, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (10, 3, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (10, 8, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (10, 9, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (10, 10, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (10, 11, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (10, 12, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (11, 1, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (11, 2, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (11, 3, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (11, 4, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (11, 12, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (12, 1, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (12, 2, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (12, 5, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (12, 6, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (12, 12, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (13, 1, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (13, 2, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (13, 3, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (13, 7, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (13, 12, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (13, 6, 3);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (14, 1, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (14, 3, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (14, 13, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (14, 14, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (14, 15, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (15, 1, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (15, 2, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (15, 3, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (15, 8, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (15, 9, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (15, 10, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (15, 11, 2);
INSERT INTO public.ingredients_de_la_pizza (id_pizza, id_ingr_pizz, quantite) VALUES (15, 12, 2);


--
-- TOC entry 3271 (class 0 OID 24910)
-- Dependencies: 209
-- Data for Name: mouvement_stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (1, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Pâtes à pizza', 'Entrée', 1, 1);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (2, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Pâtes à pizza', 'Entrée', 1, 17);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (3, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Pâtes à pizza', 'Entrée', 1, 33);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (4, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Pâtes à pizza', 'Entrée', 1, 49);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (5, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Pâtes à pizza', 'Entrée', 1, 65);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (6, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Sauces tomate', 'Entrée', 2, 2);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (7, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Sauces tomate', 'Entrée', 2, 18);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (8, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Sauces tomate', 'Entrée', 2, 34);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (9, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Sauces tomate', 'Entrée', 2, 50);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (10, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Sauces tomate', 'Entrée', 2, 66);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (11, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Mozarellas', 'Entrée', 3, 3);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (12, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Mozarellas', 'Entrée', 3, 19);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (13, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Mozarellas', 'Entrée', 3, 35);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (14, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Mozarellas', 'Entrée', 3, 51);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (15, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Mozarellas', 'Entrée', 3, 67);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (16, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '100 Basilics', 'Entrée', 4, 4);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (17, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '100 Basilics', 'Entrée', 4, 20);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (18, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '100 Basilics', 'Entrée', 4, 36);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (19, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '100 Basilics', 'Entrée', 4, 52);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (20, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '100 Basilics', 'Entrée', 4, 68);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (21, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Ails', 'Entrée', 5, 5);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (22, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Ails', 'Entrée', 5, 21);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (23, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Ails', 'Entrée', 5, 37);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (24, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Ails', 'Entrée', 5, 53);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (25, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Ails', 'Entrée', 5, 69);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (26, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Origans', 'Entrée', 6, 6);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (27, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Origans', 'Entrée', 6, 22);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (28, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Origans', 'Entrée', 6, 38);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (29, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Origans', 'Entrée', 6, 54);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (30, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Origans', 'Entrée', 6, 70);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (31, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Anchois', 'Entrée', 7, 7);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (32, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Anchois', 'Entrée', 7, 23);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (33, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Anchois', 'Entrée', 7, 39);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (34, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Anchois', 'Entrée', 7, 55);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (35, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Anchois', 'Entrée', 7, 71);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (36, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Jambons cuits', 'Entrée', 8, 8);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (37, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Jambons cuits', 'Entrée', 8, 24);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (38, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Jambons cuits', 'Entrée', 8, 40);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (39, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Jambons cuits', 'Entrée', 8, 56);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (40, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Jambons cuits', 'Entrée', 8, 72);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (41, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Artichauts', 'Entrée', 9, 9);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (42, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Artichauts', 'Entrée', 9, 25);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (43, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Artichauts', 'Entrée', 9, 41);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (44, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Artichauts', 'Entrée', 9, 57);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (45, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Artichauts', 'Entrée', 9, 73);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (46, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Champignons', 'Entrée', 10, 10);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (47, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Champignons', 'Entrée', 10, 26);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (48, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Champignons', 'Entrée', 10, 42);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (49, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Champignons', 'Entrée', 10, 58);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (50, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Champignons', 'Entrée', 10, 74);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (51, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Olives', 'Entrée', 11, 11);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (52, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Olives', 'Entrée', 11, 27);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (53, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Olives', 'Entrée', 11, 43);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (54, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Olives', 'Entrée', 11, 59);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (55, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Olives', 'Entrée', 11, 75);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (56, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '100 Huiles', 'Entrée', 12, 12);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (57, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '100 Huiles', 'Entrée', 12, 28);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (58, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '100 Huiles', 'Entrée', 12, 44);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (59, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '100 Huiles', 'Entrée', 12, 60);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (60, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '100 Huiles', 'Entrée', 12, 76);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (61, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Gorgonzolas', 'Entrée', 13, 13);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (62, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Gorgonzolas', 'Entrée', 13, 29);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (63, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Gorgonzolas', 'Entrée', 13, 45);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (64, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Gorgonzolas', 'Entrée', 13, 61);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (65, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Gorgonzolas', 'Entrée', 13, 77);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (66, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Fontinas', 'Entrée', 14, 14);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (67, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Fontinas', 'Entrée', 14, 30);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (68, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Fontinas', 'Entrée', 14, 46);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (69, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Fontinas', 'Entrée', 14, 62);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (70, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Fontinas', 'Entrée', 14, 78);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (71, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Parmesans', 'Entrée', 15, 15);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (72, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Parmesans', 'Entrée', 15, 31);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (73, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Parmesans', 'Entrée', 15, 47);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (74, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Parmesans', 'Entrée', 15, 63);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (75, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Parmesans', 'Entrée', 15, 79);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (76, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '100 Sauces piquantes', 'Entrée', 16, 16);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (77, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Sauces piquantes', 'Entrée', 16, 32);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (78, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Sauces piquantes', 'Entrée', 16, 48);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (79, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Sauces piquantes', 'Entrée', 16, 64);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (80, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '100 Sauces piquantes', 'Entrée', 16, 80);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (81, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Pâtes à pizza', 'Sortie', 1, 1);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (82, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Pâtes à pizza', 'Sortie', 1, 17);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (83, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Pâtes à pizza', 'Sortie', 1, 33);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (84, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Pâtes à pizza', 'Sortie', 1, 49);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (85, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Pâtes à pizza', 'Sortie', 1, 65);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (86, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Sauces tomate', 'Sortie', 2, 2);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (87, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Sauces tomate', 'Sortie', 2, 18);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (88, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Sauces tomate', 'Sortie', 2, 34);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (89, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Sauces tomate', 'Sortie', 2, 50);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (90, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Sauces tomate', 'Sortie', 2, 66);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (91, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Mozarellas', 'Sortie', 3, 3);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (92, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Mozarellas', 'Sortie', 3, 19);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (93, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Mozarellas', 'Sortie', 3, 35);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (94, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Mozarellas', 'Sortie', 3, 51);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (95, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Mozarellas', 'Sortie', 3, 67);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (96, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '20 Basilics', 'Sortie', 4, 4);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (97, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '20 Basilics', 'Sortie', 4, 20);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (98, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '20 Basilics', 'Sortie', 4, 36);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (99, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '20 Basilics', 'Sortie', 4, 52);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (100, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '20 Basilics', 'Sortie', 4, 68);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (101, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Ails', 'Sortie', 5, 5);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (102, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Ails', 'Sortie', 5, 21);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (103, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Ails', 'Sortie', 5, 37);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (104, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Ails', 'Sortie', 5, 53);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (105, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Ails', 'Sortie', 5, 69);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (106, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Origans', 'Sortie', 6, 6);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (107, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Origans', 'Sortie', 6, 22);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (108, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Origans', 'Sortie', 6, 38);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (109, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Origans', 'Sortie', 6, 54);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (110, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Origans', 'Sortie', 6, 70);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (111, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Anchois', 'Sortie', 7, 7);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (112, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Anchois', 'Sortie', 7, 23);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (113, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Anchois', 'Sortie', 7, 39);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (114, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Anchois', 'Sortie', 7, 55);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (115, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Anchois', 'Sortie', 7, 71);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (116, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Jambons cuits', 'Sortie', 8, 8);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (117, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Jambons cuits', 'Sortie', 8, 24);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (118, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Jambons cuits', 'Sortie', 8, 40);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (119, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Jambons cuits', 'Sortie', 8, 56);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (120, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Jambons cuits', 'Sortie', 8, 72);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (121, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Artichauts', 'Sortie', 9, 9);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (122, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Artichauts', 'Sortie', 9, 25);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (123, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Artichauts', 'Sortie', 9, 41);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (124, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Artichauts', 'Sortie', 9, 57);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (125, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Artichauts', 'Sortie', 9, 73);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (126, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Champignons', 'Sortie', 10, 10);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (127, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Champignons', 'Sortie', 10, 26);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (128, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Champignons', 'Sortie', 10, 42);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (129, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Champignons', 'Sortie', 10, 58);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (130, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Champignons', 'Sortie', 10, 74);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (131, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Olives', 'Sortie', 11, 11);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (132, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Olives', 'Sortie', 11, 27);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (133, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Olives', 'Sortie', 11, 43);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (134, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Olives', 'Sortie', 11, 59);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (135, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Olives', 'Sortie', 11, 75);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (136, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '20 Huiles', 'Sortie', 12, 12);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (137, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '20 Huiles', 'Sortie', 12, 28);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (138, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '20 Huiles', 'Sortie', 12, 44);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (139, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '20 Huiles', 'Sortie', 12, 60);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (140, '2019-08-10 00:00:00', '2019-09-10 00:00:00', '20 Huiles', 'Sortie', 12, 76);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (141, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Gorgonzolas', 'Sortie', 13, 13);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (142, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Gorgonzolas', 'Sortie', 13, 29);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (143, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Gorgonzolas', 'Sortie', 13, 45);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (144, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Gorgonzolas', 'Sortie', 13, 61);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (145, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Gorgonzolas', 'Sortie', 13, 77);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (146, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Fontinas', 'Sortie', 14, 14);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (147, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Fontinas', 'Sortie', 14, 30);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (148, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Fontinas', 'Sortie', 14, 46);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (149, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Fontinas', 'Sortie', 14, 62);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (150, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Fontinas', 'Sortie', 14, 78);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (151, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Parmesans', 'Sortie', 15, 15);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (152, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Parmesans', 'Sortie', 15, 31);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (153, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Parmesans', 'Sortie', 15, 47);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (154, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Parmesans', 'Sortie', 15, 63);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (155, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Parmesans', 'Sortie', 15, 79);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (156, '2019-08-10 00:00:00', '2020-12-10 00:00:00', '20 Sauces piquantes', 'Sortie', 16, 16);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (157, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Sauces piquantes', 'Sortie', 16, 32);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (158, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Sauces piquantes', 'Sortie', 16, 48);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (159, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Sauces piquantes', 'Sortie', 16, 64);
INSERT INTO public.mouvement_stock (id_mvt, date, date_peremption, type_fourniture, entre_ou_sortie, id_ingredient_four, id_stock_global) VALUES (160, '2019-08-10 00:00:00', '2019-11-10 00:00:00', '20 Sauces piquantes', 'Sortie', 16, 80);


--
-- TOC entry 3260 (class 0 OID 24845)
-- Dependencies: 198
-- Data for Name: pizza; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (1, 'MARGHERITA', 10, 'Préparer la pâte à pizza....', '00:10:00', 'Mini', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (2, 'MARINARA', 10, 'Préparer la pâte à pizza....', '00:10:00', 'Mini', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (3, 'ROMANA', 12, 'Préparer la pâte à pizza....', '00:12:00', 'Mini', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (4, '4 FORMAGGi', 12, 'Préparer la pâte à pizza....', '00:12:00', 'Mini', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (5, '4 STAGIONI ', 13, 'Préparer la pâte à pizza....', '00:15:00', 'Mini', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (6, 'MARGHERITA', 12, 'Préparer la pâte à pizza....', '00:12:00', 'Normale', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (7, 'MARINARA', 12, 'Préparer la pâte à pizza....', '00:12:00', 'Normale', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (8, 'ROMANA', 14, 'Préparer la pâte à pizza....', '00:14:00', 'Normale', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (9, '4 FORMAGGi', 14, 'Préparer la pâte à pizza....', '00:14:00', 'Normale', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (10, '4 STAGIONI ', 15, 'Préparer la pâte à pizza....', '00:17:00', 'Normale', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (11, 'MARGHERITA', 15, 'Préparer la pâte à pizza....', '00:15:00', 'Maxi', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (12, 'MARINARA', 15, 'Préparer la pâte à pizza....', '00:15:00', 'Maxi', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (13, 'ROMANA', 17, 'Préparer la pâte à pizza....', '00:17:00', 'Maxi', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (14, '4 FORMAGGi', 17, 'Préparer la pâte à pizza....', '00:17:00', 'Maxi', true);
INSERT INTO public.pizza (id_pizza, name, prix, recette, temps_preparation, taille, disponible) VALUES (15, '4 STAGIONI ', 18, 'Préparer la pâte à pizza....', '00:20:00', 'Maxi', true);


--
-- TOC entry 3269 (class 0 OID 24897)
-- Dependencies: 207
-- Data for Name: pizzas_de_la_commande; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (1, 6, 1);
INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (2, 13, 1);
INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (2, 10, 1);
INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (3, 10, 1);
INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (4, 1, 2);
INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (4, 7, 1);
INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (5, 2, 1);
INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (6, 10, 2);
INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (6, 9, 1);
INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (6, 11, 1);
INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (7, 1, 2);
INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (8, 9, 3);
INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (9, 2, 1);
INSERT INTO public.pizzas_de_la_commande (id_commande, id_pizza, quantite) VALUES (9, 13, 1);


--
-- TOC entry 3264 (class 0 OID 24866)
-- Dependencies: 202
-- Data for Name: pizzeria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pizzeria (id_pizzeria, name, adresse, numtel, horaire_ouv, horaire_fer, distance_max) VALUES (1, 'Pizzeria 1', '12 allée Lemoine, Roubaix', '06 21 66 92 15', '11:00:00', '23:00:00', 9);
INSERT INTO public.pizzeria (id_pizzeria, name, adresse, numtel, horaire_ouv, horaire_fer, distance_max) VALUES (2, 'Pizzeria 2', ' 28 rue du calvaire, Lille', '06 50 06 71 65', '11:00:00', '22:00:00', 8);
INSERT INTO public.pizzeria (id_pizzeria, name, adresse, numtel, horaire_ouv, horaire_fer, distance_max) VALUES (3, 'Pizzeria 3', ' 52 allée du playmobile', '06 57 00 87 21', '11:00:00', '22:00:00', 10);
INSERT INTO public.pizzeria (id_pizzeria, name, adresse, numtel, horaire_ouv, horaire_fer, distance_max) VALUES (4, 'Pizzeria 4', ' 12 rue de la mésange', '06 42 75 97 56', '11:00:00', '22:00:00', 8);
INSERT INTO public.pizzeria (id_pizzeria, name, adresse, numtel, horaire_ouv, horaire_fer, distance_max) VALUES (5, 'Pizzeria 5', ' 88 rue de la désertification', '07 85 95 53 67', '11:00:00', '22:00:00', 10);


--
-- TOC entry 3270 (class 0 OID 24902)
-- Dependencies: 208
-- Data for Name: stock_global; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (1, 'Stock pâte à pizza', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (17, 'Stock pâte à pizza', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (33, 'Stock pâte à pizza', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (49, 'Stock pâte à pizza', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (65, 'Stock pâte à pizza', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (2, 'Stock sauce tomate', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (18, 'Stock sauce tomate', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (34, 'Stock sauce tomate', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (50, 'Stock sauce tomate', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (66, 'Stock sauce tomate', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (3, 'Stock mozzarella', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (19, 'Stock mozzarella', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (35, 'Stock mozzarella', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (51, 'Stock mozzarella', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (67, 'Stock mozzarella', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (4, 'Stock basilic', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (20, 'Stock basilic', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (36, 'Stock basilic', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (52, 'Stock basilic', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (68, 'Stock basilic', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (5, 'Stock ail', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (21, 'Stock ail', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (37, 'Stock ail', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (53, 'Stock ail', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (69, 'Stock ail', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (6, 'Stock origan', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (22, 'Stock origan', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (38, 'Stock origan', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (54, 'Stock origan', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (70, 'Stock origan', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (7, 'Stock Anchois', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (23, 'Stock Anchois', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (39, 'Stock Anchois', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (55, 'Stock Anchois', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (71, 'Stock Anchois', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (8, 'Stock jambon cuit', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (24, 'Stock jambon cuit', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (40, 'Stock jambon cuit', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (56, 'Stock jambon cuit', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (72, 'Stock jambon cuit', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (9, 'Stock artichauts', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (25, 'Stock artichauts', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (41, 'Stock artichauts', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (57, 'Stock artichauts', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (73, 'Stock artichauts', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (10, 'Stock champignons de Paris', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (26, 'Stock champignons de Paris', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (42, 'Stock champignons de Paris', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (58, 'Stock champignons de Paris', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (74, 'Stock champignons de Paris', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (11, 'Stock olives noires', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (27, 'Stock olives noires', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (43, 'Stock olives noires', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (59, 'Stock olives noires', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (75, 'Stock olives noires', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (12, 'Stock huile d’olive', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (28, 'Stock huile d’olive', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (44, 'Stock huile d’olive', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (60, 'Stock huile d’olive', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (76, 'Stock huile d’olive', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (13, 'Stock gorgonzola', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (29, 'Stock gorgonzola', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (45, 'Stock gorgonzola', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (61, 'Stock gorgonzola', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (77, 'Stock gorgonzola', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (14, 'Stock fontina', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (30, 'Stock fontina', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (46, 'Stock fontina', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (62, 'Stock fontina', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (78, 'Stock fontina', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (15, 'Stock parmesan', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (31, 'Stock parmesan', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (47, 'Stock parmesan', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (63, 'Stock parmesan', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (79, 'Stock parmesan', 80, 5);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (16, 'Stock sauce piquante', 80, 1);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (32, 'Stock sauce piquante', 80, 2);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (48, 'Stock sauce piquante', 80, 3);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (64, 'Stock sauce piquante', 80, 4);
INSERT INTO public.stock_global (id_stock_global, name, quantite_restante, id_pizzeria) VALUES (80, 'Stock sauce piquante', 80, 5);


--
-- TOC entry 3290 (class 0 OID 0)
-- Dependencies: 199
-- Name: client_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_id_client_seq', 5, true);


--
-- TOC entry 3291 (class 0 OID 0)
-- Dependencies: 203
-- Name: commande_id_commande_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commande_id_commande_seq', 9, true);


--
-- TOC entry 3292 (class 0 OID 0)
-- Dependencies: 205
-- Name: commentaire_id_commentaire_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commentaire_id_commentaire_seq', 9, true);


--
-- TOC entry 3293 (class 0 OID 0)
-- Dependencies: 213
-- Name: employ__id_employe_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employ__id_employe_seq', 21, true);


--
-- TOC entry 3294 (class 0 OID 0)
-- Dependencies: 210
-- Name: ingredient_pizzeria_id_ingr_pizz_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ingredient_pizzeria_id_ingr_pizz_seq', 80, true);


--
-- TOC entry 3295 (class 0 OID 0)
-- Dependencies: 201
-- Name: pizzeria_id_pizzeria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pizzeria_id_pizzeria_seq', 5, true);


--
-- TOC entry 3100 (class 2606 OID 24863)
-- Name: client client_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pk PRIMARY KEY (id_client);


--
-- TOC entry 3104 (class 2606 OID 24885)
-- Name: commande commande_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pk PRIMARY KEY (id_commande);


--
-- TOC entry 3106 (class 2606 OID 24896)
-- Name: commentaire commentaire_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT commentaire_pk PRIMARY KEY (id_commentaire);


--
-- TOC entry 3118 (class 2606 OID 24944)
-- Name: employé employ__pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."employé"
    ADD CONSTRAINT employ__pk PRIMARY KEY (id_employe);


--
-- TOC entry 3120 (class 2606 OID 24949)
-- Name: en_charge_des_commandes en_charge_des_commandes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.en_charge_des_commandes
    ADD CONSTRAINT en_charge_des_commandes_pk PRIMARY KEY (id_employe, id_commande);


--
-- TOC entry 3094 (class 2606 OID 24836)
-- Name: fournisseur fournisseur_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fournisseur
    ADD CONSTRAINT fournisseur_pk PRIMARY KEY (id_fournisseur);


--
-- TOC entry 3096 (class 2606 OID 24844)
-- Name: ingredient_fournisseur ingredient_fournisseur_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient_fournisseur
    ADD CONSTRAINT ingredient_fournisseur_pk PRIMARY KEY (id_ingredient_four);


--
-- TOC entry 3114 (class 2606 OID 24928)
-- Name: ingredient_pizzeria ingredient_pizzeria_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient_pizzeria
    ADD CONSTRAINT ingredient_pizzeria_pk PRIMARY KEY (id_ingr_pizz);


--
-- TOC entry 3116 (class 2606 OID 24933)
-- Name: ingredients_de_la_pizza ingredients_de_la_pizza_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredients_de_la_pizza
    ADD CONSTRAINT ingredients_de_la_pizza_pk PRIMARY KEY (id_pizza, id_ingr_pizz);


--
-- TOC entry 3112 (class 2606 OID 24917)
-- Name: mouvement_stock mouvement_stock_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mouvement_stock
    ADD CONSTRAINT mouvement_stock_pk PRIMARY KEY (id_mvt);


--
-- TOC entry 3098 (class 2606 OID 24852)
-- Name: pizza pizza_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizza
    ADD CONSTRAINT pizza_pk PRIMARY KEY (id_pizza);


--
-- TOC entry 3108 (class 2606 OID 24901)
-- Name: pizzas_de_la_commande pizzas_de_la_commande_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizzas_de_la_commande
    ADD CONSTRAINT pizzas_de_la_commande_pk PRIMARY KEY (id_commande, id_pizza);


--
-- TOC entry 3102 (class 2606 OID 24874)
-- Name: pizzeria pizzeria_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizzeria
    ADD CONSTRAINT pizzeria_pk PRIMARY KEY (id_pizzeria);


--
-- TOC entry 3110 (class 2606 OID 24909)
-- Name: stock_global stock_global_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_global
    ADD CONSTRAINT stock_global_pk PRIMARY KEY (id_stock_global);


--
-- TOC entry 3122 (class 2606 OID 24975)
-- Name: commande client_commande_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT client_commande_fk FOREIGN KEY (id_client) REFERENCES public.client(id_client);


--
-- TOC entry 3124 (class 2606 OID 24970)
-- Name: commentaire client_commentaire_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT client_commentaire_fk FOREIGN KEY (id_client) REFERENCES public.client(id_client);


--
-- TOC entry 3125 (class 2606 OID 25005)
-- Name: commentaire commande_commentaire_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT commande_commentaire_fk FOREIGN KEY (id_commande) REFERENCES public.commande(id_commande);


--
-- TOC entry 3135 (class 2606 OID 24995)
-- Name: en_charge_des_commandes commande_en_charge_des_commandes_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.en_charge_des_commandes
    ADD CONSTRAINT commande_en_charge_des_commandes_fk FOREIGN KEY (id_commande) REFERENCES public.commande(id_commande);


--
-- TOC entry 3127 (class 2606 OID 25000)
-- Name: pizzas_de_la_commande commande_pizzas_de_la_commande_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizzas_de_la_commande
    ADD CONSTRAINT commande_pizzas_de_la_commande_fk FOREIGN KEY (id_commande) REFERENCES public.commande(id_commande);


--
-- TOC entry 3136 (class 2606 OID 25025)
-- Name: en_charge_des_commandes employ__en_charge_des_commandes_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.en_charge_des_commandes
    ADD CONSTRAINT employ__en_charge_des_commandes_fk FOREIGN KEY (id_employe) REFERENCES public."employé"(id_employe);


--
-- TOC entry 3121 (class 2606 OID 24950)
-- Name: ingredient_fournisseur fournisseur_ingredient_fournisseur_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient_fournisseur
    ADD CONSTRAINT fournisseur_ingredient_fournisseur_fk FOREIGN KEY (id_fournisseur) REFERENCES public.fournisseur(id_fournisseur);


--
-- TOC entry 3129 (class 2606 OID 24955)
-- Name: mouvement_stock ingredient_fournisseur_mouvement_stock_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mouvement_stock
    ADD CONSTRAINT ingredient_fournisseur_mouvement_stock_fk FOREIGN KEY (id_ingredient_four) REFERENCES public.ingredient_fournisseur(id_ingredient_four);


--
-- TOC entry 3133 (class 2606 OID 25020)
-- Name: ingredients_de_la_pizza ingredient_pizzeria_ingredients_de_la_pizza_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredients_de_la_pizza
    ADD CONSTRAINT ingredient_pizzeria_ingredients_de_la_pizza_fk FOREIGN KEY (id_ingr_pizz) REFERENCES public.ingredient_pizzeria(id_ingr_pizz);


--
-- TOC entry 3131 (class 2606 OID 25015)
-- Name: ingredient_pizzeria mouvement_stock_ingredient_pizzeria_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient_pizzeria
    ADD CONSTRAINT mouvement_stock_ingredient_pizzeria_fk FOREIGN KEY (id_mvt) REFERENCES public.mouvement_stock(id_mvt);


--
-- TOC entry 3132 (class 2606 OID 24965)
-- Name: ingredients_de_la_pizza pizza_ingredients_de_la_pizza_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredients_de_la_pizza
    ADD CONSTRAINT pizza_ingredients_de_la_pizza_fk FOREIGN KEY (id_pizza) REFERENCES public.pizza(id_pizza);


--
-- TOC entry 3126 (class 2606 OID 24960)
-- Name: pizzas_de_la_commande pizza_pizzas_de_la_commande_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pizzas_de_la_commande
    ADD CONSTRAINT pizza_pizzas_de_la_commande_fk FOREIGN KEY (id_pizza) REFERENCES public.pizza(id_pizza);


--
-- TOC entry 3123 (class 2606 OID 24990)
-- Name: commande pizzeria_commande_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT pizzeria_commande_fk FOREIGN KEY (id_pizzeria) REFERENCES public.pizzeria(id_pizzeria);


--
-- TOC entry 3134 (class 2606 OID 24980)
-- Name: employé pizzeria_employ__fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."employé"
    ADD CONSTRAINT pizzeria_employ__fk FOREIGN KEY (id_pizzeria) REFERENCES public.pizzeria(id_pizzeria);


--
-- TOC entry 3128 (class 2606 OID 24985)
-- Name: stock_global pizzeria_stock_global_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_global
    ADD CONSTRAINT pizzeria_stock_global_fk FOREIGN KEY (id_pizzeria) REFERENCES public.pizzeria(id_pizzeria);


--
-- TOC entry 3130 (class 2606 OID 25010)
-- Name: mouvement_stock stock_global_mouvement_stock_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mouvement_stock
    ADD CONSTRAINT stock_global_mouvement_stock_fk FOREIGN KEY (id_stock_global) REFERENCES public.stock_global(id_stock_global);


-- Completed on 2019-08-14 11:13:06 CEST

--
-- PostgreSQL database dump complete
--

