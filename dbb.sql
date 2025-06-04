--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-06-04 22:49:37

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 24583)
-- Name: Kategoria; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public."Kategoria" (
    "ID_Kategoria" bigint NOT NULL,
    "Nazwa" character varying
);


ALTER TABLE public."Kategoria" OWNER TO inzynieria_owner;

--
-- TOC entry 223 (class 1259 OID 24640)
-- Name: Miejsce; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public."Miejsce" (
    "ID_Miejsce" bigint NOT NULL,
    "ID_Region" integer NOT NULL,
    "ID_Kategoria" integer NOT NULL,
    "ID_Użytkownik" integer NOT NULL,
    "Nazwa" character varying,
    "Ulica" character varying,
    "Opis" character varying,
    "Data_dodania" date,
    "Miejscowość" character varying,
    "Kod_pocztowy" character varying(6),
    "Link" character varying,
    CONSTRAINT "Miejsce_kod_pocztowy_check" CHECK ((("Kod_pocztowy")::text ~ '^[0-9]{2}-[0-9]{3}$'::text))
);


ALTER TABLE public."Miejsce" OWNER TO inzynieria_owner;

--
-- TOC entry 245 (class 1259 OID 90112)
-- Name: Miejsce_ID_Miejsce_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public."Miejsce" ALTER COLUMN "ID_Miejsce" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Miejsce_ID_Miejsce_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 251 (class 1259 OID 114714)
-- Name: Ranking; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public."Ranking" (
    "ID_Ranking" integer NOT NULL,
    "Nazwa" character varying(100) NOT NULL,
    "Opis" text,
    "Data_utworzenia" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Ranking" OWNER TO inzynieria_owner;

--
-- TOC entry 250 (class 1259 OID 114713)
-- Name: Ranking_ID_Ranking_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

CREATE SEQUENCE public."Ranking_ID_Ranking_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Ranking_ID_Ranking_seq" OWNER TO inzynieria_owner;

--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 250
-- Name: Ranking_ID_Ranking_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: inzynieria_owner
--

ALTER SEQUENCE public."Ranking_ID_Ranking_seq" OWNED BY public."Ranking"."ID_Ranking";


--
-- TOC entry 253 (class 1259 OID 114725)
-- Name: Ranking_Miejsca; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public."Ranking_Miejsca" (
    id integer NOT NULL,
    ranking_id integer NOT NULL,
    miejsce_id integer NOT NULL
);


ALTER TABLE public."Ranking_Miejsca" OWNER TO inzynieria_owner;

--
-- TOC entry 252 (class 1259 OID 114724)
-- Name: Ranking_Miejsca_id_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

CREATE SEQUENCE public."Ranking_Miejsca_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Ranking_Miejsca_id_seq" OWNER TO inzynieria_owner;

--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 252
-- Name: Ranking_Miejsca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: inzynieria_owner
--

ALTER SEQUENCE public."Ranking_Miejsca_id_seq" OWNED BY public."Ranking_Miejsca".id;


--
-- TOC entry 222 (class 1259 OID 24621)
-- Name: Recenzja; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public."Recenzja" (
    "ID_Recenzja" bigint NOT NULL,
    "ID_Użytkownik" integer NOT NULL,
    "Ocena" integer,
    "Komentarz" character varying,
    "Data_dodania" date,
    "ID_Miejsce" integer NOT NULL
);


ALTER TABLE public."Recenzja" OWNER TO inzynieria_owner;

--
-- TOC entry 246 (class 1259 OID 90113)
-- Name: Recenzja_ID_Recenzja_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public."Recenzja" ALTER COLUMN "ID_Recenzja" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Recenzja_ID_Recenzja_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 24590)
-- Name: Region; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public."Region" (
    "ID_Regionu" bigint NOT NULL,
    "Nazwa" character varying
);


ALTER TABLE public."Region" OWNER TO inzynieria_owner;

--
-- TOC entry 217 (class 1259 OID 24576)
-- Name: Uprawnienia; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public."Uprawnienia" (
    "ID_Uprawnienia" bigint NOT NULL,
    "Nazwa" character varying
);


ALTER TABLE public."Uprawnienia" OWNER TO inzynieria_owner;

--
-- TOC entry 220 (class 1259 OID 24597)
-- Name: Użytkownik; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public."Użytkownik" (
    "ID_Użytkownik" bigint NOT NULL,
    "Imie" character varying,
    "Nazwisko" character varying,
    "Mail" character varying,
    "Hasło" character varying,
    "ID_Uprawnienia" integer NOT NULL
);


ALTER TABLE public."Użytkownik" OWNER TO inzynieria_owner;

--
-- TOC entry 247 (class 1259 OID 90114)
-- Name: Użytkownik_ID_Użytkownik_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public."Użytkownik" ALTER COLUMN "ID_Użytkownik" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Użytkownik_ID_Użytkownik_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 24662)
-- Name: Zdjęcia; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public."Zdjęcia" (
    "ID_Zdjęcie" bigint NOT NULL,
    "ID_Miejsce" integer,
    "ID_Recenzja" integer,
    "URL" character varying NOT NULL
);


ALTER TABLE public."Zdjęcia" OWNER TO inzynieria_owner;

--
-- TOC entry 248 (class 1259 OID 90115)
-- Name: Zdjęcia_ID_Zdjęcie_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public."Zdjęcia" ALTER COLUMN "ID_Zdjęcie" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Zdjęcia_ID_Zdjęcie_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 65572)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO inzynieria_owner;

--
-- TOC entry 231 (class 1259 OID 65571)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 65580)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO inzynieria_owner;

--
-- TOC entry 233 (class 1259 OID 65579)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 65566)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO inzynieria_owner;

--
-- TOC entry 229 (class 1259 OID 65565)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 236 (class 1259 OID 65586)
-- Name: auth_user; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO inzynieria_owner;

--
-- TOC entry 238 (class 1259 OID 65594)
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO inzynieria_owner;

--
-- TOC entry 237 (class 1259 OID 65593)
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 235 (class 1259 OID 65585)
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 240 (class 1259 OID 65600)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO inzynieria_owner;

--
-- TOC entry 239 (class 1259 OID 65599)
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 242 (class 1259 OID 65658)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO inzynieria_owner;

--
-- TOC entry 241 (class 1259 OID 65657)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 65558)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO inzynieria_owner;

--
-- TOC entry 227 (class 1259 OID 65557)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 65550)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO inzynieria_owner;

--
-- TOC entry 225 (class 1259 OID 65549)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 243 (class 1259 OID 65693)
-- Name: django_session; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO inzynieria_owner;

--
-- TOC entry 221 (class 1259 OID 24611)
-- Name: historia_wyszukiwan; Type: TABLE; Schema: public; Owner: inzynieria_owner
--

CREATE TABLE public.historia_wyszukiwan (
    "ID_Historia" bigint NOT NULL,
    "ID_Użytkownik" integer NOT NULL,
    "Data_wyszukiwania" timestamp with time zone,
    "ID_Miejsce" integer NOT NULL
);


ALTER TABLE public.historia_wyszukiwan OWNER TO inzynieria_owner;

--
-- TOC entry 244 (class 1259 OID 81925)
-- Name: historia_wyszukiwan_ID_Historia_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE public.historia_wyszukiwan ALTER COLUMN "ID_Historia" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."historia_wyszukiwan_ID_Historia_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 249 (class 1259 OID 98306)
-- Name: miejsce_id_seq; Type: SEQUENCE; Schema: public; Owner: inzynieria_owner
--

CREATE SEQUENCE public.miejsce_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.miejsce_id_seq OWNER TO inzynieria_owner;

--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 249
-- Name: miejsce_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: inzynieria_owner
--

ALTER SEQUENCE public.miejsce_id_seq OWNED BY public."Miejsce"."ID_Miejsce";


--
-- TOC entry 3279 (class 2604 OID 114717)
-- Name: Ranking ID_Ranking; Type: DEFAULT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Ranking" ALTER COLUMN "ID_Ranking" SET DEFAULT nextval('public."Ranking_ID_Ranking_seq"'::regclass);


--
-- TOC entry 3281 (class 2604 OID 114728)
-- Name: Ranking_Miejsca id; Type: DEFAULT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Ranking_Miejsca" ALTER COLUMN id SET DEFAULT nextval('public."Ranking_Miejsca_id_seq"'::regclass);


--
-- TOC entry 3522 (class 0 OID 24583)
-- Dependencies: 218
-- Data for Name: Kategoria; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public."Kategoria" ("ID_Kategoria", "Nazwa") FROM stdin;
2	Zabytek
3	Krajobraz
1	Punkt gastronomiczny
4	Roślinność
5	Akwen wodny
6	Park
7	Kościół
8	Inne
\.


--
-- TOC entry 3527 (class 0 OID 24640)
-- Dependencies: 223
-- Data for Name: Miejsce; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public."Miejsce" ("ID_Miejsce", "ID_Region", "ID_Kategoria", "ID_Użytkownik", "Nazwa", "Ulica", "Opis", "Data_dodania", "Miejscowość", "Kod_pocztowy", "Link") FROM stdin;
15	1	5	1	Kolorowe jeziorka	\N	Pierwsze zielone, drugie błękitne, trzecie purpurowo-czerwone, czwarte zaś – czarne.	2025-05-24	Wieściszowice	58-410	https://maps.app.goo.gl/b8zyr3RPUZuPo5tw9
1	13	3	1	Skałki Piekło pod Niekłaniem	\N	Zbudowane z piaskowców, rzeźbione przez siły natury twory o wysokości od 2 do 8 m przybierają bardzo wymyślne kształty.	2023-01-15	Niekłań Wielki	26-220	https://maps.app.goo.gl/azkpYqcgPVKSck5a6
2	10	8	2	Kładka Śliwno-Waniewo	\N	Długa na 1050 metrów kładka prowadząca przez łąki, bagna i rozlewiska.	2023-02-20	Śliwno	16-070	https://maps.app.goo.gl/Vhv4ijL2WjAoCFRx5
3	1	3	3	Twierdza Srebrna Góra	Kręta 4	Jedyna górska forteca w Polsce i największa twierdza górska w Europie.	2023-03-10	Srebrna Góra	57-215	https://maps.app.goo.gl/ACF2xoE8VhR6e2cp6
26	1	2	2	Projekt "Riese", Kompleks "Włodarz"	 Górna 71	Najbezpieczniejszy i najnowocześniejszy schron Hitlera.	2025-05-24	Jugowice	58-321	https://maps.app.goo.gl/N6Z6DTUEPURCUc1U8
28	15	5	3	Skrzyżowanie rzek	 Gnieźnieńska	Jedyne w Europie skrzyżowanie rzek w jednej płaszczyźnie.	2025-05-24	Wągrowiec	62-100	https://maps.app.goo.gl/sAg6kVRnH5otb7cN6
29	3	8	4	Magiczne Ogrody	Trzcianki 92	Jedyny w Polsce rodzinny park tematyczny, oparty na autorskiej baśni.	2025-05-24	Trzcianki	24-123	https://maps.app.goo.gl/Hb4s3jMCEd6RAeq6A
30	1	3	5	Geopark Kraina Wygasłych Wulkanów	\N	Dawne wulkany, dziś malownicze wzgórza, stanowią atrakcję dla geologów, fotografów oraz turystów poszukujących nietypowych miejsc.	2025-05-24	Złotoryja	59-500	https://maps.app.goo.gl/EFJbRjJ5FiNgjm8a6
31	1	2	6	Krzywa wieża	Świętego Wojciecha 7	Jedna z najbardziej pochylonych konstrukcji tego typu w Polsce.	2025-05-23	Ząbkowice Śląskie	57-200	https://maps.app.goo.gl/5spERsyEAKJEdxxF6
32	1	8	7	Muzeum Klocków	 Adama Mickiewicza 11	W muzeum znajdują się interaktywne wystawy z klocków LEGO.	2025-05-25	Karpacz	58-540	https://maps.app.goo.gl/h1iz84FNLa2mufGa9
37	1	8	8	Muzeum Motoryzacji Wena	Zielna 1B	Największe prywatne muzeum motoryzacji w Europie Środkowej.	2025-05-25	Oława	55-200	https://maps.app.goo.gl/owU397vReqpHjgSa9
4	10	2	4	Skit w Odrynkach	\N	Jedyna prawosławna pustelnia w Polsce.	2023-04-05	Odrynki	17-210	https://maps.app.goo.gl/8DxxmHPLqgpQ8R9bA
38	9	3	4	Yumi	Krakowska	Mój piękny kotek	2025-05-25	Rzeszów	35-420	
39	8	8	1	Fabryka Robotów	Zamkowa 2	Jedyne miejsce w Polsce a nawet w Europie gdzie budowane są ogromnie stalowe roboty inspirowane filmami Sci-fi.	2025-05-25	Moszna	47-370	https://maps.app.goo.gl/h634eccy3NJ6GcwNA
5	8	2	5	Ruiny zamku w Kopicach	Kopice 47	Spektakularny gmach pałacowy z dwiema wieżami czworobocznymi zwieńczonymi wysokimi dachami z iglicami, otoczony z trzech stron malowniczymi stawami i parkiem.	2023-05-25	Kopice	49-200	https://maps.app.goo.gl/Y7Cg47kpMeXsehvv7
8	9	2	6	Muzeum-Zamek w Łańcucie	Zamkowa 1	Zamek w Łańcucie jest jedną z najpiękniejszych rezydencji arystokratycznych w Polsce.	2025-05-06	Łańcut	37-100	https://maps.app.goo.gl/dNi2RmSwT8FE9HUA7
9	12	6	7	Park Gródek	Płetwonurków	Park Gródek to dawna kopalnia dolomitu. Powstałe w ten sposób rozlewiska otoczone skałami stworzyły krajobraz niczym na wybrzeżu Dalmacji czy na Malediwach.	2025-05-14	Jaworzno	43-602	https://maps.app.goo.gl/NhGoeFSqRmULHZed7
12	1	8	8	Kaplica czaszek	Stanisława Moniuszki 8a	Ściany i sklepienie wnętrza kaplicy pokrywa ok. 3 tys. ciasno ułożonych czaszek i kości ludzkich, dalsze 20-30 tys. szczątków spoczywa w krypcie pod kaplicą. To jeden z zaledwie trzech takich obiektów w Europie.	2025-05-06	Kudowa-Zdrój	57-350	https://maps.app.goo.gl/UDU75r9XLnbRyHjA9
14	16	3	9	Krzywy las	Przemysłowa 25	Skupisko kilkuset najdziwniejszych sosen, jakie kiedykolwiek rosły na ziemi.	2025-05-06	Nowe Czarnowo	74-105	https://maps.app.goo.gl/vBP5Z4nDzXpk1A2h6
44	6	8	11	Kotek	Warłowska 33	Kotek	2025-06-02	Warło	33-333	
45	8	8	17	Obiekt Testowy	Warłowska 33	Testowy komentarz	2025-06-02	Warło	33-333	
46	5	6	11	Wacek	Łódzka	Wymagany Opis	2025-06-02	Łódź	10-223	
\.


--
-- TOC entry 3555 (class 0 OID 114714)
-- Dependencies: 251
-- Data for Name: Ranking; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public."Ranking" ("ID_Ranking", "Nazwa", "Opis", "Data_utworzenia") FROM stdin;
5	Ukryte perełki Polski	Miejsca mniej znane, ale wyjątkowo cenione przez użytkowników.	2025-06-03 16:28:20.810944
6	Idealne na weekend	Atrakcje, które świetnie sprawdzą się na krótkie wypady weekendowe.	2025-06-03 16:31:37.839965
7	Ranking rodzinny	Najlepsze miejsca do odwiedzenia z dziećmi i rodziną.	2025-06-03 16:32:38.829959
8	Ranking ekstremalny	Miejsca idealne dla fanów adrenaliny i przygody.	2025-06-03 16:33:11.240261
9	Najpiękniejsze widoki	Krajobrazy, punkty widokowe, natura.	2025-06-03 14:33:44.220816
10	Zabytki i historia	Historyczne miejsca i obiekty.	2025-06-03 16:34:44.260076
11	Top atrakcje Dolnego Śląska	Najlepsze w dolnośląskim.	2025-06-03 14:35:13.708761
12	Romantyczne miejsca	Klimatyczne, ciche i piękne lokalizacje na randkę.	2025-06-03 16:37:57.029916
4	TOP 5 Ogólnie	Najlepiej oceniane miejsca ogółem, niezależnie od kategorii czy regionu.	2025-06-03 14:24:27.592056
\.


--
-- TOC entry 3557 (class 0 OID 114725)
-- Dependencies: 253
-- Data for Name: Ranking_Miejsca; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public."Ranking_Miejsca" (id, ranking_id, miejsce_id) FROM stdin;
14	4	32
15	4	28
16	4	5
17	4	31
18	5	1
19	5	2
20	5	5
21	5	9
22	5	12
23	5	14
24	5	15
25	6	3
26	6	37
27	6	5
28	6	9
29	6	31
30	7	32
31	7	38
32	7	39
33	7	8
34	7	29
35	8	1
36	8	3
37	8	9
38	8	26
39	8	30
40	9	2
41	9	4
42	9	9
43	9	14
44	9	15
45	10	3
46	10	5
47	10	8
48	10	12
49	10	26
50	10	31
51	11	15
52	11	32
53	11	3
54	11	12
55	11	30
56	11	31
57	12	2
58	12	4
59	12	5
60	12	38
61	12	9
62	12	15
63	4	38
\.


--
-- TOC entry 3526 (class 0 OID 24621)
-- Dependencies: 222
-- Data for Name: Recenzja; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public."Recenzja" ("ID_Recenzja", "ID_Użytkownik", "Ocena", "Komentarz", "Data_dodania", "ID_Miejsce") FROM stdin;
9	1	4	\N	2025-05-24	26
10	10	5	\N	2025-05-24	28
11	10	0	\N	2025-05-24	29
12	10	0	\N	2025-05-24	30
13	10	2	\N	2025-05-24	31
14	1	4	\N	2025-05-25	32
18	1	4	\N	2025-05-25	37
19	10	5	\N	2025-05-25	38
21	10	5	Ale super pies!	2025-05-25	38
22	10	3	średnie te ciapki	2025-05-25	38
23	10	3	średnie te ciapki	2025-05-25	38
24	10	3	średnie te ciapki	2025-05-25	38
27	10	3	średnie szczerze mówiąc	2025-05-25	26
28	10	5	piękny kot 10/10	2025-05-25	38
29	10	1	słabe to	2025-05-25	1
31	10	5	fajny kotek	2025-05-25	38
32	15	5	Fajny kot, bardzo czujny	2025-05-25	38
33	10	0	\N	2025-05-25	39
34	10	4	nie pozdrawiam	2025-05-25	39
36	11	4	😺	2025-05-26	38
41	15	5	YUMI to jest kot a nie pies	2025-05-26	38
43	10	5	fajne	2025-05-27	5
45	11	5	Polecam te miejsce :) 😺	2025-06-02	38
46	11	3	\N	2025-06-02	44
47	11	5	Kotek😺	2025-06-02	44
48	17	4	\N	2025-06-02	45
49	11	3	\N	2025-06-02	46
51	16	5	fajne	2025-06-03	32
52	16	5	fajkne	2025-06-03	31
53	16	5	bardzo fajne	2025-06-03	31
54	16	5	bardzo fajne	2025-06-03	31
55	16	5	fajniutkjie	2025-06-03	31
56	16	5	4.4	2025-06-03	31
57	16	5	4.5	2025-06-03	31
\.


--
-- TOC entry 3523 (class 0 OID 24590)
-- Dependencies: 219
-- Data for Name: Region; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public."Region" ("ID_Regionu", "Nazwa") FROM stdin;
1	dolnośląskie
2	kujawsko-pomorskie
3	lubelskie
4	lubuskie
5	łódzkie
6	małopolskie
7	mazowieckie
8	opolskie
9	podkarpackie
10	podlaskie
11	pomorskie
12	śląskie
13	świętokrzyskie
14	warmińsko-mazurskie
15	wielkopolskie
16	zachodniopomorskie
17	Spoza Polski
\.


--
-- TOC entry 3521 (class 0 OID 24576)
-- Dependencies: 217
-- Data for Name: Uprawnienia; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public."Uprawnienia" ("ID_Uprawnienia", "Nazwa") FROM stdin;
1	Administrator
2	Użytkownik
\.


--
-- TOC entry 3524 (class 0 OID 24597)
-- Dependencies: 220
-- Data for Name: Użytkownik; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public."Użytkownik" ("ID_Użytkownik", "Imie", "Nazwisko", "Mail", "Hasło", "ID_Uprawnienia") FROM stdin;
1	Dawid	Kowalczuk	dawid.elo@gmail.com	siema	2
2	Jan	Kowalski	kowalski@gmail.com	Haslo123!	2
4	Ewa	Lipska	ewa.lipska@gmail.com	lipa	2
5	Filip	Konfederak	filip.konfederak@gmail.com	konfederata	2
6	Michał	Kumięga	michal.kumiega@gmail.com	kumi	1
7	Dominik	Kudła	dominik.kudla@gmail.com	kudłacz	1
8	Wiktor	Koźlik	wiktor.kozlik@gmail.com	koźlica	1
9	Jan	Kowalski	jan@gmail.com	1qazxsW@	2
10	test	test	ewa_lipska@op.pl	niewiem1	2
11	Dominik	Kudła	dominik-kudla1@wp.pl	6g>UUzC+'qsmysN	2
12	Filip	Konfederak	fkonfederak.fk@gmail.com	siemanko	2
13	Filip	Ziomek	konfederakf@gmail.com	siemanko	2
3	Mateusz	Kościński	matkos037@gmail.com	atrakcje	2
14	bfb	fn	mmg@gmk.com	abc	2
15	Mateusz2	Kościński2	mati2@gmail.com	numer2	2
16	Filip	Konfederak	123@gmail.com	123	2
17	123	321	dominik-kudla2@wp.pl	1	2
18	zsuetaM	iksńicśoK	mail@gmail.com	qwerty	2
\.


--
-- TOC entry 3528 (class 0 OID 24662)
-- Dependencies: 224
-- Data for Name: Zdjęcia; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public."Zdjęcia" ("ID_Zdjęcie", "ID_Miejsce", "ID_Recenzja", "URL") FROM stdin;
1	1	\N	https://upload.wikimedia.org/wikipedia/commons/7/7c/Rezerwat_piek%C5%82o_ko%C5%82o_niek%C5%82ania.jpg
2	2	\N	https://www.zlotaproporcja.pl/wp-content/uploads/2021/05/KLADKA_SLIWNO-WANIEWO_PODLASIE-6636.jpg
13	3	\N	https://forty.pl/wp-content/uploads/2021/12/najwieksza-003.jpg
14	4	\N	https://images.immediate.co.uk/production/volatile/sites/63/2025/02/shutterstock1875942445-1-d97de6c.jpg
19	5	\N	https://upload.wikimedia.org/wikipedia/commons/1/17/Widok_pa%C5%82acu_w_Kopicach_od_g%C5%82%C3%B3wnego_wjazdu.jpg
20	8	\N	https://polskazachwyca.pl/wp-content/uploads/2017/12/zamek-w-%C5%82a%C5%84cucie-shutterstock_211646971.jpg
21	9	\N	https://cdn.podroze.smcloud.net/t/photos/t/144659/park-grodek-w-jaworznie_1138486.jpg
24	12	\N	https://osrodekbolko.pl/wp-content/uploads/2014/05/kaplica-1.jpg
25	14	\N	https://u.profitroom.pl/2017.hoteldana.pl/thumb/1024x768/uploads/krzywy-las-hotel-szczecin.jpeg
26	15	\N	https://krainakarkonoszy.pl/wp-content/uploads/2015/12/kolorowe-jeziorka-4.jpg
27	26	\N	https://www.agroturystykaforteca.eu/wp-content/uploads/2017/11/riese.jpg
28	28	\N	https://www.wagrowiec.eu/assets/images/dzialy/ciekawe-miejsca/skrzyzowanie-rzek/skrzyzowanie-rzek-2-hdr.jpg
29	29	\N	https://upload.wikimedia.org/wikipedia/commons/e/e1/Magiczne_ogrody_panorama_dron_2018_krasnoludzki_grod_i_wodny_swiat.jpg
30	30	\N	https://lwowecki.info/wp-content/uploads/2024/04/Kraina-Wygaslych-Wulkanow-3.jpg
31	31	\N	https://polska-org.pl/foto/3196/Krzywa_Wieza_ul_Wojciecha_sw_Zabkowice_Slaskie_3196367.jpg
32	32	\N	https://www.ahojprzygodo.com/wp-content/uploads/2023/01/221210_karpacz_muzeum_lego_173605-scaled.jpg
33	37	\N	https://siechnice.com.pl/thumbs/900x525c/2025-02/20250215-153854-1-.jpg
34	39	\N	https://kasai.eu/wp-content/uploads/2020/07/Opolskie-kasai.eu-7971.jpg
35	38	\N	/media/zdjecia/38_avatar.jpg
37	44	\N	https://thumbs.dreamstime.com/b/kot-kawaii-%C5%9Bmieszny-ma%C5%82y-kotek-z-r%C3%B3%C5%BCowymi-paskami-anime-u%C5%9Bmiechni%C4%99ty-styl-czaruj%C4%85cy-fantasy-manga-uroczy-wektor-sztuka-185023999.jpg
\.


--
-- TOC entry 3536 (class 0 OID 65572)
-- Dependencies: 232
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- TOC entry 3538 (class 0 OID 65580)
-- Dependencies: 234
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- TOC entry 3534 (class 0 OID 65566)
-- Dependencies: 230
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add historia wyszukiwan	7	add_historiawyszukiwan
26	Can change historia wyszukiwan	7	change_historiawyszukiwan
27	Can delete historia wyszukiwan	7	delete_historiawyszukiwan
28	Can view historia wyszukiwan	7	view_historiawyszukiwan
29	Can add kategoria	8	add_kategoria
30	Can change kategoria	8	change_kategoria
31	Can delete kategoria	8	delete_kategoria
32	Can view kategoria	8	view_kategoria
33	Can add miejsce	9	add_miejsce
34	Can change miejsce	9	change_miejsce
35	Can delete miejsce	9	delete_miejsce
36	Can view miejsce	9	view_miejsce
37	Can add recenzja	10	add_recenzja
38	Can change recenzja	10	change_recenzja
39	Can delete recenzja	10	delete_recenzja
40	Can view recenzja	10	view_recenzja
41	Can add region	11	add_region
42	Can change region	11	change_region
43	Can delete region	11	delete_region
44	Can view region	11	view_region
45	Can add uprawnienia	12	add_uprawnienia
46	Can change uprawnienia	12	change_uprawnienia
47	Can delete uprawnienia	12	delete_uprawnienia
48	Can view uprawnienia	12	view_uprawnienia
49	Can add uzytkownik	13	add_uzytkownik
50	Can change uzytkownik	13	change_uzytkownik
51	Can delete uzytkownik	13	delete_uzytkownik
52	Can view uzytkownik	13	view_uzytkownik
53	Can add zdjęcia	14	add_zdjęcia
54	Can change zdjęcia	14	change_zdjęcia
55	Can delete zdjęcia	14	delete_zdjęcia
56	Can view zdjęcia	14	view_zdjęcia
57	Can add Ranking	15	add_ranking
58	Can change Ranking	15	change_ranking
59	Can delete Ranking	15	delete_ranking
60	Can view Ranking	15	view_ranking
\.


--
-- TOC entry 3540 (class 0 OID 65586)
-- Dependencies: 236
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$1000000$0SUWrd8Qi9hwZtHXxx2v6i$ec7B2Ju2vD3Eq871Q840+eamZoKZBCZ5zYSlm6hx92s=	\N	t	tester				t	t	2025-05-19 19:21:58+00
3	pbkdf2_sha256$1000000$2UbIXMxt0U2VzJGhobhL85$Rrd9Z71rtYaZib5SBaULMzycucGOdkLp4OY9KDGtAu0=	2025-05-24 23:31:12.117583+00	t	testet			mkumiega@onet.eu	t	t	2025-05-19 19:30:33.116815+00
4	pbkdf2_sha256$1000000$QDKcWS7AllJNLrox3LOHte$SwGg9Oqzzn49hA7isXMVnNa8Sy8oabnmA2hzMbMJD48=	2025-06-03 15:49:37.594316+00	t	Felipe			fkonfederak.fk@gmail.com	t	t	2025-06-03 15:49:29.527176+00
1	pbkdf2_sha256$1000000$eslmLLihTAFeb042wlDbsb$81yUYTTKCKddA2ieOdlfWuRFXQHeaLGHHAkPeDp84lY=	2025-06-03 17:58:58.838365+00	t	dominik			dominik-kudla1@wp.pl	t	t	2025-05-19 19:18:49+00
\.


--
-- TOC entry 3542 (class 0 OID 65594)
-- Dependencies: 238
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- TOC entry 3544 (class 0 OID 65600)
-- Dependencies: 240
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
1	1	25
2	1	26
3	1	27
4	1	28
\.


--
-- TOC entry 3546 (class 0 OID 65658)
-- Dependencies: 242
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2025-05-19 19:21:59.180012+00	2	tester	1	[{"added": {}}]	4	1
2	2025-05-19 19:22:25.86957+00	2	tester	2	[{"changed": {"fields": ["Staff status", "Superuser status"]}}]	4	1
3	2025-05-24 23:39:55.052371+00	31	Bufet mydło	2	[]	9	3
4	2025-05-26 19:13:07.167685+00	41	Obiekt Testowy	3		9	3
5	2025-05-26 19:13:50.368619+00	1	Best of the best	1	[{"added": {}}]	15	3
6	2025-05-26 19:14:32.561136+00	40	Rynek	3		9	3
7	2025-05-26 20:24:03.23814+00	2	Mydlany ranking	1	[{"added": {}}]	15	3
8	2025-06-02 16:25:09.349401+00	1	dominik	2	[{"changed": {"fields": ["User permissions"]}}]	4	1
9	2025-06-03 15:50:42.180375+00	1	Best of the best	2	[{"changed": {"fields": ["Miejsca"]}}]	15	4
10	2025-06-03 15:51:55.526807+00	1	Best of the best	2	[{"changed": {"fields": ["Miejsca"]}}]	15	4
11	2025-06-03 15:54:35.887195+00	3	Fajny ranking	1	[{"added": {}}]	15	4
12	2025-06-03 16:24:27.751895+00	4	TOP 5 Ogólnie	1	[{"added": {}}]	15	4
13	2025-06-03 16:28:20.964373+00	5	Ukryte perełki Polski	1	[{"added": {}}]	15	4
14	2025-06-03 16:31:38.009663+00	6	Idealne na weekend	1	[{"added": {}}]	15	4
15	2025-06-03 16:32:39.007642+00	7	Ranking rodzinny	1	[{"added": {}}]	15	4
16	2025-06-03 16:33:11.38541+00	8	Ranking ekstremalny	1	[{"added": {}}]	15	4
17	2025-06-03 16:33:44.371819+00	9	Najpiękniejsze widoki	1	[{"added": {}}]	15	4
18	2025-06-03 16:34:08.193563+00	9	Najpiękniejsze widoki	2	[]	15	4
19	2025-06-03 16:34:44.429577+00	10	Zabytki i historia	1	[{"added": {}}]	15	4
20	2025-06-03 16:35:13.928719+00	11	Top atrakcje Dolnego Śląska	1	[{"added": {}}]	15	4
21	2025-06-03 16:36:17.445081+00	11	Top atrakcje Dolnego Śląska	2	[{"changed": {"fields": ["Miejsca"]}}]	15	4
22	2025-06-03 16:37:57.207537+00	12	Romantyczne miejsca	1	[{"added": {}}]	15	4
23	2025-06-03 16:38:37.49036+00	1	Best of the best	3		15	4
24	2025-06-03 16:38:51.439899+00	2	Mydlany ranking	3		15	4
25	2025-06-03 16:39:03.549635+00	3	Fajny ranking	3		15	4
26	2025-06-03 16:39:47.355168+00	4	TOP 5 Ogólnie	2	[{"changed": {"fields": ["Miejsca"]}}]	15	4
\.


--
-- TOC entry 3532 (class 0 OID 65558)
-- Dependencies: 228
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	app	historiawyszukiwan
8	app	kategoria
9	app	miejsce
10	app	recenzja
11	app	region
12	app	uprawnienia
13	app	uzytkownik
14	app	zdjęcia
15	app	ranking
\.


--
-- TOC entry 3530 (class 0 OID 65550)
-- Dependencies: 226
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2025-05-03 05:20:19.093048+00
2	auth	0001_initial	2025-05-03 05:20:20.200839+00
3	admin	0001_initial	2025-05-03 05:20:20.520872+00
4	admin	0002_logentry_remove_auto_add	2025-05-03 05:20:20.632088+00
5	admin	0003_logentry_add_action_flag_choices	2025-05-03 05:20:20.784034+00
6	app	0001_use_existing_tables	2025-05-03 05:31:02.917274+00
8	contenttypes	0002_remove_content_type_name	2025-05-03 05:37:24.053638+00
9	auth	0002_alter_permission_name_max_length	2025-05-03 05:37:24.232593+00
10	auth	0003_alter_user_email_max_length	2025-05-03 05:37:24.415894+00
11	auth	0004_alter_user_username_opts	2025-05-03 05:37:24.56089+00
12	auth	0005_alter_user_last_login_null	2025-05-03 05:37:24.737369+00
13	auth	0006_require_contenttypes_0002	2025-05-03 05:37:24.871558+00
14	auth	0007_alter_validators_add_error_messages	2025-05-03 05:37:25.021091+00
15	auth	0008_alter_user_username_max_length	2025-05-03 05:37:25.214027+00
16	auth	0009_alter_user_last_name_max_length	2025-05-03 05:37:25.401815+00
17	auth	0010_alter_group_name_max_length	2025-05-03 05:37:25.59023+00
18	auth	0011_update_proxy_permissions	2025-05-03 05:37:25.74099+00
19	auth	0012_alter_user_first_name_max_length	2025-05-03 05:37:25.928407+00
20	sessions	0001_initial	2025-05-03 05:37:26.217887+00
22	app	0001_initial	2025-05-25 00:01:47.615368+00
23	app	0002_ranking_alter_miejsce_options	2025-05-25 00:01:47.731448+00
24	app	0003_alter_ranking_options	2025-05-25 00:14:46.888759+00
\.


--
-- TOC entry 3547 (class 0 OID 65693)
-- Dependencies: 243
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
8rq7vbuqs4o3b53jyisu79kuny2t7hlu	eyJ1enl0a293bmlrX2lkIjoxfQ:1uEI7n:4DXbXEXLbJbZ2ezIZjVDgmZpElJxcgP6NosqYvqTde4	2025-05-26 01:38:35.197492+00
g4it2a544i7dcx318prqzqkujat6slov	eyJ1enl0a293bmlrX2lkIjoxMH0:1uEYkz:MoFMZf-APV1Ghenk0aXIbp57hOzRWebyilKX72eGa7I	2025-05-26 19:24:09.833476+00
d2wkcn7fnak1r6ntbmw2rp2ldehj5i6o	e30:1uEZhH:mSaKbFarQVvRuN-Fpm3ATvTIreHKIwuDEJBK3iwvBcQ	2025-05-26 20:24:23.831482+00
u6muuxjj85aywhb4hecm6jn5notufr7x	eyJ1enl0a293bmlrX2lkIjoxMH0:1uFBkT:sb0lo26JsYeIVlbp1XkNoV3BdlFe2gIFO6DKqBUEpqY	2025-05-28 13:02:13.98597+00
0876aozoq5xlv9jk624pemyl7ballo9p	e30:1uFIrc:gwPqSAmdRE2rTnUNrpbflgsVCJk2KcV0DCSVbvfmyOQ	2025-05-28 20:38:04.613122+00
w70ka2z7dx9jlk8xmukymuxl05fi1htm	eyJ1enl0a293bmlrX2lkIjoxMn0:1uGEwn:P6tZuV3E9FJB8Ccj-ADBlt_ku6DYpns0fjQvABD0las	2025-05-31 10:39:17.116759+00
6jc9dmclavs7pdlzopzv008jvrjxujta	e30:1uGI1v:2qP0Wa8b9-Z3CkvZA-JdVdLn_jWeuv0LbX2lpAHfUsw	2025-05-31 13:56:47.11709+00
z4vn4bt6s4hmz6zerpi8c04x6vm7t8hk	e30:1uGIN6:xQym8lD7vmtMMBa_QOmmvjz2Em0nISuYvfc6fQaxIHM	2025-05-31 14:18:40.30394+00
hyvsa4csc1u1owd0rar4wjy3anrvlz4r	eyJ1enl0a293bmlrX2lkIjoxMH0:1uGJHn:67zSBrar0UQ7La2eN2qs2Hbsg8xI9aQgqr6QkY7Tcds	2025-05-31 15:17:15.508307+00
c8ov1t0ivc7dizgzf8roi2jshkl4lhqp	eyJ1enl0a293bmlrX2lkIjoxfQ:1uGbQV:YX7QNkIK3eU16EnsM7ZDFaF1FT0zA0-e6qIbWKAHDHo	2025-06-01 10:39:27.913082+00
714csznou3u40j7619bjvkgiblfzhl6x	.eJxVjkEOwiAURO_C2hDgF0pduu8Zms8HbK2BpLQxary7YrrQ7byZl3myAbd1HLYSlmHy7MgkO_xmDmkOqQJ_wXTOnHJal8nxWuE7LbzPPlxPe_dPMGIZP2sKVkkF2FovtCLROfLKyEjaqQgOog2kGiAQ3qKMAGi17LQmI9C0TZVuj_s651ua5u9TKV5vTHs-ZA:1uIQGx:YrdvZGO5eU3DSKlaDjfyi17FIks-cFNjOrGQp4ClnQc	2025-06-06 11:09:07.591618+00
9uiaknbkt4dcn1v2t74096w7kc7thdmy	.eJxVjMsOgjAQRf9l1qahA0zBpXu_gUyZQbCmTXjEqPHfBcOG7Tnn3g8s79cc0jMOoRkEzjY7QcPL3DfLpOMfQQ4H5rkNGjchd463ZNoU53HwZkvMbidzTaKPy94eDnqe-nXtucCcao8duy6zYrkjJGpLK0hFhZqpZdTaScVUELkyJ6lWjSTkvcL3B5mkPkc:1uIyKe:IoHkXe708vFZUVfcfA4BFQ3rKiMLh5KWrE09sxKs5Bw	2025-06-07 23:31:12.166649+00
rivuwnu73oxvv7tazokgi9dutxlnegw0	eyJ1enl0a293bmlrX2lkIjoxNn0:1uJB6e:6Jnl6wnnLOEhWqLVyjorjCXKgDVs72gUWKiigEGScQI	2025-06-08 13:09:36.659643+00
v1gb9rbua127f3zrapldv7ndbu90cgs4	eyJ1enl0a293bmlrX2lkIjoxNn0:1uJFC2:087Z0Uhm0VRzLuZQSOpRI3aF9tu29yJFkHZtK-1E-p8	2025-06-08 17:31:26.562863+00
b048krfrz7rmbjmrgtj4og4afl1e5qpw	eyJ1enl0a293bmlrX2lkIjoxMH0:1uJRuF:mbU_66Qimyd8zYxnQFmqzvPzsKU6lXUccN9DI-Zivco	2025-06-09 07:05:55.423675+00
j0gf5wks1r6di1op0tvvxvcyilfpawr9	.eJxVjkEOwiAURO_C2hDgF0pduu8Zms8HbK2BpLQxary7YrrQ7byZl3myAbd1HLYSlmHy7MgkO_xmDmkOqQJ_wXTOnHJal8nxWuE7LbzPPlxPe_dPMGIZP2sKVkkF2FovtCLROfLKyEjaqQgOog2kGiAQ3qKMAGi17LQmI9C0TZVuj_s651ua5u9TKV5vTHs-ZA:1uJyEo:_E4ifkaVFhXfezuKeb9N2RrgHlkHi1-G25PeO87-E40	2025-06-10 17:37:18.619484+00
xzymc5ey0vrbyy1oxtnryrkfawlncvu4	eyJ1enl0a293bmlrX2lkIjoxMH0:1uLpQl:EFUyY-lyC5PI1NVO0WmMtV-dJz5dB55CooHuwMmgHHE	2025-06-15 20:37:19.957836+00
yn2hf7yjv0dd1z96qy0obknibhkwbrsq	eyJ1enl0a293bmlrX2lkIjoxfQ:1uLr1n:-Mdx863PU2jIftwCjzM95JbkPQzXZfWT4G84Sboh0s0	2025-06-15 22:19:39.260869+00
y18fnsa2emnbsi4uc0zgajcefcfhneuw	.eJxVjsEOgjAQRP-lZ9N0uxSKR-98A9luW0FMm1CIUeO_K4aDXufNvMxT9LQuQ7-WMPejF0cB4vCbOeIppA34C6VzlpzTMo9ObhW50yK77MP1tHf_BAOV4bPmYDVopMZ6ZTSr1rHXNUQ2Tkd0GG1gXSGj8pYgIpI10BrDtaK6qTbp-rgvU76lcfo-BXi9AUx9PmU:1uMAUx:0GLbeYVUmj60094SvLjLoVdWuCNNrt4gp7nsPr-3fqQ	2025-06-16 19:07:03.425783+00
xyc40th457zq9q4ji8jjeibxp801uv00	e30:1uMBVf:U8AMQ9J4YY2xuy5ntW-YM6HqEHbHCQOvV-ehkUHBolI	2025-06-16 20:11:51.085115+00
zerfa3psgao8s860y9ojuj6fy035c5mm	.eJxVjssOgjAURP-la9MUSi_g0r3fQNr7EMS0CYUYNf67YFjods6ZybxU55e575bMUzeQOqpKHX6z4HHkuAG6-nhJGlOcpyHoTdE7zfqciG-n3f0b6H3u17YIW2taL7UYMgFdBQ1wS6YkhhoLJmNKgwIYqHBkZdW8cIOIAM7ZdXR5PuYx3eMwfp8W8P4Ajv0_yg:1uMTwC:DpQvGywQN6V-NIvFAKQEwQ0gKeFCLM3cV0lKAF53L40	2025-06-17 15:52:28.04729+00
0ls2sbapd7nkg5ncynvpirf3hpopedcg	.eJxVjEEOgjAQRe_StWnaDoXi0j1nINOZVhDTJhRi1Hh3xbBh-977_y3W13OZ8iONUz-yOGt1Ej2uy9CvJcx_JLQ4MI80hbQJvmG6Zkk5LfPo5ZbI3RbZZQ73y94eDgYsw29NwRltABvHyhpSrSc2tY5kvYngIbpApgICxQ51BEBndWst1QrrpmLx-QKi1D5k:1uMVuc:a_z3C0hY3ZI3A-lX02YIM1EMIAQnKSkKhQSIKjwIHU4	2025-06-17 17:58:58.870164+00
\.


--
-- TOC entry 3525 (class 0 OID 24611)
-- Dependencies: 221
-- Data for Name: historia_wyszukiwan; Type: TABLE DATA; Schema: public; Owner: inzynieria_owner
--

COPY public.historia_wyszukiwan ("ID_Historia", "ID_Użytkownik", "Data_wyszukiwania", "ID_Miejsce") FROM stdin;
1	3	2025-05-23 09:50:23.019859+00	14
2	3	2025-05-23 09:51:52.778522+00	8
3	3	2025-05-23 10:04:15.86165+00	12
4	10	2025-05-23 11:06:18.329395+00	1
5	10	2025-05-23 11:06:28.895011+00	3
6	10	2025-05-23 11:16:05.46893+00	14
7	3	2025-05-23 12:21:28.025877+00	1
8	1	2025-05-24 16:34:21.32896+00	15
9	1	2025-05-24 17:33:43.245836+00	26
10	10	2025-05-24 19:15:58.624356+00	1
11	10	2025-05-24 19:16:01.800106+00	1
12	10	2025-05-24 19:18:37.831489+00	12
13	10	2025-05-24 19:19:02.782009+00	1
14	10	2025-05-24 19:43:37.942426+00	4
15	10	2025-05-24 19:49:02.158794+00	4
16	10	2025-05-24 19:51:05.683497+00	4
17	10	2025-05-24 19:51:12.19892+00	8
18	10	2025-05-24 19:51:25.31945+00	8
19	10	2025-05-24 19:54:18.426893+00	8
20	10	2025-05-24 19:55:33.503691+00	8
21	10	2025-05-24 19:56:49.593477+00	8
22	10	2025-05-24 19:57:09.205325+00	1
23	10	2025-05-24 19:58:54.358969+00	1
24	10	2025-05-24 19:59:26.507757+00	1
25	10	2025-05-24 19:59:53.027981+00	1
26	10	2025-05-24 19:59:55.512296+00	1
27	10	2025-05-24 20:00:17.228862+00	1
28	10	2025-05-24 23:03:47.285123+00	31
29	10	2025-05-24 23:03:50.178424+00	31
30	10	2025-05-25 11:01:16.10761+00	8
31	10	2025-05-25 11:02:45.414704+00	1
32	10	2025-05-25 11:03:01.681998+00	15
33	10	2025-05-25 11:03:12.353245+00	26
34	10	2025-05-25 11:03:16.830711+00	15
35	10	2025-05-25 11:03:18.86866+00	26
36	10	2025-05-25 11:04:04.006859+00	26
37	10	2025-05-25 11:04:37.415538+00	26
38	10	2025-05-25 11:05:45.329759+00	26
39	10	2025-05-25 11:06:23.219397+00	26
40	10	2025-05-25 11:06:33.022202+00	26
41	10	2025-05-25 11:06:34.361922+00	26
42	1	2025-05-25 11:38:22.677195+00	37
43	1	2025-05-25 11:38:28.99191+00	37
44	1	2025-05-25 11:38:34.510274+00	37
45	1	2025-05-25 11:38:40.931966+00	32
46	10	2025-05-25 11:59:08.949116+00	38
47	10	2025-05-25 12:05:46.710902+00	38
48	10	2025-05-25 12:13:51.059342+00	38
49	1	2025-05-25 12:15:58.189434+00	1
50	10	2025-05-25 12:16:16.290315+00	38
51	10	2025-05-25 12:16:31.573921+00	1
52	10	2025-05-25 12:16:41.169745+00	14
53	10	2025-05-25 12:21:44.78231+00	14
54	10	2025-05-25 12:22:34.837427+00	14
55	10	2025-05-25 12:23:05.710528+00	14
56	10	2025-05-25 12:25:58.780112+00	14
57	10	2025-05-25 12:32:06.680348+00	9
58	10	2025-05-25 12:32:11.451774+00	14
59	10	2025-05-25 12:32:17.541227+00	14
60	10	2025-05-25 12:32:46.882398+00	14
61	10	2025-05-25 12:33:04.980035+00	14
62	10	2025-05-25 12:33:35.168781+00	14
63	10	2025-05-25 12:33:53.603698+00	14
64	10	2025-05-25 12:34:28.210429+00	14
65	10	2025-05-25 12:35:56.081511+00	14
66	10	2025-05-25 12:35:59.756591+00	14
67	10	2025-05-25 12:36:01.633732+00	14
68	10	2025-05-25 12:36:53.660961+00	14
69	10	2025-05-25 12:39:17.022785+00	14
70	10	2025-05-25 12:39:53.277591+00	2
71	10	2025-05-25 12:40:09.512786+00	38
72	10	2025-05-25 12:40:35.200098+00	38
73	10	2025-05-25 12:42:42.685327+00	38
74	10	2025-05-25 12:43:31.979466+00	38
75	10	2025-05-25 12:43:39.439853+00	38
76	10	2025-05-25 12:44:29.194513+00	38
77	10	2025-05-25 12:48:09.324607+00	2
78	10	2025-05-25 12:48:16.329903+00	26
79	10	2025-05-25 12:54:03.567121+00	1
80	10	2025-05-25 12:54:34.454024+00	1
81	10	2025-05-25 12:54:41.010989+00	14
82	10	2025-05-25 12:54:51.862957+00	38
83	10	2025-05-25 12:56:20.496164+00	38
84	10	2025-05-25 12:56:55.079162+00	38
85	10	2025-05-25 12:59:39.419312+00	38
86	10	2025-05-25 13:02:21.901248+00	38
87	10	2025-05-25 13:02:36.402523+00	38
88	16	2025-05-25 13:09:45.866319+00	38
89	16	2025-05-25 13:20:23.804619+00	38
90	10	2025-05-25 13:23:08.95677+00	38
91	16	2025-05-25 13:26:21.769168+00	38
92	10	2025-05-25 13:38:41.180068+00	1
93	10	2025-05-25 16:38:09.213355+00	26
94	10	2025-05-25 16:38:21.109666+00	26
95	10	2025-05-25 18:06:48.401782+00	1
96	10	2025-05-25 18:06:58.451677+00	1
97	10	2025-05-25 18:07:12.152464+00	38
98	10	2025-05-25 18:07:26.142611+00	38
99	10	2025-05-25 18:11:35.903969+00	1
100	10	2025-05-25 18:11:39.757331+00	1
101	10	2025-05-25 18:11:41.008716+00	1
102	10	2025-05-25 18:12:00.243256+00	1
103	10	2025-05-25 18:12:38.713251+00	38
104	10	2025-05-25 18:13:20.942899+00	38
105	10	2025-05-25 18:13:49.485576+00	38
106	10	2025-05-25 18:15:36.57374+00	38
107	10	2025-05-25 18:15:43.651364+00	38
108	10	2025-05-25 18:16:01.472548+00	1
109	10	2025-05-25 18:16:11.333638+00	1
110	10	2025-05-25 18:16:23.35816+00	1
111	10	2025-05-25 18:16:44.115596+00	38
112	10	2025-05-25 18:21:38.579754+00	38
113	10	2025-05-25 18:22:16.074139+00	38
114	10	2025-05-25 18:22:23.317578+00	38
115	10	2025-05-25 18:22:49.735693+00	38
116	10	2025-05-25 18:23:09.641912+00	38
117	10	2025-05-25 18:23:44.562921+00	38
118	10	2025-05-25 18:23:51.561901+00	38
119	10	2025-05-25 18:25:31.865558+00	38
120	10	2025-05-25 18:26:45.624625+00	38
121	10	2025-05-25 18:27:07.325571+00	38
122	10	2025-05-25 18:27:14.258795+00	38
123	10	2025-05-25 18:27:28.93262+00	38
124	10	2025-05-25 18:27:31.044127+00	38
125	10	2025-05-25 18:28:06.746164+00	38
126	10	2025-05-25 18:28:27.278864+00	38
127	10	2025-05-25 18:28:40.065876+00	38
128	10	2025-05-25 18:29:23.418677+00	38
129	10	2025-05-25 18:29:35.73352+00	38
130	10	2025-05-25 18:29:45.258792+00	38
131	10	2025-05-25 18:32:07.342101+00	38
132	10	2025-05-25 18:32:34.836245+00	38
133	10	2025-05-25 18:32:59.186927+00	38
134	10	2025-05-25 18:33:27.287103+00	38
135	10	2025-05-25 18:36:12.641365+00	38
136	10	2025-05-25 18:36:38.258321+00	38
137	10	2025-05-25 18:36:46.214067+00	38
138	10	2025-05-25 18:36:58.014006+00	38
139	10	2025-05-25 18:37:19.37475+00	38
140	10	2025-05-25 18:37:35.877696+00	38
141	10	2025-05-25 18:37:42.399357+00	38
142	10	2025-05-25 18:40:06.456493+00	38
143	10	2025-05-25 18:41:26.358086+00	38
144	10	2025-05-25 18:41:28.51661+00	38
145	10	2025-05-25 18:41:35.952193+00	38
146	10	2025-05-25 18:41:54.297056+00	38
147	10	2025-05-25 18:42:15.237628+00	38
148	10	2025-05-25 18:42:45.198142+00	38
149	10	2025-05-25 18:43:03.881306+00	38
150	10	2025-05-25 18:43:21.46998+00	38
151	10	2025-05-25 18:44:23.025603+00	38
152	10	2025-05-25 18:45:11.259652+00	38
153	10	2025-05-25 18:45:30.538178+00	38
154	10	2025-05-25 18:45:43.170501+00	38
155	10	2025-05-25 18:45:49.225201+00	38
156	10	2025-05-25 18:48:15.880193+00	38
157	10	2025-05-25 18:48:44.521673+00	38
158	10	2025-05-25 18:49:28.974378+00	38
159	10	2025-05-25 18:51:16.674166+00	38
160	10	2025-05-25 18:54:15.911693+00	38
161	10	2025-05-25 18:54:29.765829+00	38
162	10	2025-05-25 18:55:38.460391+00	38
163	10	2025-05-25 18:55:40.755133+00	38
164	10	2025-05-25 18:55:45.573007+00	38
165	10	2025-05-25 18:55:54.062503+00	38
166	10	2025-05-25 18:56:01.589118+00	38
167	10	2025-05-25 18:56:19.149771+00	38
168	10	2025-05-25 18:56:25.855128+00	38
169	10	2025-05-25 18:56:45.620944+00	38
170	10	2025-05-25 18:57:05.128361+00	38
171	10	2025-05-25 18:58:06.075298+00	38
172	10	2025-05-25 19:00:30.212039+00	38
173	10	2025-05-25 19:00:43.990792+00	38
174	10	2025-05-25 19:00:45.964378+00	38
175	10	2025-05-25 19:16:38.109342+00	38
176	10	2025-05-25 19:28:30.037951+00	38
177	10	2025-05-25 19:28:57.909779+00	38
178	10	2025-05-25 19:29:06.432679+00	38
179	10	2025-05-25 19:37:20.24477+00	1
180	10	2025-05-25 19:37:27.15729+00	38
181	15	2025-05-25 19:41:24.458745+00	38
182	15	2025-05-25 19:41:53.073465+00	38
183	10	2025-05-25 19:43:54.911519+00	1
184	10	2025-05-25 19:44:00.951313+00	1
185	10	2025-05-25 19:44:12.755547+00	38
186	10	2025-05-25 19:44:30.178079+00	38
187	10	2025-05-25 19:50:56.844722+00	1
188	10	2025-05-25 19:51:45.989982+00	14
189	10	2025-05-25 19:52:06.935758+00	14
190	10	2025-05-25 21:24:25.710995+00	39
191	10	2025-05-25 21:25:18.437727+00	39
192	10	2025-05-25 21:25:42.745829+00	39
193	10	2025-05-25 21:28:31.238375+00	39
194	11	2025-05-25 21:45:51.311964+00	1
195	11	2025-05-25 21:46:00.30852+00	2
196	11	2025-05-25 21:46:13.525458+00	14
197	10	2025-05-25 22:25:52.023292+00	39
198	11	2025-05-25 22:27:17.707648+00	1
199	10	2025-05-26 06:47:53.049148+00	39
200	11	2025-05-26 07:07:06.685228+00	14
204	10	2025-05-26 07:12:21.899045+00	38
205	11	2025-05-26 07:12:34.039712+00	38
206	11	2025-05-26 07:13:05.897813+00	38
207	10	2025-05-26 07:13:20.963439+00	38
208	10	2025-05-26 07:13:37.478906+00	38
209	11	2025-05-26 07:13:48.647013+00	38
214	10	2025-05-26 18:18:54.938378+00	1
215	10	2025-05-26 18:19:20.133967+00	1
216	10	2025-05-26 18:26:21.45327+00	8
217	10	2025-05-26 18:26:39.124922+00	8
218	10	2025-05-26 18:27:05.396065+00	1
219	10	2025-05-26 18:27:12.46943+00	38
220	10	2025-05-26 18:29:02.544125+00	14
221	15	2025-05-26 18:30:03.928155+00	38
222	15	2025-05-26 18:30:19.780025+00	38
232	10	2025-05-27 17:37:24.9711+00	5
233	10	2025-05-27 17:37:30.383229+00	5
234	10	2025-05-27 18:52:03.201985+00	38
235	10	2025-05-27 18:53:26.358806+00	31
236	10	2025-05-30 21:04:39.741043+00	38
237	10	2025-05-30 21:04:50.324464+00	38
238	10	2025-06-01 21:43:29.95442+00	29
239	10	2025-06-01 21:43:54.675116+00	38
240	10	2025-06-01 21:44:19.541907+00	15
241	10	2025-06-01 21:44:29.826074+00	1
242	10	2025-06-01 21:44:33.179686+00	2
243	10	2025-06-01 21:44:35.858557+00	26
244	10	2025-06-01 21:45:06.97937+00	38
245	10	2025-06-01 21:51:17.714588+00	38
246	10	2025-06-01 21:51:21.693479+00	38
247	10	2025-06-01 21:51:24.022429+00	38
248	10	2025-06-01 21:51:26.172347+00	38
249	10	2025-06-01 22:00:01.87174+00	38
250	10	2025-06-01 22:00:08.213519+00	38
251	10	2025-06-01 22:00:10.503291+00	38
252	10	2025-06-01 22:00:52.830211+00	38
253	10	2025-06-01 22:01:01.073257+00	38
254	10	2025-06-01 22:01:10.521656+00	38
255	10	2025-06-01 22:01:16.508797+00	38
256	10	2025-06-01 22:02:04.35054+00	38
257	10	2025-06-01 22:02:25.417975+00	38
258	10	2025-06-01 22:02:37.526058+00	38
259	10	2025-06-01 22:06:56.808511+00	38
260	10	2025-06-01 22:07:00.106313+00	38
261	10	2025-06-01 22:07:26.12813+00	38
262	10	2025-06-01 22:07:32.796696+00	1
263	10	2025-06-01 22:07:44.922814+00	38
264	10	2025-06-01 22:07:46.53513+00	38
265	10	2025-06-01 22:08:20.424297+00	1
266	10	2025-06-01 22:08:26.332634+00	1
267	10	2025-06-02 06:48:18.273448+00	2
268	11	2025-06-02 06:54:07.515377+00	38
269	11	2025-06-02 06:54:21.589+00	38
270	11	2025-06-02 06:54:28.093489+00	38
271	11	2025-06-02 06:55:17.663233+00	38
272	11	2025-06-02 06:56:25.395975+00	38
273	11	2025-06-02 07:21:44.622692+00	44
274	11	2025-06-02 07:22:28.004547+00	44
275	11	2025-06-02 07:23:00.722894+00	44
277	18	2025-06-02 18:38:26.844107+00	38
278	18	2025-06-02 18:38:41.811375+00	38
279	18	2025-06-02 18:38:53.322667+00	38
280	18	2025-06-02 18:39:11.129882+00	1
281	1	2025-06-02 19:20:21.844576+00	15
282	1	2025-06-02 19:20:32.210326+00	2
283	16	2025-06-03 15:52:36.847006+00	32
284	16	2025-06-03 15:52:49.627249+00	32
285	16	2025-06-03 15:53:08.834346+00	31
286	16	2025-06-03 15:53:18.116929+00	31
287	16	2025-06-03 15:53:24.906935+00	31
288	16	2025-06-03 15:53:31.266928+00	31
289	16	2025-06-03 15:53:39.72712+00	31
290	16	2025-06-03 15:53:53.86722+00	31
291	16	2025-06-03 15:54:02.417464+00	31
292	16	2025-06-03 15:54:09.056894+00	31
293	10	2025-06-03 17:52:57.914485+00	26
294	10	2025-06-03 17:58:11.388325+00	26
295	10	2025-06-03 17:58:32.065245+00	26
296	10	2025-06-03 23:44:38.151999+00	37
\.


--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 245
-- Name: Miejsce_ID_Miejsce_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public."Miejsce_ID_Miejsce_seq"', 65, true);


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 250
-- Name: Ranking_ID_Ranking_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public."Ranking_ID_Ranking_seq"', 12, true);


--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 252
-- Name: Ranking_Miejsca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public."Ranking_Miejsca_id_seq"', 63, true);


--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 246
-- Name: Recenzja_ID_Recenzja_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public."Recenzja_ID_Recenzja_seq"', 70, true);


--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 247
-- Name: Użytkownik_ID_Użytkownik_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public."Użytkownik_ID_Użytkownik_seq"', 18, true);


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 248
-- Name: Zdjęcia_ID_Zdjęcie_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public."Zdjęcia_ID_Zdjęcie_seq"', 49, true);


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 231
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 233
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 229
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 60, true);


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 237
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 235
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 4, true);


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 239
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 4, true);


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 241
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 26, true);


--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 227
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 15, true);


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 225
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 24, true);


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 244
-- Name: historia_wyszukiwan_ID_Historia_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public."historia_wyszukiwan_ID_Historia_seq"', 296, true);


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 249
-- Name: miejsce_id_seq; Type: SEQUENCE SET; Schema: public; Owner: inzynieria_owner
--

SELECT pg_catalog.setval('public.miejsce_id_seq', 27, false);


--
-- TOC entry 3295 (class 2606 OID 24615)
-- Name: historia_wyszukiwan Historia wyszukiwań_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.historia_wyszukiwan
    ADD CONSTRAINT "Historia wyszukiwań_pkey" PRIMARY KEY ("ID_Historia");


--
-- TOC entry 3287 (class 2606 OID 24589)
-- Name: Kategoria Kategoria_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Kategoria"
    ADD CONSTRAINT "Kategoria_pkey" PRIMARY KEY ("ID_Kategoria");


--
-- TOC entry 3299 (class 2606 OID 24646)
-- Name: Miejsce Miejsce_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Miejsce"
    ADD CONSTRAINT "Miejsce_pkey" PRIMARY KEY ("ID_Miejsce");


--
-- TOC entry 3352 (class 2606 OID 114730)
-- Name: Ranking_Miejsca Ranking_Miejsca_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Ranking_Miejsca"
    ADD CONSTRAINT "Ranking_Miejsca_pkey" PRIMARY KEY (id);


--
-- TOC entry 3354 (class 2606 OID 114732)
-- Name: Ranking_Miejsca Ranking_Miejsca_ranking_id_miejsce_id_key; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Ranking_Miejsca"
    ADD CONSTRAINT "Ranking_Miejsca_ranking_id_miejsce_id_key" UNIQUE (ranking_id, miejsce_id);


--
-- TOC entry 3350 (class 2606 OID 114722)
-- Name: Ranking Ranking_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Ranking"
    ADD CONSTRAINT "Ranking_pkey" PRIMARY KEY ("ID_Ranking");


--
-- TOC entry 3297 (class 2606 OID 24627)
-- Name: Recenzja Recenzja_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Recenzja"
    ADD CONSTRAINT "Recenzja_pkey" PRIMARY KEY ("ID_Recenzja");


--
-- TOC entry 3289 (class 2606 OID 24596)
-- Name: Region Region_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Region"
    ADD CONSTRAINT "Region_pkey" PRIMARY KEY ("ID_Regionu");


--
-- TOC entry 3285 (class 2606 OID 24582)
-- Name: Uprawnienia Uprawnienia_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Uprawnienia"
    ADD CONSTRAINT "Uprawnienia_pkey" PRIMARY KEY ("ID_Uprawnienia");


--
-- TOC entry 3291 (class 2606 OID 24605)
-- Name: Użytkownik Użytkownik_Mail_key; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Użytkownik"
    ADD CONSTRAINT "Użytkownik_Mail_key" UNIQUE ("Mail");


--
-- TOC entry 3293 (class 2606 OID 24603)
-- Name: Użytkownik Użytkownik_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Użytkownik"
    ADD CONSTRAINT "Użytkownik_pkey" PRIMARY KEY ("ID_Użytkownik");


--
-- TOC entry 3301 (class 2606 OID 24668)
-- Name: Zdjęcia Zdjęcia_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Zdjęcia"
    ADD CONSTRAINT "Zdjęcia_pkey" PRIMARY KEY ("ID_Zdjęcie");


--
-- TOC entry 3315 (class 2606 OID 65691)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 3320 (class 2606 OID 65615)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 3323 (class 2606 OID 65584)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3317 (class 2606 OID 65576)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3310 (class 2606 OID 65606)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 3312 (class 2606 OID 65570)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3331 (class 2606 OID 65598)
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3334 (class 2606 OID 65630)
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 3325 (class 2606 OID 65590)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 3337 (class 2606 OID 65604)
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3340 (class 2606 OID 65644)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 3328 (class 2606 OID 65686)
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 3343 (class 2606 OID 65665)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3305 (class 2606 OID 65564)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 3307 (class 2606 OID 65562)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3303 (class 2606 OID 65556)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3347 (class 2606 OID 65699)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 3313 (class 1259 OID 65692)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 3318 (class 1259 OID 65626)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 3321 (class 1259 OID 65627)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 3308 (class 1259 OID 65612)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 3329 (class 1259 OID 65642)
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- TOC entry 3332 (class 1259 OID 65641)
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- TOC entry 3335 (class 1259 OID 65656)
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 3338 (class 1259 OID 65655)
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 3326 (class 1259 OID 65687)
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 3341 (class 1259 OID 65676)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 3344 (class 1259 OID 65677)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 3345 (class 1259 OID 65701)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 3348 (class 1259 OID 65700)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 3356 (class 2606 OID 24679)
-- Name: historia_wyszukiwan Historia wyszukiwań_ID_Miejsce_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.historia_wyszukiwan
    ADD CONSTRAINT "Historia wyszukiwań_ID_Miejsce_fkey" FOREIGN KEY ("ID_Miejsce") REFERENCES public."Miejsce"("ID_Miejsce") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3357 (class 2606 OID 24616)
-- Name: historia_wyszukiwan Historia wyszukiwań_ID_Użytkownik_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.historia_wyszukiwan
    ADD CONSTRAINT "Historia wyszukiwań_ID_Użytkownik_fkey" FOREIGN KEY ("ID_Użytkownik") REFERENCES public."Użytkownik"("ID_Użytkownik") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3360 (class 2606 OID 24652)
-- Name: Miejsce Miejsce_ID_Kategoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Miejsce"
    ADD CONSTRAINT "Miejsce_ID_Kategoria_fkey" FOREIGN KEY ("ID_Kategoria") REFERENCES public."Kategoria"("ID_Kategoria") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3361 (class 2606 OID 24647)
-- Name: Miejsce Miejsce_ID_Region_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Miejsce"
    ADD CONSTRAINT "Miejsce_ID_Region_fkey" FOREIGN KEY ("ID_Region") REFERENCES public."Region"("ID_Regionu") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3362 (class 2606 OID 24657)
-- Name: Miejsce Miejsce_ID_Użytkownik_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Miejsce"
    ADD CONSTRAINT "Miejsce_ID_Użytkownik_fkey" FOREIGN KEY ("ID_Użytkownik") REFERENCES public."Użytkownik"("ID_Użytkownik") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3374 (class 2606 OID 114738)
-- Name: Ranking_Miejsca Ranking_Miejsca_miejsce_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Ranking_Miejsca"
    ADD CONSTRAINT "Ranking_Miejsca_miejsce_id_fkey" FOREIGN KEY (miejsce_id) REFERENCES public."Miejsce"("ID_Miejsce") ON DELETE CASCADE;


--
-- TOC entry 3375 (class 2606 OID 114733)
-- Name: Ranking_Miejsca Ranking_Miejsca_ranking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Ranking_Miejsca"
    ADD CONSTRAINT "Ranking_Miejsca_ranking_id_fkey" FOREIGN KEY (ranking_id) REFERENCES public."Ranking"("ID_Ranking") ON DELETE CASCADE;


--
-- TOC entry 3358 (class 2606 OID 24694)
-- Name: Recenzja Recenzja_ID_Miejsce_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Recenzja"
    ADD CONSTRAINT "Recenzja_ID_Miejsce_fkey" FOREIGN KEY ("ID_Miejsce") REFERENCES public."Miejsce"("ID_Miejsce") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3359 (class 2606 OID 24628)
-- Name: Recenzja Recenzja_ID_Użytkownik_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Recenzja"
    ADD CONSTRAINT "Recenzja_ID_Użytkownik_fkey" FOREIGN KEY ("ID_Użytkownik") REFERENCES public."Użytkownik"("ID_Użytkownik") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3355 (class 2606 OID 24606)
-- Name: Użytkownik Użytkownik_ID_Uprawnienia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Użytkownik"
    ADD CONSTRAINT "Użytkownik_ID_Uprawnienia_fkey" FOREIGN KEY ("ID_Uprawnienia") REFERENCES public."Uprawnienia"("ID_Uprawnienia") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3363 (class 2606 OID 24669)
-- Name: Zdjęcia Zdjęcia_ID_Miejsce_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Zdjęcia"
    ADD CONSTRAINT "Zdjęcia_ID_Miejsce_fkey" FOREIGN KEY ("ID_Miejsce") REFERENCES public."Miejsce"("ID_Miejsce") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3364 (class 2606 OID 24674)
-- Name: Zdjęcia Zdjęcia_ID_Recenzja_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Zdjęcia"
    ADD CONSTRAINT "Zdjęcia_ID_Recenzja_fkey" FOREIGN KEY ("ID_Recenzja") REFERENCES public."Recenzja"("ID_Recenzja") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3366 (class 2606 OID 65621)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3367 (class 2606 OID 65616)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3365 (class 2606 OID 65607)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3368 (class 2606 OID 65636)
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3369 (class 2606 OID 65631)
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3370 (class 2606 OID 65650)
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3371 (class 2606 OID 65645)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3372 (class 2606 OID 65666)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3373 (class 2606 OID 65671)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2137 (class 826 OID 16392)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- TOC entry 2136 (class 826 OID 16391)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


-- Completed on 2025-06-04 22:49:43

--
-- PostgreSQL database dump complete
--

