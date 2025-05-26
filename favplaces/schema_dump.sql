--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-05-26 21:08:22

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
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 249
-- Name: miejsce_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: inzynieria_owner
--

ALTER SEQUENCE public.miejsce_id_seq OWNED BY public."Miejsce"."ID_Miejsce";


--
-- TOC entry 3282 (class 2606 OID 24615)
-- Name: historia_wyszukiwan Historia wyszukiwań_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.historia_wyszukiwan
    ADD CONSTRAINT "Historia wyszukiwań_pkey" PRIMARY KEY ("ID_Historia");


--
-- TOC entry 3274 (class 2606 OID 24589)
-- Name: Kategoria Kategoria_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Kategoria"
    ADD CONSTRAINT "Kategoria_pkey" PRIMARY KEY ("ID_Kategoria");


--
-- TOC entry 3286 (class 2606 OID 24646)
-- Name: Miejsce Miejsce_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Miejsce"
    ADD CONSTRAINT "Miejsce_pkey" PRIMARY KEY ("ID_Miejsce");


--
-- TOC entry 3284 (class 2606 OID 24627)
-- Name: Recenzja Recenzja_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Recenzja"
    ADD CONSTRAINT "Recenzja_pkey" PRIMARY KEY ("ID_Recenzja");


--
-- TOC entry 3276 (class 2606 OID 24596)
-- Name: Region Region_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Region"
    ADD CONSTRAINT "Region_pkey" PRIMARY KEY ("ID_Regionu");


--
-- TOC entry 3272 (class 2606 OID 24582)
-- Name: Uprawnienia Uprawnienia_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Uprawnienia"
    ADD CONSTRAINT "Uprawnienia_pkey" PRIMARY KEY ("ID_Uprawnienia");


--
-- TOC entry 3278 (class 2606 OID 24605)
-- Name: Użytkownik Użytkownik_Mail_key; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Użytkownik"
    ADD CONSTRAINT "Użytkownik_Mail_key" UNIQUE ("Mail");


--
-- TOC entry 3280 (class 2606 OID 24603)
-- Name: Użytkownik Użytkownik_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Użytkownik"
    ADD CONSTRAINT "Użytkownik_pkey" PRIMARY KEY ("ID_Użytkownik");


--
-- TOC entry 3288 (class 2606 OID 24668)
-- Name: Zdjęcia Zdjęcia_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Zdjęcia"
    ADD CONSTRAINT "Zdjęcia_pkey" PRIMARY KEY ("ID_Zdjęcie");


--
-- TOC entry 3302 (class 2606 OID 65691)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 3307 (class 2606 OID 65615)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 3310 (class 2606 OID 65584)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3304 (class 2606 OID 65576)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3297 (class 2606 OID 65606)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 3299 (class 2606 OID 65570)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3318 (class 2606 OID 65598)
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3321 (class 2606 OID 65630)
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 3312 (class 2606 OID 65590)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 3324 (class 2606 OID 65604)
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3327 (class 2606 OID 65644)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 3315 (class 2606 OID 65686)
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 3330 (class 2606 OID 65665)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3292 (class 2606 OID 65564)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 3294 (class 2606 OID 65562)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3290 (class 2606 OID 65556)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3334 (class 2606 OID 65699)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 3300 (class 1259 OID 65692)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 3305 (class 1259 OID 65626)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 3308 (class 1259 OID 65627)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 3295 (class 1259 OID 65612)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 3316 (class 1259 OID 65642)
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- TOC entry 3319 (class 1259 OID 65641)
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- TOC entry 3322 (class 1259 OID 65656)
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 3325 (class 1259 OID 65655)
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 3313 (class 1259 OID 65687)
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 3328 (class 1259 OID 65676)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 3331 (class 1259 OID 65677)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 3332 (class 1259 OID 65701)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 3335 (class 1259 OID 65700)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: inzynieria_owner
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 3337 (class 2606 OID 24679)
-- Name: historia_wyszukiwan Historia wyszukiwań_ID_Miejsce_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.historia_wyszukiwan
    ADD CONSTRAINT "Historia wyszukiwań_ID_Miejsce_fkey" FOREIGN KEY ("ID_Miejsce") REFERENCES public."Miejsce"("ID_Miejsce") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3338 (class 2606 OID 24616)
-- Name: historia_wyszukiwan Historia wyszukiwań_ID_Użytkownik_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.historia_wyszukiwan
    ADD CONSTRAINT "Historia wyszukiwań_ID_Użytkownik_fkey" FOREIGN KEY ("ID_Użytkownik") REFERENCES public."Użytkownik"("ID_Użytkownik") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3341 (class 2606 OID 24652)
-- Name: Miejsce Miejsce_ID_Kategoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Miejsce"
    ADD CONSTRAINT "Miejsce_ID_Kategoria_fkey" FOREIGN KEY ("ID_Kategoria") REFERENCES public."Kategoria"("ID_Kategoria") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3342 (class 2606 OID 24647)
-- Name: Miejsce Miejsce_ID_Region_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Miejsce"
    ADD CONSTRAINT "Miejsce_ID_Region_fkey" FOREIGN KEY ("ID_Region") REFERENCES public."Region"("ID_Regionu") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3343 (class 2606 OID 24657)
-- Name: Miejsce Miejsce_ID_Użytkownik_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Miejsce"
    ADD CONSTRAINT "Miejsce_ID_Użytkownik_fkey" FOREIGN KEY ("ID_Użytkownik") REFERENCES public."Użytkownik"("ID_Użytkownik") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3339 (class 2606 OID 24694)
-- Name: Recenzja Recenzja_ID_Miejsce_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Recenzja"
    ADD CONSTRAINT "Recenzja_ID_Miejsce_fkey" FOREIGN KEY ("ID_Miejsce") REFERENCES public."Miejsce"("ID_Miejsce") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3340 (class 2606 OID 24628)
-- Name: Recenzja Recenzja_ID_Użytkownik_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Recenzja"
    ADD CONSTRAINT "Recenzja_ID_Użytkownik_fkey" FOREIGN KEY ("ID_Użytkownik") REFERENCES public."Użytkownik"("ID_Użytkownik") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3336 (class 2606 OID 24606)
-- Name: Użytkownik Użytkownik_ID_Uprawnienia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Użytkownik"
    ADD CONSTRAINT "Użytkownik_ID_Uprawnienia_fkey" FOREIGN KEY ("ID_Uprawnienia") REFERENCES public."Uprawnienia"("ID_Uprawnienia") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3344 (class 2606 OID 24669)
-- Name: Zdjęcia Zdjęcia_ID_Miejsce_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Zdjęcia"
    ADD CONSTRAINT "Zdjęcia_ID_Miejsce_fkey" FOREIGN KEY ("ID_Miejsce") REFERENCES public."Miejsce"("ID_Miejsce") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3345 (class 2606 OID 24674)
-- Name: Zdjęcia Zdjęcia_ID_Recenzja_fkey; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public."Zdjęcia"
    ADD CONSTRAINT "Zdjęcia_ID_Recenzja_fkey" FOREIGN KEY ("ID_Recenzja") REFERENCES public."Recenzja"("ID_Recenzja") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3347 (class 2606 OID 65621)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3348 (class 2606 OID 65616)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3346 (class 2606 OID 65607)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3349 (class 2606 OID 65636)
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3350 (class 2606 OID 65631)
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3351 (class 2606 OID 65650)
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3352 (class 2606 OID 65645)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3353 (class 2606 OID 65666)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3354 (class 2606 OID 65671)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: inzynieria_owner
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2127 (class 826 OID 16392)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- TOC entry 2126 (class 826 OID 16391)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


-- Completed on 2025-05-26 21:08:25

--
-- PostgreSQL database dump complete
--

