--
-- PostgreSQL database cluster dump
--

-- Started on 2026-10-27 16:24:50

\restrict GMY4tYzFJ3mNxG7eXsRVYZMUkd0JilI3KrakNRx90LqQ26yixZ9NQOddYCeavxn

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE "IvanovN";
ALTER ROLE "IvanovN" WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:G/0RJSMgtgVvfAT5E33Ypw==$zPiYx5NRNDEy70l40rrr6Y8d8aqXQsX8+xfurR3dCOI=:fjTg4bm66UJqG+qLeITA4PnmftahXLTQasdzeURgX00=';

--
-- User Configurations
--








\unrestrict GMY4tYzFJ3mNxG7eXsRVYZMUkd0JilI3KrakNRx90LqQ26yixZ9NQOddYCeavxn

--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

\restrict Jy0wxJLKoYNOU1LteCNXthsx5oegAppHXvmEGAw0Rr37C2xPQ1uqUKTnTHd14f2

-- Dumped from database version 18.6 (Debian 18.6-1.pgdg13+2)
-- Dumped by pg_dump version 18.4

-- Started on 2026-10-27 16:24:50

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

-- Completed on 2026-10-27 16:24:50

--
-- PostgreSQL database dump complete
--

\unrestrict Jy0wxJLKoYNOU1LteCNXthsx5oegAppHXvmEGAw0Rr37C2xPQ1uqUKTnTHd14f2

--
-- Database "PraktikaIvanov" dump
--

--
-- PostgreSQL database dump
--

\restrict uCGNLGyViUZMcJQ7cltL4iBcFcAp5lrBfLpHToFaE99qbb4JUTmCpdcFPp220m7

-- Dumped from database version 18.6 (Debian 18.6-1.pgdg13+2)
-- Dumped by pg_dump version 18.4

-- Started on 2026-10-27 16:24:50

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

--
-- TOC entry 3560 (class 1262 OID 16384)
-- Name: PraktikaIvanov; Type: DATABASE; Schema: -; Owner: IvanovN
--

CREATE DATABASE "PraktikaIvanov" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE "PraktikaIvanov" OWNER TO "IvanovN";

\unrestrict uCGNLGyViUZMcJQ7cltL4iBcFcAp5lrBfLpHToFaE99qbb4JUTmCpdcFPp220m7
\connect "PraktikaIvanov"
\restrict uCGNLGyViUZMcJQ7cltL4iBcFcAp5lrBfLpHToFaE99qbb4JUTmCpdcFPp220m7

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

--
-- TOC entry 915 (class 1247 OID 16597)
-- Name: d_comment; Type: DOMAIN; Schema: public; Owner: IvanovN
--

CREATE DOMAIN public.d_comment AS character varying(300)
	CONSTRAINT ck_comment_not_empty CHECK ((length(TRIM(BOTH FROM VALUE)) > 0));


ALTER DOMAIN public.d_comment OWNER TO "IvanovN";

--
-- TOC entry 919 (class 1247 OID 16600)
-- Name: d_date; Type: DOMAIN; Schema: public; Owner: IvanovN
--

CREATE DOMAIN public.d_date AS date
	CONSTRAINT ck_date_min CHECK ((VALUE >= '2020-01-01'::date));


ALTER DOMAIN public.d_date OWNER TO "IvanovN";

--
-- TOC entry 895 (class 1247 OID 16582)
-- Name: d_email; Type: DOMAIN; Schema: public; Owner: IvanovN
--

CREATE DOMAIN public.d_email AS character varying(100)
	CONSTRAINT ck_email_format CHECK (((VALUE)::text ~ '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]+$'::text));


ALTER DOMAIN public.d_email OWNER TO "IvanovN";

--
-- TOC entry 891 (class 1247 OID 16579)
-- Name: d_login; Type: DOMAIN; Schema: public; Owner: IvanovN
--

CREATE DOMAIN public.d_login AS character varying(50)
	CONSTRAINT ck_login_format CHECK (((VALUE)::text ~ '^[A-Za-z0-9_]{3,50}$'::text));


ALTER DOMAIN public.d_login OWNER TO "IvanovN";

--
-- TOC entry 899 (class 1247 OID 16585)
-- Name: d_password_hash; Type: DOMAIN; Schema: public; Owner: IvanovN
--

CREATE DOMAIN public.d_password_hash AS character varying(200)
	CONSTRAINT ck_hash_format CHECK (((VALUE)::text ~ '^[0-9A-F]{64}$'::text));


ALTER DOMAIN public.d_password_hash OWNER TO "IvanovN";

--
-- TOC entry 903 (class 1247 OID 16588)
-- Name: d_person_name; Type: DOMAIN; Schema: public; Owner: IvanovN
--

CREATE DOMAIN public.d_person_name AS character varying(100)
	CONSTRAINT ck_person_name_len CHECK ((length(TRIM(BOTH FROM VALUE)) >= 2));


ALTER DOMAIN public.d_person_name OWNER TO "IvanovN";

--
-- TOC entry 911 (class 1247 OID 16594)
-- Name: d_text; Type: DOMAIN; Schema: public; Owner: IvanovN
--

CREATE DOMAIN public.d_text AS character varying(500)
	CONSTRAINT ck_text_not_empty CHECK ((length(TRIM(BOTH FROM VALUE)) > 0));


ALTER DOMAIN public.d_text OWNER TO "IvanovN";

--
-- TOC entry 907 (class 1247 OID 16591)
-- Name: d_title; Type: DOMAIN; Schema: public; Owner: IvanovN
--

CREATE DOMAIN public.d_title AS character varying(100)
	CONSTRAINT ck_title_not_empty CHECK ((length(TRIM(BOTH FROM VALUE)) > 0));


ALTER DOMAIN public.d_title OWNER TO "IvanovN";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16389)
-- Name: roles; Type: TABLE; Schema: public; Owner: IvanovN
--

CREATE TABLE public.roles (
    role_id integer CONSTRAINT "IvanovN_role_id_not_null" NOT NULL,
    role_name character varying(30) CONSTRAINT "IvanovN_role_name_not_null" NOT NULL
);


ALTER TABLE public.roles OWNER TO "IvanovN";

--
-- TOC entry 220 (class 1259 OID 16392)
-- Name: IvanovN_role_id_seq; Type: SEQUENCE; Schema: public; Owner: IvanovN
--

CREATE SEQUENCE public."IvanovN_role_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."IvanovN_role_id_seq" OWNER TO "IvanovN";

--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 220
-- Name: IvanovN_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: IvanovN
--

ALTER SEQUENCE public."IvanovN_role_id_seq" OWNED BY public.roles.role_id;


--
-- TOC entry 228 (class 1259 OID 16429)
-- Name: users; Type: TABLE; Schema: public; Owner: IvanovN
--

CREATE TABLE public.users (
    user_id integer CONSTRAINT "Name_name_id_not_null" NOT NULL,
    login public.d_login CONSTRAINT "Name_login_not_null" NOT NULL,
    password_hash public.d_password_hash CONSTRAINT "Name_password_hash_not_null" NOT NULL,
    full_name public.d_person_name CONSTRAINT "Name_full_name_not_null" NOT NULL,
    email public.d_email CONSTRAINT "Name_email_not_null" NOT NULL,
    registered_at public.d_date DEFAULT CURRENT_DATE CONSTRAINT "Name_registered_at_not_null" NOT NULL,
    role_id integer CONSTRAINT "Name_role_id_not_null" NOT NULL
);


ALTER TABLE public.users OWNER TO "IvanovN";

--
-- TOC entry 227 (class 1259 OID 16428)
-- Name: Name_name_id_seq; Type: SEQUENCE; Schema: public; Owner: IvanovN
--

CREATE SEQUENCE public."Name_name_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Name_name_id_seq" OWNER TO "IvanovN";

--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 227
-- Name: Name_name_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: IvanovN
--

ALTER SEQUENCE public."Name_name_id_seq" OWNED BY public.users.user_id;


--
-- TOC entry 222 (class 1259 OID 16402)
-- Name: categories; Type: TABLE; Schema: public; Owner: IvanovN
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name character varying(50) CONSTRAINT categories_categoty_name_not_null NOT NULL
);


ALTER TABLE public.categories OWNER TO "IvanovN";

--
-- TOC entry 221 (class 1259 OID 16401)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: IvanovN
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_category_id_seq OWNER TO "IvanovN";

--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 221
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: IvanovN
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- TOC entry 224 (class 1259 OID 16411)
-- Name: frequencies; Type: TABLE; Schema: public; Owner: IvanovN
--

CREATE TABLE public.frequencies (
    frequency_id integer NOT NULL,
    frequency_name character varying(50) NOT NULL
);


ALTER TABLE public.frequencies OWNER TO "IvanovN";

--
-- TOC entry 223 (class 1259 OID 16410)
-- Name: frequencies_frequency_id_seq; Type: SEQUENCE; Schema: public; Owner: IvanovN
--

CREATE SEQUENCE public.frequencies_frequency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.frequencies_frequency_id_seq OWNER TO "IvanovN";

--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 223
-- Name: frequencies_frequency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: IvanovN
--

ALTER SEQUENCE public.frequencies_frequency_id_seq OWNED BY public.frequencies.frequency_id;


--
-- TOC entry 232 (class 1259 OID 16480)
-- Name: habit_logs; Type: TABLE; Schema: public; Owner: IvanovN
--

CREATE TABLE public.habit_logs (
    log_id integer CONSTRAINT habit_log_log_id_not_null NOT NULL,
    habit_id integer CONSTRAINT habit_log_habit_id_not_null NOT NULL,
    log_date public.d_date CONSTRAINT habit_log_lag_date_not_null NOT NULL,
    is_done boolean DEFAULT false CONSTRAINT habit_log_is_done_not_null NOT NULL
);


ALTER TABLE public.habit_logs OWNER TO "IvanovN";

--
-- TOC entry 231 (class 1259 OID 16479)
-- Name: habit_log_log_id_seq; Type: SEQUENCE; Schema: public; Owner: IvanovN
--

CREATE SEQUENCE public.habit_log_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.habit_log_log_id_seq OWNER TO "IvanovN";

--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 231
-- Name: habit_log_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: IvanovN
--

ALTER SEQUENCE public.habit_log_log_id_seq OWNED BY public.habit_logs.log_id;


--
-- TOC entry 234 (class 1259 OID 16499)
-- Name: habit_requests; Type: TABLE; Schema: public; Owner: IvanovN
--

CREATE TABLE public.habit_requests (
    request_id integer NOT NULL,
    author_id integer,
    manager_id integer,
    status_id integer,
    name public.d_title,
    description public.d_text,
    submitted_at public.d_date DEFAULT CURRENT_DATE,
    manager_comment public.d_comment
);


ALTER TABLE public.habit_requests OWNER TO "IvanovN";

--
-- TOC entry 233 (class 1259 OID 16498)
-- Name: habit_requests_request_id_seq; Type: SEQUENCE; Schema: public; Owner: IvanovN
--

CREATE SEQUENCE public.habit_requests_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.habit_requests_request_id_seq OWNER TO "IvanovN";

--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 233
-- Name: habit_requests_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: IvanovN
--

ALTER SEQUENCE public.habit_requests_request_id_seq OWNED BY public.habit_requests.request_id;


--
-- TOC entry 230 (class 1259 OID 16449)
-- Name: habits; Type: TABLE; Schema: public; Owner: IvanovN
--

CREATE TABLE public.habits (
    habit_id integer NOT NULL,
    user_id integer NOT NULL,
    category_id integer NOT NULL,
    frequency_id integer NOT NULL,
    name public.d_title NOT NULL,
    description public.d_text,
    start_date public.d_date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.habits OWNER TO "IvanovN";

--
-- TOC entry 229 (class 1259 OID 16448)
-- Name: habits_habit_id_seq; Type: SEQUENCE; Schema: public; Owner: IvanovN
--

CREATE SEQUENCE public.habits_habit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.habits_habit_id_seq OWNER TO "IvanovN";

--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 229
-- Name: habits_habit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: IvanovN
--

ALTER SEQUENCE public.habits_habit_id_seq OWNED BY public.habits.habit_id;


--
-- TOC entry 226 (class 1259 OID 16420)
-- Name: request_statuses; Type: TABLE; Schema: public; Owner: IvanovN
--

CREATE TABLE public.request_statuses (
    status_id integer NOT NULL,
    status_name character varying(30) NOT NULL
);


ALTER TABLE public.request_statuses OWNER TO "IvanovN";

--
-- TOC entry 225 (class 1259 OID 16419)
-- Name: request_statuses_status_id_seq; Type: SEQUENCE; Schema: public; Owner: IvanovN
--

CREATE SEQUENCE public.request_statuses_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.request_statuses_status_id_seq OWNER TO "IvanovN";

--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 225
-- Name: request_statuses_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: IvanovN
--

ALTER SEQUENCE public.request_statuses_status_id_seq OWNED BY public.request_statuses.status_id;


--
-- TOC entry 3357 (class 2604 OID 16405)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- TOC entry 3358 (class 2604 OID 16414)
-- Name: frequencies frequency_id; Type: DEFAULT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.frequencies ALTER COLUMN frequency_id SET DEFAULT nextval('public.frequencies_frequency_id_seq'::regclass);


--
-- TOC entry 3364 (class 2604 OID 16483)
-- Name: habit_logs log_id; Type: DEFAULT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.habit_logs ALTER COLUMN log_id SET DEFAULT nextval('public.habit_log_log_id_seq'::regclass);


--
-- TOC entry 3366 (class 2604 OID 16502)
-- Name: habit_requests request_id; Type: DEFAULT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.habit_requests ALTER COLUMN request_id SET DEFAULT nextval('public.habit_requests_request_id_seq'::regclass);


--
-- TOC entry 3362 (class 2604 OID 16452)
-- Name: habits habit_id; Type: DEFAULT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.habits ALTER COLUMN habit_id SET DEFAULT nextval('public.habits_habit_id_seq'::regclass);


--
-- TOC entry 3359 (class 2604 OID 16423)
-- Name: request_statuses status_id; Type: DEFAULT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.request_statuses ALTER COLUMN status_id SET DEFAULT nextval('public.request_statuses_status_id_seq'::regclass);


--
-- TOC entry 3356 (class 2604 OID 16393)
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public."IvanovN_role_id_seq"'::regclass);


--
-- TOC entry 3360 (class 2604 OID 16432)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public."Name_name_id_seq"'::regclass);


--
-- TOC entry 3542 (class 0 OID 16402)
-- Dependencies: 222
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: IvanovN
--

COPY public.categories (category_id, category_name) FROM stdin;
1	Здоровье
2	Спорт
3	Учёба
4	Работа
5	Отдых
\.


--
-- TOC entry 3544 (class 0 OID 16411)
-- Dependencies: 224
-- Data for Name: frequencies; Type: TABLE DATA; Schema: public; Owner: IvanovN
--

COPY public.frequencies (frequency_id, frequency_name) FROM stdin;
1	Ежедневно
2	По будням
3	Раз в неделю
\.


--
-- TOC entry 3552 (class 0 OID 16480)
-- Dependencies: 232
-- Data for Name: habit_logs; Type: TABLE DATA; Schema: public; Owner: IvanovN
--

COPY public.habit_logs (log_id, habit_id, log_date, is_done) FROM stdin;
1	1	2026-10-27	t
2	2	2026-10-27	t
3	3	2026-10-27	f
4	4	2026-10-27	t
5	5	2026-10-27	t
6	6	2026-10-27	f
7	7	2026-10-27	t
8	8	2026-10-27	t
9	9	2026-10-27	f
10	10	2026-10-27	t
11	11	2026-10-27	t
12	12	2026-10-27	f
13	13	2026-10-27	t
14	14	2026-10-27	t
15	15	2026-10-27	f
16	16	2026-10-27	t
17	17	2026-10-27	t
18	18	2026-10-27	f
19	19	2026-10-27	t
20	20	2026-10-27	t
21	21	2026-10-27	f
22	22	2026-10-27	t
23	23	2026-10-27	t
24	24	2026-10-27	f
25	25	2026-10-27	t
26	26	2026-10-27	t
27	27	2026-10-27	f
28	28	2026-10-27	t
29	29	2026-10-27	t
30	30	2026-10-27	f
31	31	2026-10-27	t
32	32	2026-10-27	t
33	33	2026-10-27	f
34	34	2026-10-27	t
35	35	2026-10-27	t
36	36	2026-10-27	f
37	37	2026-10-27	t
38	38	2026-10-27	t
39	39	2026-10-27	f
40	40	2026-10-27	t
41	41	2026-10-27	t
42	42	2026-10-27	f
43	43	2026-10-27	t
44	44	2026-10-27	t
45	45	2026-10-27	f
46	46	2026-10-27	t
47	47	2026-10-27	t
48	48	2026-10-27	f
49	49	2026-10-27	t
50	50	2026-10-27	t
51	51	2026-10-27	f
52	52	2026-10-27	t
53	53	2026-10-27	t
54	54	2026-10-27	f
55	55	2026-10-27	t
56	56	2026-10-27	t
57	57	2026-10-27	f
58	58	2026-10-27	t
59	59	2026-10-27	t
60	60	2026-10-27	f
61	61	2026-10-27	t
62	62	2026-10-27	t
63	63	2026-10-27	f
64	64	2026-10-27	t
65	65	2026-10-27	t
66	66	2026-10-27	f
67	67	2026-10-27	t
68	68	2026-10-27	t
69	69	2026-10-27	f
70	70	2026-10-27	t
71	71	2026-10-27	t
72	72	2026-10-27	f
73	73	2026-10-27	t
74	74	2026-10-27	t
75	75	2026-10-27	f
76	76	2026-10-27	t
77	77	2026-10-27	t
78	78	2026-10-27	f
79	79	2026-10-27	t
80	80	2026-10-27	t
81	81	2026-10-27	f
82	82	2026-10-27	t
83	83	2026-10-27	t
84	84	2026-10-27	f
85	85	2026-10-27	t
86	86	2026-10-27	t
87	87	2026-10-27	f
88	88	2026-10-27	t
89	89	2026-10-27	t
90	90	2026-10-27	f
91	91	2026-10-27	t
92	92	2026-10-27	t
93	93	2026-10-27	f
94	94	2026-10-27	t
95	95	2026-10-27	t
96	96	2026-10-27	f
97	97	2026-10-27	t
98	98	2026-10-27	t
99	99	2026-10-27	f
100	100	2026-10-27	t
101	101	2026-10-27	t
102	102	2026-10-27	f
103	103	2026-10-27	t
104	104	2026-10-27	t
105	105	2026-10-27	f
106	106	2026-10-27	t
107	107	2026-10-27	t
108	108	2026-10-27	f
109	109	2026-10-27	t
110	110	2026-10-27	t
111	111	2026-10-27	f
112	112	2026-10-27	t
113	113	2026-10-27	t
114	114	2026-10-27	f
115	115	2026-10-27	t
116	116	2026-10-27	t
117	117	2026-10-27	f
118	118	2026-10-27	t
119	119	2026-10-27	t
120	120	2026-10-27	f
121	121	2026-10-27	t
122	122	2026-10-27	t
123	123	2026-10-27	f
124	124	2026-10-27	t
125	125	2026-10-27	t
126	126	2026-10-27	f
127	127	2026-10-27	t
128	128	2026-10-27	t
129	129	2026-10-27	f
130	130	2026-10-27	t
131	131	2026-10-27	t
132	132	2026-10-27	f
133	133	2026-10-27	t
134	134	2026-10-27	t
135	135	2026-10-27	f
136	136	2026-10-27	t
137	137	2026-10-27	t
138	138	2026-10-27	f
139	139	2026-10-27	t
140	140	2026-10-27	t
141	141	2026-10-27	f
142	142	2026-10-27	t
143	143	2026-10-27	t
144	144	2026-10-27	f
145	145	2026-10-27	t
146	146	2026-10-27	t
147	147	2026-10-27	f
148	148	2026-10-27	t
149	149	2026-10-27	t
150	150	2026-10-27	f
151	1	2026-10-26	t
152	2	2026-10-26	f
153	3	2026-10-26	t
154	4	2026-10-26	t
155	5	2026-10-26	f
156	6	2026-10-26	t
157	7	2026-10-26	t
158	8	2026-10-26	f
159	9	2026-10-26	t
160	10	2026-10-26	t
161	11	2026-10-26	f
162	12	2026-10-26	t
163	13	2026-10-26	t
164	14	2026-10-26	f
165	15	2026-10-26	t
166	16	2026-10-26	t
167	17	2026-10-26	f
168	18	2026-10-26	t
169	19	2026-10-26	t
170	20	2026-10-26	f
171	21	2026-10-26	t
172	22	2026-10-26	t
173	23	2026-10-26	f
174	24	2026-10-26	t
175	25	2026-10-26	t
176	26	2026-10-26	f
177	27	2026-10-26	t
178	28	2026-10-26	t
179	29	2026-10-26	f
180	30	2026-10-26	t
181	31	2026-10-26	t
182	32	2026-10-26	f
183	33	2026-10-26	t
184	34	2026-10-26	t
185	35	2026-10-26	f
186	36	2026-10-26	t
187	37	2026-10-26	t
188	38	2026-10-26	f
189	39	2026-10-26	t
190	40	2026-10-26	t
191	41	2026-10-26	f
192	42	2026-10-26	t
193	43	2026-10-26	t
194	44	2026-10-26	f
195	45	2026-10-26	t
196	46	2026-10-26	t
197	47	2026-10-26	f
198	48	2026-10-26	t
199	49	2026-10-26	t
200	50	2026-10-26	f
201	51	2026-10-26	t
202	52	2026-10-26	t
203	53	2026-10-26	f
204	54	2026-10-26	t
205	55	2026-10-26	t
206	56	2026-10-26	f
207	57	2026-10-26	t
208	58	2026-10-26	t
209	59	2026-10-26	f
210	60	2026-10-26	t
211	61	2026-10-26	t
212	62	2026-10-26	f
213	63	2026-10-26	t
214	64	2026-10-26	t
215	65	2026-10-26	f
216	66	2026-10-26	t
217	67	2026-10-26	t
218	68	2026-10-26	f
219	69	2026-10-26	t
220	70	2026-10-26	t
221	71	2026-10-26	f
222	72	2026-10-26	t
223	73	2026-10-26	t
224	74	2026-10-26	f
225	75	2026-10-26	t
226	76	2026-10-26	t
227	77	2026-10-26	f
228	78	2026-10-26	t
229	79	2026-10-26	t
230	80	2026-10-26	f
231	81	2026-10-26	t
232	82	2026-10-26	t
233	83	2026-10-26	f
234	84	2026-10-26	t
235	85	2026-10-26	t
236	86	2026-10-26	f
237	87	2026-10-26	t
238	88	2026-10-26	t
239	89	2026-10-26	f
240	90	2026-10-26	t
241	91	2026-10-26	t
242	92	2026-10-26	f
243	93	2026-10-26	t
244	94	2026-10-26	t
245	95	2026-10-26	f
246	96	2026-10-26	t
247	97	2026-10-26	t
248	98	2026-10-26	f
249	99	2026-10-26	t
250	100	2026-10-26	t
251	101	2026-10-26	f
252	102	2026-10-26	t
253	103	2026-10-26	t
254	104	2026-10-26	f
255	105	2026-10-26	t
256	106	2026-10-26	t
257	107	2026-10-26	f
258	108	2026-10-26	t
259	109	2026-10-26	t
260	110	2026-10-26	f
261	111	2026-10-26	t
262	112	2026-10-26	t
263	113	2026-10-26	f
264	114	2026-10-26	t
265	115	2026-10-26	t
266	116	2026-10-26	f
267	117	2026-10-26	t
268	118	2026-10-26	t
269	119	2026-10-26	f
270	120	2026-10-26	t
271	121	2026-10-26	t
272	122	2026-10-26	f
273	123	2026-10-26	t
274	124	2026-10-26	t
275	125	2026-10-26	f
276	126	2026-10-26	t
277	127	2026-10-26	t
278	128	2026-10-26	f
279	129	2026-10-26	t
280	130	2026-10-26	t
281	131	2026-10-26	f
282	132	2026-10-26	t
283	133	2026-10-26	t
284	134	2026-10-26	f
285	135	2026-10-26	t
286	136	2026-10-26	t
287	137	2026-10-26	f
288	138	2026-10-26	t
289	139	2026-10-26	t
290	140	2026-10-26	f
291	141	2026-10-26	t
292	142	2026-10-26	t
293	143	2026-10-26	f
294	144	2026-10-26	t
295	145	2026-10-26	t
296	146	2026-10-26	f
297	147	2026-10-26	t
298	148	2026-10-26	t
299	149	2026-10-26	f
300	150	2026-10-26	t
301	1	2026-10-25	f
302	2	2026-10-25	t
303	3	2026-10-25	t
304	4	2026-10-25	f
305	5	2026-10-25	t
306	6	2026-10-25	t
307	7	2026-10-25	f
308	8	2026-10-25	t
309	9	2026-10-25	t
310	10	2026-10-25	f
311	11	2026-10-25	t
312	12	2026-10-25	t
313	13	2026-10-25	f
314	14	2026-10-25	t
315	15	2026-10-25	t
316	16	2026-10-25	f
317	17	2026-10-25	t
318	18	2026-10-25	t
319	19	2026-10-25	f
320	20	2026-10-25	t
321	21	2026-10-25	t
322	22	2026-10-25	f
323	23	2026-10-25	t
324	24	2026-10-25	t
325	25	2026-10-25	f
326	26	2026-10-25	t
327	27	2026-10-25	t
328	28	2026-10-25	f
329	29	2026-10-25	t
330	30	2026-10-25	t
331	31	2026-10-25	f
332	32	2026-10-25	t
333	33	2026-10-25	t
334	34	2026-10-25	f
335	35	2026-10-25	t
336	36	2026-10-25	t
337	37	2026-10-25	f
338	38	2026-10-25	t
339	39	2026-10-25	t
340	40	2026-10-25	f
341	41	2026-10-25	t
342	42	2026-10-25	t
343	43	2026-10-25	f
344	44	2026-10-25	t
345	45	2026-10-25	t
346	46	2026-10-25	f
347	47	2026-10-25	t
348	48	2026-10-25	t
349	49	2026-10-25	f
350	50	2026-10-25	t
351	51	2026-10-25	t
352	52	2026-10-25	f
353	53	2026-10-25	t
354	54	2026-10-25	t
355	55	2026-10-25	f
356	56	2026-10-25	t
357	57	2026-10-25	t
358	58	2026-10-25	f
359	59	2026-10-25	t
360	60	2026-10-25	t
361	61	2026-10-25	f
362	62	2026-10-25	t
363	63	2026-10-25	t
364	64	2026-10-25	f
365	65	2026-10-25	t
366	66	2026-10-25	t
367	67	2026-10-25	f
368	68	2026-10-25	t
369	69	2026-10-25	t
370	70	2026-10-25	f
371	71	2026-10-25	t
372	72	2026-10-25	t
373	73	2026-10-25	f
374	74	2026-10-25	t
375	75	2026-10-25	t
376	76	2026-10-25	f
377	77	2026-10-25	t
378	78	2026-10-25	t
379	79	2026-10-25	f
380	80	2026-10-25	t
381	81	2026-10-25	t
382	82	2026-10-25	f
383	83	2026-10-25	t
384	84	2026-10-25	t
385	85	2026-10-25	f
386	86	2026-10-25	t
387	87	2026-10-25	t
388	88	2026-10-25	f
389	89	2026-10-25	t
390	90	2026-10-25	t
391	91	2026-10-25	f
392	92	2026-10-25	t
393	93	2026-10-25	t
394	94	2026-10-25	f
395	95	2026-10-25	t
396	96	2026-10-25	t
397	97	2026-10-25	f
398	98	2026-10-25	t
399	99	2026-10-25	t
400	100	2026-10-25	f
401	101	2026-10-25	t
402	102	2026-10-25	t
403	103	2026-10-25	f
404	104	2026-10-25	t
405	105	2026-10-25	t
406	106	2026-10-25	f
407	107	2026-10-25	t
408	108	2026-10-25	t
409	109	2026-10-25	f
410	110	2026-10-25	t
411	111	2026-10-25	t
412	112	2026-10-25	f
413	113	2026-10-25	t
414	114	2026-10-25	t
415	115	2026-10-25	f
416	116	2026-10-25	t
417	117	2026-10-25	t
418	118	2026-10-25	f
419	119	2026-10-25	t
420	120	2026-10-25	t
421	121	2026-10-25	f
422	122	2026-10-25	t
423	123	2026-10-25	t
424	124	2026-10-25	f
425	125	2026-10-25	t
426	126	2026-10-25	t
427	127	2026-10-25	f
428	128	2026-10-25	t
429	129	2026-10-25	t
430	130	2026-10-25	f
431	131	2026-10-25	t
432	132	2026-10-25	t
433	133	2026-10-25	f
434	134	2026-10-25	t
435	135	2026-10-25	t
436	136	2026-10-25	f
437	137	2026-10-25	t
438	138	2026-10-25	t
439	139	2026-10-25	f
440	140	2026-10-25	t
441	141	2026-10-25	t
442	142	2026-10-25	f
443	143	2026-10-25	t
444	144	2026-10-25	t
445	145	2026-10-25	f
446	146	2026-10-25	t
447	147	2026-10-25	t
448	148	2026-10-25	f
449	149	2026-10-25	t
450	150	2026-10-25	t
451	1	2026-10-24	t
452	2	2026-10-24	t
453	3	2026-10-24	f
454	4	2026-10-24	t
455	5	2026-10-24	t
456	6	2026-10-24	f
457	7	2026-10-24	t
458	8	2026-10-24	t
459	9	2026-10-24	f
460	10	2026-10-24	t
461	11	2026-10-24	t
462	12	2026-10-24	f
463	13	2026-10-24	t
464	14	2026-10-24	t
465	15	2026-10-24	f
466	16	2026-10-24	t
467	17	2026-10-24	t
468	18	2026-10-24	f
469	19	2026-10-24	t
470	20	2026-10-24	t
471	21	2026-10-24	f
472	22	2026-10-24	t
473	23	2026-10-24	t
474	24	2026-10-24	f
475	25	2026-10-24	t
476	26	2026-10-24	t
477	27	2026-10-24	f
478	28	2026-10-24	t
479	29	2026-10-24	t
480	30	2026-10-24	f
481	31	2026-10-24	t
482	32	2026-10-24	t
483	33	2026-10-24	f
484	34	2026-10-24	t
485	35	2026-10-24	t
486	36	2026-10-24	f
487	37	2026-10-24	t
488	38	2026-10-24	t
489	39	2026-10-24	f
490	40	2026-10-24	t
491	41	2026-10-24	t
492	42	2026-10-24	f
493	43	2026-10-24	t
494	44	2026-10-24	t
495	45	2026-10-24	f
496	46	2026-10-24	t
497	47	2026-10-24	t
498	48	2026-10-24	f
499	49	2026-10-24	t
500	50	2026-10-24	t
501	51	2026-10-24	f
502	52	2026-10-24	t
503	53	2026-10-24	t
504	54	2026-10-24	f
505	55	2026-10-24	t
506	56	2026-10-24	t
507	57	2026-10-24	f
508	58	2026-10-24	t
509	59	2026-10-24	t
510	60	2026-10-24	f
511	61	2026-10-24	t
512	62	2026-10-24	t
513	63	2026-10-24	f
514	64	2026-10-24	t
515	65	2026-10-24	t
516	66	2026-10-24	f
517	67	2026-10-24	t
518	68	2026-10-24	t
519	69	2026-10-24	f
520	70	2026-10-24	t
521	71	2026-10-24	t
522	72	2026-10-24	f
523	73	2026-10-24	t
524	74	2026-10-24	t
525	75	2026-10-24	f
526	76	2026-10-24	t
527	77	2026-10-24	t
528	78	2026-10-24	f
529	79	2026-10-24	t
530	80	2026-10-24	t
531	81	2026-10-24	f
532	82	2026-10-24	t
533	83	2026-10-24	t
534	84	2026-10-24	f
535	85	2026-10-24	t
536	86	2026-10-24	t
537	87	2026-10-24	f
538	88	2026-10-24	t
539	89	2026-10-24	t
540	90	2026-10-24	f
541	91	2026-10-24	t
542	92	2026-10-24	t
543	93	2026-10-24	f
544	94	2026-10-24	t
545	95	2026-10-24	t
546	96	2026-10-24	f
547	97	2026-10-24	t
548	98	2026-10-24	t
549	99	2026-10-24	f
550	100	2026-10-24	t
551	101	2026-10-24	t
552	102	2026-10-24	f
553	103	2026-10-24	t
554	104	2026-10-24	t
555	105	2026-10-24	f
556	106	2026-10-24	t
557	107	2026-10-24	t
558	108	2026-10-24	f
559	109	2026-10-24	t
560	110	2026-10-24	t
561	111	2026-10-24	f
562	112	2026-10-24	t
563	113	2026-10-24	t
564	114	2026-10-24	f
565	115	2026-10-24	t
566	116	2026-10-24	t
567	117	2026-10-24	f
568	118	2026-10-24	t
569	119	2026-10-24	t
570	120	2026-10-24	f
571	121	2026-10-24	t
572	122	2026-10-24	t
573	123	2026-10-24	f
574	124	2026-10-24	t
575	125	2026-10-24	t
576	126	2026-10-24	f
577	127	2026-10-24	t
578	128	2026-10-24	t
579	129	2026-10-24	f
580	130	2026-10-24	t
581	131	2026-10-24	t
582	132	2026-10-24	f
583	133	2026-10-24	t
584	134	2026-10-24	t
585	135	2026-10-24	f
586	136	2026-10-24	t
587	137	2026-10-24	t
588	138	2026-10-24	f
589	139	2026-10-24	t
590	140	2026-10-24	t
591	141	2026-10-24	f
592	142	2026-10-24	t
593	143	2026-10-24	t
594	144	2026-10-24	f
595	145	2026-10-24	t
596	146	2026-10-24	t
597	147	2026-10-24	f
598	148	2026-10-24	t
599	149	2026-10-24	t
600	150	2026-10-24	f
601	1	2026-10-23	t
602	2	2026-10-23	f
603	3	2026-10-23	t
604	4	2026-10-23	t
605	5	2026-10-23	f
606	6	2026-10-23	t
607	7	2026-10-23	t
608	8	2026-10-23	f
609	9	2026-10-23	t
610	10	2026-10-23	t
611	11	2026-10-23	f
612	12	2026-10-23	t
613	13	2026-10-23	t
614	14	2026-10-23	f
615	15	2026-10-23	t
616	16	2026-10-23	t
617	17	2026-10-23	f
618	18	2026-10-23	t
619	19	2026-10-23	t
620	20	2026-10-23	f
621	21	2026-10-23	t
622	22	2026-10-23	t
623	23	2026-10-23	f
624	24	2026-10-23	t
625	25	2026-10-23	t
626	26	2026-10-23	f
627	27	2026-10-23	t
628	28	2026-10-23	t
629	29	2026-10-23	f
630	30	2026-10-23	t
631	31	2026-10-23	t
632	32	2026-10-23	f
633	33	2026-10-23	t
634	34	2026-10-23	t
635	35	2026-10-23	f
636	36	2026-10-23	t
637	37	2026-10-23	t
638	38	2026-10-23	f
639	39	2026-10-23	t
640	40	2026-10-23	t
641	41	2026-10-23	f
642	42	2026-10-23	t
643	43	2026-10-23	t
644	44	2026-10-23	f
645	45	2026-10-23	t
646	46	2026-10-23	t
647	47	2026-10-23	f
648	48	2026-10-23	t
649	49	2026-10-23	t
650	50	2026-10-23	f
651	51	2026-10-23	t
652	52	2026-10-23	t
653	53	2026-10-23	f
654	54	2026-10-23	t
655	55	2026-10-23	t
656	56	2026-10-23	f
657	57	2026-10-23	t
658	58	2026-10-23	t
659	59	2026-10-23	f
660	60	2026-10-23	t
661	61	2026-10-23	t
662	62	2026-10-23	f
663	63	2026-10-23	t
664	64	2026-10-23	t
665	65	2026-10-23	f
666	66	2026-10-23	t
667	67	2026-10-23	t
668	68	2026-10-23	f
669	69	2026-10-23	t
670	70	2026-10-23	t
671	71	2026-10-23	f
672	72	2026-10-23	t
673	73	2026-10-23	t
674	74	2026-10-23	f
675	75	2026-10-23	t
676	76	2026-10-23	t
677	77	2026-10-23	f
678	78	2026-10-23	t
679	79	2026-10-23	t
680	80	2026-10-23	f
681	81	2026-10-23	t
682	82	2026-10-23	t
683	83	2026-10-23	f
684	84	2026-10-23	t
685	85	2026-10-23	t
686	86	2026-10-23	f
687	87	2026-10-23	t
688	88	2026-10-23	t
689	89	2026-10-23	f
690	90	2026-10-23	t
691	91	2026-10-23	t
692	92	2026-10-23	f
693	93	2026-10-23	t
694	94	2026-10-23	t
695	95	2026-10-23	f
696	96	2026-10-23	t
697	97	2026-10-23	t
698	98	2026-10-23	f
699	99	2026-10-23	t
700	100	2026-10-23	t
701	101	2026-10-23	f
702	102	2026-10-23	t
703	103	2026-10-23	t
704	104	2026-10-23	f
705	105	2026-10-23	t
706	106	2026-10-23	t
707	107	2026-10-23	f
708	108	2026-10-23	t
709	109	2026-10-23	t
710	110	2026-10-23	f
711	111	2026-10-23	t
712	112	2026-10-23	t
713	113	2026-10-23	f
714	114	2026-10-23	t
715	115	2026-10-23	t
716	116	2026-10-23	f
717	117	2026-10-23	t
718	118	2026-10-23	t
719	119	2026-10-23	f
720	120	2026-10-23	t
721	121	2026-10-23	t
722	122	2026-10-23	f
723	123	2026-10-23	t
724	124	2026-10-23	t
725	125	2026-10-23	f
726	126	2026-10-23	t
727	127	2026-10-23	t
728	128	2026-10-23	f
729	129	2026-10-23	t
730	130	2026-10-23	t
731	131	2026-10-23	f
732	132	2026-10-23	t
733	133	2026-10-23	t
734	134	2026-10-23	f
735	135	2026-10-23	t
736	136	2026-10-23	t
737	137	2026-10-23	f
738	138	2026-10-23	t
739	139	2026-10-23	t
740	140	2026-10-23	f
741	141	2026-10-23	t
742	142	2026-10-23	t
743	143	2026-10-23	f
744	144	2026-10-23	t
745	145	2026-10-23	t
746	146	2026-10-23	f
747	147	2026-10-23	t
748	148	2026-10-23	t
749	149	2026-10-23	f
750	150	2026-10-23	t
751	1	2026-10-22	f
752	2	2026-10-22	t
753	3	2026-10-22	t
754	4	2026-10-22	f
755	5	2026-10-22	t
756	6	2026-10-22	t
757	7	2026-10-22	f
758	8	2026-10-22	t
759	9	2026-10-22	t
760	10	2026-10-22	f
761	11	2026-10-22	t
762	12	2026-10-22	t
763	13	2026-10-22	f
764	14	2026-10-22	t
765	15	2026-10-22	t
766	16	2026-10-22	f
767	17	2026-10-22	t
768	18	2026-10-22	t
769	19	2026-10-22	f
770	20	2026-10-22	t
771	21	2026-10-22	t
772	22	2026-10-22	f
773	23	2026-10-22	t
774	24	2026-10-22	t
775	25	2026-10-22	f
776	26	2026-10-22	t
777	27	2026-10-22	t
778	28	2026-10-22	f
779	29	2026-10-22	t
780	30	2026-10-22	t
781	31	2026-10-22	f
782	32	2026-10-22	t
783	33	2026-10-22	t
784	34	2026-10-22	f
785	35	2026-10-22	t
786	36	2026-10-22	t
787	37	2026-10-22	f
788	38	2026-10-22	t
789	39	2026-10-22	t
790	40	2026-10-22	f
791	41	2026-10-22	t
792	42	2026-10-22	t
793	43	2026-10-22	f
794	44	2026-10-22	t
795	45	2026-10-22	t
796	46	2026-10-22	f
797	47	2026-10-22	t
798	48	2026-10-22	t
799	49	2026-10-22	f
800	50	2026-10-22	t
801	51	2026-10-22	t
802	52	2026-10-22	f
803	53	2026-10-22	t
804	54	2026-10-22	t
805	55	2026-10-22	f
806	56	2026-10-22	t
807	57	2026-10-22	t
808	58	2026-10-22	f
809	59	2026-10-22	t
810	60	2026-10-22	t
811	61	2026-10-22	f
812	62	2026-10-22	t
813	63	2026-10-22	t
814	64	2026-10-22	f
815	65	2026-10-22	t
816	66	2026-10-22	t
817	67	2026-10-22	f
818	68	2026-10-22	t
819	69	2026-10-22	t
820	70	2026-10-22	f
821	71	2026-10-22	t
822	72	2026-10-22	t
823	73	2026-10-22	f
824	74	2026-10-22	t
825	75	2026-10-22	t
826	76	2026-10-22	f
827	77	2026-10-22	t
828	78	2026-10-22	t
829	79	2026-10-22	f
830	80	2026-10-22	t
831	81	2026-10-22	t
832	82	2026-10-22	f
833	83	2026-10-22	t
834	84	2026-10-22	t
835	85	2026-10-22	f
836	86	2026-10-22	t
837	87	2026-10-22	t
838	88	2026-10-22	f
839	89	2026-10-22	t
840	90	2026-10-22	t
841	91	2026-10-22	f
842	92	2026-10-22	t
843	93	2026-10-22	t
844	94	2026-10-22	f
845	95	2026-10-22	t
846	96	2026-10-22	t
847	97	2026-10-22	f
848	98	2026-10-22	t
849	99	2026-10-22	t
850	100	2026-10-22	f
851	101	2026-10-22	t
852	102	2026-10-22	t
853	103	2026-10-22	f
854	104	2026-10-22	t
855	105	2026-10-22	t
856	106	2026-10-22	f
857	107	2026-10-22	t
858	108	2026-10-22	t
859	109	2026-10-22	f
860	110	2026-10-22	t
861	111	2026-10-22	t
862	112	2026-10-22	f
863	113	2026-10-22	t
864	114	2026-10-22	t
865	115	2026-10-22	f
866	116	2026-10-22	t
867	117	2026-10-22	t
868	118	2026-10-22	f
869	119	2026-10-22	t
870	120	2026-10-22	t
871	121	2026-10-22	f
872	122	2026-10-22	t
873	123	2026-10-22	t
874	124	2026-10-22	f
875	125	2026-10-22	t
876	126	2026-10-22	t
877	127	2026-10-22	f
878	128	2026-10-22	t
879	129	2026-10-22	t
880	130	2026-10-22	f
881	131	2026-10-22	t
882	132	2026-10-22	t
883	133	2026-10-22	f
884	134	2026-10-22	t
885	135	2026-10-22	t
886	136	2026-10-22	f
887	137	2026-10-22	t
888	138	2026-10-22	t
889	139	2026-10-22	f
890	140	2026-10-22	t
891	141	2026-10-22	t
892	142	2026-10-22	f
893	143	2026-10-22	t
894	144	2026-10-22	t
895	145	2026-10-22	f
896	146	2026-10-22	t
897	147	2026-10-22	t
898	148	2026-10-22	f
899	149	2026-10-22	t
900	150	2026-10-22	t
901	1	2026-10-21	t
902	2	2026-10-21	t
903	3	2026-10-21	f
904	4	2026-10-21	t
905	5	2026-10-21	t
906	6	2026-10-21	f
907	7	2026-10-21	t
908	8	2026-10-21	t
909	9	2026-10-21	f
910	10	2026-10-21	t
911	11	2026-10-21	t
912	12	2026-10-21	f
913	13	2026-10-21	t
914	14	2026-10-21	t
915	15	2026-10-21	f
916	16	2026-10-21	t
917	17	2026-10-21	t
918	18	2026-10-21	f
919	19	2026-10-21	t
920	20	2026-10-21	t
921	21	2026-10-21	f
922	22	2026-10-21	t
923	23	2026-10-21	t
924	24	2026-10-21	f
925	25	2026-10-21	t
926	26	2026-10-21	t
927	27	2026-10-21	f
928	28	2026-10-21	t
929	29	2026-10-21	t
930	30	2026-10-21	f
931	31	2026-10-21	t
932	32	2026-10-21	t
933	33	2026-10-21	f
934	34	2026-10-21	t
935	35	2026-10-21	t
936	36	2026-10-21	f
937	37	2026-10-21	t
938	38	2026-10-21	t
939	39	2026-10-21	f
940	40	2026-10-21	t
941	41	2026-10-21	t
942	42	2026-10-21	f
943	43	2026-10-21	t
944	44	2026-10-21	t
945	45	2026-10-21	f
946	46	2026-10-21	t
947	47	2026-10-21	t
948	48	2026-10-21	f
949	49	2026-10-21	t
950	50	2026-10-21	t
951	51	2026-10-21	f
952	52	2026-10-21	t
953	53	2026-10-21	t
954	54	2026-10-21	f
955	55	2026-10-21	t
956	56	2026-10-21	t
957	57	2026-10-21	f
958	58	2026-10-21	t
959	59	2026-10-21	t
960	60	2026-10-21	f
961	61	2026-10-21	t
962	62	2026-10-21	t
963	63	2026-10-21	f
964	64	2026-10-21	t
965	65	2026-10-21	t
966	66	2026-10-21	f
967	67	2026-10-21	t
968	68	2026-10-21	t
969	69	2026-10-21	f
970	70	2026-10-21	t
971	71	2026-10-21	t
972	72	2026-10-21	f
973	73	2026-10-21	t
974	74	2026-10-21	t
975	75	2026-10-21	f
976	76	2026-10-21	t
977	77	2026-10-21	t
978	78	2026-10-21	f
979	79	2026-10-21	t
980	80	2026-10-21	t
981	81	2026-10-21	f
982	82	2026-10-21	t
983	83	2026-10-21	t
984	84	2026-10-21	f
985	85	2026-10-21	t
986	86	2026-10-21	t
987	87	2026-10-21	f
988	88	2026-10-21	t
989	89	2026-10-21	t
990	90	2026-10-21	f
991	91	2026-10-21	t
992	92	2026-10-21	t
993	93	2026-10-21	f
994	94	2026-10-21	t
995	95	2026-10-21	t
996	96	2026-10-21	f
997	97	2026-10-21	t
998	98	2026-10-21	t
999	99	2026-10-21	f
1000	100	2026-10-21	t
1001	101	2026-10-21	t
1002	102	2026-10-21	f
1003	103	2026-10-21	t
1004	104	2026-10-21	t
1005	105	2026-10-21	f
1006	106	2026-10-21	t
1007	107	2026-10-21	t
1008	108	2026-10-21	f
1009	109	2026-10-21	t
1010	110	2026-10-21	t
1011	111	2026-10-21	f
1012	112	2026-10-21	t
1013	113	2026-10-21	t
1014	114	2026-10-21	f
1015	115	2026-10-21	t
1016	116	2026-10-21	t
1017	117	2026-10-21	f
1018	118	2026-10-21	t
1019	119	2026-10-21	t
1020	120	2026-10-21	f
1021	121	2026-10-21	t
1022	122	2026-10-21	t
1023	123	2026-10-21	f
1024	124	2026-10-21	t
1025	125	2026-10-21	t
1026	126	2026-10-21	f
1027	127	2026-10-21	t
1028	128	2026-10-21	t
1029	129	2026-10-21	f
1030	130	2026-10-21	t
1031	131	2026-10-21	t
1032	132	2026-10-21	f
1033	133	2026-10-21	t
1034	134	2026-10-21	t
1035	135	2026-10-21	f
1036	136	2026-10-21	t
1037	137	2026-10-21	t
1038	138	2026-10-21	f
1039	139	2026-10-21	t
1040	140	2026-10-21	t
1041	141	2026-10-21	f
1042	142	2026-10-21	t
1043	143	2026-10-21	t
1044	144	2026-10-21	f
1045	145	2026-10-21	t
1046	146	2026-10-21	t
1047	147	2026-10-21	f
1048	148	2026-10-21	t
1049	149	2026-10-21	t
1050	150	2026-10-21	f
\.


--
-- TOC entry 3554 (class 0 OID 16499)
-- Dependencies: 234
-- Data for Name: habit_requests; Type: TABLE DATA; Schema: public; Owner: IvanovN
--

COPY public.habit_requests (request_id, author_id, manager_id, status_id, name, description, submitted_at, manager_comment) FROM stdin;
1	8	3	2	Утренняя зарядка	Прошу добавить привычку №1	2026-10-26	Одобрено
2	9	4	3	Читать книгу	Прошу добавить привычку №2	2026-10-25	Нужно уточнить описание
3	10	\N	1	Медитация	Прошу добавить привычку №3	2026-10-24	\N
4	11	6	2	Прогулка	Прошу добавить привычку №4	2026-10-23	Одобрено
5	12	2	3	Учить английский	Прошу добавить привычку №5	2026-10-22	Нужно уточнить описание
6	13	\N	1	Ложиться до 23:00	Прошу добавить привычку №6	2026-10-21	\N
7	14	4	2	Не есть сладкое	Прошу добавить привычку №7	2026-10-20	Одобрено
8	15	5	3	Планировать день	Прошу добавить привычку №8	2026-10-19	Нужно уточнить описание
9	16	\N	1	Тренировка	Прошу добавить привычку №9	2026-10-18	\N
10	17	2	2	Пить воду	Прошу добавить привычку №10	2026-10-17	Одобрено
11	18	3	3	Утренняя зарядка	Прошу добавить привычку №11	2026-10-16	Нужно уточнить описание
12	19	\N	1	Читать книгу	Прошу добавить привычку №12	2026-10-15	\N
13	20	5	2	Медитация	Прошу добавить привычку №13	2026-10-14	Одобрено
14	21	6	3	Прогулка	Прошу добавить привычку №14	2026-10-13	Нужно уточнить описание
15	22	\N	1	Учить английский	Прошу добавить привычку №15	2026-10-12	\N
16	23	3	2	Ложиться до 23:00	Прошу добавить привычку №16	2026-10-11	Одобрено
17	24	4	3	Не есть сладкое	Прошу добавить привычку №17	2026-10-10	Нужно уточнить описание
18	25	\N	1	Планировать день	Прошу добавить привычку №18	2026-10-09	\N
19	26	6	2	Тренировка	Прошу добавить привычку №19	2026-10-08	Одобрено
20	27	2	3	Пить воду	Прошу добавить привычку №20	2026-10-07	Нужно уточнить описание
21	28	\N	1	Утренняя зарядка	Прошу добавить привычку №21	2026-10-06	\N
22	29	4	2	Читать книгу	Прошу добавить привычку №22	2026-10-05	Одобрено
23	30	5	3	Медитация	Прошу добавить привычку №23	2026-10-04	Нужно уточнить описание
24	31	\N	1	Прогулка	Прошу добавить привычку №24	2026-10-03	\N
25	32	2	2	Учить английский	Прошу добавить привычку №25	2026-10-02	Одобрено
26	33	3	3	Ложиться до 23:00	Прошу добавить привычку №26	2026-10-01	Нужно уточнить описание
27	34	\N	1	Не есть сладкое	Прошу добавить привычку №27	2026-09-30	\N
28	35	5	2	Планировать день	Прошу добавить привычку №28	2026-09-29	Одобрено
29	36	6	3	Тренировка	Прошу добавить привычку №29	2026-09-28	Нужно уточнить описание
30	37	\N	1	Пить воду	Прошу добавить привычку №30	2026-10-27	\N
31	38	3	2	Утренняя зарядка	Прошу добавить привычку №31	2026-10-26	Одобрено
32	39	4	3	Читать книгу	Прошу добавить привычку №32	2026-10-25	Нужно уточнить описание
33	40	\N	1	Медитация	Прошу добавить привычку №33	2026-10-24	\N
34	41	6	2	Прогулка	Прошу добавить привычку №34	2026-10-23	Одобрено
35	42	2	3	Учить английский	Прошу добавить привычку №35	2026-10-22	Нужно уточнить описание
36	43	\N	1	Ложиться до 23:00	Прошу добавить привычку №36	2026-10-21	\N
37	44	4	2	Не есть сладкое	Прошу добавить привычку №37	2026-10-20	Одобрено
38	45	5	3	Планировать день	Прошу добавить привычку №38	2026-10-19	Нужно уточнить описание
39	46	\N	1	Тренировка	Прошу добавить привычку №39	2026-10-18	\N
40	47	2	2	Пить воду	Прошу добавить привычку №40	2026-10-17	Одобрено
41	48	3	3	Утренняя зарядка	Прошу добавить привычку №41	2026-10-16	Нужно уточнить описание
42	49	\N	1	Читать книгу	Прошу добавить привычку №42	2026-10-15	\N
43	50	5	2	Медитация	Прошу добавить привычку №43	2026-10-14	Одобрено
44	51	6	3	Прогулка	Прошу добавить привычку №44	2026-10-13	Нужно уточнить описание
45	52	\N	1	Учить английский	Прошу добавить привычку №45	2026-10-12	\N
46	53	3	2	Ложиться до 23:00	Прошу добавить привычку №46	2026-10-11	Одобрено
47	54	4	3	Не есть сладкое	Прошу добавить привычку №47	2026-10-10	Нужно уточнить описание
48	55	\N	1	Планировать день	Прошу добавить привычку №48	2026-10-09	\N
49	56	6	2	Тренировка	Прошу добавить привычку №49	2026-10-08	Одобрено
50	57	2	3	Пить воду	Прошу добавить привычку №50	2026-10-07	Нужно уточнить описание
51	58	\N	1	Утренняя зарядка	Прошу добавить привычку №51	2026-10-06	\N
52	59	4	2	Читать книгу	Прошу добавить привычку №52	2026-10-05	Одобрено
53	60	5	3	Медитация	Прошу добавить привычку №53	2026-10-04	Нужно уточнить описание
54	61	\N	1	Прогулка	Прошу добавить привычку №54	2026-10-03	\N
55	62	2	2	Учить английский	Прошу добавить привычку №55	2026-10-02	Одобрено
56	63	3	3	Ложиться до 23:00	Прошу добавить привычку №56	2026-10-01	Нужно уточнить описание
57	64	\N	1	Не есть сладкое	Прошу добавить привычку №57	2026-09-30	\N
58	65	5	2	Планировать день	Прошу добавить привычку №58	2026-09-29	Одобрено
59	66	6	3	Тренировка	Прошу добавить привычку №59	2026-09-28	Нужно уточнить описание
60	67	\N	1	Пить воду	Прошу добавить привычку №60	2026-10-27	\N
61	68	3	2	Утренняя зарядка	Прошу добавить привычку №61	2026-10-26	Одобрено
62	69	4	3	Читать книгу	Прошу добавить привычку №62	2026-10-25	Нужно уточнить описание
63	70	\N	1	Медитация	Прошу добавить привычку №63	2026-10-24	\N
64	71	6	2	Прогулка	Прошу добавить привычку №64	2026-10-23	Одобрено
65	72	2	3	Учить английский	Прошу добавить привычку №65	2026-10-22	Нужно уточнить описание
66	73	\N	1	Ложиться до 23:00	Прошу добавить привычку №66	2026-10-21	\N
67	74	4	2	Не есть сладкое	Прошу добавить привычку №67	2026-10-20	Одобрено
68	75	5	3	Планировать день	Прошу добавить привычку №68	2026-10-19	Нужно уточнить описание
69	76	\N	1	Тренировка	Прошу добавить привычку №69	2026-10-18	\N
70	77	2	2	Пить воду	Прошу добавить привычку №70	2026-10-17	Одобрено
71	78	3	3	Утренняя зарядка	Прошу добавить привычку №71	2026-10-16	Нужно уточнить описание
72	79	\N	1	Читать книгу	Прошу добавить привычку №72	2026-10-15	\N
73	80	5	2	Медитация	Прошу добавить привычку №73	2026-10-14	Одобрено
74	81	6	3	Прогулка	Прошу добавить привычку №74	2026-10-13	Нужно уточнить описание
75	82	\N	1	Учить английский	Прошу добавить привычку №75	2026-10-12	\N
76	83	3	2	Ложиться до 23:00	Прошу добавить привычку №76	2026-10-11	Одобрено
77	84	4	3	Не есть сладкое	Прошу добавить привычку №77	2026-10-10	Нужно уточнить описание
78	85	\N	1	Планировать день	Прошу добавить привычку №78	2026-10-09	\N
79	86	6	2	Тренировка	Прошу добавить привычку №79	2026-10-08	Одобрено
80	87	2	3	Пить воду	Прошу добавить привычку №80	2026-10-07	Нужно уточнить описание
81	88	\N	1	Утренняя зарядка	Прошу добавить привычку №81	2026-10-06	\N
82	89	4	2	Читать книгу	Прошу добавить привычку №82	2026-10-05	Одобрено
83	90	5	3	Медитация	Прошу добавить привычку №83	2026-10-04	Нужно уточнить описание
84	91	\N	1	Прогулка	Прошу добавить привычку №84	2026-10-03	\N
85	92	2	2	Учить английский	Прошу добавить привычку №85	2026-10-02	Одобрено
86	93	3	3	Ложиться до 23:00	Прошу добавить привычку №86	2026-10-01	Нужно уточнить описание
87	94	\N	1	Не есть сладкое	Прошу добавить привычку №87	2026-09-30	\N
88	95	5	2	Планировать день	Прошу добавить привычку №88	2026-09-29	Одобрено
89	96	6	3	Тренировка	Прошу добавить привычку №89	2026-09-28	Нужно уточнить описание
90	97	\N	1	Пить воду	Прошу добавить привычку №90	2026-10-27	\N
91	98	3	2	Утренняя зарядка	Прошу добавить привычку №91	2026-10-26	Одобрено
92	99	4	3	Читать книгу	Прошу добавить привычку №92	2026-10-25	Нужно уточнить описание
93	100	\N	1	Медитация	Прошу добавить привычку №93	2026-10-24	\N
94	101	6	2	Прогулка	Прошу добавить привычку №94	2026-10-23	Одобрено
95	102	2	3	Учить английский	Прошу добавить привычку №95	2026-10-22	Нужно уточнить описание
96	103	\N	1	Ложиться до 23:00	Прошу добавить привычку №96	2026-10-21	\N
97	104	4	2	Не есть сладкое	Прошу добавить привычку №97	2026-10-20	Одобрено
98	105	5	3	Планировать день	Прошу добавить привычку №98	2026-10-19	Нужно уточнить описание
99	106	\N	1	Тренировка	Прошу добавить привычку №99	2026-10-18	\N
100	107	2	2	Пить воду	Прошу добавить привычку №100	2026-10-17	Одобрено
\.


--
-- TOC entry 3550 (class 0 OID 16449)
-- Dependencies: 230
-- Data for Name: habits; Type: TABLE DATA; Schema: public; Owner: IvanovN
--

COPY public.habits (habit_id, user_id, category_id, frequency_id, name, description, start_date) FROM stdin;
1	7	2	2	Утренняя зарядка	Описание привычки №1	2026-10-19
2	8	3	3	Читать книгу	Описание привычки №2	2026-10-18
3	9	4	1	Медитация	Описание привычки №3	2026-10-17
4	10	5	2	Прогулка	Описание привычки №4	2026-10-16
5	11	1	3	Учить английский	Описание привычки №5	2026-10-15
6	12	2	1	Ложиться до 23:00	Описание привычки №6	2026-10-14
7	13	3	2	Не есть сладкое	Описание привычки №7	2026-10-13
8	14	4	3	Планировать день	Описание привычки №8	2026-10-12
9	15	5	1	Тренировка	Описание привычки №9	2026-10-11
10	16	1	2	Пить воду	Описание привычки №10	2026-10-10
11	17	2	3	Утренняя зарядка	Описание привычки №11	2026-10-09
12	18	3	1	Читать книгу	Описание привычки №12	2026-10-08
13	19	4	2	Медитация	Описание привычки №13	2026-10-07
14	20	5	3	Прогулка	Описание привычки №14	2026-10-06
15	21	1	1	Учить английский	Описание привычки №15	2026-10-05
16	22	2	2	Ложиться до 23:00	Описание привычки №16	2026-10-04
17	23	3	3	Не есть сладкое	Описание привычки №17	2026-10-03
18	24	4	1	Планировать день	Описание привычки №18	2026-10-02
19	25	5	2	Тренировка	Описание привычки №19	2026-10-01
20	26	1	3	Пить воду	Описание привычки №20	2026-09-30
21	27	2	1	Утренняя зарядка	Описание привычки №21	2026-09-29
22	28	3	2	Читать книгу	Описание привычки №22	2026-09-28
23	29	4	3	Медитация	Описание привычки №23	2026-09-27
24	30	5	1	Прогулка	Описание привычки №24	2026-09-26
25	31	1	2	Учить английский	Описание привычки №25	2026-09-25
26	32	2	3	Ложиться до 23:00	Описание привычки №26	2026-09-24
27	33	3	1	Не есть сладкое	Описание привычки №27	2026-09-23
28	34	4	2	Планировать день	Описание привычки №28	2026-09-22
29	35	5	3	Тренировка	Описание привычки №29	2026-09-21
30	36	1	1	Пить воду	Описание привычки №30	2026-09-20
31	37	2	2	Утренняя зарядка	Описание привычки №31	2026-09-19
32	38	3	3	Читать книгу	Описание привычки №32	2026-09-18
33	39	4	1	Медитация	Описание привычки №33	2026-09-17
34	40	5	2	Прогулка	Описание привычки №34	2026-09-16
35	41	1	3	Учить английский	Описание привычки №35	2026-09-15
36	42	2	1	Ложиться до 23:00	Описание привычки №36	2026-09-14
37	43	3	2	Не есть сладкое	Описание привычки №37	2026-09-13
38	44	4	3	Планировать день	Описание привычки №38	2026-09-12
39	45	5	1	Тренировка	Описание привычки №39	2026-09-11
40	46	1	2	Пить воду	Описание привычки №40	2026-09-10
41	47	2	3	Утренняя зарядка	Описание привычки №41	2026-09-09
42	48	3	1	Читать книгу	Описание привычки №42	2026-09-08
43	49	4	2	Медитация	Описание привычки №43	2026-09-07
44	50	5	3	Прогулка	Описание привычки №44	2026-09-06
45	51	1	1	Учить английский	Описание привычки №45	2026-09-05
46	52	2	2	Ложиться до 23:00	Описание привычки №46	2026-09-04
47	53	3	3	Не есть сладкое	Описание привычки №47	2026-09-03
48	54	4	1	Планировать день	Описание привычки №48	2026-09-02
49	55	5	2	Тренировка	Описание привычки №49	2026-09-01
50	56	1	3	Пить воду	Описание привычки №50	2026-08-31
51	57	2	1	Утренняя зарядка	Описание привычки №51	2026-08-30
52	58	3	2	Читать книгу	Описание привычки №52	2026-08-29
53	59	4	3	Медитация	Описание привычки №53	2026-10-20
54	60	5	1	Прогулка	Описание привычки №54	2026-10-19
55	61	1	2	Учить английский	Описание привычки №55	2026-10-18
56	62	2	3	Ложиться до 23:00	Описание привычки №56	2026-10-17
57	63	3	1	Не есть сладкое	Описание привычки №57	2026-10-16
58	64	4	2	Планировать день	Описание привычки №58	2026-10-15
59	65	5	3	Тренировка	Описание привычки №59	2026-10-14
60	66	1	1	Пить воду	Описание привычки №60	2026-10-13
61	67	2	2	Утренняя зарядка	Описание привычки №61	2026-10-12
62	68	3	3	Читать книгу	Описание привычки №62	2026-10-11
63	69	4	1	Медитация	Описание привычки №63	2026-10-10
64	70	5	2	Прогулка	Описание привычки №64	2026-10-09
65	71	1	3	Учить английский	Описание привычки №65	2026-10-08
66	72	2	1	Ложиться до 23:00	Описание привычки №66	2026-10-07
67	73	3	2	Не есть сладкое	Описание привычки №67	2026-10-06
68	74	4	3	Планировать день	Описание привычки №68	2026-10-05
69	75	5	1	Тренировка	Описание привычки №69	2026-10-04
70	76	1	2	Пить воду	Описание привычки №70	2026-10-03
71	77	2	3	Утренняя зарядка	Описание привычки №71	2026-10-02
72	78	3	1	Читать книгу	Описание привычки №72	2026-10-01
73	79	4	2	Медитация	Описание привычки №73	2026-09-30
74	80	5	3	Прогулка	Описание привычки №74	2026-09-29
75	81	1	1	Учить английский	Описание привычки №75	2026-09-28
76	82	2	2	Ложиться до 23:00	Описание привычки №76	2026-09-27
77	83	3	3	Не есть сладкое	Описание привычки №77	2026-09-26
78	84	4	1	Планировать день	Описание привычки №78	2026-09-25
79	85	5	2	Тренировка	Описание привычки №79	2026-09-24
80	86	1	3	Пить воду	Описание привычки №80	2026-09-23
81	87	2	1	Утренняя зарядка	Описание привычки №81	2026-09-22
82	88	3	2	Читать книгу	Описание привычки №82	2026-09-21
83	89	4	3	Медитация	Описание привычки №83	2026-09-20
84	90	5	1	Прогулка	Описание привычки №84	2026-09-19
85	91	1	2	Учить английский	Описание привычки №85	2026-09-18
86	92	2	3	Ложиться до 23:00	Описание привычки №86	2026-09-17
87	93	3	1	Не есть сладкое	Описание привычки №87	2026-09-16
88	94	4	2	Планировать день	Описание привычки №88	2026-09-15
89	95	5	3	Тренировка	Описание привычки №89	2026-09-14
90	96	1	1	Пить воду	Описание привычки №90	2026-09-13
91	97	2	2	Утренняя зарядка	Описание привычки №91	2026-09-12
92	98	3	3	Читать книгу	Описание привычки №92	2026-09-11
93	99	4	1	Медитация	Описание привычки №93	2026-09-10
94	100	5	2	Прогулка	Описание привычки №94	2026-09-09
95	101	1	3	Учить английский	Описание привычки №95	2026-09-08
96	102	2	1	Ложиться до 23:00	Описание привычки №96	2026-09-07
97	103	3	2	Не есть сладкое	Описание привычки №97	2026-09-06
98	104	4	3	Планировать день	Описание привычки №98	2026-09-05
99	105	5	1	Тренировка	Описание привычки №99	2026-09-04
100	106	1	2	Пить воду	Описание привычки №100	2026-09-03
101	107	2	3	Утренняя зарядка	Описание привычки №101	2026-09-02
102	108	3	1	Читать книгу	Описание привычки №102	2026-09-01
103	109	4	2	Медитация	Описание привычки №103	2026-08-31
104	110	5	3	Прогулка	Описание привычки №104	2026-08-30
105	111	1	1	Учить английский	Описание привычки №105	2026-08-29
106	7	2	2	Ложиться до 23:00	Описание привычки №106	2026-10-20
107	8	3	3	Не есть сладкое	Описание привычки №107	2026-10-19
108	9	4	1	Планировать день	Описание привычки №108	2026-10-18
109	10	5	2	Тренировка	Описание привычки №109	2026-10-17
110	11	1	3	Пить воду	Описание привычки №110	2026-10-16
111	12	2	1	Утренняя зарядка	Описание привычки №111	2026-10-15
112	13	3	2	Читать книгу	Описание привычки №112	2026-10-14
113	14	4	3	Медитация	Описание привычки №113	2026-10-13
114	15	5	1	Прогулка	Описание привычки №114	2026-10-12
115	16	1	2	Учить английский	Описание привычки №115	2026-10-11
116	17	2	3	Ложиться до 23:00	Описание привычки №116	2026-10-10
117	18	3	1	Не есть сладкое	Описание привычки №117	2026-10-09
118	19	4	2	Планировать день	Описание привычки №118	2026-10-08
119	20	5	3	Тренировка	Описание привычки №119	2026-10-07
120	21	1	1	Пить воду	Описание привычки №120	2026-10-06
121	22	2	2	Утренняя зарядка	Описание привычки №121	2026-10-05
122	23	3	3	Читать книгу	Описание привычки №122	2026-10-04
123	24	4	1	Медитация	Описание привычки №123	2026-10-03
124	25	5	2	Прогулка	Описание привычки №124	2026-10-02
125	26	1	3	Учить английский	Описание привычки №125	2026-10-01
126	27	2	1	Ложиться до 23:00	Описание привычки №126	2026-09-30
127	28	3	2	Не есть сладкое	Описание привычки №127	2026-09-29
128	29	4	3	Планировать день	Описание привычки №128	2026-09-28
129	30	5	1	Тренировка	Описание привычки №129	2026-09-27
130	31	1	2	Пить воду	Описание привычки №130	2026-09-26
131	32	2	3	Утренняя зарядка	Описание привычки №131	2026-09-25
132	33	3	1	Читать книгу	Описание привычки №132	2026-09-24
133	34	4	2	Медитация	Описание привычки №133	2026-09-23
134	35	5	3	Прогулка	Описание привычки №134	2026-09-22
135	36	1	1	Учить английский	Описание привычки №135	2026-09-21
136	37	2	2	Ложиться до 23:00	Описание привычки №136	2026-09-20
137	38	3	3	Не есть сладкое	Описание привычки №137	2026-09-19
138	39	4	1	Планировать день	Описание привычки №138	2026-09-18
139	40	5	2	Тренировка	Описание привычки №139	2026-09-17
140	41	1	3	Пить воду	Описание привычки №140	2026-09-16
141	42	2	1	Утренняя зарядка	Описание привычки №141	2026-09-15
142	43	3	2	Читать книгу	Описание привычки №142	2026-09-14
143	44	4	3	Медитация	Описание привычки №143	2026-09-13
144	45	5	1	Прогулка	Описание привычки №144	2026-09-12
145	46	1	2	Учить английский	Описание привычки №145	2026-09-11
146	47	2	3	Ложиться до 23:00	Описание привычки №146	2026-09-10
147	48	3	1	Не есть сладкое	Описание привычки №147	2026-09-09
148	49	4	2	Планировать день	Описание привычки №148	2026-09-08
149	50	5	3	Тренировка	Описание привычки №149	2026-09-07
150	51	1	1	Пить воду	Описание привычки №150	2026-09-06
\.


--
-- TOC entry 3546 (class 0 OID 16420)
-- Dependencies: 226
-- Data for Name: request_statuses; Type: TABLE DATA; Schema: public; Owner: IvanovN
--

COPY public.request_statuses (status_id, status_name) FROM stdin;
1	Новая
2	Одобрена
3	Отклонена
\.


--
-- TOC entry 3539 (class 0 OID 16389)
-- Dependencies: 219
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: IvanovN
--

COPY public.roles (role_id, role_name) FROM stdin;
1	Администратор
2	Менеджер
3	Пользователь
\.


--
-- TOC entry 3548 (class 0 OID 16429)
-- Dependencies: 228
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: IvanovN
--

COPY public.users (user_id, login, password_hash, full_name, email, registered_at, role_id) FROM stdin;
1	admin	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Администратор Системы	admin@habit.local	2026-10-27	1
2	manager1	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Пётр Иванов	manager1@mail.ru	2026-10-24	2
3	manager2	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Алексей Иванов	manager2@mail.ru	2026-10-21	2
4	manager3	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Дмитрий Иванов	manager3@mail.ru	2026-10-18	2
5	manager4	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Сергей Иванов	manager4@mail.ru	2026-10-15	2
6	manager5	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Андрей Иванов	manager5@mail.ru	2026-10-12	2
7	user6	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Максим Иванов	user6@mail.ru	2026-10-09	3
8	user7	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Никита Иванов	user7@mail.ru	2026-10-06	3
9	user8	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Артём Иванов	user8@mail.ru	2026-10-03	3
10	user9	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Егор Иванов	user9@mail.ru	2026-09-30	3
11	user10	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Иван Петров	user10@mail.ru	2026-09-27	3
12	user11	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Пётр Петров	user11@mail.ru	2026-09-24	3
13	user12	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Алексей Петров	user12@mail.ru	2026-09-21	3
14	user13	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Дмитрий Петров	user13@mail.ru	2026-09-18	3
15	user14	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Сергей Петров	user14@mail.ru	2026-09-15	3
16	user15	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Андрей Петров	user15@mail.ru	2026-09-12	3
17	user16	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Максим Петров	user16@mail.ru	2026-09-09	3
18	user17	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Никита Петров	user17@mail.ru	2026-09-06	3
19	user18	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Артём Петров	user18@mail.ru	2026-09-03	3
20	user19	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Егор Петров	user19@mail.ru	2026-08-31	3
21	user20	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Иван Сидоров	user20@mail.ru	2026-08-28	3
22	user21	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Пётр Сидоров	user21@mail.ru	2026-08-25	3
23	user22	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Алексей Сидоров	user22@mail.ru	2026-08-22	3
24	user23	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Дмитрий Сидоров	user23@mail.ru	2026-08-19	3
25	user24	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Сергей Сидоров	user24@mail.ru	2026-08-16	3
26	user25	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Андрей Сидоров	user25@mail.ru	2026-08-13	3
27	user26	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Максим Сидоров	user26@mail.ru	2026-08-10	3
28	user27	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Никита Сидоров	user27@mail.ru	2026-08-07	3
29	user28	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Артём Сидоров	user28@mail.ru	2026-08-04	3
30	user29	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Егор Сидоров	user29@mail.ru	2026-08-01	3
31	user30	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Иван Смирнов	user30@mail.ru	2026-07-29	3
32	user31	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Пётр Смирнов	user31@mail.ru	2026-07-26	3
33	user32	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Алексей Смирнов	user32@mail.ru	2026-07-23	3
34	user33	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Дмитрий Смирнов	user33@mail.ru	2026-07-20	3
35	user34	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Сергей Смирнов	user34@mail.ru	2026-07-17	3
36	user35	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Андрей Смирнов	user35@mail.ru	2026-07-14	3
37	user36	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Максим Смирнов	user36@mail.ru	2026-07-11	3
38	user37	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Никита Смирнов	user37@mail.ru	2026-07-08	3
39	user38	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Артём Смирнов	user38@mail.ru	2026-07-05	3
40	user39	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Егор Смирнов	user39@mail.ru	2026-07-02	3
41	user40	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Иван Кузнецов	user40@mail.ru	2026-06-29	3
42	user41	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Пётр Кузнецов	user41@mail.ru	2026-06-26	3
43	user42	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Алексей Кузнецов	user42@mail.ru	2026-06-23	3
44	user43	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Дмитрий Кузнецов	user43@mail.ru	2026-06-20	3
45	user44	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Сергей Кузнецов	user44@mail.ru	2026-06-17	3
46	user45	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Андрей Кузнецов	user45@mail.ru	2026-06-14	3
47	user46	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Максим Кузнецов	user46@mail.ru	2026-06-11	3
48	user47	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Никита Кузнецов	user47@mail.ru	2026-06-08	3
49	user48	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Артём Кузнецов	user48@mail.ru	2026-06-05	3
50	user49	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Егор Кузнецов	user49@mail.ru	2026-06-02	3
51	user50	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Иван Попов	user50@mail.ru	2026-05-30	3
52	user51	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Пётр Попов	user51@mail.ru	2026-05-27	3
53	user52	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Алексей Попов	user52@mail.ru	2026-05-24	3
54	user53	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Дмитрий Попов	user53@mail.ru	2026-05-21	3
55	user54	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Сергей Попов	user54@mail.ru	2026-05-18	3
56	user55	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Андрей Попов	user55@mail.ru	2026-05-15	3
57	user56	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Максим Попов	user56@mail.ru	2026-05-12	3
58	user57	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Никита Попов	user57@mail.ru	2026-05-09	3
59	user58	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Артём Попов	user58@mail.ru	2026-05-06	3
60	user59	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Егор Попов	user59@mail.ru	2026-05-03	3
61	user60	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Иван Васильев	user60@mail.ru	2026-04-30	3
62	user61	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Пётр Васильев	user61@mail.ru	2026-04-27	3
63	user62	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Алексей Васильев	user62@mail.ru	2026-04-24	3
64	user63	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Дмитрий Васильев	user63@mail.ru	2026-04-21	3
65	user64	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Сергей Васильев	user64@mail.ru	2026-04-18	3
66	user65	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Андрей Васильев	user65@mail.ru	2026-04-15	3
67	user66	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Максим Васильев	user66@mail.ru	2026-04-12	3
68	user67	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Никита Васильев	user67@mail.ru	2026-04-09	3
69	user68	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Артём Васильев	user68@mail.ru	2026-04-06	3
70	user69	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Егор Васильев	user69@mail.ru	2026-04-03	3
71	user70	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Иван Новиков	user70@mail.ru	2026-03-31	3
72	user71	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Пётр Новиков	user71@mail.ru	2026-03-28	3
73	user72	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Алексей Новиков	user72@mail.ru	2026-03-25	3
74	user73	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Дмитрий Новиков	user73@mail.ru	2026-03-22	3
75	user74	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Сергей Новиков	user74@mail.ru	2026-03-19	3
76	user75	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Андрей Новиков	user75@mail.ru	2026-03-16	3
77	user76	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Максим Новиков	user76@mail.ru	2026-03-13	3
78	user77	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Никита Новиков	user77@mail.ru	2026-03-10	3
79	user78	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Артём Новиков	user78@mail.ru	2026-03-07	3
80	user79	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Егор Новиков	user79@mail.ru	2026-03-04	3
81	user80	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Иван Морозов	user80@mail.ru	2026-03-01	3
82	user81	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Пётр Морозов	user81@mail.ru	2026-02-26	3
83	user82	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Алексей Морозов	user82@mail.ru	2026-02-23	3
84	user83	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Дмитрий Морозов	user83@mail.ru	2026-02-20	3
85	user84	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Сергей Морозов	user84@mail.ru	2026-02-17	3
86	user85	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Андрей Морозов	user85@mail.ru	2026-02-14	3
87	user86	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Максим Морозов	user86@mail.ru	2026-02-11	3
88	user87	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Никита Морозов	user87@mail.ru	2026-02-08	3
89	user88	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Артём Морозов	user88@mail.ru	2026-02-05	3
90	user89	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Егор Морозов	user89@mail.ru	2026-02-02	3
91	user90	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Иван Волков	user90@mail.ru	2026-01-30	3
92	user91	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Пётр Волков	user91@mail.ru	2026-01-27	3
93	user92	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Алексей Волков	user92@mail.ru	2026-01-24	3
94	user93	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Дмитрий Волков	user93@mail.ru	2026-01-21	3
95	user94	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Сергей Волков	user94@mail.ru	2026-01-18	3
96	user95	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Андрей Волков	user95@mail.ru	2026-01-15	3
97	user96	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Максим Волков	user96@mail.ru	2026-01-12	3
98	user97	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Никита Волков	user97@mail.ru	2026-01-09	3
99	user98	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Артём Волков	user98@mail.ru	2026-01-06	3
100	user99	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Егор Волков	user99@mail.ru	2026-01-03	3
101	user100	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Иван Иванов	user100@mail.ru	2026-10-27	3
102	user101	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Пётр Иванов	user101@mail.ru	2026-10-24	3
103	user102	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Алексей Иванов	user102@mail.ru	2026-10-21	3
104	user103	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Дмитрий Иванов	user103@mail.ru	2026-10-18	3
105	user104	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Сергей Иванов	user104@mail.ru	2026-10-15	3
106	user105	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Андрей Иванов	user105@mail.ru	2026-10-12	3
107	user106	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Максим Иванов	user106@mail.ru	2026-10-09	3
108	user107	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Никита Иванов	user107@mail.ru	2026-10-06	3
109	user108	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Артём Иванов	user108@mail.ru	2026-10-03	3
110	user109	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Егор Иванов	user109@mail.ru	2026-09-30	3
111	user110	08FA299AECC0C034E037033E3B0BBFAEF26B78C742F16CF88AC3194502D6C394	Иван Петров	user110@mail.ru	2026-09-27	3
\.


--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 220
-- Name: IvanovN_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: IvanovN
--

SELECT pg_catalog.setval('public."IvanovN_role_id_seq"', 3, true);


--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 227
-- Name: Name_name_id_seq; Type: SEQUENCE SET; Schema: public; Owner: IvanovN
--

SELECT pg_catalog.setval('public."Name_name_id_seq"', 112, true);


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 221
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: IvanovN
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 5, true);


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 223
-- Name: frequencies_frequency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: IvanovN
--

SELECT pg_catalog.setval('public.frequencies_frequency_id_seq', 3, true);


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 231
-- Name: habit_log_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: IvanovN
--

SELECT pg_catalog.setval('public.habit_log_log_id_seq', 1050, true);


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 233
-- Name: habit_requests_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: IvanovN
--

SELECT pg_catalog.setval('public.habit_requests_request_id_seq', 100, true);


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 229
-- Name: habits_habit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: IvanovN
--

SELECT pg_catalog.setval('public.habits_habit_id_seq', 150, true);


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 225
-- Name: request_statuses_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: IvanovN
--

SELECT pg_catalog.setval('public.request_statuses_status_id_seq', 3, true);


--
-- TOC entry 3369 (class 2606 OID 16400)
-- Name: roles IvanovN_pkey; Type: CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT "IvanovN_pkey" PRIMARY KEY (role_id);


--
-- TOC entry 3377 (class 2606 OID 16441)
-- Name: users Name_pkey; Type: CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "Name_pkey" PRIMARY KEY (user_id);


--
-- TOC entry 3371 (class 2606 OID 16409)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 3373 (class 2606 OID 16418)
-- Name: frequencies frequencies_pkey; Type: CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.frequencies
    ADD CONSTRAINT frequencies_pkey PRIMARY KEY (frequency_id);


--
-- TOC entry 3381 (class 2606 OID 16490)
-- Name: habit_logs habit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.habit_logs
    ADD CONSTRAINT habit_log_pkey PRIMARY KEY (log_id);


--
-- TOC entry 3379 (class 2606 OID 16463)
-- Name: habits habits_pkey; Type: CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.habits
    ADD CONSTRAINT habits_pkey PRIMARY KEY (habit_id);


--
-- TOC entry 3375 (class 2606 OID 16427)
-- Name: request_statuses request_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.request_statuses
    ADD CONSTRAINT request_statuses_pkey PRIMARY KEY (status_id);


--
-- TOC entry 3383 (class 2606 OID 16626)
-- Name: habit_logs uq_habit_logs; Type: CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.habit_logs
    ADD CONSTRAINT uq_habit_logs UNIQUE (habit_id, log_date);


--
-- TOC entry 3385 (class 2606 OID 16469)
-- Name: habits fk_habits_category; Type: FK CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.habits
    ADD CONSTRAINT fk_habits_category FOREIGN KEY (category_id) REFERENCES public.categories(category_id) NOT VALID;


--
-- TOC entry 3386 (class 2606 OID 16474)
-- Name: habits fk_habits_frequencies; Type: FK CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.habits
    ADD CONSTRAINT fk_habits_frequencies FOREIGN KEY (frequency_id) REFERENCES public.frequencies(frequency_id) NOT VALID;


--
-- TOC entry 3387 (class 2606 OID 16464)
-- Name: habits fk_habits_user; Type: FK CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.habits
    ADD CONSTRAINT fk_habits_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;


--
-- TOC entry 3388 (class 2606 OID 16491)
-- Name: habit_logs fk_logs_habits; Type: FK CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.habit_logs
    ADD CONSTRAINT fk_logs_habits FOREIGN KEY (habit_id) REFERENCES public.habits(habit_id) ON DELETE CASCADE;


--
-- TOC entry 3389 (class 2606 OID 16507)
-- Name: habit_requests fk_requests_author; Type: FK CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.habit_requests
    ADD CONSTRAINT fk_requests_author FOREIGN KEY (author_id) REFERENCES public.users(user_id) NOT VALID;


--
-- TOC entry 3390 (class 2606 OID 16512)
-- Name: habit_requests fk_requests_manager; Type: FK CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.habit_requests
    ADD CONSTRAINT fk_requests_manager FOREIGN KEY (manager_id) REFERENCES public.users(user_id) NOT VALID;


--
-- TOC entry 3391 (class 2606 OID 16517)
-- Name: habit_requests fk_requests_status; Type: FK CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.habit_requests
    ADD CONSTRAINT fk_requests_status FOREIGN KEY (status_id) REFERENCES public.request_statuses(status_id) NOT VALID;


--
-- TOC entry 3384 (class 2606 OID 16443)
-- Name: users fk_users_roles; Type: FK CONSTRAINT; Schema: public; Owner: IvanovN
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_roles FOREIGN KEY (role_id) REFERENCES public.roles(role_id) NOT VALID;


-- Completed on 2026-10-27 16:24:50

--
-- PostgreSQL database dump complete
--

\unrestrict uCGNLGyViUZMcJQ7cltL4iBcFcAp5lrBfLpHToFaE99qbb4JUTmCpdcFPp220m7

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict b5P5gdljWfsvYfzSodWrnvISjSki5LFnec9sUompDAl0jYSurIYGwcxaCSXZXdM

-- Dumped from database version 18.6 (Debian 18.6-1.pgdg13+2)
-- Dumped by pg_dump version 18.4

-- Started on 2026-10-27 16:24:50

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

-- Completed on 2026-10-27 16:24:50

--
-- PostgreSQL database dump complete
--

\unrestrict b5P5gdljWfsvYfzSodWrnvISjSki5LFnec9sUompDAl0jYSurIYGwcxaCSXZXdM

-- Completed on 2026-10-27 16:24:50

--
-- PostgreSQL database cluster dump complete
--

