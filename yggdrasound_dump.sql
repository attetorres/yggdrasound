--
-- PostgreSQL database dump
--

\restrict WuerKXdR5vBfh3cbmbN9u3AzJQGghBlGUoHwAa4Cu5FbxcvBDwEVN2NRB9haEdZ

-- Dumped from database version 15.16 (Debian 15.16-1.pgdg13+1)
-- Dumped by pg_dump version 15.16 (Debian 15.16-1.pgdg13+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cart_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_item (
    id integer NOT NULL,
    cart_id integer NOT NULL,
    vinyl_id integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT cart_item_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.cart_item OWNER TO postgres;

--
-- Name: cart_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_item_id_seq OWNER TO postgres;

--
-- Name: cart_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_item_id_seq OWNED BY public.cart_item.id;


--
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    id integer NOT NULL,
    user_id integer NOT NULL,
    vinyl_id integer NOT NULL,
    comment_text text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_id_seq OWNER TO postgres;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;


--
-- Name: credit_card; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credit_card (
    id integer NOT NULL,
    user_id integer NOT NULL,
    card_number character varying(20) NOT NULL,
    expiration_date date NOT NULL,
    cvv character varying(4) NOT NULL,
    brand character varying(50) NOT NULL,
    is_default boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.credit_card OWNER TO postgres;

--
-- Name: credit_card_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.credit_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credit_card_id_seq OWNER TO postgres;

--
-- Name: credit_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.credit_card_id_seq OWNED BY public.credit_card.id;


--
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.genre OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genre_id_seq OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genre_id_seq OWNED BY public.genre.id;


--
-- Name: order_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_history (
    id integer NOT NULL,
    user_id integer NOT NULL,
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_amount numeric(10,2) NOT NULL,
    quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT order_history_quantity_check CHECK ((quantity > 0)),
    CONSTRAINT order_history_total_amount_check CHECK ((total_amount >= (0)::numeric))
);


ALTER TABLE public.order_history OWNER TO postgres;

--
-- Name: order_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_history_id_seq OWNER TO postgres;

--
-- Name: order_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_history_id_seq OWNED BY public.order_history.id;


--
-- Name: order_vinyl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_vinyl (
    id integer NOT NULL,
    order_id integer NOT NULL,
    vinyl_id integer NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT order_vinyl_quantity_check CHECK ((quantity > 0)),
    CONSTRAINT order_vinyl_unit_price_check CHECK ((unit_price >= (0)::numeric))
);


ALTER TABLE public.order_vinyl OWNER TO postgres;

--
-- Name: order_vinyl_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_vinyl_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_vinyl_id_seq OWNER TO postgres;

--
-- Name: order_vinyl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_vinyl_id_seq OWNED BY public.order_vinyl.id;


--
-- Name: shopping_cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shopping_cart (
    id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shopping_cart OWNER TO postgres;

--
-- Name: shopping_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shopping_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shopping_cart_id_seq OWNER TO postgres;

--
-- Name: shopping_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shopping_cart_id_seq OWNED BY public.shopping_cart.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    is_admin boolean DEFAULT false,
    name character varying(100) NOT NULL,
    surname character varying(100),
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    avatar_img character varying(500),
    country character varying(100),
    city character varying(100),
    street character varying(200),
    postcode character varying(20),
    number character varying(10),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_login_at timestamp without time zone,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: vinyl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vinyl (
    id integer NOT NULL,
    artist character varying(150) NOT NULL,
    album character varying(200) NOT NULL,
    album_url character varying(500),
    band_location character varying(100),
    release_date date,
    album_cover character varying(500),
    price numeric(10,2) NOT NULL,
    track_list text[],
    track_count integer DEFAULT 0,
    duration interval,
    band_url character varying(500),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT vinyl_price_check CHECK ((price >= (0)::numeric))
);


ALTER TABLE public.vinyl OWNER TO postgres;

--
-- Name: vinyl_genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vinyl_genre (
    id integer NOT NULL,
    vinyl_id integer NOT NULL,
    genre_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vinyl_genre OWNER TO postgres;

--
-- Name: vinyl_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vinyl_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vinyl_genre_id_seq OWNER TO postgres;

--
-- Name: vinyl_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vinyl_genre_id_seq OWNED BY public.vinyl_genre.id;


--
-- Name: vinyl_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vinyl_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vinyl_id_seq OWNER TO postgres;

--
-- Name: vinyl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vinyl_id_seq OWNED BY public.vinyl.id;


--
-- Name: wish_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wish_item (
    id integer NOT NULL,
    wish_list_id integer NOT NULL,
    vinyl_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.wish_item OWNER TO postgres;

--
-- Name: wish_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wish_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wish_item_id_seq OWNER TO postgres;

--
-- Name: wish_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wish_item_id_seq OWNED BY public.wish_item.id;


--
-- Name: wish_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wish_list (
    id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.wish_list OWNER TO postgres;

--
-- Name: wish_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wish_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wish_list_id_seq OWNER TO postgres;

--
-- Name: wish_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wish_list_id_seq OWNED BY public.wish_list.id;


--
-- Name: cart_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item ALTER COLUMN id SET DEFAULT nextval('public.cart_item_id_seq'::regclass);


--
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);


--
-- Name: credit_card id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_card ALTER COLUMN id SET DEFAULT nextval('public.credit_card_id_seq'::regclass);


--
-- Name: genre id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre ALTER COLUMN id SET DEFAULT nextval('public.genre_id_seq'::regclass);


--
-- Name: order_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_history ALTER COLUMN id SET DEFAULT nextval('public.order_history_id_seq'::regclass);


--
-- Name: order_vinyl id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_vinyl ALTER COLUMN id SET DEFAULT nextval('public.order_vinyl_id_seq'::regclass);


--
-- Name: shopping_cart id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart ALTER COLUMN id SET DEFAULT nextval('public.shopping_cart_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: vinyl id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vinyl ALTER COLUMN id SET DEFAULT nextval('public.vinyl_id_seq'::regclass);


--
-- Name: vinyl_genre id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vinyl_genre ALTER COLUMN id SET DEFAULT nextval('public.vinyl_genre_id_seq'::regclass);


--
-- Name: wish_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wish_item ALTER COLUMN id SET DEFAULT nextval('public.wish_item_id_seq'::regclass);


--
-- Name: wish_list id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wish_list ALTER COLUMN id SET DEFAULT nextval('public.wish_list_id_seq'::regclass);


--
-- Data for Name: cart_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_item (id, cart_id, vinyl_id, quantity, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment (id, user_id, vinyl_id, comment_text, created_at, updated_at) FROM stdin;
1	81	1	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-23 10:20:06	2026-02-23 10:20:06
2	88	1	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-23 12:21:02	2026-02-23 12:21:02
3	76	2	Flat pressing ensures consistent playback across the entire record.	2026-02-20 15:57:41	2026-02-20 15:57:41
4	95	3	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-27 10:34:18	2026-02-27 10:34:18
5	16	3	Una compra segura si buscas calidad sin excesivos extras.	2026-02-23 02:15:09	2026-02-23 02:15:09
6	50	3	Sonido impecable.	2026-02-20 22:56:10	2026-02-20 22:56:10
7	54	4	Experiencia completa.	2026-02-28 22:49:57	2026-02-28 22:49:57
8	58	4	The analog warmth brings out emotions in the music that digital misses.	2026-02-27 02:26:18	2026-02-27 02:26:18
9	36	4	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-21 06:20:17	2026-02-21 06:20:17
10	13	5	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-25 20:39:18	2026-02-25 20:39:18
11	20	5	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-25 05:10:59	2026-02-25 05:10:59
12	17	5	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-28 17:40:18	2026-02-28 17:40:18
13	78	5	La portada es una obra de arte por sí sola, además del contenido.	2026-02-22 15:08:16	2026-02-22 15:08:16
14	97	6	Muy satisfecho.	2026-02-22 07:56:12	2026-02-22 07:56:12
15	70	7	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-21 19:44:05	2026-02-21 19:44:05
16	52	7	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-24 06:16:44	2026-02-24 06:16:44
17	10	8	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-21 15:38:32	2026-02-21 15:38:32
18	5	9	Experiencia completa.	2026-02-20 03:03:55	2026-02-20 03:03:55
19	8	9	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-24 19:02:34	2026-02-24 19:02:34
20	98	9	Every listen reveals new layers in familiar recordings.	2026-02-26 14:05:24	2026-02-26 14:05:24
21	72	10	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-21 09:21:18	2026-02-21 09:21:18
22	45	11	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-27 13:11:01	2026-02-27 13:11:01
23	4	11	Muy buen pressing.	2026-02-22 09:05:50	2026-02-22 09:05:50
24	48	11	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-26 15:11:29	2026-02-26 15:11:29
25	8	12	Muy buen pressing.	2026-02-23 21:40:40	2026-02-23 21:40:40
26	46	12	Calidad premium.	2026-02-24 11:34:43	2026-02-24 11:34:43
27	23	13	Recomendación absoluta.	2026-02-22 06:50:52	2026-02-22 06:50:52
28	65	14	El producto cumple con lo prometido y algo más.	2026-02-22 07:47:14	2026-02-22 07:47:14
29	41	14	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-20 11:45:27	2026-02-20 11:45:27
30	27	14	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-24 15:11:37	2026-02-24 15:11:37
31	19	15	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-26 11:47:11	2026-02-26 11:47:11
32	25	16	Calidad excepcional.	2026-02-26 01:28:08	2026-02-26 01:28:08
33	38	16	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-28 04:35:23	2026-02-28 04:35:23
34	77	16	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-21 12:39:10	2026-02-21 12:39:10
35	3	17	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-22 11:13:53	2026-02-22 11:13:53
36	28	17	Experiencia completa.	2026-02-23 10:11:44	2026-02-23 10:11:44
37	80	17	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-24 13:30:58	2026-02-24 13:30:58
38	47	18	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-20 23:10:31	2026-02-20 23:10:31
39	44	18	Sonido rico y detallado.	2026-02-25 18:06:55	2026-02-25 18:06:55
40	99	18	The soundstage is wide and deep, creating an immersive experience.	2026-02-23 08:20:16	2026-02-23 08:20:16
41	74	18	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-27 04:14:22	2026-02-27 04:14:22
42	27	19	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-28 01:42:09	2026-02-28 01:42:09
43	58	19	Excelente calidad de sonido.	2026-02-20 13:28:43	2026-02-20 13:28:43
44	56	19	Instrument separation is remarkable, each element has its own space.	2026-02-28 01:34:11	2026-02-28 01:34:11
45	99	20	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-25 20:39:31	2026-02-25 20:39:31
46	41	20	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-28 19:08:38	2026-02-28 19:08:38
47	100	20	Calidad excepcional.	2026-02-26 08:49:56	2026-02-26 08:49:56
48	30	21	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-20 18:38:12	2026-02-20 18:38:12
49	31	21	Flat pressing ensures consistent playback across the entire record.	2026-02-20 19:47:11	2026-02-20 19:47:11
50	15	21	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-23 23:11:50	2026-02-23 23:11:50
51	60	21	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-20 05:20:53	2026-02-20 05:20:53
52	56	22	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-24 11:19:55	2026-02-24 11:19:55
53	42	22	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-26 03:49:10	2026-02-26 03:49:10
54	68	22	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-21 10:49:01	2026-02-21 10:49:01
55	79	22	Pressing de calidad.	2026-02-25 23:29:31	2026-02-25 23:29:31
56	49	23	Calidad premium.	2026-02-20 17:02:26	2026-02-20 17:02:26
57	94	23	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-24 19:43:30	2026-02-24 19:43:30
58	32	23	Sonido espectacular.	2026-02-23 06:14:48	2026-02-23 06:14:48
59	29	23	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-24 15:56:51	2026-02-24 15:56:51
60	92	24	Muy satisfecho.	2026-02-25 10:40:18	2026-02-25 10:40:18
61	71	24	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-20 14:40:04	2026-02-20 14:40:04
62	54	24	Muy satisfecho.	2026-02-26 18:18:44	2026-02-26 18:18:44
63	78	25	Merece la pena.	2026-02-24 18:26:19	2026-02-24 18:26:19
64	58	25	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-28 23:20:27	2026-02-28 23:20:27
65	45	25	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-28 10:52:08	2026-02-28 10:52:08
66	47	26	Muy satisfecho.	2026-02-24 09:06:14	2026-02-24 09:06:14
67	62	27	Inmejorable relación calidad-precio.	2026-02-28 07:27:05	2026-02-28 07:27:05
68	41	27	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-20 21:12:29	2026-02-20 21:12:29
69	87	28	The soundstage is wide and deep, creating an immersive experience.	2026-02-21 22:00:57	2026-02-21 22:00:57
70	69	28	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-28 08:46:29	2026-02-28 08:46:29
71	24	29	Calidad consistente de principio a fin del disco.	2026-02-28 18:06:02	2026-02-28 18:06:02
72	2	29	Flat pressing ensures consistent playback across the entire record.	2026-02-24 01:56:35	2026-02-24 01:56:35
73	18	29	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-26 03:09:01	2026-02-26 03:09:01
74	4	29	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-26 12:56:46	2026-02-26 12:56:46
75	48	30	Recomendación absoluta.	2026-02-22 05:09:48	2026-02-22 05:09:48
76	72	30	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-24 02:26:47	2026-02-24 02:26:47
77	86	31	Totalmente recomendado.	2026-02-26 13:58:39	2026-02-26 13:58:39
78	90	31	Pressing de calidad.	2026-02-23 15:10:28	2026-02-23 15:10:28
79	37	31	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-20 16:43:38	2026-02-20 16:43:38
80	48	32	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-25 11:34:49	2026-02-25 11:34:49
81	54	32	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-28 03:57:20	2026-02-28 03:57:20
82	14	32	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-25 04:27:40	2026-02-25 04:27:40
83	31	32	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-22 03:10:19	2026-02-22 03:10:19
84	99	33	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-24 02:14:56	2026-02-24 02:14:56
85	23	33	Instrument separation is remarkable, each element has its own space.	2026-02-22 21:24:49	2026-02-22 21:24:49
86	26	34	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-25 16:53:40	2026-02-25 16:53:40
87	4	34	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-23 14:47:42	2026-02-23 14:47:42
88	52	35	Every listen reveals new layers in familiar recordings.	2026-02-25 06:20:27	2026-02-25 06:20:27
89	71	35	The analog warmth brings out emotions in the music that digital misses.	2026-02-21 11:57:09	2026-02-21 11:57:09
90	42	36	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-22 01:53:16	2026-02-22 01:53:16
91	56	36	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-28 15:39:52	2026-02-28 15:39:52
92	12	36	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-28 11:59:26	2026-02-28 11:59:26
93	90	36	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-28 11:44:02	2026-02-28 11:44:02
94	34	37	Experiencia completa.	2026-02-25 12:41:48	2026-02-25 12:41:48
95	16	38	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-27 06:56:20	2026-02-27 06:56:20
96	19	38	The analog warmth brings out emotions in the music that digital misses.	2026-02-27 19:11:00	2026-02-27 19:11:00
97	21	38	Merece la pena.	2026-02-25 00:40:41	2026-02-25 00:40:41
98	62	39	Calidad excepcional.	2026-02-28 13:50:22	2026-02-28 13:50:22
99	92	39	El sonido es lo importante y aquí brilla con luz propia.	2026-02-27 16:58:44	2026-02-27 16:58:44
100	72	39	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-24 09:24:31	2026-02-24 09:24:31
101	77	40	The soundstage is wide and deep, creating an immersive experience.	2026-02-26 09:30:40	2026-02-26 09:30:40
102	32	40	Inmejorable relación calidad-precio.	2026-02-24 02:29:19	2026-02-24 02:29:19
103	42	40	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-25 15:56:00	2026-02-25 15:56:00
104	50	40	Mastering for vinyl was clearly done with care and expertise.	2026-02-27 08:26:31	2026-02-27 08:26:31
105	45	41	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-24 02:45:27	2026-02-24 02:45:27
106	72	41	Excelente calidad de sonido.	2026-02-24 19:54:05	2026-02-24 19:54:05
107	66	42	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-28 15:57:10	2026-02-28 15:57:10
108	69	42	Calidad excepcional.	2026-02-27 10:15:44	2026-02-27 10:15:44
109	64	43	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-23 03:27:43	2026-02-23 03:27:43
110	64	44	El centrado del label es perfecto, detalles que importan.	2026-02-20 10:34:48	2026-02-20 10:34:48
111	95	45	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-24 02:16:41	2026-02-24 02:16:41
112	83	45	Totalmente recomendado.	2026-02-25 18:03:27	2026-02-25 18:03:27
113	66	46	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-26 16:04:43	2026-02-26 16:04:43
114	36	46	Muy satisfecho.	2026-02-24 10:09:22	2026-02-24 10:09:22
115	84	46	Totalmente recomendado.	2026-02-24 04:55:12	2026-02-24 04:55:12
116	2	46	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-20 22:17:18	2026-02-20 22:17:18
117	84	47	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-27 08:22:25	2026-02-27 08:22:25
118	33	48	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-27 18:27:58	2026-02-27 18:27:58
119	90	49	El centrado del label es perfecto, detalles que importan.	2026-02-22 17:23:32	2026-02-22 17:23:32
120	10	49	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-23 10:54:02	2026-02-23 10:54:02
121	98	49	Calidad excepcional.	2026-02-25 04:12:44	2026-02-25 04:12:44
122	18	49	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-27 16:39:05	2026-02-27 16:39:05
123	20	50	Every listen reveals new layers in familiar recordings.	2026-02-25 14:14:00	2026-02-25 14:14:00
124	4	50	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-21 14:22:38	2026-02-21 14:22:38
125	53	50	Flat pressing ensures consistent playback across the entire record.	2026-02-20 14:27:11	2026-02-20 14:27:11
126	13	51	Excelente calidad de sonido.	2026-02-27 11:02:20	2026-02-27 11:02:20
127	39	51	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-24 18:43:27	2026-02-24 18:43:27
128	51	52	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-24 01:52:58	2026-02-24 01:52:58
129	24	52	Experiencia completa.	2026-02-22 14:18:17	2026-02-22 14:18:17
130	95	52	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-22 13:41:50	2026-02-22 13:41:50
131	15	52	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-24 01:50:12	2026-02-24 01:50:12
132	66	53	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-23 07:28:10	2026-02-23 07:28:10
133	15	53	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-20 07:09:42	2026-02-20 07:09:42
134	31	53	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-26 12:47:14	2026-02-26 12:47:14
135	26	53	Una compra segura si buscas calidad sin excesivos extras.	2026-02-22 03:39:47	2026-02-22 03:39:47
136	31	54	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-20 01:08:53	2026-02-20 01:08:53
137	68	54	The soundstage is wide and deep, creating an immersive experience.	2026-02-26 05:25:31	2026-02-26 05:25:31
138	37	54	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-21 16:29:44	2026-02-21 16:29:44
139	74	54	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-23 18:51:02	2026-02-23 18:51:02
140	20	55	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-23 12:35:22	2026-02-23 12:35:22
141	62	55	Totalmente recomendado.	2026-02-21 04:01:18	2026-02-21 04:01:18
142	83	56	Sonido espectacular.	2026-02-24 10:29:26	2026-02-24 10:29:26
143	77	56	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-25 00:21:06	2026-02-25 00:21:06
144	62	56	The analog warmth brings out emotions in the music that digital misses.	2026-02-27 12:27:02	2026-02-27 12:27:02
145	15	56	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-21 13:14:01	2026-02-21 13:14:01
146	42	57	Inmejorable relación calidad-precio.	2026-02-27 23:38:18	2026-02-27 23:38:18
147	60	58	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-26 09:15:09	2026-02-26 09:15:09
148	55	59	Inmejorable relación calidad-precio.	2026-02-25 09:29:59	2026-02-25 09:29:59
149	54	60	Una compra segura si buscas calidad sin excesivos extras.	2026-02-28 19:21:46	2026-02-28 19:21:46
150	57	60	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-23 10:30:10	2026-02-23 10:30:10
151	92	60	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-22 16:38:40	2026-02-22 16:38:40
152	42	61	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-23 12:55:13	2026-02-23 12:55:13
153	36	61	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-23 21:19:14	2026-02-23 21:19:14
154	88	61	El sonido es lo importante y aquí brilla con luz propia.	2026-02-23 03:52:04	2026-02-23 03:52:04
155	55	62	Pressing de calidad.	2026-02-23 01:51:25	2026-02-23 01:51:25
156	94	63	El producto cumple con lo prometido y algo más.	2026-02-23 06:35:23	2026-02-23 06:35:23
157	72	64	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-28 04:42:05	2026-02-28 04:42:05
158	76	64	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-28 13:07:50	2026-02-28 13:07:50
159	35	65	Calidad premium.	2026-02-28 02:15:28	2026-02-28 02:15:28
160	85	66	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-25 17:59:01	2026-02-25 17:59:01
161	79	66	Surface noise is minimal, allowing the music to speak for itself.	2026-02-25 12:28:18	2026-02-25 12:28:18
162	95	66	Calidad excepcional.	2026-02-26 15:44:11	2026-02-26 15:44:11
163	13	67	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-21 12:38:26	2026-02-21 12:38:26
164	34	67	Pressing de calidad.	2026-02-24 17:38:52	2026-02-24 17:38:52
165	39	67	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-21 05:37:09	2026-02-21 05:37:09
166	65	67	The soundstage is wide and deep, creating an immersive experience.	2026-02-28 01:51:08	2026-02-28 01:51:08
167	48	68	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-21 14:07:00	2026-02-21 14:07:00
168	93	68	Una compra segura si buscas calidad sin excesivos extras.	2026-02-26 18:19:25	2026-02-26 18:19:25
169	19	68	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-27 09:58:58	2026-02-27 09:58:58
170	31	68	Experiencia completa.	2026-02-25 05:14:56	2026-02-25 05:14:56
171	100	69	Muy buen pressing.	2026-02-28 16:20:38	2026-02-28 16:20:38
172	43	69	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-27 15:47:54	2026-02-27 15:47:54
173	45	69	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-23 03:15:36	2026-02-23 03:15:36
174	36	69	The vinyl compound seems high-quality with excellent durability.	2026-02-21 00:06:59	2026-02-21 00:06:59
175	3	70	Sonido impecable.	2026-02-22 15:58:20	2026-02-22 15:58:20
176	13	70	Edición cuidada.	2026-02-24 14:55:07	2026-02-24 14:55:07
177	22	71	Totalmente recomendado.	2026-02-25 02:12:53	2026-02-25 02:12:53
178	7	72	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-26 15:05:36	2026-02-26 15:05:36
179	30	72	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-23 22:16:27	2026-02-23 22:16:27
180	74	72	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-22 17:34:59	2026-02-22 17:34:59
181	60	72	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-25 06:50:25	2026-02-25 06:50:25
182	38	73	Every listen reveals new layers in familiar recordings.	2026-02-26 11:51:32	2026-02-26 11:51:32
183	22	74	Sonido espectacular.	2026-02-20 09:46:58	2026-02-20 09:46:58
184	25	74	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-23 05:40:42	2026-02-23 05:40:42
185	77	74	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-23 20:13:51	2026-02-23 20:13:51
186	33	74	El producto cumple con lo prometido y algo más.	2026-02-20 10:33:33	2026-02-20 10:33:33
187	29	75	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-28 03:28:36	2026-02-28 03:28:36
188	73	75	El centrado del label es perfecto, detalles que importan.	2026-02-26 19:42:49	2026-02-26 19:42:49
189	84	76	Totalmente recomendado.	2026-02-20 01:44:45	2026-02-20 01:44:45
190	40	77	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-22 20:12:48	2026-02-22 20:12:48
191	90	77	Totalmente recomendado.	2026-02-23 23:36:42	2026-02-23 23:36:42
192	57	78	Mastering for vinyl was clearly done with care and expertise.	2026-02-23 14:38:43	2026-02-23 14:38:43
193	90	78	Instrument separation is remarkable, each element has its own space.	2026-02-20 21:16:22	2026-02-20 21:16:22
194	77	78	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-25 23:48:21	2026-02-25 23:48:21
195	67	79	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-27 16:07:26	2026-02-27 16:07:26
196	13	80	The analog warmth brings out emotions in the music that digital misses.	2026-02-25 22:06:52	2026-02-25 22:06:52
197	29	80	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-28 20:53:30	2026-02-28 20:53:30
198	69	80	Calidad consistente de principio a fin del disco.	2026-02-27 01:52:50	2026-02-27 01:52:50
199	75	81	Muy buen pressing.	2026-02-24 15:57:09	2026-02-24 15:57:09
200	60	81	Recomendación absoluta.	2026-02-21 12:37:08	2026-02-21 12:37:08
201	89	81	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-28 20:23:46	2026-02-28 20:23:46
202	72	81	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-28 14:10:16	2026-02-28 14:10:16
203	20	82	El simple acto de colocar la aguja ya genera expectación.	2026-02-22 02:30:20	2026-02-22 02:30:20
204	47	82	Mastering for vinyl was clearly done with care and expertise.	2026-02-22 19:13:33	2026-02-22 19:13:33
205	63	82	Totalmente recomendado.	2026-02-28 04:05:35	2026-02-28 04:05:35
206	37	83	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-27 15:45:49	2026-02-27 15:45:49
207	68	84	Sonido impecable.	2026-02-25 07:14:34	2026-02-25 07:14:34
208	46	84	The vinyl compound seems high-quality with excellent durability.	2026-02-21 14:09:04	2026-02-21 14:09:04
209	57	84	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-23 15:16:40	2026-02-23 15:16:40
210	41	85	Flat pressing ensures consistent playback across the entire record.	2026-02-22 19:43:51	2026-02-22 19:43:51
211	51	85	Recomendación absoluta.	2026-02-22 12:17:09	2026-02-22 12:17:09
212	27	86	Calidad premium.	2026-02-24 02:14:51	2026-02-24 02:14:51
213	62	86	The vinyl compound seems high-quality with excellent durability.	2026-02-23 06:13:38	2026-02-23 06:13:38
214	89	86	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-21 13:24:09	2026-02-21 13:24:09
215	55	87	Muy buen pressing.	2026-02-28 03:03:56	2026-02-28 03:03:56
216	47	87	Sonido impecable.	2026-02-24 03:46:59	2026-02-24 03:46:59
217	41	87	El centrado del label es perfecto, detalles que importan.	2026-02-25 12:45:24	2026-02-25 12:45:24
218	17	88	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-26 03:54:42	2026-02-26 03:54:42
219	28	88	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-28 18:27:45	2026-02-28 18:27:45
220	92	88	Recomendación absoluta.	2026-02-24 15:13:21	2026-02-24 15:13:21
221	8	88	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-27 01:15:12	2026-02-27 01:15:12
222	25	89	The analog warmth brings out emotions in the music that digital misses.	2026-02-23 19:52:18	2026-02-23 19:52:18
223	35	89	Muy satisfecho.	2026-02-28 14:18:25	2026-02-28 14:18:25
224	95	90	Edición cuidada.	2026-02-22 09:11:36	2026-02-22 09:11:36
225	100	90	Surface noise is minimal, allowing the music to speak for itself.	2026-02-22 15:23:48	2026-02-22 15:23:48
226	81	91	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-22 19:44:45	2026-02-22 19:44:45
227	9	91	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-20 07:57:26	2026-02-20 07:57:26
228	100	91	Excelente calidad de sonido.	2026-02-22 01:47:35	2026-02-22 01:47:35
229	12	92	Muy satisfecho.	2026-02-25 16:02:51	2026-02-25 16:02:51
230	48	92	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-27 02:15:13	2026-02-27 02:15:13
231	60	93	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-25 22:40:16	2026-02-25 22:40:16
232	62	93	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-21 19:23:22	2026-02-21 19:23:22
233	4	93	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-20 06:51:46	2026-02-20 06:51:46
234	70	93	The vinyl compound seems high-quality with excellent durability.	2026-02-28 16:42:33	2026-02-28 16:42:33
235	62	94	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-22 02:01:47	2026-02-22 02:01:47
236	66	94	Excelente calidad de sonido.	2026-02-24 20:12:13	2026-02-24 20:12:13
237	84	94	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-23 05:07:34	2026-02-23 05:07:34
238	37	95	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-20 13:15:56	2026-02-20 13:15:56
239	53	95	Excelente calidad de sonido.	2026-02-25 02:05:54	2026-02-25 02:05:54
240	47	95	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-23 15:39:00	2026-02-23 15:39:00
241	93	96	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-26 00:12:24	2026-02-26 00:12:24
242	46	96	Pressing de calidad.	2026-02-21 07:15:47	2026-02-21 07:15:47
243	97	96	Merece la pena.	2026-02-27 15:01:59	2026-02-27 15:01:59
244	11	97	El simple acto de colocar la aguja ya genera expectación.	2026-02-20 18:24:49	2026-02-20 18:24:49
245	81	97	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-22 04:55:02	2026-02-22 04:55:02
246	72	98	Flat pressing ensures consistent playback across the entire record.	2026-02-20 06:53:14	2026-02-20 06:53:14
247	26	98	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-28 16:48:53	2026-02-28 16:48:53
248	16	98	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-21 15:37:55	2026-02-21 15:37:55
249	38	99	Merece la pena.	2026-02-27 18:19:05	2026-02-27 18:19:05
250	83	99	Una compra segura si buscas calidad sin excesivos extras.	2026-02-27 22:43:51	2026-02-27 22:43:51
251	14	99	Recomendación absoluta.	2026-02-28 15:48:40	2026-02-28 15:48:40
252	12	99	Surface noise is minimal, allowing the music to speak for itself.	2026-02-28 14:05:12	2026-02-28 14:05:12
253	38	100	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-22 14:54:52	2026-02-22 14:54:52
254	69	100	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-24 06:06:31	2026-02-24 06:06:31
255	43	100	Recomendación absoluta.	2026-02-24 15:02:56	2026-02-24 15:02:56
256	39	100	The analog warmth brings out emotions in the music that digital misses.	2026-02-26 06:57:28	2026-02-26 06:57:28
257	18	101	Inmejorable relación calidad-precio.	2026-02-20 09:52:56	2026-02-20 09:52:56
258	2	101	El sonido es lo importante y aquí brilla con luz propia.	2026-02-28 14:55:18	2026-02-28 14:55:18
259	68	101	El centrado del label es perfecto, detalles que importan.	2026-02-25 04:43:33	2026-02-25 04:43:33
260	45	101	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-26 05:28:41	2026-02-26 05:28:41
261	75	102	Muy buen pressing.	2026-02-27 04:29:26	2026-02-27 04:29:26
262	96	102	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-21 11:38:22	2026-02-21 11:38:22
263	41	102	Calidad consistente de principio a fin del disco.	2026-02-28 08:59:48	2026-02-28 08:59:48
264	13	102	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-28 09:08:40	2026-02-28 09:08:40
265	11	103	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-20 09:28:10	2026-02-20 09:28:10
266	51	103	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-22 00:17:53	2026-02-22 00:17:53
267	52	103	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-25 04:54:33	2026-02-25 04:54:33
268	96	104	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-27 11:44:58	2026-02-27 11:44:58
269	94	104	Sonido impecable.	2026-02-28 09:14:36	2026-02-28 09:14:36
270	79	104	Experiencia completa.	2026-02-20 21:02:09	2026-02-20 21:02:09
271	7	105	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-28 12:54:02	2026-02-28 12:54:02
272	84	105	Sonido impecable.	2026-02-27 18:15:00	2026-02-27 18:15:00
273	53	105	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-25 05:40:37	2026-02-25 05:40:37
274	3	106	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-28 21:34:49	2026-02-28 21:34:49
275	99	106	El centrado del label es perfecto, detalles que importan.	2026-02-24 07:13:48	2026-02-24 07:13:48
276	39	106	Recomendación absoluta.	2026-02-20 23:28:57	2026-02-20 23:28:57
277	39	107	Muy satisfecho.	2026-02-26 09:25:11	2026-02-26 09:25:11
278	37	107	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-25 09:17:05	2026-02-25 09:17:05
279	33	107	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-27 04:03:28	2026-02-27 04:03:28
280	69	107	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-22 22:49:25	2026-02-22 22:49:25
281	78	108	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-24 12:44:27	2026-02-24 12:44:27
282	83	108	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-28 14:20:49	2026-02-28 14:20:49
283	63	108	The soundstage is wide and deep, creating an immersive experience.	2026-02-24 08:53:07	2026-02-24 08:53:07
284	13	109	Totalmente recomendado.	2026-02-28 04:02:43	2026-02-28 04:02:43
285	29	109	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-20 17:29:15	2026-02-20 17:29:15
286	61	109	Totalmente recomendado.	2026-02-23 23:15:40	2026-02-23 23:15:40
287	82	109	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-21 01:51:59	2026-02-21 01:51:59
914	41	359	Merece la pena.	2026-02-20 13:16:52	2026-02-20 13:16:52
288	38	110	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-25 08:57:26	2026-02-25 08:57:26
289	72	110	Surface noise is minimal, allowing the music to speak for itself.	2026-02-26 21:31:51	2026-02-26 21:31:51
290	45	111	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-20 00:41:15	2026-02-20 00:41:15
291	85	111	Edición cuidada.	2026-02-27 16:45:53	2026-02-27 16:45:53
292	18	111	Surface noise is minimal, allowing the music to speak for itself.	2026-02-26 10:51:29	2026-02-26 10:51:29
293	26	112	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-24 23:36:03	2026-02-24 23:36:03
294	14	112	Calidad excepcional.	2026-02-21 07:43:49	2026-02-21 07:43:49
295	28	112	Merece la pena.	2026-02-26 17:02:09	2026-02-26 17:02:09
296	97	112	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-26 12:42:37	2026-02-26 12:42:37
297	99	113	The soundstage is wide and deep, creating an immersive experience.	2026-02-20 02:53:23	2026-02-20 02:53:23
298	8	113	Sonido impecable.	2026-02-24 17:03:04	2026-02-24 17:03:04
299	50	113	Merece la pena.	2026-02-28 06:40:00	2026-02-28 06:40:00
300	71	114	Recomendación absoluta.	2026-02-27 05:10:16	2026-02-27 05:10:16
301	21	114	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-21 03:05:29	2026-02-21 03:05:29
302	31	114	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-25 16:23:12	2026-02-25 16:23:12
303	80	114	Surface noise is minimal, allowing the music to speak for itself.	2026-02-20 15:03:49	2026-02-20 15:03:49
304	88	115	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-20 21:00:06	2026-02-20 21:00:06
305	63	115	The vinyl compound seems high-quality with excellent durability.	2026-02-22 04:52:57	2026-02-22 04:52:57
306	9	116	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-22 06:52:40	2026-02-22 06:52:40
307	81	116	The soundstage is wide and deep, creating an immersive experience.	2026-02-20 01:59:10	2026-02-20 01:59:10
308	82	116	Recomendación absoluta.	2026-02-28 08:16:45	2026-02-28 08:16:45
309	16	116	Experiencia completa.	2026-02-20 03:48:13	2026-02-20 03:48:13
310	1	117	Edición cuidada.	2026-02-24 22:12:59	2026-02-24 22:12:59
311	51	117	Muy satisfecho.	2026-02-24 21:47:44	2026-02-24 21:47:44
312	1	118	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-22 11:01:30	2026-02-22 11:01:30
313	41	118	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-24 10:32:25	2026-02-24 10:32:25
314	2	118	Una compra segura si buscas calidad sin excesivos extras.	2026-02-23 00:16:40	2026-02-23 00:16:40
315	8	119	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-23 04:03:50	2026-02-23 04:03:50
316	63	119	Merece la pena.	2026-02-25 13:15:48	2026-02-25 13:15:48
317	21	119	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-23 16:44:39	2026-02-23 16:44:39
318	68	119	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-21 12:09:18	2026-02-21 12:09:18
319	20	120	Calidad excepcional.	2026-02-25 22:31:15	2026-02-25 22:31:15
320	47	120	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-26 03:59:30	2026-02-26 03:59:30
321	21	120	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-21 03:38:05	2026-02-21 03:38:05
322	81	120	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-24 22:04:11	2026-02-24 22:04:11
323	19	121	Una compra segura si buscas calidad sin excesivos extras.	2026-02-21 03:08:08	2026-02-21 03:08:08
324	49	121	Recomendación absoluta.	2026-02-26 12:18:47	2026-02-26 12:18:47
325	46	122	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-27 03:41:43	2026-02-27 03:41:43
326	86	123	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-26 12:50:19	2026-02-26 12:50:19
327	7	123	Sonido impecable.	2026-02-24 15:52:00	2026-02-24 15:52:00
328	78	124	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-21 23:33:46	2026-02-21 23:33:46
329	96	124	Sonido rico y detallado.	2026-02-26 18:06:23	2026-02-26 18:06:23
330	57	124	El centrado del label es perfecto, detalles que importan.	2026-02-24 06:06:32	2026-02-24 06:06:32
331	51	125	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-24 04:08:35	2026-02-24 04:08:35
332	27	125	Recomendación absoluta.	2026-02-23 10:50:02	2026-02-23 10:50:02
333	63	126	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-22 02:03:25	2026-02-22 02:03:25
334	95	126	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-26 02:58:38	2026-02-26 02:58:38
335	49	126	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-23 04:01:14	2026-02-23 04:01:14
336	40	126	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-27 09:48:52	2026-02-27 09:48:52
337	73	127	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-22 16:18:17	2026-02-22 16:18:17
338	93	127	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-20 03:27:26	2026-02-20 03:27:26
339	8	127	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-24 17:33:28	2026-02-24 17:33:28
340	73	128	Pressing de calidad.	2026-02-24 09:14:05	2026-02-24 09:14:05
341	75	128	Recomendación absoluta.	2026-02-28 06:42:51	2026-02-28 06:42:51
342	86	129	Sonido impecable.	2026-02-22 21:05:25	2026-02-22 21:05:25
343	10	129	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-27 16:06:42	2026-02-27 16:06:42
344	74	130	Totalmente recomendado.	2026-02-24 20:25:10	2026-02-24 20:25:10
345	18	130	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-22 18:15:19	2026-02-22 18:15:19
346	5	130	The soundstage is wide and deep, creating an immersive experience.	2026-02-23 21:39:38	2026-02-23 21:39:38
347	95	130	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-21 09:21:57	2026-02-21 09:21:57
348	33	131	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-20 01:39:32	2026-02-20 01:39:32
349	52	131	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-26 02:45:46	2026-02-26 02:45:46
350	51	132	Excelente calidad de sonido.	2026-02-25 11:23:00	2026-02-25 11:23:00
351	73	133	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-20 18:17:33	2026-02-20 18:17:33
352	62	133	Calidad consistente de principio a fin del disco.	2026-02-22 19:05:09	2026-02-22 19:05:09
353	83	134	Inmejorable relación calidad-precio.	2026-02-23 16:35:15	2026-02-23 16:35:15
354	34	134	Flat pressing ensures consistent playback across the entire record.	2026-02-20 00:29:27	2026-02-20 00:29:27
355	77	135	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-24 04:24:54	2026-02-24 04:24:54
356	74	135	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-24 02:08:41	2026-02-24 02:08:41
357	94	135	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-22 12:37:06	2026-02-22 12:37:06
358	18	135	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-27 14:01:49	2026-02-27 14:01:49
1198	58	481	Pressing de calidad.	2026-02-24 10:40:31	2026-02-24 10:40:31
359	3	136	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-25 08:16:04	2026-02-25 08:16:04
360	74	136	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-20 22:58:57	2026-02-20 22:58:57
361	68	137	The analog warmth brings out emotions in the music that digital misses.	2026-02-20 16:32:27	2026-02-20 16:32:27
362	5	137	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-23 21:00:36	2026-02-23 21:00:36
363	1	137	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-27 08:07:59	2026-02-27 08:07:59
364	75	137	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-28 15:02:11	2026-02-28 15:02:11
365	12	138	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-20 05:51:52	2026-02-20 05:51:52
366	77	138	The soundstage is wide and deep, creating an immersive experience.	2026-02-24 00:45:08	2026-02-24 00:45:08
367	49	138	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-25 23:24:54	2026-02-25 23:24:54
368	54	139	El sonido es lo importante y aquí brilla con luz propia.	2026-02-27 10:13:31	2026-02-27 10:13:31
369	66	139	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-28 09:23:45	2026-02-28 09:23:45
370	88	139	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-23 08:00:29	2026-02-23 08:00:29
371	82	139	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-28 06:13:41	2026-02-28 06:13:41
372	91	140	Merece la pena.	2026-02-25 07:44:00	2026-02-25 07:44:00
373	36	141	Every listen reveals new layers in familiar recordings.	2026-02-22 23:48:29	2026-02-22 23:48:29
374	13	141	Excelente calidad de sonido.	2026-02-27 17:23:55	2026-02-27 17:23:55
375	55	141	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-27 10:03:27	2026-02-27 10:03:27
376	13	142	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-24 08:45:05	2026-02-24 08:45:05
377	71	142	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-25 12:24:05	2026-02-25 12:24:05
378	50	142	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-26 10:32:56	2026-02-26 10:32:56
379	45	142	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-28 19:15:50	2026-02-28 19:15:50
380	56	143	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-24 14:10:45	2026-02-24 14:10:45
381	18	144	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-27 21:52:50	2026-02-27 21:52:50
382	1	144	Flat pressing ensures consistent playback across the entire record.	2026-02-21 15:22:51	2026-02-21 15:22:51
383	44	144	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-25 05:18:31	2026-02-25 05:18:31
384	23	144	Sonido impecable.	2026-02-28 08:00:40	2026-02-28 08:00:40
385	95	145	El centrado del label es perfecto, detalles que importan.	2026-02-25 15:01:00	2026-02-25 15:01:00
386	34	146	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-20 21:31:26	2026-02-20 21:31:26
387	43	146	Calidad consistente de principio a fin del disco.	2026-02-28 00:31:38	2026-02-28 00:31:38
388	29	147	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-27 20:40:10	2026-02-27 20:40:10
389	11	148	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-28 07:47:18	2026-02-28 07:47:18
390	9	148	Sonido rico y detallado.	2026-02-20 02:23:07	2026-02-20 02:23:07
391	91	148	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-22 00:58:57	2026-02-22 00:58:57
392	62	149	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-25 23:14:03	2026-02-25 23:14:03
393	22	150	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-25 07:35:29	2026-02-25 07:35:29
394	68	150	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-22 16:57:35	2026-02-22 16:57:35
395	41	150	Muy satisfecho.	2026-02-24 04:05:57	2026-02-24 04:05:57
396	27	150	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-27 16:27:55	2026-02-27 16:27:55
397	7	151	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-21 06:29:22	2026-02-21 06:29:22
398	32	151	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-25 19:08:27	2026-02-25 19:08:27
399	16	151	Sonido espectacular.	2026-02-21 18:41:21	2026-02-21 18:41:21
400	61	151	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-25 09:34:14	2026-02-25 09:34:14
401	86	152	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-28 07:49:28	2026-02-28 07:49:28
402	68	152	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-20 17:40:26	2026-02-20 17:40:26
403	40	153	Sonido impecable.	2026-02-26 22:15:36	2026-02-26 22:15:36
404	45	154	El simple acto de colocar la aguja ya genera expectación.	2026-02-25 17:45:16	2026-02-25 17:45:16
405	41	155	Mastering for vinyl was clearly done with care and expertise.	2026-02-22 00:13:01	2026-02-22 00:13:01
406	20	155	Inmejorable relación calidad-precio.	2026-02-21 20:27:51	2026-02-21 20:27:51
407	79	156	Una compra segura si buscas calidad sin excesivos extras.	2026-02-20 08:01:19	2026-02-20 08:01:19
408	41	156	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-26 06:32:05	2026-02-26 06:32:05
409	97	157	Surface noise is minimal, allowing the music to speak for itself.	2026-02-28 19:30:54	2026-02-28 19:30:54
410	74	158	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-23 12:54:09	2026-02-23 12:54:09
411	30	158	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-24 00:20:01	2026-02-24 00:20:01
412	44	159	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-21 09:42:48	2026-02-21 09:42:48
413	22	159	La portada es una obra de arte por sí sola, además del contenido.	2026-02-26 13:51:20	2026-02-26 13:51:20
414	98	159	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-24 12:20:28	2026-02-24 12:20:28
415	6	160	Sonido impecable.	2026-02-24 21:29:05	2026-02-24 21:29:05
416	52	160	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-24 20:01:09	2026-02-24 20:01:09
417	88	160	Sonido rico y detallado.	2026-02-22 13:24:42	2026-02-22 13:24:42
418	76	160	Merece la pena.	2026-02-26 23:19:22	2026-02-26 23:19:22
419	13	161	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-28 21:20:14	2026-02-28 21:20:14
420	88	161	Una compra segura si buscas calidad sin excesivos extras.	2026-02-23 01:28:52	2026-02-23 01:28:52
421	47	161	El simple acto de colocar la aguja ya genera expectación.	2026-02-27 05:25:52	2026-02-27 05:25:52
422	84	162	Instrument separation is remarkable, each element has its own space.	2026-02-26 21:27:53	2026-02-26 21:27:53
423	63	162	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-24 12:00:17	2026-02-24 12:00:17
424	20	162	Mastering for vinyl was clearly done with care and expertise.	2026-02-23 22:52:03	2026-02-23 22:52:03
425	62	163	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-27 13:29:18	2026-02-27 13:29:18
426	76	163	Surface noise is minimal, allowing the music to speak for itself.	2026-02-27 09:56:38	2026-02-27 09:56:38
427	42	163	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-20 09:02:36	2026-02-20 09:02:36
428	34	163	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-26 01:54:11	2026-02-26 01:54:11
429	77	164	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-27 16:52:06	2026-02-27 16:52:06
430	31	165	Every listen reveals new layers in familiar recordings.	2026-02-22 20:10:57	2026-02-22 20:10:57
431	64	165	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-21 12:55:21	2026-02-21 12:55:21
432	22	166	Muy satisfecho.	2026-02-22 21:58:44	2026-02-22 21:58:44
433	81	166	Calidad excepcional.	2026-02-26 12:12:41	2026-02-26 12:12:41
434	1	166	The soundstage is wide and deep, creating an immersive experience.	2026-02-20 01:04:10	2026-02-20 01:04:10
435	66	166	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-25 02:53:51	2026-02-25 02:53:51
436	81	167	El simple acto de colocar la aguja ya genera expectación.	2026-02-25 03:20:38	2026-02-25 03:20:38
437	13	167	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-26 08:36:18	2026-02-26 08:36:18
438	40	168	Sonido espectacular.	2026-02-24 00:50:47	2026-02-24 00:50:47
439	31	168	Experiencia completa.	2026-02-28 19:16:12	2026-02-28 19:16:12
440	13	168	La portada es una obra de arte por sí sola, además del contenido.	2026-02-20 17:27:59	2026-02-20 17:27:59
441	41	169	Inmejorable relación calidad-precio.	2026-02-24 12:43:53	2026-02-24 12:43:53
442	22	169	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-23 07:05:19	2026-02-23 07:05:19
443	49	170	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-26 17:33:47	2026-02-26 17:33:47
444	54	170	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-28 01:56:41	2026-02-28 01:56:41
445	9	170	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-26 09:27:59	2026-02-26 09:27:59
446	29	171	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-23 14:23:30	2026-02-23 14:23:30
447	38	171	Pressing de calidad.	2026-02-24 05:46:08	2026-02-24 05:46:08
448	82	171	El sonido es lo importante y aquí brilla con luz propia.	2026-02-20 20:03:07	2026-02-20 20:03:07
449	77	172	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-28 03:17:43	2026-02-28 03:17:43
450	26	172	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-26 10:58:10	2026-02-26 10:58:10
451	66	173	Mastering for vinyl was clearly done with care and expertise.	2026-02-21 04:05:24	2026-02-21 04:05:24
452	48	174	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-22 17:01:17	2026-02-22 17:01:17
453	43	174	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-28 21:15:49	2026-02-28 21:15:49
454	89	175	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-21 20:59:50	2026-02-21 20:59:50
455	37	176	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-27 16:51:15	2026-02-27 16:51:15
456	91	176	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-27 22:11:25	2026-02-27 22:11:25
457	83	176	El sonido es lo importante y aquí brilla con luz propia.	2026-02-20 06:05:45	2026-02-20 06:05:45
458	35	176	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-21 16:54:33	2026-02-21 16:54:33
459	36	177	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-23 03:30:04	2026-02-23 03:30:04
460	43	177	Experiencia completa.	2026-02-27 04:15:23	2026-02-27 04:15:23
461	2	177	Surface noise is minimal, allowing the music to speak for itself.	2026-02-23 04:25:09	2026-02-23 04:25:09
462	65	177	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-21 04:36:05	2026-02-21 04:36:05
463	72	178	The vinyl compound seems high-quality with excellent durability.	2026-02-22 12:39:44	2026-02-22 12:39:44
464	1	179	Recomendación absoluta.	2026-02-23 02:27:47	2026-02-23 02:27:47
465	29	179	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-24 21:05:48	2026-02-24 21:05:48
466	16	179	Muy satisfecho.	2026-02-22 07:12:42	2026-02-22 07:12:42
467	46	180	Merece la pena.	2026-02-20 09:42:18	2026-02-20 09:42:18
468	52	180	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-24 07:33:06	2026-02-24 07:33:06
469	38	181	Calidad excepcional.	2026-02-20 09:50:10	2026-02-20 09:50:10
470	61	181	The soundstage is wide and deep, creating an immersive experience.	2026-02-23 16:29:54	2026-02-23 16:29:54
471	39	181	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-24 21:58:01	2026-02-24 21:58:01
472	66	182	Merece la pena.	2026-02-28 18:34:20	2026-02-28 18:34:20
473	26	182	Recomendación absoluta.	2026-02-22 20:02:53	2026-02-22 20:02:53
474	97	182	El sonido es lo importante y aquí brilla con luz propia.	2026-02-26 14:51:27	2026-02-26 14:51:27
475	18	182	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-21 23:33:00	2026-02-21 23:33:00
476	45	183	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-27 06:27:52	2026-02-27 06:27:52
477	6	183	Calidad excepcional.	2026-02-22 03:56:04	2026-02-22 03:56:04
478	5	184	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-27 17:05:23	2026-02-27 17:05:23
479	72	184	Recomendación absoluta.	2026-02-25 02:25:28	2026-02-25 02:25:28
480	100	185	Instrument separation is remarkable, each element has its own space.	2026-02-21 15:57:14	2026-02-21 15:57:14
481	41	185	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-24 12:08:11	2026-02-24 12:08:11
482	28	185	Surface noise is minimal, allowing the music to speak for itself.	2026-02-24 13:04:36	2026-02-24 13:04:36
483	99	185	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-25 17:12:12	2026-02-25 17:12:12
484	88	186	Inmejorable relación calidad-precio.	2026-02-24 07:41:59	2026-02-24 07:41:59
485	29	186	The analog warmth brings out emotions in the music that digital misses.	2026-02-21 15:04:10	2026-02-21 15:04:10
486	32	186	The vinyl compound seems high-quality with excellent durability.	2026-02-20 12:41:19	2026-02-20 12:41:19
487	58	186	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-25 04:46:40	2026-02-25 04:46:40
488	95	187	Recomendación absoluta.	2026-02-27 21:53:39	2026-02-27 21:53:39
489	65	188	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-20 02:10:33	2026-02-20 02:10:33
490	64	188	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-25 16:46:47	2026-02-25 16:46:47
491	90	189	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-22 05:59:39	2026-02-22 05:59:39
492	95	189	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-28 01:44:01	2026-02-28 01:44:01
493	97	189	Instrument separation is remarkable, each element has its own space.	2026-02-25 09:24:49	2026-02-25 09:24:49
494	71	190	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-22 06:01:43	2026-02-22 06:01:43
495	45	191	Excelente calidad de sonido.	2026-02-23 13:43:03	2026-02-23 13:43:03
496	48	191	Sonido espectacular.	2026-02-25 03:43:05	2026-02-25 03:43:05
497	49	192	Calidad premium.	2026-02-27 20:06:48	2026-02-27 20:06:48
498	90	192	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-23 09:00:02	2026-02-23 09:00:02
499	2	193	Mastering for vinyl was clearly done with care and expertise.	2026-02-26 14:37:53	2026-02-26 14:37:53
500	21	193	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-26 14:36:02	2026-02-26 14:36:02
501	26	193	Every listen reveals new layers in familiar recordings.	2026-02-28 22:04:19	2026-02-28 22:04:19
502	25	193	Flat pressing ensures consistent playback across the entire record.	2026-02-26 12:09:22	2026-02-26 12:09:22
503	42	194	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-21 04:57:11	2026-02-21 04:57:11
504	53	194	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-21 22:40:17	2026-02-21 22:40:17
505	82	195	Excelente calidad de sonido.	2026-02-25 09:40:02	2026-02-25 09:40:02
506	25	195	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-28 20:40:37	2026-02-28 20:40:37
507	61	195	Inmejorable relación calidad-precio.	2026-02-26 07:51:33	2026-02-26 07:51:33
508	100	196	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-24 19:24:58	2026-02-24 19:24:58
509	97	196	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-24 15:36:37	2026-02-24 15:36:37
510	51	196	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-23 10:38:00	2026-02-23 10:38:00
511	75	197	Recomendación absoluta.	2026-02-25 11:41:59	2026-02-25 11:41:59
512	62	197	Flat pressing ensures consistent playback across the entire record.	2026-02-23 07:16:40	2026-02-23 07:16:40
513	92	198	The vinyl compound seems high-quality with excellent durability.	2026-02-21 20:35:37	2026-02-21 20:35:37
514	41	198	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-26 16:35:31	2026-02-26 16:35:31
515	87	198	Sonido impecable.	2026-02-26 00:36:43	2026-02-26 00:36:43
516	75	198	El sonido es lo importante y aquí brilla con luz propia.	2026-02-25 13:29:05	2026-02-25 13:29:05
517	70	199	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-26 07:56:33	2026-02-26 07:56:33
518	13	200	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-24 00:10:41	2026-02-24 00:10:41
519	54	200	Every listen reveals new layers in familiar recordings.	2026-02-22 03:57:31	2026-02-22 03:57:31
520	59	200	El simple acto de colocar la aguja ya genera expectación.	2026-02-23 16:52:28	2026-02-23 16:52:28
521	40	201	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-22 00:55:12	2026-02-22 00:55:12
522	41	201	Sonido rico y detallado.	2026-02-28 07:40:53	2026-02-28 07:40:53
523	37	202	The vinyl compound seems high-quality with excellent durability.	2026-02-23 11:22:45	2026-02-23 11:22:45
524	72	202	El producto cumple con lo prometido y algo más.	2026-02-27 17:27:32	2026-02-27 17:27:32
525	23	202	Inmejorable relación calidad-precio.	2026-02-24 21:14:04	2026-02-24 21:14:04
526	15	203	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-21 03:49:37	2026-02-21 03:49:37
527	73	204	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-28 12:39:50	2026-02-28 12:39:50
528	98	204	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-28 07:02:23	2026-02-28 07:02:23
529	44	204	Sonido impecable.	2026-02-20 05:04:52	2026-02-20 05:04:52
530	43	204	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-20 08:08:52	2026-02-20 08:08:52
531	42	205	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-22 10:17:03	2026-02-22 10:17:03
532	1	206	Inmejorable relación calidad-precio.	2026-02-20 22:25:33	2026-02-20 22:25:33
533	15	206	Every listen reveals new layers in familiar recordings.	2026-02-21 20:55:49	2026-02-21 20:55:49
534	37	207	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-27 10:03:23	2026-02-27 10:03:23
535	40	208	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-26 12:06:13	2026-02-26 12:06:13
536	29	208	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-24 05:59:47	2026-02-24 05:59:47
537	52	208	El sonido es lo importante y aquí brilla con luz propia.	2026-02-25 05:23:46	2026-02-25 05:23:46
538	10	209	El centrado del label es perfecto, detalles que importan.	2026-02-24 09:33:19	2026-02-24 09:33:19
539	62	209	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-23 08:59:10	2026-02-23 08:59:10
540	60	209	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-28 00:37:05	2026-02-28 00:37:05
541	40	210	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-25 02:48:28	2026-02-25 02:48:28
542	66	211	Inmejorable relación calidad-precio.	2026-02-27 23:15:02	2026-02-27 23:15:02
543	43	211	Sonido impecable.	2026-02-28 02:36:28	2026-02-28 02:36:28
544	56	211	The soundstage is wide and deep, creating an immersive experience.	2026-02-22 00:02:48	2026-02-22 00:02:48
545	65	212	Totalmente recomendado.	2026-02-21 20:04:37	2026-02-21 20:04:37
546	72	213	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-20 05:42:00	2026-02-20 05:42:00
547	50	213	El centrado del label es perfecto, detalles que importan.	2026-02-28 03:28:50	2026-02-28 03:28:50
548	62	213	Sonido impecable.	2026-02-23 16:31:53	2026-02-23 16:31:53
549	60	213	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-23 18:44:08	2026-02-23 18:44:08
550	54	214	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-23 18:07:39	2026-02-23 18:07:39
551	1	214	The analog warmth brings out emotions in the music that digital misses.	2026-02-26 15:42:59	2026-02-26 15:42:59
552	22	215	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-26 12:44:26	2026-02-26 12:44:26
553	63	215	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-24 04:49:18	2026-02-24 04:49:18
554	44	215	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-25 21:48:05	2026-02-25 21:48:05
555	90	215	Una compra segura si buscas calidad sin excesivos extras.	2026-02-26 11:11:35	2026-02-26 11:11:35
556	87	216	Edición cuidada.	2026-02-28 14:29:49	2026-02-28 14:29:49
557	24	217	Excelente calidad de sonido.	2026-02-27 10:42:44	2026-02-27 10:42:44
558	77	217	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-22 22:29:59	2026-02-22 22:29:59
559	5	218	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-27 13:23:39	2026-02-27 13:23:39
560	74	218	Recomendación absoluta.	2026-02-25 17:56:33	2026-02-25 17:56:33
561	90	218	Muy satisfecho.	2026-02-23 13:33:52	2026-02-23 13:33:52
562	4	219	The analog warmth brings out emotions in the music that digital misses.	2026-02-22 22:31:05	2026-02-22 22:31:05
563	55	220	Calidad excepcional.	2026-02-27 17:53:13	2026-02-27 17:53:13
564	54	221	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-25 04:32:06	2026-02-25 04:32:06
565	58	221	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-26 09:13:16	2026-02-26 09:13:16
566	23	221	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-27 05:01:22	2026-02-27 05:01:22
567	15	221	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-23 11:07:42	2026-02-23 11:07:42
568	11	222	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-28 17:58:56	2026-02-28 17:58:56
569	24	222	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-27 02:22:43	2026-02-27 02:22:43
570	61	222	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-20 12:52:40	2026-02-20 12:52:40
571	53	222	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-27 10:54:57	2026-02-27 10:54:57
572	58	223	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-22 01:13:01	2026-02-22 01:13:01
573	69	223	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-27 16:27:05	2026-02-27 16:27:05
574	64	223	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-21 06:16:42	2026-02-21 06:16:42
575	3	224	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-27 14:17:28	2026-02-27 14:17:28
576	35	224	Sonido espectacular.	2026-02-23 07:18:56	2026-02-23 07:18:56
577	90	224	El producto cumple con lo prometido y algo más.	2026-02-21 01:36:08	2026-02-21 01:36:08
578	65	224	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-20 14:16:05	2026-02-20 14:16:05
579	7	225	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-21 23:28:19	2026-02-21 23:28:19
580	40	225	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-22 08:26:29	2026-02-22 08:26:29
581	71	226	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-25 07:43:30	2026-02-25 07:43:30
582	21	226	Flat pressing ensures consistent playback across the entire record.	2026-02-23 09:50:15	2026-02-23 09:50:15
583	93	226	El sonido es lo importante y aquí brilla con luz propia.	2026-02-28 09:28:46	2026-02-28 09:28:46
584	56	227	Totalmente recomendado.	2026-02-25 17:10:17	2026-02-25 17:10:17
585	86	227	Sonido impecable.	2026-02-20 10:00:59	2026-02-20 10:00:59
586	66	228	Inmejorable relación calidad-precio.	2026-02-20 18:38:16	2026-02-20 18:38:16
587	50	228	The vinyl compound seems high-quality with excellent durability.	2026-02-23 22:52:40	2026-02-23 22:52:40
588	74	228	Experiencia completa.	2026-02-28 15:02:27	2026-02-28 15:02:27
589	31	228	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-21 04:02:00	2026-02-21 04:02:00
590	84	229	El simple acto de colocar la aguja ya genera expectación.	2026-02-21 09:02:24	2026-02-21 09:02:24
591	79	230	Sonido impecable.	2026-02-27 18:04:59	2026-02-27 18:04:59
592	13	230	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-27 14:14:41	2026-02-27 14:14:41
593	55	231	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-25 16:51:26	2026-02-25 16:51:26
594	85	231	Inmejorable relación calidad-precio.	2026-02-28 14:26:21	2026-02-28 14:26:21
595	3	231	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-20 10:30:08	2026-02-20 10:30:08
596	1	232	Pressing de calidad.	2026-02-23 16:15:21	2026-02-23 16:15:21
597	52	232	Instrument separation is remarkable, each element has its own space.	2026-02-28 10:54:44	2026-02-28 10:54:44
598	44	232	El producto cumple con lo prometido y algo más.	2026-02-20 05:17:28	2026-02-20 05:17:28
599	92	233	Recomendación absoluta.	2026-02-28 19:04:04	2026-02-28 19:04:04
600	63	233	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-23 03:23:46	2026-02-23 03:23:46
601	25	234	Totalmente recomendado.	2026-02-23 20:56:10	2026-02-23 20:56:10
602	95	234	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-22 11:56:30	2026-02-22 11:56:30
603	81	234	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-24 20:31:47	2026-02-24 20:31:47
604	61	234	Inmejorable relación calidad-precio.	2026-02-27 19:27:07	2026-02-27 19:27:07
605	33	235	Calidad premium.	2026-02-26 10:31:39	2026-02-26 10:31:39
606	41	236	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-23 02:37:34	2026-02-23 02:37:34
607	18	236	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-21 12:02:04	2026-02-21 12:02:04
608	39	237	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-24 10:28:11	2026-02-24 10:28:11
609	64	237	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-20 08:46:30	2026-02-20 08:46:30
610	67	237	El sonido es lo importante y aquí brilla con luz propia.	2026-02-26 14:49:14	2026-02-26 14:49:14
611	92	238	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-20 01:20:56	2026-02-20 01:20:56
612	62	239	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-28 00:01:48	2026-02-28 00:01:48
613	85	239	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-28 17:26:53	2026-02-28 17:26:53
614	25	239	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-24 02:23:44	2026-02-24 02:23:44
615	17	240	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-23 00:18:32	2026-02-23 00:18:32
616	16	240	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-28 14:39:30	2026-02-28 14:39:30
617	60	240	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-23 18:34:59	2026-02-23 18:34:59
618	7	240	La portada es una obra de arte por sí sola, además del contenido.	2026-02-26 13:49:20	2026-02-26 13:49:20
619	22	241	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-22 05:58:08	2026-02-22 05:58:08
620	62	242	Sonido rico y detallado.	2026-02-24 12:24:03	2026-02-24 12:24:03
621	35	242	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-20 13:21:02	2026-02-20 13:21:02
622	68	242	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-23 00:28:34	2026-02-23 00:28:34
623	22	242	Surface noise is minimal, allowing the music to speak for itself.	2026-02-27 21:52:31	2026-02-27 21:52:31
624	39	243	La portada es una obra de arte por sí sola, además del contenido.	2026-02-26 07:58:41	2026-02-26 07:58:41
625	4	243	Calidad excepcional.	2026-02-27 03:28:19	2026-02-27 03:28:19
626	42	244	Excelente calidad de sonido.	2026-02-22 20:19:34	2026-02-22 20:19:34
627	59	245	The soundstage is wide and deep, creating an immersive experience.	2026-02-21 02:06:27	2026-02-21 02:06:27
628	67	245	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-26 13:47:18	2026-02-26 13:47:18
629	17	245	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-20 14:45:03	2026-02-20 14:45:03
630	15	246	Instrument separation is remarkable, each element has its own space.	2026-02-26 03:02:57	2026-02-26 03:02:57
631	8	246	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-25 06:10:39	2026-02-25 06:10:39
632	74	246	El sonido es lo importante y aquí brilla con luz propia.	2026-02-20 23:29:32	2026-02-20 23:29:32
633	78	247	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-23 15:57:43	2026-02-23 15:57:43
634	75	248	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-21 09:09:23	2026-02-21 09:09:23
635	44	249	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-27 16:38:28	2026-02-27 16:38:28
636	81	249	Sonido espectacular.	2026-02-26 01:05:25	2026-02-26 01:05:25
637	62	249	The analog warmth brings out emotions in the music that digital misses.	2026-02-27 06:18:28	2026-02-27 06:18:28
638	84	249	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-25 08:43:42	2026-02-25 08:43:42
639	23	250	El centrado del label es perfecto, detalles que importan.	2026-02-27 06:15:39	2026-02-27 06:15:39
640	17	250	Instrument separation is remarkable, each element has its own space.	2026-02-22 06:45:00	2026-02-22 06:45:00
641	31	250	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-21 22:33:25	2026-02-21 22:33:25
642	80	250	Calidad premium.	2026-02-21 10:26:43	2026-02-21 10:26:43
643	49	251	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-21 16:09:57	2026-02-21 16:09:57
644	78	251	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-26 03:47:19	2026-02-26 03:47:19
645	36	251	Calidad consistente de principio a fin del disco.	2026-02-23 18:03:02	2026-02-23 18:03:02
646	90	251	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-23 06:59:35	2026-02-23 06:59:35
647	53	252	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-26 01:27:04	2026-02-26 01:27:04
648	6	252	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-25 19:06:32	2026-02-25 19:06:32
649	22	252	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-27 15:07:46	2026-02-27 15:07:46
650	64	253	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-27 14:31:10	2026-02-27 14:31:10
651	35	253	El producto cumple con lo prometido y algo más.	2026-02-28 03:47:37	2026-02-28 03:47:37
652	99	253	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-28 06:24:38	2026-02-28 06:24:38
653	60	253	The analog warmth brings out emotions in the music that digital misses.	2026-02-25 16:35:13	2026-02-25 16:35:13
654	22	254	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-28 20:04:50	2026-02-28 20:04:50
655	46	254	Una compra segura si buscas calidad sin excesivos extras.	2026-02-23 19:21:11	2026-02-23 19:21:11
656	51	254	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-21 08:04:51	2026-02-21 08:04:51
657	39	254	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-27 01:15:55	2026-02-27 01:15:55
658	28	255	Sonido rico y detallado.	2026-02-21 01:30:37	2026-02-21 01:30:37
659	62	256	Muy satisfecho.	2026-02-21 14:09:25	2026-02-21 14:09:25
660	85	257	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-25 13:25:43	2026-02-25 13:25:43
661	88	257	Muy buen pressing.	2026-02-28 18:51:40	2026-02-28 18:51:40
662	9	258	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-22 07:31:26	2026-02-22 07:31:26
663	81	259	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-28 06:30:29	2026-02-28 06:30:29
664	91	259	Every listen reveals new layers in familiar recordings.	2026-02-22 08:28:13	2026-02-22 08:28:13
665	26	259	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-26 04:56:38	2026-02-26 04:56:38
666	25	259	El producto cumple con lo prometido y algo más.	2026-02-28 23:33:50	2026-02-28 23:33:50
667	35	260	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-25 10:55:53	2026-02-25 10:55:53
668	12	260	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-24 23:48:26	2026-02-24 23:48:26
669	45	260	The vinyl compound seems high-quality with excellent durability.	2026-02-26 00:06:49	2026-02-26 00:06:49
670	9	260	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-28 19:55:28	2026-02-28 19:55:28
671	69	261	Sonido espectacular.	2026-02-21 17:23:54	2026-02-21 17:23:54
672	82	261	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-21 09:16:24	2026-02-21 09:16:24
673	9	261	Calidad consistente de principio a fin del disco.	2026-02-26 10:05:39	2026-02-26 10:05:39
674	12	262	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-23 04:25:09	2026-02-23 04:25:09
675	29	262	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-23 14:54:33	2026-02-23 14:54:33
676	9	262	Sonido rico y detallado.	2026-02-24 23:06:22	2026-02-24 23:06:22
677	86	263	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-25 02:37:21	2026-02-25 02:37:21
678	28	263	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-24 16:51:13	2026-02-24 16:51:13
679	56	264	Calidad premium.	2026-02-21 19:17:12	2026-02-21 19:17:12
680	55	264	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-27 14:05:40	2026-02-27 14:05:40
681	34	265	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-20 08:21:33	2026-02-20 08:21:33
682	11	266	Calidad excepcional.	2026-02-22 09:51:34	2026-02-22 09:51:34
683	99	267	Calidad consistente de principio a fin del disco.	2026-02-22 17:53:52	2026-02-22 17:53:52
684	64	268	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-20 00:34:31	2026-02-20 00:34:31
685	57	269	Excelente calidad de sonido.	2026-02-21 13:41:31	2026-02-21 13:41:31
686	86	269	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-23 14:31:21	2026-02-23 14:31:21
687	96	269	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-21 20:02:40	2026-02-21 20:02:40
688	66	270	El centrado del label es perfecto, detalles que importan.	2026-02-20 17:07:28	2026-02-20 17:07:28
689	12	270	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-21 05:05:20	2026-02-21 05:05:20
690	4	270	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-23 08:11:54	2026-02-23 08:11:54
691	93	270	El producto cumple con lo prometido y algo más.	2026-02-23 01:20:48	2026-02-23 01:20:48
692	85	271	Calidad consistente de principio a fin del disco.	2026-02-26 06:36:25	2026-02-26 06:36:25
693	98	271	Every listen reveals new layers in familiar recordings.	2026-02-20 09:10:12	2026-02-20 09:10:12
694	47	271	The analog warmth brings out emotions in the music that digital misses.	2026-02-28 06:50:11	2026-02-28 06:50:11
695	61	271	Inmejorable relación calidad-precio.	2026-02-25 15:02:59	2026-02-25 15:02:59
696	79	272	El sonido es lo importante y aquí brilla con luz propia.	2026-02-27 01:42:20	2026-02-27 01:42:20
697	62	272	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-23 11:38:04	2026-02-23 11:38:04
698	38	273	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-24 13:43:55	2026-02-24 13:43:55
699	36	273	Flat pressing ensures consistent playback across the entire record.	2026-02-21 17:33:25	2026-02-21 17:33:25
700	82	273	Mastering for vinyl was clearly done with care and expertise.	2026-02-27 00:07:48	2026-02-27 00:07:48
701	67	274	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-25 23:30:48	2026-02-25 23:30:48
702	88	274	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-27 04:47:57	2026-02-27 04:47:57
703	41	274	El centrado del label es perfecto, detalles que importan.	2026-02-23 14:46:11	2026-02-23 14:46:11
704	48	274	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-26 05:43:26	2026-02-26 05:43:26
705	21	275	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-25 05:23:35	2026-02-25 05:23:35
706	56	275	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-22 09:04:28	2026-02-22 09:04:28
707	73	275	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-24 14:25:14	2026-02-24 14:25:14
708	60	276	The vinyl compound seems high-quality with excellent durability.	2026-02-28 22:57:05	2026-02-28 22:57:05
709	35	277	Excelente calidad de sonido.	2026-02-22 07:19:13	2026-02-22 07:19:13
710	65	277	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-23 14:38:57	2026-02-23 14:38:57
711	8	277	Una compra segura si buscas calidad sin excesivos extras.	2026-02-24 13:34:48	2026-02-24 13:34:48
712	90	277	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-27 21:35:04	2026-02-27 21:35:04
713	12	278	Totalmente recomendado.	2026-02-22 23:46:37	2026-02-22 23:46:37
714	20	278	Inmejorable relación calidad-precio.	2026-02-23 01:11:21	2026-02-23 01:11:21
715	60	279	Muy buen pressing.	2026-02-22 22:43:20	2026-02-22 22:43:20
716	96	279	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-23 08:56:33	2026-02-23 08:56:33
717	22	280	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-25 00:39:47	2026-02-25 00:39:47
718	35	280	Una compra segura si buscas calidad sin excesivos extras.	2026-02-23 05:05:38	2026-02-23 05:05:38
719	87	280	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-26 14:59:53	2026-02-26 14:59:53
720	47	281	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-20 23:06:35	2026-02-20 23:06:35
721	4	281	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-26 08:22:46	2026-02-26 08:22:46
722	43	281	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-25 16:13:58	2026-02-25 16:13:58
723	74	281	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-21 03:38:28	2026-02-21 03:38:28
724	71	282	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-22 20:09:18	2026-02-22 20:09:18
725	50	282	Excelente calidad de sonido.	2026-02-25 03:44:04	2026-02-25 03:44:04
726	11	282	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-23 07:50:01	2026-02-23 07:50:01
727	7	283	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-20 01:19:16	2026-02-20 01:19:16
728	49	283	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-21 09:28:46	2026-02-21 09:28:46
729	55	283	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-23 18:23:53	2026-02-23 18:23:53
730	6	284	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-26 12:01:03	2026-02-26 12:01:03
731	99	284	El producto cumple con lo prometido y algo más.	2026-02-22 02:28:00	2026-02-22 02:28:00
732	3	285	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-28 21:07:33	2026-02-28 21:07:33
733	65	285	Muy satisfecho.	2026-02-22 20:13:22	2026-02-22 20:13:22
734	81	286	Muy buen pressing.	2026-02-21 18:01:11	2026-02-21 18:01:11
735	20	286	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-26 20:45:35	2026-02-26 20:45:35
736	73	286	The soundstage is wide and deep, creating an immersive experience.	2026-02-25 12:08:17	2026-02-25 12:08:17
737	5	287	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-28 20:53:59	2026-02-28 20:53:59
738	93	287	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-24 09:30:04	2026-02-24 09:30:04
739	80	287	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-24 11:41:43	2026-02-24 11:41:43
740	98	287	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-24 13:52:55	2026-02-24 13:52:55
741	48	288	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-26 16:34:16	2026-02-26 16:34:16
742	48	289	Calidad consistente de principio a fin del disco.	2026-02-25 20:44:55	2026-02-25 20:44:55
743	8	290	Calidad premium.	2026-02-27 05:00:55	2026-02-27 05:00:55
744	55	290	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-20 09:34:12	2026-02-20 09:34:12
745	98	290	Calidad premium.	2026-02-24 20:48:03	2026-02-24 20:48:03
746	92	291	Calidad excepcional.	2026-02-20 15:22:44	2026-02-20 15:22:44
747	70	291	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-21 23:13:34	2026-02-21 23:13:34
748	66	291	Edición cuidada.	2026-02-26 08:22:55	2026-02-26 08:22:55
749	34	291	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-26 23:17:09	2026-02-26 23:17:09
750	48	292	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-22 06:41:10	2026-02-22 06:41:10
751	65	292	Experiencia completa.	2026-02-28 22:38:35	2026-02-28 22:38:35
752	61	293	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-28 22:02:14	2026-02-28 22:02:14
753	31	294	Totalmente recomendado.	2026-02-22 14:31:26	2026-02-22 14:31:26
754	75	294	Sonido rico y detallado.	2026-02-26 11:29:34	2026-02-26 11:29:34
755	75	295	Sonido espectacular.	2026-02-21 15:19:02	2026-02-21 15:19:02
756	65	296	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-23 15:37:41	2026-02-23 15:37:41
757	25	297	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-28 07:44:40	2026-02-28 07:44:40
758	49	297	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-21 19:02:49	2026-02-21 19:02:49
759	63	297	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-27 19:04:28	2026-02-27 19:04:28
760	28	298	Edición cuidada.	2026-02-23 04:39:58	2026-02-23 04:39:58
761	49	299	Flat pressing ensures consistent playback across the entire record.	2026-02-22 10:58:11	2026-02-22 10:58:11
762	99	299	The soundstage is wide and deep, creating an immersive experience.	2026-02-23 04:27:35	2026-02-23 04:27:35
763	51	300	Flat pressing ensures consistent playback across the entire record.	2026-02-20 07:34:04	2026-02-20 07:34:04
764	98	300	Edición cuidada.	2026-02-20 10:40:31	2026-02-20 10:40:31
765	100	301	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-23 04:02:45	2026-02-23 04:02:45
766	18	301	Pressing de calidad.	2026-02-25 20:10:11	2026-02-25 20:10:11
767	61	301	Sonido espectacular.	2026-02-23 17:17:55	2026-02-23 17:17:55
768	42	301	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-26 19:39:44	2026-02-26 19:39:44
769	67	302	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-26 15:20:32	2026-02-26 15:20:32
770	41	302	Inmejorable relación calidad-precio.	2026-02-22 08:12:57	2026-02-22 08:12:57
771	46	302	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-21 14:30:02	2026-02-21 14:30:02
772	68	302	El producto cumple con lo prometido y algo más.	2026-02-26 11:25:05	2026-02-26 11:25:05
773	42	303	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-28 11:54:05	2026-02-28 11:54:05
774	79	304	Calidad consistente de principio a fin del disco.	2026-02-28 00:57:16	2026-02-28 00:57:16
775	26	304	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-20 16:20:25	2026-02-20 16:20:25
776	27	304	Flat pressing ensures consistent playback across the entire record.	2026-02-26 19:28:32	2026-02-26 19:28:32
777	99	305	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-25 03:45:51	2026-02-25 03:45:51
1199	51	481	Muy satisfecho.	2026-02-25 13:25:14	2026-02-25 13:25:14
778	25	305	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-23 21:43:44	2026-02-23 21:43:44
779	38	305	Muy satisfecho.	2026-02-24 18:12:08	2026-02-24 18:12:08
780	54	305	Excelente calidad de sonido.	2026-02-22 23:39:09	2026-02-22 23:39:09
781	15	306	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-22 16:27:56	2026-02-22 16:27:56
782	41	306	El simple acto de colocar la aguja ya genera expectación.	2026-02-22 18:49:02	2026-02-22 18:49:02
783	81	306	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-26 09:49:59	2026-02-26 09:49:59
784	46	307	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-23 05:23:45	2026-02-23 05:23:45
785	98	307	Experiencia completa.	2026-02-27 13:52:54	2026-02-27 13:52:54
786	65	307	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-28 03:55:32	2026-02-28 03:55:32
787	13	307	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-23 00:03:55	2026-02-23 00:03:55
788	74	308	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-26 13:09:03	2026-02-26 13:09:03
789	47	309	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-26 02:40:52	2026-02-26 02:40:52
790	1	309	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-22 03:01:41	2026-02-22 03:01:41
791	36	309	Mastering for vinyl was clearly done with care and expertise.	2026-02-26 00:21:05	2026-02-26 00:21:05
792	60	309	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-25 14:04:07	2026-02-25 14:04:07
793	27	310	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-24 03:37:10	2026-02-24 03:37:10
794	20	310	Recomendación absoluta.	2026-02-20 19:38:58	2026-02-20 19:38:58
795	21	311	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-21 18:11:05	2026-02-21 18:11:05
796	7	311	Calidad consistente de principio a fin del disco.	2026-02-22 21:34:30	2026-02-22 21:34:30
797	38	311	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-20 04:54:25	2026-02-20 04:54:25
798	57	311	Recomendación absoluta.	2026-02-24 20:28:21	2026-02-24 20:28:21
799	16	312	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-25 13:18:28	2026-02-25 13:18:28
800	41	312	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-23 21:55:59	2026-02-23 21:55:59
801	48	313	The vinyl compound seems high-quality with excellent durability.	2026-02-26 07:15:01	2026-02-26 07:15:01
802	69	313	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-20 13:39:44	2026-02-20 13:39:44
803	66	313	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-28 06:12:34	2026-02-28 06:12:34
804	52	314	Calidad premium.	2026-02-26 21:00:43	2026-02-26 21:00:43
805	36	314	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-23 07:51:23	2026-02-23 07:51:23
806	94	314	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-28 02:54:53	2026-02-28 02:54:53
807	9	314	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-27 00:27:21	2026-02-27 00:27:21
808	31	315	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-28 07:40:38	2026-02-28 07:40:38
809	71	315	El producto cumple con lo prometido y algo más.	2026-02-25 14:28:39	2026-02-25 14:28:39
810	23	316	Edición cuidada.	2026-02-23 07:38:29	2026-02-23 07:38:29
811	16	316	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-24 13:08:26	2026-02-24 13:08:26
812	9	316	Una compra segura si buscas calidad sin excesivos extras.	2026-02-25 18:54:41	2026-02-25 18:54:41
813	88	316	The soundstage is wide and deep, creating an immersive experience.	2026-02-24 18:21:47	2026-02-24 18:21:47
814	50	317	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-23 16:34:59	2026-02-23 16:34:59
815	5	317	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-27 09:05:37	2026-02-27 09:05:37
816	84	317	Instrument separation is remarkable, each element has its own space.	2026-02-21 02:11:16	2026-02-21 02:11:16
817	99	317	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-26 21:54:07	2026-02-26 21:54:07
818	79	318	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-23 03:05:47	2026-02-23 03:05:47
819	100	318	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-20 04:36:26	2026-02-20 04:36:26
820	18	318	Calidad consistente de principio a fin del disco.	2026-02-20 23:44:33	2026-02-20 23:44:33
821	43	319	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-27 03:08:55	2026-02-27 03:08:55
822	8	319	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-27 01:42:12	2026-02-27 01:42:12
823	62	320	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-28 15:35:01	2026-02-28 15:35:01
824	61	321	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-28 03:39:08	2026-02-28 03:39:08
825	44	322	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-24 00:59:16	2026-02-24 00:59:16
826	44	323	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-25 12:18:36	2026-02-25 12:18:36
827	55	323	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-20 09:52:24	2026-02-20 09:52:24
828	42	324	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-26 05:26:54	2026-02-26 05:26:54
829	85	324	Pressing de calidad.	2026-02-27 16:51:58	2026-02-27 16:51:58
830	46	324	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-20 14:26:33	2026-02-20 14:26:33
831	26	324	Calidad excepcional.	2026-02-21 02:55:20	2026-02-21 02:55:20
832	30	325	Edición cuidada.	2026-02-25 01:34:39	2026-02-25 01:34:39
833	23	326	The analog warmth brings out emotions in the music that digital misses.	2026-02-22 04:36:21	2026-02-22 04:36:21
834	65	326	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-20 14:41:24	2026-02-20 14:41:24
835	26	326	Flat pressing ensures consistent playback across the entire record.	2026-02-25 21:33:48	2026-02-25 21:33:48
836	61	326	Mastering for vinyl was clearly done with care and expertise.	2026-02-22 17:58:01	2026-02-22 17:58:01
837	18	327	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-23 11:54:00	2026-02-23 11:54:00
838	45	327	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-22 16:50:40	2026-02-22 16:50:40
839	89	327	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-28 02:31:10	2026-02-28 02:31:10
840	19	328	Una compra segura si buscas calidad sin excesivos extras.	2026-02-21 02:20:47	2026-02-21 02:20:47
841	88	329	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-23 07:23:32	2026-02-23 07:23:32
842	85	330	El producto cumple con lo prometido y algo más.	2026-02-24 03:42:20	2026-02-24 03:42:20
843	41	330	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-28 18:43:38	2026-02-28 18:43:38
844	64	331	Inmejorable relación calidad-precio.	2026-02-21 09:15:11	2026-02-21 09:15:11
915	2	360	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-22 04:54:16	2026-02-22 04:54:16
845	99	331	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-21 07:13:12	2026-02-21 07:13:12
846	65	332	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-27 17:43:27	2026-02-27 17:43:27
847	32	333	The soundstage is wide and deep, creating an immersive experience.	2026-02-27 04:34:16	2026-02-27 04:34:16
848	20	333	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-24 12:02:38	2026-02-24 12:02:38
849	66	333	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-24 15:27:44	2026-02-24 15:27:44
850	47	333	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-26 17:38:21	2026-02-26 17:38:21
851	60	334	Calidad premium.	2026-02-25 02:49:59	2026-02-25 02:49:59
852	13	334	Mastering for vinyl was clearly done with care and expertise.	2026-02-27 19:39:49	2026-02-27 19:39:49
853	58	334	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-23 06:47:30	2026-02-23 06:47:30
854	59	334	El centrado del label es perfecto, detalles que importan.	2026-02-21 19:26:37	2026-02-21 19:26:37
855	93	335	Sonido rico y detallado.	2026-02-20 15:07:36	2026-02-20 15:07:36
856	7	335	Every listen reveals new layers in familiar recordings.	2026-02-28 11:19:36	2026-02-28 11:19:36
857	45	335	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-23 21:15:38	2026-02-23 21:15:38
858	13	336	The analog warmth brings out emotions in the music that digital misses.	2026-02-27 17:53:50	2026-02-27 17:53:50
859	17	336	El sonido es lo importante y aquí brilla con luz propia.	2026-02-23 19:37:51	2026-02-23 19:37:51
860	4	336	Mastering for vinyl was clearly done with care and expertise.	2026-02-23 19:49:34	2026-02-23 19:49:34
861	29	336	Instrument separation is remarkable, each element has its own space.	2026-02-23 02:45:13	2026-02-23 02:45:13
862	66	337	El sonido es lo importante y aquí brilla con luz propia.	2026-02-27 11:16:23	2026-02-27 11:16:23
863	11	337	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-27 05:20:41	2026-02-27 05:20:41
864	69	337	Merece la pena.	2026-02-21 00:14:05	2026-02-21 00:14:05
865	25	338	Totalmente recomendado.	2026-02-27 23:32:02	2026-02-27 23:32:02
866	24	339	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-28 11:04:59	2026-02-28 11:04:59
867	72	339	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-21 06:11:20	2026-02-21 06:11:20
868	36	340	Flat pressing ensures consistent playback across the entire record.	2026-02-26 23:46:36	2026-02-26 23:46:36
869	14	340	Merece la pena.	2026-02-26 08:27:51	2026-02-26 08:27:51
870	84	341	Muy satisfecho.	2026-02-22 20:33:12	2026-02-22 20:33:12
871	39	341	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-23 15:59:50	2026-02-23 15:59:50
872	5	341	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-26 17:23:29	2026-02-26 17:23:29
873	29	341	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-26 09:18:05	2026-02-26 09:18:05
874	66	342	The soundstage is wide and deep, creating an immersive experience.	2026-02-28 17:32:49	2026-02-28 17:32:49
875	3	343	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-28 01:03:53	2026-02-28 01:03:53
876	64	343	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-26 07:08:55	2026-02-26 07:08:55
877	4	343	Una compra segura si buscas calidad sin excesivos extras.	2026-02-21 08:34:43	2026-02-21 08:34:43
878	9	344	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-27 21:45:34	2026-02-27 21:45:34
879	91	344	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-27 17:32:57	2026-02-27 17:32:57
880	24	344	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-21 22:48:38	2026-02-21 22:48:38
881	32	345	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-28 22:27:04	2026-02-28 22:27:04
882	89	345	Mastering for vinyl was clearly done with care and expertise.	2026-02-24 17:22:15	2026-02-24 17:22:15
883	52	346	Calidad excepcional.	2026-02-28 00:16:14	2026-02-28 00:16:14
884	95	346	Calidad excepcional.	2026-02-21 11:20:02	2026-02-21 11:20:02
885	21	346	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-26 20:53:20	2026-02-26 20:53:20
886	9	346	Edición cuidada.	2026-02-21 01:20:47	2026-02-21 01:20:47
887	6	347	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-20 01:09:48	2026-02-20 01:09:48
888	53	348	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-21 16:02:10	2026-02-21 16:02:10
889	69	348	Mastering for vinyl was clearly done with care and expertise.	2026-02-25 15:05:21	2026-02-25 15:05:21
890	10	348	Inmejorable relación calidad-precio.	2026-02-28 08:14:03	2026-02-28 08:14:03
891	44	348	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-24 04:07:56	2026-02-24 04:07:56
892	9	349	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-28 00:53:35	2026-02-28 00:53:35
893	68	350	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-27 15:54:12	2026-02-27 15:54:12
894	90	350	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-26 10:04:52	2026-02-26 10:04:52
895	38	350	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-22 17:32:17	2026-02-22 17:32:17
896	17	350	Surface noise is minimal, allowing the music to speak for itself.	2026-02-28 23:37:02	2026-02-28 23:37:02
897	70	351	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-25 02:37:32	2026-02-25 02:37:32
898	82	351	El producto cumple con lo prometido y algo más.	2026-02-21 03:34:26	2026-02-21 03:34:26
899	3	351	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-22 00:52:35	2026-02-22 00:52:35
900	69	352	Sonido espectacular.	2026-02-24 13:02:42	2026-02-24 13:02:42
901	55	352	Sonido espectacular.	2026-02-24 19:17:45	2026-02-24 19:17:45
902	83	352	Sonido rico y detallado.	2026-02-28 06:55:52	2026-02-28 06:55:52
903	95	353	Instrument separation is remarkable, each element has its own space.	2026-02-20 14:44:00	2026-02-20 14:44:00
904	10	353	Edición cuidada.	2026-02-22 06:25:49	2026-02-22 06:25:49
905	78	354	Instrument separation is remarkable, each element has its own space.	2026-02-23 09:09:17	2026-02-23 09:09:17
906	57	355	The analog warmth brings out emotions in the music that digital misses.	2026-02-28 04:46:18	2026-02-28 04:46:18
907	5	355	Surface noise is minimal, allowing the music to speak for itself.	2026-02-21 21:52:39	2026-02-21 21:52:39
908	12	356	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-23 10:41:51	2026-02-23 10:41:51
909	27	356	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-24 17:26:32	2026-02-24 17:26:32
910	44	356	Surface noise is minimal, allowing the music to speak for itself.	2026-02-25 22:01:18	2026-02-25 22:01:18
911	5	357	Mastering for vinyl was clearly done with care and expertise.	2026-02-27 07:37:55	2026-02-27 07:37:55
912	73	358	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-23 16:53:54	2026-02-23 16:53:54
913	71	359	The vinyl compound seems high-quality with excellent durability.	2026-02-26 03:36:14	2026-02-26 03:36:14
916	91	360	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-28 10:27:22	2026-02-28 10:27:22
917	71	361	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-25 20:06:47	2026-02-25 20:06:47
918	36	362	Muy satisfecho.	2026-02-22 11:51:15	2026-02-22 11:51:15
919	77	362	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-22 09:52:59	2026-02-22 09:52:59
920	39	363	El simple acto de colocar la aguja ya genera expectación.	2026-02-25 22:57:23	2026-02-25 22:57:23
921	93	363	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-23 08:25:10	2026-02-23 08:25:10
922	73	363	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-24 02:53:39	2026-02-24 02:53:39
923	12	363	Edición cuidada.	2026-02-25 02:25:13	2026-02-25 02:25:13
924	58	364	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-28 19:54:05	2026-02-28 19:54:05
925	12	364	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-22 08:29:32	2026-02-22 08:29:32
926	49	365	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-27 00:36:56	2026-02-27 00:36:56
927	30	365	Every listen reveals new layers in familiar recordings.	2026-02-24 17:05:12	2026-02-24 17:05:12
928	27	366	El simple acto de colocar la aguja ya genera expectación.	2026-02-20 09:12:56	2026-02-20 09:12:56
929	43	366	The analog warmth brings out emotions in the music that digital misses.	2026-02-27 02:32:58	2026-02-27 02:32:58
930	94	366	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-22 20:54:11	2026-02-22 20:54:11
931	21	366	Inmejorable relación calidad-precio.	2026-02-27 10:33:59	2026-02-27 10:33:59
932	90	367	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-23 01:32:02	2026-02-23 01:32:02
933	44	367	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-24 07:32:28	2026-02-24 07:32:28
934	88	367	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-24 02:27:48	2026-02-24 02:27:48
935	98	367	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-28 17:48:41	2026-02-28 17:48:41
936	14	368	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-26 10:47:43	2026-02-26 10:47:43
937	36	368	Sonido rico y detallado.	2026-02-25 15:43:38	2026-02-25 15:43:38
938	21	369	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-28 11:49:16	2026-02-28 11:49:16
939	47	370	Una compra segura si buscas calidad sin excesivos extras.	2026-02-20 20:36:15	2026-02-20 20:36:15
940	1	371	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-25 03:57:58	2026-02-25 03:57:58
941	74	372	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-21 22:45:34	2026-02-21 22:45:34
942	56	372	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-24 19:36:57	2026-02-24 19:36:57
943	59	373	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-21 18:26:02	2026-02-21 18:26:02
944	100	373	El simple acto de colocar la aguja ya genera expectación.	2026-02-21 09:30:53	2026-02-21 09:30:53
945	67	374	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-22 14:26:17	2026-02-22 14:26:17
946	45	375	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-20 01:11:55	2026-02-20 01:11:55
947	72	375	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-25 08:21:12	2026-02-25 08:21:12
948	87	375	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-28 14:54:58	2026-02-28 14:54:58
949	16	375	El producto cumple con lo prometido y algo más.	2026-02-20 11:14:52	2026-02-20 11:14:52
950	20	376	The analog warmth brings out emotions in the music that digital misses.	2026-02-22 21:35:08	2026-02-22 21:35:08
951	54	376	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-23 08:34:23	2026-02-23 08:34:23
952	90	376	Experiencia completa.	2026-02-22 06:04:56	2026-02-22 06:04:56
953	20	377	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-28 21:22:40	2026-02-28 21:22:40
954	9	377	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-27 08:58:57	2026-02-27 08:58:57
955	51	377	The analog warmth brings out emotions in the music that digital misses.	2026-02-25 08:54:14	2026-02-25 08:54:14
956	87	377	El simple acto de colocar la aguja ya genera expectación.	2026-02-21 12:04:17	2026-02-21 12:04:17
957	99	378	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-22 08:35:39	2026-02-22 08:35:39
958	93	378	Sonido espectacular.	2026-02-21 21:53:48	2026-02-21 21:53:48
959	85	378	Edición cuidada.	2026-02-28 22:40:26	2026-02-28 22:40:26
960	74	378	El simple acto de colocar la aguja ya genera expectación.	2026-02-24 17:54:07	2026-02-24 17:54:07
961	77	379	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-26 22:03:22	2026-02-26 22:03:22
962	75	379	Surface noise is minimal, allowing the music to speak for itself.	2026-02-25 10:35:38	2026-02-25 10:35:38
963	8	380	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-21 02:07:27	2026-02-21 02:07:27
964	26	381	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-23 06:41:31	2026-02-23 06:41:31
965	92	382	Recomendación absoluta.	2026-02-22 14:29:31	2026-02-22 14:29:31
966	25	382	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-21 16:53:25	2026-02-21 16:53:25
967	35	382	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-26 04:44:14	2026-02-26 04:44:14
968	51	383	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-28 12:54:58	2026-02-28 12:54:58
969	23	383	Pressing de calidad.	2026-02-20 12:39:46	2026-02-20 12:39:46
970	98	384	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-24 12:36:48	2026-02-24 12:36:48
971	90	384	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-26 23:16:12	2026-02-26 23:16:12
972	63	385	The soundstage is wide and deep, creating an immersive experience.	2026-02-22 10:42:04	2026-02-22 10:42:04
973	88	385	Una compra segura si buscas calidad sin excesivos extras.	2026-02-22 09:08:22	2026-02-22 09:08:22
974	73	386	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-23 13:14:18	2026-02-23 13:14:18
975	10	386	Inmejorable relación calidad-precio.	2026-02-24 10:04:03	2026-02-24 10:04:03
976	49	386	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-26 23:00:31	2026-02-26 23:00:31
977	32	386	Sonido espectacular.	2026-02-22 02:59:54	2026-02-22 02:59:54
978	29	387	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-25 01:41:28	2026-02-25 01:41:28
979	64	387	El producto cumple con lo prometido y algo más.	2026-02-28 11:27:21	2026-02-28 11:27:21
980	80	387	Calidad consistente de principio a fin del disco.	2026-02-24 17:41:48	2026-02-24 17:41:48
981	74	387	Edición cuidada.	2026-02-26 05:06:20	2026-02-26 05:06:20
982	31	388	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-26 06:11:26	2026-02-26 06:11:26
983	67	388	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-20 17:33:02	2026-02-20 17:33:02
984	52	389	Pressing de calidad.	2026-02-28 16:07:34	2026-02-28 16:07:34
985	14	389	El producto cumple con lo prometido y algo más.	2026-02-24 16:42:05	2026-02-24 16:42:05
986	60	389	Muy satisfecho.	2026-02-24 00:13:51	2026-02-24 00:13:51
987	33	389	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-24 21:07:46	2026-02-24 21:07:46
988	59	390	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-21 05:40:20	2026-02-21 05:40:20
989	40	391	Instrument separation is remarkable, each element has its own space.	2026-02-20 02:29:20	2026-02-20 02:29:20
990	65	392	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-25 13:29:46	2026-02-25 13:29:46
991	45	393	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-24 12:50:16	2026-02-24 12:50:16
992	66	393	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-27 01:49:03	2026-02-27 01:49:03
993	29	393	Every listen reveals new layers in familiar recordings.	2026-02-20 02:42:36	2026-02-20 02:42:36
994	26	393	The vinyl compound seems high-quality with excellent durability.	2026-02-28 15:47:25	2026-02-28 15:47:25
995	71	394	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-28 16:03:00	2026-02-28 16:03:00
996	31	394	Sonido impecable.	2026-02-20 11:12:49	2026-02-20 11:12:49
997	39	395	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-23 10:17:47	2026-02-23 10:17:47
998	47	396	La portada es una obra de arte por sí sola, además del contenido.	2026-02-27 09:36:11	2026-02-27 09:36:11
999	6	396	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-28 18:34:47	2026-02-28 18:34:47
1000	19	396	The vinyl compound seems high-quality with excellent durability.	2026-02-28 15:01:29	2026-02-28 15:01:29
1001	85	396	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-25 01:01:33	2026-02-25 01:01:33
1002	47	397	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-27 16:56:44	2026-02-27 16:56:44
1003	62	397	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-25 02:14:51	2026-02-25 02:14:51
1004	79	397	Muy buen pressing.	2026-02-28 10:56:13	2026-02-28 10:56:13
1005	79	398	El sonido es lo importante y aquí brilla con luz propia.	2026-02-20 09:10:14	2026-02-20 09:10:14
1006	71	399	El simple acto de colocar la aguja ya genera expectación.	2026-02-24 17:34:22	2026-02-24 17:34:22
1007	40	399	Merece la pena.	2026-02-23 15:21:39	2026-02-23 15:21:39
1008	15	400	Excelente calidad de sonido.	2026-02-22 06:29:50	2026-02-22 06:29:50
1009	44	400	Surface noise is minimal, allowing the music to speak for itself.	2026-02-27 15:09:07	2026-02-27 15:09:07
1010	25	401	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-21 16:42:51	2026-02-21 16:42:51
1011	32	402	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-20 20:30:51	2026-02-20 20:30:51
1012	15	403	Pressing de calidad.	2026-02-28 04:51:40	2026-02-28 04:51:40
1013	50	403	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-23 09:55:40	2026-02-23 09:55:40
1014	84	404	Calidad premium.	2026-02-27 11:03:47	2026-02-27 11:03:47
1015	87	405	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-21 19:21:04	2026-02-21 19:21:04
1016	53	406	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-28 04:07:19	2026-02-28 04:07:19
1017	32	406	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-28 21:10:12	2026-02-28 21:10:12
1018	68	406	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-21 15:19:05	2026-02-21 15:19:05
1019	65	407	El simple acto de colocar la aguja ya genera expectación.	2026-02-21 21:01:01	2026-02-21 21:01:01
1020	81	407	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-27 13:10:44	2026-02-27 13:10:44
1021	51	407	Instrument separation is remarkable, each element has its own space.	2026-02-25 05:28:57	2026-02-25 05:28:57
1022	27	408	Surface noise is minimal, allowing the music to speak for itself.	2026-02-21 14:26:12	2026-02-21 14:26:12
1023	52	409	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-24 01:58:02	2026-02-24 01:58:02
1024	6	409	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-23 17:41:16	2026-02-23 17:41:16
1025	75	409	Una compra segura si buscas calidad sin excesivos extras.	2026-02-20 12:11:08	2026-02-20 12:11:08
1026	32	409	Every listen reveals new layers in familiar recordings.	2026-02-25 18:12:35	2026-02-25 18:12:35
1027	70	410	Surface noise is minimal, allowing the music to speak for itself.	2026-02-25 23:04:47	2026-02-25 23:04:47
1028	87	410	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-23 07:53:03	2026-02-23 07:53:03
1029	5	411	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-22 17:34:26	2026-02-22 17:34:26
1030	11	411	Pressing de calidad.	2026-02-24 20:49:54	2026-02-24 20:49:54
1031	56	411	Totalmente recomendado.	2026-02-27 22:23:39	2026-02-27 22:23:39
1032	3	412	The soundstage is wide and deep, creating an immersive experience.	2026-02-21 07:33:22	2026-02-21 07:33:22
1033	82	413	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-26 03:52:01	2026-02-26 03:52:01
1034	6	413	Sonido espectacular.	2026-02-23 02:57:18	2026-02-23 02:57:18
1035	16	413	Muy satisfecho.	2026-02-27 19:42:28	2026-02-27 19:42:28
1036	73	413	Muy satisfecho.	2026-02-26 06:53:31	2026-02-26 06:53:31
1037	63	414	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-21 05:18:51	2026-02-21 05:18:51
1038	92	414	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-20 03:11:00	2026-02-20 03:11:00
1039	24	415	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-27 02:43:04	2026-02-27 02:43:04
1040	56	416	Sonido impecable.	2026-02-27 15:56:02	2026-02-27 15:56:02
1041	25	416	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-22 22:07:00	2026-02-22 22:07:00
1042	17	417	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-20 13:52:54	2026-02-20 13:52:54
1043	46	417	The analog warmth brings out emotions in the music that digital misses.	2026-02-27 11:22:35	2026-02-27 11:22:35
1044	67	417	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-28 09:45:42	2026-02-28 09:45:42
1045	58	418	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-21 04:28:40	2026-02-21 04:28:40
1046	83	418	Mastering for vinyl was clearly done with care and expertise.	2026-02-20 07:29:26	2026-02-20 07:29:26
1047	18	418	Every listen reveals new layers in familiar recordings.	2026-02-20 04:59:24	2026-02-20 04:59:24
1048	31	418	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-25 15:27:55	2026-02-25 15:27:55
1049	8	419	Sonido rico y detallado.	2026-02-23 08:04:39	2026-02-23 08:04:39
1050	22	420	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-28 08:00:53	2026-02-28 08:00:53
1051	37	421	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-23 17:28:49	2026-02-23 17:28:49
1052	44	422	Flat pressing ensures consistent playback across the entire record.	2026-02-21 23:34:59	2026-02-21 23:34:59
1053	11	422	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-28 06:13:49	2026-02-28 06:13:49
1054	80	422	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-20 04:42:38	2026-02-20 04:42:38
1055	96	423	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-22 18:16:27	2026-02-22 18:16:27
1056	17	423	Instrument separation is remarkable, each element has its own space.	2026-02-27 05:25:15	2026-02-27 05:25:15
1057	81	423	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-23 07:03:58	2026-02-23 07:03:58
1058	44	423	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-27 06:35:51	2026-02-27 06:35:51
1059	19	424	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-22 00:17:27	2026-02-22 00:17:27
1060	34	424	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-24 01:23:08	2026-02-24 01:23:08
1061	81	424	Every listen reveals new layers in familiar recordings.	2026-02-27 00:30:28	2026-02-27 00:30:28
1062	35	425	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-21 22:13:01	2026-02-21 22:13:01
1063	54	425	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-22 18:59:04	2026-02-22 18:59:04
1064	1	425	Mastering for vinyl was clearly done with care and expertise.	2026-02-25 11:12:49	2026-02-25 11:12:49
1065	44	426	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-20 18:28:24	2026-02-20 18:28:24
1066	29	427	Sonido impecable.	2026-02-20 15:11:43	2026-02-20 15:11:43
1067	89	427	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-25 21:11:00	2026-02-25 21:11:00
1068	2	427	Pressing de calidad.	2026-02-22 21:39:39	2026-02-22 21:39:39
1069	69	428	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-27 10:08:47	2026-02-27 10:08:47
1070	74	428	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-25 13:20:29	2026-02-25 13:20:29
1071	53	429	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-24 12:05:35	2026-02-24 12:05:35
1072	66	430	Recomendación absoluta.	2026-02-28 05:07:25	2026-02-28 05:07:25
1073	26	430	Flat pressing ensures consistent playback across the entire record.	2026-02-24 14:22:09	2026-02-24 14:22:09
1074	29	431	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-27 22:03:49	2026-02-27 22:03:49
1075	79	432	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-20 04:02:24	2026-02-20 04:02:24
1076	42	433	El producto cumple con lo prometido y algo más.	2026-02-23 01:12:26	2026-02-23 01:12:26
1077	61	433	Calidad premium.	2026-02-26 13:41:04	2026-02-26 13:41:04
1078	1	433	Sonido impecable.	2026-02-22 12:17:03	2026-02-22 12:17:03
1079	24	434	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-28 13:53:22	2026-02-28 13:53:22
1080	21	434	Instrument separation is remarkable, each element has its own space.	2026-02-22 11:37:45	2026-02-22 11:37:45
1081	49	434	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-22 11:42:55	2026-02-22 11:42:55
1082	26	434	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-24 22:54:49	2026-02-24 22:54:49
1083	50	435	Pressing de calidad.	2026-02-20 00:22:05	2026-02-20 00:22:05
1084	71	435	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-23 19:52:26	2026-02-23 19:52:26
1085	62	436	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-21 13:17:08	2026-02-21 13:17:08
1086	15	436	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-24 04:19:55	2026-02-24 04:19:55
1087	70	437	Edición cuidada.	2026-02-24 08:46:26	2026-02-24 08:46:26
1088	16	437	Totalmente recomendado.	2026-02-26 07:54:25	2026-02-26 07:54:25
1089	73	437	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-26 22:37:38	2026-02-26 22:37:38
1090	74	437	The soundstage is wide and deep, creating an immersive experience.	2026-02-21 10:16:45	2026-02-21 10:16:45
1091	82	438	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-20 07:47:26	2026-02-20 07:47:26
1092	57	439	Calidad consistente de principio a fin del disco.	2026-02-27 20:16:22	2026-02-27 20:16:22
1093	98	440	Sonido rico y detallado.	2026-02-28 03:43:32	2026-02-28 03:43:32
1094	1	441	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-25 06:30:24	2026-02-25 06:30:24
1095	57	441	Every listen reveals new layers in familiar recordings.	2026-02-20 15:34:10	2026-02-20 15:34:10
1096	32	441	Merece la pena.	2026-02-24 23:26:25	2026-02-24 23:26:25
1097	11	442	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-28 22:44:50	2026-02-28 22:44:50
1098	63	442	The analog warmth brings out emotions in the music that digital misses.	2026-02-25 11:39:54	2026-02-25 11:39:54
1099	71	442	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-20 22:51:53	2026-02-20 22:51:53
1100	60	442	El sonido es lo importante y aquí brilla con luz propia.	2026-02-21 05:36:32	2026-02-21 05:36:32
1101	27	443	Sonido impecable.	2026-02-21 12:55:05	2026-02-21 12:55:05
1102	4	443	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-25 17:43:37	2026-02-25 17:43:37
1103	29	444	Merece la pena.	2026-02-26 15:47:55	2026-02-26 15:47:55
1104	61	444	Calidad premium.	2026-02-22 05:06:04	2026-02-22 05:06:04
1105	51	444	Edición cuidada.	2026-02-24 01:54:58	2026-02-24 01:54:58
1106	87	444	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-25 20:33:48	2026-02-25 20:33:48
1107	60	445	Edición cuidada.	2026-02-22 06:50:26	2026-02-22 06:50:26
1108	38	445	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-20 09:55:34	2026-02-20 09:55:34
1109	26	446	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-27 00:16:34	2026-02-27 00:16:34
1110	2	446	El sonido es lo importante y aquí brilla con luz propia.	2026-02-24 16:03:33	2026-02-24 16:03:33
1111	23	446	El simple acto de colocar la aguja ya genera expectación.	2026-02-23 18:04:38	2026-02-23 18:04:38
1112	30	447	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-24 10:05:59	2026-02-24 10:05:59
1113	48	447	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-24 10:38:30	2026-02-24 10:38:30
1114	83	447	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-20 13:42:36	2026-02-20 13:42:36
1115	65	447	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-20 17:19:17	2026-02-20 17:19:17
1116	29	448	El producto cumple con lo prometido y algo más.	2026-02-23 16:21:11	2026-02-23 16:21:11
1117	12	448	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-24 05:31:52	2026-02-24 05:31:52
1118	4	448	Recomendación absoluta.	2026-02-21 03:32:03	2026-02-21 03:32:03
1119	76	449	The vinyl compound seems high-quality with excellent durability.	2026-02-24 12:21:24	2026-02-24 12:21:24
1120	83	449	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-21 20:02:34	2026-02-21 20:02:34
1121	40	450	El producto cumple con lo prometido y algo más.	2026-02-25 03:28:54	2026-02-25 03:28:54
1122	27	450	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-22 15:00:57	2026-02-22 15:00:57
1123	75	450	Calidad excepcional.	2026-02-20 17:21:00	2026-02-20 17:21:00
1124	17	450	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-25 22:05:46	2026-02-25 22:05:46
1125	20	451	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-23 05:53:03	2026-02-23 05:53:03
1126	34	451	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-26 23:21:20	2026-02-26 23:21:20
1127	98	452	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-24 18:11:03	2026-02-24 18:11:03
1128	39	452	Surface noise is minimal, allowing the music to speak for itself.	2026-02-28 13:42:28	2026-02-28 13:42:28
1129	10	452	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-24 23:09:13	2026-02-24 23:09:13
1130	44	452	Experiencia completa.	2026-02-24 17:10:19	2026-02-24 17:10:19
1131	14	453	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-20 21:43:54	2026-02-20 21:43:54
1132	92	453	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-24 01:45:15	2026-02-24 01:45:15
1133	77	453	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-22 05:43:34	2026-02-22 05:43:34
1134	96	454	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-26 13:23:15	2026-02-26 13:23:15
1135	93	454	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-21 10:30:31	2026-02-21 10:30:31
1136	58	455	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-28 23:55:00	2026-02-28 23:55:00
1137	50	455	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-23 06:38:19	2026-02-23 06:38:19
1138	85	456	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-28 10:40:32	2026-02-28 10:40:32
1139	51	456	Excelente calidad de sonido.	2026-02-20 19:52:07	2026-02-20 19:52:07
1140	1	456	Recomendación absoluta.	2026-02-23 18:40:35	2026-02-23 18:40:35
1141	64	457	Excelente calidad de sonido.	2026-02-28 16:18:35	2026-02-28 16:18:35
1142	84	457	The vinyl compound seems high-quality with excellent durability.	2026-02-21 17:03:10	2026-02-21 17:03:10
1143	22	457	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-25 05:32:06	2026-02-25 05:32:06
1144	13	457	Sonido rico y detallado.	2026-02-26 09:10:37	2026-02-26 09:10:37
1145	88	458	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-24 04:11:52	2026-02-24 04:11:52
1146	95	458	Sonido espectacular.	2026-02-24 05:00:28	2026-02-24 05:00:28
1147	86	458	Sonido rico y detallado.	2026-02-26 16:39:37	2026-02-26 16:39:37
1148	72	459	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-23 06:25:12	2026-02-23 06:25:12
1149	27	459	Excelente calidad de sonido.	2026-02-27 22:06:15	2026-02-27 22:06:15
1150	67	460	Una compra segura si buscas calidad sin excesivos extras.	2026-02-24 20:23:12	2026-02-24 20:23:12
1151	73	460	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-28 19:11:03	2026-02-28 19:11:03
1152	31	460	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-24 22:46:39	2026-02-24 22:46:39
1153	76	461	Recomendación absoluta.	2026-02-24 05:10:50	2026-02-24 05:10:50
1154	68	461	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-20 08:10:51	2026-02-20 08:10:51
1155	35	462	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-27 15:57:10	2026-02-27 15:57:10
1156	21	462	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-23 06:41:46	2026-02-23 06:41:46
1157	77	462	Muy buen pressing.	2026-02-26 10:39:24	2026-02-26 10:39:24
1158	99	462	Sonido rico y detallado.	2026-02-20 16:32:39	2026-02-20 16:32:39
1159	25	463	Surface noise is minimal, allowing the music to speak for itself.	2026-02-24 10:13:07	2026-02-24 10:13:07
1160	31	463	Flat pressing ensures consistent playback across the entire record.	2026-02-24 21:07:40	2026-02-24 21:07:40
1161	67	463	Experiencia completa.	2026-02-27 00:06:52	2026-02-27 00:06:52
1162	60	463	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-25 10:19:56	2026-02-25 10:19:56
1163	57	464	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-21 23:41:12	2026-02-21 23:41:12
1164	81	465	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-21 06:37:24	2026-02-21 06:37:24
1165	20	466	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-27 12:12:58	2026-02-27 12:12:58
1166	41	466	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-25 07:18:43	2026-02-25 07:18:43
1167	1	466	The vinyl compound seems high-quality with excellent durability.	2026-02-21 22:57:39	2026-02-21 22:57:39
1168	16	467	The vinyl compound seems high-quality with excellent durability.	2026-02-20 06:05:49	2026-02-20 06:05:49
1169	14	467	El sonido es lo importante y aquí brilla con luz propia.	2026-02-27 04:05:32	2026-02-27 04:05:32
1170	34	467	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-24 04:00:47	2026-02-24 04:00:47
1171	44	468	El producto cumple con lo prometido y algo más.	2026-02-28 15:59:13	2026-02-28 15:59:13
1172	95	468	El sonido es lo importante y aquí brilla con luz propia.	2026-02-28 23:33:01	2026-02-28 23:33:01
1173	2	469	Una compra segura si buscas calidad sin excesivos extras.	2026-02-22 13:25:55	2026-02-22 13:25:55
1174	60	469	Calidad excepcional.	2026-02-27 04:10:58	2026-02-27 04:10:58
1175	71	469	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-21 11:49:55	2026-02-21 11:49:55
1176	1	470	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-20 10:17:30	2026-02-20 10:17:30
1177	97	470	Muy buen pressing.	2026-02-21 17:29:00	2026-02-21 17:29:00
1178	88	470	El producto cumple con lo prometido y algo más.	2026-02-21 13:10:44	2026-02-21 13:10:44
1179	63	470	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-20 07:34:19	2026-02-20 07:34:19
1180	69	471	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-25 09:37:51	2026-02-25 09:37:51
1181	70	471	Recomendación absoluta.	2026-02-25 23:27:44	2026-02-25 23:27:44
1182	56	471	La portada es una obra de arte por sí sola, además del contenido.	2026-02-28 02:48:24	2026-02-28 02:48:24
1183	95	472	El producto cumple con lo prometido y algo más.	2026-02-20 07:46:42	2026-02-20 07:46:42
1184	89	472	El producto cumple con lo prometido y algo más.	2026-02-25 09:34:44	2026-02-25 09:34:44
1185	35	472	El simple acto de colocar la aguja ya genera expectación.	2026-02-22 11:52:05	2026-02-22 11:52:05
1186	50	473	Una compra segura si buscas calidad sin excesivos extras.	2026-02-27 10:07:56	2026-02-27 10:07:56
1187	27	473	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-20 07:11:17	2026-02-20 07:11:17
1188	20	474	Edición cuidada.	2026-02-28 09:15:07	2026-02-28 09:15:07
1189	49	475	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-26 22:45:12	2026-02-26 22:45:12
1190	23	476	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-28 15:35:43	2026-02-28 15:35:43
1191	98	477	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-26 22:28:36	2026-02-26 22:28:36
1192	84	478	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-28 12:41:22	2026-02-28 12:41:22
1193	22	478	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-28 10:03:00	2026-02-28 10:03:00
1194	69	478	Calidad premium.	2026-02-23 16:43:46	2026-02-23 16:43:46
1195	30	479	Una compra segura si buscas calidad sin excesivos extras.	2026-02-28 13:06:34	2026-02-28 13:06:34
1196	79	480	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-28 03:38:29	2026-02-28 03:38:29
1197	57	481	Muy buen pressing.	2026-02-24 22:34:26	2026-02-24 22:34:26
1200	17	482	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-28 02:08:45	2026-02-28 02:08:45
1201	87	482	Merece la pena.	2026-02-28 12:44:28	2026-02-28 12:44:28
1202	22	482	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-20 03:44:31	2026-02-20 03:44:31
1203	49	482	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-28 19:32:34	2026-02-28 19:32:34
1204	39	483	El sonido es lo importante y aquí brilla con luz propia.	2026-02-25 05:33:58	2026-02-25 05:33:58
1205	17	483	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-20 16:38:27	2026-02-20 16:38:27
1206	74	484	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-23 16:46:57	2026-02-23 16:46:57
1207	10	484	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-24 09:28:41	2026-02-24 09:28:41
1208	72	484	Muy buen pressing.	2026-02-27 22:09:58	2026-02-27 22:09:58
1209	13	484	El simple acto de colocar la aguja ya genera expectación.	2026-02-25 08:45:55	2026-02-25 08:45:55
1210	100	485	Muy buen pressing.	2026-02-25 10:26:42	2026-02-25 10:26:42
1211	25	485	Sonido espectacular.	2026-02-25 22:54:48	2026-02-25 22:54:48
1212	64	485	El sonido es lo importante y aquí brilla con luz propia.	2026-02-24 04:41:46	2026-02-24 04:41:46
1213	34	485	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-27 14:10:05	2026-02-27 14:10:05
1214	82	486	Surface noise is minimal, allowing the music to speak for itself.	2026-02-21 14:13:27	2026-02-21 14:13:27
1215	25	486	The vinyl compound seems high-quality with excellent durability.	2026-02-23 08:48:59	2026-02-23 08:48:59
1216	21	486	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-24 02:36:40	2026-02-24 02:36:40
1217	57	486	The soundstage is wide and deep, creating an immersive experience.	2026-02-24 20:05:56	2026-02-24 20:05:56
1218	94	487	The soundstage is wide and deep, creating an immersive experience.	2026-02-27 21:00:35	2026-02-27 21:00:35
1219	2	488	Experiencia completa.	2026-02-26 03:55:12	2026-02-26 03:55:12
1220	12	488	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-27 22:16:23	2026-02-27 22:16:23
1221	52	488	Muy buen pressing.	2026-02-27 20:47:32	2026-02-27 20:47:32
1222	5	488	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-28 05:09:20	2026-02-28 05:09:20
1223	55	489	Every listen reveals new layers in familiar recordings.	2026-02-21 10:13:43	2026-02-21 10:13:43
1224	47	490	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-23 22:59:47	2026-02-23 22:59:47
1225	24	490	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-25 12:03:37	2026-02-25 12:03:37
1226	49	490	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-23 15:17:34	2026-02-23 15:17:34
1227	94	491	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-28 10:00:23	2026-02-28 10:00:23
1228	79	492	Mastering for vinyl was clearly done with care and expertise.	2026-02-21 06:48:30	2026-02-21 06:48:30
1229	32	493	Excelente calidad de sonido.	2026-02-24 02:24:58	2026-02-24 02:24:58
1230	26	493	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-24 08:13:41	2026-02-24 08:13:41
1231	12	493	El producto cumple con lo prometido y algo más.	2026-02-22 15:14:10	2026-02-22 15:14:10
1232	7	494	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-21 17:00:59	2026-02-21 17:00:59
1233	66	494	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-20 06:54:42	2026-02-20 06:54:42
1234	32	494	La portada es una obra de arte por sí sola, además del contenido.	2026-02-21 01:06:38	2026-02-21 01:06:38
1235	53	494	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-21 12:37:17	2026-02-21 12:37:17
1236	73	495	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-22 22:12:22	2026-02-22 22:12:22
1237	24	495	Sonido rico y detallado.	2026-02-26 13:49:24	2026-02-26 13:49:24
1238	87	495	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-22 12:11:58	2026-02-22 12:11:58
1239	3	496	Calidad premium.	2026-02-20 02:25:08	2026-02-20 02:25:08
1240	14	497	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-24 00:22:01	2026-02-24 00:22:01
1241	44	497	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-21 10:08:31	2026-02-21 10:08:31
1242	77	497	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-25 07:46:02	2026-02-25 07:46:02
1243	65	498	Muy buen pressing.	2026-02-27 12:50:25	2026-02-27 12:50:25
1244	72	499	Instrument separation is remarkable, each element has its own space.	2026-02-26 16:15:15	2026-02-26 16:15:15
1245	91	499	Calidad premium.	2026-02-22 07:28:06	2026-02-22 07:28:06
1246	45	499	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-28 12:12:23	2026-02-28 12:12:23
1247	41	499	Calidad excepcional.	2026-02-27 12:48:48	2026-02-27 12:48:48
1248	17	500	Merece la pena.	2026-02-20 14:37:40	2026-02-20 14:37:40
1249	67	500	El simple acto de colocar la aguja ya genera expectación.	2026-02-21 14:16:46	2026-02-21 14:16:46
1250	4	500	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-25 08:59:41	2026-02-25 08:59:41
1251	93	501	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-20 17:35:49	2026-02-20 17:35:49
1252	1	501	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-23 08:56:56	2026-02-23 08:56:56
1253	18	502	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-24 08:10:16	2026-02-24 08:10:16
1254	98	502	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-28 17:27:54	2026-02-28 17:27:54
1255	93	502	Inmejorable relación calidad-precio.	2026-02-22 13:11:38	2026-02-22 13:11:38
1256	12	503	Surface noise is minimal, allowing the music to speak for itself.	2026-02-28 18:20:01	2026-02-28 18:20:01
1257	54	503	Mastering for vinyl was clearly done with care and expertise.	2026-02-20 03:54:19	2026-02-20 03:54:19
1258	57	504	Totalmente recomendado.	2026-02-24 08:53:17	2026-02-24 08:53:17
1259	61	504	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-21 08:23:39	2026-02-21 08:23:39
1260	27	504	The analog warmth brings out emotions in the music that digital misses.	2026-02-28 02:25:17	2026-02-28 02:25:17
1261	24	504	Surface noise is minimal, allowing the music to speak for itself.	2026-02-20 22:30:34	2026-02-20 22:30:34
1262	70	505	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-21 12:18:08	2026-02-21 12:18:08
1263	39	506	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-24 01:10:39	2026-02-24 01:10:39
1264	32	507	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-21 09:29:41	2026-02-21 09:29:41
1265	53	507	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-25 15:43:37	2026-02-25 15:43:37
1266	10	507	Every listen reveals new layers in familiar recordings.	2026-02-27 06:32:09	2026-02-27 06:32:09
1267	45	507	Instrument separation is remarkable, each element has its own space.	2026-02-22 14:19:04	2026-02-22 14:19:04
1268	47	508	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-20 06:09:29	2026-02-20 06:09:29
1269	84	508	El simple acto de colocar la aguja ya genera expectación.	2026-02-28 01:27:19	2026-02-28 01:27:19
1270	50	508	El producto cumple con lo prometido y algo más.	2026-02-24 08:05:14	2026-02-24 08:05:14
1271	18	509	El centrado del label es perfecto, detalles que importan.	2026-02-28 05:31:31	2026-02-28 05:31:31
1272	33	509	Sonido rico y detallado.	2026-02-21 17:33:33	2026-02-21 17:33:33
1273	19	510	Flat pressing ensures consistent playback across the entire record.	2026-02-20 13:36:12	2026-02-20 13:36:12
1274	80	510	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-26 01:13:58	2026-02-26 01:13:58
1275	75	510	Inmejorable relación calidad-precio.	2026-02-20 08:43:43	2026-02-20 08:43:43
1276	81	510	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-24 21:58:31	2026-02-24 21:58:31
1277	98	511	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-27 14:39:29	2026-02-27 14:39:29
1278	36	511	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-24 21:55:14	2026-02-24 21:55:14
1279	47	511	Una compra segura si buscas calidad sin excesivos extras.	2026-02-26 01:55:10	2026-02-26 01:55:10
1280	22	511	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-24 18:59:59	2026-02-24 18:59:59
1281	91	512	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-23 19:13:20	2026-02-23 19:13:20
1282	65	512	Excelente calidad de sonido.	2026-02-24 13:37:09	2026-02-24 13:37:09
1283	23	513	Sonido rico y detallado.	2026-02-25 16:47:43	2026-02-25 16:47:43
1284	73	514	Sonido rico y detallado.	2026-02-22 17:46:07	2026-02-22 17:46:07
1285	34	514	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-22 11:50:55	2026-02-22 11:50:55
1286	57	514	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-26 07:12:08	2026-02-26 07:12:08
1287	11	514	Una compra segura si buscas calidad sin excesivos extras.	2026-02-28 09:15:14	2026-02-28 09:15:14
1288	22	515	Calidad premium.	2026-02-24 14:32:51	2026-02-24 14:32:51
1289	26	515	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-27 03:56:58	2026-02-27 03:56:58
1290	67	515	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-25 18:47:30	2026-02-25 18:47:30
1291	5	515	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-20 17:59:23	2026-02-20 17:59:23
1292	65	516	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-23 10:38:16	2026-02-23 10:38:16
1293	69	516	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-24 10:34:17	2026-02-24 10:34:17
1294	32	516	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-24 08:13:18	2026-02-24 08:13:18
1295	2	517	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-23 08:42:45	2026-02-23 08:42:45
1296	1	517	Muy buen pressing.	2026-02-27 20:35:55	2026-02-27 20:35:55
1297	52	518	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-28 12:14:47	2026-02-28 12:14:47
1298	3	518	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-22 16:03:07	2026-02-22 16:03:07
1299	26	519	Calidad premium.	2026-02-28 04:29:54	2026-02-28 04:29:54
1300	57	520	The analog warmth brings out emotions in the music that digital misses.	2026-02-23 08:58:46	2026-02-23 08:58:46
1301	93	520	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-20 14:50:52	2026-02-20 14:50:52
1302	99	520	Calidad consistente de principio a fin del disco.	2026-02-26 19:51:49	2026-02-26 19:51:49
1303	98	520	Totalmente recomendado.	2026-02-27 12:29:31	2026-02-27 12:29:31
1304	57	521	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-28 13:02:37	2026-02-28 13:02:37
1305	65	521	Flat pressing ensures consistent playback across the entire record.	2026-02-24 11:20:54	2026-02-24 11:20:54
1306	80	521	Surface noise is minimal, allowing the music to speak for itself.	2026-02-27 15:45:51	2026-02-27 15:45:51
1307	13	522	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-25 07:04:52	2026-02-25 07:04:52
1308	3	522	The soundstage is wide and deep, creating an immersive experience.	2026-02-24 19:13:59	2026-02-24 19:13:59
1309	36	522	Totalmente recomendado.	2026-02-20 18:38:28	2026-02-20 18:38:28
1310	41	522	Calidad excepcional.	2026-02-26 19:56:21	2026-02-26 19:56:21
1311	96	523	Sonido rico y detallado.	2026-02-26 17:55:01	2026-02-26 17:55:01
1312	3	524	El simple acto de colocar la aguja ya genera expectación.	2026-02-20 10:03:11	2026-02-20 10:03:11
1313	52	524	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-22 19:07:40	2026-02-22 19:07:40
1314	95	525	Calidad premium.	2026-02-24 17:49:49	2026-02-24 17:49:49
1315	26	525	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-21 09:53:28	2026-02-21 09:53:28
1316	99	525	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-24 10:31:32	2026-02-24 10:31:32
1317	35	526	Calidad consistente de principio a fin del disco.	2026-02-21 23:33:03	2026-02-21 23:33:03
1318	42	527	La portada es una obra de arte por sí sola, además del contenido.	2026-02-24 05:05:10	2026-02-24 05:05:10
1319	46	527	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-22 22:55:18	2026-02-22 22:55:18
1320	55	528	Instrument separation is remarkable, each element has its own space.	2026-02-27 22:54:11	2026-02-27 22:54:11
1321	5	528	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-25 02:55:33	2026-02-25 02:55:33
1322	49	528	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-21 13:03:01	2026-02-21 13:03:01
1323	44	528	Sonido espectacular.	2026-02-26 02:39:45	2026-02-26 02:39:45
1324	61	529	Sonido impecable.	2026-02-21 22:25:38	2026-02-21 22:25:38
1325	71	529	Calidad excepcional.	2026-02-21 12:14:49	2026-02-21 12:14:49
1326	5	530	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-24 20:38:04	2026-02-24 20:38:04
1327	96	530	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-24 00:22:02	2026-02-24 00:22:02
1328	23	531	Sonido impecable.	2026-02-23 15:43:22	2026-02-23 15:43:22
1329	62	531	Sonido rico y detallado.	2026-02-21 07:49:19	2026-02-21 07:49:19
1330	35	531	Excelente calidad de sonido.	2026-02-26 08:11:19	2026-02-26 08:11:19
1331	24	531	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-20 02:24:22	2026-02-20 02:24:22
1332	79	532	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-25 02:29:34	2026-02-25 02:29:34
1333	43	532	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-23 23:35:00	2026-02-23 23:35:00
1334	8	532	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-26 11:57:31	2026-02-26 11:57:31
1335	56	533	Muy satisfecho.	2026-02-26 03:06:27	2026-02-26 03:06:27
1336	76	533	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-24 12:33:39	2026-02-24 12:33:39
1337	52	533	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-22 12:14:12	2026-02-22 12:14:12
1338	12	533	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-20 09:52:29	2026-02-20 09:52:29
1339	5	534	Calidad consistente de principio a fin del disco.	2026-02-25 09:05:29	2026-02-25 09:05:29
1340	69	534	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-26 20:46:39	2026-02-26 20:46:39
1341	94	535	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-22 01:15:12	2026-02-22 01:15:12
1342	100	535	Excelente calidad de sonido.	2026-02-20 12:58:58	2026-02-20 12:58:58
1343	92	535	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-26 08:45:59	2026-02-26 08:45:59
1344	72	535	The analog warmth brings out emotions in the music that digital misses.	2026-02-26 01:54:17	2026-02-26 01:54:17
1345	62	536	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-21 05:01:49	2026-02-21 05:01:49
1346	17	536	Every listen reveals new layers in familiar recordings.	2026-02-23 00:43:36	2026-02-23 00:43:36
1347	15	537	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-25 13:13:06	2026-02-25 13:13:06
1348	27	537	Instrument separation is remarkable, each element has its own space.	2026-02-27 21:00:50	2026-02-27 21:00:50
1349	33	538	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-22 20:40:21	2026-02-22 20:40:21
1350	24	538	The analog warmth brings out emotions in the music that digital misses.	2026-02-24 18:42:06	2026-02-24 18:42:06
1351	67	539	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-28 16:20:40	2026-02-28 16:20:40
1352	95	540	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-23 03:49:55	2026-02-23 03:49:55
1353	33	540	Merece la pena.	2026-02-24 07:56:38	2026-02-24 07:56:38
1354	71	540	El simple acto de colocar la aguja ya genera expectación.	2026-02-21 03:51:33	2026-02-21 03:51:33
1355	88	540	Calidad consistente de principio a fin del disco.	2026-02-25 04:49:07	2026-02-25 04:49:07
1356	84	541	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-25 01:38:21	2026-02-25 01:38:21
1357	57	542	El sonido es lo importante y aquí brilla con luz propia.	2026-02-23 16:32:18	2026-02-23 16:32:18
1358	40	542	Muy satisfecho.	2026-02-25 03:12:06	2026-02-25 03:12:06
1359	54	542	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-23 04:42:10	2026-02-23 04:42:10
1360	18	543	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-23 01:41:02	2026-02-23 01:41:02
1361	99	544	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-20 14:11:30	2026-02-20 14:11:30
1362	31	544	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-21 15:04:49	2026-02-21 15:04:49
1363	67	545	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-27 07:32:48	2026-02-27 07:32:48
1364	23	545	Every listen reveals new layers in familiar recordings.	2026-02-28 22:20:42	2026-02-28 22:20:42
1365	61	545	Experiencia completa.	2026-02-21 21:48:01	2026-02-21 21:48:01
1366	98	545	Experiencia completa.	2026-02-21 13:59:17	2026-02-21 13:59:17
1367	33	546	Flat pressing ensures consistent playback across the entire record.	2026-02-23 04:07:28	2026-02-23 04:07:28
1368	84	546	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-22 04:03:30	2026-02-22 04:03:30
1369	93	547	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-24 03:41:21	2026-02-24 03:41:21
1370	16	547	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-25 10:23:02	2026-02-25 10:23:02
1371	58	548	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-21 19:14:54	2026-02-21 19:14:54
1372	5	548	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-27 07:32:35	2026-02-27 07:32:35
1373	97	549	Calidad consistente de principio a fin del disco.	2026-02-24 11:43:47	2026-02-24 11:43:47
1374	69	549	Inmejorable relación calidad-precio.	2026-02-22 00:25:26	2026-02-22 00:25:26
1375	25	549	Calidad consistente de principio a fin del disco.	2026-02-26 09:46:39	2026-02-26 09:46:39
1376	76	549	Totalmente recomendado.	2026-02-24 16:43:16	2026-02-24 16:43:16
1377	32	550	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-26 03:25:14	2026-02-26 03:25:14
1378	83	550	Muy buen pressing.	2026-02-20 10:07:34	2026-02-20 10:07:34
1379	8	550	Excelente calidad de sonido.	2026-02-24 21:13:39	2026-02-24 21:13:39
1380	39	551	The analog warmth brings out emotions in the music that digital misses.	2026-02-28 21:52:08	2026-02-28 21:52:08
1381	68	551	Merece la pena.	2026-02-24 04:41:42	2026-02-24 04:41:42
1382	91	551	Edición cuidada.	2026-02-21 22:42:32	2026-02-21 22:42:32
1383	12	552	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-20 14:34:52	2026-02-20 14:34:52
1384	76	552	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-20 14:15:05	2026-02-20 14:15:05
1385	48	552	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-24 18:03:43	2026-02-24 18:03:43
1386	59	552	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-27 09:29:37	2026-02-27 09:29:37
1387	43	553	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-21 14:15:22	2026-02-21 14:15:22
1388	62	554	Totalmente recomendado.	2026-02-27 06:12:31	2026-02-27 06:12:31
1389	5	554	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-26 02:10:18	2026-02-26 02:10:18
1390	83	554	Excelente calidad de sonido.	2026-02-24 01:57:29	2026-02-24 01:57:29
1391	45	555	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-25 11:56:18	2026-02-25 11:56:18
1392	33	555	Mastering for vinyl was clearly done with care and expertise.	2026-02-23 00:08:13	2026-02-23 00:08:13
1393	66	555	Merece la pena.	2026-02-28 23:19:58	2026-02-28 23:19:58
1394	99	555	Surface noise is minimal, allowing the music to speak for itself.	2026-02-26 23:57:31	2026-02-26 23:57:31
1395	13	556	Sonido impecable.	2026-02-24 05:46:11	2026-02-24 05:46:11
1396	36	556	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-28 07:57:23	2026-02-28 07:57:23
1397	70	556	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-27 03:26:47	2026-02-27 03:26:47
1398	53	556	Edición cuidada.	2026-02-25 04:37:25	2026-02-25 04:37:25
1399	72	557	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-21 17:11:50	2026-02-21 17:11:50
1400	21	557	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-28 04:52:26	2026-02-28 04:52:26
1401	80	558	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-23 08:24:28	2026-02-23 08:24:28
1402	90	558	Excelente calidad de sonido.	2026-02-23 16:18:04	2026-02-23 16:18:04
1403	38	558	El producto cumple con lo prometido y algo más.	2026-02-22 02:20:52	2026-02-22 02:20:52
1404	87	559	Mastering for vinyl was clearly done with care and expertise.	2026-02-24 20:03:57	2026-02-24 20:03:57
1405	79	559	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-28 20:27:58	2026-02-28 20:27:58
1406	56	559	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-24 12:38:09	2026-02-24 12:38:09
1407	78	559	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-22 04:21:25	2026-02-22 04:21:25
1408	77	560	Every listen reveals new layers in familiar recordings.	2026-02-26 05:00:52	2026-02-26 05:00:52
1409	3	560	Flat pressing ensures consistent playback across the entire record.	2026-02-20 05:16:44	2026-02-20 05:16:44
1410	81	561	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-23 14:11:11	2026-02-23 14:11:11
1411	80	561	Inmejorable relación calidad-precio.	2026-02-26 21:37:37	2026-02-26 21:37:37
1412	75	562	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-24 15:07:01	2026-02-24 15:07:01
1413	70	563	Edición cuidada.	2026-02-27 07:54:39	2026-02-27 07:54:39
1414	19	563	El centrado del label es perfecto, detalles que importan.	2026-02-28 06:39:35	2026-02-28 06:39:35
1415	47	563	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-20 10:43:29	2026-02-20 10:43:29
1416	21	563	Recomendación absoluta.	2026-02-28 19:13:57	2026-02-28 19:13:57
1417	37	564	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-24 13:09:45	2026-02-24 13:09:45
1418	68	565	Calidad premium.	2026-02-21 00:33:12	2026-02-21 00:33:12
1419	2	565	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-27 17:50:02	2026-02-27 17:50:02
1420	49	565	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-22 02:37:19	2026-02-22 02:37:19
1421	39	565	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-28 18:11:44	2026-02-28 18:11:44
1422	75	566	Pressing de calidad.	2026-02-26 01:19:47	2026-02-26 01:19:47
1423	43	567	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-21 10:32:17	2026-02-21 10:32:17
1424	93	567	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-22 02:25:37	2026-02-22 02:25:37
1425	23	567	El simple acto de colocar la aguja ya genera expectación.	2026-02-24 08:06:56	2026-02-24 08:06:56
1426	86	568	The analog warmth brings out emotions in the music that digital misses.	2026-02-28 03:40:44	2026-02-28 03:40:44
1427	31	568	Mastering for vinyl was clearly done with care and expertise.	2026-02-22 10:55:27	2026-02-22 10:55:27
1428	32	569	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-21 11:34:21	2026-02-21 11:34:21
1429	38	570	Merece la pena.	2026-02-20 00:18:35	2026-02-20 00:18:35
1430	80	570	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-26 04:45:24	2026-02-26 04:45:24
1431	21	570	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-20 06:28:15	2026-02-20 06:28:15
1432	19	570	El centrado del label es perfecto, detalles que importan.	2026-02-22 01:48:50	2026-02-22 01:48:50
1433	17	571	Recomendación absoluta.	2026-02-22 02:41:04	2026-02-22 02:41:04
1434	73	571	El centrado del label es perfecto, detalles que importan.	2026-02-25 06:16:10	2026-02-25 06:16:10
1435	77	571	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-22 05:14:10	2026-02-22 05:14:10
1436	97	571	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-20 00:02:03	2026-02-20 00:02:03
1437	85	572	Muy satisfecho.	2026-02-22 05:09:13	2026-02-22 05:09:13
1438	43	573	El sonido es lo importante y aquí brilla con luz propia.	2026-02-21 10:50:41	2026-02-21 10:50:41
1439	2	573	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-22 11:13:36	2026-02-22 11:13:36
1440	46	573	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-23 22:32:28	2026-02-23 22:32:28
1441	79	574	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-21 02:23:40	2026-02-21 02:23:40
1442	46	574	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-24 18:04:44	2026-02-24 18:04:44
1443	53	574	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-22 20:00:13	2026-02-22 20:00:13
1444	1	574	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-27 10:05:25	2026-02-27 10:05:25
1445	31	575	Una compra segura si buscas calidad sin excesivos extras.	2026-02-22 03:10:34	2026-02-22 03:10:34
1446	22	575	Una compra segura si buscas calidad sin excesivos extras.	2026-02-28 09:31:49	2026-02-28 09:31:49
1447	61	576	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-27 11:36:43	2026-02-27 11:36:43
1448	51	576	Una compra segura si buscas calidad sin excesivos extras.	2026-02-21 17:51:43	2026-02-21 17:51:43
1449	83	576	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-26 00:45:44	2026-02-26 00:45:44
1450	84	576	El centrado del label es perfecto, detalles que importan.	2026-02-23 18:32:34	2026-02-23 18:32:34
1451	59	577	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-24 17:21:14	2026-02-24 17:21:14
1452	77	578	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-28 19:50:11	2026-02-28 19:50:11
1453	96	578	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-21 18:06:18	2026-02-21 18:06:18
1454	47	578	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-26 13:54:28	2026-02-26 13:54:28
1455	49	579	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-26 08:00:21	2026-02-26 08:00:21
1456	95	580	Una compra segura si buscas calidad sin excesivos extras.	2026-02-21 23:04:13	2026-02-21 23:04:13
1457	39	581	Inmejorable relación calidad-precio.	2026-02-28 00:07:08	2026-02-28 00:07:08
1458	92	581	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-23 02:24:23	2026-02-23 02:24:23
1459	70	581	Mastering for vinyl was clearly done with care and expertise.	2026-02-20 05:59:34	2026-02-20 05:59:34
1460	38	582	Calidad premium.	2026-02-23 02:01:20	2026-02-23 02:01:20
1461	56	583	Every listen reveals new layers in familiar recordings.	2026-02-28 23:08:22	2026-02-28 23:08:22
1462	1	583	The analog warmth brings out emotions in the music that digital misses.	2026-02-28 04:20:28	2026-02-28 04:20:28
1463	79	584	Sonido rico y detallado.	2026-02-25 10:47:13	2026-02-25 10:47:13
1464	53	584	The vinyl compound seems high-quality with excellent durability.	2026-02-20 19:53:26	2026-02-20 19:53:26
1465	86	584	Muy buen pressing.	2026-02-21 23:33:10	2026-02-21 23:33:10
1466	73	584	Every listen reveals new layers in familiar recordings.	2026-02-20 13:28:41	2026-02-20 13:28:41
1467	8	585	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-25 12:29:36	2026-02-25 12:29:36
1468	38	586	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-28 19:28:37	2026-02-28 19:28:37
1469	44	586	Totalmente recomendado.	2026-02-24 18:20:14	2026-02-24 18:20:14
1470	59	587	Muy satisfecho.	2026-02-20 01:32:11	2026-02-20 01:32:11
1471	77	588	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-20 14:00:36	2026-02-20 14:00:36
1472	68	588	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-27 14:45:19	2026-02-27 14:45:19
1473	94	588	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-20 02:56:21	2026-02-20 02:56:21
1474	81	589	La portada es una obra de arte por sí sola, además del contenido.	2026-02-25 00:33:35	2026-02-25 00:33:35
1475	41	589	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-26 06:37:10	2026-02-26 06:37:10
1476	90	589	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-24 16:57:19	2026-02-24 16:57:19
1477	49	589	Experiencia completa.	2026-02-28 02:53:30	2026-02-28 02:53:30
1478	4	590	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-27 09:06:05	2026-02-27 09:06:05
1479	57	590	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-20 12:03:50	2026-02-20 12:03:50
1480	96	591	Surface noise is minimal, allowing the music to speak for itself.	2026-02-27 21:54:51	2026-02-27 21:54:51
1481	64	591	Sonido espectacular.	2026-02-28 12:43:34	2026-02-28 12:43:34
1482	45	591	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-23 03:40:52	2026-02-23 03:40:52
1483	4	591	Recomendación absoluta.	2026-02-27 19:13:01	2026-02-27 19:13:01
1484	36	592	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-22 19:10:51	2026-02-22 19:10:51
1485	93	592	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-22 05:30:12	2026-02-22 05:30:12
1486	3	593	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-21 13:32:44	2026-02-21 13:32:44
1487	24	593	Pressing de calidad.	2026-02-28 04:35:11	2026-02-28 04:35:11
1488	10	594	Recomendación absoluta.	2026-02-20 15:56:28	2026-02-20 15:56:28
1489	9	595	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-21 19:05:55	2026-02-21 19:05:55
1490	64	595	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-22 03:52:33	2026-02-22 03:52:33
1491	19	595	El simple acto de colocar la aguja ya genera expectación.	2026-02-24 15:05:28	2026-02-24 15:05:28
1492	41	596	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-24 12:31:31	2026-02-24 12:31:31
1493	19	597	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-23 15:45:37	2026-02-23 15:45:37
1494	72	598	Mastering for vinyl was clearly done with care and expertise.	2026-02-28 14:56:52	2026-02-28 14:56:52
1495	75	598	El centrado del label es perfecto, detalles que importan.	2026-02-28 22:06:16	2026-02-28 22:06:16
1496	84	598	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-23 04:55:35	2026-02-23 04:55:35
1497	25	598	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-28 16:37:41	2026-02-28 16:37:41
1498	31	599	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-25 15:01:22	2026-02-25 15:01:22
1499	32	599	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-25 17:59:38	2026-02-25 17:59:38
1500	4	600	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-25 18:26:56	2026-02-25 18:26:56
1501	59	601	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-25 03:49:26	2026-02-25 03:49:26
1502	75	601	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-25 17:39:59	2026-02-25 17:39:59
1503	6	602	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-28 11:03:19	2026-02-28 11:03:19
1504	72	602	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-27 14:36:32	2026-02-27 14:36:32
1505	1	602	Surface noise is minimal, allowing the music to speak for itself.	2026-02-26 01:39:18	2026-02-26 01:39:18
1506	62	603	El centrado del label es perfecto, detalles que importan.	2026-02-27 23:13:40	2026-02-27 23:13:40
1507	61	604	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-23 12:35:03	2026-02-23 12:35:03
1508	98	604	Flat pressing ensures consistent playback across the entire record.	2026-02-23 12:15:02	2026-02-23 12:15:02
1509	50	604	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-26 01:04:35	2026-02-26 01:04:35
1510	13	605	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-28 15:08:25	2026-02-28 15:08:25
1511	34	606	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-25 02:21:16	2026-02-25 02:21:16
1512	74	606	Experiencia completa.	2026-02-26 14:17:02	2026-02-26 14:17:02
1513	13	607	El producto cumple con lo prometido y algo más.	2026-02-26 06:59:08	2026-02-26 06:59:08
1514	28	607	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-21 22:19:13	2026-02-21 22:19:13
1515	64	607	Inmejorable relación calidad-precio.	2026-02-21 01:07:59	2026-02-21 01:07:59
1516	70	608	El sonido es lo importante y aquí brilla con luz propia.	2026-02-27 03:50:41	2026-02-27 03:50:41
1517	90	609	Sonido espectacular.	2026-02-27 19:12:09	2026-02-27 19:12:09
1518	18	610	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-28 02:41:01	2026-02-28 02:41:01
1519	2	610	Sonido rico y detallado.	2026-02-25 22:50:13	2026-02-25 22:50:13
1520	80	610	Muy buen pressing.	2026-02-20 08:38:07	2026-02-20 08:38:07
1521	89	610	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-24 20:04:53	2026-02-24 20:04:53
1522	71	611	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-28 02:57:41	2026-02-28 02:57:41
1523	83	612	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-26 10:40:03	2026-02-26 10:40:03
1524	29	612	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-25 20:19:01	2026-02-25 20:19:01
1525	5	612	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-26 06:58:31	2026-02-26 06:58:31
1526	1	613	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-20 17:21:33	2026-02-20 17:21:33
1527	62	613	El sonido es lo importante y aquí brilla con luz propia.	2026-02-24 05:56:50	2026-02-24 05:56:50
1528	34	613	Excelente calidad de sonido.	2026-02-20 01:03:52	2026-02-20 01:03:52
1529	3	614	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-21 18:23:03	2026-02-21 18:23:03
1530	28	614	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-22 20:09:42	2026-02-22 20:09:42
1531	72	614	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-22 16:20:47	2026-02-22 16:20:47
1532	90	614	Merece la pena.	2026-02-26 08:58:09	2026-02-26 08:58:09
1533	52	615	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-23 03:31:07	2026-02-23 03:31:07
1534	4	615	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-23 07:13:04	2026-02-23 07:13:04
1535	85	616	Muy satisfecho.	2026-02-25 12:29:59	2026-02-25 12:29:59
1536	60	617	Sonido rico y detallado.	2026-02-23 21:41:19	2026-02-23 21:41:19
1537	48	618	Surface noise is minimal, allowing the music to speak for itself.	2026-02-20 14:09:31	2026-02-20 14:09:31
1538	67	618	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-23 20:48:58	2026-02-23 20:48:58
1539	99	618	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-21 03:26:08	2026-02-21 03:26:08
1540	31	618	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-28 02:48:37	2026-02-28 02:48:37
1541	75	619	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-28 08:46:00	2026-02-28 08:46:00
1542	86	619	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-28 15:39:04	2026-02-28 15:39:04
1543	46	619	The analog warmth brings out emotions in the music that digital misses.	2026-02-27 08:17:28	2026-02-27 08:17:28
1544	21	619	Muy satisfecho.	2026-02-28 19:44:56	2026-02-28 19:44:56
1545	98	620	Calidad premium.	2026-02-23 14:36:00	2026-02-23 14:36:00
1546	100	620	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-25 20:15:36	2026-02-25 20:15:36
1547	91	620	The soundstage is wide and deep, creating an immersive experience.	2026-02-22 19:24:18	2026-02-22 19:24:18
1548	99	621	The analog warmth brings out emotions in the music that digital misses.	2026-02-21 14:47:07	2026-02-21 14:47:07
1549	69	621	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-25 16:28:48	2026-02-25 16:28:48
1550	47	621	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-22 21:05:41	2026-02-22 21:05:41
1623	34	649	Excelente calidad de sonido.	2026-02-27 19:00:57	2026-02-27 19:00:57
1551	3	621	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-21 13:26:14	2026-02-21 13:26:14
1552	54	622	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-26 23:11:16	2026-02-26 23:11:16
1553	19	623	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-26 22:37:07	2026-02-26 22:37:07
1554	13	623	El centrado del label es perfecto, detalles que importan.	2026-02-21 16:23:07	2026-02-21 16:23:07
1555	84	623	The soundstage is wide and deep, creating an immersive experience.	2026-02-28 01:14:23	2026-02-28 01:14:23
1556	20	624	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-24 08:18:48	2026-02-24 08:18:48
1557	72	625	Calidad premium.	2026-02-21 03:16:45	2026-02-21 03:16:45
1558	44	625	Sonido rico y detallado.	2026-02-23 17:59:17	2026-02-23 17:59:17
1559	7	625	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-27 20:08:07	2026-02-27 20:08:07
1560	93	626	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-23 09:52:12	2026-02-23 09:52:12
1561	16	626	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-27 23:38:18	2026-02-27 23:38:18
1562	87	627	El sonido es lo importante y aquí brilla con luz propia.	2026-02-26 23:51:10	2026-02-26 23:51:10
1563	68	627	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-27 00:35:53	2026-02-27 00:35:53
1564	16	627	La portada es una obra de arte por sí sola, además del contenido.	2026-02-24 07:34:49	2026-02-24 07:34:49
1565	35	627	El simple acto de colocar la aguja ya genera expectación.	2026-02-21 19:26:28	2026-02-21 19:26:28
1566	16	628	Muy satisfecho.	2026-02-23 23:30:15	2026-02-23 23:30:15
1567	34	628	El producto cumple con lo prometido y algo más.	2026-02-23 06:44:10	2026-02-23 06:44:10
1568	22	628	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-20 18:21:27	2026-02-20 18:21:27
1569	82	628	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-28 16:55:22	2026-02-28 16:55:22
1570	27	629	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-25 12:00:40	2026-02-25 12:00:40
1571	46	629	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-24 21:17:45	2026-02-24 21:17:45
1572	74	630	The soundstage is wide and deep, creating an immersive experience.	2026-02-22 17:54:43	2026-02-22 17:54:43
1573	51	630	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-21 20:14:55	2026-02-21 20:14:55
1574	37	630	Sonido impecable.	2026-02-27 11:03:27	2026-02-27 11:03:27
1575	71	631	Sonido espectacular.	2026-02-21 07:36:42	2026-02-21 07:36:42
1576	23	631	Inmejorable relación calidad-precio.	2026-02-28 22:30:06	2026-02-28 22:30:06
1577	80	631	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-26 15:41:21	2026-02-26 15:41:21
1578	77	631	Calidad excepcional.	2026-02-28 16:23:06	2026-02-28 16:23:06
1579	67	632	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-22 15:52:12	2026-02-22 15:52:12
1580	57	632	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-25 00:00:30	2026-02-25 00:00:30
1581	89	632	Excelente calidad de sonido.	2026-02-22 10:44:54	2026-02-22 10:44:54
1582	29	633	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-21 21:55:31	2026-02-21 21:55:31
1583	21	634	Recomendación absoluta.	2026-02-27 03:00:01	2026-02-27 03:00:01
1584	50	634	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-25 17:54:11	2026-02-25 17:54:11
1585	49	634	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-24 17:08:48	2026-02-24 17:08:48
1586	9	634	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-28 07:50:21	2026-02-28 07:50:21
1587	38	635	Sonido rico y detallado.	2026-02-25 17:26:17	2026-02-25 17:26:17
1588	74	636	Calidad excepcional.	2026-02-22 02:18:09	2026-02-22 02:18:09
1589	79	636	Inmejorable relación calidad-precio.	2026-02-28 11:26:08	2026-02-28 11:26:08
1590	97	636	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-28 04:22:26	2026-02-28 04:22:26
1591	10	637	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-23 17:47:04	2026-02-23 17:47:04
1592	35	637	El simple acto de colocar la aguja ya genera expectación.	2026-02-24 05:03:35	2026-02-24 05:03:35
1593	57	637	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-27 00:35:55	2026-02-27 00:35:55
1594	17	638	Muy buen pressing.	2026-02-27 21:51:17	2026-02-27 21:51:17
1595	77	638	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-22 16:44:34	2026-02-22 16:44:34
1596	84	638	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-27 07:43:04	2026-02-27 07:43:04
1597	1	639	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-23 08:58:43	2026-02-23 08:58:43
1598	60	639	Recomendación absoluta.	2026-02-26 05:14:49	2026-02-26 05:14:49
1599	49	640	Calidad premium.	2026-02-27 12:13:49	2026-02-27 12:13:49
1600	84	641	Edición cuidada.	2026-02-27 17:19:24	2026-02-27 17:19:24
1601	85	641	Sonido impecable.	2026-02-22 07:49:39	2026-02-22 07:49:39
1602	79	641	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-20 16:26:21	2026-02-20 16:26:21
1603	89	642	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-22 17:21:38	2026-02-22 17:21:38
1604	99	643	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-28 08:01:06	2026-02-28 08:01:06
1605	13	643	Totalmente recomendado.	2026-02-24 01:10:00	2026-02-24 01:10:00
1606	77	643	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-25 08:28:46	2026-02-25 08:28:46
1607	29	644	Inmejorable relación calidad-precio.	2026-02-21 08:21:58	2026-02-21 08:21:58
1608	97	644	Una compra segura si buscas calidad sin excesivos extras.	2026-02-25 13:38:17	2026-02-25 13:38:17
1609	59	644	Calidad excepcional.	2026-02-27 15:37:00	2026-02-27 15:37:00
1610	42	645	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-24 21:32:12	2026-02-24 21:32:12
1611	7	645	Calidad consistente de principio a fin del disco.	2026-02-24 17:49:22	2026-02-24 17:49:22
1612	96	645	Surface noise is minimal, allowing the music to speak for itself.	2026-02-25 19:57:41	2026-02-25 19:57:41
1613	64	645	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-21 06:11:51	2026-02-21 06:11:51
1614	21	646	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-24 06:44:47	2026-02-24 06:44:47
1615	3	646	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-22 16:48:34	2026-02-22 16:48:34
1616	28	646	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-28 10:37:58	2026-02-28 10:37:58
1617	30	647	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-27 05:11:28	2026-02-27 05:11:28
1618	83	647	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-25 19:19:21	2026-02-25 19:19:21
1619	41	648	Mastering for vinyl was clearly done with care and expertise.	2026-02-25 03:34:50	2026-02-25 03:34:50
1620	86	648	Calidad premium.	2026-02-26 21:33:07	2026-02-26 21:33:07
1621	51	648	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-24 09:32:03	2026-02-24 09:32:03
1622	72	649	Una compra segura si buscas calidad sin excesivos extras.	2026-02-20 15:45:58	2026-02-20 15:45:58
1624	62	650	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-20 09:15:57	2026-02-20 09:15:57
1625	47	650	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-20 05:05:03	2026-02-20 05:05:03
1626	81	650	Excelente calidad de sonido.	2026-02-23 10:09:07	2026-02-23 10:09:07
1627	25	650	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-28 10:52:43	2026-02-28 10:52:43
1628	19	651	Experiencia completa.	2026-02-22 16:35:46	2026-02-22 16:35:46
1629	39	651	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-25 11:12:39	2026-02-25 11:12:39
1630	60	651	Una compra segura si buscas calidad sin excesivos extras.	2026-02-20 17:45:56	2026-02-20 17:45:56
1631	47	652	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-24 04:18:17	2026-02-24 04:18:17
1632	59	652	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-24 22:11:51	2026-02-24 22:11:51
1633	11	652	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-25 11:59:42	2026-02-25 11:59:42
1634	84	653	La portada es una obra de arte por sí sola, además del contenido.	2026-02-22 23:49:30	2026-02-22 23:49:30
1635	97	654	Calidad premium.	2026-02-23 03:29:39	2026-02-23 03:29:39
1636	5	654	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-20 15:05:38	2026-02-20 15:05:38
1637	9	654	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-23 08:29:46	2026-02-23 08:29:46
1638	48	654	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-23 03:44:43	2026-02-23 03:44:43
1639	63	655	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-20 05:56:06	2026-02-20 05:56:06
1640	42	655	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-21 02:25:38	2026-02-21 02:25:38
1641	10	655	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-26 18:16:14	2026-02-26 18:16:14
1642	28	655	Flat pressing ensures consistent playback across the entire record.	2026-02-25 23:26:29	2026-02-25 23:26:29
1643	24	656	The soundstage is wide and deep, creating an immersive experience.	2026-02-22 16:44:58	2026-02-22 16:44:58
1644	40	657	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-24 16:50:48	2026-02-24 16:50:48
1645	15	657	Surface noise is minimal, allowing the music to speak for itself.	2026-02-20 08:13:32	2026-02-20 08:13:32
1646	32	658	The analog warmth brings out emotions in the music that digital misses.	2026-02-23 16:26:26	2026-02-23 16:26:26
1647	57	658	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-27 17:09:53	2026-02-27 17:09:53
1648	96	659	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-28 06:30:34	2026-02-28 06:30:34
1649	2	659	El sonido es lo importante y aquí brilla con luz propia.	2026-02-26 06:11:54	2026-02-26 06:11:54
1650	94	659	Recomendación absoluta.	2026-02-21 23:48:53	2026-02-21 23:48:53
1651	20	659	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-21 18:03:30	2026-02-21 18:03:30
1652	35	660	Recomendación absoluta.	2026-02-24 23:07:20	2026-02-24 23:07:20
1653	58	660	The analog warmth brings out emotions in the music that digital misses.	2026-02-27 20:22:17	2026-02-27 20:22:17
1654	97	660	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-25 14:31:25	2026-02-25 14:31:25
1655	85	661	Inmejorable relación calidad-precio.	2026-02-24 10:11:54	2026-02-24 10:11:54
1656	77	661	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-26 12:50:08	2026-02-26 12:50:08
1657	51	661	Muy satisfecho.	2026-02-20 23:48:36	2026-02-20 23:48:36
1658	62	662	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-24 06:03:00	2026-02-24 06:03:00
1659	20	662	The soundstage is wide and deep, creating an immersive experience.	2026-02-21 12:56:25	2026-02-21 12:56:25
1660	34	663	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-23 05:15:57	2026-02-23 05:15:57
1661	7	664	Excelente calidad de sonido.	2026-02-21 19:41:19	2026-02-21 19:41:19
1662	48	664	El producto cumple con lo prometido y algo más.	2026-02-27 20:13:28	2026-02-27 20:13:28
1663	56	665	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-27 19:04:28	2026-02-27 19:04:28
1664	94	665	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-22 12:13:50	2026-02-22 12:13:50
1665	80	665	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-25 05:47:23	2026-02-25 05:47:23
1666	12	666	Recomendación absoluta.	2026-02-21 15:23:55	2026-02-21 15:23:55
1667	59	666	El simple acto de colocar la aguja ya genera expectación.	2026-02-24 07:34:49	2026-02-24 07:34:49
1668	27	667	Flat pressing ensures consistent playback across the entire record.	2026-02-21 09:01:17	2026-02-21 09:01:17
1669	33	667	Merece la pena.	2026-02-21 11:37:58	2026-02-21 11:37:58
1670	26	668	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-28 19:15:49	2026-02-28 19:15:49
1671	62	668	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-27 01:05:28	2026-02-27 01:05:28
1672	23	668	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-28 00:03:09	2026-02-28 00:03:09
1673	13	668	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-24 02:02:18	2026-02-24 02:02:18
1674	32	669	Instrument separation is remarkable, each element has its own space.	2026-02-26 14:30:31	2026-02-26 14:30:31
1675	66	670	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-20 12:21:20	2026-02-20 12:21:20
1676	55	670	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-25 07:11:12	2026-02-25 07:11:12
1677	60	671	Experiencia completa.	2026-02-24 20:42:07	2026-02-24 20:42:07
1678	24	672	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-28 00:39:27	2026-02-28 00:39:27
1679	68	672	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-25 13:48:13	2026-02-25 13:48:13
1680	12	673	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-26 22:33:58	2026-02-26 22:33:58
1681	31	673	Muy satisfecho.	2026-02-28 16:46:29	2026-02-28 16:46:29
1682	13	673	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-24 11:47:01	2026-02-24 11:47:01
1683	39	674	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-25 00:32:33	2026-02-25 00:32:33
1684	70	674	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-22 10:24:42	2026-02-22 10:24:42
1685	59	674	Merece la pena.	2026-02-28 12:08:26	2026-02-28 12:08:26
1686	38	674	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-21 17:38:57	2026-02-21 17:38:57
1687	90	675	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-20 12:58:09	2026-02-20 12:58:09
1688	59	675	Pressing de calidad.	2026-02-26 12:10:30	2026-02-26 12:10:30
1689	87	675	Edición cuidada.	2026-02-28 09:06:16	2026-02-28 09:06:16
1690	28	675	Una compra segura si buscas calidad sin excesivos extras.	2026-02-24 09:29:16	2026-02-24 09:29:16
1691	52	676	Una compra segura si buscas calidad sin excesivos extras.	2026-02-20 14:04:01	2026-02-20 14:04:01
1692	92	676	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-22 09:06:19	2026-02-22 09:06:19
2684	86	1091	Pressing de calidad.	2026-02-23 22:11:39	2026-02-23 22:11:39
1693	41	676	Instrument separation is remarkable, each element has its own space.	2026-02-24 19:11:30	2026-02-24 19:11:30
1694	72	676	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-24 22:27:05	2026-02-24 22:27:05
1695	42	677	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-27 10:30:10	2026-02-27 10:30:10
1696	17	677	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-25 04:33:41	2026-02-25 04:33:41
1697	59	678	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-23 12:20:15	2026-02-23 12:20:15
1698	84	679	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-23 19:26:25	2026-02-23 19:26:25
1699	36	679	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-20 10:14:10	2026-02-20 10:14:10
1700	73	680	Flat pressing ensures consistent playback across the entire record.	2026-02-27 01:18:58	2026-02-27 01:18:58
1701	95	680	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-20 14:30:16	2026-02-20 14:30:16
1702	70	681	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-23 16:46:46	2026-02-23 16:46:46
1703	100	681	La portada es una obra de arte por sí sola, además del contenido.	2026-02-20 23:21:04	2026-02-20 23:21:04
1704	8	681	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-23 22:02:30	2026-02-23 22:02:30
1705	29	681	Recomendación absoluta.	2026-02-27 22:04:22	2026-02-27 22:04:22
1706	33	682	El sonido es lo importante y aquí brilla con luz propia.	2026-02-27 21:42:57	2026-02-27 21:42:57
1707	53	682	Totalmente recomendado.	2026-02-21 23:10:30	2026-02-21 23:10:30
1708	66	682	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-24 02:20:30	2026-02-24 02:20:30
1709	97	683	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-25 22:02:23	2026-02-25 22:02:23
1710	84	683	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-23 23:46:31	2026-02-23 23:46:31
1711	28	683	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-26 10:40:51	2026-02-26 10:40:51
1712	36	684	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-25 01:26:10	2026-02-25 01:26:10
1713	75	684	Sonido impecable.	2026-02-23 16:56:54	2026-02-23 16:56:54
1714	74	685	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-24 10:39:49	2026-02-24 10:39:49
1715	61	685	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-25 03:46:25	2026-02-25 03:46:25
1716	8	685	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-20 01:45:28	2026-02-20 01:45:28
1717	51	685	Experiencia completa.	2026-02-20 13:15:57	2026-02-20 13:15:57
1718	100	686	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-25 20:58:09	2026-02-25 20:58:09
1719	44	686	Inmejorable relación calidad-precio.	2026-02-22 19:10:44	2026-02-22 19:10:44
1720	27	687	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-26 04:01:28	2026-02-26 04:01:28
1721	100	688	Recomendación absoluta.	2026-02-26 22:23:19	2026-02-26 22:23:19
1722	45	689	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-25 02:28:39	2026-02-25 02:28:39
1723	1	690	Calidad consistente de principio a fin del disco.	2026-02-27 15:26:29	2026-02-27 15:26:29
1724	13	690	Calidad consistente de principio a fin del disco.	2026-02-25 18:16:12	2026-02-25 18:16:12
1725	94	690	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-25 09:05:57	2026-02-25 09:05:57
1726	36	690	Pressing de calidad.	2026-02-25 06:38:58	2026-02-25 06:38:58
1727	1	691	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-26 19:20:27	2026-02-26 19:20:27
1728	7	691	El producto cumple con lo prometido y algo más.	2026-02-22 01:40:18	2026-02-22 01:40:18
1729	69	691	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-24 02:27:45	2026-02-24 02:27:45
1730	93	692	The soundstage is wide and deep, creating an immersive experience.	2026-02-24 12:21:49	2026-02-24 12:21:49
1731	91	692	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-22 19:57:50	2026-02-22 19:57:50
1732	36	692	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-25 13:07:02	2026-02-25 13:07:02
1733	45	693	Muy satisfecho.	2026-02-21 07:01:28	2026-02-21 07:01:28
1734	96	693	Mastering for vinyl was clearly done with care and expertise.	2026-02-28 12:10:53	2026-02-28 12:10:53
1735	30	693	El simple acto de colocar la aguja ya genera expectación.	2026-02-21 07:31:45	2026-02-21 07:31:45
1736	81	694	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-27 20:53:53	2026-02-27 20:53:53
1737	79	694	El sonido es lo importante y aquí brilla con luz propia.	2026-02-27 10:23:49	2026-02-27 10:23:49
1738	31	694	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-21 16:01:05	2026-02-21 16:01:05
1739	77	694	Sonido impecable.	2026-02-24 23:51:10	2026-02-24 23:51:10
1740	93	695	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-21 10:40:48	2026-02-21 10:40:48
1741	4	695	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-26 19:28:51	2026-02-26 19:28:51
1742	19	696	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-25 09:01:59	2026-02-25 09:01:59
1743	65	697	Inmejorable relación calidad-precio.	2026-02-27 08:13:02	2026-02-27 08:13:02
1744	62	697	El producto cumple con lo prometido y algo más.	2026-02-23 22:06:20	2026-02-23 22:06:20
1745	9	697	Sonido espectacular.	2026-02-24 10:51:15	2026-02-24 10:51:15
1746	99	697	El sonido es lo importante y aquí brilla con luz propia.	2026-02-23 13:47:28	2026-02-23 13:47:28
1747	92	698	The analog warmth brings out emotions in the music that digital misses.	2026-02-22 19:52:43	2026-02-22 19:52:43
1748	22	698	Instrument separation is remarkable, each element has its own space.	2026-02-21 02:27:29	2026-02-21 02:27:29
1749	85	698	Sonido espectacular.	2026-02-27 14:24:22	2026-02-27 14:24:22
1750	5	699	El producto cumple con lo prometido y algo más.	2026-02-28 16:04:57	2026-02-28 16:04:57
1751	14	699	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-23 15:42:48	2026-02-23 15:42:48
1752	46	699	Totalmente recomendado.	2026-02-21 23:28:11	2026-02-21 23:28:11
1753	36	699	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-21 09:32:04	2026-02-21 09:32:04
1754	38	700	El simple acto de colocar la aguja ya genera expectación.	2026-02-26 12:46:19	2026-02-26 12:46:19
1755	76	700	Surface noise is minimal, allowing the music to speak for itself.	2026-02-20 20:07:42	2026-02-20 20:07:42
1756	37	700	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-24 02:32:09	2026-02-24 02:32:09
1757	47	701	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-26 00:52:04	2026-02-26 00:52:04
1758	71	701	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-21 07:09:31	2026-02-21 07:09:31
1759	89	701	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-28 14:01:52	2026-02-28 14:01:52
1760	93	702	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-25 09:04:00	2026-02-25 09:04:00
1761	79	702	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-25 01:44:54	2026-02-25 01:44:54
1762	27	702	Every listen reveals new layers in familiar recordings.	2026-02-21 11:24:10	2026-02-21 11:24:10
1763	93	703	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-21 06:18:57	2026-02-21 06:18:57
1764	58	703	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-20 23:52:52	2026-02-20 23:52:52
1765	84	703	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-22 06:30:53	2026-02-22 06:30:53
1766	12	704	Sonido espectacular.	2026-02-23 05:32:50	2026-02-23 05:32:50
1767	83	704	Sonido espectacular.	2026-02-23 21:50:27	2026-02-23 21:50:27
1768	53	704	Every listen reveals new layers in familiar recordings.	2026-02-21 11:14:39	2026-02-21 11:14:39
1769	61	704	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-25 08:12:43	2026-02-25 08:12:43
1770	28	705	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-26 07:36:42	2026-02-26 07:36:42
1771	57	705	Una compra segura si buscas calidad sin excesivos extras.	2026-02-26 19:47:34	2026-02-26 19:47:34
1772	80	705	Every listen reveals new layers in familiar recordings.	2026-02-22 16:44:02	2026-02-22 16:44:02
1773	4	705	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-26 05:24:22	2026-02-26 05:24:22
1774	44	706	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-22 14:34:28	2026-02-22 14:34:28
1775	30	706	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-26 07:51:59	2026-02-26 07:51:59
1776	30	707	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-27 15:47:00	2026-02-27 15:47:00
1777	1	707	The vinyl compound seems high-quality with excellent durability.	2026-02-21 02:18:13	2026-02-21 02:18:13
1778	6	707	Sonido impecable.	2026-02-26 14:08:07	2026-02-26 14:08:07
1779	13	708	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-27 21:51:07	2026-02-27 21:51:07
1780	4	708	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-20 21:52:44	2026-02-20 21:52:44
1781	61	709	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-27 19:42:05	2026-02-27 19:42:05
1782	69	709	Una compra segura si buscas calidad sin excesivos extras.	2026-02-23 04:44:10	2026-02-23 04:44:10
1783	75	709	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-27 04:27:48	2026-02-27 04:27:48
1784	88	710	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-27 16:19:12	2026-02-27 16:19:12
1785	3	710	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-22 03:16:30	2026-02-22 03:16:30
1786	37	710	Calidad premium.	2026-02-27 03:10:19	2026-02-27 03:10:19
1787	57	710	La portada es una obra de arte por sí sola, además del contenido.	2026-02-28 04:40:28	2026-02-28 04:40:28
1788	1	711	El centrado del label es perfecto, detalles que importan.	2026-02-24 04:59:28	2026-02-24 04:59:28
1789	50	711	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-24 21:10:08	2026-02-24 21:10:08
1790	55	711	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-28 00:04:08	2026-02-28 00:04:08
1791	3	711	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-27 18:25:50	2026-02-27 18:25:50
1792	51	712	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-21 00:47:22	2026-02-21 00:47:22
1793	45	712	The analog warmth brings out emotions in the music that digital misses.	2026-02-27 10:24:38	2026-02-27 10:24:38
1794	83	713	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-23 05:08:18	2026-02-23 05:08:18
1795	24	713	Sonido rico y detallado.	2026-02-23 21:03:06	2026-02-23 21:03:06
1796	91	714	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-21 13:10:03	2026-02-21 13:10:03
1797	50	714	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-22 14:45:45	2026-02-22 14:45:45
1798	84	715	Mastering for vinyl was clearly done with care and expertise.	2026-02-25 13:44:46	2026-02-25 13:44:46
1799	24	715	Merece la pena.	2026-02-28 18:59:12	2026-02-28 18:59:12
1800	20	716	Surface noise is minimal, allowing the music to speak for itself.	2026-02-26 18:04:28	2026-02-26 18:04:28
1801	90	717	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-28 03:07:03	2026-02-28 03:07:03
1802	59	717	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-21 19:21:16	2026-02-21 19:21:16
1803	40	718	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-27 20:22:32	2026-02-27 20:22:32
1804	22	718	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-27 05:29:42	2026-02-27 05:29:42
1805	35	718	Calidad premium.	2026-02-22 20:38:46	2026-02-22 20:38:46
1806	79	719	El sonido es lo importante y aquí brilla con luz propia.	2026-02-24 22:23:49	2026-02-24 22:23:49
1807	87	719	Excelente calidad de sonido.	2026-02-26 04:00:18	2026-02-26 04:00:18
1808	82	720	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-25 00:11:10	2026-02-25 00:11:10
1809	77	720	Mastering for vinyl was clearly done with care and expertise.	2026-02-24 09:49:25	2026-02-24 09:49:25
1810	68	720	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-22 19:56:25	2026-02-22 19:56:25
1811	13	721	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-28 17:23:17	2026-02-28 17:23:17
1812	10	721	Sonido espectacular.	2026-02-28 19:44:38	2026-02-28 19:44:38
1813	24	721	Merece la pena.	2026-02-26 16:22:12	2026-02-26 16:22:12
1814	30	721	Flat pressing ensures consistent playback across the entire record.	2026-02-20 04:39:09	2026-02-20 04:39:09
1815	68	722	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-25 17:00:21	2026-02-25 17:00:21
1816	68	723	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-27 21:46:53	2026-02-27 21:46:53
1817	49	723	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-24 16:49:28	2026-02-24 16:49:28
1818	48	724	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-27 05:19:39	2026-02-27 05:19:39
1819	19	724	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-24 09:59:42	2026-02-24 09:59:42
1820	71	725	Muy satisfecho.	2026-02-28 17:17:59	2026-02-28 17:17:59
1821	71	726	Totalmente recomendado.	2026-02-28 16:52:13	2026-02-28 16:52:13
1822	74	726	Calidad consistente de principio a fin del disco.	2026-02-25 15:16:07	2026-02-25 15:16:07
1823	40	727	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-27 07:23:58	2026-02-27 07:23:58
1824	47	727	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-28 22:48:51	2026-02-28 22:48:51
1825	9	727	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-20 03:02:43	2026-02-20 03:02:43
1826	26	728	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-23 01:57:17	2026-02-23 01:57:17
1827	19	728	Experiencia completa.	2026-02-24 09:22:05	2026-02-24 09:22:05
1828	60	729	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-27 21:01:31	2026-02-27 21:01:31
1829	14	729	Surface noise is minimal, allowing the music to speak for itself.	2026-02-22 18:22:37	2026-02-22 18:22:37
1830	41	729	The analog warmth brings out emotions in the music that digital misses.	2026-02-24 05:47:32	2026-02-24 05:47:32
1831	23	729	Inmejorable relación calidad-precio.	2026-02-22 03:54:22	2026-02-22 03:54:22
1832	70	730	Mastering for vinyl was clearly done with care and expertise.	2026-02-25 23:11:42	2026-02-25 23:11:42
1833	91	730	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-23 21:02:50	2026-02-23 21:02:50
1834	25	731	The analog warmth brings out emotions in the music that digital misses.	2026-02-28 13:16:31	2026-02-28 13:16:31
1835	20	732	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-23 13:27:37	2026-02-23 13:27:37
1836	15	732	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-23 03:58:27	2026-02-23 03:58:27
1837	93	732	Muy satisfecho.	2026-02-28 18:35:13	2026-02-28 18:35:13
1838	1	733	El simple acto de colocar la aguja ya genera expectación.	2026-02-28 09:29:36	2026-02-28 09:29:36
1839	21	733	Calidad premium.	2026-02-21 05:15:16	2026-02-21 05:15:16
1840	38	734	Sonido impecable.	2026-02-22 00:45:39	2026-02-22 00:45:39
1841	82	734	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-27 19:38:08	2026-02-27 19:38:08
1842	47	734	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-25 00:42:18	2026-02-25 00:42:18
1843	83	734	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-28 11:19:34	2026-02-28 11:19:34
1844	72	735	Excelente calidad de sonido.	2026-02-20 06:35:46	2026-02-20 06:35:46
1845	100	735	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-24 03:40:16	2026-02-24 03:40:16
1846	40	735	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-20 00:13:10	2026-02-20 00:13:10
1847	12	735	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-24 04:03:41	2026-02-24 04:03:41
1848	99	736	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-22 19:48:02	2026-02-22 19:48:02
1849	61	736	Experiencia completa.	2026-02-25 11:10:53	2026-02-25 11:10:53
1850	56	737	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-26 15:38:16	2026-02-26 15:38:16
1851	29	738	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-25 05:07:55	2026-02-25 05:07:55
1852	24	738	Totalmente recomendado.	2026-02-22 18:29:51	2026-02-22 18:29:51
1853	48	739	El sonido es lo importante y aquí brilla con luz propia.	2026-02-26 15:47:16	2026-02-26 15:47:16
1854	77	739	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-24 17:53:01	2026-02-24 17:53:01
1855	44	739	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-23 04:30:13	2026-02-23 04:30:13
1856	56	740	Recomendación absoluta.	2026-02-22 22:51:20	2026-02-22 22:51:20
1857	34	740	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-20 19:03:09	2026-02-20 19:03:09
1858	97	740	El simple acto de colocar la aguja ya genera expectación.	2026-02-26 07:42:06	2026-02-26 07:42:06
1859	90	740	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-27 13:12:33	2026-02-27 13:12:33
1860	48	741	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-21 06:27:36	2026-02-21 06:27:36
1861	87	742	El simple acto de colocar la aguja ya genera expectación.	2026-02-24 18:37:49	2026-02-24 18:37:49
1862	23	743	El simple acto de colocar la aguja ya genera expectación.	2026-02-25 19:57:05	2026-02-25 19:57:05
1863	85	744	Sonido impecable.	2026-02-28 17:37:07	2026-02-28 17:37:07
1864	67	744	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-24 04:26:32	2026-02-24 04:26:32
1865	13	745	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-27 13:31:28	2026-02-27 13:31:28
1866	83	746	El producto cumple con lo prometido y algo más.	2026-02-22 10:50:35	2026-02-22 10:50:35
1867	70	747	Muy satisfecho.	2026-02-25 01:06:10	2026-02-25 01:06:10
1868	72	747	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-22 09:26:40	2026-02-22 09:26:40
1869	18	747	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-27 11:59:17	2026-02-27 11:59:17
1870	55	748	La portada es una obra de arte por sí sola, además del contenido.	2026-02-28 06:06:58	2026-02-28 06:06:58
1871	70	749	Every listen reveals new layers in familiar recordings.	2026-02-21 14:48:12	2026-02-21 14:48:12
1872	45	749	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-25 18:24:34	2026-02-25 18:24:34
1873	63	749	El simple acto de colocar la aguja ya genera expectación.	2026-02-23 17:00:12	2026-02-23 17:00:12
1874	40	750	Calidad premium.	2026-02-25 18:54:03	2026-02-25 18:54:03
1875	26	751	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-27 02:42:57	2026-02-27 02:42:57
1876	71	751	Edición cuidada.	2026-02-25 03:28:36	2026-02-25 03:28:36
1877	76	751	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-21 20:54:14	2026-02-21 20:54:14
1878	60	752	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-28 18:17:31	2026-02-28 18:17:31
1879	72	753	The analog warmth brings out emotions in the music that digital misses.	2026-02-25 17:32:38	2026-02-25 17:32:38
1880	99	753	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-22 23:53:50	2026-02-22 23:53:50
1881	55	753	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-27 03:43:35	2026-02-27 03:43:35
1882	19	753	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-23 23:53:24	2026-02-23 23:53:24
1883	100	754	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-20 07:23:34	2026-02-20 07:23:34
1884	56	754	Sonido impecable.	2026-02-24 15:41:35	2026-02-24 15:41:35
1885	66	755	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-28 20:32:12	2026-02-28 20:32:12
1886	33	756	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-24 02:22:01	2026-02-24 02:22:01
1887	82	757	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-22 06:33:47	2026-02-22 06:33:47
1888	96	758	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-28 12:52:56	2026-02-28 12:52:56
1889	43	759	Totalmente recomendado.	2026-02-24 08:53:25	2026-02-24 08:53:25
1890	67	759	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-26 18:06:01	2026-02-26 18:06:01
1891	51	760	The vinyl compound seems high-quality with excellent durability.	2026-02-26 12:31:05	2026-02-26 12:31:05
1892	77	760	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-21 02:50:15	2026-02-21 02:50:15
1893	32	761	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-21 03:03:53	2026-02-21 03:03:53
1894	7	761	The soundstage is wide and deep, creating an immersive experience.	2026-02-25 15:37:22	2026-02-25 15:37:22
1895	83	761	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-27 07:38:18	2026-02-27 07:38:18
1896	49	762	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-23 14:31:27	2026-02-23 14:31:27
1897	9	763	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-23 19:05:26	2026-02-23 19:05:26
1898	66	763	Sonido rico y detallado.	2026-02-27 08:13:10	2026-02-27 08:13:10
1899	26	763	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-22 15:48:22	2026-02-22 15:48:22
1900	70	763	El sonido es lo importante y aquí brilla con luz propia.	2026-02-27 16:16:24	2026-02-27 16:16:24
1901	100	764	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-20 18:39:46	2026-02-20 18:39:46
1902	56	764	El producto cumple con lo prometido y algo más.	2026-02-22 22:11:53	2026-02-22 22:11:53
1903	93	764	The vinyl compound seems high-quality with excellent durability.	2026-02-28 06:11:29	2026-02-28 06:11:29
1904	4	764	Surface noise is minimal, allowing the music to speak for itself.	2026-02-27 17:16:05	2026-02-27 17:16:05
1905	11	765	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-20 16:57:22	2026-02-20 16:57:22
1906	84	765	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-24 21:12:22	2026-02-24 21:12:22
1907	83	765	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-24 20:43:32	2026-02-24 20:43:32
1908	100	765	Una compra segura si buscas calidad sin excesivos extras.	2026-02-22 10:44:36	2026-02-22 10:44:36
1909	11	766	Calidad premium.	2026-02-23 01:51:05	2026-02-23 01:51:05
1910	80	766	Calidad premium.	2026-02-26 00:20:16	2026-02-26 00:20:16
1911	93	766	Calidad consistente de principio a fin del disco.	2026-02-23 01:47:58	2026-02-23 01:47:58
1912	44	766	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-23 19:51:45	2026-02-23 19:51:45
1913	34	767	Every listen reveals new layers in familiar recordings.	2026-02-23 06:34:58	2026-02-23 06:34:58
1914	63	767	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-24 09:28:41	2026-02-24 09:28:41
1915	21	767	El sonido es lo importante y aquí brilla con luz propia.	2026-02-27 17:12:51	2026-02-27 17:12:51
1916	80	768	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-21 04:34:44	2026-02-21 04:34:44
1917	95	769	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-22 02:37:40	2026-02-22 02:37:40
1918	60	769	The vinyl compound seems high-quality with excellent durability.	2026-02-20 05:51:32	2026-02-20 05:51:32
1919	100	770	Pressing de calidad.	2026-02-23 12:40:52	2026-02-23 12:40:52
1920	87	770	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-20 04:55:52	2026-02-20 04:55:52
1921	75	770	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-21 05:42:04	2026-02-21 05:42:04
1922	69	770	Experiencia completa.	2026-02-28 22:50:20	2026-02-28 22:50:20
1923	63	771	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-22 13:23:07	2026-02-22 13:23:07
1924	58	772	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-24 13:03:19	2026-02-24 13:03:19
1925	42	773	Flat pressing ensures consistent playback across the entire record.	2026-02-22 02:47:20	2026-02-22 02:47:20
1926	4	773	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-20 10:34:07	2026-02-20 10:34:07
1927	11	774	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-23 16:31:22	2026-02-23 16:31:22
1928	17	775	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-27 14:09:10	2026-02-27 14:09:10
1929	75	775	Edición cuidada.	2026-02-24 02:33:16	2026-02-24 02:33:16
1930	75	776	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-22 16:32:00	2026-02-22 16:32:00
1931	14	776	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-27 05:29:29	2026-02-27 05:29:29
1932	27	776	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-20 22:37:09	2026-02-20 22:37:09
1933	19	776	Merece la pena.	2026-02-27 20:44:05	2026-02-27 20:44:05
1934	40	777	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-28 18:06:41	2026-02-28 18:06:41
1935	36	778	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-28 04:11:09	2026-02-28 04:11:09
1936	98	779	Calidad premium.	2026-02-28 11:55:40	2026-02-28 11:55:40
1937	72	780	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-23 05:08:01	2026-02-23 05:08:01
1938	29	781	Calidad excepcional.	2026-02-26 15:45:16	2026-02-26 15:45:16
1939	51	781	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-23 01:23:33	2026-02-23 01:23:33
1940	27	782	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-20 22:47:30	2026-02-20 22:47:30
1941	66	783	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-21 10:50:01	2026-02-21 10:50:01
1942	69	783	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-24 21:48:36	2026-02-24 21:48:36
1943	79	783	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-20 10:22:02	2026-02-20 10:22:02
1944	58	783	El centrado del label es perfecto, detalles que importan.	2026-02-24 20:29:56	2026-02-24 20:29:56
1945	96	784	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-26 21:52:30	2026-02-26 21:52:30
1946	16	785	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-27 19:34:15	2026-02-27 19:34:15
1947	67	786	Every listen reveals new layers in familiar recordings.	2026-02-26 01:09:48	2026-02-26 01:09:48
1948	37	786	Totalmente recomendado.	2026-02-26 02:44:36	2026-02-26 02:44:36
1949	61	787	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-26 18:25:58	2026-02-26 18:25:58
1950	63	788	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-23 06:02:13	2026-02-23 06:02:13
1951	96	788	Inmejorable relación calidad-precio.	2026-02-28 08:56:29	2026-02-28 08:56:29
1952	49	788	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-27 07:42:40	2026-02-27 07:42:40
1953	31	789	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-21 02:08:56	2026-02-21 02:08:56
1954	5	789	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-27 03:27:40	2026-02-27 03:27:40
1955	70	789	Sonido espectacular.	2026-02-21 01:31:35	2026-02-21 01:31:35
1956	52	789	Recomendación absoluta.	2026-02-23 22:04:26	2026-02-23 22:04:26
1957	17	790	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-28 21:02:15	2026-02-28 21:02:15
1958	4	791	Calidad excepcional.	2026-02-20 01:21:42	2026-02-20 01:21:42
1959	77	791	Muy satisfecho.	2026-02-22 21:18:06	2026-02-22 21:18:06
1960	24	791	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-26 15:37:01	2026-02-26 15:37:01
1961	19	791	Calidad excepcional.	2026-02-22 11:20:46	2026-02-22 11:20:46
1962	100	792	Sonido rico y detallado.	2026-02-22 08:31:34	2026-02-22 08:31:34
1963	27	792	Every listen reveals new layers in familiar recordings.	2026-02-20 21:36:00	2026-02-20 21:36:00
1964	88	792	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-22 20:19:13	2026-02-22 20:19:13
1965	33	793	El sonido es lo importante y aquí brilla con luz propia.	2026-02-24 17:19:15	2026-02-24 17:19:15
1966	37	793	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-21 19:31:49	2026-02-21 19:31:49
1967	52	793	Inmejorable relación calidad-precio.	2026-02-28 04:55:09	2026-02-28 04:55:09
1968	15	794	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-21 15:28:32	2026-02-21 15:28:32
1969	12	794	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-21 03:27:41	2026-02-21 03:27:41
1970	85	795	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-23 23:28:09	2026-02-23 23:28:09
1971	10	795	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-24 18:11:57	2026-02-24 18:11:57
1972	97	795	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-23 21:32:14	2026-02-23 21:32:14
1973	13	796	El simple acto de colocar la aguja ya genera expectación.	2026-02-20 01:08:41	2026-02-20 01:08:41
1974	100	796	The vinyl compound seems high-quality with excellent durability.	2026-02-20 04:21:13	2026-02-20 04:21:13
1975	28	796	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-22 02:02:11	2026-02-22 02:02:11
1976	3	796	The vinyl compound seems high-quality with excellent durability.	2026-02-23 09:40:35	2026-02-23 09:40:35
1977	67	797	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-25 15:52:26	2026-02-25 15:52:26
1978	6	797	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-26 22:17:46	2026-02-26 22:17:46
1979	98	797	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-20 00:11:56	2026-02-20 00:11:56
1980	65	798	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-28 07:39:44	2026-02-28 07:39:44
1981	69	798	Excelente calidad de sonido.	2026-02-21 06:12:18	2026-02-21 06:12:18
1982	43	798	Edición cuidada.	2026-02-26 23:57:59	2026-02-26 23:57:59
1983	80	798	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-27 04:18:11	2026-02-27 04:18:11
1984	40	799	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-24 08:42:50	2026-02-24 08:42:50
1985	29	800	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-26 01:40:48	2026-02-26 01:40:48
1986	94	801	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-23 15:15:17	2026-02-23 15:15:17
1987	70	801	Calidad excepcional.	2026-02-27 16:03:39	2026-02-27 16:03:39
1988	69	801	Muy buen pressing.	2026-02-24 06:41:59	2026-02-24 06:41:59
1989	91	801	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-25 09:19:54	2026-02-25 09:19:54
1990	58	802	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-23 06:56:49	2026-02-23 06:56:49
1991	66	802	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-21 21:38:18	2026-02-21 21:38:18
1992	67	802	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-26 09:38:32	2026-02-26 09:38:32
1993	64	803	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-26 07:19:51	2026-02-26 07:19:51
1994	14	803	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-25 06:27:26	2026-02-25 06:27:26
1995	61	803	Muy buen pressing.	2026-02-21 13:22:47	2026-02-21 13:22:47
1996	72	804	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-22 08:46:09	2026-02-22 08:46:09
1997	18	804	Sonido rico y detallado.	2026-02-26 07:07:17	2026-02-26 07:07:17
1998	15	805	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-28 17:13:30	2026-02-28 17:13:30
1999	11	806	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-23 04:25:57	2026-02-23 04:25:57
2000	15	806	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-27 14:43:21	2026-02-27 14:43:21
2001	40	806	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-21 09:24:02	2026-02-21 09:24:02
2002	76	806	El simple acto de colocar la aguja ya genera expectación.	2026-02-21 20:00:42	2026-02-21 20:00:42
2003	88	807	Inmejorable relación calidad-precio.	2026-02-25 12:40:37	2026-02-25 12:40:37
2004	92	807	Flat pressing ensures consistent playback across the entire record.	2026-02-24 13:06:31	2026-02-24 13:06:31
2005	96	808	El centrado del label es perfecto, detalles que importan.	2026-02-24 03:19:02	2026-02-24 03:19:02
2006	97	808	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-28 17:39:59	2026-02-28 17:39:59
2007	4	808	Calidad premium.	2026-02-23 08:55:33	2026-02-23 08:55:33
2008	5	808	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-25 10:47:04	2026-02-25 10:47:04
2009	48	809	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-26 10:42:22	2026-02-26 10:42:22
2010	3	810	Edición cuidada.	2026-02-26 01:39:36	2026-02-26 01:39:36
2011	95	811	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-23 00:08:19	2026-02-23 00:08:19
2012	84	811	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-23 14:58:31	2026-02-23 14:58:31
2013	24	812	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-26 22:49:04	2026-02-26 22:49:04
2014	36	813	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-27 09:31:09	2026-02-27 09:31:09
2015	97	813	Inmejorable relación calidad-precio.	2026-02-21 12:55:37	2026-02-21 12:55:37
2016	18	813	Pressing de calidad.	2026-02-27 22:52:41	2026-02-27 22:52:41
2017	76	813	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-21 20:47:56	2026-02-21 20:47:56
2018	7	814	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-21 09:29:34	2026-02-21 09:29:34
2019	66	815	The analog warmth brings out emotions in the music that digital misses.	2026-02-24 08:01:06	2026-02-24 08:01:06
2020	85	816	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-25 16:29:33	2026-02-25 16:29:33
2021	99	817	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-20 16:38:47	2026-02-20 16:38:47
2022	1	817	La portada es una obra de arte por sí sola, además del contenido.	2026-02-20 20:31:32	2026-02-20 20:31:32
2023	76	818	Recomendación absoluta.	2026-02-21 07:13:24	2026-02-21 07:13:24
2024	86	818	Sonido impecable.	2026-02-22 15:23:04	2026-02-22 15:23:04
2025	74	818	Experiencia completa.	2026-02-21 12:52:14	2026-02-21 12:52:14
2026	18	819	Una compra segura si buscas calidad sin excesivos extras.	2026-02-27 17:38:53	2026-02-27 17:38:53
2027	63	819	Totalmente recomendado.	2026-02-28 15:49:06	2026-02-28 15:49:06
2028	2	819	Excelente calidad de sonido.	2026-02-21 02:08:49	2026-02-21 02:08:49
2029	80	820	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-26 15:34:12	2026-02-26 15:34:12
2030	86	821	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-24 19:14:40	2026-02-24 19:14:40
2031	12	821	Pressing de calidad.	2026-02-28 03:57:26	2026-02-28 03:57:26
2032	47	821	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-28 17:12:03	2026-02-28 17:12:03
2033	70	821	Inmejorable relación calidad-precio.	2026-02-23 19:55:53	2026-02-23 19:55:53
2034	86	822	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-24 21:36:37	2026-02-24 21:36:37
2035	64	822	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-22 07:39:50	2026-02-22 07:39:50
2036	42	822	Edición cuidada.	2026-02-27 13:32:27	2026-02-27 13:32:27
2037	41	823	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-24 10:46:54	2026-02-24 10:46:54
2038	56	824	Flat pressing ensures consistent playback across the entire record.	2026-02-24 10:49:41	2026-02-24 10:49:41
2039	61	825	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-26 22:21:09	2026-02-26 22:21:09
2040	2	826	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-27 11:24:28	2026-02-27 11:24:28
2041	85	826	The vinyl compound seems high-quality with excellent durability.	2026-02-20 00:04:54	2026-02-20 00:04:54
2042	63	827	Calidad excepcional.	2026-02-27 14:48:26	2026-02-27 14:48:26
2043	79	827	La portada es una obra de arte por sí sola, además del contenido.	2026-02-28 14:37:36	2026-02-28 14:37:36
2044	70	827	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-28 19:56:36	2026-02-28 19:56:36
2045	6	828	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-20 12:38:29	2026-02-20 12:38:29
2046	62	829	El simple acto de colocar la aguja ya genera expectación.	2026-02-28 15:05:15	2026-02-28 15:05:15
2047	88	829	El simple acto de colocar la aguja ya genera expectación.	2026-02-28 02:54:09	2026-02-28 02:54:09
2048	42	829	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-23 09:21:41	2026-02-23 09:21:41
2049	94	829	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-24 02:02:22	2026-02-24 02:02:22
2050	62	830	Sonido impecable.	2026-02-23 00:42:12	2026-02-23 00:42:12
2051	47	830	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-25 23:05:06	2026-02-25 23:05:06
2052	17	831	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-25 19:55:33	2026-02-25 19:55:33
2053	5	831	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-28 17:25:26	2026-02-28 17:25:26
2054	97	831	Edición cuidada.	2026-02-25 18:20:29	2026-02-25 18:20:29
2055	23	832	El centrado del label es perfecto, detalles que importan.	2026-02-25 16:56:50	2026-02-25 16:56:50
2056	14	832	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-24 13:36:51	2026-02-24 13:36:51
2057	59	832	Sonido espectacular.	2026-02-27 02:58:20	2026-02-27 02:58:20
2058	36	833	Recomendación absoluta.	2026-02-21 00:12:03	2026-02-21 00:12:03
2059	13	833	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-25 21:14:52	2026-02-25 21:14:52
2060	71	833	The soundstage is wide and deep, creating an immersive experience.	2026-02-27 04:29:50	2026-02-27 04:29:50
2061	50	833	El producto cumple con lo prometido y algo más.	2026-02-21 21:54:08	2026-02-21 21:54:08
2062	10	834	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-21 13:28:45	2026-02-21 13:28:45
2063	31	834	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-27 05:24:17	2026-02-27 05:24:17
2064	86	835	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-20 14:15:58	2026-02-20 14:15:58
2065	97	835	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-24 01:53:58	2026-02-24 01:53:58
2066	92	835	Calidad premium.	2026-02-20 03:24:42	2026-02-20 03:24:42
2067	30	836	Recomendación absoluta.	2026-02-21 12:34:37	2026-02-21 12:34:37
2068	82	836	Experiencia completa.	2026-02-22 15:22:20	2026-02-22 15:22:20
2069	75	837	Calidad excepcional.	2026-02-27 17:22:36	2026-02-27 17:22:36
2070	26	838	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-20 00:16:01	2026-02-20 00:16:01
2071	23	839	Muy buen pressing.	2026-02-24 09:36:49	2026-02-24 09:36:49
2072	9	839	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-21 09:53:55	2026-02-21 09:53:55
2073	12	839	The vinyl compound seems high-quality with excellent durability.	2026-02-26 02:16:13	2026-02-26 02:16:13
2074	80	840	Una compra segura si buscas calidad sin excesivos extras.	2026-02-26 04:00:48	2026-02-26 04:00:48
2075	64	840	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-20 21:01:06	2026-02-20 21:01:06
2076	35	840	Mastering for vinyl was clearly done with care and expertise.	2026-02-24 07:15:00	2026-02-24 07:15:00
2077	68	841	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-21 06:39:14	2026-02-21 06:39:14
2078	93	842	Mastering for vinyl was clearly done with care and expertise.	2026-02-27 07:40:07	2026-02-27 07:40:07
2079	65	842	The soundstage is wide and deep, creating an immersive experience.	2026-02-28 02:16:08	2026-02-28 02:16:08
2080	46	843	Experiencia completa.	2026-02-23 23:25:03	2026-02-23 23:25:03
2081	65	843	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-22 23:12:49	2026-02-22 23:12:49
2082	69	844	Pressing de calidad.	2026-02-25 17:36:28	2026-02-25 17:36:28
2083	1	844	Una compra segura si buscas calidad sin excesivos extras.	2026-02-25 16:03:17	2026-02-25 16:03:17
2084	98	844	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-23 14:13:12	2026-02-23 14:13:12
2085	71	844	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-25 19:24:09	2026-02-25 19:24:09
2086	36	845	Muy satisfecho.	2026-02-26 08:00:22	2026-02-26 08:00:22
2087	55	845	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-25 21:54:51	2026-02-25 21:54:51
2088	21	846	La portada es una obra de arte por sí sola, además del contenido.	2026-02-28 16:21:03	2026-02-28 16:21:03
2089	16	846	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-20 01:38:47	2026-02-20 01:38:47
2090	59	846	Flat pressing ensures consistent playback across the entire record.	2026-02-27 09:00:57	2026-02-27 09:00:57
2091	29	847	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-23 16:57:18	2026-02-23 16:57:18
2092	15	847	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-21 00:50:01	2026-02-21 00:50:01
2093	5	848	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-24 02:38:16	2026-02-24 02:38:16
2094	71	848	Pressing de calidad.	2026-02-21 15:44:13	2026-02-21 15:44:13
2095	2	848	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-24 03:28:28	2026-02-24 03:28:28
2096	3	849	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-27 08:43:41	2026-02-27 08:43:41
2097	40	849	Una compra segura si buscas calidad sin excesivos extras.	2026-02-25 05:40:56	2026-02-25 05:40:56
2098	98	849	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-21 11:28:19	2026-02-21 11:28:19
2099	13	849	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-22 13:39:17	2026-02-22 13:39:17
2100	89	850	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-23 07:18:38	2026-02-23 07:18:38
2101	48	851	Every listen reveals new layers in familiar recordings.	2026-02-27 15:18:45	2026-02-27 15:18:45
2102	65	851	Totalmente recomendado.	2026-02-26 02:20:58	2026-02-26 02:20:58
2103	4	851	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-22 10:11:12	2026-02-22 10:11:12
2104	33	851	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-23 17:09:07	2026-02-23 17:09:07
2105	65	852	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-27 08:16:52	2026-02-27 08:16:52
2106	90	852	Edición cuidada.	2026-02-25 02:58:09	2026-02-25 02:58:09
2107	62	852	Recomendación absoluta.	2026-02-25 19:26:57	2026-02-25 19:26:57
2108	53	853	Merece la pena.	2026-02-27 02:59:54	2026-02-27 02:59:54
2109	77	853	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-22 07:00:41	2026-02-22 07:00:41
2110	95	853	El producto cumple con lo prometido y algo más.	2026-02-25 03:59:11	2026-02-25 03:59:11
2111	31	853	La portada es una obra de arte por sí sola, además del contenido.	2026-02-27 22:20:13	2026-02-27 22:20:13
2112	27	854	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-26 07:28:47	2026-02-26 07:28:47
2113	75	855	Experiencia completa.	2026-02-20 22:39:57	2026-02-20 22:39:57
2114	89	856	Calidad excepcional.	2026-02-23 18:54:26	2026-02-23 18:54:26
2115	69	856	Surface noise is minimal, allowing the music to speak for itself.	2026-02-21 03:32:11	2026-02-21 03:32:11
2116	44	856	Muy satisfecho.	2026-02-27 21:45:05	2026-02-27 21:45:05
2117	95	857	El sonido es lo importante y aquí brilla con luz propia.	2026-02-27 03:18:48	2026-02-27 03:18:48
2118	92	857	Inmejorable relación calidad-precio.	2026-02-24 10:52:24	2026-02-24 10:52:24
2119	83	857	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-22 00:33:50	2026-02-22 00:33:50
2120	56	858	Instrument separation is remarkable, each element has its own space.	2026-02-23 20:08:28	2026-02-23 20:08:28
2121	99	858	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-23 22:27:14	2026-02-23 22:27:14
2122	84	859	Flat pressing ensures consistent playback across the entire record.	2026-02-26 03:11:39	2026-02-26 03:11:39
2123	70	860	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-24 22:27:22	2026-02-24 22:27:22
2124	11	860	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-22 16:45:11	2026-02-22 16:45:11
2125	89	861	The vinyl compound seems high-quality with excellent durability.	2026-02-27 00:59:37	2026-02-27 00:59:37
2126	63	861	Muy satisfecho.	2026-02-21 08:33:00	2026-02-21 08:33:00
2127	91	861	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-25 19:53:50	2026-02-25 19:53:50
2128	88	861	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-20 15:44:35	2026-02-20 15:44:35
2129	20	862	Edición cuidada.	2026-02-26 06:37:07	2026-02-26 06:37:07
2130	98	862	Sonido espectacular.	2026-02-23 18:41:27	2026-02-23 18:41:27
2131	66	863	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-25 03:24:33	2026-02-25 03:24:33
2132	10	863	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-22 03:49:53	2026-02-22 03:49:53
2133	85	863	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-26 10:13:00	2026-02-26 10:13:00
2134	58	863	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-23 00:14:16	2026-02-23 00:14:16
2135	47	864	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-25 01:56:47	2026-02-25 01:56:47
2136	40	864	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-22 12:24:42	2026-02-22 12:24:42
2137	72	865	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-21 23:08:02	2026-02-21 23:08:02
2138	40	865	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-25 05:06:10	2026-02-25 05:06:10
2139	81	865	Calidad excepcional.	2026-02-20 22:30:22	2026-02-20 22:30:22
2140	86	866	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-28 05:48:44	2026-02-28 05:48:44
2141	48	866	Sonido espectacular.	2026-02-25 23:23:17	2026-02-25 23:23:17
2142	79	867	Calidad premium.	2026-02-22 11:48:46	2026-02-22 11:48:46
2143	72	867	Excelente calidad de sonido.	2026-02-23 19:00:54	2026-02-23 19:00:54
2144	88	868	Muy buen pressing.	2026-02-25 11:07:27	2026-02-25 11:07:27
2145	96	868	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-24 03:45:49	2026-02-24 03:45:49
2146	98	868	Experiencia completa.	2026-02-20 10:49:51	2026-02-20 10:49:51
2147	89	868	Inmejorable relación calidad-precio.	2026-02-24 22:10:45	2026-02-24 22:10:45
2148	57	869	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-26 01:09:47	2026-02-26 01:09:47
2149	2	870	El sonido es lo importante y aquí brilla con luz propia.	2026-02-25 15:44:53	2026-02-25 15:44:53
2150	34	871	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-28 12:39:59	2026-02-28 12:39:59
2151	93	871	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-28 23:32:19	2026-02-28 23:32:19
2152	77	871	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-25 22:45:30	2026-02-25 22:45:30
2153	5	871	Sonido rico y detallado.	2026-02-25 20:34:30	2026-02-25 20:34:30
2154	86	872	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-26 10:30:09	2026-02-26 10:30:09
2155	73	873	Pressing de calidad.	2026-02-28 01:41:21	2026-02-28 01:41:21
2156	67	873	Edición cuidada.	2026-02-23 02:02:07	2026-02-23 02:02:07
2157	21	873	Calidad premium.	2026-02-23 18:24:58	2026-02-23 18:24:58
2158	67	874	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-26 06:21:25	2026-02-26 06:21:25
2159	27	874	Every listen reveals new layers in familiar recordings.	2026-02-24 02:15:57	2026-02-24 02:15:57
2160	52	874	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-24 07:38:43	2026-02-24 07:38:43
2161	42	875	Sonido espectacular.	2026-02-25 23:51:35	2026-02-25 23:51:35
2162	47	876	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-23 09:58:03	2026-02-23 09:58:03
2163	19	876	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-20 13:28:50	2026-02-20 13:28:50
2164	85	877	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-25 16:49:37	2026-02-25 16:49:37
2165	18	878	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-26 08:43:54	2026-02-26 08:43:54
2166	62	879	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-26 08:52:26	2026-02-26 08:52:26
2167	30	879	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-22 04:56:39	2026-02-22 04:56:39
2168	63	880	The soundstage is wide and deep, creating an immersive experience.	2026-02-28 16:15:06	2026-02-28 16:15:06
2169	17	880	Sonido impecable.	2026-02-24 11:08:54	2026-02-24 11:08:54
2170	55	880	Edición cuidada.	2026-02-23 17:14:10	2026-02-23 17:14:10
2171	97	881	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-24 14:10:00	2026-02-24 14:10:00
2172	5	881	Every listen reveals new layers in familiar recordings.	2026-02-27 10:30:19	2026-02-27 10:30:19
2173	98	881	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-26 08:15:54	2026-02-26 08:15:54
2174	73	881	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-20 01:53:44	2026-02-20 01:53:44
2175	42	882	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-27 04:35:39	2026-02-27 04:35:39
2176	58	882	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-22 04:26:50	2026-02-22 04:26:50
2177	44	882	El centrado del label es perfecto, detalles que importan.	2026-02-24 10:23:10	2026-02-24 10:23:10
2178	43	883	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-21 00:46:58	2026-02-21 00:46:58
2179	4	884	Calidad premium.	2026-02-20 14:32:30	2026-02-20 14:32:30
2180	90	884	Instrument separation is remarkable, each element has its own space.	2026-02-23 14:38:12	2026-02-23 14:38:12
2181	43	884	Recomendación absoluta.	2026-02-23 01:19:11	2026-02-23 01:19:11
2182	8	884	Surface noise is minimal, allowing the music to speak for itself.	2026-02-21 20:36:40	2026-02-21 20:36:40
2183	88	885	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-26 23:52:29	2026-02-26 23:52:29
2184	76	886	Sonido espectacular.	2026-02-21 22:38:19	2026-02-21 22:38:19
2185	19	886	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-28 10:37:02	2026-02-28 10:37:02
2186	11	886	Calidad excepcional.	2026-02-22 04:14:33	2026-02-22 04:14:33
2187	58	886	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-23 10:29:04	2026-02-23 10:29:04
2188	87	887	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-27 03:30:53	2026-02-27 03:30:53
2189	26	888	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-24 09:02:25	2026-02-24 09:02:25
2190	91	889	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-21 20:57:13	2026-02-21 20:57:13
2191	87	890	Calidad premium.	2026-02-21 04:14:16	2026-02-21 04:14:16
2192	96	891	Flat pressing ensures consistent playback across the entire record.	2026-02-22 04:25:00	2026-02-22 04:25:00
2193	32	891	La portada es una obra de arte por sí sola, además del contenido.	2026-02-21 09:50:02	2026-02-21 09:50:02
2194	28	891	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-22 13:50:00	2026-02-22 13:50:00
2195	10	891	Muy buen pressing.	2026-02-28 03:40:47	2026-02-28 03:40:47
2196	92	892	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-28 00:29:33	2026-02-28 00:29:33
2197	94	892	Excelente calidad de sonido.	2026-02-25 12:52:53	2026-02-25 12:52:53
2198	28	893	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-24 05:23:28	2026-02-24 05:23:28
2199	6	894	Pressing de calidad.	2026-02-28 18:26:04	2026-02-28 18:26:04
2200	50	894	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-25 18:32:42	2026-02-25 18:32:42
2201	18	894	Calidad premium.	2026-02-25 04:20:43	2026-02-25 04:20:43
2202	21	894	El simple acto de colocar la aguja ya genera expectación.	2026-02-20 06:54:29	2026-02-20 06:54:29
2203	97	895	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-23 23:08:49	2026-02-23 23:08:49
2204	48	895	Calidad premium.	2026-02-23 14:49:38	2026-02-23 14:49:38
2205	81	896	Sonido impecable.	2026-02-25 16:34:43	2026-02-25 16:34:43
2206	46	896	The soundstage is wide and deep, creating an immersive experience.	2026-02-27 02:20:42	2026-02-27 02:20:42
2207	20	896	Merece la pena.	2026-02-22 14:03:23	2026-02-22 14:03:23
2208	94	896	Sonido espectacular.	2026-02-20 11:28:06	2026-02-20 11:28:06
2209	45	897	Sonido rico y detallado.	2026-02-20 20:24:10	2026-02-20 20:24:10
2210	32	897	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-27 21:40:20	2026-02-27 21:40:20
2211	1	897	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-24 23:03:01	2026-02-24 23:03:01
2212	48	897	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-21 05:00:51	2026-02-21 05:00:51
2213	5	898	Surface noise is minimal, allowing the music to speak for itself.	2026-02-21 08:14:04	2026-02-21 08:14:04
2214	4	898	Flat pressing ensures consistent playback across the entire record.	2026-02-24 17:47:03	2026-02-24 17:47:03
2215	84	898	Surface noise is minimal, allowing the music to speak for itself.	2026-02-27 05:40:44	2026-02-27 05:40:44
2216	60	899	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-23 06:41:54	2026-02-23 06:41:54
2217	66	899	Every listen reveals new layers in familiar recordings.	2026-02-27 04:43:05	2026-02-27 04:43:05
2218	84	899	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-20 22:15:29	2026-02-20 22:15:29
2219	40	899	Instrument separation is remarkable, each element has its own space.	2026-02-22 05:56:31	2026-02-22 05:56:31
2220	96	900	El producto cumple con lo prometido y algo más.	2026-02-26 14:59:05	2026-02-26 14:59:05
2221	25	900	Una compra segura si buscas calidad sin excesivos extras.	2026-02-26 22:23:31	2026-02-26 22:23:31
2222	9	901	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-26 15:12:32	2026-02-26 15:12:32
2223	22	901	Mastering for vinyl was clearly done with care and expertise.	2026-02-26 14:52:13	2026-02-26 14:52:13
2224	34	901	Experiencia completa.	2026-02-24 19:49:29	2026-02-24 19:49:29
2225	96	902	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-27 21:06:57	2026-02-27 21:06:57
2226	89	902	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-27 17:43:34	2026-02-27 17:43:34
2227	69	902	The soundstage is wide and deep, creating an immersive experience.	2026-02-27 01:48:48	2026-02-27 01:48:48
2228	90	903	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-27 16:40:51	2026-02-27 16:40:51
2229	20	904	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-24 04:18:18	2026-02-24 04:18:18
2230	3	904	The analog warmth brings out emotions in the music that digital misses.	2026-02-26 00:19:28	2026-02-26 00:19:28
2231	85	905	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-20 03:10:12	2026-02-20 03:10:12
2232	30	906	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-26 02:00:35	2026-02-26 02:00:35
2233	32	906	Una compra segura si buscas calidad sin excesivos extras.	2026-02-27 10:04:36	2026-02-27 10:04:36
2234	54	906	Excelente calidad de sonido.	2026-02-24 04:47:15	2026-02-24 04:47:15
2235	6	907	Surface noise is minimal, allowing the music to speak for itself.	2026-02-23 04:31:35	2026-02-23 04:31:35
2236	70	908	The analog warmth brings out emotions in the music that digital misses.	2026-02-23 21:00:44	2026-02-23 21:00:44
2237	72	909	The soundstage is wide and deep, creating an immersive experience.	2026-02-20 01:17:51	2026-02-20 01:17:51
2238	61	910	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-26 15:53:28	2026-02-26 15:53:28
2239	71	910	Flat pressing ensures consistent playback across the entire record.	2026-02-26 06:47:57	2026-02-26 06:47:57
2240	76	911	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-20 04:03:48	2026-02-20 04:03:48
2241	27	911	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-20 09:21:07	2026-02-20 09:21:07
2242	82	912	Sonido impecable.	2026-02-24 22:41:44	2026-02-24 22:41:44
2243	79	912	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-26 06:59:58	2026-02-26 06:59:58
2244	74	912	Totalmente recomendado.	2026-02-26 06:40:57	2026-02-26 06:40:57
2245	84	913	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-25 04:32:34	2026-02-25 04:32:34
2246	92	913	Sonido rico y detallado.	2026-02-25 08:47:26	2026-02-25 08:47:26
2247	25	914	Inmejorable relación calidad-precio.	2026-02-24 20:53:27	2026-02-24 20:53:27
2248	81	915	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-23 15:16:55	2026-02-23 15:16:55
2249	100	915	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-20 07:06:59	2026-02-20 07:06:59
2250	17	915	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-27 13:51:42	2026-02-27 13:51:42
2251	64	916	El sonido es lo importante y aquí brilla con luz propia.	2026-02-28 00:40:04	2026-02-28 00:40:04
2252	63	917	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-28 11:13:04	2026-02-28 11:13:04
2253	81	917	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-20 00:47:43	2026-02-20 00:47:43
2254	99	918	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-22 11:20:43	2026-02-22 11:20:43
2255	75	919	Experiencia completa.	2026-02-26 07:36:48	2026-02-26 07:36:48
2256	50	920	El centrado del label es perfecto, detalles que importan.	2026-02-23 23:51:38	2026-02-23 23:51:38
2257	66	920	Merece la pena.	2026-02-28 22:10:25	2026-02-28 22:10:25
2258	61	921	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-20 16:55:33	2026-02-20 16:55:33
2259	82	921	Every listen reveals new layers in familiar recordings.	2026-02-24 01:49:48	2026-02-24 01:49:48
2260	74	921	Experiencia completa.	2026-02-28 08:16:34	2026-02-28 08:16:34
2261	70	922	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-20 11:57:37	2026-02-20 11:57:37
2262	15	922	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-26 05:34:19	2026-02-26 05:34:19
2263	92	923	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-23 04:38:04	2026-02-23 04:38:04
2264	36	923	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-28 02:36:14	2026-02-28 02:36:14
2265	14	923	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-24 19:47:34	2026-02-24 19:47:34
2266	68	924	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-28 03:47:51	2026-02-28 03:47:51
2267	71	924	Instrument separation is remarkable, each element has its own space.	2026-02-28 06:13:16	2026-02-28 06:13:16
2268	20	924	El sonido es lo importante y aquí brilla con luz propia.	2026-02-27 17:54:33	2026-02-27 17:54:33
2269	39	925	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-27 16:42:40	2026-02-27 16:42:40
2270	57	925	El centrado del label es perfecto, detalles que importan.	2026-02-21 06:19:07	2026-02-21 06:19:07
2271	89	926	Inmejorable relación calidad-precio.	2026-02-27 21:30:24	2026-02-27 21:30:24
2272	2	926	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-21 14:26:26	2026-02-21 14:26:26
2273	35	926	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-25 08:10:30	2026-02-25 08:10:30
2274	21	926	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-21 14:52:17	2026-02-21 14:52:17
2275	91	927	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-28 10:26:40	2026-02-28 10:26:40
2276	19	927	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-26 05:31:35	2026-02-26 05:31:35
2277	96	928	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-24 18:59:14	2026-02-24 18:59:14
2278	17	928	Edición cuidada.	2026-02-20 19:39:45	2026-02-20 19:39:45
2279	64	928	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-25 12:45:01	2026-02-25 12:45:01
2280	98	928	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-21 23:03:57	2026-02-21 23:03:57
2281	88	929	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-28 22:38:10	2026-02-28 22:38:10
2282	33	929	El sonido es lo importante y aquí brilla con luz propia.	2026-02-23 05:37:32	2026-02-23 05:37:32
2283	28	930	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-28 17:57:59	2026-02-28 17:57:59
2284	55	930	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-23 09:33:59	2026-02-23 09:33:59
2285	91	930	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-26 22:59:22	2026-02-26 22:59:22
2286	35	930	Surface noise is minimal, allowing the music to speak for itself.	2026-02-28 12:19:27	2026-02-28 12:19:27
2287	14	931	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-26 14:06:26	2026-02-26 14:06:26
2288	50	932	Totalmente recomendado.	2026-02-21 22:14:38	2026-02-21 22:14:38
2289	21	932	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-28 02:24:23	2026-02-28 02:24:23
2290	2	932	The analog warmth brings out emotions in the music that digital misses.	2026-02-23 14:06:38	2026-02-23 14:06:38
2291	73	933	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-25 15:52:38	2026-02-25 15:52:38
2292	65	933	El producto cumple con lo prometido y algo más.	2026-02-23 00:56:57	2026-02-23 00:56:57
2293	69	933	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-23 04:02:48	2026-02-23 04:02:48
2294	100	933	El producto cumple con lo prometido y algo más.	2026-02-25 11:25:19	2026-02-25 11:25:19
2295	72	934	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-26 11:02:04	2026-02-26 11:02:04
2296	73	934	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-22 23:01:27	2026-02-22 23:01:27
2297	50	934	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-24 06:29:10	2026-02-24 06:29:10
2298	51	935	The analog warmth brings out emotions in the music that digital misses.	2026-02-24 00:17:08	2026-02-24 00:17:08
2299	29	935	La portada es una obra de arte por sí sola, además del contenido.	2026-02-27 17:02:08	2026-02-27 17:02:08
2300	24	936	Una compra segura si buscas calidad sin excesivos extras.	2026-02-22 10:04:46	2026-02-22 10:04:46
2301	53	936	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-20 23:10:27	2026-02-20 23:10:27
2302	54	937	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-23 10:00:36	2026-02-23 10:00:36
2303	21	938	Experiencia completa.	2026-02-23 15:14:11	2026-02-23 15:14:11
2304	28	938	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-26 15:04:40	2026-02-26 15:04:40
2305	4	938	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-25 08:20:10	2026-02-25 08:20:10
2306	56	938	Surface noise is minimal, allowing the music to speak for itself.	2026-02-20 21:29:36	2026-02-20 21:29:36
2307	35	939	Edición cuidada.	2026-02-25 19:58:41	2026-02-25 19:58:41
2308	6	940	Totalmente recomendado.	2026-02-20 16:03:12	2026-02-20 16:03:12
2309	99	940	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-25 23:34:18	2026-02-25 23:34:18
2310	64	941	Edición cuidada.	2026-02-26 16:36:07	2026-02-26 16:36:07
2311	85	941	Una compra segura si buscas calidad sin excesivos extras.	2026-02-26 22:27:32	2026-02-26 22:27:32
2312	16	941	Edición cuidada.	2026-02-23 02:51:08	2026-02-23 02:51:08
2313	42	941	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-28 15:39:12	2026-02-28 15:39:12
2314	59	942	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-24 23:51:56	2026-02-24 23:51:56
2315	96	942	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-27 21:57:44	2026-02-27 21:57:44
2316	49	942	The vinyl compound seems high-quality with excellent durability.	2026-02-28 10:15:55	2026-02-28 10:15:55
2317	33	942	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-27 16:06:52	2026-02-27 16:06:52
2318	52	943	Every listen reveals new layers in familiar recordings.	2026-02-27 03:38:48	2026-02-27 03:38:48
2319	61	943	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-20 21:15:54	2026-02-20 21:15:54
2320	65	943	Inmejorable relación calidad-precio.	2026-02-23 09:38:34	2026-02-23 09:38:34
2321	98	944	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-28 05:44:33	2026-02-28 05:44:33
2322	89	944	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-27 14:30:12	2026-02-27 14:30:12
2323	74	945	The soundstage is wide and deep, creating an immersive experience.	2026-02-27 20:43:23	2026-02-27 20:43:23
2324	35	946	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-26 14:30:24	2026-02-26 14:30:24
2325	60	946	Merece la pena.	2026-02-26 03:18:03	2026-02-26 03:18:03
2326	57	946	Muy satisfecho.	2026-02-28 03:04:47	2026-02-28 03:04:47
2327	56	946	Mastering for vinyl was clearly done with care and expertise.	2026-02-22 14:32:51	2026-02-22 14:32:51
2328	40	947	Sonido impecable.	2026-02-28 11:30:30	2026-02-28 11:30:30
2329	99	948	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-27 11:26:20	2026-02-27 11:26:20
2330	98	949	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-28 20:50:33	2026-02-28 20:50:33
2331	10	949	Calidad excepcional.	2026-02-22 08:09:55	2026-02-22 08:09:55
2332	85	949	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-24 21:14:51	2026-02-24 21:14:51
2333	30	949	La portada es una obra de arte por sí sola, además del contenido.	2026-02-22 00:57:15	2026-02-22 00:57:15
2334	27	950	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-25 17:25:32	2026-02-25 17:25:32
2335	15	950	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-23 03:17:06	2026-02-23 03:17:06
2336	63	950	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-23 04:44:44	2026-02-23 04:44:44
2337	24	950	The vinyl compound seems high-quality with excellent durability.	2026-02-27 20:11:00	2026-02-27 20:11:00
2338	10	951	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-27 21:04:26	2026-02-27 21:04:26
2339	98	951	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-23 18:55:19	2026-02-23 18:55:19
2340	22	951	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-22 16:51:52	2026-02-22 16:51:52
2341	89	951	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-27 16:21:24	2026-02-27 16:21:24
2342	14	952	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-25 08:31:12	2026-02-25 08:31:12
2343	85	953	Pressing de calidad.	2026-02-22 21:08:36	2026-02-22 21:08:36
2344	24	954	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-21 06:37:55	2026-02-21 06:37:55
2345	32	955	Inmejorable relación calidad-precio.	2026-02-28 22:44:28	2026-02-28 22:44:28
2346	96	955	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-26 07:32:09	2026-02-26 07:32:09
2347	67	956	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-28 15:45:33	2026-02-28 15:45:33
2348	27	956	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-25 12:46:47	2026-02-25 12:46:47
2349	33	957	Calidad premium.	2026-02-27 01:04:16	2026-02-27 01:04:16
2350	85	957	Inmejorable relación calidad-precio.	2026-02-24 09:11:38	2026-02-24 09:11:38
2351	34	957	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-24 05:39:06	2026-02-24 05:39:06
2352	5	958	Recomendación absoluta.	2026-02-20 19:15:43	2026-02-20 19:15:43
2353	17	959	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-22 01:27:29	2026-02-22 01:27:29
2354	47	959	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-26 18:16:16	2026-02-26 18:16:16
2355	33	960	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-21 23:26:37	2026-02-21 23:26:37
2356	75	960	Una compra segura si buscas calidad sin excesivos extras.	2026-02-27 19:26:30	2026-02-27 19:26:30
2357	33	961	Experiencia completa.	2026-02-26 05:45:47	2026-02-26 05:45:47
2358	5	961	El centrado del label es perfecto, detalles que importan.	2026-02-24 18:26:09	2026-02-24 18:26:09
2359	76	961	Edición cuidada.	2026-02-26 12:15:38	2026-02-26 12:15:38
2360	3	961	Calidad premium.	2026-02-26 20:16:29	2026-02-26 20:16:29
2361	42	962	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-28 10:36:45	2026-02-28 10:36:45
2362	72	962	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-26 23:56:24	2026-02-26 23:56:24
2363	31	963	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-27 02:03:29	2026-02-27 02:03:29
2364	30	963	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-21 04:27:54	2026-02-21 04:27:54
2365	83	964	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-25 10:45:28	2026-02-25 10:45:28
2366	40	964	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-27 19:53:12	2026-02-27 19:53:12
2367	63	964	Sonido impecable.	2026-02-26 09:55:18	2026-02-26 09:55:18
2368	64	964	El simple acto de colocar la aguja ya genera expectación.	2026-02-28 11:55:27	2026-02-28 11:55:27
2369	40	965	Instrument separation is remarkable, each element has its own space.	2026-02-24 18:01:24	2026-02-24 18:01:24
2370	88	966	Sonido impecable.	2026-02-22 10:50:40	2026-02-22 10:50:40
2371	37	966	The vinyl compound seems high-quality with excellent durability.	2026-02-28 08:20:37	2026-02-28 08:20:37
2372	54	966	Calidad excepcional.	2026-02-28 05:55:10	2026-02-28 05:55:10
2373	99	966	Calidad excepcional.	2026-02-22 16:13:00	2026-02-22 16:13:00
2374	72	967	Every listen reveals new layers in familiar recordings.	2026-02-27 23:10:54	2026-02-27 23:10:54
2375	13	967	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-23 22:39:06	2026-02-23 22:39:06
2376	55	967	El simple acto de colocar la aguja ya genera expectación.	2026-02-21 07:55:26	2026-02-21 07:55:26
2377	10	967	El producto cumple con lo prometido y algo más.	2026-02-22 22:38:18	2026-02-22 22:38:18
2378	57	968	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-22 23:56:44	2026-02-22 23:56:44
2379	65	968	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-23 16:49:14	2026-02-23 16:49:14
2380	37	968	Edición cuidada.	2026-02-23 23:24:31	2026-02-23 23:24:31
2381	25	969	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-26 22:03:17	2026-02-26 22:03:17
2382	12	969	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-27 20:30:22	2026-02-27 20:30:22
2383	40	970	La portada es una obra de arte por sí sola, además del contenido.	2026-02-22 04:54:20	2026-02-22 04:54:20
2384	90	970	Recomendación absoluta.	2026-02-25 22:25:42	2026-02-25 22:25:42
2385	73	970	The analog warmth brings out emotions in the music that digital misses.	2026-02-25 17:29:19	2026-02-25 17:29:19
2386	32	970	Experiencia completa.	2026-02-25 21:03:47	2026-02-25 21:03:47
2387	40	971	Excelente calidad de sonido.	2026-02-26 02:43:30	2026-02-26 02:43:30
2388	1	971	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-27 07:21:58	2026-02-27 07:21:58
2389	74	972	Every listen reveals new layers in familiar recordings.	2026-02-20 21:14:38	2026-02-20 21:14:38
2390	29	972	Sonido impecable.	2026-02-26 01:44:53	2026-02-26 01:44:53
2391	89	972	The soundstage is wide and deep, creating an immersive experience.	2026-02-28 19:18:04	2026-02-28 19:18:04
2392	45	973	Excelente calidad de sonido.	2026-02-21 12:18:41	2026-02-21 12:18:41
2393	89	974	Edición cuidada.	2026-02-25 19:33:48	2026-02-25 19:33:48
2394	77	974	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-28 10:59:08	2026-02-28 10:59:08
2395	32	974	El simple acto de colocar la aguja ya genera expectación.	2026-02-25 06:31:54	2026-02-25 06:31:54
2396	57	974	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-20 19:54:44	2026-02-20 19:54:44
2397	40	975	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-28 08:11:18	2026-02-28 08:11:18
2398	60	975	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-26 16:48:19	2026-02-26 16:48:19
2399	8	975	Calidad premium.	2026-02-27 22:04:51	2026-02-27 22:04:51
2400	92	976	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-26 02:39:50	2026-02-26 02:39:50
2401	92	977	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-25 14:31:59	2026-02-25 14:31:59
2402	98	977	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-26 10:49:02	2026-02-26 10:49:02
2403	26	977	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-27 17:03:33	2026-02-27 17:03:33
2404	100	977	Mastering for vinyl was clearly done with care and expertise.	2026-02-24 21:23:57	2026-02-24 21:23:57
2405	65	978	Surface noise is minimal, allowing the music to speak for itself.	2026-02-24 11:12:08	2026-02-24 11:12:08
2406	40	978	Sonido rico y detallado.	2026-02-20 09:50:49	2026-02-20 09:50:49
2407	23	979	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-21 16:13:49	2026-02-21 16:13:49
2408	17	979	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-23 09:30:57	2026-02-23 09:30:57
2409	68	979	The analog warmth brings out emotions in the music that digital misses.	2026-02-26 17:44:58	2026-02-26 17:44:58
2410	81	980	El simple acto de colocar la aguja ya genera expectación.	2026-02-27 03:32:12	2026-02-27 03:32:12
2411	66	980	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-25 12:36:59	2026-02-25 12:36:59
2412	47	980	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-26 07:55:32	2026-02-26 07:55:32
2413	59	980	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-21 11:57:48	2026-02-21 11:57:48
2414	26	981	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-22 20:38:44	2026-02-22 20:38:44
2415	99	981	The analog warmth brings out emotions in the music that digital misses.	2026-02-25 09:16:03	2026-02-25 09:16:03
2416	78	981	The analog warmth brings out emotions in the music that digital misses.	2026-02-22 00:02:01	2026-02-22 00:02:01
2417	65	982	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-20 06:42:13	2026-02-20 06:42:13
2418	79	982	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-23 12:45:11	2026-02-23 12:45:11
2419	86	983	Sonido impecable.	2026-02-21 19:52:50	2026-02-21 19:52:50
2420	54	983	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-26 02:20:37	2026-02-26 02:20:37
2421	8	984	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-23 14:15:06	2026-02-23 14:15:06
2422	84	984	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-27 07:28:56	2026-02-27 07:28:56
2423	68	985	Surface noise is minimal, allowing the music to speak for itself.	2026-02-24 05:45:04	2026-02-24 05:45:04
2424	38	985	El producto cumple con lo prometido y algo más.	2026-02-22 05:55:16	2026-02-22 05:55:16
2425	72	985	El centrado del label es perfecto, detalles que importan.	2026-02-25 17:09:20	2026-02-25 17:09:20
2426	45	985	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-26 04:52:17	2026-02-26 04:52:17
2427	93	986	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-27 21:40:02	2026-02-27 21:40:02
2428	90	987	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-23 16:21:01	2026-02-23 16:21:01
2429	74	988	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-24 13:25:13	2026-02-24 13:25:13
2430	42	988	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-27 03:43:42	2026-02-27 03:43:42
2431	51	988	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-28 18:47:15	2026-02-28 18:47:15
2432	32	989	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-26 05:44:53	2026-02-26 05:44:53
2433	53	989	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-21 03:56:59	2026-02-21 03:56:59
2434	52	989	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-25 05:28:34	2026-02-25 05:28:34
2435	5	989	Inmejorable relación calidad-precio.	2026-02-23 05:08:30	2026-02-23 05:08:30
2436	76	990	Every listen reveals new layers in familiar recordings.	2026-02-20 05:52:31	2026-02-20 05:52:31
2437	44	990	El sonido es lo importante y aquí brilla con luz propia.	2026-02-25 13:41:24	2026-02-25 13:41:24
2438	12	991	La calidad de sonido es realmente impresionante, se nota la dedicación en el mastering.	2026-02-22 12:09:39	2026-02-22 12:09:39
2439	84	991	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-20 08:52:04	2026-02-20 08:52:04
2440	35	992	Flat pressing ensures consistent playback across the entire record.	2026-02-21 15:16:10	2026-02-21 15:16:10
2441	27	993	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-26 00:06:02	2026-02-26 00:06:02
2442	64	993	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-22 00:21:28	2026-02-22 00:21:28
2443	88	993	La limpieza del disco de fábrica es notable, sin residuos visibles.	2026-02-21 01:57:10	2026-02-21 01:57:10
2444	62	994	Totalmente recomendado.	2026-02-24 19:19:44	2026-02-24 19:19:44
2445	58	994	Instrument separation is remarkable, each element has its own space.	2026-02-22 09:26:19	2026-02-22 09:26:19
2446	53	994	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-28 04:47:46	2026-02-28 04:47:46
2447	12	994	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-24 16:45:35	2026-02-24 16:45:35
2448	60	995	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-22 20:44:29	2026-02-22 20:44:29
2449	23	995	Calidad premium.	2026-02-26 23:18:21	2026-02-26 23:18:21
2450	11	996	El producto cumple con lo prometido y algo más.	2026-02-28 23:23:05	2026-02-28 23:23:05
2451	59	996	The soundstage is wide and deep, creating an immersive experience.	2026-02-26 23:57:50	2026-02-26 23:57:50
2452	79	996	Excelente calidad de sonido.	2026-02-25 06:51:02	2026-02-25 06:51:02
2453	81	996	The soundstage is wide and deep, creating an immersive experience.	2026-02-28 02:00:07	2026-02-28 02:00:07
2454	38	997	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-28 03:20:32	2026-02-28 03:20:32
2455	69	998	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-26 00:39:45	2026-02-26 00:39:45
2456	40	998	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-28 07:53:11	2026-02-28 07:53:11
2457	86	998	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-27 23:45:34	2026-02-27 23:45:34
2458	84	999	Inmejorable relación calidad-precio.	2026-02-22 01:35:05	2026-02-22 01:35:05
2459	70	999	The vinyl compound seems high-quality with excellent durability.	2026-02-21 02:19:52	2026-02-21 02:19:52
2460	15	1000	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-24 08:19:18	2026-02-24 08:19:18
2461	7	1001	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-22 18:12:16	2026-02-22 18:12:16
2462	1	1001	Recomendación absoluta.	2026-02-23 03:53:02	2026-02-23 03:53:02
2463	53	1002	Sonido espectacular.	2026-02-22 22:51:05	2026-02-22 22:51:05
2464	40	1002	Excelente calidad de sonido.	2026-02-24 22:06:40	2026-02-24 22:06:40
2465	69	1002	Muy buen pressing.	2026-02-25 20:09:36	2026-02-25 20:09:36
2466	33	1002	The soundstage is wide and deep, creating an immersive experience.	2026-02-23 17:09:08	2026-02-23 17:09:08
2467	80	1003	El producto cumple con lo prometido y algo más.	2026-02-23 04:53:48	2026-02-23 04:53:48
2468	68	1003	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-28 08:13:26	2026-02-28 08:13:26
2469	90	1004	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-21 13:19:39	2026-02-21 13:19:39
2470	80	1005	Calidad consistente de principio a fin del disco.	2026-02-23 07:38:43	2026-02-23 07:38:43
2471	18	1006	Leer las notas mientras suena la música añade profundidad a la escucha.	2026-02-27 18:46:48	2026-02-27 18:46:48
2472	56	1006	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-25 17:32:19	2026-02-25 17:32:19
2473	41	1006	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-24 16:58:02	2026-02-24 16:58:02
2474	83	1006	Excelente calidad de sonido.	2026-02-24 04:45:24	2026-02-24 04:45:24
2475	97	1007	Flat pressing ensures consistent playback across the entire record.	2026-02-25 23:38:47	2026-02-25 23:38:47
2476	90	1008	The soundstage is wide and deep, creating an immersive experience.	2026-02-23 22:10:27	2026-02-23 22:10:27
2477	41	1008	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-23 22:40:51	2026-02-23 22:40:51
2478	77	1008	The vinyl compound seems high-quality with excellent durability.	2026-02-21 22:39:06	2026-02-21 22:39:06
2479	76	1009	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-27 10:13:19	2026-02-27 10:13:19
2480	2	1009	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-20 00:51:03	2026-02-20 00:51:03
2481	53	1009	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-23 09:22:06	2026-02-23 09:22:06
2482	4	1010	El simple acto de colocar la aguja ya genera expectación.	2026-02-23 17:57:44	2026-02-23 17:57:44
2483	77	1010	Merece la pena.	2026-02-26 03:44:52	2026-02-26 03:44:52
2484	65	1010	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-28 02:54:21	2026-02-28 02:54:21
2485	7	1010	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-23 09:39:34	2026-02-23 09:39:34
2486	84	1011	Flat pressing ensures consistent playback across the entire record.	2026-02-24 15:34:42	2026-02-24 15:34:42
2487	1	1011	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-28 12:03:49	2026-02-28 12:03:49
2488	83	1011	Mastering for vinyl was clearly done with care and expertise.	2026-02-22 22:26:44	2026-02-22 22:26:44
2489	23	1011	Experiencia completa.	2026-02-21 21:51:06	2026-02-21 21:51:06
2490	4	1012	Instrument separation is remarkable, each element has its own space.	2026-02-23 05:36:14	2026-02-23 05:36:14
2491	73	1013	Experiencia completa.	2026-02-22 04:21:44	2026-02-22 04:21:44
2492	69	1013	Muy satisfecho.	2026-02-27 07:47:48	2026-02-27 07:47:48
2493	5	1013	El sonido es lo importante y aquí brilla con luz propia.	2026-02-22 11:33:56	2026-02-22 11:33:56
2494	27	1014	El producto cumple con lo prometido y algo más.	2026-02-21 13:49:19	2026-02-21 13:49:19
2495	36	1015	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-26 00:40:56	2026-02-26 00:40:56
2496	90	1015	El producto cumple con lo prometido y algo más.	2026-02-24 15:18:18	2026-02-24 15:18:18
2497	28	1015	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-28 03:35:04	2026-02-28 03:35:04
2498	47	1015	The soundstage is wide and deep, creating an immersive experience.	2026-02-22 00:44:38	2026-02-22 00:44:38
2499	78	1016	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-20 20:45:53	2026-02-20 20:45:53
2500	48	1017	Calidad excepcional.	2026-02-26 00:18:13	2026-02-26 00:18:13
2501	69	1017	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-22 10:14:02	2026-02-22 10:14:02
2502	27	1017	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-22 13:01:13	2026-02-22 13:01:13
2503	76	1018	Sonido impecable.	2026-02-26 15:17:26	2026-02-26 15:17:26
2504	50	1018	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-21 02:04:24	2026-02-21 02:04:24
2505	41	1018	Inmejorable relación calidad-precio.	2026-02-27 17:14:50	2026-02-27 17:14:50
2506	69	1018	The vinyl compound seems high-quality with excellent durability.	2026-02-22 07:14:31	2026-02-22 07:14:31
2507	63	1019	Sonido rico y detallado.	2026-02-27 07:32:28	2026-02-27 07:32:28
2508	79	1020	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-28 04:20:43	2026-02-28 04:20:43
2509	6	1020	Edición cuidada.	2026-02-26 19:15:13	2026-02-26 19:15:13
2510	13	1020	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-28 11:12:39	2026-02-28 11:12:39
2511	40	1021	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-21 02:23:51	2026-02-21 02:23:51
2512	76	1021	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-22 18:52:18	2026-02-22 18:52:18
2513	37	1021	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-26 21:34:09	2026-02-26 21:34:09
2514	95	1022	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-26 04:35:18	2026-02-26 04:35:18
2515	60	1022	El sonido es lo importante y aquí brilla con luz propia.	2026-02-26 02:09:21	2026-02-26 02:09:21
2516	98	1022	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-26 05:30:48	2026-02-26 05:30:48
2517	12	1023	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-23 14:54:14	2026-02-23 14:54:14
2518	72	1023	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-22 10:51:56	2026-02-22 10:51:56
2519	63	1023	Excelente calidad de sonido.	2026-02-26 21:12:31	2026-02-26 21:12:31
2520	42	1024	El simple acto de colocar la aguja ya genera expectación.	2026-02-22 18:15:37	2026-02-22 18:15:37
2521	39	1024	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-25 08:53:15	2026-02-25 08:53:15
2522	70	1024	La portada es una obra de arte por sí sola, además del contenido.	2026-02-22 17:58:28	2026-02-22 17:58:28
2523	7	1025	Totalmente recomendado.	2026-02-24 09:32:45	2026-02-24 09:32:45
2524	53	1025	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-27 19:36:31	2026-02-27 19:36:31
2525	22	1026	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-20 08:20:49	2026-02-20 08:20:49
2526	14	1026	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-24 03:37:31	2026-02-24 03:37:31
2527	43	1026	Los agudos son cristalinos sin llegar a ser estridentes.	2026-02-22 15:49:49	2026-02-22 15:49:49
2528	12	1027	El producto cumple con lo prometido y algo más.	2026-02-22 09:57:01	2026-02-22 09:57:01
2529	67	1027	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-26 02:36:28	2026-02-26 02:36:28
2530	61	1028	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-25 15:58:01	2026-02-25 15:58:01
2531	66	1029	Inmejorable relación calidad-precio.	2026-02-20 11:16:14	2026-02-20 11:16:14
2532	62	1029	La portada es una obra de arte por sí sola, además del contenido.	2026-02-27 15:42:33	2026-02-27 15:42:33
2533	35	1030	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-28 18:08:01	2026-02-28 18:08:01
2534	35	1031	El simple acto de colocar la aguja ya genera expectación.	2026-02-25 15:21:35	2026-02-25 15:21:35
2535	6	1031	La portada es una obra de arte por sí sola, además del contenido.	2026-02-27 11:29:59	2026-02-27 11:29:59
2536	9	1032	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-23 18:37:55	2026-02-23 18:37:55
2537	28	1032	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-27 21:39:42	2026-02-27 21:39:42
2538	42	1033	La portada es una obra de arte por sí sola, además del contenido.	2026-02-25 05:15:10	2026-02-25 05:15:10
2539	25	1033	El centrado del label es perfecto, detalles que importan.	2026-02-27 08:56:26	2026-02-27 08:56:26
2540	43	1033	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-23 07:48:39	2026-02-23 07:48:39
2541	69	1033	El simple acto de colocar la aguja ya genera expectación.	2026-02-20 16:51:12	2026-02-20 16:51:12
2542	76	1034	Merece la pena.	2026-02-21 19:37:36	2026-02-21 19:37:36
2543	60	1034	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-21 23:24:47	2026-02-21 23:24:47
2544	8	1034	Calidad excepcional.	2026-02-27 13:21:49	2026-02-27 13:21:49
2545	81	1035	Edición cuidada.	2026-02-24 22:22:08	2026-02-24 22:22:08
2546	44	1035	Excelente calidad de sonido.	2026-02-21 22:59:52	2026-02-21 22:59:52
2547	85	1035	Sonido espectacular.	2026-02-28 17:19:55	2026-02-28 17:19:55
2548	66	1036	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-23 01:27:06	2026-02-23 01:27:06
2549	13	1036	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-25 07:12:19	2026-02-25 07:12:19
2550	93	1037	The dynamics are handled beautifully, from whispers to crescendos.	2026-02-28 21:54:31	2026-02-28 21:54:31
2551	72	1038	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-24 09:33:54	2026-02-24 09:33:54
2552	47	1038	Un acierto en la biblioteca de cualquier amante del vinilo.	2026-02-24 10:54:09	2026-02-24 10:54:09
2553	50	1038	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-20 11:03:01	2026-02-20 11:03:01
2554	42	1038	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-25 21:27:00	2026-02-25 21:27:00
2555	15	1039	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-27 12:22:22	2026-02-27 12:22:22
2556	76	1040	Muy satisfecho.	2026-02-26 08:58:48	2026-02-26 08:58:48
2557	69	1041	Merece la pena.	2026-02-27 23:09:33	2026-02-27 23:09:33
2558	95	1041	Merece la pena.	2026-02-25 02:46:00	2026-02-25 02:46:00
2559	33	1042	Edición cuidada.	2026-02-25 12:47:43	2026-02-25 12:47:43
2560	44	1043	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-22 06:29:16	2026-02-22 06:29:16
2561	50	1044	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-27 15:20:37	2026-02-27 15:20:37
2562	55	1044	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-22 04:31:51	2026-02-22 04:31:51
2563	19	1044	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-23 21:04:51	2026-02-23 21:04:51
2564	51	1045	Calidad excepcional.	2026-02-27 12:35:25	2026-02-27 12:35:25
2565	54	1045	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-24 17:31:09	2026-02-24 17:31:09
2566	63	1046	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-22 07:05:08	2026-02-22 07:05:08
2567	64	1046	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-26 15:48:25	2026-02-26 15:48:25
2568	2	1046	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-23 16:34:41	2026-02-23 16:34:41
2569	30	1046	Edición cuidada.	2026-02-25 14:01:01	2026-02-25 14:01:01
2570	36	1047	Calidad consistente de principio a fin del disco.	2026-02-21 20:03:35	2026-02-21 20:03:35
2571	1	1047	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-21 01:58:09	2026-02-21 01:58:09
2572	42	1047	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-26 05:08:35	2026-02-26 05:08:35
2573	35	1047	Calidad excepcional.	2026-02-26 13:37:20	2026-02-26 13:37:20
2574	15	1048	Instrument separation is remarkable, each element has its own space.	2026-02-22 03:12:16	2026-02-22 03:12:16
2575	69	1048	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-25 14:58:49	2026-02-25 14:58:49
2576	90	1049	Pressing de calidad.	2026-02-27 00:03:09	2026-02-27 00:03:09
2577	28	1050	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-20 02:00:42	2026-02-20 02:00:42
2578	86	1050	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-20 22:06:21	2026-02-20 22:06:21
2579	19	1050	Calidad excepcional.	2026-02-28 01:38:02	2026-02-28 01:38:02
2580	88	1051	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-25 23:48:21	2026-02-25 23:48:21
2581	81	1051	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-23 11:02:42	2026-02-23 11:02:42
2582	28	1051	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-26 01:53:51	2026-02-26 01:53:51
2583	41	1051	The analog warmth brings out emotions in the music that digital misses.	2026-02-21 08:33:18	2026-02-21 08:33:18
2584	62	1052	Excelente calidad de sonido.	2026-02-20 00:07:17	2026-02-20 00:07:17
2585	23	1052	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-27 17:28:33	2026-02-27 17:28:33
2586	54	1052	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-27 20:13:15	2026-02-27 20:13:15
2587	66	1052	La superficie del disco es perfectamente plana, sin deformaciones.	2026-02-24 21:18:55	2026-02-24 21:18:55
2588	55	1053	Es una experiencia multisensorial: vista, tacto y oído.	2026-02-20 07:04:19	2026-02-20 07:04:19
2589	87	1054	Merece la pena.	2026-02-24 09:49:16	2026-02-24 09:49:16
2590	43	1054	Surface noise is minimal, allowing the music to speak for itself.	2026-02-28 07:04:33	2026-02-28 07:04:33
2591	47	1055	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-28 15:13:42	2026-02-28 15:13:42
2592	74	1055	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-28 08:06:38	2026-02-28 08:06:38
2593	22	1055	Surface noise is minimal, allowing the music to speak for itself.	2026-02-24 14:41:28	2026-02-24 14:41:28
2594	37	1055	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-28 18:45:04	2026-02-28 18:45:04
2595	34	1056	Recomendable sin reservas para quienes aprecian el buen sonido.	2026-02-24 09:46:50	2026-02-24 09:46:50
2596	23	1056	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-24 06:51:15	2026-02-24 06:51:15
2597	76	1057	Cada escucha descubre nuevos detalles en canciones conocidas.	2026-02-20 15:50:14	2026-02-20 15:50:14
2598	58	1057	Una joya para cualquier coleccionista, el pressing está impecable.	2026-02-20 22:52:58	2026-02-20 22:52:58
2599	31	1058	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-26 13:27:56	2026-02-26 13:27:56
2600	4	1058	Muy satisfecho.	2026-02-24 19:59:12	2026-02-24 19:59:12
2601	100	1058	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-27 03:49:58	2026-02-27 03:49:58
2602	54	1059	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-20 11:35:13	2026-02-20 11:35:13
2603	24	1059	A reference-quality pressing that shows what vinyl can truly achieve.	2026-02-25 23:23:41	2026-02-25 23:23:41
2604	20	1059	Calidad premium.	2026-02-26 08:42:06	2026-02-26 08:42:06
2605	93	1060	Edición cuidada.	2026-02-26 16:51:30	2026-02-26 16:51:30
2606	91	1060	The vinyl compound seems high-quality with excellent durability.	2026-02-25 14:09:48	2026-02-25 14:09:48
2607	87	1061	Edición cuidada.	2026-02-25 13:40:05	2026-02-25 13:40:05
2608	82	1062	La separación de instrumentos es clara y definida, muy buen trabajo.	2026-02-21 19:37:02	2026-02-21 19:37:02
2609	35	1062	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-20 23:56:39	2026-02-20 23:56:39
2610	31	1063	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-23 15:44:25	2026-02-23 15:44:25
2611	12	1064	El producto cumple con lo prometido y algo más.	2026-02-27 07:49:59	2026-02-27 07:49:59
2612	81	1064	Excelente calidad de sonido.	2026-02-24 10:28:37	2026-02-24 10:28:37
2613	56	1065	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-21 21:18:36	2026-02-21 21:18:36
2614	62	1066	Sonido espectacular.	2026-02-23 07:36:23	2026-02-23 07:36:23
2615	8	1066	The analog warmth brings out emotions in the music that digital misses.	2026-02-22 10:20:30	2026-02-22 10:20:30
2616	6	1066	Muy satisfecho.	2026-02-27 05:19:52	2026-02-27 05:19:52
2617	94	1067	Poner este vinilo es convertirse en parte del ritual musical.	2026-02-27 10:22:14	2026-02-27 10:22:14
2618	66	1067	Mastering for vinyl was clearly done with care and expertise.	2026-02-20 15:58:04	2026-02-20 15:58:04
2619	30	1067	El ruido de fondo es prácticamente inexistente, señal de buena calidad.	2026-02-21 15:22:10	2026-02-21 15:22:10
2620	5	1068	Recomendación absoluta.	2026-02-23 13:31:54	2026-02-23 13:31:54
2621	22	1068	Experiencia completa.	2026-02-24 02:12:35	2026-02-24 02:12:35
2622	45	1068	Every listen reveals new layers in familiar recordings.	2026-02-22 13:51:06	2026-02-22 13:51:06
2623	66	1068	Sonido impecable.	2026-02-20 01:17:09	2026-02-20 01:17:09
2624	14	1069	Every listen reveals new layers in familiar recordings.	2026-02-28 08:15:00	2026-02-28 08:15:00
2625	51	1069	Sonido rico y detallado.	2026-02-25 21:58:40	2026-02-25 21:58:40
2626	6	1069	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-27 02:23:59	2026-02-27 02:23:59
2627	78	1069	Calidad premium.	2026-02-20 11:08:13	2026-02-20 11:08:13
2628	27	1070	Muy buen pressing.	2026-02-24 21:40:40	2026-02-24 21:40:40
2629	24	1070	Sonido impecable.	2026-02-23 05:22:51	2026-02-23 05:22:51
2630	21	1071	Inmejorable relación calidad-precio.	2026-02-24 17:07:31	2026-02-24 17:07:31
2631	70	1072	Merece la pena.	2026-02-24 20:15:33	2026-02-24 20:15:33
2632	7	1072	Surface noise is minimal, allowing the music to speak for itself.	2026-02-23 20:23:08	2026-02-23 20:23:08
2633	4	1073	Sonido impecable.	2026-02-22 10:10:57	2026-02-22 10:10:57
2634	87	1073	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-24 15:53:09	2026-02-24 15:53:09
2635	23	1073	Experiencia completa.	2026-02-23 00:06:31	2026-02-23 00:06:31
2636	78	1073	Calidad excepcional.	2026-02-28 08:03:09	2026-02-28 08:03:09
2637	2	1074	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-23 02:02:19	2026-02-23 02:02:19
2638	60	1075	Recomendación absoluta.	2026-02-25 18:41:25	2026-02-25 18:41:25
2639	43	1075	Sonido espectacular.	2026-02-21 11:56:12	2026-02-21 11:56:12
2640	69	1076	Muy buen pressing.	2026-02-27 21:39:03	2026-02-27 21:39:03
2641	9	1076	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-20 10:43:48	2026-02-20 10:43:48
2642	99	1076	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-21 13:59:59	2026-02-21 13:59:59
2643	23	1076	El vinilo obliga a reducir la velocidad y realmente escuchar.	2026-02-22 22:12:06	2026-02-22 22:12:06
2644	16	1077	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-23 12:47:43	2026-02-23 12:47:43
2645	55	1077	Surface noise is minimal, allowing the music to speak for itself.	2026-02-23 04:56:53	2026-02-23 04:56:53
2646	80	1077	La calidad del material se nota al tacto, es un vinilo de peso.	2026-02-20 21:25:07	2026-02-20 21:25:07
2647	13	1077	Pressing de calidad.	2026-02-24 16:07:14	2026-02-24 16:07:14
2648	66	1078	Pressing de calidad.	2026-02-21 06:44:14	2026-02-21 06:44:14
2649	71	1078	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-20 07:10:26	2026-02-20 07:10:26
2650	48	1078	The vinyl compound seems high-quality with excellent durability.	2026-02-27 21:45:37	2026-02-27 21:45:37
2651	93	1078	Calidad consistente de principio a fin del disco.	2026-02-25 02:35:56	2026-02-25 02:35:56
2652	49	1079	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-21 00:10:31	2026-02-21 00:10:31
2653	41	1079	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-23 02:51:23	2026-02-23 02:51:23
2654	14	1079	La ausencia de pops y clicks demuestra un pressing cuidado.	2026-02-24 06:42:44	2026-02-24 06:42:44
2655	67	1080	La dinámica es excelente, los cambios de volumen son naturales.	2026-02-24 20:29:00	2026-02-24 20:29:00
2656	96	1080	Mastering for vinyl was clearly done with care and expertise.	2026-02-25 02:37:00	2026-02-25 02:37:00
2657	58	1080	Para el precio, ofrece más de lo que uno podría esperar.	2026-02-22 22:10:30	2026-02-22 22:10:30
2658	19	1080	Experiencia completa.	2026-02-26 08:12:36	2026-02-26 08:12:36
2659	69	1081	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-27 09:46:49	2026-02-27 09:46:49
2660	100	1081	La presentación es excelente, desde la funda hasta los detalles del interior.	2026-02-20 03:15:46	2026-02-20 03:15:46
2661	35	1081	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-25 03:57:20	2026-02-25 03:57:20
2662	9	1082	The analog warmth brings out emotions in the music that digital misses.	2026-02-21 14:57:43	2026-02-21 14:57:43
2663	96	1083	Aunque es una edición básica, la calidad sonora es excelente.	2026-02-28 08:34:17	2026-02-28 08:34:17
2664	22	1083	Every listen reveals new layers in familiar recordings.	2026-02-22 12:30:24	2026-02-22 12:30:24
2665	99	1084	El sonido tiene una calidez que solo el vinilo puede ofrecer.	2026-02-22 18:43:14	2026-02-22 18:43:14
2666	35	1085	Mastering for vinyl was clearly done with care and expertise.	2026-02-28 21:44:07	2026-02-28 21:44:07
2667	21	1085	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-20 03:21:36	2026-02-20 03:21:36
2668	93	1086	El centrado del label es perfecto, detalles que importan.	2026-02-22 10:25:24	2026-02-22 10:25:24
2669	34	1086	Cada giro del disco es una experiencia, los matices se aprecian mejor.	2026-02-20 05:13:30	2026-02-20 05:13:30
2670	57	1087	Muy buen pressing.	2026-02-23 11:54:33	2026-02-23 11:54:33
2671	91	1087	Sonido rico y detallado.	2026-02-23 03:45:44	2026-02-23 03:45:44
2672	42	1087	Calidad excepcional.	2026-02-27 06:32:57	2026-02-27 06:32:57
2673	10	1087	Mastering for vinyl was clearly done with care and expertise.	2026-02-26 15:30:18	2026-02-26 15:30:18
2674	5	1088	Muy satisfecho.	2026-02-21 15:27:49	2026-02-21 15:27:49
2675	32	1089	El cuidado que requiere el formato se traduce en aprecio por la música.	2026-02-21 13:42:00	2026-02-21 13:42:00
2676	14	1089	Muy satisfecho.	2026-02-24 00:55:23	2026-02-24 00:55:23
2677	33	1089	Inmejorable relación calidad-precio.	2026-02-25 14:35:48	2026-02-25 14:35:48
2678	83	1089	Buena relación calidad-precio, el sonido justifica la inversión.	2026-02-20 06:26:21	2026-02-20 06:26:21
2679	69	1090	La portada es una obra de arte por sí sola, además del contenido.	2026-02-24 10:44:43	2026-02-24 10:44:43
2680	5	1090	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-26 23:19:26	2026-02-26 23:19:26
2681	13	1090	The soundstage is wide and deep, creating an immersive experience.	2026-02-24 12:22:48	2026-02-24 12:22:48
2682	23	1091	Suena fresco y vibrante, como si fuera la primera vez que lo escucho.	2026-02-28 00:58:29	2026-02-28 00:58:29
2683	60	1091	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-21 06:54:01	2026-02-21 06:54:01
2685	79	1091	La estereofonía crea una imagen sonora tridimensional increíble.	2026-02-24 19:57:35	2026-02-24 19:57:35
2686	45	1092	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-22 10:16:25	2026-02-22 10:16:25
2687	58	1092	Every listen reveals new layers in familiar recordings.	2026-02-26 10:19:23	2026-02-26 10:19:23
2688	67	1093	El formato invita a escuchar álbumes completos, no solo canciones sueltas.	2026-02-25 18:44:57	2026-02-25 18:44:57
2689	74	1094	Calidad excepcional.	2026-02-22 21:08:21	2026-02-22 21:08:21
2690	55	1094	La respuesta en graves es potente pero controlada, no domina el resto.	2026-02-21 01:23:32	2026-02-21 01:23:32
2691	16	1095	Inmejorable relación calidad-precio.	2026-02-24 13:29:39	2026-02-24 13:29:39
2692	46	1095	El tacto del vinilo, el peso en las manos, todo contribuye a la experiencia.	2026-02-24 08:07:09	2026-02-24 08:07:09
2693	84	1096	El sonido es consistente de principio a fin, incluso en los surcos internos.	2026-02-21 01:55:35	2026-02-21 01:55:35
2694	3	1096	El equilibrio entre graves y agudos es perfecto, sin distorsiones.	2026-02-28 15:10:28	2026-02-28 15:10:28
2695	55	1096	Pequeños detalles en el packaging, pero el disco suena perfecto.	2026-02-26 03:58:12	2026-02-26 03:58:12
2696	77	1096	Excelente calidad de sonido.	2026-02-22 09:37:30	2026-02-22 09:37:30
2697	79	1097	Totalmente recomendado.	2026-02-22 15:24:05	2026-02-22 15:24:05
2698	42	1098	Merece la pena.	2026-02-24 22:50:48	2026-02-24 22:50:48
2699	19	1098	Sonido impecable.	2026-02-22 10:21:34	2026-02-22 10:21:34
2700	26	1098	Recomendación absoluta.	2026-02-22 08:37:35	2026-02-22 08:37:35
2701	76	1098	Cada copia tiene su carácter, esta en particular es excelente.	2026-02-25 05:48:28	2026-02-25 05:48:28
\.


--
-- Data for Name: credit_card; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credit_card (id, user_id, card_number, expiration_date, cvv, brand, is_default, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre (id, name, created_at, updated_at) FROM stdin;
1	rock	2026-02-23 13:15:22.396602	2026-02-23 13:15:22.396602
2	electronic	2026-02-23 13:15:22.396602	2026-02-23 13:15:22.396602
3	metal	2026-02-23 13:15:22.396602	2026-02-23 13:15:22.396602
4	alternative	2026-02-23 13:15:22.396602	2026-02-23 13:15:22.396602
5	hip-hop-rap	2026-02-23 13:15:22.396602	2026-02-23 13:15:22.396602
6	experimental	2026-02-23 13:15:22.396602	2026-02-23 13:15:22.396602
7	punk	2026-02-23 13:15:22.396602	2026-02-23 13:15:22.396602
8	pop	2026-02-23 13:15:22.396602	2026-02-23 13:15:22.396602
9	ambient	2026-02-23 13:15:22.396602	2026-02-23 13:15:22.396602
\.


--
-- Data for Name: order_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_history (id, user_id, order_date, total_amount, quantity, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: order_vinyl; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_vinyl (id, order_id, vinyl_id, quantity, unit_price, created_at) FROM stdin;
\.


--
-- Data for Name: shopping_cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shopping_cart (id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, is_admin, name, surname, username, email, password, avatar_img, country, city, street, postcode, number, created_at, last_login_at, updated_at) FROM stdin;
1	f	Angela	Rubio	user_angela_rubio	angela.rubio@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/74.jpg	Spain	La Palma	Calle de Ferraz	61708	4352	2026-02-23 13:27:04.483421	\N	2026-02-23 13:27:04.483421
2	f	Vicente	Carrasco	user_vicente_carrasco	vicente.carrasco@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/78.jpg	Spain	Castellón de la Plana	Ronda de Toledo	83305	1424	2026-02-23 13:27:04.496014	\N	2026-02-23 13:27:04.496014
3	f	Carmelo	Delgado	user_carmelo_delgado	carmelo.delgado@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/80.jpg	Spain	Torrejón de Ardoz	Calle del Barquillo	38923	2932	2026-02-23 13:27:04.498981	\N	2026-02-23 13:27:04.498981
4	f	Gerardo	Rojas	user_gerardo_rojas	gerardo.rojas@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/74.jpg	Spain	Pamplona	Calle de Ferraz	21187	6760	2026-02-23 13:27:04.501953	\N	2026-02-23 13:27:04.501953
5	f	Arturo	Soto	user_arturo_soto	arturo.soto@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/8.jpg	Spain	Fuenlabrada	Avenida de Andalucía	45277	2789	2026-02-23 13:27:04.50491	\N	2026-02-23 13:27:04.50491
6	f	Adriana	Benítez	user_adriana_benitez	adriana.benitez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/20.jpg	Spain	Santiago de Compostela	Calle de Argumosa	34715	8914	2026-02-23 13:27:04.507933	\N	2026-02-23 13:27:04.507933
7	f	Manuela	Blanco	user_manuela_blanco	manuela.blanco@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/12.jpg	Spain	Parla	Calle de La Almudena	33341	3858	2026-02-23 13:27:04.510875	\N	2026-02-23 13:27:04.510875
8	f	Rubén	Cruz	user_ruben_cruz	ruben.cruz@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/50.jpg	Spain	Murcia	Calle de Alberto Aguilera	73384	9820	2026-02-23 13:27:04.513804	\N	2026-02-23 13:27:04.513804
9	f	Gonzalo	Garrido	user_gonzalo_garrido	gonzalo.garrido@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/16.jpg	Spain	Alcalá de Henares	Calle del Prado	69189	1883	2026-02-23 13:27:04.516607	\N	2026-02-23 13:27:04.516607
10	f	Inés	Pascual	user_ines_pascual	ines.pascual@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/77.jpg	Spain	Vigo	Ronda de Toledo	62276	2109	2026-02-23 13:27:04.519409	\N	2026-02-23 13:27:04.519409
11	f	Ángel	Méndez	user_angel_mendez	angel.mendez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/1.jpg	Spain	Castellón de la Plana	Calle de Téllez	11797	2623	2026-02-23 13:27:04.52224	\N	2026-02-23 13:27:04.52224
12	f	Beatriz	Lorenzo	user_beatriz_lorenzo	beatriz.lorenzo@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/78.jpg	Spain	Orense	Calle de Alcalá	64425	8031	2026-02-23 13:27:04.525113	\N	2026-02-23 13:27:04.525113
13	f	Noelia	Montero	user_noelia_montero	noelia.montero@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/78.jpg	Spain	Ferrol	Calle Covadonga	17393	3678	2026-02-23 13:27:04.527975	\N	2026-02-23 13:27:04.527975
14	f	Salvador	Gómez	user_salvador_gomez	salvador.gomez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/38.jpg	Spain	Santa Cruz de Tenerife	Ronda de Toledo	99805	474	2026-02-23 13:27:04.530855	\N	2026-02-23 13:27:04.530855
15	f	David	Rojas	user_david_rojas	david.rojas@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/35.jpg	Spain	Barcelona	Avenida de Salamanca	52026	2967	2026-02-23 13:27:04.533688	\N	2026-02-23 13:27:04.533688
16	f	Raquel	Delgado	user_raquel_delgado	raquel.delgado@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/56.jpg	Spain	Santiago de Compostela	Calle de Atocha	93309	6174	2026-02-23 13:27:04.5366	\N	2026-02-23 13:27:04.5366
17	f	Oscar	Carrasco	user_oscar_carrasco	oscar.carrasco@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/1.jpg	Spain	Gandía	Avenida de América	10582	2639	2026-02-23 13:27:04.539468	\N	2026-02-23 13:27:04.539468
18	f	Lucia	Gil	user_lucia_gil	lucia.gil@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/87.jpg	Spain	Pontevedra	Calle de La Luna	26699	6999	2026-02-23 13:27:04.542351	\N	2026-02-23 13:27:04.542351
19	f	Lourdes	Delgado	user_lourdes_delgado	lourdes.delgado@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/53.jpg	Spain	Sevilla	Calle de Arganzuela	31976	1148	2026-02-23 13:27:04.545292	\N	2026-02-23 13:27:04.545292
20	f	Dolores	López	user_dolores_lopez	dolores.lopez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/17.jpg	Spain	La Palma	Calle de La Almudena	19099	6946	2026-02-23 13:27:04.548102	\N	2026-02-23 13:27:04.548102
21	f	Mercedes	Diez	user_mercedes_diez	mercedes.diez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/2.jpg	Spain	Toledo	Calle del Prado	63110	1841	2026-02-23 13:27:04.550919	\N	2026-02-23 13:27:04.550919
22	f	Catalina	Jiménez	user_catalina_jimenez	catalina.jimenez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/36.jpg	Spain	Talavera de la Reina	Calle del Arenal	29847	433	2026-02-23 13:27:04.553781	\N	2026-02-23 13:27:04.553781
23	f	Anna	García	user_anna_garcia	anna.garcia@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/59.jpg	Spain	Cartagena	Calle de Alberto Aguilera	16515	4204	2026-02-23 13:27:04.556703	\N	2026-02-23 13:27:04.556703
24	f	Alba	Calvo	user_alba_calvo	alba.calvo@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/87.jpg	Spain	Ciudad Real	Calle de Bravo Murillo	31947	8241	2026-02-23 13:27:04.559578	\N	2026-02-23 13:27:04.559578
25	f	Elisa	Santiago	user_elisa_santiago	elisa.santiago@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/26.jpg	Spain	Vigo	Calle de Arganzuela	40920	7596	2026-02-23 13:27:04.562382	\N	2026-02-23 13:27:04.562382
26	f	Alexander	Vargas	user_alexander_vargas	alexander.vargas@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/74.jpg	Spain	Orense	Calle de Ángel García	96907	4818	2026-02-23 13:27:04.565185	\N	2026-02-23 13:27:04.565185
27	f	Carla	Rojas	user_carla_rojas	carla.rojas@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/63.jpg	Spain	Palma de Mallorca	Paseo de Zorrilla	90336	5297	2026-02-23 13:27:04.570959	\N	2026-02-23 13:27:04.570959
28	f	Marco	Moreno	user_marco_moreno	marco.moreno@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/92.jpg	Spain	Móstoles	Calle de La Luna	51739	630	2026-02-23 13:27:04.577054	\N	2026-02-23 13:27:04.577054
29	f	Montserrat	Molina	user_montserrat_molina	montserrat.molina@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/25.jpg	Spain	Parla	Calle del Prado	72220	3295	2026-02-23 13:27:04.583435	\N	2026-02-23 13:27:04.583435
30	f	Jorge	Gómez	user_jorge_gomez	jorge.gomez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/14.jpg	Spain	Parla	Calle Mota	10348	3015	2026-02-23 13:27:04.586631	\N	2026-02-23 13:27:04.586631
31	f	Cesar	Aguilar	user_cesar_aguilar	cesar.aguilar@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/38.jpg	Spain	Elche	Paseo de Zorrilla	26894	2799	2026-02-23 13:27:04.590324	\N	2026-02-23 13:27:04.590324
32	f	Susana	Cano	user_susana_cano	susana.cano@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/84.jpg	Spain	Hospitalet de Llobregat	Calle de La Almudena	23150	1571	2026-02-23 13:27:04.594276	\N	2026-02-23 13:27:04.594276
33	f	Alberto	Domínguez	user_alberto_dominguez	alberto.dominguez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/17.jpg	Spain	Ferrol	Calle del Barquillo	51726	4668	2026-02-23 13:27:04.59835	\N	2026-02-23 13:27:04.59835
34	f	Vicente	Carrasco	user_vicente_carrasco_1	vicente.carrasco@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/63.jpg	Spain	Torrejón de Ardoz	Paseo de Extremadura	98637	4709	2026-02-23 13:27:04.602095	\N	2026-02-23 13:27:04.602095
35	f	Amparo	Ferrer	user_amparo_ferrer	amparo.ferrer@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/11.jpg	Spain	Palma de Mallorca	Calle de Arturo Soria	87218	9734	2026-02-23 13:27:04.605449	\N	2026-02-23 13:27:04.605449
36	f	Gabriel	Reyes	user_gabriel_reyes	gabriel.reyes@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/95.jpg	Spain	Bilbao	Avenida del Planetario	49036	2381	2026-02-23 13:27:04.608894	\N	2026-02-23 13:27:04.608894
37	f	Josep	Álvarez	user_josep_alvarez	josep.alvarez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/3.jpg	Spain	San Sebastián de Los Reyes	Calle de La Almudena	24675	3073	2026-02-23 13:27:04.61238	\N	2026-02-23 13:27:04.61238
38	f	Ana	Montero	user_ana_montero	ana.montero@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/45.jpg	Spain	Torrevieja	Calle de Toledo	34823	316	2026-02-23 13:27:04.615739	\N	2026-02-23 13:27:04.615739
39	f	Marina	Diaz	user_marina_diaz	marina.diaz@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/18.jpg	Spain	Talavera de la Reina	Calle de Argumosa	19793	3370	2026-02-23 13:27:04.619087	\N	2026-02-23 13:27:04.619087
40	f	Iván	Fuentes	user_ivan_fuentes	ivan.fuentes@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/17.jpg	Spain	Jerez de la Frontera	Avenida de La Albufera	35055	4448	2026-02-23 13:27:04.622236	\N	2026-02-23 13:27:04.622236
41	f	Eduardo	Hernández	user_eduardo_hernandez	eduardo.hernandez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/57.jpg	Spain	Burgos	Avenida de Castilla	98435	373	2026-02-23 13:27:04.625311	\N	2026-02-23 13:27:04.625311
42	f	Rafael	Carmona	user_rafael_carmona	rafael.carmona@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/93.jpg	Spain	Córdoba	Calle de Toledo	75215	1223	2026-02-23 13:27:04.628219	\N	2026-02-23 13:27:04.628219
43	f	Carla	Alonso	user_carla_alonso	carla.alonso@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/85.jpg	Spain	Vigo	Avenida de Andalucía	95029	3285	2026-02-23 13:27:04.631232	\N	2026-02-23 13:27:04.631232
44	f	Rafael	Hernández	user_rafael_hernandez	rafael.hernandez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/95.jpg	Spain	Murcia	Calle de Segovia	69082	652	2026-02-23 13:27:04.634145	\N	2026-02-23 13:27:04.634145
45	f	Remedios	Ferrer	user_remedios_ferrer	remedios.ferrer@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/88.jpg	Spain	Torrevieja	Calle de Argumosa	77509	9148	2026-02-23 13:27:04.637033	\N	2026-02-23 13:27:04.637033
46	f	Sebastián	Serrano	user_sebastian_serrano	sebastian.serrano@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/28.jpg	Spain	Arrecife	Calle de Pedro Bosch	17922	9075	2026-02-23 13:27:04.639843	\N	2026-02-23 13:27:04.639843
47	f	Sandra	Molina	user_sandra_molina	sandra.molina@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/82.jpg	Spain	La Palma	Avenida de La Albufera	94656	1325	2026-02-23 13:27:04.642636	\N	2026-02-23 13:27:04.642636
48	f	Dolores	Álvarez	user_dolores_alvarez	dolores.alvarez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/40.jpg	Spain	Gijón	Avenida de La Albufera	93331	4355	2026-02-23 13:27:04.645416	\N	2026-02-23 13:27:04.645416
49	f	Guillermo	Rubio	user_guillermo_rubio	guillermo.rubio@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/53.jpg	Spain	Murcia	Ronda de Toledo	66635	2607	2026-02-23 13:27:04.648235	\N	2026-02-23 13:27:04.648235
50	f	Víctor	García	user_victor_garcia	victor.garcia@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/44.jpg	Spain	Zaragoza	Avenida de Castilla	82096	5768	2026-02-23 13:27:04.651107	\N	2026-02-23 13:27:04.651107
51	f	Antonia	Suarez	user_antonia_suarez	antonia.suarez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/53.jpg	Spain	Logroño	Calle de Alcalá	34821	5897	2026-02-23 13:27:04.653936	\N	2026-02-23 13:27:04.653936
52	f	Felipe	Domínguez	user_felipe_dominguez	felipe.dominguez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/9.jpg	Spain	Elche	Calle de Alcalá	79761	3336	2026-02-23 13:27:04.656725	\N	2026-02-23 13:27:04.656725
53	f	Fátima	Gil	user_fatima_gil	fatima.gil@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/33.jpg	Spain	Torrejón de Ardoz	Calle Nebrija	30247	5374	2026-02-23 13:27:04.659482	\N	2026-02-23 13:27:04.659482
54	f	Yolanda	Fernández	user_yolanda_fernandez	yolanda.fernandez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/64.jpg	Spain	Granada	Avenida del Planetario	95518	1794	2026-02-23 13:27:04.662302	\N	2026-02-23 13:27:04.662302
55	f	Alfredo	Vega	user_alfredo_vega	alfredo.vega@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/56.jpg	Spain	Santander	Calle de La Democracia	96729	6733	2026-02-23 13:27:04.665137	\N	2026-02-23 13:27:04.665137
56	f	Felipe	Crespo	user_felipe_crespo	felipe.crespo@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/94.jpg	Spain	Córdoba	Calle de La Luna	78718	4569	2026-02-23 13:27:04.667927	\N	2026-02-23 13:27:04.667927
57	f	Víctor	Calvo	user_victor_calvo	victor.calvo@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/79.jpg	Spain	Santa Cruz de Tenerife	Calle de Toledo	98113	7226	2026-02-23 13:27:04.674068	\N	2026-02-23 13:27:04.674068
58	f	Borja	Morales	user_borja_morales	borja.morales@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/10.jpg	Spain	La Palma	Calle del Pez	71146	5447	2026-02-23 13:27:04.676948	\N	2026-02-23 13:27:04.676948
59	f	Lorenzo	Lorenzo	user_lorenzo_lorenzo	lorenzo.lorenzo@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/44.jpg	Spain	Albacete	Calle de Arturo Soria	11619	215	2026-02-23 13:27:04.679858	\N	2026-02-23 13:27:04.679858
60	f	Amparo	Ortiz	user_amparo_ortiz	amparo.ortiz@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/95.jpg	Spain	Albacete	Avenida de Castilla	99519	8652	2026-02-23 13:27:04.682668	\N	2026-02-23 13:27:04.682668
61	f	David	Herrero	user_david_herrero	david.herrero@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/96.jpg	Spain	Córdoba	Calle de Toledo	68228	1904	2026-02-23 13:27:04.685541	\N	2026-02-23 13:27:04.685541
62	f	Noelia	Ibáñez	user_noelia_ibanez	noelia.ibanez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/20.jpg	Spain	Torrejón de Ardoz	Calle de Argumosa	31510	8776	2026-02-23 13:27:04.688275	\N	2026-02-23 13:27:04.688275
63	f	Juan	Domínguez	user_juan_dominguez	juan.dominguez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/75.jpg	Spain	Toledo	Paseo de Extremadura	97820	7792	2026-02-23 13:27:04.691049	\N	2026-02-23 13:27:04.691049
64	f	Luisa	Benítez	user_luisa_benitez	luisa.benitez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/66.jpg	Spain	Alicante	Calle de La Democracia	33958	3306	2026-02-23 13:27:04.693806	\N	2026-02-23 13:27:04.693806
65	f	Francisca	Giménez	user_francisca_gimenez	francisca.gimenez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/31.jpg	Spain	Valencia	Calle de La Almudena	47299	2535	2026-02-23 13:27:04.696553	\N	2026-02-23 13:27:04.696553
66	f	Irene	Santana	user_irene_santana	irene.santana@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/26.jpg	Spain	Castellón de la Plana	Avenida de Burgos	79058	7609	2026-02-23 13:27:04.69936	\N	2026-02-23 13:27:04.69936
67	f	John	Benítez	user_john_benitez	john.benitez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/92.jpg	Spain	Elche	Avenida de Castilla	40103	7555	2026-02-23 13:27:04.702072	\N	2026-02-23 13:27:04.702072
68	f	Sergio	Castro	user_sergio_castro	sergio.castro@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/8.jpg	Spain	Parla	Ronda de Toledo	30257	5748	2026-02-23 13:27:04.704849	\N	2026-02-23 13:27:04.704849
69	f	Marta	Gil	user_marta_gil	marta.gil@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/95.jpg	Spain	Orense	Calle de Ferraz	66996	9954	2026-02-23 13:27:04.707564	\N	2026-02-23 13:27:04.707564
70	f	Natalia	Delgado	user_natalia_delgado	natalia.delgado@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/13.jpg	Spain	Torrejón de Ardoz	Calle de Toledo	54457	9581	2026-02-23 13:27:04.710325	\N	2026-02-23 13:27:04.710325
71	f	Francisca	Pastor	user_francisca_pastor	francisca.pastor@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/21.jpg	Spain	Pontevedra	Calle de Bravo Murillo	88751	282	2026-02-23 13:27:04.713123	\N	2026-02-23 13:27:04.713123
72	f	Daniel	Ruiz	user_daniel_ruiz	daniel.ruiz@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/70.jpg	Spain	Zaragoza	Calle de Arganzuela	74824	1414	2026-02-23 13:27:04.715952	\N	2026-02-23 13:27:04.715952
73	f	Pedro	Morales	user_pedro_morales	pedro.morales@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/16.jpg	Spain	Cartagena	Calle de La Luna	26237	5889	2026-02-23 13:27:04.71873	\N	2026-02-23 13:27:04.71873
74	f	Guillermo	Santiago	user_guillermo_santiago	guillermo.santiago@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/81.jpg	Spain	Pozuelo de Alarcón	Calle de Ferraz	85962	7078	2026-02-23 13:27:04.721656	\N	2026-02-23 13:27:04.721656
75	f	Jonathan	Esteban	user_jonathan_esteban	jonathan.esteban@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/11.jpg	Spain	Albacete	Avenida de Burgos	45256	8842	2026-02-23 13:27:04.724426	\N	2026-02-23 13:27:04.724426
76	f	Javier	Hernández	user_javier_hernandez	javier.hernandez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/49.jpg	Spain	Pamplona	Avenida de Salamanca	67982	4396	2026-02-23 13:27:04.72722	\N	2026-02-23 13:27:04.72722
77	f	Sergio	González	user_sergio_gonzalez	sergio.gonzalez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/77.jpg	Spain	Alicante	Calle de Arganzuela	57242	9629	2026-02-23 13:27:04.730031	\N	2026-02-23 13:27:04.730031
78	f	Enrique	Pascual	user_enrique_pascual	enrique.pascual@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/9.jpg	Spain	Valencia	Avenida de Castilla	18288	4463	2026-02-23 13:27:04.732803	\N	2026-02-23 13:27:04.732803
79	f	Eugenio	Santiago	user_eugenio_santiago	eugenio.santiago@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/93.jpg	Spain	Córdoba	Calle de La Luna	37960	303	2026-02-23 13:27:04.735648	\N	2026-02-23 13:27:04.735648
80	f	Gonzalo	Ferrer	user_gonzalo_ferrer	gonzalo.ferrer@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/87.jpg	Spain	Las Palmas de Gran Canaria	Calle del Arenal	12841	5635	2026-02-23 13:27:04.738525	\N	2026-02-23 13:27:04.738525
81	f	Raquel	Esteban	user_raquel_esteban	raquel.esteban@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/38.jpg	Spain	Torrejón de Ardoz	Calle de Pedro Bosch	97536	5634	2026-02-23 13:27:04.741384	\N	2026-02-23 13:27:04.741384
82	f	Dolores	Soler	user_dolores_soler	dolores.soler@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/64.jpg	Spain	Valladolid	Calle de Segovia	94779	8400	2026-02-23 13:27:04.744243	\N	2026-02-23 13:27:04.744243
83	f	Nieves	Giménez	user_nieves_gimenez	nieves.gimenez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/20.jpg	Spain	Arrecife	Avenida de La Albufera	62466	8829	2026-02-23 13:27:04.747228	\N	2026-02-23 13:27:04.747228
84	f	Ernesto	Santos	user_ernesto_santos	ernesto.santos@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/89.jpg	Spain	Vitoria	Paseo de Zorrilla	29853	9760	2026-02-23 13:27:04.750033	\N	2026-02-23 13:27:04.750033
85	f	Claudia	Montero	user_claudia_montero	claudia.montero@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/6.jpg	Spain	Parla	Calle Covadonga	63211	3583	2026-02-23 13:27:04.752782	\N	2026-02-23 13:27:04.752782
86	f	Iván	Cruz	user_ivan_cruz	ivan.cruz@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/17.jpg	Spain	Bilbao	Avenida de Castilla	75659	1746	2026-02-23 13:27:04.755637	\N	2026-02-23 13:27:04.755637
87	f	Magdalena	Rodríguez	user_magdalena_rodriguez	magdalena.rodriguez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/1.jpg	Spain	Murcia	Calle del Barquillo	24382	3665	2026-02-23 13:27:04.758514	\N	2026-02-23 13:27:04.758514
88	f	Alejandro	Suarez	user_alejandro_suarez	alejandro.suarez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/42.jpg	Spain	Vigo	Paseo de Zorrilla	39076	3545	2026-02-23 13:27:04.761434	\N	2026-02-23 13:27:04.761434
89	f	Samuel	Benítez	user_samuel_benitez	samuel.benitez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/44.jpg	Spain	La Palma	Calle Mota	25679	3177	2026-02-23 13:27:04.764339	\N	2026-02-23 13:27:04.764339
90	f	Alba	Méndez	user_alba_mendez	alba.mendez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/22.jpg	Spain	Móstoles	Avenida de Burgos	77930	8282	2026-02-23 13:27:04.767243	\N	2026-02-23 13:27:04.767243
91	f	Trinidad	Vega	user_trinidad_vega	trinidad.vega@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/52.jpg	Spain	Alicante	Calle de Bravo Murillo	62841	9294	2026-02-23 13:27:04.770047	\N	2026-02-23 13:27:04.770047
92	f	Esteban	Sáez	user_esteban_saez	esteban.saez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/67.jpg	Spain	Móstoles	Ronda de Toledo	43503	6298	2026-02-23 13:27:04.772835	\N	2026-02-23 13:27:04.772835
93	f	Vanesa	Parra	user_vanesa_parra	vanesa.parra@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/47.jpg	Spain	Ferrol	Calle del Prado	72161	4489	2026-02-23 13:27:04.775637	\N	2026-02-23 13:27:04.775637
94	f	Angela	Pastor	user_angela_pastor	angela.pastor@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/31.jpg	Spain	Madrid	Calle de Téllez	46815	7947	2026-02-23 13:27:04.778409	\N	2026-02-23 13:27:04.778409
95	f	Joaquin	Sáez	user_joaquin_saez	joaquin.saez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/58.jpg	Spain	Castellón de la Plana	Calle del Prado	15786	5849	2026-02-23 13:27:04.781232	\N	2026-02-23 13:27:04.781232
96	f	Alfonso	Castro	user_alfonso_castro	alfonso.castro@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/men/9.jpg	Spain	Guadalajara	Calle de La Luna	21778	8356	2026-02-23 13:27:04.787363	\N	2026-02-23 13:27:04.787363
97	f	Susana	Alonso	user_susana_alonso	susana.alonso@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/9.jpg	Spain	Orense	Calle del Barquillo	68878	4779	2026-02-23 13:27:04.790255	\N	2026-02-23 13:27:04.790255
98	f	Luz	Rodríguez	user_luz_rodriguez	luz.rodriguez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/27.jpg	Spain	Parla	Calle de La Democracia	44997	870	2026-02-23 13:27:04.793141	\N	2026-02-23 13:27:04.793141
99	f	Daniela	Ortega	user_daniela_ortega	daniela.ortega@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/74.jpg	Spain	Hospitalet de Llobregat	Calle de Alcalá	95766	4467	2026-02-23 13:27:04.79596	\N	2026-02-23 13:27:04.79596
100	f	José	Martínez	user_jose_martinez	jose.martinez@example.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/women/51.jpg	Spain	Santiago de Compostela	Calle de Argumosa	56252	6112	2026-02-23 13:27:04.798912	\N	2026-02-23 13:27:04.798912
101	t	Admin	Sistema	admin	admin@yggdrasound.com	$2b$12$kB1DRsQZscDrth4DusXrEeXB69oJW4epiL6H1Vk664c/sPd8h0KkW	https://randomuser.me/api/portraits/med/lego/1.jpg	Spain	Madrid	Calle Admin	28001	1	2026-02-23 13:27:04.80184	\N	2026-02-23 13:27:04.80184
\.


--
-- Data for Name: vinyl; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vinyl (id, artist, album, album_url, band_location, release_date, album_cover, price, track_list, track_count, duration, band_url, created_at, updated_at) FROM stdin;
1	Peter Gabriel	In The Big Room	https://petergabriel.bandcamp.com/album/in-the-big-room?from=discover_page	England, UK	2025-06-27	https://f4.bcbits.com/img/a0618500289_16.jpg	34.12	{"Burn You Up, Burn You Down (Live)","More Than This (Live)","Games Without Frontiers (Live)","Downside Up (Live)","Mercy Street (Live)","Darkness (Live)","Digging in the Dirt (Live)","The Tower that Ate People (Live)","San Jacinto (Live)","Shock the Monkey (Live)","Signal to Noise (Live)","Secret World (Live)","Father, Son (Live)","In Your Eyes (Live)"}	14	01:30:54	https://petergabriel.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
2	Peter Gabriel	Live at WOMAD 1982	https://petergabriel.bandcamp.com/album/live-at-womad-1982?from=discover_page	England, UK	2025-08-08	https://f4.bcbits.com/img/a3763114976_16.jpg	34.12	{"San Jacinto","The Family and the Fishing Net","I Have the Touch","Lay Your Hands on Me","Shock the Monkey","I Go Swimming","The Rhythm of the Heat","Kiss of Life",Biko}	9	00:55:52	https://petergabriel.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
3	trauma ray	Carnival	https://traumaray.bandcamp.com/album/carnival?from=discover_page	Fort Worth, Texas	2026-02-20	https://f4.bcbits.com/img/a4153465225_16.jpg	19.54	{carousel,Hannibal,Méliès,Funhouse,Clown}	5	00:23:36	https://traumaray.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
4	Wolf Parade	Apologies to the Queen Mary	https://wolfparade.bandcamp.com/album/apologies-to-the-queen-mary?from=discover_page	Montreal, Québec	2005-09-26	https://f4.bcbits.com/img/a1986885145_16.jpg	19.55	{"You Are A Runner And I Am My Father's Son","Modern World","Grounds For Divorce","We Built Another World","Fancy Claps","Same Ghost Every Night","Shine A Light","Dear Sons and Daughters of Hungry Ghosts","I'll Believe In Anything","It's A Curse","Dinner Bells","This Heart's On Fire"}	12	00:47:52	https://wolfparade.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
5	Dry Cleaning	Secret Love	https://drycleaning.bandcamp.com/album/secret-love?from=discover_page	London, UK	2026-01-09	https://f4.bcbits.com/img/a4213216818_16.jpg	25.73	{"Hit My Head All Day","Cruise Ship Designer","My Soul / Half Pint","Secret Love (Concealed in a Drawing of a Boy)","Let Me Grow and You'll See the Fruit",Blood,"Evil Evil Idiot",Rocks,"The Cute Things","I Need You",Joy}	11	00:41:08	https://drycleaning.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
6	Souled American	Sanctions	https://souledamerican.bandcamp.com/album/sanctions?from=discover_page	Chicago, Illinois	2026-04-17	https://f4.bcbits.com/img/a3904539534_16.jpg	21.25	{Stranger,"Fractured Sun","Boom Boom","Freeing Wheels","Sorry State",E.Q.,Everytime,"Born Free","Living Love","Bad To Be Good",Unforgiven,We}	12	00:44:16	https://souledamerican.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
7	The Third Mind	Spellbinder!	https://thethirdmind.bandcamp.com/album/spellbinder?from=discover_page	Downey, California	2026-03-13	https://f4.bcbits.com/img/a0774253153_16.jpg	21.25	{"Spellbinder (Tchad Blake Mix)","Reap What You Sow","Before We Said Goodbye (with strings)","Darkness, Darkness/The Creator Has a Master Plan (Tchad Blake Remix)"}	4	00:35:57	https://thethirdmind.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
8	Cut Worms	Transmitter	https://cutworms.bandcamp.com/album/transmitter?from=discover_page	Brooklyn, New York	2026-03-13	https://f4.bcbits.com/img/a0000431799_16.jpg	20.39	{"Worlds Unknown","Evil Twin","Long Weekend",Barfly,"Windows on the World","Walk in an Absent Mind","Don’t Look Down","Shut In","Out of Touch",Dream}	10	00:36:26	https://cutworms.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
9	Godspeed You! Black Emperor	Lift Your Skinny Fists Like Antennas To Heaven	https://godspeedyoublackemperor.bandcamp.com/album/lift-your-skinny-fists-like-antennas-to-heaven?from=discover_page	Montreal, Québec	2000-11-08	https://f4.bcbits.com/img/a3636119674_16.jpg	30.60	{Storm,Static,Sleep,"Like Antennas To Heaven..."}	4	01:27:23	https://godspeedyoublackemperor.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
10	KEYGEN CHURCH	Tenebre Rosso Sangue	https://keygenchurch.bandcamp.com/album/tenebre-rosso-sangue?from=discover_page	Rome, Italy	2022-12-17	https://f4.bcbits.com/img/a0375793902_16.jpg	20.00	{"Tenebre Rosso Sangue","Tenebre Rosso Sangue (Calm Loop)","Tenebre Rosso Sangue (Combat Loop)","UltraChurch (Cyber Grind)"}	4	00:13:37	https://keygenchurch.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
11	Godspeed You! Black Emperor	"NO TITLE AS OF 13 FEBRUARY 2024 28,340 DEAD"	https://godspeedyoublackemperor.bandcamp.com/album/no-title-as-of-13-february-2024-28340-dead?from=discover_page	Montreal, Québec	2024-10-04	https://f4.bcbits.com/img/a2589762612_16.jpg	30.60	{"SUN IS A HOLE SUN IS VAPORS","BABYS IN A THUNDERCLOUD","RAINDROPS CAST IN LEAD","BROKEN SPIRES AT DEAD KAPITAL","PALE SPECTATOR TAKES PHOTOGRAPHS","GREY RUBBLE - GREEN SHOOTS"}	6	00:54:11	https://godspeedyoublackemperor.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
12	Black Label Society	Engines of Demolition	https://blacklabelsocietyband.bandcamp.com/album/engines-of-demolition?from=discover_page	Los Angeles, California	2026-03-27	https://f4.bcbits.com/img/a0879002928_16.jpg	31.43	{"Name In Blood","Gatherer of Souls","The Hand of Tomorrows Grave","Better Days & Wiser Times","Broken and Blind","The Gallows","Above & Below","Back To Me","Lord Humungus","Pedal To The Floor","Broken Pieces","The Stranger","Ozzy's Song"}	13	00:51:40	https://blacklabelsocietyband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
13	Castle Rat	The Bestiary	https://castlerat.bandcamp.com/album/the-bestiary?from=discover_page	Brooklyn, New York	2025-09-19	https://f4.bcbits.com/img/a0495744873_16.jpg	23.80	{"PHOENIX I","WOLF I",WIZARD,SIREN,UNICORN,"PATH OF MOSS","CRYSTAL CAVE",SERPENT,"WOLF II",DRAGON,"SUMMONING SPELL","SUN SONG","PHOENIX II"}	13	00:48:38	https://castlerat.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
14	Abrams	Loon	https://abramsrock.bandcamp.com/album/loon?from=discover_page	Denver, Colorado	2026-04-10	https://f4.bcbits.com/img/a4131493993_16.jpg	22.09	{"Glass House","White Walls","Last Nail","Said & Done",Waves,"How Did I Lose My Mind?","A State of Mind",Home,Remains,Sirens}	10	00:37:10	https://abramsrock.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
15	HEALTH	CONFLICT DLC	https://youwillloveeachother.bandcamp.com/album/conflict-dlc?from=discover_page	Los Angeles, California	2025-12-11	https://f4.bcbits.com/img/a0545396081_16.jpg	22.09	{"ORDINARY LOSS","BURN THE CANDLES","VIBE COP","TRASH DECADE","TORTURE II",ANTIDOTE,DARKAGE,"SHRED ENVY","YOU DIED","THOUGHT LEADER","DON’T KILL YOURSELF","WASTED YEARS"}	12	00:39:26	https://youwillloveeachother.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
16	Mod Lang	Borrowed Time	https://modlangdetroit.bandcamp.com/album/borrowed-time?from=discover_page	Detroit, Michigan	2026-02-20	https://f4.bcbits.com/img/a4073494053_16.jpg	23.80	{"What I Can't Have","In Advance",Cocomoda,"Those Words","Fool In Love","Try Your Love","TV Star","Big House","Borrowed Time","In The Morning"}	10	00:35:02	https://modlangdetroit.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
17	Way Dynamic	Massive Shoe	https://waydynamic.bandcamp.com/album/massive-shoe?from=discover_page	Melbourne, Australia	2025-08-22	https://f4.bcbits.com/img/a1236566509_16.jpg	40.00	{"People Settle Down","I Was The Dancer","In Review","Miffed It","Mercy Town","My Visit (To Hell)","The Others",Hurricane,Ibiza,"They Said","Evening Star"}	11	00:34:36	https://waydynamic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
18	Ulver	Neverland	https://ulver.bandcamp.com/album/neverland?from=discover_page	Oslo, Norway	2025-12-31	https://f4.bcbits.com/img/a2850368741_16.jpg	21.24	{"Fear in a Handful of Dust","Elephant Trunk","Weeping Stone","People of the Hills","They're Coming! The Birds!","Hark! Hark! The Dogs Do Bark","Horses of the Plough","Pandora's Box","Quivers in the Marrow","Welcome to the Jungle","Fire in the End"}	11	00:41:39	https://ulver.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
19	Die Spitz	Something To Consume	https://diespitz.bandcamp.com/album/something-to-consume?from=discover_page	Austin, Texas	2025-09-12	https://f4.bcbits.com/img/a0056004218_16.jpg	20.40	{"Pop Punk Anthem (Sorry for the Delay)","Voir Dire","Throw Yourself to the Sword","American Porn","Sound to No One","Go Get Dressed",Red40,"RIDING WITH MY GIRLS",Punishers,"Down on It","a strange moon/selenophilia"}	11	00:34:10	https://diespitz.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
20	Pernice Brothers	Sunny, I Was Wrong	https://pernicebrothers.bandcamp.com/album/sunny-i-was-wrong?from=discover_page	Boston, Massachusetts	2026-04-03	https://f4.bcbits.com/img/a1236572905_16.jpg	25.50	{"Peace in Our Home","Deep into the Dawn (ft. Aimee Mann)","If You Go Back to California","Force Feed the Fire","The Black and the Blue","It Won’t Be Me (ft. Rodney Crowell)","I’d Rather Look Away (ft. Norman Blake)","Sunny, I Was Wrong","Is It Serious","Twenty-Thousand Times","It Got Away from Me (ft. Jimmy Webb)"}	11	00:35:09	https://pernicebrothers.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
21	Winged Wheel	Desert So Green	https://wingedwheel.bandcamp.com/album/desert-so-green?from=discover_page	Detroit, Michigan	2026-01-09	https://f4.bcbits.com/img/a2330470849_16.jpg	18.70	{"Canvas 11","Canvas 2","Speed Table","More Frog Poems","Beautiful Holy Jewel Home","Canvas 8","Bird Spells","I See Poseurs Every Day","The Suite Goes Quiet"}	9	00:42:14	https://wingedwheel.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
22	Annahstasia	Live at Glasshaus	https://annahstasia.bandcamp.com/album/live-at-glasshaus?from=discover_page	Los Angeles, California	2026-03-13	https://f4.bcbits.com/img/a3580219971_16.jpg	34.00	{"Satisfy Me - Live at Glasshaus","Take Care of Me - Live at Glasshaus","Power - Live at Glasshaus","Slow - Live at Glasshaus","Villain - Live at Glasshaus","Unrest - Live at Glasshaus","Evergreen - Live at Glasshaus","Stress Test - Live at Glasshaus","Sunday - Live at Glasshaus","Untamed - Live at Glasshaus","Be Kind - Live at Glasshaus","Saturday - Live at Glasshaus","Believer - Live at Glasshaus"}	13	01:01:57	https://annahstasia.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
23	Powerplant	Bridge of Sacrifice	https://ppowerplant.bandcamp.com/album/bridge-of-sacrifice?from=discover_page	London, UK	2026-03-13	https://f4.bcbits.com/img/a4248709920_16.jpg	1168.83	{"Bridge of Sacrifice","Running Cross",Florida,Transactions,"The Fork","Hall of Wolves","Bad Moon Motel","Last Wheel",Arborglyph,"Red Death",Wingspan}	11	00:38:51	https://ppowerplant.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
24	Band of Horses	Everything All The Time (20th Anniversary Edition)	https://bandofhorses.bandcamp.com/album/everything-all-the-time-20th-anniversary-edition?from=discover_page	Charleston, South Carolina	2026-03-20	https://f4.bcbits.com/img/a3236768930_16.jpg	28.05	{"The First Song","Wicked Gil","Our Swords","The Funeral","Part One","The Great Salt Lake","Weed Party","I Go to the Barn Because I Like The",Monsters,"St. Augustine","(Biding Time Is a) Boat to Row","Part Two","Coal Mine","Worry Song","The End's Not Near","The First Song (Demo Version)","Wicked Gil (Demo Version)","Our Swords (Demo Version)","The Funeral (Demo Version)","Part One (Demo Version)","Our Swords (Live at The Crocodile)","I Go to the Barn Because I Like The / Monsters (Live at The Crocodile)","Showdown (Live at The Crocodile)","Part One (Live at KEXP)"}	24	01:27:33	https://bandofhorses.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
25	Lantlôs	Nowhere In Between Forever	https://lantlos.bandcamp.com/album/nowhere-in-between-forever?from=discover_page	Germany	2026-04-03	https://f4.bcbits.com/img/a0398581976_16.jpg	22.94	{Daisies,Cherries,Oxygen,Jeanet,"Numb TV Superstar","Solar Death",AutoGuard,Planets,Ghost,Clockworks,Windhunter}	11	00:42:27	https://lantlos.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
26	deathcrash	Somersaults	https://deathcrash.bandcamp.com/album/somersaults?from=discover_page	London, UK	2026-02-27	https://f4.bcbits.com/img/a1258804995_16.jpg	26.90	{Somersaults,NYC,CMC,Triumph,Bella,"The Thing You Did","Wrong To Suffer","Stay Forever","Love For M","Marie's Last Dance"}	10	00:41:09	https://deathcrash.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
27	Mark Malibu & the Wasagas	Knock Me Out !	https://markmalibuthewasagas.bandcamp.com/album/knock-me-out?from=discover_page	Toronto, Ontario	2026-01-16	https://f4.bcbits.com/img/a0934670132_16.jpg	21.25	{"K. M. O! - intro","Knock Me Out!","Jellyfish Attack","Reef Break","Love in Liverpool","Turning Point","Night Stalker","Kick Trick","The Swerve","Pepper Stomp!","Mini Chopper","Impact Zone","Jibbed Again","Surfer’s Cross","Cutting the Edge","Moonstone Surfer","On The Way To Warrington","K.M.O!  - Radio ad"}	18	00:38:12	https://markmalibuthewasagas.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
28	Godspeed You! Black Emperor	Slow Riot for New Zero Kanada	https://godspeedyoublackemperor.bandcamp.com/album/slow-riot-for-new-zero-kanada?from=discover_page	Montreal, Québec	1999-03-29	https://f4.bcbits.com/img/a0565708888_16.jpg	21.25	{Moya,"Blaise Bailey Finnegan III"}	2	00:28:37	https://godspeedyoublackemperor.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
273	Jon Sable	Imperfect Circuit EP	https://sablebeats.bandcamp.com/album/imperfect-circuit-ep?from=discover_page	London, UK	2025-12-05	https://f4.bcbits.com/img/a3136914382_16.jpg	14.04	{"Imperfect Circuit","Heads Up","People Person"}	3	00:17:50	https://sablebeats.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
29	The Birthday Massacre	Violet	https://thebirthdaymassacre.bandcamp.com/album/violet?from=discover_page	Toronto, Ontario	2009-12-02	https://f4.bcbits.com/img/a3427994434_16.jpg	25.50	{Prologue,"Lovers End","Happy Birthday","Horrow Show",Violet,Red,"Play Dead",Blue,"Video Kid","The Dream",Black,Holiday,Nevermind}	13	00:46:30	https://thebirthdaymassacre.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
30	Ratboys	Singin’ to an Empty Chair	https://ratboys.bandcamp.com/album/singin-to-an-empty-chair?from=discover_page	Chicago, Illinois	2026-02-06	https://f4.bcbits.com/img/a4078892998_16.jpg	25.50	{"Open Up","Know You Then","Light Night Mountains All That",Anywhere,"Penny in the Lake","Strange Love","The World, So Madly","Just Want You to Know the Truth","What’s Right?","Burn It Down","At Peace in the Hundred Acre Wood"}	11	00:50:51	https://ratboys.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
31	Godspeed You! Black Emperor	ALLELUJAH! DON''T BEND! ASCEND!	https://godspeedyoublackemperor.bandcamp.com/album/allelujah-dont-bend-ascend?from=discover_page	Montreal, Québec	2012-10-16	https://f4.bcbits.com/img/a3340410897_16.jpg	33.15	{Mladic,"Their Helicopters Sing","We Drift Like Worried Fire","Strung Like Lights At Thee Printemps Erable"}	4	00:53:08	https://godspeedyoublackemperor.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
32	Tortoise	Millions Now Living Will Never Die	https://tortoise.bandcamp.com/album/millions-now-living-will-never-die?from=discover_page	Chicago, Illinois	1996-01-30	https://f4.bcbits.com/img/a4201817460_16.jpg	19.55	{Djed,"Glass Museum","A Survey","The Taut and Tame","Dear Grandma and Grandpa","Along the Banks of Rivers"}	6	00:43:00	https://tortoise.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
33	Godspeed You! Black Emperor	Yanqui U.X.O.	https://godspeedyoublackemperor.bandcamp.com/album/yanqui-u-x-o?from=discover_page	Montreal, Québec	2002-11-11	https://f4.bcbits.com/img/a2072134049_16.jpg	30.60	{09-15-00,"09-15-00 (cont.)","Rockets fall on Rocket Falls",motherfucker=redeemer,"motherfucker=redeemer (cont.)"}	5	01:14:58	https://godspeedyoublackemperor.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
34	The Ant Band	From Genesis to Reimagination	https://antband.bandcamp.com/album/from-genesis-to-reimagination?from=discover_page	Germany	2026-02-13	https://f4.bcbits.com/img/a0143925967_16.jpg	25.50	{"In the Beginning","Fireside Song","The Serpent","The Conqueror","Build Me a Mountain","One Day","In the Wilderness","Where the Sour Turns to Sweet","In Hiding","Image Blown Out","Am I Very Wrong?",Window,"Visions of Angels","In Limbo","A Place to Call My Own"}	16	01:04:28	https://antband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
35	Sophomore Lounge	RYAN DAVIS & the Roadhouse Band "New Threats from the Soul"	https://sophomorelounge.bandcamp.com/album/ryan-davis-the-roadhouse-band-new-threats-from-the-soul?from=discover_page	Jeffersonville, Indiana	2025-07-25	https://f4.bcbits.com/img/a1433588771_16.jpg	117.00	{"New Threats from the Soul","Monte Carlo / No Limits","Mutilation Springs","Better If You Make Me","The Simple Joy","Mutilation Falls","Crass Shadows (at Walden Pawn)"}	7	00:57:08	https://sophomorelounge.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
36	The John Martyn Project	The John Martyn Project - Volume Two	https://thejohnmartynproject.bandcamp.com/album/the-john-martyn-project-volume-two?from=discover_page	Bristol, UK	2026-02-07	https://f4.bcbits.com/img/a0085795400_16.jpg	29.25	{"Small Hours","One World","Fairy Tale Lullaby","Go Down Easy","Road to Ruin","One Day Without You","I'd Rather Be The Devil","John Wayne"}	8	00:40:35	https://thejohnmartynproject.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
37	LAB Records	I Wonder If The World Knows? (Deluxe Edition)	https://labrecords.bandcamp.com/album/i-wonder-if-the-world-knows-deluxe-edition?from=discover_page	Manchester, UK	2024-04-05	https://f4.bcbits.com/img/a0102410098_16.jpg	29.25	{Icarus,"Heart On My Sleeve",Chancer,"Throw It All Away","Lights Go Down",Hometown,Landmines,"Hoping Maybe","No Place Like Home","Black and Blue",Circles,"Valley One","Icarus (with Tony Walsh Intro)",Sarajevo,"Glass Towns","Got a Feeling","Just For Today","Dacton & Wanderella"}	18	01:07:30	https://labrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
38	Godspeed You! Black Emperor	"Luciferian Towers"	https://godspeedyoublackemperor.bandcamp.com/album/luciferian-towers?from=discover_page	Montreal, Québec	2017-09-22	https://f4.bcbits.com/img/a4189928277_16.jpg	25.50	{"Undoing A Luciferian Towers","Bosses Hang, Pt. I","Bosses Hang, Pt. II","Bosses Hang, Pt. III",Fam/Famine,"Anthem For No State, Pt. I","Anthem For No State, Pt. II","Anthem For No State, Pt. III"}	8	00:43:54	https://godspeedyoublackemperor.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
39	Twin Peaks	Freezing In Chicago — Live at Thalia Hall, December 31st, 2017	https://twinpeakschicago.bandcamp.com/album/freezing-in-chicago-live-at-thalia-hall-december-31st-2017?from=discover_page	Chicago, Illinois	2026-12-31	https://f4.bcbits.com/img/a2239765803_16.jpg	38.25	{"What Up Dawg (Live)","Good Lovin' (Live)","Tossing Tears (Live)","Butterfly (Live)","Telephone (Live)","Keep It Together (Live)","Sloop Jay D (Live)","Flavor (Live)","I Found A New Way (Live)","Boomers (Live)","In The Meadow (Live)","Natural Villain (Live)","Shake Your Lonely (Live)","Have You Ever (Live)","Getting Better (Live)","Walk To The One You Love (Live)","Making Breakfast (Live)","Holding Roses (Live)","Countdown (Live)","Blue Coupe (Live)","Strawberry Smoothie (Live)","Heavenly Showers (Live)","Wanted You (Live)","We Will Not Make It (Not Without You) (Live)"}	24	01:22:05	https://twinpeakschicago.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
40	Hey Colossus	Heaven Was Wild	https://heycolossus.bandcamp.com/album/heaven-was-wild?from=discover_page	UK	2026-02-27	https://f4.bcbits.com/img/a0184043879_16.jpg	20.47	{"Cannibal Forecast",Roses,Clock,"Death And Deliverance","Runaway Heart","People You Long To Forget",Consequences,"Party Of Fleas","You'll Rot","The Spiders Line"}	10	00:38:01	https://heycolossus.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
41	HENGE	Alpha Test 4	https://hengemusic.bandcamp.com/album/alpha-test-4?from=discover_page	Manchester, UK	2023-05-26	https://f4.bcbits.com/img/a1444847004_16.jpg	29.25	{"Get A Wriggle On","Self Repair Protocol",Wanderlust,Tardigrades,DNA,"Altered State",Ra,"First Encounter","Alpha Test 4",Asteroid}	10	00:35:39	https://hengemusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
56	Silvertwin	Fall Again	https://wearesilvertwin.bandcamp.com/album/fall-again?from=discover_page	London, UK	2026-01-14	https://f4.bcbits.com/img/a2022825959_16.jpg	21.05	{"It's Only Magic","If That's Love (I Don't Want It)","Good To You","Fall Again","Watching The World Go By (Demo)"}	5	00:18:01	https://wearesilvertwin.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
42	Xiu Xiu	Xiu Mutha Fuckin'' Xiu: Vol. 1	https://xiuxiu.bandcamp.com/album/xiu-mutha-fuckin-xiu-vol-1?from=discover_page	Los Angeles, California	2026-01-16	https://f4.bcbits.com/img/a0391210830_16.jpg	20.40	{"Psycho Killer","Warm Leatherette","I Put a Spell on You","Hamburger Lady","In Dreams","Sex Dwarf","Dancing on My Own",SPQR,"Lick or Sum","Some Things Last a Long Time","Triple Sun","Cherry Bomb"}	12	00:45:21	https://xiuxiu.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
43	DJ BACON	BEASTIE FLOYD MEGAMIX (DJBLP01)	https://therealdjbacon.bandcamp.com/album/beastie-floyd-megamix-djblp01?from=discover_page	Australia	2020-05-12	https://f4.bcbits.com/img/a2131676666_16.jpg	39.00	{"BeastieFloyd Megamix Part 1","BeastieFloyd Megamix Part II","Shake Yo Rump (DJ Bacon_BF_Remix) (Single)","Root Down (DJ Bacon_BF_Remix) (Single)","Stop That Train (DJ Bacon_BF_Remix) (Single)","So What Ya Want (DJ Bacon_BF Remix) (Single)","BeastieFloyd Megamix Part 1 (Instrumental)","BeastieFloyd Megamix Part II (Instrumental)"}	8	00:57:19	https://therealdjbacon.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
44	Ghost	Skeletá	https://ghost.bandcamp.com/album/skelet?from=discover_page	Linköping, Sweden	2025-04-25	https://f4.bcbits.com/img/a3343799490_16.jpg	22.10	{Peacefield,Lachryma,Satanized,"Guiding Lights","De Profundis Borealis",Cenotaph,"Missilia Amori","Marks Of The Evil One",Umbra,Excelsis}	11	00:50:45	https://ghost.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
45	Godspeed You! Black Emperor	G_d’s Pee AT STATE’S END!	https://godspeedyoublackemperor.bandcamp.com/album/g-d-s-pee-at-state-s-end?from=discover_page	Montreal, Québec	2021-04-02	https://f4.bcbits.com/img/a1526103098_16.jpg	30.60	{"A Military Alphabet (five eyes all blind) (4521.0kHz 6730.0kHz 4109.09kHz) / Job’s Lament / First of the Last Glaciers / where we break how we shine (ROCKETS FOR MARY)","Fire at Static Valley","“GOVERNMENT CAME” (9980.0kHz 3617.1kHz 4521.0 kHz) / Cliffs Gaze / cliffs’ gaze at empty waters’ rise / ASHES TO SEA or NEARER TO THEE","OUR SIDE HAS TO WIN (for D.H.)"}	4	00:52:38	https://godspeedyoublackemperor.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
46	KEYGEN CHURCH	Nel Nome Del Codice	https://keygenchurch.bandcamp.com/album/nel-nome-del-codice?from=discover_page	Rome, Italy	2024-03-22	https://f4.bcbits.com/img/a1260630093_16.jpg	29.75	{"Se Hai Timore Del Vero","La Chiave Del Mio Amor","Sulla Via Della Gloria","Nel Nome Del Codice","Lode Al Disco Sacro","Il Paradiso Dell'Anima","La Voce Del Destino","Che Sia Vita O Morte","Sempre Nel Mio Pensiero"}	9	00:54:09	https://keygenchurch.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
47	HENGE	Journey to Voltus B LP	https://hengemusic.bandcamp.com/album/journey-to-voltus-b-lp?from=discover_page	Manchester, UK	2025-01-31	https://f4.bcbits.com/img/a1171794523_16.jpg	29.25	{Ascending,Slingshot,Hypersleep,Descending,"Welcome to Voltus","The Power of The Atom (Fusion Version)","Nuclear Fusion","The Power of The Atom (Winter Version)","Nuclear Winter"}	9	00:36:27	https://hengemusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
48	Comet Gain	City Fallen Leaves	https://comet-gain.bandcamp.com/album/city-fallen-leaves?from=discover_page	London, UK	2026-02-13	https://f4.bcbits.com/img/a0517852338_16.jpg	27.99	{"The Fists In The Pocket","Days I Forgot To Write Down","Daydream Scars","Bored Roar","Seven Sisters To Silverlake","This English Melancholy","The Punk Got Fucked","The Story Of The Vivian Girls","Just One More Summer Before I Go","Draw A Smile Upon An Egg","Your Robert!","Fingernailed For You","New Mattress","Gone Before We Open Our Eyes","Right Now? No","The Ballad Of A Mix Tape"}	16	00:51:23	https://comet-gain.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
49	Godspeed You! Black Emperor	Asunder, Sweet and Other Distress	https://godspeedyoublackemperor.bandcamp.com/album/asunder-sweet-and-other-distress?from=discover_page	Montreal, Québec	2015-03-31	https://f4.bcbits.com/img/a2430150895_16.jpg	25.50	{"Peasantry or ‘Light! Inside of Light!’","Lambs’ Breath","Asunder, Sweet","Piss Crowns Are Trebled"}	4	00:40:23	https://godspeedyoublackemperor.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
50	Chunklet Industries	WhaRvEy milK	https://chunklet.bandcamp.com/album/wharvey-milk?from=discover_page	Atlanta, Georgia	2026-01-23	https://f4.bcbits.com/img/a4253518876_16.jpg	23.79	{Pretty,"Chain Wallet In Shop/Jim’s Polish","Women Dig It","Shit Pile","Yer Mouse Gets My Dander Up",F.S.T.P.}	6	00:55:24	https://chunklet.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
51	Airbag	Airbag - Dysphoria (Live in the Netherlands)	https://airbagsound.bandcamp.com/album/airbag-dysphoria-live-in-the-netherlands?from=discover_page	Oslo, Norway	2025-11-21	https://f4.bcbits.com/img/a4294199540_16.jpg	34.99	{Dysphoria,"Tyrants and Kings",Awakening,Erase,"Tear it Down","Machines and Men",Redemption,"Never Coming Home",Homesick}	9	01:34:11	https://airbagsound.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
52	Annahstasia	Tether	https://annahstasia.bandcamp.com/album/tether?from=discover_page	Los Angeles, California	2025-06-13	https://f4.bcbits.com/img/a3914404539_16.jpg	22.95	{"Be Kind",Villian,Unrest,"Take Care of Me","Slow (ft. Obongjayar)",Waiting,Overflow,"All Is. Will Be. As It Was. (ft. aja monet)","Silk And Velvet","Satisfy Me",Believer}	11	00:43:27	https://annahstasia.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
53	Maria BC	Marathon	https://mariabc.bandcamp.com/album/marathon?from=discover_page		2026-02-27	https://f4.bcbits.com/img/a3207365271_16.jpg	21.25	{Marathon,"As the earth turns",Peacemaking,Safety,Rare,"Port authority","The sound",Sabotage,June,"Night & day","May this rain",Channels,Miami}	13	00:37:24	https://mariabc.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
54	Kal-El	Astral Voyager Vol. 2 (North American Version)	https://kal-el.bandcamp.com/album/astral-voyager-vol-2-north-american-version?from=discover_page	Stavanger, Norway	2026-03-20	https://f4.bcbits.com/img/a0857477795_16.jpg	22.09	{Juno,"The Nine","The Prophecy",Asteroid,Juggernaut,Pan}	6	00:42:53	https://kal-el.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
55	Hotline TNT	Raspberry Moon	https://hotlinetnt.bandcamp.com/album/raspberry-moon?from=discover_page	Brooklyn, New York	2025-06-20	https://f4.bcbits.com/img/a1573502729_16.jpg	20.40	{"Was I Wrong?","Transition Lens","The Scene","Julia's War","Letter To Heaven","Break Right","If Time Flies",Candle,"Dance The Night Away",Lawnmower,"Where U Been?"}	11	00:35:26	https://hotlinetnt.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
57	Orcutt Shelley Miller	Orcutt Shelley Miller	https://orcuttshelleymiller.bandcamp.com/album/orcutt-shelley-miller?from=discover_page	San Francisco, California	2025-09-05	https://f4.bcbits.com/img/a1678863700_16.jpg	27.20	{"A Star Is Born","An L.A. Funeral","Unsafe At Any Speed","Four-door Charger","A Long Island Wedding"}	5	00:31:16	https://orcuttshelleymiller.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
58	Natural Magic	II	https://naturalmagic.bandcamp.com/album/ii?from=discover_page	Portland, Oregon	2026-01-30	https://f4.bcbits.com/img/a2997656000_16.jpg	25.00	{"Galaxy Builder","Don't Look Back","Distant Bells","Skyward Eye","Get It Right",Ride,"Chugsby's Theme"}	8	00:45:06	https://naturalmagic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
59	Cindy Lee	What''s Tonight To Eternity	https://cindylee.bandcamp.com/album/whats-tonight-to-eternity?from=discover_page	Toronto, Ontario	2020-02-14	https://f4.bcbits.com/img/a3690679937_16.jpg	17.00	{"Plastic Raincoat","I Want You To Suffer","The Limit","What's Tonight To Eternity","One Second To Toe The Line","Lucifer Stand","Speaking From Above","Just For Loving You I Pay The Price","Heavy Metal"}	9	00:42:08	https://cindylee.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
60	Daniel Land	Pearl Daddy	https://danielland.bandcamp.com/album/pearl-daddy?from=discover_page	London, UK	2026-04-10	https://f4.bcbits.com/img/a1534137914_16.jpg	14.04	{"Pearl Daddy",Bilal}	2	00:08:53	https://danielland.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
61	Sergeant Thunderhoof	A Momentary Lapse of Badon	https://sergeantthunderhoof.bandcamp.com/album/a-momentary-lapse-of-badon?from=discover_page	Bath, UK	2024-12-25	https://f4.bcbits.com/img/a2493269943_16.jpg	29.25	{"Badon (Josh Gallop Remix)","Blood Moon (Josh Gallop Remix)","The Orb of Octavia (Josh Gallop Remix)","Salvation for the Soul (Josh Gallop Remix)","Sentinel (Josh Gallop Remix)","Beyond the Hill (Josh Gallop Remix)"}	6	00:39:50	https://sergeantthunderhoof.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
62	Uni Boys	Uni Boys	https://uniboys.bandcamp.com/album/uni-boys?from=discover_page	Los Angeles, California	2026-03-27	https://f4.bcbits.com/img/a3571339829_16.jpg	21.25	{"Victim Of Myself","I Don't Wanna Dream Anymore","You'll Curse His Name Again",Abra,"Maybe I'm Wrong","Want You Back","You're So (Phisticated)","Look On The Brightside",Genevieve,"Sin Your Life Away","No Need To Serve A Purpose","Without A Broken Heart"}	14	00:42:34	https://uniboys.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
63	SUNN O)))	Metta, Benevolence BBC 6Music : Live on the Invitation of Mary Anne Hobbs	https://sunn.bandcamp.com/album/metta-benevolence-bbc-6music-live-on-the-invitation-of-mary-anne-hobbs?from=discover_page	Seattle, Washington	2022-01-22	https://f4.bcbits.com/img/a3821764350_16.jpg	17.00	{"Pyroclasts F","Pyroclasts C#","Troubled Air"}	3	01:01:10	https://sunn.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
64	Big Thief	Double Infinity	https://bigthief.bandcamp.com/album/double-infinity?from=discover_page	Brooklyn, New York	2025-09-05	https://f4.bcbits.com/img/a0135149855_16.jpg	20.21	{Incomprehensible,Words,"Los Angeles","All Night All Day","Double Infinity","No Fear","Big Thief feat. Laraaji - Grandmother","Happy with You","How Could I Have Known"}	9	00:42:53	https://bigthief.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
65	Peppermint Records	The Only Truth	https://peppermintrecords.bandcamp.com/album/the-only-truth?from=discover_page	Youngstown, Ohio	1972-01-01	https://f4.bcbits.com/img/a1539469997_16.jpg	25.50	{"Peace Officer","You Came To Me","Who Can I Say You Are?","I'm Afraid","Our Time","After Me Again","A Feeling For You","The Only Truth"}	8	00:47:41	https://peppermintrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
66	Fontaines D.C.	Romance	https://fontainesdc.bandcamp.com/album/romance?from=discover_page	Dublin, Ireland	2024-08-23	https://f4.bcbits.com/img/a1885243503_16.jpg	23.39	{Romance,Starburster,"Here's The Thing",Desire,"In The Modern World",Bug,"Motorcycle Boy",Sundowner,"Horseness Is The Whatness","Death Kink",Favourite}	11	00:37:00	https://fontainesdc.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
67	Lena Raine	Celeste B-Sides	https://radicaldreamland.bandcamp.com/album/celeste-b-sides?from=discover_page	Vancouver, British Columbia	2018-01-25	https://f4.bcbits.com/img/a0426095820_16.jpg	106.25	{"Maxo - Forsaken City (Sever the Skyline Mix)","Ben Prunty - Old Site (Black Moonrise Mix)","Christa Lee - Celestial Resort (Good Karma Mix)","in love with a ghost - Golden Ridge (Golden Feather Mix)","2 Mello - Mirror Temple (Mirror Magic Mix)","Jukio Kallio - Reflection (Center of the Earth Mix)","kuraine - Summit (No More Running Mix)","Matthewせいじ - The Core (Say Goodbye Mix)","Lena Raine - (Bonus) Area 1 Demo"}	9	00:34:59	https://radicaldreamland.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
68	Prewn	System	https://prewnmusic.bandcamp.com/album/system?from=discover_page	Northampton, Massachusetts	2025-10-03	https://f4.bcbits.com/img/a0598934852_16.jpg	19.55	{Easy,Commotion,System,"It's Only You","My Side",Forgot,"Dirty Dog",Cavity,"Don't Be Scared"}	9	00:31:49	https://prewnmusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
69	Sigur Rós	Takk... (20th Anniversary Remaster)	https://store.sigurros.com/album/takk-20th-anniversary-remaster?from=discover_page	Reykjavík, Iceland	2025-09-12	https://f4.bcbits.com/img/a0054358329_16.jpg	117.00	{"Takk... (2025 Remaster)","Glósóli (2025 Remaster)","Hoppípolla (2025 Remaster)","Með blóðnasir (2025 Remaster)","Sé lest (2025 Remaster)","Sæglópur (2025 Remaster)","Mílanó (2025 Remaster)","Gong (2025 Remaster)","Andvari (2025 Remaster)","Svo hljótt (2025 Remaster)","Heysátan (2025 Remaster)",Melrakki,"Refur (2025 Remaster)","Ó Friður (2025 Remaster)","Kafari (2025 Remaster)",Elfur}	16	01:25:19	https://store.sigurros.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
70	Gogol Bordello	We Mean It, Man!	https://gogolbordello.bandcamp.com/album/we-mean-it-man?from=discover_page	New York, New York	2026-02-13	https://f4.bcbits.com/img/a2841942266_16.jpg	25.50	{"We Mean It, Man!","Life Is Possible Again","No Time For Idiots","Hater Liquidator","Boiling Point",Ignition,"From Boyarka to Boyaca",Mystics,"We Did Good With The Good We Did",Crayons,"State of Shock","Solidarity (Nick Launay Mix)"}	12	00:48:26	https://gogolbordello.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
71	Supreme Echo	The Glass Cage	https://supremeecho.bandcamp.com/album/the-glass-cage?from=discover_page	Victoria, British Columbia	2026-02-24	https://f4.bcbits.com/img/a0734084664_16.jpg	35.00	{"I Think I Love You","All Alone","Think It Over","When I See Her","Where Did The Sunshine Go?","Outside Woman Blues",Outro}	7	00:22:32	https://supremeecho.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
72	Big Thief	Dragon New Warm Mountain I Believe In You	https://bigthief.bandcamp.com/album/dragon-new-warm-mountain-i-believe-in-you?from=discover_page	Brooklyn, New York	2022-02-11	https://f4.bcbits.com/img/a0882840373_16.jpg	23.83	{Change,"Time Escaping","Spud Infinity",Certainty,"Dragon New Warm Mountain I Believe in You",Sparrow,"Little Things","Heavy Bend","Flower of Blood","Blurred View","Red Moon","Dried Roses","No Reason","Wake Me up to Drive","Promise Is a Pendulum","12,000 Lines","Simulation Swarm","Love Love Love","The Only Place","Blue Lightning"}	20	01:20:25	https://bigthief.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
73	SPILLINGS	SPILLINGS	https://spillings.bandcamp.com/album/spillings?from=discover_page	Montreal, Québec	2026-01-01	https://f4.bcbits.com/img/a2153796166_16.jpg	21.25	{"CASTED CRIME",PRECAUTION,"40 GRIT","VIOLENT CARRIER",SKINNED,"UNDER THE VEIL","STRIKING THE MATCH","TERMINAL AGITATION","SEED FOR SOWING"}	9	00:35:46	https://spillings.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
74	Glass Harp	Live! At Carnegie Hall	https://glassharp.bandcamp.com/album/live-at-carnegie-hall?from=discover_page	Nashville, Tennessee	2022-04-01	https://f4.bcbits.com/img/a1271650025_16.jpg	25.50	{"Look In The Sky","Do Lord",Changes,"Never Is A Long Time","Can You See Me"}	5	00:53:31	https://glassharp.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
75	Blood Cultures	LUNO	https://bloodcultures.bandcamp.com/album/luno?from=discover_page	Brooklyn, New York	2021-05-28	https://f4.bcbits.com/img/a2795779621_16.jpg	25.50	{"Keeps Bringing Me Back","Deep Sea Diver","Set it on Fire","Graveyard Vibes",Andromeda,"When the Night Calls...","Cabin Fever Freestyle","Beneath the Moon & Me"}	8	00:31:52	https://bloodcultures.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
76	The Protomen	Present: A Night of Queen	https://theprotomen.bandcamp.com/album/present-a-night-of-queen?from=discover_page	Nashville, Tennessee	2018-05-21	https://f4.bcbits.com/img/a2407129928_16.jpg	23.79	{Intro,Flash,"Battle Theme","Don't Stop Me Now","Killer Queen","Hammer to Fall","One Vision","Somebody to Love","Princes of the Universe","Death on Two Legs","I Want to Break Free",Scandal,"I Want it All","The Show Must Go On","Under Pressure","Bohemian Rhapsody","Due Vendetta",Outro}	18	01:13:12	https://theprotomen.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
77	MASTER BOOT RECORD	INTERRUPT REQUEST	https://masterbootrecord.bandcamp.com/album/interrupt-request?from=discover_page	Rome, Italy	2017-09-20	https://f4.bcbits.com/img/a4244005369_16.jpg	32.00	{"IRQ 0 SYSTEM CLOCK","IRQ 1 KEYBOARD","IRQ 2 CASCADE","IRQ 3 MODEM","IRQ 4 MOUSE","IRQ 5 SOUND BLASTER","IRQ 6 FLOPPY DISK DRIVE","IRQ 7 PRINTER","IRQ 8 CMOS","IRQ 9 NETWORK","IRQ 10 3DFX","IRQ 11 SCSI","IRQ 12 VGA","IRQ 13 COPROCESSOR","IRQ 14 PRIMARY IDE","IRQ 15 SECONDARY IDE"}	16	01:13:41	https://masterbootrecord.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
78	Capacopter	Capacopter	https://capacopter.bandcamp.com/album/capacopter?from=discover_page	Mannheim, Germany	2026-01-09	https://f4.bcbits.com/img/a2257521419_16.jpg	21.00	{"600 Years","Borderline Steal Circus",Caravan,"Kings and Crowds","Half'N Inch","JP's Horse","Temple Son","Wandering Stones"}	8	00:40:36	https://capacopter.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
79	Stereolab	Instant Holograms On Metal Film	https://stereolab.bandcamp.com/album/instant-holograms-on-metal-film?from=discover_page	London, UK	2025-05-23	https://f4.bcbits.com/img/a0337059608_16.jpg	33.93	{"Mystical Plosives","Aerial Troubles","Melodie Is A Wound","Immortal Hands","Vermona F Transistor","Le Coeur Et La Force","Electrified Teenybop!","Transmuted Matter","Esemplastic Creeping Eruption","If You Remember I Forgot How To Dream Pt.1","Flashes From Everywhere","Colour Television","If You Remember I Forgot How To Dream Pt.2"}	13	00:59:40	https://stereolab.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
80	MASTER BOOT RECORD	HARDWAREZ	https://masterbootrecord.bandcamp.com/album/hardwarez?from=discover_page	Rome, Italy	2024-10-11	https://f4.bcbits.com/img/a3638647289_16.jpg	22.95	{BIOS,MOBO,CPU,GPU,RAM,FDD,HDD,PSU,CASE}	9	00:41:19	https://masterbootrecord.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
81	The Dandy Warhols	Pin Ups	https://music.dandywarhols.com/album/pin-ups?from=discover_page	Portland, Oregon	2026-03-20	https://f4.bcbits.com/img/a1312882671_16.jpg	34.00	{"Cherry Bomb","What We All Want",Primary,"Kiss Off","Goo Goo Muck",Rain,"Straight To Hell","Sister Golden Hair","Lay Lady Lay",Ripple,"You Ain't Goin' Nowhere",Blackbird,"The Beautiful People","Love Song",Jetboy,"She Sells Sanctuary","Inside The Outside"}	17	01:03:32	https://music.dandywarhols.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
82	TFS	Braindrops	https://tropicalfstorm.bandcamp.com/album/braindrops?from=discover_page	Melbourne, Australia	2019-08-23	https://f4.bcbits.com/img/a2512211965_16.jpg	19.55	{Paradise,"The Planet Of Straw Men","Who’s My Eugene?","The Happiest Guy Around","Maria 62",Braindrops,Aspirin,"Desert Sands Of Venus","Maria 63"}	9	00:48:14	https://tropicalfstorm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
83	Lala Lala	Heaven 2	https://lalabandlala.bandcamp.com/album/heaven-2?from=discover_page	Los Angeles, California	2026-02-27	https://f4.bcbits.com/img/a3128630362_16.jpg	19.55	{"Car Anymore","Even Mountains Erode",Arrow,Tricks,Scammer,Heaven2,Anywave,"Does This Go Faster?","This City","Wyoming Dirt"}	10	00:33:08	https://lalabandlala.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
84	Palm Desert	Rays Of The Gold And Grays	https://palmdesert.bandcamp.com/album/rays-of-the-gold-and-grays?from=discover_page	Poland	2025-12-05	https://f4.bcbits.com/img/a0798861125_16.jpg	20.40	{"In The Breeze","Black Hurricane","Blue Of The Sky",Lightriders,"At The Edge Of Time","Rays Of The Gold And Grays","Son Of A Wind And Dust","In My Eyes"}	8	00:43:27	https://palmdesert.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
85	KAUAN	Wayhome	https://kauan.bandcamp.com/album/wayhome?from=discover_page	Helsinki, Finland	2025-11-07	https://f4.bcbits.com/img/a2955058893_16.jpg	85.00	{"aim / decide","outline / pave","depart / dive","leave / let go","soothe / sear","haste / ascend","embrace / repel","arrive / resolve"}	8	00:49:28	https://kauan.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
174	Picture	Eeeeeeee	https://pppicture.bandcamp.com/album/eeeeeeee?from=discover_page	Aarhus, Denmark	2026-02-09	https://f4.bcbits.com/img/a0420917905_16.jpg	32.76	{Waaaaaaaa,Tyyyyyyyyy,Heeeeeeee,Keeeeeee,Yeeeeeee,Qeeeeeeee}	6	00:38:23	https://pppicture.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
86	Caput Medusae	You Can''t Negotiate With Zombies [Debut Album]	https://caputmedusae.bandcamp.com/album/you-cant-negotiate-with-zombies-debut-album?from=discover_page	Germany	2024-07-05	https://f4.bcbits.com/img/a2275486336_16.jpg	29.00	{Überfan,"On My Trip","Eerie Dance","I Wear Black 'Til I'm Dead","Colder Than Ice","Slave To The System","You Can't Negotiate With Zombies",Endboss}	8	00:31:21	https://caputmedusae.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
87	Lotus	Rise of the Anglerfish	https://lotusvibes.bandcamp.com/album/rise-of-the-anglerfish?from=discover_page	Philadelphia	2026-02-13	https://f4.bcbits.com/img/a1160383676_16.jpg	29.75	{"And I Don't","One Word",Angler,"Oblong Shapes","Wild Card","Coarse Notes","Urbn Xplr","Resonance Experiments",Lure,Remedy,"Sine Bubbles"}	15	01:10:22	https://lotusvibes.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
88	Remember Sports	The Refrigerator	https://remembersports.bandcamp.com/album/the-refrigerator?from=discover_page	Philadelphia, Pennsylvania	2026-02-13	https://f4.bcbits.com/img/a2452418363_16.jpg	20.39	{"Across The Line",Bug,Thumb,Selfish,Ghost,Fridge,Roadkill,"Cut Fruit",Yowie,Zucchini,Soothe/Seethe,Nevermind}	12	00:37:34	https://remembersports.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
89	Unsane	Occupational Hazard (2026 Remaster)	https://unsane.bandcamp.com/album/occupational-hazard-2026-remaster?from=discover_page	New York, New York	2026-02-06	https://f4.bcbits.com/img/a2672869948_16.jpg	19.55	{"Committed (2026 Remaster)","This Plan (2026 Remaster)","Over Me (2026 Remaster)","Take In the Stray (2026 Remaster)","Stop (2026 Remaster)","Wait To Lose (2026 Remaster)","Sick (2026 Remaster)","Hazmat (2026 Remaster)","Smells Like Rain (2026 Remaster)","Lead (2026 Remaster)","Humidifier (2026 Remaster)","Scam (2026 Remaster)","Understand (2026 Remaster)","No Soul (2026 Remaster)","Committed (AmRep Session Demos)","Over Me (AmRep Session Demos)","Sick (AmRep Session Demos)","Smells Like Rain (AmRep Session Demos)","Lead (AmRep Session Demos)","Understand (AmRep Session Demos)"}	20	01:00:04	https://unsane.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
90	MASTER BOOT RECORD	PERSONAL COMPUTER	https://masterbootrecord.bandcamp.com/album/personal-computer?from=discover_page	Rome, Italy	2022-05-13	https://f4.bcbits.com/img/a2560598250_16.jpg	29.75	{8086,80186,80286,80386,80386SX,80486,80486DX,80486SX,80586,80686}	10	01:04:21	https://masterbootrecord.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
91	MASTER BOOT RECORD	FLOPPY DISK OVERDRIVE	https://masterbootrecord.bandcamp.com/album/floppy-disk-overdrive?from=discover_page	Rome, Italy	2020-03-20	https://f4.bcbits.com/img/a1120298037_16.jpg	28.00	{ANSI.SYS,EDIT.COM,FDISK.EXE,DISPLAY.SYS,CHKDSK.EXE,DEFRAG.EXE,RAMDRIVE.SYS,DBLSPACE.EXE,SMARTDRV.EXE,DISKCOPY.COM,EMM386.EXE,HIMEM.SYS}	12	01:08:29	https://masterbootrecord.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
92	Los Deltonos	El Futuro (2025)	https://losdeltonos.com/album/el-futuro-2025?from=discover_page	Camargo, Spain	2025-12-12	https://f4.bcbits.com/img/a3258909169_16.jpg	20.00	{"El Futuro","Andrés Muñiz","Al Revés","El Día Aquel","Había Una Vez","La Fuerza","El Mal Menor",Indecisión,"El Color De Los Tiempos","La Campana",Meteorito,Naufragio}	14	00:50:14	https://losdeltonos.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
93	liar, flower	ornamental gardens	https://liarflower.bandcamp.com/album/ornamental-gardens?from=discover_page	London, UK	2025-12-07	https://f4.bcbits.com/img/a4206068196_16.jpg	91.26	{"ornamental gardens side a","ornamental gardens side b","ornamental gardens side c","ornamental gardens side d",before,"ornamental gardens","bolt of cloth","monolithic ego",after,raven,stowaway,tapestries,"sewing machine (tongue for a dress)","dark blue bike","liar, flower - transference","i am stars","orcas my orchid"}	17	02:21:54	https://liarflower.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
94	YĪN YĪN	Yatta!	https://yinyin.bandcamp.com/album/yatta?from=discover_page	Maastricht, Netherlands	2026-01-23	https://f4.bcbits.com/img/a2700145357_16.jpg	27.00	{"In Search of Yang","Spirit Adapter","Lecker Song","Yata Yata","Night in Taipei","Golden Lion",Elma,"Kasumi's Quest","Slow Burner","Pattaya Wrangler","Mooncake Melody"}	11	00:40:59	https://yinyin.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
95	Madis	Reflecte	https://madis.bandcamp.com/album/reflecte?from=discover_page	Kraków, Poland	2025-12-05	https://f4.bcbits.com/img/a4154853384_16.jpg	119.00	{"Silent Echoes","Whispers From Behind","Mentes Determinadas (with Kebu)","Burning Sands",Arcadia,"Distante (with Justyna Bujak & Jacek Królik)","Moments Eternal"}	7	00:43:20	https://madis.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
96	Bristol Archive Records	Freedom City	https://bristolarchiverecords.bandcamp.com/album/freedom-city?from=discover_page	UK	2026-03-27	https://f4.bcbits.com/img/a0114849305_16.jpg	21.05	{"Freedom City","Babylon Fire / Babylon Dub","Twelve Tribes / Twelve Tribes Dub","To See You Smile"}	4	00:17:42	https://bristolarchiverecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
97	DAZE	Holder	https://dazestyle.bandcamp.com/album/holder?from=discover_page	Connecticut	2025-11-07	https://f4.bcbits.com/img/a2592733936_16.jpg	20.40	{"First Cut Is The Deepest (One Way Dance)","A Thread/Anthems",Discolored,"Passing By, Waiting To Observe",Five}	5	00:11:34	https://dazestyle.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
98	Sonic Youth	Daydream Nation	https://sonicyouth.bandcamp.com/album/daydream-nation?from=discover_page	New York, New York	1988-10-18	https://f4.bcbits.com/img/a0462860911_16.jpg	24.65	{"Teen Age Riot","Silver Rocket","The Sprawl","'Cross The Breeze","Eric's Trip","Total Trash","Hey Joni",Providence,Candle,"Rain King",Kissability,"The Wonder",Hyperstation,"Eliminator Jr."}	14	01:10:52	https://sonicyouth.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
99	Solstice	Clann:The Stables Gathering	https://solstice3.bandcamp.com/album/clann-the-stables-gathering?from=discover_page	UK	2026-02-18	https://f4.bcbits.com/img/a1983728842_16.jpg	40.95	{"Twin Peaks - Shout",Life,Earthsong,Firefly,Plunk,"Wongle No9","Mount Ephraim",Cheyenne,"A New Day","Sacred Run"}	10	01:30:05	https://solstice3.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
100	Kal-El	Astral Voyager Vol. 2 (Scandinavian/European Version)	https://kal-el.bandcamp.com/album/astral-voyager-vol-2-scandinavian-european-version?from=discover_page	Stavanger, Norway	2026-03-20	https://f4.bcbits.com/img/a3454536192_16.jpg	270.00	{Juno,"The Nine","The Prophecy",Juggernaut,Pan,Asteroid}	6	00:42:53	https://kal-el.bandcamp.com?from=discover_page	2026-02-23 13:22:19.538136	2026-02-23 13:22:19.538136
101	Militarie Gun	God Save The Gun	https://militariegun.bandcamp.com/album/god-save-the-gun?from=discover_page	Los Angeles, California	2025-10-17	https://f4.bcbits.com/img/a3723738113_16.jpg	22.10	{"Pt. II","B A D I D E A","Fill Me With Paint","Throw Me Away","God Owes Me Money",Daydream,"Maybe I’ll Burn My Life Down",Kick,"Laugh At Me","Wake Up and Smile","I Won’t Murder Your Friend","Isaac’s Song","Thought You Were Waving","God Save The Gun"}	14	00:37:41	https://militariegun.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
102	SORCERER RECORDS	Paddock Of Love	https://sorcererrecords.bandcamp.com/album/paddock-of-love?from=discover_page	Melbourne, Australia	2026-01-30	https://f4.bcbits.com/img/a3395077768_16.jpg	44.00	{"In The Raw","Funeral On A Spit","All Too Sane",Bullock,"Broken Glass",Gargoyles,"On The Gear","Elsewhere Else","He Moves In Mysterious Ways","Promised Land","Cannibal's Lament","The Spectator"}	12	00:47:35	https://sorcererrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
103	Caput Medusae	SCHWARZSCHILD [Album]	https://caputmedusae.bandcamp.com/album/schwarzschild-album?from=discover_page	Germany	2026-02-19	https://f4.bcbits.com/img/a3972460044_16.jpg	29.99	{"The Creation Prelude",Schwarzschild,LONE,"Never Have I Ever","The Sounds Of Space","Sonatina In A Minor"}	2	00:06:49	https://caputmedusae.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
104	Floral	Floral EP	https://floral1.bandcamp.com/album/floral-ep?from=discover_page	California	2014-09-13	https://f4.bcbits.com/img/a2722985231_16.jpg	22.44	{"Aquarius Theater","Balancing Act",Cars,"Climbing a Wall","Picture of Flower",Temple}	6	00:16:36	https://floral1.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
105	Nusantara Beat	Nusantara Beat	https://nusantarabeat.bandcamp.com/album/nusantara-beat?from=discover_page	Amsterdam, Netherlands	2025-11-14	https://f4.bcbits.com/img/a3284679635_16.jpg	23.00	{"Ke Masa Lalu",Kalangkang,"Di Pantai","Bunga Mekar","Ular Ular","Kupu Kupu",Gapura,"Hilang Kendali",Tamat,Bakar,"Cinta Itu Menyakitkan"}	11	00:40:59	https://nusantarabeat.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
106	Кино	Последний герой	https://kinogroup.bandcamp.com/album/--10?from=discover_page	Saint Petersburg, Russia	2023-01-16	https://f4.bcbits.com/img/a3472710160_16.jpg	55.00	{"Мы Ждём Перемен",Электричка,Война,Троллейбус,Печаль,"Последний Герой","Группа Крови","Мама, Мы Все Тяжело Больны","В Наших Глазах","Спокойная Ночь"}	10	00:48:30	https://kinogroup.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
107	Magic Fig	Valerian Tea	https://magicfig.bandcamp.com/album/valerian-tea?from=discover_page	San Francisco, California	2025-11-21	https://f4.bcbits.com/img/a4201101091_16.jpg	19.55	{Flammarion,"Walking Shoes","At The Garden's Gate",Percolations,"Valerian Tea","Riders At Dawn","Sensation Seeker",Splinter,Goblin,"Sleep Of Reason"}	10	00:38:50	https://magicfig.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
108	The Beths	Future Me Hates Me	https://thebethsnz.bandcamp.com/album/future-me-hates-me?from=discover_page	Auckland, New Zealand	2018-08-10	https://f4.bcbits.com/img/a1225303261_16.jpg	22.94	{"Great No One","Future Me Hates Me","Uptown Girl","You Wouldn't Like Me","Not Running","Little Death","Happy Unhappy","River Run: Lvl 1",Whatever,"Less Than Thou"}	10	00:38:36	https://thebethsnz.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
109	Caput Medusae	Deus Ex Machina	https://caputmedusae.bandcamp.com/album/deus-ex-machina?from=discover_page	Germany	2021-11-12	https://f4.bcbits.com/img/a2624517526_16.jpg	30.00	{"Deus Ex Machina",Screamdance}	2	00:09:01	https://caputmedusae.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
110	Heavy Medication Records	After The Dolls e.p.	https://heavymedicationrecords.bandcamp.com/album/after-the-dolls-e-p?from=discover_page	Warsaw, Poland	2026-01-09	https://f4.bcbits.com/img/a4038943714_16.jpg	17.00	{"Dead or Alive","Disappointed in You","Short Lives","Wreckless Crazy",Melody,"The Rope"}	6	00:18:24	https://heavymedicationrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
111	deathcrash	Return	https://deathcrash.bandcamp.com/album/return?from=discover_page	London, UK	2022-01-28	https://f4.bcbits.com/img/a2081013528_16.jpg	24.37	{Sundown,Unwind,Horses,"American Metal","Matt's Song","Wrestle With Jimmy","Metro 1",Slowday,"Was Living","What To Do",Doomcrash,"The Low Anthem"}	12	01:05:57	https://deathcrash.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
112	Annahstasia	Surface Tension	https://annahstasia.bandcamp.com/album/surface-tension?from=discover_page	Los Angeles, California	2024-11-01	https://f4.bcbits.com/img/a1694636894_16.jpg	9.35	{Saturday,Sunday,"Stress Test"}	3	00:12:09	https://annahstasia.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
113	Peter Gabriel	i/o	https://petergabriel.bandcamp.com/album/i-o?from=discover_page	England, UK	2023-12-01	https://f4.bcbits.com/img/a4251126870_16.jpg	38.61	{"Panopticom (Bright-Side Mix)","The Court (Bright-Side Mix)","Playing for Time (Bright-Side Mix)","i/o (Bright-Side Mix)","Four Kinds of Horses (Bright-Side Mix)","Road to Joy (Bright-Side Mix)","So Much (Bright-Side Mix)","Olive Tree (Bright-Side Mix)","Love Can Heal (Bright-Side Mix)","This Is Home (Bright-Side Mix)","And Still (Bright-Side Mix)","Live and Let Live (Bright-Side Mix)","Panopticom (Dark-Side Mix)","The Court (Dark-Side Mix)","Playing for Time (Dark-Side Mix)","i/o (Dark-Side Mix)","Four Kinds of Horses (Dark-Side Mix)","Road to Joy (Dark-Side Mix)","So Much (Dark-Side Mix)","Olive Tree (Dark-Side Mix)","Love Can Heal (Dark-Side Mix)","This Is Home (Dark-Side Mix)","And Still (Dark-Side Mix)","Live and Let Live (Dark-Side Mix)"}	24	02:17:33	https://petergabriel.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
114	Melody''s Echo Chamber	Unclouded	https://melodysechochamber.bandcamp.com/album/unclouded?from=discover_page	Paris, France	2025-12-05	https://f4.bcbits.com/img/a1258398488_16.jpg	30.99	{"The House That Doesn’t Exist","In The Stars","Flowers Turn Into Gold","Eyes Closed","Childhood Dream","Memory’s Underground","Broken Roses","Burning Man","Into Shadows","How to Leave Misery Behind",Unclouded,"Daisy (feat. El Michels Affair)"}	12	00:30:05	https://melodysechochamber.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
115	Hotline TNT	Cartwheel	https://hotlinetnt.bandcamp.com/album/cartwheel?from=discover_page	Brooklyn, New York	2023-11-03	https://f4.bcbits.com/img/a0861744003_16.jpg	19.55	{Protocol,"I Thought You'd Change","Beauty Filter","History Channel","I Know You","Son In Law","Out of Town",Maxine,"That Was My Life","Spot Me 100",BMX,Stump}	12	00:33:06	https://hotlinetnt.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
116	All Them Witches	Dying Surfer Meets His Maker	https://allthemwitches.bandcamp.com/album/dying-surfer-meets-his-maker?from=discover_page	Nashville, Tennessee	2015-10-30	https://f4.bcbits.com/img/a0088904721_16.jpg	23.80	{"Call Me Star","El Centro","Dirt Preachers","This Is Where It Falls Apart",Mellowing,"Open Passageways","Instrumental 2 (Welcome To The Caveman Future)",Talisman,"Blood And Sand / Milk And Endless Waters"}	9	00:45:31	https://allthemwitches.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
117	Guerilla Toss	You''re Weird Now	https://guerillatoss.bandcamp.com/album/youre-weird-now?from=discover_page	New York, New York	2025-09-12	https://f4.bcbits.com/img/a3944046041_16.jpg	19.55	{"Krystal Ball","Psychosis Is Just a Number","CEO of Personal & Pleasure","Life’s a Zoo","Red Flag to Angry Bull","Panglossian Mannequin","Deep Sight","When Dogs Bark","Crocodile Cloud","Favorite Sun"}	10	00:37:23	https://guerillatoss.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
118	Caput Medusae	Never Have I Ever	https://caputmedusae.bandcamp.com/album/never-have-i-ever?from=discover_page	Germany	2025-09-26	https://f4.bcbits.com/img/a1943271173_16.jpg	29.99	{"Never Have I Ever","Never Have I Ever [Preview]"}	2	00:04:28	https://caputmedusae.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
119	MASTER BOOT RECORD	C:\\>DEFRAG	https://masterbootrecord.bandcamp.com/album/c-defrag?from=discover_page	Rome, Italy	2020-10-26	https://f4.bcbits.com/img/a0141175852_16.jpg	17.00	{"CLUSTER 777","CLUSTER 1337"}	2	00:37:02	https://masterbootrecord.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
120	Big Big Train	Woodcut (24-bit HD audio)	https://bigbigtrain.bandcamp.com/album/woodcut-24-bit-hd-audio?from=discover_page	UK	2026-02-06	https://f4.bcbits.com/img/a3291431999_16.jpg	40.99	{"Inkwell Black","The Artist","The Lie of the Land","The Sharpest Blade","Albion Press",Arcadia,"Second Press","Warp and Weft",Chimaera,"Dead Point","Light Without Heat","Dreams in Black and White","Cut and Run","Hawthorn White","Counting Stars","Last Stand"}	16	01:05:47	https://bigbigtrain.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
121	Kikagaku Moyo/幾何学模様	House in the Tall Grass	https://kikagakumoyoggb.bandcamp.com/album/house-in-the-tall-grass?from=discover_page	Tokyo, Japan	2016-05-13	https://f4.bcbits.com/img/a2646235549_16.jpg	27.00	{"Green Sugar",Kogarashi,"Old Snow, White Sun","Melted Crystal",Dune,"Silver Owl","Fata Morgana",Trad,"Cardigan Song"}	9	00:48:31	https://kikagakumoyoggb.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
122	Кино	Звезда По Имени Солнце	https://kinogroup.bandcamp.com/album/--3?from=discover_page	Saint Petersburg, Russia	2020-03-11	https://f4.bcbits.com/img/a3538772258_16.jpg	38.00	{"Песня без слов","Звезда по имени Солнце","Невесёлая песня",Сказка,"Место для шага вперёд","Пачка сигарет",Стук,Печаль,Апрель}	9	00:41:56	https://kinogroup.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
123	Caput Medusae	I Wear Black ''Til I''m Dead	https://caputmedusae.bandcamp.com/album/i-wear-black-til-im-dead?from=discover_page	Germany	2024-01-30	https://f4.bcbits.com/img/a0270721607_16.jpg	39.00	{"I Wear Black 'Til I'm Dead","Romantic Nightmare"}	2	00:08:23	https://caputmedusae.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
124	Colin Edwin	The Baldock Transmission	https://music.colinedwin.co.uk/album/the-baldock-transmission?from=discover_page	London	2025-11-07	https://f4.bcbits.com/img/a3739700527_16.jpg	29.25	{"Transmission Resumed","Journey To Rebhu","Stationary Orbit","Mechanical Tears","Lower Constrictor","Solar Season Signal"}	6	01:00:43	https://music.colinedwin.co.uk?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
125	MASTER BOOT RECORD	C:\\>COPY *.* A: /V	https://masterbootrecord.bandcamp.com/album/c-copy-a-v?from=discover_page	Rome, Italy	2017-03-07	https://f4.bcbits.com/img/a2157244285_16.jpg	17.00	{RZR.NFO,FLT.NFO,DEV.NFO,MYTH.NFO,CLS.NFO,TRSI.NFO,PDX.NFO,README.NFO,FILE_ID.DIZ}	9	00:42:15	https://masterbootrecord.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
126	SWANS	Soundtracks For The Blind	https://swans.bandcamp.com/album/soundtracks-for-the-blind-2?from=discover_page	New York, New York	2014-07-25	https://f4.bcbits.com/img/a2652002832_16.jpg	46.75	{"Red Velvet Corridor","I Was A Prisoner In Your Skull","Helpless Child","Live Through Me","Yum-Yab Killers","The Beautiful Days",Volcano,Mellothumb,"All Lined Up","Surrogate 2","How They Suffer",Animus,"Red Velvet Wound","The Sound","Her Mouth Is Filled With Honey","Blood Section",Hypogirl,"Minus Something",Empathy,"I Love You This Much",YRP,"Fan's Lament","Secret Friends","The Final Sacrifice","YRP 2","Surrogate Drone"}	26	02:21:49	https://swans.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
127	La Luz	News of the Universe	https://laluz.bandcamp.com/album/news-of-the-universe-2?from=discover_page	California	2024-05-24	https://f4.bcbits.com/img/a1424656649_16.jpg	19.55	{"Reaching Up to the Sun","Strange World",Dandelions,Poppies,"Good Luck With Your Secret","Always in Love","Close Your Eyes","I'll Go With You","Blue Moth Cloud Shadow","News of the Universe","Moon in Reverse","Blue Jay"}	12	00:35:11	https://laluz.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
128	SWANS	Great Annihilator / Drainland (Remastered 2017)	https://swans.bandcamp.com/album/great-annihilator-drainland-remastered-2017?from=discover_page	New York, New York	2017-05-05	https://f4.bcbits.com/img/a3551379830_16.jpg	28.05	{In,"I Am The Sun","She Lives","Celebrity Lifestyle",Mother_Father,"Blood Promise",Mind/Body/Light/Sound,"My Buried Child",Warm,"Alcohol The Seed","Killing For Company","Mother's Milk","Where Does A Body End",Telepathy,"The Great Annihilator",Out,"I Am The Sun (Live At The Flesh Club)","You See Through Me","Where Does Your Body Begin","I See Them All Lined Up",Unreal,"Fan Letter","Your Naked Body","Low Life Form","If You…","Why I Ate My Wife",Blind}	27	02:00:22	https://swans.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
129	The Altered Hours	The Altered Hours	https://thealteredhours.bandcamp.com/album/the-altered-hours?from=discover_page	Ireland	2025-11-07	https://f4.bcbits.com/img/a2475009143_16.jpg	25.00	{"Turn Away","Such a Steal","Lay There With You","Paper Roses","Too Much Too Late","Heavy Red Blossom",TNT,"Cash For A Cab","Special Things","We're The Same"}	10	00:40:55	https://thealteredhours.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
130	Elder	Elder (REMASTERED) + demos	https://beholdtheelder.bandcamp.com/album/elder-remastered-demos?from=discover_page	Berlin, Germany	2008-01-01	https://f4.bcbits.com/img/a1264457954_16.jpg	25.49	{"White Walls",Hexe,"Riddle of Steel pt 1","Ghost Head","Riddle of Steel pt 2","1162 [Demo]","Red Sunrise [Demo]","Black Midnight [Demo]","Soul Incarnate [Demo]"}	9	01:13:28	https://beholdtheelder.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
131	Cindy Lee	Cat O'' Nine Tails	https://cindylee.bandcamp.com/album/cat-o-nine-tails?from=discover_page	Toronto, Ontario	2020-04-14	https://f4.bcbits.com/img/a0011577251_16.jpg	17.00	{"Our Lady Of Sorrows","Cat O' Nine Tails","Faith Restored","Love Remains","Cat O' Nine Tails II","As I'm Stepping Through The Gates","Cat O' Nine Tails III","I Don't Want To Fall In Love Again","Bondage Of The Mind"}	9	00:24:28	https://cindylee.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
132	Charly Records	Recorded Live at the Craw-Daddy Club, Richmond (London)	https://charlyrecords.bandcamp.com/album/recorded-live-at-the-craw-daddy-club-richmond-london?from=discover_page	London, UK	2026-01-16	https://f4.bcbits.com/img/a3954804303_16.jpg	28.08	{"Bye, Bye Bird","Misterdown Child","23 Hours Too Long","Out of the Water Coast","Baby Don't Worry","Pontiac Blues","Take It Easy Baby","I Don't Care No More","Do The Weston"}	9	00:35:54	https://charlyrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
133	JeGong	Gomi Kuzu Can	https://jegong.bandcamp.com/album/gomi-kuzu-can?from=discover_page	Bern, Switzerland	2026-02-27	https://f4.bcbits.com/img/a0631751368_16.jpg	23.00	{"Golden Hairs Goes Back To Japan","Outright Wolf Medicines",Contortion,Downed,Chalk,"What Ever Happened To Gene",Sister,"Parallel Tracks",Patterns,"Müll Schrott Dose","Obaachan Bingo"}	11	00:46:48	https://jegong.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
134	SOM	Let The Light In	https://somtheband.bandcamp.com/album/let-the-light-in?from=discover_page		2025-03-14	https://f4.bcbits.com/img/a0355420696_16.jpg	24.00	{"Don't Look Back","Let The Light In",Chemicals,"The Place That I Belong","Give Blood",Nightmares,"Under Streetlights","The Light"}	8	00:37:44	https://somtheband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
135	Mod Lang	TV Star	https://modlangdetroit.bandcamp.com/album/tv-star?from=discover_page	Detroit, Michigan	2025-12-08	https://f4.bcbits.com/img/a0397792012_16.jpg	10.20	{"TV Star","3 + 1"}	2	00:06:41	https://modlangdetroit.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
136	Rickshaw Billie''s Burger Patrol	DOOM-WOP	https://rickshawbilliesburgerpatrol.bandcamp.com/album/doom-wop?from=discover_page	Austin, Texas	2022-09-22	https://f4.bcbits.com/img/a2918031916_16.jpg	21.25	{Heel,Chew,"Doom Wop","I’m the Fucking Man","Fly Super Glide","The Bog",Shoo-in,"The Room","Jesus Was an Alien"}	9	00:24:38	https://rickshawbilliesburgerpatrol.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
137	Mike Patton	AVTT/PTTN	https://mikepatton.bandcamp.com/album/avtt-pttn?from=discover_page		2025-11-14	https://f4.bcbits.com/img/a0983181568_16.jpg	21.25	{"Dark Night of My Soul","To Be Known","Heaven’s Breath","Too Awesome",Disappearing,"Eternal Love","The Ox Driver's Song","The Things I Do",Received}	9	00:34:34	https://mikepatton.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
138	Jack Harlon &The Dead Crows	Inexorable Opposites	https://jackharlon-dawsonthedeadcrows.bandcamp.com/album/inexorable-opposites?from=discover_page	Melbourne, Australia	2026-02-06	https://f4.bcbits.com/img/a0029795986_16.jpg	22.94	{Moss,Venomous,"Mt. Macedon","Dave Is Done","Junior Fiction",Seer,"On The Overwhelm","To Die"}	8	00:43:30	https://jackharlon-dawsonthedeadcrows.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
139	Lyres	On Fyre at the Rusty Nail 1985	https://lyres.bandcamp.com/album/on-fyre-at-the-rusty-nail-1985?from=discover_page	Boston, Massachusetts	2025-11-13	https://f4.bcbits.com/img/a4103358644_16.jpg	25.50	{"Someone Who'll Treat You Right Now","Gettin' Plenty Lovin'","I Can Tell","What a Girl Can't Do","Help You Ann","Love Me Till the Sun Shines","Take a Look at Me","Hi-Heel Sneakers","Don't Give It Up Now","Diddy Wah Diddy","I Really Want You Right Now","I'm Tellin' You Girl","How Can I Make Her Mine-Money-Nobody But Me MEDLEY","How Do You Know",Soapy,"Swing Shift","Since You've Been Gone","Busy Body"}	18	01:02:55	https://lyres.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
140	Being Dead	EELS	https://beingdead.bandcamp.com/album/eels?from=discover_page	Austin, Texas	2024-09-27	https://f4.bcbits.com/img/a1724806854_16.jpg	21.25	{"Godzilla Rises","Van Goes","Blanket of my Bone",Problems,Firefighters,"Dragons II",Nightvision,"Gazing at Footwear","Big Bovine","Storybook Bay",Ballerina,"Rock n' Roll Hurts","Love Machine","I Was a Tunnel",Goodnight,"Lilypad Lane"}	16	00:39:50	https://beingdead.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
141	Dry Cleaning	Boundary Road Snacks and Drinks EP	https://drycleaning.bandcamp.com/album/boundary-road-snacks-and-drinks-ep?from=discover_page	London, UK	2019-10-25	https://f4.bcbits.com/img/a4261641880_16.jpg	22.42	{"Dog Proposal","Viking Hair",Spoils,"Jam After School","Sombre One","Sit Down Meal"}	6	00:21:04	https://drycleaning.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
142	IDLES	Joy as an Act of Resistance.	https://idlesband.bandcamp.com/album/joy-as-an-act-of-resistance?from=discover_page	Bristol, UK	2018-08-31	https://f4.bcbits.com/img/a2336397456_16.jpg	34.00	{Colossus,"Never Fight A Man With A Perm","I'm Scum","Danny Nedelko","Love Song",June,Samaritans,Television,Great,"Gram Rock","Cry To Me",Rottweiler}	12	00:42:28	https://idlesband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
143	L''Ira Del Baccano	The Praise of Folly	https://liradelbaccanoofficial.bandcamp.com/album/the-praise-of-folly?from=discover_page	Rome, New York	2026-02-20	https://f4.bcbits.com/img/a3314172564_16.jpg	30.00	{"The Praise of Folly (Part 1)","The Praise of Folly (Part 2)",Stigma,"Rosencrantz and Guildenstern are dead"}	4	00:42:50	https://liradelbaccanoofficial.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
144	Mars Red Sky	Mars Red Sky (debut album)	https://marsredsky.bandcamp.com/album/mars-red-sky-debut-album?from=discover_page		2012-08-01	https://f4.bcbits.com/img/a3446157605_16.jpg	25.00	{"Strong Reflection",Curse,Falls,"Way To Rome","Saddle Point","Marble Sky","Up The Stairs"}	9	00:49:28	https://marsredsky.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
274	HSH Series	HSH001	https://hshseries.bandcamp.com/album/hsh001?from=discover_page	Amsterdam, Netherlands	2025-12-16	https://f4.bcbits.com/img/a1352931393_16.jpg	12.99	{Among,Spiral,Orcasong,"Eclipse (Dub)"}	4	00:24:02	https://hshseries.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
145	Various Artists	The Downward Spiral (Redux)	https://reduxrecords.bandcamp.com/album/the-downward-spiral-redux?from=discover_page	New York, New York	2025-11-28	https://f4.bcbits.com/img/a1197718638_16.jpg	33.14	{"Black Tusk - Mr. Self Destruct","Thief - Piggy","GRIN - Heresy","Sandrider - March of the Pigs","Daevar - Closer","High Tone Son of a Bitch - Ruiner","Dreadnought - The Becoming","John Fryer - I Do Not Want This","John Cxnnor - Big Man With a Gun","IAH - A Warm Place","Abrams - Eraser","Author & Punisher - Reptile","Palehorse Palerider - The Downward Spiral","Between the Buried and Me - Hurt"}	14	01:07:20	https://reduxrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
146	Wolf Parade	Thin Mind	https://wolfparade.bandcamp.com/album/thin-mind?from=discover_page	Montreal, Québec	2020-01-24	https://f4.bcbits.com/img/a0762606729_16.jpg	19.55	{"Under Glass","Julia Take Your Man Home","Forest Green","Out of Control","The Static Age","As Kind as You Can","Fall Into the Future","Wandering Son","Against the Day","Town Square"}	10	00:42:38	https://wolfparade.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
147	fleshwater	We''re Not Here To Be Loved	https://fleshwater.bandcamp.com/album/were-not-here-to-be-loved?from=discover_page	Georgetown, Massachusetts	2022-11-04	https://f4.bcbits.com/img/a2311964443_16.jpg	23.80	{"Baldpate Driver",Closet,"The Razor's Apple",Woohoo,"Linda Claire","Kiss The Ladder",Enjoy,"Backstairs Breathing",Foreign}	9	00:27:31	https://fleshwater.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
148	Ba Dum Tish	Cuz I Like It EP	https://badumtish.bandcamp.com/album/cuz-i-like-it-ep?from=discover_page	London, UK	2026-03-16	https://f4.bcbits.com/img/a0866475366_16.jpg	14.04	{"Cuz I Like It","Gary's Riddem","Afro Puffs","Papi's House"}	4	00:23:20	https://badumtish.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
149	GLOK	Alliance Remixed	https://glok.bandcamp.com/album/alliance-remixed?from=discover_page	London, UK	2026-02-27	https://f4.bcbits.com/img/a4215625914_16.jpg	37.44	{"Empyrean (FROID DUB Remix)","AmigA (bdrmm Remix)","Nothing Ever (Tom Sharkett Remix)","Scattered (Yu Su's Scattering Cross-Section)","The Witching Hour (Richard Sen Remix)","E-Theme (Legowelt Rave Filter Remix)","Nothing Ever Reprise (Xylitol Remix)","AmigA (Timothy Clerkin Jungle Mix)","The Empyrean Hour (Timothy Clerkin Mix)"}	9	00:53:44	https://glok.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
150	Fcukers	Ö	https://fcukers.bandcamp.com/album/-?from=discover_page	New York, New York	2026-03-27	https://f4.bcbits.com/img/a3505634352_16.jpg	25.50	{Beatback,L.U.C.K.Y,Butterflies,"if you wanna party, come over to my house","Play Me","Shake It Up","I Like It Like That",TTYGF,Lonely,Getaway,"Feel The Real"}	11	00:28:57	https://fcukers.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
151	Mary Lattimore	Tragic Magic	https://marylattimoreharpist.bandcamp.com/album/tragic-magic?from=discover_page	Los Angeles, California	2026-01-16	https://f4.bcbits.com/img/a1940337204_16.jpg	22.00	{"Perpetual Adoration","The Four Sleeping Princesses","Rachel's Song","Haze with no Haze","Temple of the Winds",Stardust,"Melted Moon"}	7	00:42:33	https://marylattimoreharpist.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
152	Holy Fuck	Event Beat	https://holyfuck.bandcamp.com/album/event-beat?from=discover_page	Toronto, Ontario	2026-03-27	https://f4.bcbits.com/img/a3603508285_16.jpg	21.25	{Evie,"Broken Roots",Elevate,Czar,Seven,"Ice Box","Gold Flakes",Aerosol,Bricks,Diamond,"Event Beat"}	11	00:40:36	https://holyfuck.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
153	light-years	At Source	https://light-years.bandcamp.com/album/at-source?from=discover_page	Berlin, Germany	2026-02-27	https://f4.bcbits.com/img/a2301226360_16.jpg	24.00	{"Intuition, Nimbus","Alignment, Orbits","Impatience, Magma","Persistence, Buds"}	4	00:33:03	https://light-years.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
154	Robyn	Sexistential	https://robynkonichiwa.bandcamp.com/album/sexistential?from=discover_page	Stockholm, Sweden	2026-03-27	https://f4.bcbits.com/img/a3422378299_16.jpg	23.39	{"Really Real",Dopamine,"Blow My Mind","Sucker For Love","It Don't Mean A Thing","Talk To Me",Sexistential,"Light Up","Into The Sun"}	9	00:29:30	https://robynkonichiwa.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
155	Cynthoni	LAMENTING MALICE	https://cynthoni.bandcamp.com/album/lamenting-malice?from=discover_page		2025-12-04	https://f4.bcbits.com/img/a1897641613_16.jpg	38.25	{Unbirthing,"The Fucking Apocalypse",Enshittification,BleakReality,"Hell Sings",MentallyILL,"Imminent Eradication","Nihilism Extremist","Dead Doom Scrolls","Endlessly Dying Machine",(emotion)2,"Fearful Avoidant Disorganised Attachment",Disappearing,"It Is 0 Seconds To Midnight"}	\N	00:42:40	https://cynthoni.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
156	C418	Minecraft - Volume Beta	https://c418.bandcamp.com/album/minecraft-volume-beta?from=discover_page		2013-11-09	https://f4.bcbits.com/img/a1112985681_16.jpg	27.20	{Ki,Alpha,"Dead Voxel","Blind Spots",Flake,"Moog City 2","Concrete Halls","Biome Fest",Mutation,"Haunt Muskie",Warmth,"Floating Trees","Aria Math",Kyoto,"Ballad of the Cats",Taswell,"Beginning 2",Dreiton,"The End",Chirp,Wait,Mellohi,Stal,Strad,Eleven,Ward,Mall,Blocks,Far,Intro}	30	02:20:55	https://c418.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
157	Shabaka	Of The Earth	https://shabaka.bandcamp.com/album/of-the-earth?from=discover_page	UK	2026-03-06	https://f4.bcbits.com/img/a0386675042_16.jpg	29.25	{"A Future Untold","Those Of The Sky","Go Astray","Step Lightly","Call The Power","Dance In Praise","Ol’ Time African Gods","Marwa The Mountain","Light The Way","Stand Firm","Space Time","Eyes Lowered"}	12	00:47:09	https://shabaka.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
158	Abul Mogard	In a Few Places Along the River	https://abulmogard.bandcamp.com/album/in-a-few-places-along-the-river?from=discover_page	Italy	2022-02-01	https://f4.bcbits.com/img/a2635090814_16.jpg	26.00	{"Against a White Cloud","In True Contemplation","Along the River","Along the River (Reduction) [digital bonus track]"}	4	00:49:59	https://abulmogard.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
159	Flaccid Mojo	Loose Jacks	https://flaccmo.bandcamp.com/album/loose-jacks?from=discover_page	Los Angeles, California	2026-02-27	https://f4.bcbits.com/img/a1352866493_16.jpg	18.70	{"Conversational Excess","Creep Meter","Bang Your Chain","VHS Motherfucker","Milk and Bones","Born Dumb","Cold Roller","Infinity Upgrade"}	8	00:42:19	https://flaccmo.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
160	Shy One	Mali	https://shyone.bandcamp.com/album/mali?from=discover_page	London, UK	2026-03-12	https://f4.bcbits.com/img/a4248684693_16.jpg	25.74	{"Evidence Of My Love Affair","I Can Tell (feat. George Riley)","Loosen Up","Moonlight (feat. Private Joy)","Full Circle","Driving On Sand (feat. Steve Spacek)","Nort Wess","Same New Song","16 Hours (feat. James Massiah)","Live Dis Ting (Belt Drives)"}	10	00:38:54	https://shyone.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
161	Cartridge 1987	Rétro Découverte: Original Soundtrack - Saison 2	https://cartridge1.bandcamp.com/album/r-tro-d-couverte-original-soundtrack-saison-2?from=discover_page	Paris, France	2025-09-19	https://f4.bcbits.com/img/a2061442921_16.jpg	25.00	{"Sonic The Hedgehog 2 - Sky Chase Zone","Pokémon Blue/Red - Pallet Town","The Legend of Zelda: Ocarina of Time - Song of Storms (Hymne à Mr. Pichon)","The Colonel's Bequest","Super Mario 64 - Piranha Plant Lullaby","The Legend of Zelda: Majora's Mask - Final Hours","Super Mario Galaxy - Gusty Garden Galaxy","Wario Land 3 - Golf Minigame Entrance","Final Fantasy 7 - Cait Sith Theme","Chrono Trigger - Delightful Spekkio","Street Fighter 2 - Balrog Theme","Mario's Picross - Mushroom Picross","SimCity - Village"}	13	00:42:31	https://cartridge1.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
162	Kangding Ray	SIRĀT (Original Motion Picture Soundtrack)	https://kangdingray.bandcamp.com/album/sir-t-original-motion-picture-soundtrack?from=discover_page	Berlin, Germany	2025-10-01	https://f4.bcbits.com/img/a0747154379_16.jpg	33.92	{Sirāt,Horizon,"En La Noche",Katharsis,Desierto,"La Route","The Fall",Ritual,"Les Marches","Surah Maryam Excerpt (Recited by Ali Keeler)","Blank Empire ( Sirāt HU remix )","Amber Decay ( Sirāt remix )"}	12	00:52:18	https://kangdingray.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
163	Carbon Based Lifeforms	Twentythree	https://carbonbasedlifeforms.bandcamp.com/album/twentythree?from=discover_page	Sweden	2011-07-23	https://f4.bcbits.com/img/a0521300956_16.jpg	400.00	{Arecibo,System,"Somwhere in russia",Terpene,Inertia,"VLA (Edit)","Kensington Gardens","Held together by gravity"}	8	01:07:43	https://carbonbasedlifeforms.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
164	NO PROBLEMA TAPES	一切事物的秩序力量	https://noproblematapes.bandcamp.com/album/--87?from=discover_page	Chile	2026-01-09	https://f4.bcbits.com/img/a2641056212_16.jpg	26.35	{他们就像鬣狗，露西,与美洲狮共泳,精神诚实,这美丽的教条,云层间唯一的一缕阳光,这个谜题的神圣之处,无神论者不能演奏爵士乐,如果她微笑我们也会微笑,"A crucifix 绑在马刀上的",请为我们祈祷}	10	00:51:18	https://noproblematapes.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
165	Shane Parish	Autechre Guitar	https://shaneparish.bandcamp.com/album/autechre-guitar-2?from=discover_page	Athens, Georgia	2026-02-27	https://f4.bcbits.com/img/a0786735092_16.jpg	29.75	{Maetl,Eggshell,Eutow,Slip,Bike,Nine,Yulquen,Lowride,Corc,Clipper}	10	00:51:42	https://shaneparish.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
166	Radicall	Oblivion EP	https://radicall.bandcamp.com/album/oblivion-ep?from=discover_page	Łódź, Poland	2026-01-14	https://f4.bcbits.com/img/a4283481698_16.jpg	14.04	{"Feel Good","Don't Be Afraid","Universal Drum",Oblivion}	4	00:20:36	https://radicall.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
167	Suckerpunch // Papa Nugs	SUCKERPUNCH006	https://suckerpunchrecordings.bandcamp.com/album/suckerpunch006?from=discover_page	London, UK	2026-01-13	https://f4.bcbits.com/img/a3712455904_16.jpg	14.04	{Flangerman,"Ever Here","Thump Ya","It Can't Go On Like This Can It? (It Can Mix)","Danger Of Rolling"}	5	00:34:15	https://suckerpunchrecordings.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
168	Colin Benders	Rigmarole	https://colinbenders.bandcamp.com/album/rigmarole?from=discover_page	Utrecht, Netherlands	2021-12-17	https://f4.bcbits.com/img/a3267372981_16.jpg	40.00	{"This is fine",Wait,"What's that noise","I can't feel my legs","Carry me"}	5	01:20:13	https://colinbenders.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
169	PERTURBATOR	Age of Aquarius	https://perturbator.bandcamp.com/album/age-of-aquarius?from=discover_page	Paris, France	2025-10-10	https://f4.bcbits.com/img/a0715522955_16.jpg	34.99	{"Apocalypse Now (ft. Ulver)",Lunacy,"Venus (ft. Author & Punisher)","The Glass Staircase","Hangover Square","The Art of War","12th House","Lady Moon (ft. Greta Link)","The Swimming Pool","Mors Ultima Ratio","Age of Aquarius (ft. Alcest)"}	11	00:59:37	https://perturbator.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
170	Voices From The Lake	II	https://voicesfromthelake.bandcamp.com/album/ii?from=discover_page	Rome, Italy	2025-12-05	https://f4.bcbits.com/img/a3093308768_16.jpg	33.00	{Eos,"Lotus Mist",Bespin,Aquateo,Montenero,Manuark,"Mono No Koto",Asterios,"Blue Noa",Ian}	11	01:47:23	https://voicesfromthelake.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
171	Machine Girl	WLFGRL 10+ YEARS ANNIVERSARY EDITION	https://machinegirl.bandcamp.com/album/wlfgrl-10-years-anniversary-edition?from=discover_page	New York, New York	2025-05-23	https://f4.bcbits.com/img/a1200897966_16.jpg	49.06	{MG1,"Ionic Funk (20XXX Battle Music)","Krystle (URL Cyber Palace Mix)","Ginger Claps",Ghost,"覆面調査員 (GabberTrap Mix)","Out By 16, Dead on the Scene","かわいい Post Rave Maximalist","Phase α","Freewill (Phase β)","Excruciating Deth (Phase γ)","Hidden Power (Phase δ)",MG2,"Lifeforce2 (Bonus Track)","WLFGRL ACID (Bonus Track)","Phantasy13 (Bonus Track)","Night Saber","A Lot 2 Me (2013 Demo)","Incan (2013 Demo)","All U Got (2013 Demo)","My Favourite Stuff (2013 Demo)",ACIDPUNK!!!!}	22	01:15:49	https://machinegirl.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
172	Oneohtrix Point Never	Tranquilizer	https://oneohtrixpointnever.bandcamp.com/album/tranquilizer?from=discover_page		2025-11-21	https://f4.bcbits.com/img/a0188445141_16.jpg	36.27	{"For Residue",Bumpy,Lifeworld,"Measuring Ruins","Modern Lust","Fear of Symmetry",Vestigel,"Cherry Blue","Bell Scanner",D.I.S.,Tranquilizer,"Storm Show",Petro,"Rodl Glide",Waterfalls}	15	00:58:31	https://oneohtrixpointnever.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
173	Calibre	they want you	https://calibre.bandcamp.com/album/they-want-you?from=discover_page	Belfast, UK	2025-12-05	https://f4.bcbits.com/img/a2912363518_16.jpg	38.61	{"living is truth","don't feel for me",tame,"possession dub","outside man","badger in forth","sally broke","they want you","ratbag dub","bit broken stream","dim light","low hanging"}	12	01:07:17	https://calibre.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
175	De:tuned	Episodes	https://detunedrecords.bandcamp.com/album/episodes?from=discover_page	Antwerp, Belgium	2026-02-27	https://f4.bcbits.com/img/a2038054227_16.jpg	11.50	{"Episode I","Episode II","Episode III","Episode IV","Episode V","Episode VI"}	6	00:33:50	https://detunedrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
176	Caribou	Butterfly	https://caribouband.bandcamp.com/album/butterfly?from=discover_page	London, UK	2026-02-06	https://f4.bcbits.com/img/a4118111990_16.jpg	30.42	{"Sad Piano House","Clap Your Hands",Hang,Lucky,"Waiting So Long","Napoleon's Rock","Good Night Baby","Talk To Me","Two Maps",Josephine,"Miles Smiles",Goldie,Caterpillar,Shifty,Invention,Eleven}	16	00:58:37	https://caribouband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
177	Signals	Field Lines Cartographer - XXi	https://signalsmmx.bandcamp.com/album/field-lines-cartographer-xxi?from=discover_page	England, UK	2026-02-16	https://f4.bcbits.com/img/a4284626606_16.jpg	18.71	{"Skimming Time","Rain Through Fog","Live in Leeds 230925 (digital bonus)"}	3	00:39:49	https://signalsmmx.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
178	6th Borough Project	The Deal EP	https://6thboroughproject.bandcamp.com/album/the-deal-ep-2?from=discover_page	Edinburgh, UK	2026-02-20	https://f4.bcbits.com/img/a1478123499_16.jpg	14.04	{"The Deal","The Hertz","Let Me Know","For Life"}	\N	00:35:30	https://6thboroughproject.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
179	International Anthem	Touch	https://intlanthem.bandcamp.com/album/touch?from=discover_page	Chicago, Illinois	2025-10-24	https://f4.bcbits.com/img/a2905449829_16.jpg	22.95	{Vexations,"Layered Presence","Works and Days",Elka,"Promenade à deux","Axial Seamount","A Title Comes","Rated OG",Oganesson,"Night Gang"}	10	00:38:53	https://intlanthem.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
180	Djrum	Under Tangled Silence	https://djrum.bandcamp.com/album/under-tangled-silence?from=discover_page	England, UK	2025-04-25	https://f4.bcbits.com/img/a1040071726_16.jpg	28.08	{"A Tune For Us",Waxcap,Unweaving,L'Ancienne,Hold,"Galaxy In Silence",Reprise,"Three Foxes Chasing Each Other","Let Me","Out Of Dust",Sycamore}	11	01:02:19	https://djrum.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
181	RuptureLDN	Humble Rock	https://ruptureldn.bandcamp.com/album/humble-rock?from=discover_page	London, UK	2026-02-06	https://f4.bcbits.com/img/a1617797809_16.jpg	18.72	{"Humble Rock",Reveal,"Jah Children","Super C"}	4	00:24:37	https://ruptureldn.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
182	Mannequin Records	MNQ 169 D.A.F. - El Que (Terence Fixmer Remixes)	https://mannequinrecords.bandcamp.com/album/mnq-169-d-a-f-el-que-terence-fixmer-remixes?from=discover_page	Germany	2026-01-09	https://f4.bcbits.com/img/a3872267096_16.jpg	20.00	{"El Que (Terence Fixmer Drive Remix)","El Que (Terence Fixmer Leather Remix)"}	2	00:11:42	https://mannequinrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
183	Hallow Under	Quiet North	https://hallowunder.bandcamp.com/album/quiet-north?from=discover_page	Richland, Washington	2026-01-11	https://f4.bcbits.com/img/a2182732514_16.jpg	32.90	{Snow,"Mountain Shelter","Quiet North","When Summer Turns To Fall","Long Shadows"}	5	00:38:02	https://hallowunder.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
184	HAYES	Everzero	https://hayescollective.bandcamp.com/album/everzero?from=discover_page	Lisbon, Portugal	2026-01-09	https://f4.bcbits.com/img/a3710217305_16.jpg	15.00	{Everzero,"Tomorrow Is Gone",Chromatic,"Pleasure Void","North Bends","Distant Ties"}	6	00:33:34	https://hayescollective.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
185	Craven Faults	Sidings	https://cravenfaults.bandcamp.com/album/sidings?from=discover_page	UK	2026-01-23	https://f4.bcbits.com/img/a4095658947_16.jpg	29.24	{Ganger,Stoneyman,"Yard Loup","Three Loaning End","Up Goods Distant, Down Goods Home","Incline Huttes","Drover Hole Sike","Far Closes"}	8	01:08:55	https://cravenfaults.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
186	Machine Girl	PsychoWarrior: MG Ultra X	https://machinegirl.bandcamp.com/album/psychowarrior-mg-ultra-x?from=discover_page	New York, New York	2025-10-24	https://f4.bcbits.com/img/a2086453290_16.jpg	29.57	{"We Don’t Give a Fuck","Come On Baby, Scrape My Data","Ignore the Vore","Rabbit Season","Creeping Up From the Pit",Psychowar,Innermission,"Dual Wield","ID Crisis Angel","Down to the Essence","Despite Having No Money At All I’m Just Another Rat in the Mall","Phantom Doom","Dread Architect","i-Void Destroyer"}	14	00:47:24	https://machinegirl.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
187	GLOK	Alliance	https://glok.bandcamp.com/album/alliance?from=discover_page	London, UK	2024-11-08	https://f4.bcbits.com/img/a4254551011_16.jpg	23.40	{Empyrean,AmigA,"Nothing Ever feat. Du Blonde",Scattered,"The Witching Hour",E-Theme,"Nothing Ever (Reprise)","Nothing Ever feat. Du Blonde (12\\" Version)"}	8	00:50:35	https://glok.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
188	r u s s e l b u c k	RAVEPOP	https://russelbuck.bandcamp.com/album/ravepop?from=discover_page	Orlando, Florida	2024-09-06	https://f4.bcbits.com/img/a2820360667_16.jpg	38.25	{"JUST ARTIST STRUGGLES","FLY WITH ME","TOO MANY PEOPLE","IN DA DOGHOUSE","EVIL MUSIC for BAD DOGS","EAT YOU UP","b-b-BASS DOWN LOW","JUST BE COMPETENT","HERE FOR A GOOD TIME, NOT A LONG TIME","SAME PLACE, DIFFERENT TIME"}	10	00:24:05	https://russelbuck.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
189	Sally C	Somethin'' Nasty EP	https://sallyc.bandcamp.com/album/somethin-nasty-ep?from=discover_page	Berlin, Germany	2025-10-23	https://f4.bcbits.com/img/a1533113153_16.jpg	13.00	{"Play Somethin' Nasty","Funky Bluh Bluh","Drop The O.S.B.","Let It Whip"}	4	00:25:50	https://sallyc.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
190	Burial	Untrue	https://burial.bandcamp.com/album/untrue?from=discover_page	London, UK	2016-03-03	https://f4.bcbits.com/img/a0104561231_16.jpg	35.09	{Untitled,Archangel,"Near Dark","Ghost Hardware",Endorphin,"Etched Headplate","In McDonalds",Untrue,"Shell of Light","Dog Shelter",Homeless,UK,Raver}	13	00:50:33	https://burial.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
191	Combichrist	No Redemption	https://combichrist.bandcamp.com/album/no-redemption?from=discover_page	Norway	2013-01-25	https://f4.bcbits.com/img/a3220707665_16.jpg	22.00	{"Age Of Mutation","Zombie Fistfight","Feed The Fire","Gimme Deathrace","Clouds Of War","Buried Alive",Empty,"I Know What I Am Doing (Planet Treason)","No Redemption","Falling Apart","Gotta Go","How Old Is Your Soul?","Pull The Pin"}	13	00:42:38	https://combichrist.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
192	Floating Points	Promises	https://floatingpoints.bandcamp.com/album/promises?from=discover_page	UK	2021-03-26	https://f4.bcbits.com/img/a2975740667_16.jpg	24.64	{"Movement 1","Movement 2","Movement 3","Movement 4","Movement 5","Movement 6","Movement 7","Movement 8","Movement 9"}	9	00:46:37	https://floatingpoints.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
193	Buried Treasure	THE SHOUT	https://buriedtreasure.bandcamp.com/album/the-shout?from=discover_page	UK	2025-12-05	https://f4.bcbits.com/img/a1022502441_16.jpg	26.91	{"A Friendly Game","There You Are","Anthony's Studio","My Wife Is Waiting For Me",Trapped,"The Shout","Crossley Inspects The Studio","Bass Drone","Anthony Attempts The Shout","CS80 Strings","Vocal Drone","Harry's Funeral","EMS seq1","Ring Mod FX","Eventide Voices","Crossley's Arrest",Roop,"Tailcoated Shaman","Not Entirely Normal","EMS seq3","Blake Leads The Bowling","Hartland Echoes","I Like To Keep It Alive","My Wife Is Waiting For Me v2",Sharpening,"Approaching Saunton","Pointing The Bone","Walking On All Fours","A Shattered Soul","CS80 Dark Strings","Lightning Strikes","Sound And Fury"}	32	00:28:48	https://buriedtreasure.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
194	Mysticisms	Dubplate #11 : Beat To Beat	https://mysticisms23.bandcamp.com/album/dubplate-11-beat-to-beat?from=discover_page	London, UK	2026-02-28	https://f4.bcbits.com/img/a1911872209_16.jpg	16.38	{"Dynamic Duo (Lexx Re-Edit)","Subconscious (Miles J Paralysis Re-Edit)","Heavy Dub (Chuggy Re-Edit)","Reality Dub (Vanity Project Re-Edit)"}	4	00:25:47	https://mysticisms23.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
195	james K	Friend	https://jameskmusic.bandcamp.com/album/friend?from=discover_page	New York, New York	2025-09-05	https://f4.bcbits.com/img/a4120596030_16.jpg	39.78	{"Days Go By","Blinkmoth (July Mix)","Doom Bikini",Idea.2,N'Balmed,Rider,"On God",Peel,"Lude (unwind)",Play,"Lung Slide","Hypersoft Lovejinx Junkdream","Collapse (falling forward blissfully all the time)"}	13	01:01:42	https://jameskmusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
196	Nous''klaer Audio	Disintegration	https://nousklaer.bandcamp.com/album/disintegration?from=discover_page	Rotterdam, Netherlands	2026-01-27	https://f4.bcbits.com/img/a0299234061_16.jpg	12.00	{Struktur,Reticulum,Disintegration}	4	00:26:38	https://nousklaer.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
197	GAUDI	Jazz Gone Dub	https://gaudimusic.bandcamp.com/album/jazz-gone-dub?from=discover_page	London, UK	2025-12-05	https://f4.bcbits.com/img/a2021541594_16.jpg	23.40	{"Cool Jazztice","H.E.L.P (Happy Elephants Love Pistachio)","Deflated and Discombobulated","Alabaster Moon","Fragile Hands","Bach @ Liszt (Bucket List)","Dub Lu",Susceptible,"Tokyo Subterfuge"}	9	00:38:23	https://gaudimusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
198	Geometric Lullaby	来たれあなたは私をすべてのものから遠ざけこの世界で一人にした	https://geometriclullaby.bandcamp.com/album/--64?from=discover_page	Pittsburgh, Pennsylvania	2025-12-05	https://f4.bcbits.com/img/a3619809845_16.jpg	37.77	{この世界の執着は、愛の前ではただの影だ,神秘的な恋人,裁きも困惑も、喜びも愛も映し出す瞳,その瞳に宿る謎と、微笑みの奥の小さな悪戯,今度こそ、自分の心に嘘をつかない,なぜ自分が悲しくて孤独だと信じているのですか？鏡を見なさい,永遠に私たちと一緒にいて}	7	01:15:32	https://geometriclullaby.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
199	International Anthem	How You Been	https://intlanthem.bandcamp.com/album/how-you-been?from=discover_page	Chicago, Illinois	2025-11-07	https://f4.bcbits.com/img/a2861032363_16.jpg	20.40	{"Gutteral Utterance","Chicago Four","Taking out the Trash",Plankton,"Chicago Three",Daves,"Old Mytth","Stepping In / The Loop","Brood Board SHROOM","Odd Evens","How You Been","Moving Walkway","Mouth Words"}	13	00:43:57	https://intlanthem.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
200	TECHNO Records	TECH035 Curated by ANNĒ	https://technorecords.bandcamp.com/album/tech035-curated-by-ann-2?from=discover_page	Kyiv, Ukraine	2026-01-22	https://f4.bcbits.com/img/a3159460882_16.jpg	35.00	{"Gaetano Parisio - Deadline","CRAVO - Drive Back","Dold - Feng Shui","Endlec - Select Source","Sera J - Triangles","The Advent - Flux","Newa - Your Love","Julieta Kopp - Empty Roads","Mike Konstantinidis - Secret Scent","Glaskin - Talon","Dynamic Forces - Untitled Two","ANNĒ - Daughter Of The Wind"}	12	00:57:26	https://technorecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.567666	2026-02-23 13:22:19.567666
201	Plastic & Sounds	P&S002	https://plasticandsounds.bandcamp.com/album/p-s002?from=discover_page	Japan	2026-01-09	https://f4.bcbits.com/img/a1217893494_16.jpg	3500.00	{SynthScale,Disappear,"Between Thoughts"}	3	00:22:19	https://plasticandsounds.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
202	ILIAN TAPE	ITLP04 - Compro	https://iliantape.bandcamp.com/album/itlp04-compro?from=discover_page	Munich, Germany	2018-05-15	https://f4.bcbits.com/img/a4230057167_16.jpg	20.00	{Cerroverb,"Session Add",Rev8617,"50 Euro To Break Boost","Via Sub Mids","Soundboy Ext.","Dial 274",VLI,"Flyby VFR","Muk FM","Kozmic Flush","Calimance (Delay Mix)"}	12	01:04:58	https://iliantape.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
203	BCCO	HATCH | BCCO003	https://bcco.bandcamp.com/album/hatch-bcco003?from=discover_page	Berlin, Germany	2026-01-16	https://f4.bcbits.com/img/a0357158197_16.jpg	14.99	{Abilene,Viable,Hatch,Condition}	4	00:22:27	https://bcco.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
204	Francesco Fabris	DISPLACES	https://francescofabris.bandcamp.com/album/displaces?from=discover_page	Reykjavík, Iceland	2026-02-27	https://f4.bcbits.com/img/a0043312780_16.jpg	28.99	{"Extraction of the I","Xanadu Phasing","Barricading the Ice Sheets","Monolith I","A Quake in Being","The Map is the Territory",Wolf-Rayet,"Monolith II","Topography of Extinction"}	9	00:41:18	https://francescofabris.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
205	Swingers	SWINGIN-WAX-0001	https://swingerslabel.bandcamp.com/album/swingin-wax-0001?from=discover_page	Benidorm, Spain	2025-12-03	https://f4.bcbits.com/img/a3168083546_16.jpg	14.04	{"Bang Da Box","Untitled (21 Seconds)"}	2	00:09:33	https://swingerslabel.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
206	Gathering of Angels	Ginseng	https://gatheringofangels.bandcamp.com/album/ginseng?from=discover_page	Maryland, New York	2026-01-13	https://f4.bcbits.com/img/a0869930035_16.jpg	17.00	{"Painted Post","Gum Chew Man","Bluff, a Lie or a Cliff","Corinthians 1:27","Road People"}	5	00:30:47	https://gatheringofangels.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
207	Barker	Stochastic Drift	https://sambarker.bandcamp.com/album/stochastic-drift?from=discover_page	Berlin, Germany	2025-04-04	https://f4.bcbits.com/img/a2523815539_16.jpg	25.50	{"Force of Habit",Reframing,"Difference and Repetition","The Remembering Self","Positive Disintegration","Cosmic Microwave","Fluid Mechanics","Stochastic Drift"}	8	00:43:18	https://sambarker.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
208	Hammock	Nevertheless	https://shop.hammockmusic.com/album/nevertheless?from=discover_page	Nashville, Tennessee	2025-07-11	https://f4.bcbits.com/img/a3428090171_16.jpg	21.25	{"Requiem for Johan","In Distance Pavilion","You Get So Far Away","Breath Inside Your Breath","Through Nameless Air","Without Which Nothing","Traces Disappear","Like a Sadness We Get Used To",Nevertheless,"Watching You Collapse","All Flesh Is Grass"}	11	00:44:01	https://shop.hammockmusic.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
209	Eye Witness Records	V.O.L.T	https://eyewitnessrecords.bandcamp.com/album/v-o-l-t?from=discover_page	Bloomington, Indiana	2025-12-05	https://f4.bcbits.com/img/a2506016823_16.jpg	42.49	{Infrared,V.O.L.T,Ultraviolet,Mode,Flux,Radiate,Isolate,Gravity,L.I.F.E,S.Y.S.T.E.M}	10	00:37:05	https://eyewitnessrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
210	DHR	Golden Groove (DHR001)	https://dhr-uk.bandcamp.com/album/golden-groove-dhr001?from=discover_page	London, UK	2026-01-23	https://f4.bcbits.com/img/a3063867949_16.jpg	14.04	{"ATST - Golden Groove","ATST - Golden Groove (Papa Nugs Remix)","ATST - Be Like Him","ATST - Be Like Him (Phasmid Remix)"}	4	00:21:07	https://dhr-uk.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
211	Madvillain	Madvillainy	https://madvillain.bandcamp.com/album/madvillainy?from=discover_page	Los Angeles, California	2004-03-23	https://f4.bcbits.com/img/a1024330960_16.jpg	28.05	{"The Illest Villains",Accordion,"Meat Grinder",Bistro,"Raid feat. MED","America's Most Blunted feat. Lord Quas","Sickfit (Instrumental)",Rainbows,Curls,"Do Not Fire! (Instrumental)","Money Folder","Shadows Of Tomorrow feat. Lord Quas","Operation Lifesaver AKA Mint Test",Figaro,"Hardcore Hustle feat. Wildchild","Strange Ways","Fancy Clown feat. Viktor Vaughn","Eye feat. Stacy Epps","Supervillain Theme (Instrumental)","All Caps","Great Day","Rhinestone Cowboy"}	22	00:46:22	https://madvillain.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
212	Constant Sound	Oldboy - How''d Ya Feel	https://constantsound.bandcamp.com/album/oldboy-howd-ya-feel?from=discover_page	UK	2026-09-01	https://f4.bcbits.com/img/a1522463516_16.jpg	14.61	{"How'd Ya Feel","Straight Hittah",Hustla}	3	00:16:22	https://constantsound.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
213	Eyesome	Wisdom EP	https://eyesome.bandcamp.com/album/wisdom-ep?from=discover_page	France	2026-01-08	https://f4.bcbits.com/img/a2323129056_16.jpg	55.00	{Wisdom,Morphing,"Junk Deal","Tune In ft. 911 Request","Wisdom (Graham Lynn Remix)"}	5	00:24:56	https://eyesome.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
214	Beatrice M.	Eurotrash	https://beatricem.bandcamp.com/album/eurotrash?from=discover_page	London, UK	2025-12-05	https://f4.bcbits.com/img/a0593476612_16.jpg	14.04	{Dresscode,Eurotrash,Wish}	3	00:12:40	https://beatricem.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
215	Black Loops	Something Special E.P	https://blackloops.bandcamp.com/album/something-special-e-p?from=discover_page	Berlin, Germany	2020-03-27	https://f4.bcbits.com/img/a0990445750_16.jpg	14.04	{"Fresh 16","Something Special","Blue Pill","The Melody (Digital Bonus)"}	4	00:27:44	https://blackloops.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
216	Julianna Barwick	Tragic Magic	https://juliannabarwick.bandcamp.com/album/tragic-magic?from=discover_page	Brooklyn, New York	2026-01-16	https://f4.bcbits.com/img/a0339344743_16.jpg	22.00	{"Perpetual Adoration","The Four Sleeping Princesses","Rachel's Song","Haze with no Haze","Temple of the Winds",Stardust,"Melted Moon"}	7	00:42:33	https://juliannabarwick.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
217	Moonshine Recordings	(dub) excursion (s)	https://moonshinerecordings.bandcamp.com/album/dub-excursion-s?from=discover_page	Poland	2018-10-05	https://f4.bcbits.com/img/a4067446419_16.jpg	25.00	{"Run Dub","Amir Dub","(Yes!) Badness","Ael Na Dub",Solid,"Ethiopian Dub",Uranus,"Run (Babe Roots Remix)"}	8	00:43:02	https://moonshinerecordings.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
218	feeo	Goodness	https://feeo.bandcamp.com/album/goodness?from=discover_page	London, UK	2025-10-10	https://f4.bcbits.com/img/a2618795326_16.jpg	25.74	{"Days pt.1","The Mountain",Requiem,"The Last Great Storm",Win!,Sandpit,Here,"Days pt.2","The Hammer Strikes the Bell","Night Forgives those Black as Her","There is No I"}	11	00:39:12	https://feeo.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
219	David August	HYMNS	https://davidaugust.bandcamp.com/album/hymns?from=discover_page	Rome, Italy	2026-02-27	https://f4.bcbits.com/img/a3088277608_16.jpg	22.00	{"HYMN I","HYMN II","HYMN III","HYMN IV","HYMN V","HYMN VI","HYMN VII","HYMN VIII","HYMN IX"}	9	00:25:16	https://davidaugust.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
220	Sully	The Still	https://sullyuk.bandcamp.com/album/the-still?from=discover_page	UK	2025-12-11	https://f4.bcbits.com/img/a1059557655_16.jpg	23.39	{"The Still",Lies,"The Still (Yaw Evans Remix)","The Still (El-B Remix) - BANDCAMP EXCLUSIVE"}	4	00:19:13	https://sullyuk.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
221	Susumu Yokota	Sakura (Skintone Edition)	https://susumuyokota.bandcamp.com/album/sakura-skintone-edition?from=discover_page	Tokyo, Japan	2025-10-03	https://f4.bcbits.com/img/a1762693479_16.jpg	35.10	{Saku,Tobiume,"Uchu Tanjyo",Hagoromo,Genshi,Gekkoh,Hisen,"Azukiiro no Kaori",Kodomotachi,Naminote,Shinsen,Kirakiraboshi}	12	00:49:53	https://susumuyokota.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
222	Dave Huismans	Lost Dubs 2006-09	https://amadeupsound.bandcamp.com/album/lost-dubs-2006-09?from=discover_page	Utrecht, Netherlands	2025-11-28	https://f4.bcbits.com/img/a3207462734_16.jpg	17.54	{"Stranger Than Paradise",Soaring,"All Weather","In Reverse"}	4	00:21:10	https://amadeupsound.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
223	Overmono	Turn The Page	https://overmono.bandcamp.com/album/turn-the-page?from=discover_page	London, UK	2024-04-24	https://f4.bcbits.com/img/a3230962872_16.jpg	13.64	{"Turn The Page"}	1	00:04:22	https://overmono.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
224	Sublunar	Fading Trails	https://sublunarrecords.bandcamp.com/album/fading-trails?from=discover_page	Florence, Italy	2025-11-14	https://f4.bcbits.com/img/a0712799008_16.jpg	12.00	{"Silent Range","Beaten II",Machina,"Fading Trails",Lightshifter}	5	00:26:28	https://sublunarrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
225	Planet Rhythm	Muzzle Blast EP (Special Vinyl Promotion)	https://planetrhythm.bandcamp.com/album/muzzle-blast-ep-special-vinyl-promotion?from=discover_page	Rotterdam, Netherlands	2026-01-12	https://f4.bcbits.com/img/a2151326277_16.jpg	5.00	{"Muzzle Blast","Most Monkeys Live In Trees","Chinese Water Torture","Wasps Attack When Drunk"}	4	00:21:25	https://planetrhythm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
226	Ness	Chromadelia EP	https://ness8.bandcamp.com/album/chromadelia-ep?from=discover_page	Italy	2026-01-09	https://f4.bcbits.com/img/a1181882249_16.jpg	11.00	{Iridium,Mechalon,Spectravore,Eltrip}	4	00:22:51	https://ness8.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
227	Loopaina	Clusters of Noise [LPR-V006]	https://loopainarecords.bandcamp.com/album/clusters-of-noise-lpr-v006?from=discover_page		2026-02-13	https://f4.bcbits.com/img/a3303544791_16.jpg	12.50	{"Oliver Rosemann - Pleiades","Carmelo Ponente - Vega","Oliver Rosemann - Pleiades (Carmelo Ponente Remix)","Carmelo Ponente - Vega (Oliver Rosemann Remix)","Carmelo Ponente - Hydra (Digital Bonus Track)","Oliver Rosemann - Hyades (Digital Bonus Track)"}	6	00:33:27	https://loopainarecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
228	[Emotional] Especial	Dub Acid EP	https://emotional-especial.bandcamp.com/album/dub-acid-ep?from=discover_page	UK	2025-12-31	https://f4.bcbits.com/img/a2976628514_16.jpg	16.38	{"I Like Smoke","Night Time High Acid","Creation Dub","Harmonica Dub"}	4	00:24:20	https://emotional-especial.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
229	Vladimir Dubyshkin	jane doe''s secret	https://vladimirdubyshkin.bandcamp.com/album/jane-does-secret?from=discover_page	Tambov, Russia	2025-12-19	https://f4.bcbits.com/img/a1257652089_16.jpg	12.00	{"all inclusive resort","whats bitting you?",midsommar,"gimme dat beat","party with exit visa","la fiebre","sad glam","bone crushing"}	8	00:33:33	https://vladimirdubyshkin.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
230	Nous''klaer Audio	Always There	https://nousklaer.bandcamp.com/album/always-there?from=discover_page	Rotterdam, Netherlands	2025-12-19	https://f4.bcbits.com/img/a3032068597_16.jpg	12.00	{"Ready To Let Go",Surge,"Find Me",Paean}	4	00:24:44	https://nousklaer.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
231	iDEAL Recordings	PENDULUM	https://idealrecordings.bandcamp.com/album/pendulum?from=discover_page	Sweden	2025-12-30	https://f4.bcbits.com/img/a4012311564_16.jpg	25.00	{"PENDULUM PART 1","PENDULUM PART 2"}	2	00:09:22	https://idealrecordings.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
232	Ashbury Heights	Three Cheers For The Newlydeads	https://ashburyheights.bandcamp.com/album/three-cheers-for-the-newlydeads?from=discover_page	Sundsvall, Sweden	2007-10-05	https://f4.bcbits.com/img/a2846038449_16.jpg	30.00	{"Bare your Teeth","Waste of Love",SmAlLeR,Stormbringer,"Derrick is a Strange Machine","Cry Havoc",Swansong,Illusion,"Angora Overdrive",Corsair,Christ,"Suicide Anthem",Penance,"I Paint Nightscapes","Eternity at an End"}	15	01:06:47	https://ashburyheights.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
233	Brazen Records	BRZ010 - DJ SOFA	https://brazenrecords.bandcamp.com/album/brz010-dj-sofa?from=discover_page	Bristol, UK	2026-01-09	https://f4.bcbits.com/img/a0491454908_16.jpg	14.04	{"Horns for 24","No Mercy (Raw Deal)","Lost My Head (ft. Infekto)","Horns for 24 (Tim Reaper Remix)"}	4	00:21:39	https://brazenrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
234	smallville records	Smallville 71 - Lb Honne - Brücke	https://smallville-records.bandcamp.com/album/smallville-71-lb-honne-br-cke?from=discover_page	Freiburg Im Breisgau, Germany	2025-12-05	https://f4.bcbits.com/img/a3093941759_16.jpg	14.00	{"Lb Honne - A1 - Brücke","Lb Honne - A2 - Not Tonight","Lb Honne - B1 - Deeper","Lb Honne - B2 - Rue Du Belfort"}	4	00:29:22	https://smallville-records.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
235	Fokuz Recordings	Requiem 4 Dreams EP	https://fokuzrecordings.bandcamp.com/album/requiem-4-dreams-ep?from=discover_page	Rotterdam, Netherlands	2026-01-16	https://f4.bcbits.com/img/a2419424018_16.jpg	12.75	{"Requiem 4 Dreams (Amen Addict Remix)","Ocean I (Hardcore Jungle Remix)","Morning After"}	3	00:14:30	https://fokuzrecordings.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
236	cEvin Key	Astral Elevator	https://brap.bandcamp.com/album/astral-elevator?from=discover_page	Vancouver, British Columbia	2025-10-24	https://f4.bcbits.com/img/a0589559916_16.jpg	38.25	{"A Return","Going Up","Lady Fate","Square Root","It Just Ain't So","In the Name of",Exorcism,"Toten Tanz","War Crier","Swallow the Leader",Unreal,"A Developing World","Always Take the Highway","Chow Mein","Undiluted Bliss"}	15	01:15:23	https://brap.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
237	Plastic & Sounds	SET DISCOUNT	https://plasticandsounds.bandcamp.com/album/set-discount?from=discover_page	Japan	2026-01-09	https://f4.bcbits.com/img/a0577866554_16.jpg	6000.00	{"Whispers into the Void",Fleeting_637,SynthScale,Disappear,"Between Thoughts"}	5	00:37:20	https://plasticandsounds.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
238	Mysticisms	Dubplate #12 : Persian Meets Miles J Paralysis	https://mysticisms23.bandcamp.com/album/dubplate-12-persian-meets-miles-j-paralysis?from=discover_page	London, UK	2025-12-31	https://f4.bcbits.com/img/a4097074325_16.jpg	16.38	{"Survival Dub (Miles J Paralysis 'Big Slide' Remix)","Smoke Mari (Miles J Paralysis 'Breathwork' Dub)","There Is No Love (Miles J Paralysis 'Hopeful Romantic' Remix)","Zatoichis Troubles (Miles J Paralysis `Headspace' Dub)","DIGITAL BONUS : Persian - Zatoichis Troubles (Miles J Paralysis `Night Walk' Dub)"}	5	00:33:38	https://mysticisms23.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
239	Molekül	Midnight Cuts EP [MLKL046]	https://molekul.bandcamp.com/album/midnight-cuts-ep-mlkl046?from=discover_page	Paris, France	2026-01-20	https://f4.bcbits.com/img/a3454530619_16.jpg	13.00	{"FANK - Amatriciana","Vanya Velin - Oxygen Drift","Vilchezz - Night End Dubs","Rare Mamba - Disorder","MAURER - Corporate Smile","Josh Heywood - Desire"}	6	00:28:51	https://molekul.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
240	Mars Frequency Records	ElectroVision	https://marsfrequency.bandcamp.com/album/electrovision?from=discover_page	Madrid, Spain	2026-01-28	https://f4.bcbits.com/img/a3085836096_16.jpg	15.50	{"Siempre Chándal",101%,Viajeros,"Door Mir"}	4	00:20:08	https://marsfrequency.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
241	Pinkman	Steamy Highways Have No End	https://pinkman.bandcamp.com/album/steamy-highways-have-no-end?from=discover_page	Rotterdam, Netherlands	2025-12-18	https://f4.bcbits.com/img/a3250642331_16.jpg	25.00	{"In The Swamp","Night Owl","Never Wake Up Again","Μαύρη Χήρα","Ruine Des Seigneurs Iniques",Krematorium,"March To The Drums","Entre Ciel Et Terre","Atom Bomb (Special Edition 7\\" - Vinyl Only) - Beware: This is a 1 minute snippet","Νεκρός Κόσμος (Special Edition 7\\" - Vinyl Only) - Beware: This is a 1 minute snippet","Digital bonus: Never Wake Up Again (Radio Edit)"}	11	00:47:56	https://pinkman.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
242	Burial	Comafields / Imaginary Festival	https://burial.bandcamp.com/album/comafields-imaginary-festival?from=discover_page	London, UK	2025-08-01	https://f4.bcbits.com/img/a1072802913_16.jpg	17.54	{Comafields,"Imaginary Festival"}	2	00:22:48	https://burial.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
243	Hania Rani	Esja	https://haniarani.bandcamp.com/album/esja?from=discover_page	Warsaw, Poland	2019-04-05	https://f4.bcbits.com/img/a1351551068_16.jpg	26.90	{Eden,Sun,"Hawaii Oslo","Pour Trois",Biesy,Luka,Glass,"Today It Came",Esja,"Now, Run"}	10	00:45:07	https://haniarani.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
244	ILIAN TAPE	ITLP19 - Resort	https://iliantape.bandcamp.com/album/itlp19-resort?from=discover_page	Munich, Germany	2024-06-13	https://f4.bcbits.com/img/a1230128187_16.jpg	20.00	{"Hedwig Transformation Group",Nostaglitch,Reminiscrmx,Element,Waldmeister,"Daytime Gamer","Schneiders Paradox","BB Care","Terminal Z","Hölzl Was A Dancer","7AM At The Rodeo","Vitamin 313"}	12	01:03:17	https://iliantape.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
245	[Emotional] Especial	Don''t Forget The Ritual	https://emotional-especial.bandcamp.com/album/dont-forget-the-ritual?from=discover_page	UK	2026-02-28	https://f4.bcbits.com/img/a1080515585_16.jpg	16.38	{"It's Only Shadows Talking","Don't Forget The Ritual","Come On Fleet","The Delicate Fairytale"}	4	00:29:21	https://emotional-especial.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
246	Regent	Arcane EP	https://regent030.bandcamp.com/album/arcane-ep?from=discover_page	Berlin, Germany	2025-12-05	https://f4.bcbits.com/img/a0531633673_16.jpg	15.00	{Kinesis,Infrascope,Arcane,"Finite Source"}	4	00:23:00	https://regent030.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
247	KMFDM	ENEMY	https://kmfdm.bandcamp.com/album/enemy?from=discover_page	Germany	2026-02-06	https://f4.bcbits.com/img/a2652867002_16.jpg	32.30	{ENEMY,OUBLIETTE,L'ETAT,VAMPYR,YOÜ,"OUTERNATIONAL INTERVENTION","A OKAY","STRAY BULLET 2.0","CATCH & KILL","GUN QUARTER SUE","THE SECOND COMING"}	11	00:44:40	https://kmfdm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
248	Ottagone	Selected II	https://ottagone.bandcamp.com/album/selected-ii?from=discover_page	Amsterdam, Netherlands	2026-01-09	https://f4.bcbits.com/img/a2536218688_16.jpg	16.99	{"Ottagone 013","Ottagone 025","Ottagone 033","Ottagone 035","Ottagone 038","Ottagone 040"}	6	00:30:02	https://ottagone.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
249	Danny L Harle	Cerulean	https://dannylharle.bandcamp.com/album/cerulean?from=discover_page	UK	2026-02-13	https://f4.bcbits.com/img/a0617852970_16.jpg	20.21	{Noctilucence,"Starlight (feat. PinkPantheress)","Azimuth (feat. Caroline Polachek)","Facing Away (feat. Clairo)","Raft In The Sea (feat. Julia Michaels)","Island (da da da)","Te Re Re (feat. kacha)",Laa,"O Now Am I Truly Lost","Two Hearts","Danny L Harle & oklou & MNEK - Crystallise My Tears (feat. Oklou and MNEK)","On & On (feat. Caroline Polachek)","Teardrop in the Ocean"}	13	00:42:32	https://dannylharle.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
250	Group Rhoda	Phase 5	https://grouprhoda.bandcamp.com/album/phase-5?from=discover_page	Oakland, California	2026-02-13	https://f4.bcbits.com/img/a0024195959_16.jpg	17.00	{"Field Tone","Dragon Pine",Formless,"White Fur",Sunseer,"Aeolian Crossing"}	6	00:35:01	https://grouprhoda.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
251	Nala Sinephro	Space 1.8	https://nalasinephro.bandcamp.com/album/space-18?from=discover_page	London, UK	2021-09-03	https://f4.bcbits.com/img/a2701684768_16.jpg	26.91	{"Space 1","Space 2","Space 3","Space 4","Space 5","Space 6","Space 7","Space 8"}	8	00:44:19	https://nalasinephro.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
252	Doki Doki Beats	GO UNTIL YOU ARE GONE 2013.04-07	https://dokidokibeats.bandcamp.com/album/go-until-you-are-gone-201304-07?from=discover_page	Columbus, Ohio	2026-01-09	https://f4.bcbits.com/img/a1382036254_16.jpg	25.50	{"the ballad of yuki","nothing will ever be enough (1)","the oppressor (there is no punishment befitting)","girls in my dreams are made up of static interference","i have a hole in my chest","this creeping malaise","cocoon (mind with whom you speak)","becoming now a moth (away this silken paper coat) [feat. simvlacrvm]","And So You Will Go Until You Are Gone (2)","A Prison of/is Your Own Creation"}	10	00:39:48	https://dokidokibeats.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
253	With Bells Records	TIOL	https://withbellsrecords.bandcamp.com/album/tiol?from=discover_page	Sheffield, UK	2025-12-12	https://f4.bcbits.com/img/a0628496869_16.jpg	26.79	{Gosson,Play,"Constant Watch","Clutter House"}	4	00:18:53	https://withbellsrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
254	Smile Sessions	SMILE SESSIONS 010 x Maison Close | JKS & Lacchesi - High & Dry EP	https://smilesessions.bandcamp.com/album/smile-sessions-010-x-maison-close-jks-lacchesi-high-dry-ep?from=discover_page	Berlin, Germany	2026-01-16	https://f4.bcbits.com/img/a1434730044_16.jpg	12.50	{"JKS & Lacchesi - High & Dry","Lacchesi & JKS - Get Johnson","JKS - Spectra","Lacchesi - Overhead, The Albatross"}	4	00:21:28	https://smilesessions.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
255	Sublunar	Veil Of Echoes II	https://sublunarrecords.bandcamp.com/album/veil-of-echoes-ii?from=discover_page	Florence, Italy	2025-12-12	https://f4.bcbits.com/img/a1480325397_16.jpg	24.50	{"Cirkle - Voltage","Red Rooms - Tides","Border One - Phonolith","Hemka - Basic Instinct","Hadone - Your Hands Forget Their Shapes","Temudo - The Radius","Hurdslenk - Etched","Pierce - Nardo","Ketch & Alessio Landini - Serpents","Danya - Zone 0"}	10	00:52:51	https://sublunarrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
272	Clone Classic Cuts	Abacus - The Relics E.P.	https://cloneclassiccuts.bandcamp.com/album/abacus-the-relics-e-p?from=discover_page	Rotterdam, Netherlands	2026-01-19	https://f4.bcbits.com/img/a2849787601_16.jpg	15.99	{"A Place In Time","Relics Three Mix One (Edit DGT)","The Abacus Chat","Relics Two Mix One","Relics One","Relics One Mix Three"}	6	00:31:17	https://cloneclassiccuts.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
256	Mutual Rytm	Federation Of Rytm IV	https://mutual-rytm.bandcamp.com/album/federation-of-rytm-iv?from=discover_page	Stuttgart, Germany	2025-10-24	https://f4.bcbits.com/img/a4266740078_16.jpg	59.00	{"X&B - Strobocop","Yanamaste - Hunter","Temudo - Cohorus","Ignez - Rudimental","Dextro - Buck Rogers","Flug - In Control","Klint - Quad","DJ Plant Texture - Reesolution","Petter B - Replicated","BACKBONE - From 0","Mathys Lenne - Mutant","Nørbak - Americana","Ribé & Roll Dann - El Tránsito","Red Rooms - Debris","Sciahri - Pushing","Kameliia - Parallel Realities","Jancen - Sensation","AgainstMe - OB Dub","Blenk - Shaders","Marcal - Intertwined","Hyden - Rêverie","BLANKA - I Choose You","Developer - Have It All","Claudio PRC - Torque","R.M.K - Marine","Conrad Van Orton - Man Down","Hurtado - Addiction","Toru Katsuta - Everything's In Order","Scheermann - Ito","Augusto Taito - Collar Bone"}	30	02:34:37	https://mutual-rytm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
257	INDEX:Records	Subterra	https://indexrecords.bandcamp.com/album/subterra?from=discover_page	Glasgow, UK	2025-10-31	https://f4.bcbits.com/img/a2139586464_16.jpg	21.06	{Sucker,"Find You","Get In It","Subterra (feat. Uza A'amo)","Higher (feat. {iii})","Years of Mirrors (feat. Yau Hei ASJ)",Animals,Fears,"Sucker (Downstairs People Mix)","Fears (Ike Remix)"}	10	00:41:32	https://indexrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
258	Carbon Based Lifeforms	World Of Sleepers	https://carbonbasedlifeforms.bandcamp.com/album/world-of-sleepers?from=discover_page	Sweden	2015-09-04	https://f4.bcbits.com/img/a4192776465_16.jpg	400.00	{Abiogenesis,Vortex,Photosynthesis,"Set Theory",Gryning,"Transmission / Intermission","World Of Sleepers","Proton / Electron","Erratic Patterns","Flytta DIg","Betula Pendula"}	11	01:16:05	https://carbonbasedlifeforms.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
259	Carbon Based Lifeforms	Hydroponic Garden	https://carbonbasedlifeforms.bandcamp.com/album/hydroponic-garden?from=discover_page	Sweden	2003-06-25	https://f4.bcbits.com/img/a0675913677_16.jpg	400.00	{"Central Plains",Tensor,"MOS 6581 (Album Version)","Silent Running",Neurotransmitter,"Hydroponic Garden",Exosphere,Comsat,"Epicentre (First Movement)","Artificial Island","Refraction 1.33"}	11	01:22:10	https://carbonbasedlifeforms.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
260	Rob Clouth	Cicada	https://robclouth.bandcamp.com/album/cicada?from=discover_page	Barcelona, Spain	2026-03-20	https://f4.bcbits.com/img/a2704782388_16.jpg	19.89	{Cicada,"Gummy Clusters",Grefuser,Core}	4	00:20:00	https://robclouth.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
261	Alpha''s Trip Records	AT003: Joe Koshin - Tuff Fluff EP	https://alphastriprecords.bandcamp.com/album/at003-joe-koshin-tuff-fluff-ep?from=discover_page	Bristol, UK	2026-01-14	https://f4.bcbits.com/img/a0626816866_16.jpg	15.21	{"Joe Koshin - Players Lounge","Joe Koshin - Conscience","Joe Koshin - Tuff Fluff","Joe Koshin - Tuff Fluff (A for Alpha Remix)"}	4	00:21:40	https://alphastriprecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
262	Cone Shape Top Imprint	Seamstress Clock Remixes	https://coneshapetopimprint.bandcamp.com/album/seamstress-clock-remixes?from=discover_page	Oakland, California	2025-12-06	https://f4.bcbits.com/img/a1952278002_16.jpg	16.15	{"False Aralia - Time to Erase","Philipp Otterbach - Keeping Time Remix","Motoko & Myers - Petal Crusher Remix","Slowfoam - Atemporal Remix","Jon Carr - Mistress Clock Remix"}	5	00:26:26	https://coneshapetopimprint.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
263	Tombed Visions Records	Five Stagings	https://tombedvisionsrecords.bandcamp.com/album/five-stagings?from=discover_page	Manchester, UK	2026-01-30	https://f4.bcbits.com/img/a2809008141_16.jpg	23.39	{"The Copse and The Hunting Lodge","Plum Dark","Meudon, 1928","Crystal Radio","Lion To Feel"}	5	00:41:57	https://tombedvisionsrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
264	Al Wootton	Glorias	https://alwootton.bandcamp.com/album/glorias?from=discover_page	UK	2025-12-19	https://f4.bcbits.com/img/a0864910929_16.jpg	17.55	{Glorias,"Glorias (Drums Version)","Glorias (Drumless Version)"}	3	00:35:18	https://alwootton.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
265	Warrington-Runcorn New Town Development Plan	Public Works and Utilities	https://warrington-runcorn-cis.bandcamp.com/album/public-works-and-utilities-2?from=discover_page	Runcorn, UK	2025-10-10	https://f4.bcbits.com/img/a3819554597_16.jpg	26.91	{"Swift, Safe and Comfortable","Sunset Over Stanlow","800 Yards Down At Ince Six Feet","Water Treatment Works","Renewal and Regeneration","The People Matter"}	6	00:38:29	https://warrington-runcorn-cis.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
266	Marco Shuttle	MSP02	https://marcoshuttle.bandcamp.com/album/msp02?from=discover_page	Berlin, Germany	2025-05-19	https://f4.bcbits.com/img/a3497482559_16.jpg	14.50	{BARyGOU,WyMEKE}	2	00:15:41	https://marcoshuttle.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
267	BLUSH RESPONSE	VOID IN	https://blushresponse.bandcamp.com/album/void-in?from=discover_page	Berlin, Germany	2020-07-13	https://f4.bcbits.com/img/a1323165310_16.jpg	20.00	{"VOID IN",SLAMHOUND,LOA,"MORPHIC POLYMER","PHYSICS AS A WEAPON",CHIRALIUM,"GENE STEALER","THE SECOND AETHYR","WAVES OF SILVER",TIMEFALL}	10	00:54:07	https://blushresponse.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
268	Coflo	Tsunami''s Muse	https://coflo.bandcamp.com/album/tsunamis-muse-2?from=discover_page	California	2025-12-15	https://f4.bcbits.com/img/a0509822463_16.jpg	20.00	{"Tsunami's Muse","Tsunami's Groove","Tsunami's Muse (Backside Mix)"}	3	00:25:28	https://coflo.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
269	KALI MALONE	Magnetism	https://kalimalone.bandcamp.com/album/magnetism?from=discover_page	Stockholm, Sweden	2025-11-09	https://f4.bcbits.com/img/a1589705385_16.jpg	25.00	{"Nothing Here Is Lost","The Secret Of Magnetism","Withdrawn Into The Source","The Sound In My Mind","A Sound That Is Alive"}	5	00:40:08	https://kalimalone.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
270	Flatlife Ultra Limited	Smash The Statues EP (Acid Techno)	https://flatlifeultra.bandcamp.com/album/smash-the-statues-ep-acid-techno?from=discover_page	Netherlands	2026-01-13	https://f4.bcbits.com/img/a3946184885_16.jpg	9.99	{"Smay & Tio Toni - Discoteque","Alex Punto - The Beat Bang","Chief303 - Drop The Fucking Acid","Vic Zee - Blow"}	4	00:27:19	https://flatlifeultra.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
271	International Anthem	The Way Out of Easy	https://intlanthem.bandcamp.com/album/the-way-out-of-easy?from=discover_page	Chicago, Illinois	2024-11-22	https://f4.bcbits.com/img/a2139666555_16.jpg	28.90	{Freakadelic,"Late Autumn","Easy Way Out","Chrome Dome"}	4	01:19:56	https://intlanthem.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
275	Machinedrum	IIII	https://machinedrum.bandcamp.com/album/iiii?from=discover_page	North Carolina	2025-10-09	https://f4.bcbits.com/img/a1591533920_16.jpg	30.00	{"IS HIER",CONTROL,"SOLAAR 42","THE SOURCE","WHERE WERE YOU",FRANKFURT,SOLITU,"VAI PULANDO","SMTM (Bonus track)","QUEMA QUEMA","LOOK AT THE TREES"}	11	00:38:04	https://machinedrum.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
276	Kiss The Anus Of A Black Cat	Hewers of Wood ''26	https://kisstheanusofablackcat.bandcamp.com/album/hewers-of-wood-26?from=discover_page	Gent, Belgium	2026-02-20	https://f4.bcbits.com/img/a4285816865_16.jpg	25.00	{"Hewers Of Wood And Drawers Of Water","All Your Ghosts Are Worried","Argonaut And Magneto",Harrow,Veneration,"Taking The Auspices","Feathers Of The Wings Of The Angel Gabriel","All The Heroes Run In Armour","Wander Or Waiver"}	\N	00:36:00	https://kisstheanusofablackcat.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
277	Bonobo	Fragments	https://bonobomusic.bandcamp.com/album/fragments?from=discover_page	Brighton, UK	2022-01-14	https://f4.bcbits.com/img/a1926443246_16.jpg	25.50	{"Polyghost (feat. Miguel Atwood-Ferguson)","Shadows (feat. Jordan Rakei)",Rosewood,"Otomo (feat. O’Flynn)","Tides (feat. Jamila Woods)",Elysian,Closer,"Age of Phase","From You (feat. Joji)",Counterpart,Sapien,"Day by Day (feat. Kadhja Bonet)"}	12	00:51:21	https://bonobomusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
278	Mysticisms	Dubplate #10 : Persian Meets Picasso	https://mysticisms23.bandcamp.com/album/dubplate-10-persian-meets-picasso?from=discover_page	London, UK	2025-12-31	https://f4.bcbits.com/img/a0709737085_16.jpg	16.38	{"Space Within Art (Picasso Abstract Groove Remix)","Dunya 2 (Picasso Harp Diem Remix)","D Dub Twist (Picasso Twist Ya Arm Remix)","Jacob's Dub (Picasso Dubbier Dub)","DIGITAL BONUS : Space Within Art (Picasso Ambient Abstraction)"}	5	00:36:33	https://mysticisms23.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
279	Dames Brown	Take Me As I Am (Extended Mixes)	https://dames-brown.bandcamp.com/album/take-me-as-i-am-extended-mixes-3?from=discover_page	Detroit, Michigan	2026-01-21	https://f4.bcbits.com/img/a0163611910_16.jpg	31.58	{"Dames Brown, Amp Fidler - Introducing Dames Brown (Extended Mix)","Dames Brown, Amp Fiddler, Andrés - What Would You Do? (12\\" Mix)","Dames Brown - You’re The One For Me (Extended Mix)","Dames Brown, Waajeed - Glory (Extended Mix)","Dames Brown - Take Me As I Am","Dames Brown - What Up Doe?’ (Extended Mix)","Dames Brown, Eddie Fowlkes - Do It (Extended Mix)","Dames Brown - Who Do You (Think You Are)? (Extended Mix)","Dames Brown - Provider (Extended Mix)","Dames Brown - Introducing Pt. II (Dirty Hips) (Extended Mix)","Dames Brown - Sweat (Extended Mix)","Dames Brown - This Time (Extended Mix)","Dames Brown - Why You Got Me Crazy (Walk Away) (Extended Mix)","Dames Brown - Ova (Extended Mix)"}	14	01:21:11	https://dames-brown.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
280	Tarun Balani	ڪڏهن ملنداسين Kadahin Milandaasin	https://tarunbalani.bandcamp.com/album/kadahin-milandaasin?from=discover_page	New Delhi, India	2025-05-16	https://f4.bcbits.com/img/a1537931473_16.jpg	25.00	{"Lajpat Nagar Sometimes","ڪڏهن ملنداسين Kadahin Milandaasin","The Laburnum Blooms","ٻوڏ Sailaab","Locusts Are Descending","Samadhi 02.11.2024","For Every Man Saved A Victim Will Be Found"}	7	00:37:46	https://tarunbalani.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
281	Hania Rani	Home	https://haniarani.bandcamp.com/album/home?from=discover_page	Warsaw, Poland	2020-05-29	https://f4.bcbits.com/img/a2903470072_16.jpg	26.90	{Leaving,Buka,Nest,"Letter to Glass",Home,"Zero Hour","F Major",Summer,Rurka,Tennen,"I'll Never Find Your Soul",Ombelico,"Come Back Home"}	13	00:57:39	https://haniarani.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
282	Boards of Canada	Geogaddi	https://boardsofcanada.bandcamp.com/album/geogaddi?from=discover_page		2002-02-19	https://f4.bcbits.com/img/a3411624925_16.jpg	43.29	{"Ready Lets Go","Music Is Math","Beware The Friendly Stranger",Gyroscope,Dandelion,"Sunshine Recorder","In The Annexe","Julie And Candy","The Smallest Weird Number",1969,"Energy Warning","The Beach At Redpoint","Opening The Mouth","Alpha And Omega","I Saw Drones","The Devil Is In The Details","A Is To B As B Is To C","Over The Horizon Radar","Dawn Chorus","Diving Station","You Could Feel The Sky",Corsair,"Magic Window"}	23	01:06:04	https://boardsofcanada.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
283	Red Hook Records	Solace of the Mind	https://redhookrecords.bandcamp.com/album/solace-of-the-mind?from=discover_page		2025-06-20	https://f4.bcbits.com/img/a0536365640_16.jpg	27.00	{"African Blues","Song for Mother E",Sensuous,"Steal Away","Ode to my Ancestors",Voices,"Hymn for John Lee Hooker",Twilight,Cairo,"Beneath the Sun"}	10	00:40:53	https://redhookrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
284	THE FUTURE SOUND OF LONDON	Sleep-Walking  <7/650>	https://fsol.bandcamp.com/album/sleep-walking-7-650?from=discover_page	London, UK	2026-01-01	https://f4.bcbits.com/img/a1473832487_16.jpg	17.55	{Sleepwalking,"Just Below the Skyline"}	2	00:09:02	https://fsol.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
285	FFF	[3AM010] FFF - The Program	https://fffmusic.bandcamp.com/album/3am010-fff-the-program?from=discover_page	Rotterdam, Netherlands	2026-01-30	https://f4.bcbits.com/img/a2841463813_16.jpg	12.00	{Promoter,"Ruffer Than Them","The Program","Defend Our Sound"}	4	00:24:34	https://fffmusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
286	Coflo	Infinite Salutations	https://coflo.bandcamp.com/album/infinite-salutations?from=discover_page	California	2026-01-23	https://f4.bcbits.com/img/a4081109229_16.jpg	14.00	{"Salutations (feat. QVLN)","Salutations (feat. QVLN) SNIPPET",Infinite,"Infinite SNIPPET"}	4	00:23:03	https://coflo.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
287	Sam Goku	Explorations 02	https://samgoku.bandcamp.com/album/explorations-02?from=discover_page	Munich, Germany	2025-09-26	https://f4.bcbits.com/img/a2469952851_16.jpg	13.00	{x-plor05,x-plor06,x-plor07,x-plor08}	4	00:25:19	https://samgoku.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
288	R.A.N.D. Muzik Recordings	Park Erporia EP (RMECR006)	https://randmuzikrecordings.bandcamp.com/album/park-erporia-ep-rmecr006?from=discover_page	Leipzig, Germany	2025-12-24	https://f4.bcbits.com/img/a2971412742_16.jpg	14.00	{Nuggyo,"Yko Proto",Chordesia,"Love U"}	4	00:26:21	https://randmuzikrecordings.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
414	NIMBIFER	Vom Gipfel	https://nimbifer.bandcamp.com/album/vom-gipfel?from=discover_page	Hanover, Germany	2025-10-17	https://f4.bcbits.com/img/a0023738440_16.jpg	16.00	{"Der Berg","Das Ende",-Rückkehr-}	3	00:18:37	https://nimbifer.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
289	Projekt Records	low sunday ghost machine white ep	https://projektrecords.bandcamp.com/album/low-sunday-ghost-machine-white-ep?from=discover_page	Portland, Oregon	2025-11-28	https://f4.bcbits.com/img/a1944239021_16.jpg	18.70	{Nevver,"Call Silence","Soft Capture","You Lost Yourself","Love Language"}	5	00:18:42	https://projektrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
290	BLUSH RESPONSE	NEUROSCAPE	https://blushresponse.bandcamp.com/album/neuroscape?from=discover_page	Berlin, Germany	2023-04-04	https://f4.bcbits.com/img/a3597205541_16.jpg	20.00	{SUBMIT,"WATCHING YOURSELF BEING BORN",LOCUTUS,"SEXUAL DECEPTION","DEATH LINE RUPTURE","DEAD ZONE","FLESH AND SOIL","CHAINED [FEATURING BON HARRIS]","FOLDSPACE TRANSITION [FEATURING RICHARD DEVINE]"}	9	00:45:30	https://blushresponse.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
291	Northern Underground Records	Into The Doldrums LP	https://northernundergroundrecords.bandcamp.com/album/into-the-doldrums-lp?from=discover_page	Melbourne, Australia	2025-05-16	https://f4.bcbits.com/img/a4155354651_16.jpg	23.00	{"Into The Doldrums",Mindflower,"Close To Greatness",Mayhem,"A Pain I Used To Feel",Hybris,"Sleepy Head",24hrs,"Branching Moments"}	9	00:35:32	https://northernundergroundrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
292	JG Thirlwell	Music of The Venture Bros Volume 3	https://jgthirlwell.bandcamp.com/album/music-of-the-venture-bros-volume-3?from=discover_page	Brooklyn, New York	2025-09-05	https://f4.bcbits.com/img/a1697388765_16.jpg	23.80	{Copycat,"Scaramantula's Lair",Showdown,"SS19 Rampup","A Night For Crime","Jet Bancroft",Yardbrawl,"Doom Factory","Scan Mode","Blue Morpho Sym","Luckie Groovie",Mopstalk,"Hells Bells",Knots,"Blind Shuffle","Trou de Peche Redux","Manhattan Bridge","Lab Break",Saphrax,Parkfrontation,"SS06 Hulk",Uranium,"Prof Thinktank","Jungle Chase","Council of 13","HankBat Ambush",Haranguetang,"Times Square","Spirit Invasion",Hat-Tastic,"The 55",Treehugger,"Snake Oil","Tuff Stars"}	34	01:00:28	https://jgthirlwell.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
293	Björk	Debut	https://bjork.bandcamp.com/album/debut?from=discover_page	Iceland	1993-07-05	https://f4.bcbits.com/img/a2682265154_16.jpg	28.07	{"Human Behaviour",Crying,"Venus As A Boy","There's More To Life Than This (Recorded Live at the Milk Bar Toilets)","Like Someone In Love","Big Time Sensuality","One Day",Aeroplane,"Come To Me","Violently Happy","The Anchor Song","Play Dead"}	12	00:52:27	https://bjork.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
294	White Peach	WPR086 - Empires	https://whitepeach.bandcamp.com/album/wpr086-empires?from=discover_page	UK	2025-11-28	https://f4.bcbits.com/img/a2345778669_16.jpg	12.86	{Empires,"Like A Gunshot","Wired Feat. Nina","Particles Feat. D-Los","Particles (Instrumental)"}	5	00:23:12	https://whitepeach.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
295	Mechatronica	Constellations Vol. 3	https://mechatronica.bandcamp.com/album/constellations-vol-3?from=discover_page	Berlin, Germany	2026-01-24	https://f4.bcbits.com/img/a3535734205_16.jpg	39.00	{"Anthony Rother - Zombie Master","Credit 00 - Audio 2","Maelstrom - Wisely Moving Away","TaronX - 6433","Serge Geyzel & Dagga - Discotek My Brain","The Spy - Spider Formation"}	6	00:29:08	https://mechatronica.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
296	raster - artistic platform	Pounding	https://raster-raster.bandcamp.com/album/pounding?from=discover_page	Germany	2024-06-21	https://f4.bcbits.com/img/a1085294324_16.jpg	18.00	{"Evening News","Here We Go",Massenmedium,"Alright Tomorrow",Gojo,Orbit,Zone,"Dichte 9",Transit,Supermoon,Rapid}	11	00:41:53	https://raster-raster.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
297	Hania Rani	Nostalgia	https://haniarani.bandcamp.com/album/nostalgia?from=discover_page	Warsaw, Poland	2024-09-27	https://f4.bcbits.com/img/a0778341239_16.jpg	35.09	{"24.03 (Studio 1, Warsaw)","Thin Line (Studio 1, Warsaw)","Dancing with Ghosts (Studio 1, Warsaw)","The Boat (Studio 1, Warsaw)","It Comes in Waves (Studio 1, Warsaw)","Don't Break My Heart (Studio 1, Warsaw)","Komeda (Studio 1, Warsaw)","Utrata (Studio 1, Warsaw)","Nostalgia (Roundhouse, London)"}	9	01:00:28	https://haniarani.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
298	The Very Polish Cut Outs	Virtual Cuts	https://theverypolishcutouts.bandcamp.com/album/virtual-cuts?from=discover_page	Poland	2025-12-19	https://f4.bcbits.com/img/a0982623158_16.jpg	29.00	{"VRTUAL CUTS - INTRO (NO DIGITAL!!!!)"}	1	00:00:30	https://theverypolishcutouts.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
299	Moving Pressure	Moving Pressure 05	https://movingpressure.bandcamp.com/album/moving-pressure-05?from=discover_page	Lisbon, Portugal	2025-11-21	https://f4.bcbits.com/img/a1744578037_16.jpg	24.00	{"Memory Erased","Flinders Drive","I Need Air",Rush,Intuition,"Response Here","Empty Tank",Trapped}	8	00:47:53	https://movingpressure.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
300	Non Series	Memory Folds Inward	https://nonseries.bandcamp.com/album/memory-folds-inward?from=discover_page	Spain	2025-11-21	https://f4.bcbits.com/img/a2163287611_16.jpg	12.50	{Vertigo,Sinner,Pinger,Nulling,Unplace}	5	00:31:44	https://nonseries.bandcamp.com?from=discover_page	2026-02-23 13:22:19.593737	2026-02-23 13:22:19.593737
301	Abul Mogard	Quiet Pieces	https://abulmogard.bandcamp.com/album/quiet-pieces?from=discover_page	Italy	2025-05-30	https://f4.bcbits.com/img/a3076594762_16.jpg	26.00	{"Following a dream","Constantly slipping away","In a studded procession","Through whispers","Like a bird"}	5	00:39:03	https://abulmogard.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
302	Blutengel	Reich Mir Die Hand	https://blutengel.bandcamp.com/album/reich-mir-die-hand?from=discover_page	Berlin, Germany	2011-01-21	https://f4.bcbits.com/img/a3901029952_16.jpg	20.00	{"Reich Mir Die Hand","Reich Mir Die Hand (Remixed by Turnstyle & Fil Groth)","Reich Mir Die Hand (Fire-Eater Remix)",Insomnia}	4	00:19:40	https://blutengel.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
303	Intertoto	Siccar Point	https://intertoto.bandcamp.com/album/siccar-point?from=discover_page	London, UK	2026-02-13	https://f4.bcbits.com/img/a2999867557_16.jpg	25.74	{"Raw Lunar Concrete","Condor Launch","Cloud Chamber",Restore,"Fold (feat. Lablab)","Metallic Veins","Redox Dub",Foraber}	8	00:42:42	https://intertoto.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
304	M.O.O.N.	MOON EP	https://music.musicofthemoon.com/album/moon-ep?from=discover_page	Lisbon, Portugal	2011-11-27	https://f4.bcbits.com/img/a0265022005_16.jpg	15.00	{Paris,Crystals,Hydrogen,Release}	4	00:20:12	https://music.musicofthemoon.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
305	Loopaina	Angels Around Us [LPR-V005] Charity Release	https://loopainarecords.bandcamp.com/album/angels-around-us-lpr-v005-charity-release?from=discover_page		2025-12-19	https://f4.bcbits.com/img/a3190942660_16.jpg	24.79	{"Ricardo Garduno - Human After All","Biorc - Anestesia","Oscar Mulero - Untold","DSNGDMANN - Luca","Pyramidal Decode - Magma","Lakej - Minimally Conscious","KØLPØS - Zotak","Drucal - Grasp"}	8	00:45:57	https://loopainarecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
306	Hania Rani	On Giacometti	https://haniarani.bandcamp.com/album/on-giacometti?from=discover_page	Warsaw, Poland	2023-02-17	https://f4.bcbits.com/img/a0911442966_16.jpg	31.58	{Allegra,Spring,Stampa,Struggle,Morning,"In Between",Knots,Dreamy,Storm,Time,Mountains,Annette,Alberto}	13	00:42:08	https://haniarani.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
307	Oscar Mulero	Part of a physical creation - PoleGroup079	https://oscarmulero-oficial.bandcamp.com/album/part-of-a-physical-creation-polegroup079?from=discover_page	Spain	2025-12-19	https://f4.bcbits.com/img/a1457438581_16.jpg	12.50	{"The body","Like a black rainbow","Golden dome","Sacred place","A subtle physical sphere"}	5	00:25:46	https://oscarmulero-oficial.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
308	HARDLINE	HARDLINE14	https://hardlinesounds.bandcamp.com/album/hardline14?from=discover_page	Manchester, UK	2025-11-27	https://f4.bcbits.com/img/a2969712942_16.jpg	14.04	{Ghetto,Wicked,"Call Da Cops (feat. Whose Kru)",Clash}	4	00:21:19	https://hardlinesounds.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
309	Aniara Recordings	Aniara35: Earth Creatures	https://aniararecordings.bandcamp.com/album/aniara35-earth-creatures?from=discover_page	Sweden	2025-11-21	https://f4.bcbits.com/img/a1852677160_16.jpg	11.00	{"Earth Creatures","Your Planet","Drex Vibe","Apollo 11"}	4	00:23:55	https://aniararecordings.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
310	Apparat	A Hum Of Maybe	https://apparat-music.bandcamp.com/album/a-hum-of-maybe?from=discover_page	Berlin, Germany	2026-02-20	https://f4.bcbits.com/img/a1971940186_16.jpg	32.28	{Glimmerine,"A Slow Collision","Gravity Test","Apparat, KÁRYYN - Tilth","Hum Of Maybe","An Echo Skips A Name","Enough For Me",Lunes,Williamsburg,"Apparat, Bi Disc - Pieces, Falling",Recalibration,"An Echo Skips A Name (alternate take)"}	12	00:55:41	https://apparat-music.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
311	Sully	Model Collapse	https://sullyuk.bandcamp.com/album/model-collapse?from=discover_page	UK	2025-03-14	https://f4.bcbits.com/img/a2079884625_16.jpg	25.74	{"Model Collapse","The Wash"}	2	00:08:38	https://sullyuk.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
312	Tristan Allen	Osni the Flare	https://tristan-allen.bandcamp.com/album/osni-the-flare?from=discover_page	New York	2026-03-27	https://f4.bcbits.com/img/a2606492897_16.jpg	25.50	{"Osni Opening","Act I: Garden","Act I: Loon","Act II: Dragon","Act II: Pyre","Act III: Umbra","Act III: Rite","Act IV: Flood","Act IV: Everglow","Osni Closing"}	10	00:45:15	https://tristan-allen.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
313	VP	COSMOSIS	https://v-p-v-p-v-p.bandcamp.com/album/cosmosis?from=discover_page	Paris, France	2025-12-05	https://f4.bcbits.com/img/a3074952534_16.jpg	50.00	{underground,mountains,jungle,desert,grassland,oceans,"sky to atmos"}	7	00:37:44	https://v-p-v-p-v-p.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
314	soave	Notti Senza Fine	https://soave.bandcamp.com/album/notti-senza-fine?from=discover_page	Italy	2026-01-13	https://f4.bcbits.com/img/a4046051196_16.jpg	27.00	{"Tangeri, 400 Km. Nord","Honolulu, Vento Solare, 48°","Atollo Di Bikini, N. G. C. 313","Bombay, Tramonto, H. 19,40","Rotte Polari 1","Tijuana, Frontiera A Nord-Ouest","Al Hoceima 1943 (Calore)",Kabul-Febbre,"Rotte Polari 2"}	9	00:39:04	https://soave.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
315	HARDLINE	HARD37	https://hardlinesounds.bandcamp.com/album/hard37?from=discover_page	Manchester, UK	2025-12-11	https://f4.bcbits.com/img/a1043545563_16.jpg	14.04	{Skyline,"New Game","Stick & Twist","Like That","Get Personal"}	5	00:29:19	https://hardlinesounds.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
316	Mood Waves	CM006 // Rap Moods - DJ Tjizza - Nasty Tools EP [&Digital]	https://moodwaves.bandcamp.com/album/cm006-rap-moods-dj-tjizza-nasty-tools-ep-digital?from=discover_page	Berlin, Germany	2023-09-07	https://f4.bcbits.com/img/a3704029747_16.jpg	12.50	{"DJ Tjizza - Micro Twerker","DJ Tjizza - Rap House Jam"}	2	00:10:59	https://moodwaves.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
317	Pizza Hotline	DREAM SELECT	https://pizzahotline.bandcamp.com/album/dream-select?from=discover_page	London, UK	2025-10-31	https://f4.bcbits.com/img/a4221103051_16.jpg	26.91	{V-Rally,"LEVEL SELECT 2","DREAM SELECT","Nothing To Lose","Mrs Hotline",AIR,"DREAM ARENA"}	7	00:27:00	https://pizzahotline.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
318	SUNN O)))	sunn O)))	https://sunn.bandcamp.com/album/sunn-o-2?from=discover_page	Seattle, Washington	2026-04-03	https://f4.bcbits.com/img/a3577788719_16.jpg	30.60	{XXANN,"Does Anyone Hear Like Venom?","Butch's Guns",Mindrolling,"Everett Moses","Glory Black"}	6	01:19:37	https://sunn.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
319	Temple Of Void	The Crawl	https://templeofvoid.bandcamp.com/album/the-crawl?from=discover_page	Detroit, Michigan	2026-03-06	https://f4.bcbits.com/img/a3047357665_16.jpg	20.40	{"Poison Icon","Godless Cynic","The Crawl","A Dead Issue","Thy Mountain Eternal",Soulburn,"The Twin Stranger"}	7	00:41:29	https://templeofvoid.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
320	SUNN O)))	Eternity''s Pillars b/w Raise the Chalice & Reverential	https://sunn.bandcamp.com/album/eternitys-pillars-b-w-raise-the-chalice-reverential?from=discover_page	Seattle, Washington	2025-10-14	https://f4.bcbits.com/img/a3585267222_16.jpg	21.25	{"Eternity's Pillars","Raise the Chalice",Reverential}	3	00:29:42	https://sunn.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
321	noothgrush	Kashyyyk (30th Anniversary Edition)	https://noothgrush.bandcamp.com/album/kashyyyk-30th-anniversary-edition?from=discover_page	Oakland, California	2025-12-25	https://f4.bcbits.com/img/a1723720370_16.jpg	20.40	{Gage,Sith,"Jundland Wastes",Bric-a-Brac,"Imperial March / Alderaan",Dianoga,"Double Bock"}	7	00:38:37	https://noothgrush.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
649	The Allergies	Stanky Funk (feat. Bootie Brown)	https://theallergies.bandcamp.com/album/stanky-funk-feat-bootie-brown?from=discover_page	Bristol, UK	2023-03-31	https://f4.bcbits.com/img/a1597289103_16.jpg	10.52	{"Stanky Funk (feat. Bootie Brown)"}	1	00:04:05	https://theallergies.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
322	Blut Aus Nord	Ethereal Horizons	https://blutausnord.bandcamp.com/album/ethereal-horizons?from=discover_page	France	2025-11-28	https://f4.bcbits.com/img/a1084343345_16.jpg	32.99	{"Shadows Breathe First",Seclusion,"The Ordeal","The Fall Opens The Sky","What Burns Now Listens","Twin Suns Reverie","The End Becomes Grace"}	7	00:51:45	https://blutausnord.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
323	Grafjammer	Vuist & Bijl	https://grafjammer.bandcamp.com/album/vuist-bijl?from=discover_page	Utrecht, Netherlands	2026-01-10	https://f4.bcbits.com/img/a2453208607_16.jpg	10.00	{"Vuist & Bijl"}	1	00:04:17	https://grafjammer.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
324	bunsenburner	Reverie	https://bunsenburner.bandcamp.com/album/reverie?from=discover_page	Freiburg Im Breisgau, Germany	2026-01-09	https://f4.bcbits.com/img/a3272903985_16.jpg	29.00	{"Gleam Of The Goddess",Trigger,"Letting Go (softly)","Letting Go (hardly)",Catfight,"Golden Shower","Ballade Four","Dear Hollow",TORO,Triskaidekaphobie,"Zodiac Shit",Bagbak,"Waltz, alone"}	14	00:45:23	https://bunsenburner.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
325	Exhumed	Red Asphalt	https://exhumed.bandcamp.com/album/red-asphalt?from=discover_page	San Jose, California	2026-02-20	https://f4.bcbits.com/img/a0347787736_16.jpg	20.40	{"Unsafe At Any Speed","Red Asphalt","Shock Trauma",Shovelhead,"The Iron Graveyard","Crawling From the Wreckage","Signal Thirty","Death On Four Wheels",Symphorophilia,"The Fumes"}	10	00:36:36	https://exhumed.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
326	Edged Circle Productions	Between Two Worlds	https://edgedcircleproductions.bandcamp.com/album/between-two-worlds?from=discover_page	Vestland, Norway	2026-01-09	https://f4.bcbits.com/img/a2261083050_16.jpg	25.00	{"The Storm I Ride",Warriors,"Between Two Worlds",Battalions,Mountains,"Days of North Winds","Far Beyond the Quiet","Cursed We Are"}	8	00:42:38	https://edgedcircleproductions.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
327	LA JUNGLE	An Order Of Things	https://lajungle.bandcamp.com/album/an-order-of-things?from=discover_page	Mons, Belgium	2026-04-13	https://f4.bcbits.com/img/a1024256259_16.jpg	20.00	{"Witches Carousel","Jeddah Tower","Sad Hill Fire Wave",Sabertoother,"Damon Heart","Cowboy Ride","Evil Legs","Le Soleil","The Love And The Violence"}	9	00:42:05	https://lajungle.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
328	Coroner	Dissonance Theory (24-bit HD audio)	https://coronerofficial.bandcamp.com/album/dissonance-theory-24-bit-hd-audio?from=discover_page	Zürich, Switzerland	2025-10-17	https://f4.bcbits.com/img/a3943944147_16.jpg	25.99	{Oxymoron,Consequence,"Sacrificial Lamb","Crisium Bound",Symmetry,"The Law","Transparent Eye",Trinity,Renewal,Prolonging}	10	00:47:19	https://coronerofficial.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
329	Fuath	III	https://fuath.bandcamp.com/album/iii?from=discover_page	Scotland, UK	2026-01-02	https://f4.bcbits.com/img/a2963318046_16.jpg	29.25	{"The Cailleach","Embers of the Fading Age","Possessed by Starlight","The Sluagh"}	4	00:42:53	https://fuath.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
330	Dead And Dripping	Nefarious Scintillations	https://deadanddrippingus.bandcamp.com/album/nefarious-scintillations?from=discover_page		2025-11-28	https://f4.bcbits.com/img/a4251629301_16.jpg	16.99	{"Nefariously Scintillating through Vacant Galactic Reservoirs","Horrifying Glimpses Into Inconceivably Demented Cityscapes","Pestilent Hints of Darkened Malodorous Vibrations","Swollen Torsos Adorned with Pustulating Hexagonal Crania","Sickeningly Vague Anatomical Silhouettes","Spontaneous Recollections of Unwitnessable Atrocity","Seeping through Ancient Transdimensional Corridors","An Utterly Tenantless World of Aeons-Long Death"}	8	00:44:09	https://deadanddrippingus.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
331	Depravity	Bestial Possession	https://depravitydeath.bandcamp.com/album/bestial-possession?from=discover_page	Australia	2025-11-21	https://f4.bcbits.com/img/a0937345115_16.jpg	41.64	{"Engulfed in Agony","Eunuch Maker","Call to the Fallen","Awful Mangulation","Rot in the Pit","Aligned With Satan","Blinding Oblivion",Legacy,"Catastrophic Contagion"}	9	00:38:51	https://depravitydeath.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
332	Hedonist	SCAPULIMANCY	https://hedonistsl.bandcamp.com/album/scapulimancy?from=discover_page	British Columbia	2025-08-01	https://f4.bcbits.com/img/a3365500565_16.jpg	18.70	{"Execution Wheel",Heresy,Barbarian,"Abominated Void","Parasitic Realm",Scapulimancy,"Engines Of War",Cremator,Profanation,"Hidden Corpse"}	10	00:36:07	https://hedonistsl.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
333	New Age Doom	Angels Against Angels	https://newagedoom.bandcamp.com/album/angels-against-angels?from=discover_page	Vancouver, British Columbia	2026-03-06	https://f4.bcbits.com/img/a2754152648_16.jpg	27.00	{"Life on the Other Side Pt. 1","Life on the Other Side Pt. 2","Radio On","Angels Vs. Angels","One Heart","Time Gets So Hard","We're All The Same","Aetheopia Dub","Amaseganalo Pt. 1","Amaseganalo Pt. 2"}	10	00:40:45	https://newagedoom.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
334	Bloodywood	Nu Delhi	https://bloodywood.bandcamp.com/album/nu-delhi?from=discover_page	New Delhi, India	2025-03-21	https://f4.bcbits.com/img/a2421604142_16.jpg	23.80	{"Halla Bol",Hutt,Dhadak,"Bekhauf (feat. BABYMETAL)",Kismat,Daggebaaz,Tadka,"Nu Delhi"}	8	00:33:07	https://bloodywood.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
335	Nightfeeder	Split LP w/ Verdict	https://nightfeeder.bandcamp.com/album/split-lp-w-verdict?from=discover_page	Seattle, Washington	2025-12-24	https://f4.bcbits.com/img/a1131910662_16.jpg	17.00	{"Climbing the Walls","Dragged Beneath","Shit Filled Paddock","Life's Foul Pit","Cursed Ruins","Born to Suffer","The Terror Rises From the Grave","Launch Codes"}	8	00:17:10	https://nightfeeder.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
336	Blood Incantation	Absolute Elsewhere	https://bloodincantation.bandcamp.com/album/absolute-elsewhere?from=discover_page	Colorado	2024-10-04	https://f4.bcbits.com/img/a4024825693_16.jpg	121.99	{"The Stargate [Tablet I]","The Stargate [Tablet II]","The Stargate [Tablet III]","The Message [Tablet I]","The Message [Tablet II]","The Message [Tablet III]"}	6	00:43:43	https://bloodincantation.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
337	Avantgarde Music	The Outsider	https://avantgardemusic.bandcamp.com/album/the-outsider?from=discover_page	Italy	2026-01-30	https://f4.bcbits.com/img/a4198872583_16.jpg	39.00	{"Magick Triumph","Barrowgrim Asylum",Innigkeit,"The Interior Gates of the True Soul","The Pain Threshold","Where Sorrow Reigns"}	6	01:11:28	https://avantgardemusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
338	Strange Mono	Cemetery Hallucinations	https://strangemono.bandcamp.com/album/cemetery-hallucinations?from=discover_page	Philadelphia, Pennsylvania	2026-03-13	https://f4.bcbits.com/img/a3699724663_16.jpg	18.70	{"Wasted Burial","Drowned In Decomposed Remains","Terrors Of The Flesh","Consumed By Agony","Cemetery Hallucinations","Abnormal Profusion","The Pool",Cretin}	8	00:36:45	https://strangemono.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
339	Decipher	ΘΕΛΗΜΑ (Thelema)	https://decipherbm.bandcamp.com/album/thelema?from=discover_page	Greece	2026-03-20	https://f4.bcbits.com/img/a1721926918_16.jpg	23.79	{"Return to Naught","The Black March","Seven Scars","Bound to the Wheel","Hail Death","Towards Renaissance",Litany}	7	00:42:57	https://decipherbm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
340	Orbit Culture	Death Above Life (24-bit HD audio)	https://orbitculture.bandcamp.com/album/death-above-life-24-bit-hd-audio?from=discover_page	Eksjö, Sweden	2025-10-03	https://f4.bcbits.com/img/a0065751459_16.jpg	32.99	{Inferna,Bloodhound,"Inside the Waves","The Tales of War",Hydra,Nerve,"Death Above Life","The Storm","Neural Collapse","The Path I Walk"}	10	00:53:08	https://orbitculture.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
341	Predatory Void	Atoned In Metamorphosis	https://predatoryvoid.bandcamp.com/album/atoned-in-metamorphosis?from=discover_page	Ghent, Belgium	2026-02-06	https://f4.bcbits.com/img/a2517241693_16.jpg	20.00	{"Make Me Whole","New Moon","Peeling Cycle","Contemplation In Time"}	4	00:13:27	https://predatoryvoid.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
342	The Algorithm	Recursive Infinity	https://intothealgorithm.bandcamp.com/album/recursive-infinity?from=discover_page		2025-11-21	https://f4.bcbits.com/img/a2904101624_16.jpg	23.00	{"Race Condition","Advanced Evasion Technique","Endless Iteration","Graceful Degradation",Hollowing,"By Design","Rainbow Table",Mutex,"Recursive Infinity"}	9	00:43:07	https://intothealgorithm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
343	Veilburner	Longing for Triumph, Reeking of Tragedy	https://veilburnerband.bandcamp.com/album/longing-for-triumph-reeking-of-tragedy?from=discover_page		2025-11-14	https://f4.bcbits.com/img/a2702051770_16.jpg	41.64	{"Longing for Triumph...","Pestilent Niche","Rigor & Wraith","That Which Crypts Howls Grandeur","Da'ath Ye Shadow Portrait","Ouroboreal Whorl","Matter o' the Most Awful of Martyrs","...Reeking of Tragedy"}	8	00:51:51	https://veilburnerband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
344	Euclidean	Fosse	https://euclidean.bandcamp.com/album/fosse?from=discover_page	La Chaux De Fonds, Switzerland	2024-10-18	https://f4.bcbits.com/img/a3628550375_16.jpg	15.00	{"No Ear Can Hear Those Who Beseech","Never Witness Clarity","Nothing Discerned Therein"}	3	00:40:02	https://euclidean.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
345	20 Buck Spin	Carving the Causeway to the Otherworld	https://listen.20buckspin.com/album/carving-the-causeway-to-the-otherworld?from=discover_page	Pittsburgh, Pennsylvania	2026-02-20	https://f4.bcbits.com/img/a3661002551_16.jpg	22.94	{"Five Fifths Awaken","Carving the Causeway to the Otherworld","Adhradh Dé Ghoac","Caesar's Revelation (Hibernia L. VI V. XIV ad XVI et XXIV)","The Calling","Scythe of Saturn","Badhah's Shadows","Opening the Gates to Styx, Nix, Kerberos and Hydra"}	8	00:44:21	https://listen.20buckspin.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
346	Bolt Thrower	Realm of Chaos (Full Dynamic Range Edition)	https://bolt-thrower.bandcamp.com/album/realm-of-chaos-full-dynamic-range-edition?from=discover_page	Coventry, UK	1989-10-28	https://f4.bcbits.com/img/a4022766229_16.jpg	25.50	{Intro,"Eternal War","Through the Eye of Terror","Dark Millennium","All That Remains","Lost Souls Domain","Plague Bearer","World Eater","Drowned in Torment","Realm of Chaos","Prophet of Hatred",Outro}	12	00:38:01	https://bolt-thrower.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
347	REDIVIDER	SOUNDS OF MALICE	https://redividerdeathmetal.bandcamp.com/album/sounds-of-malice?from=discover_page	Louisville, Kentucky	2026-01-09	https://f4.bcbits.com/img/a2105569018_16.jpg	25.50	{"Quartered & Devoured","Sounds of Malice","Shackled to Existence","Apocalyptic Waste",Fratricide,"Bask in the Rot","Left to Rot"}	7	00:29:26	https://redividerdeathmetal.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
348	Temple Of Void	Summoning The Slayer	https://templeofvoid.bandcamp.com/album/summoning-the-slayer?from=discover_page	Detroit, Michigan	2022-06-03	https://f4.bcbits.com/img/a1894913995_16.jpg	22.10	{"Behind The Eye",Deathtouch,Engulfed,"A Sequence of Rot","Hex, Curse, & Conjuration","The Transcending Horror",Dissolution}	7	00:40:14	https://templeofvoid.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
349	Spaceslug	Time Travel Dilemma (Remastered)	https://spaceslug.bandcamp.com/album/time-travel-dilemma-remastered?from=discover_page	Wrocław, Poland	2025-12-05	https://f4.bcbits.com/img/a3955685965_16.jpg	26.35	{"Osiris (Remastered)","Living The Eternal Now (Remastered)","The Great Pylon Collider (Remastered)","Parahorizon (Remastered)","What Falls Is Fallen (Remastered)","Time Travel Dilemma (Remastered)"}	6	00:44:10	https://spaceslug.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
350	NECROPOLISSEBEHT	Taurunovem - Th’Astraktyan Serfdome	https://necropolissebeht.bandcamp.com/album/taurunovem-th-astraktyan-serfdome?from=discover_page	Germany	2026-02-20	https://f4.bcbits.com/img/a2025082388_16.jpg	20.00	{"Thorntrail to Goregotha",Necropolisabbath,"Ritual Genocide","THE AQUAMARINÆBYSS - Levitation of Cadaver Circuits in M-Orbit","Chamber of Chains","Iblian Koronation in th'Astraktryan Skullscapes of the Gehennial Flamefold","Numinoucidal War Winds","The Lower Circles","Welterer of Gethsemania"}	1	00:03:08	https://necropolissebeht.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
351	Eximperitus	Meritoriousness of Equanimity	https://eximperitus.bandcamp.com/album/meritoriousness-of-equanimity?from=discover_page	Minsk, Belarus	2026-01-30	https://f4.bcbits.com/img/a3713535161_16.jpg	25.50	{"One Step Long Infinity","Contemplation of the Plastic Fibers of Perfection at the Second Level of Reality","Twelve Centuries of Triumph of the Third Kingdom…","Finding Consistency in the Fourth Quadrant of Eternity","The Untimely Fruit of the Unsaid","Golden Chains for the Construction of Individual Greatness","Molecular Disintegration of an Unattainable Solitary Will in a Vessel of Wisdom...","Chalkionic Wandering Among the Wreckage of the Future","Standing at the Skirt of the Ruins of Human Nature (...on the Other Side of Man and Time)"}	9	00:33:54	https://eximperitus.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
352	In Mourning	The Immortal	https://inmourning.bandcamp.com/album/the-immortal?from=discover_page	Sweden	2025-08-29	https://f4.bcbits.com/img/a3868881222_16.jpg	26.90	{"The Immortal","Silver Crescent","Song of the Cranes","As Long as the Twilight Stays","The Sojourner","Moonless Sky",Staghorn,"North Star","The Hounding"}	9	00:47:14	https://inmourning.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
353	Scorching Tomb	Ossuary	https://scorchingtomb.bandcamp.com/album/ossuary?from=discover_page	Montreal, Québec	2025-10-24	https://f4.bcbits.com/img/a1671249259_16.jpg	20.00	{"Stalagmite Impalement","Skullcrush (feat. Devin Swank of Sanguisugabogg)","Diminished to Ashes","Sanctum of Bones (Ossuary)","Sentenced to Rot","Feel the Blade (feat. Primal Horde)","Bloodlust Sacrifice","Expired Existence"}	8	00:28:32	https://scorchingtomb.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
354	Avantgarde Music	Taetra Philosophia	https://avantgardemusic.bandcamp.com/album/taetra-philosophia?from=discover_page	Italy	2025-12-25	https://f4.bcbits.com/img/a1156993259_16.jpg	24.00	{"Deus Cornatus","Taetra Philosophia","Ambulacrum Luctus","Lumen ad Urnam","Corpus Mortuum","Speculum Fractum",Lamentum}	7	00:44:01	https://avantgardemusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
355	Avantgarde Music	Memorial	https://avantgardemusic.bandcamp.com/album/memorial?from=discover_page	Italy	2026-02-27	https://f4.bcbits.com/img/a1932858327_16.jpg	38.00	{"Ageless River X","After I’m Gone","When The Ashes Grow Cold","Ageless River XI",Memorial,"Ageless River XII","The River Wakes","Ageless River XIII"}	8	01:18:20	https://avantgardemusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
356	Agonia Records	The Illuminant	https://agoniarecords.bandcamp.com/album/the-illuminant?from=discover_page	Poland	2025-03-28	https://f4.bcbits.com/img/a2361015443_16.jpg	21.25	{Antichrist,"As Bestas","The Serpent And The Rod",Ichor,"Righteous Flama",Curse,"The Heavens Die","And All Is Prelude"}	8	00:39:06	https://agoniarecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
357	Sadness	I Want to Be There	https://sadnessmusic.bandcamp.com/album/i-want-to-be-there-2?from=discover_page		2019-09-28	https://f4.bcbits.com/img/a0690321680_16.jpg	25.00	{"In the Distant Travels","I Want to Be with You",Moments,"I want to Be There","You Dance Like the June Sky",Somewhere}	6	00:40:35	https://sadnessmusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
358	Darvaza	We Are Him	https://darvazablackmetal.bandcamp.com/album/we-are-him?from=discover_page	Italy	2025-12-05	https://f4.bcbits.com/img/a0169382824_16.jpg	23.00	{"Holy Blood","A Last Prayer In Gethsemane",Chaos.Fire.Devotion,Lazarus,"Blood Of No-One","Slaying Heaven",Darvaza}	7	00:42:21	https://darvazablackmetal.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
359	Blood Harvest	Visitations From Enceladus	https://bloodharvestrecords.bandcamp.com/album/visitations-from-enceladus?from=discover_page	Sweden	2020-05-04	https://f4.bcbits.com/img/a3952241168_16.jpg	235.00	{"Moonbelt Immolator","(Petrified in the) Hypogean Gaol","The Arctic Chasm","Planetary Hypnosis"}	4	00:46:34	https://bloodharvestrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
360	Eschaton	Techtalitarian	https://eschaton-label.bandcamp.com/album/techtalitarian?from=discover_page		2025-05-30	https://f4.bcbits.com/img/a4125951340_16.jpg	16.99	{"Inferior Superior","Devour the Contrarian","Blood of the People","Hellfire's Woe","The Bellicose Duality",Econocracy,Antimatter,Techtalitarian,"The Sufferer's Dichotomy","Castle Strnad"}	10	00:45:28	https://eschaton-label.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
361	Pelican	Ascending EP	https://pelican.bandcamp.com/album/ascending-ep?from=discover_page	Chicago, Illinois	2026-01-20	https://f4.bcbits.com/img/a2702429409_16.jpg	17.00	{Ascending,"Cascading Crescent (ft. Geoff Rickly)",Adrift,"Tending the Embers"}	4	00:22:25	https://pelican.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
362	Car Bomb	Tiles Whisper Dreams EP	https://carbomb.bandcamp.com/album/tiles-whisper-dreams-ep?from=discover_page	Brooklyn, New York	2025-08-01	https://f4.bcbits.com/img/a3906155046_16.jpg	17.00	{Blindsides,Paroxysm,"Tiles Whisper Dreams"}	3	00:11:56	https://carbomb.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
363	FUCKING KILL RECORDS	TRESPASSER - "יְהִי אוֹר"	https://fuckingkillrecords.bandcamp.com/album/trespasser?from=discover_page	Germany	2026-02-20	https://f4.bcbits.com/img/a3791137883_16.jpg	26.00	{"Prepare a Way","To the Congregations","Strong Wind Blows","White Water","With Fear and Great Joy","A Duty and an Honour","The Abomination of Desolation"}	7	00:31:41	https://fuckingkillrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
364	Between the Buried and Me	The Blue Nowhere (24-bit HD audio)	https://btbam.bandcamp.com/album/the-blue-nowhere-24-bit-hd-audio?from=discover_page	North Carolina	2025-09-12	https://f4.bcbits.com/img/a0023762103_16.jpg	48.99	{"Things We Tell Ourselves in the Dark","God Terror","Absent Thereafter",Pause,"Door #3","Mirador Uncoil",Psychomanteum,"Slow Paranoia","The Blue Nowhere","Beautifully Human"}	10	01:11:20	https://btbam.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
365	Worm	Necropalace (24-bit HD audio)	https://wormgloom.bandcamp.com/album/necropalace-24-bit-hd-audio?from=discover_page	Florida	2026-02-13	https://f4.bcbits.com/img/a2133041757_16.jpg	30.99	{"Gates to the Shadowzone (Intro)",Necropalace,"Halls of Weeping","The Night Has Fangs","Dragon Dreams",Blackheart,"Witchmoon: The Infernal Masquerade (feat. Marty Friedman)"}	7	01:02:50	https://wormgloom.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
366	Vígljós	𝓣𝓸𝓶𝓮 𝓘𝓘: 𝓲𝓰𝓷𝓲𝓼 𝓼𝓪𝓬𝓮𝓻	https://vigljos.bandcamp.com/album/--3?from=discover_page	Basel, Switzerland	2025-09-19	https://f4.bcbits.com/img/a0040124417_16.jpg	25.00	{𝓼𝓸𝔀𝓲𝓷𝓰,"𝓪 𝓼𝓮𝓮𝓭 𝓸𝓯 𝓪𝓫𝓮𝓻𝓻𝓪𝓽𝓲𝓸𝓷","𝓽𝓱𝓮 𝓻𝓸𝓽",𝓬𝓵𝓪𝓿𝓲𝓬𝓮𝓹𝓼,"𝓭𝓮𝓵𝓵𝓾𝓼𝓲𝓸𝓷𝓼 𝓸𝓯 𝓰𝓻𝓪𝓷𝓭𝓮𝓾𝓻","𝓭𝓮𝓬𝓪𝓭𝓮𝓷𝓬𝔂 𝓪𝓷𝓭 𝓭𝓮𝓰𝓮𝓷𝓮𝓻𝓪𝓽𝓲𝓸𝓷",𝓱𝓪𝓻𝓿𝓮𝓼𝓽,"𝓯𝓪𝓵𝓵𝓸𝔀 - 𝓪 𝓷𝓮𝔀 𝓬𝔂𝓬𝓵𝓮 𝓫𝓮𝓰𝓲𝓷𝓼"}	8	00:42:53	https://vigljos.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
367	Sun Guts	Kilonova	https://sunguts.bandcamp.com/album/kilonova?from=discover_page	New York, New York	2026-02-10	https://f4.bcbits.com/img/a4010765559_16.jpg	25.50	{Kilonova,"La Grande",Sphyxia,"Pyro Prosthetics","Through an Ocean of Keys",Motorbolt,Perpetuals,"Brute Force Defense",Silverdrone,"Slop Tactics","Exit Space"}	11	00:34:51	https://sunguts.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
368	Lychgate	Precipice	https://lychgate.bandcamp.com/album/precipice?from=discover_page	London, UK	2025-12-19	https://f4.bcbits.com/img/a1494175681_16.jpg	32.99	{"Introduction - The Sleeper Awakes","Mausoleum of Steel",Renunciation,"The Meeting of Orion and Scorpio","Hive of Parasites","Death’s Twilight Kingdom","Terror Silence",Anagnorisis,Pangaea}	9	00:47:47	https://lychgate.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
369	Fuath	I	https://fuath.bandcamp.com/album/i?from=discover_page	Scotland, UK	2016-02-01	https://f4.bcbits.com/img/a4113277168_16.jpg	29.25	{"In the Halls of the Hunter",Blood,"The Oracle","Spirit of the North"}	4	00:41:14	https://fuath.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
370	Rwake	The Return Of Magik	https://rwake.bandcamp.com/album/the-return-of-magik?from=discover_page	Little Rock, Arkansas	2025-03-14	https://f4.bcbits.com/img/a4142415823_16.jpg	25.50	{"You Swore We'd Always Be Together","The Return of Magik","With Stardust Flowers","Distant Constellations and the Psychedelic Incarceration","In After Reverse",Φ}	6	00:53:52	https://rwake.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
371	Abbie Falls	Life is just a temporary plan	https://abbiefallscz.bandcamp.com/album/life-is-just-a-temporary-plan?from=discover_page	Prague, Czechia	2025-12-12	https://f4.bcbits.com/img/a3088401663_16.jpg	20.00	{FURY,"Black Void",Victim,descend.exe,"Purge (feat. Breakdown of Sanity)","Anomaly in G minor (feat. Grapefruit Astronauts)","Chaos Disciples","Approach of the Second Sun",Hellbound,"unnatural order (feat. Alan Grnja of Distant)"}	10	00:33:04	https://abbiefallscz.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
372	Alcest	Écailles De Lune	https://alcest.bandcamp.com/album/cailles-de-lune?from=discover_page	Paris, France	2010-03-26	https://f4.bcbits.com/img/a3001297530_16.jpg	20.39	{"Écailles De Lune (Part I)","Écailles De Lune (Part II)","Percées De Lumière",Abysses,"Solar Song","Sur L'océan Couleur De Fer"}	6	00:41:43	https://alcest.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
373	Blood Red Throne	Siltskin	https://bloodredthrone.bandcamp.com/album/siltskin?from=discover_page	Norway	2025-12-05	https://f4.bcbits.com/img/a1613679298_16.jpg	20.00	{"Scraping Out The Cartilage","Beneath The Means","Husk In The Grain",Necrolysis,"Anodyne Rust","Vestigial Remnants","Vermicular Heritage","On These Bones","Marrow Of The Earth"}	9	00:45:26	https://bloodredthrone.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
374	Streams of Blood	Vermaledeit	https://streamsofblood.bandcamp.com/album/vermaledeit?from=discover_page	Germany	2025-12-18	https://f4.bcbits.com/img/a2913781427_16.jpg	22.94	{"Shitstained Cuirass","Paralyzed By Life","Der Körper Vergibt, Die Seele Nicht",E(r)gotism,Tötungsglas,"Fading Warmth (The End Of A Melancholic Summer)","Egocentric Pessimism"}	8	00:36:25	https://streamsofblood.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
375	Last Retch	Abject Cruelty	https://lastretch.bandcamp.com/album/abject-cruelty?from=discover_page	Hamilton, Ontario	2025-09-26	https://f4.bcbits.com/img/a1624980782_16.jpg	24.00	{"Abject Cruelty","Beasley Meth Merchants","Dissecting the Leper","In the Polder They Reek","Resinous Drip of Decay","Dissolved in Lye (Down to Rot)","Oozing Pustules","Gatling Gun"}	8	00:27:39	https://lastretch.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
376	Ara	Blutroter Mond	https://ara-iec.bandcamp.com/album/blutroter-mond?from=discover_page	Vienna, Austria	2024-02-05	https://f4.bcbits.com/img/a0142811635_16.jpg	20.00	{"Zur Hölle mich",Traum,Lucia,"Leuchtende Sterne","Mit pochendem Herz","Uns're Zeit ist um",Sommerwind,"Seltsames Ding"}	8	00:33:43	https://ara-iec.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
377	Zeal and Ardor	GREIF	https://zealandardor.bandcamp.com/album/greif?from=discover_page	New York, New York	2024-08-23	https://f4.bcbits.com/img/a2391873826_16.jpg	24.90	{"the Bird, the Lion and the Wildkin","Fend You Off",Kilonova,"are you the only one now?","Go home my friend","Clawing out",Disease,369,Thrill,"une ville vide",Sugarcoat,Solace,"Hide in Shade","to my ilk"}	14	00:42:37	https://zealandardor.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
378	Teitanblood	From the Visceral Abyss	https://teitanblood.bandcamp.com/album/from-the-visceral-abyss?from=discover_page	Spain	2025-03-28	https://f4.bcbits.com/img/a0586164783_16.jpg	18.33	{"Enter the Hypogeum","Sepulchral Carrion God","From the Visceral Abyss",Sevenhundreddogsfromhell,"Strangling Visions","And Darkness was All","Tomb Corpse Haruspex"}	7	00:51:58	https://teitanblood.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
379	Me Saco Un Ojo Records	Nocturnal Visions	https://mesacounojo.bandcamp.com/album/nocturnal-visions?from=discover_page	UK	2026-01-26	https://f4.bcbits.com/img/a3828211296_16.jpg	21.06	{Intro,"Abyssal Earth Eradicates","Altar of Devoted Slaughter","Lucid Dream Trauma","Persecution Madness","Dragged Beneath the Grave","Wandering Ashdream","Frozen Tomb","Nocturnal Visions"}	9	00:35:24	https://mesacounojo.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
380	Drudkh	Shadow Play	https://drudkh.bandcamp.com/album/shadow-play?from=discover_page	Харьков, Ukraine	2025-03-21	https://f4.bcbits.com/img/a3308045885_16.jpg	38.25	{"Scattering the Ashes",April,"The Exile","Fallen Blossom","The Eve","The Thirst"}	6	00:55:03	https://drudkh.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
381	Black Label Society	Doom Crew Inc.	https://blacklabelsocietyband.bandcamp.com/album/doom-crew-inc?from=discover_page	Los Angeles, California	2021-11-26	https://f4.bcbits.com/img/a2637974320_16.jpg	25.49	{"Set You Free","Destroy & Conquer","You Made Me Want to Live","Forever and a Day","End of Days",Ruins,Forsaken,"Love Reign Down","Gospel of Lies","Shelter Me","Gather all my Sins","Farewell Ballad"}	12	01:03:13	https://blacklabelsocietyband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
382	Vendetta Records	Fragments Of Pain	https://vendetta-records.bandcamp.com/album/fragments-of-pain?from=discover_page	Schorfheide, Germany	2025-11-28	https://f4.bcbits.com/img/a1998767391_16.jpg	16.00	{"Fragments Of Pain I","Fragments Of Pain II","Fragments Of Pain III"}	3	00:21:37	https://vendetta-records.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
383	Bolt Thrower	The IVth Crusade (Full Dynamic Range Edition)	https://bolt-thrower.bandcamp.com/album/the-ivth-crusade-full-dynamic-range-edition?from=discover_page	Coventry, UK	1992-09-02	https://f4.bcbits.com/img/a1448980405_16.jpg	21.25	{"The IVth Crusade",Icon,Embers,"Where Next to Conquer","As the World Burns","This Time It's War",Ritual,Spearhead,"Celestial Sanctuary","Dying Creed","Through the Ages (Outro)"}	11	00:53:30	https://bolt-thrower.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
384	Valdrin	Two Carrion Talismans	https://valdrin.bandcamp.com/album/two-carrion-talismans?from=discover_page	Cincinnati, Ohio	2018-09-28	https://f4.bcbits.com/img/a0102615988_16.jpg	17.00	{Junnatox,"Nex - The Barren Sculptor","Sinews Of Blood And Vein","Funeral Tides Of Orcus","Tempest Torn Asunder","Vesper in the Animus Lair","Crimson Blades In The Ausadjur Wake","Awaiting In The Spirit Genome..."}	8	00:43:22	https://valdrin.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
385	Dormant Ordeal	Tooth and Nail	https://dormantordeal.bandcamp.com/album/tooth-and-nail?from=discover_page	Kraków, Poland	2025-04-18	https://f4.bcbits.com/img/a1095179841_16.jpg	25.50	{"Wije i Mary, Pt. 1","Halo of Bones","Horse Eater",Orphans,Solvent,"Dust Crown","Against the Dying of the Light","Everything That Isn't Silence Is Trivial","Wije i Mary, Pt. 2"}	9	00:47:16	https://dormantordeal.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
386	Vendetta Records	Det Falmede Håb	https://vendetta-records.bandcamp.com/album/det-falmede-h-b?from=discover_page	Schorfheide, Germany	2025-09-05	https://f4.bcbits.com/img/a3993239850_16.jpg	19.00	{Intro,"Alt Vi Havde Kært","Forvitret Fortid","Det, Du Glemte","Solen Går I Hi","Uden Øjne"}	6	00:50:41	https://vendetta-records.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
387	Bindrune Recordings	What Remains When Hope Has Failed	https://bindrunerecordings.bandcamp.com/album/what-remains-when-hope-has-failed?from=discover_page	Traverse City, Michigan	2025-12-19	https://f4.bcbits.com/img/a0102413002_16.jpg	18.70	{"Nemorous - The Wyrm of the World's End","Nemorous - This Rotten Bough","Nemorous - Sky Avalanche","Nemorous - Quiescence","Nemorous - Bereft","Nemorous - What Remains When Hope Has Failed"}	6	00:42:59	https://bindrunerecordings.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
388	Haxprocess	Beyond What Eyes Can See	https://haxprocess-label.bandcamp.com/album/beyond-what-eyes-can-see?from=discover_page		2025-07-25	https://f4.bcbits.com/img/a0915377275_16.jpg	16.99	{"Where Even Stars Die","The Confines of the Flesh","Thy Inner Demon Seed","Sepulchral Void"}	4	00:44:50	https://haxprocess-label.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
389	GIANT	Beneath The Mountains	https://loreofgiants.bandcamp.com/album/beneath-the-mountains?from=discover_page	Melbourne, Australia	2026-01-07	https://f4.bcbits.com/img/a1598099404_16.jpg	50.00	{"Beneath The Mountains","Echoes Eternal","Lord Misery","Gods of Violence","The Fated Path"}	5	00:38:23	https://loreofgiants.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
390	Μνήμα	Disciples of Excremental Liturgies	https://mnima.bandcamp.com/album/disciples-of-excremental-liturgies?from=discover_page	Greece	2022-02-10	https://f4.bcbits.com/img/a1280527941_16.jpg	22.00	{"The Key of 1000 Spirits","Cosmic Lunacy","Disciples of Excremental Liturgies",Νεκροσάβανο,"Suicidal Necromancy","Abyssal Curses"}	6	00:35:21	https://mnima.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
391	Aara	Eiger	https://aara.bandcamp.com/album/eiger?from=discover_page	Switzerland	2024-12-06	https://f4.bcbits.com/img/a1564447780_16.jpg	32.99	{"Die das wilde Wetter fängt","Senkrechte Welten",Felsensang,Todesbiwak,"Der Wahnsinn dort im Abgrund","Zurück zur roten Fluh","Grausig ist der Blick",Alptraum}	8	00:55:26	https://aara.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
392	Vektor	Terminal Redux	https://vektor.bandcamp.com/album/terminal-redux?from=discover_page	Philadelphia, Pennsylvania	2016-05-06	https://f4.bcbits.com/img/a0144143476_16.jpg	20.40	{"Charging the Void","Cygnus Terminal","LCD (Liquid Crystal Disease)","Mountains Above the Sun","Ultimate Artificer",Pteropticon,Psychotropia,"Pillars of Sand",Collapse,"Recharging the Void"}	10	01:13:23	https://vektor.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
393	Cries of Agony	Cries of Agony	https://criesofagony.bandcamp.com/album/cries-of-agony?from=discover_page	Denton, Texas	2025-12-12	https://f4.bcbits.com/img/a2198380656_16.jpg	23.80	{"Ritual Hexxx","Magus ov Lilitu","Rites ov The Beheaded Jester","Succubi Seduktion (3:33am)","Rites ov the Absvrd Jester","The Vampyr Lovers","Dvngeon Fvneral","End ov Hvnger","Infinite Lucifer","A Peaceful Decay","Digital Grave","Dungeon Ravers Eulogy","Illusions ov Dismemberment","Ultimate Filth!","Siege Tower!!! (Curta'n Wall cover)"}	15	00:39:25	https://criesofagony.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
394	20 Buck Spin	Planetary Clairvoyance	https://listen.20buckspin.com/album/planetary-clairvoyance?from=discover_page	Pittsburgh, Pennsylvania	2019-07-19	https://f4.bcbits.com/img/a0983660702_16.jpg	22.94	{"Beg For Life","Planetary Clairvoyance (They Grow Inside Pt 2)","Phosphorene Ultimate","Infinite Resurrection","Accelerative Phenomenae","Cerulean Salvation","Heat Death"}	7	00:38:33	https://listen.20buckspin.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
395	SUNN O)))	Altar	https://sunn.bandcamp.com/album/altar-3?from=discover_page	Seattle, Washington	2006-10-23	https://f4.bcbits.com/img/a2428948666_16.jpg	17.00	{Etna,N.L.T.,"The Sinking Belle (Blue Sheep)","Akuma No Kuma","Fried Eagle Mind","The Sinking Belle (Black Sheep)","Blood Swamp","Her Lips Were Wet With Venom (SatanOscillateMyMetallicSonatas)"}	8	01:27:02	https://sunn.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
396	Vendetta Records	Disse Fugle Får Ingen At Se	https://vendetta-records.bandcamp.com/album/disse-fugle-f-r-ingen-at-se?from=discover_page	Schorfheide, Germany	2025-09-05	https://f4.bcbits.com/img/a0326252655_16.jpg	19.00	{"Retten Til Resterne",Træt,"1000 Kroppe","Disse Fugle Får Ingen At Se"}	4	00:46:09	https://vendetta-records.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
397	Amor Fati Productions	Osgraef - Reveries of the Arcane Eye	https://amorfatiproductions.bandcamp.com/album/osgraef-reveries-of-the-arcane-eye?from=discover_page	Germany	2025-03-23	https://f4.bcbits.com/img/a2929135843_16.jpg	22.00	{"Sekhem Apep - Vampyre's Enscription","Nox Luciferi, Liber Koth","Magick Wound (Slithering Omnipotence of Thoth)","Morbid Wretch - Reveries of the Arcane Eye","Flesh Insignia","Mystik Lore - Ancient Summoner of Osgraef"}	6	00:41:46	https://amorfatiproductions.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
398	Beverina	WITCHER - Öröklét (2025)	https://beverina.bandcamp.com/album/witcher-r-kl-t-2025?from=discover_page		2025-11-04	https://f4.bcbits.com/img/a3552302753_16.jpg	23.00	{"Örökség (Heritage)","Szélhozó (Windbringer)","Röghöz kötött (Soil-bound)","Öröklét (Eternity)","Piano Trio No. 2 - Andante con moto (Franz Schubert cover)"}	5	00:40:16	https://beverina.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
399	Sleep	Sleep''s Holy Mountain (Full Dynamic Range Edition)	https://sleep-band.bandcamp.com/album/sleeps-holy-mountain-full-dynamic-range-edition?from=discover_page	San Jose, California	1992-11-01	https://f4.bcbits.com/img/a0182002384_16.jpg	21.25	{Dragonaut,"The Druid","Evil Gypsy / Solomon's Theme","Some Grass",Aquarian,"Holy Mountain","Inside the Sun","From Beyond","Nain's Baptism"}	9	00:52:15	https://sleep-band.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
400	shoverec	yours, truly	https://shoverec.bandcamp.com/album/yours-truly?from=discover_page	Italy	2026-01-14	https://f4.bcbits.com/img/a3891297780_16.jpg	30.00	{"ciò che ho","canzone veloce N.",campane,"un solo concetto",sparta,"brevi considerazioni sulla possibilitá di comunicare","prospettive per il futuro",sbarre,bontá,"just (unrealesed)","blood is blood even if it looks like a smile","swallowing indigestible food","past is worse than a mutilated hand","M is for M is dead","i'll breath in the water",welcome,"tongue illustrations","kiss me goodbye","eat him! drink him!","a cake with a long long tail (wolf in modern fairytale part 1) + thanks god for blisters (wolf in modern fairytale part 2)"}	20	00:58:41	https://shoverec.bandcamp.com?from=discover_page	2026-02-23 13:22:19.617157	2026-02-23 13:22:19.617157
401	Imperialist	Prime	https://imperialistus.bandcamp.com/album/prime?from=discover_page		2025-09-05	https://f4.bcbits.com/img/a0225664566_16.jpg	16.99	{Starstorm,"Beneath The Sands Of Titan","Depravity Beheld","I A.M.","Heavens Sunder","Final Hours","Union Of The Swarm","Nocturnal Eon","A Ghost Abandoned"}	9	00:44:48	https://imperialistus.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
402	Hierarchies	Hierarchies	https://hierarchiesdm.bandcamp.com/album/hierarchies?from=discover_page		2025-01-17	https://f4.bcbits.com/img/a0545014743_16.jpg	16.99	{Entity,"Consecrate Phenomenon",Dimension,"Twilight Tradition",Abstract,"Complexity Parallels",Subtraction,Vultures}	8	00:46:10	https://hierarchiesdm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
403	Dark Descent Records	The Womb of the World	https://darkdescentrecords.bandcamp.com/album/the-womb-of-the-world?from=discover_page	Colorado	2025-11-10	https://f4.bcbits.com/img/a2926428882_16.jpg	22.10	{"So Spoke the Silent Stars","Slithering Serendipity","And You Shall Know Perdition as Your Shrine","The Womb of the World"}	4	00:50:18	https://darkdescentrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
404	VOID	Forbidden Morals	https://skrlabelvoid.bandcamp.com/album/forbidden-morals?from=discover_page	Lafayette, Louisiana	2025-08-29	https://f4.bcbits.com/img/a3541543568_16.jpg	21.25	{"A Curse","Forbidden Morals","Gateways of Stone","Judas Cradle","Nine Blood Moons",Valeria,Apparition,"By Silver Light","Return of the Phantom","Beneath... Lives the Impaler"}	10	00:45:48	https://skrlabelvoid.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
405	Primitive Man	Observance	https://primitivemandoom.bandcamp.com/album/observance?from=discover_page	Denver, Colorado	2025-10-31	https://f4.bcbits.com/img/a0634003591_16.jpg	25.50	{Seer,Devotion,Transactional,"Iron Sights","Natural Law","Social Contract",Water}	7	01:08:23	https://primitivemandoom.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
406	Folter Records	No Safe Place	https://folterrecords.bandcamp.com/album/no-safe-place?from=discover_page	Berlin, Germany	2025-12-18	https://f4.bcbits.com/img/a4049796700_16.jpg	22.00	{"No Safe Place",Attrition,"Homeland's Fury","Psalm for the Fallen","Maria Rosenthal","Journey Beyond Consciousness","End Humanism","The Call of the Night","Nice Death Matters"}	9	00:41:21	https://folterrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
407	Wytch Hazel	V: Lamentations	https://wytchhazel.bandcamp.com/album/v-lamentations?from=discover_page	Lancaster, UK	2025-07-04	https://f4.bcbits.com/img/a1080587281_16.jpg	27.20	{"I Lament","Run The Race","The Citadel",Elements,"The Demon Within","Racing Forwards",Elixir,Woven,"Heavy Load","Healing Power"}	10	00:45:09	https://wytchhazel.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
408	Ara	Mutterseelenallein und aus eigener Kraft	https://ara-iec.bandcamp.com/album/mutterseelenallein-und-aus-eigener-kraft?from=discover_page	Vienna, Austria	2025-06-12	https://f4.bcbits.com/img/a3950653203_16.jpg	21.95	{"Tief und Laut","Voller Last",Sexhexen,Leben,Ara,"Bei meinem Blut","Vollgesogen mit Blut",Mutterseelenallein}	8	00:38:04	https://ara-iec.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
409	Crypts of Despair	We Belong In The Grave	https://cryptsofdespairdeath.bandcamp.com/album/we-belong-in-the-grave?from=discover_page	Lithuania	2025-04-18	https://f4.bcbits.com/img/a2442101275_16.jpg	16.99	{"We Belong In The Grave","Terminal Dais","Obliteration Of The Impure","Expulsion To Purgatory",Undisillusioned,Seizures,Precipitous,"Gaze Of The Adversary","Burial Of The World"}	9	00:34:41	https://cryptsofdespairdeath.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
410	Final Gasp	New Day Symptoms	https://finalgasp.bandcamp.com/album/new-day-symptoms?from=discover_page	Boston, Massachusetts	2026-02-27	https://f4.bcbits.com/img/a1568662729_16.jpg	20.40	{"Eternal Silence","Look Away","The Apparition","Gifted Shame","No Hand To Lead",Prediction,"Burials Of Birth",Fractures,"New Day Symptoms","Pale Sun"}	10	00:31:51	https://finalgasp.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
411	Birds of Nazca	Pangaea	https://birdsofnazca.bandcamp.com/album/pangaea?from=discover_page	Nantes, France	2025-10-03	https://f4.bcbits.com/img/a4061373673_16.jpg	27.00	{Batagaïka,"Gang Rinpoché","Racetrack Playa","Man Pupu Nyor",Incahuasi,Riftus...,...Pangaea}	7	00:37:04	https://birdsofnazca.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
412	Perishing	Malicious Acropolis Unveiled	https://perishing.bandcamp.com/album/malicious-acropolis-unveiled?from=discover_page	Costa Rica	2025-10-17	https://f4.bcbits.com/img/a0497555232_16.jpg	16.99	{"Autolysis (I. Imago Fluidus Macula)","Autolysis (II. Fatum Cursed by Nature)","Castle of the Leached Body","Las Ruinas del Palacio","Osedax (Devoured by the Cavernous Worm)","Acropolis of Malignancy"}	6	00:45:02	https://perishing.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
413	GraveRipper	From Welkin to Tundra	https://graveripper.bandcamp.com/album/from-welkin-to-tundra?from=discover_page	Indianapolis, Indiana	2025-10-17	https://f4.bcbits.com/img/a4075615580_16.jpg	21.25	{"Welkin, Now Tundra","Bring Upon Pain",Hexenhammer,"Death's Cold Embrace","Sanctioned Slaughter","Hounds From Hell","New Gods, New Masters","...And Now It's Dark","Bullet Laden Crown","Burning Barren Plains"}	10	00:33:33	https://graveripper.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
415	Nomad War Machine and Susan Alcorn	Contra Madre	https://nomadwarmachineandsusanalcorn.bandcamp.com/album/contra-madre?from=discover_page	Philadelphia, Pennsylvania	2026-01-30	https://f4.bcbits.com/img/a3991427936_16.jpg	19.55	{Invocation,"Grotto That Returns the Echo of My Cry","Face of Unknown Stars","Those Who Do Not Dance","Boiling Vortex","The Shining Host","Contra Madre (digital-only)"}	7	00:50:54	https://nomadwarmachineandsusanalcorn.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
416	Greyhawk	Warriors Of Greyhawk	https://greyhawkmetal.bandcamp.com/album/warriors-of-greyhawk?from=discover_page	Seattle, Washington	2026-02-13	https://f4.bcbits.com/img/a3086075712_16.jpg	29.75	{Ascension,"Land Of Ashes","Take A Stand","Endless Race","Warriors Of Greyhawk","Words Of Power",Chosen,Hyperspace,"Embers Rise","Rise Above","Eternal Quest"}	11	00:49:43	https://greyhawkmetal.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
417	Vendetta Records	Vom Gipfel	https://vendetta-records.bandcamp.com/album/vom-gipfel?from=discover_page	Schorfheide, Germany	2025-10-17	https://f4.bcbits.com/img/a2994992508_16.jpg	16.00	{"Der Berg","Das Ende",-Rückkehr-}	3	00:18:37	https://vendetta-records.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
418	Thorn	Nebulous Womb of Eternity	https://thorndm.bandcamp.com/album/nebulous-womb-of-eternity?from=discover_page		2025-08-08	https://f4.bcbits.com/img/a4129272395_16.jpg	33.99	{"Ooze Maelstrom","Entombed in Chrysalis","Quartersawn Remains","Zombifying Mold","Haunting Gale","Gloaming Corporeal Form","Nebulous Womb of Eternity"}	7	00:36:58	https://thorndm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
419	Incinerated	Eaten Raw	https://incinerateddm.bandcamp.com/album/eaten-raw?from=discover_page	Melbourne, Australia	2025-08-30	https://f4.bcbits.com/img/a2170490446_16.jpg	40.00	{"Table Manners","Low In The Food Chain","The Feast Of Panzram","Human Cesspit","Foraging For Dignity","Get Back In One Piece","Plea Bargain","I Love Power Violence (Shank Cover)","Missing Persons","Skin Bucket","Conner Is A Cunt","Drop Ya Guts",Lacerated,"Beaten To Death In Your Hospital Bed","Blunt Amputation",Hunted,"Prime Meat (Bile Cover)","Chained In Cement","It's Just Cheese And Meat","Six Feet Chunder","Accelerate Death","Dug Up And Eaten Raw","Face In The Rotor",Binsteak,"Sleeping In The Wet Patch","Sad Old Wreck","Kicked Into Sterility","Lung Blower","Two Knuckles Deep","Pig Anus","Ketamine Kebab","Flagon Of Piss"}	32	00:39:15	https://incinerateddm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
420	20 Buck Spin	Aria Of Vernal Tombs	https://listen.20buckspin.com/album/aria-of-vernal-tombs-2?from=discover_page	Pittsburgh, Pennsylvania	2015-05-26	https://f4.bcbits.com/img/a2936586641_16.jpg	21.24	{"Ay que por muy gran fremosura","Autumnal Pyre","Until All Ages Fall","L'amour dont sui espris","Pools Of A Vernal Paradise","Anlace And Heart","The Anchoress's Orison","In The Absence Of Light",Wilweorthunga,"Des oge mais quer eu trobar","Orphic Rites Of The Mystic"}	11	00:44:18	https://listen.20buckspin.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
421	Ildaruni	Divinum Sanguinem	https://ildaruniblacklion.bandcamp.com/album/divinum-sanguinem?from=discover_page	Armenia	2025-11-07	https://f4.bcbits.com/img/a3549170730_16.jpg	21.99	{"Mithras Alone is My Wreath","The Ascension of Kosmokrator","Of Nomos and Flaming Flint Stone","Forged with Glaive and Blood","Zurvan Akrane","Arcane Sermon","Immersion into Empyrean","Scorching Pathways to Samachi","Divinum Sanguinem"}	9	00:52:41	https://ildaruniblacklion.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
422	Lowen	Do Not Go To War With The Demons Of Mazandaran	https://lowen.bandcamp.com/album/do-not-go-to-war-with-the-demons-of-mazandaran-2?from=discover_page	London, UK	2024-10-04	https://f4.bcbits.com/img/a3840398926_16.jpg	29.24	{"Corruption on Earth","Najang Bah Divhayeh Mazandaran","Waging War Against God","The Seed That Dreamed Of Its Own Creation","May Your Ghost Drink Pure Water","Ghazal For The Embrace Of Fire"}	6	00:36:53	https://lowen.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
423	Patristic	Catechesis	https://patristic.bandcamp.com/album/catechesis?from=discover_page	Rome, Italy	2025-06-20	https://f4.bcbits.com/img/a3878582857_16.jpg	19.55	{"A Vinculis Soluta I","A Vinculis Soluta II","Catechesis I","Catechesis II","Catechesis III","Catechesis IV"}	6	00:41:04	https://patristic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
424	Fleshbore	Painted Paradise	https://fleshboreband.bandcamp.com/album/painted-paradise?from=discover_page		2025-01-24	https://f4.bcbits.com/img/a0655342894_16.jpg	16.99	{"Setting Sun","The World","Target Fixation","Wandering Twilight",Inadequate,"The Ancient Knowledge","Painted Paradise","Laplace's Game"}	8	00:36:19	https://fleshboreband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
425	Tenebro	Tenebro - Una Lama d''Argento	https://tenebrohorror.bandcamp.com/album/tenebro-una-lama-dargento?from=discover_page	Italy	2025-12-12	https://f4.bcbits.com/img/a0034048462_16.jpg	24.00	{Inferno,"L’angelo Caduto Tra Le Luci Del Teatro",Impiccata,"Sangue Sui Muri","Lo Specchio… Omicida.","Il Corpo Come Spartito","Piume Rosse","Appare la Bambola, Poi La Lama","Larve Affamate","Nel Sonno Della Veggente",Jennifer}	11	00:41:03	https://tenebrohorror.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
426	Dark Descent Records	Gateway	https://darkdescentrecords.bandcamp.com/album/gateway?from=discover_page	Colorado	2025-11-28	https://f4.bcbits.com/img/a0608095997_16.jpg	22.10	{Deathless,Unbound,"Corridor I - The Affliction","Sempiternal Penance","Corridor II - The Descent","Beyond the Threshold of Flesh","Corridor III - The Void"}	7	00:35:22	https://darkdescentrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
427	TOWER	Let There Be Dark	https://towernyc.bandcamp.com/album/let-there-be-dark?from=discover_page	New York, New York	2025-03-21	https://f4.bcbits.com/img/a3481678606_16.jpg	19.00	{"Under The Chapel","Let There Be Dark","Holy Water","And I Cry","The Well of Souls","Book of the Hidden","Legio X Fretensis","Iron Clad","Don't You Say","The Hammer"}	10	00:39:32	https://towernyc.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
428	Noirsuaire	The Dragging Poison	https://noirsuaire.bandcamp.com/album/the-dragging-poison?from=discover_page	Montségur, France	2025-12-26	https://f4.bcbits.com/img/a0065585888_16.jpg	19.00	{"Intro -Thousands Throats Thousands Spears","The Trance Of Bedless Bones","Fogged By The Leaves Of Pestilence (feat BST)","The Dragging Poison","Possessed By A Malignant Lust","Interlude - Withering Veins (feat Mildrac)","Enshrouded In Rabid Repugnance","Sworn By Sinister Wisdom",Noirsuaire}	9	00:35:47	https://noirsuaire.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
429	HADOPELAGYAL	Haematophoryktos (Album)	https://hadopelagyal.bandcamp.com/album/haematophoryktos-album?from=discover_page	Germany	2025-09-19	https://f4.bcbits.com/img/a1072535136_16.jpg	22.00	{Swarthseleniasmos,"Promulgating Haematekchysia","Litany of Saltridden Exudate under Theosechtrian Tides","Amidst Unending Twilights, Unheeded, Bearing neither Lustre nor Name","Invocation of Abomination’s Excrements","Stampede of Exsanguinated Stygian Hordes","Crimson Gleamed the Augural Maw","Halios Enthroned in Hyperdiluvian Kataklysmos"}	8	00:44:52	https://hadopelagyal.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
430	deary	Birding	https://deary.bandcamp.com/album/birding?from=discover_page	London, UK	2026-04-03	https://f4.bcbits.com/img/a1149880666_16.jpg	26.90	{Smile,Seabird,"Baby's Breath",Gypsophila,"Blue Ribbon","Garden Of Eden",Alma,"No Sweeter Feeling","Terra Fable",Alfie,Birding}	11	00:43:15	https://deary.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
431	SAULT	Chapter 1	https://saultglobal.bandcamp.com/album/chapter-1?from=discover_page	UK	2026-01-09	https://f4.bcbits.com/img/a2133191573_16.jpg	35.10	{"God, Protect Me From My Enemies","Chapter 1","Fulfil Your Spirit",Protector,"Good Things Will Come After The Pressure","Create Your Prophecy","Love Does Not Equal Pain","Lord Have Mercy","Don't Worry About What You Can't Control",Puppet}	10	00:36:27	https://saultglobal.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
432	Kim Gordon	PLAY ME	https://kimgordon.bandcamp.com/album/play-me?from=discover_page	New York, New York	2026-03-13	https://f4.bcbits.com/img/a0696204821_16.jpg	23.39	{"PLAY ME","GIRL WITH A LOOK","NO HANDS","BLACK OUT","DIRTY TECH","NOT TODAY","BUSY BEE","SQUARE JAW",SUBCON,"POST EMPIRE","NAIL BITER",BYEBYE25!}	12	00:29:59	https://kimgordon.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
433	Sleaford Mods	The Demise of Planet X	https://sleafordmods.bandcamp.com/album/the-demise-of-planet-x?from=discover_page	UK	2026-01-16	https://f4.bcbits.com/img/a0087899065_16.jpg	21.66	{"The Good Life feat. Gwendoline Christie & BIG SPECIAL","Double Diamond","Elitest G.O.A.T feat. Aldous Harding",Megaton,"No Touch feat. Sue Tompkins","Bad Santa","The Demise of Planet X","Don Draper","Gina Was","Shoving the Images","Flood the Zone feat. Liam Bailey","Kill List feat. Snowy","The Unwrap"}	13	00:41:36	https://sleafordmods.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
434	Cameron Winter	Heavy Metal	https://cameronwinter.bandcamp.com/album/heavy-metal?from=discover_page	New York, New York	2024-12-06	https://f4.bcbits.com/img/a2926452844_16.jpg	21.25	{"The Rolling Stones","Nausicaä (Love Will Be Revealed)","Love Takes Miles","Drinking Age","Cancer of the Skull","Try as I May","We’re Thinking the Same Thing","Nina + Field of Cops",$0,"Can’t Keep Anything"}	10	00:43:50	https://cameronwinter.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
435	José González	Against the Dying of the Light	https://josgonzlez.bandcamp.com/album/against-the-dying-of-the-light?from=discover_page	Sweden	2026-03-27	https://f4.bcbits.com/img/a0185547224_16.jpg	30.00	{"A Perfect Storm",Etyd,"Against the Dying of the Light","For Every Dusk",Sheet,Pajarito,"Losing Game (Sick)","Ay Querida","U - Rawls slöja",Gymnasten,"Just a Rock","You & We","Joy (Can't Help But Sing)"}	13	00:45:22	https://josgonzlez.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
436	Ora Cogan	Hard Hearted Woman	https://oracogan.bandcamp.com/album/hard-hearted-woman?from=discover_page		2026-03-13	https://f4.bcbits.com/img/a3556126725_16.jpg	20.40	{Honey,"The Smoke",Division,"Bury Me",Limits,"Love You Better","River Rise","Believe in the Devil",Outgrowing,"Too Late"}	10	00:37:22	https://oracogan.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
437	LYR	Dark Sky Reservation	https://lyrband.bandcamp.com/album/dark-sky-reservation?from=discover_page	UK	2026-04-03	https://f4.bcbits.com/img/a2972873955_16.jpg	24.37	{"Dark Sky Reservation","A Walled Garden","Blah! Blah! Blah!","Pray Silence","Where Have You Been All My Life?","French Cursive","Guernica Jigsaw",Eclipse,"The Goldilocks Zone","Sirius Alpha, Sirius Beta","Under Artificial Lighting","Collared Dove"}	12	00:43:26	https://lyrband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
438	Brigitte Calls Me Baby	Irreversible	https://brigittecallsmebaby.bandcamp.com/album/irreversible?from=discover_page	Chicago, Illinois	2026-03-13	https://f4.bcbits.com/img/a2184177934_16.jpg	19.55	{"There's Always","Slumber Party","I Danced With Another Love In My Dream","The Pit","Truth is Stranger Than Fiction","These Acts Of Which Were Designed",Sillage,"I Can't Have You All To Myself","I Can Take the Sun Out of the Sky","The Early Days Of Love","Send Those Memories"}	11	00:38:44	https://brigittecallsmebaby.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
439	Kishi Bashi	Sonderlust (10th Anniversary Edition)	https://kishibashi.bandcamp.com/album/sonderlust-10th-anniversary-edition?from=discover_page	Athens, Georgia	2026-02-27	https://f4.bcbits.com/img/a0509280108_16.jpg	27.20	{m'lover,"Hey Big Star","Say Yeah","Can't Let Go, Juno","Ode to My Next Life","Who'd You Kill","Statues in a Gallery","Why Don't You Answer Me","Flame on Flame (a Slow Dirge)",Honeybody,"Comin' To You","Harpsi Chords","m'Lover (Demo-arigato Version)","Hey Big Star (Demo-arigato Version","Say Yeah (Demo-arigato Version)","Can't Let Go, Juno (Demo-arigato Version)","Ode to My Next Life (Demo-arigato Version)","Who'd You Kill (Demo-arigato Version)","Statues in a Gallery (Demo-arigato Version)","Why Don't You Answer Me (Demo-arigato Version)","Flame on Flame (a Slow Dirge) (Demo-arigato Version)","Honeybody (Demo-arigato Version)"}	22	01:20:56	https://kishibashi.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
440	cult of dom keller	Unholy Drum	https://thecultofdomkeller.bandcamp.com/album/unholy-drum?from=discover_page	UK	2026-03-27	https://f4.bcbits.com/img/a3011650744_16.jpg	26.90	{"Live Without life","Let Me Go, Satan",Disappear,B(o)ing,"Leaders With Hooves","Void Horizon","Shoot My Mind","They Cut The Heart From Out Of The Sky","Galaxies SOS"}	9	00:42:42	https://thecultofdomkeller.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
441	Charlotte Cornfield	Hurts Like Hell	https://charlottecornfield.bandcamp.com/album/hurts-like-hell?from=discover_page		2026-03-27	https://f4.bcbits.com/img/a2106657195_16.jpg	22.08	{Before,"Hurts Like Hell","Lost Leader",Lucky,"Living With It",Number,Squiddd,Kitchen,"Long Game","Bloody and Alive"}	10	00:34:21	https://charlottecornfield.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
442	Iron & Wine	Hen''s Teeth	https://ironandwine.bandcamp.com/album/hens-teeth?from=discover_page	North Carolina	2026-02-27	https://f4.bcbits.com/img/a3976857768_16.jpg	19.55	{Roses,"Paper and Stone","Robin's Egg (feat. I'm With Her)","Singing Saw","In Your Ocean","Defiance, Ohio","Wait Up (feat. I'm With Her)","Grace Notes","Dates and Dead People","Half Measures"}	10	00:39:24	https://ironandwine.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
443	Robyn Hitchcock	Globe of Frogs (2026 REMASTER)	https://robynhitchcockofficial.bandcamp.com/album/globe-of-frogs-2026-remaster?from=discover_page	London, UK	2026-01-09	https://f4.bcbits.com/img/a0617660655_16.jpg	28.05	{"Tropical Flesh Mandala",Vibrating,"Balloon Man","Luminous Rose","Sleeping With Your Devil Mask",Unsettled,"Chinese Bones","A Globe of Frogs","The Shapes Between Us Turn Into Animals","Flesh Number One (Beatle Dennis)"}	10	00:36:52	https://robynhitchcockofficial.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
444	Mediæval Bæbes	The Spinning Wheel	https://mediaevalbaebes.bandcamp.com/album/the-spinning-wheel?from=discover_page	London, UK	2025-12-05	https://f4.bcbits.com/img/a0719371397_16.jpg	29.25	{January,February,March,April,May,June,July,August,September,October,November,December}	12	00:44:02	https://mediaevalbaebes.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
445	Wet Leg	moisturizer	https://wetleg.bandcamp.com/album/moisturizer?from=discover_page	England, UK	2025-07-11	https://f4.bcbits.com/img/a1814951076_16.jpg	29.99	{CPR,liquidize,"catch these fists","davina mccall","jennifer's body",mangetout,"pond song",pokemon,"pillow talk","don’t speak",11:21,"u and me at home"}	12	00:38:27	https://wetleg.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
446	Ásgeir	Julia	https://asgeirtrausti.bandcamp.com/album/julia?from=discover_page	Iceland	2025-12-13	https://f4.bcbits.com/img/a0099603791_16.jpg	29.24	{"Quiet Life","Against The Current",Smoke,"Ferris Wheel","Universe Beyond",Julia,"Sugar Clouds",Stranger,"In The Wee Hours","Into The Sun"}	10	00:37:48	https://asgeirtrausti.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
447	Lifeguard	Ultra Violence	https://lifeguardband100.bandcamp.com/album/ultra-violence?from=discover_page	Chicago, Illinois	2025-11-19	https://f4.bcbits.com/img/a0289887829_16.jpg	11.69	{"Ultra Violence"}	1	00:03:24	https://lifeguardband100.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
448	they are gutting a body of water	LOTTO	https://theyareguttingabodyofwater.bandcamp.com/album/lotto?from=discover_page	Philadelphia, Pennsylvania	2025-10-17	https://f4.bcbits.com/img/a1665948047_16.jpg	20.40	{"the chase","sour diesel",trainers,"chrises head","rl stine","slo crostic","violence iii","american food","baeside k",herpim}	10	00:27:49	https://theyareguttingabodyofwater.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
449	Igorrr	Amen	https://igorrr.bandcamp.com/album/amen?from=discover_page	France	2025-09-19	https://f4.bcbits.com/img/a1755448576_16.jpg	21.90	{Daemoni,Headbutt,Limbo,"Blastbeat Falafel",ADHD,2020,"Mustard Mucous",Infestis,"Ancient Sun","Pure Disproportionate Black and White Nihilism","Étude n°120",Silence}	12	00:44:14	https://igorrr.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
450	Pullman	III	https://pullman.bandcamp.com/album/iii?from=discover_page		2026-01-09	https://f4.bcbits.com/img/a0312672621_16.jpg	17.85	{Bray,Weightless,Thirteen,October,Valence,Kabul}	6	00:35:09	https://pullman.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
451	Anjimile	You’re Free to Go	https://anjimile.bandcamp.com/album/you-re-free-to-go?from=discover_page	Durham, North Carolina	2026-03-13	https://f4.bcbits.com/img/a1238971338_16.jpg	18.77	{"You're Free to Go","Rust & Wire","Waits for Me","Like You Really Mean It","Turning Away","Exquisite Skeleton","The Store","Ready or Not","Point of View",Afarin,"Destroying You",Enough}	12	00:34:54	https://anjimile.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
452	Throwing Muses	Moonlight Confessions	https://throwingmuses.bandcamp.com/album/moonlight-confessions?from=discover_page	Rhode Island	2025-03-03	https://f4.bcbits.com/img/a1031900021_16.jpg	25.74	{"Summer Of Love (Moonlight Confessions Version)","South Coast (Moonlight Confessions Version)","Theremini (Moonlight Confessions Version)","Libretto (Moonlight Confessions Version)","Albatross (Moonlight Confessions Version)","Sally's Beauty (Moonlight Confessions Version)","Drugstore Drastic (Moonlight Confessions Version)","You're Clouds (Moonlight Confessions Version)","Moonlight Concessions (Moonlight Confessions Version)"}	9	00:28:25	https://throwingmuses.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
453	Some Bizzare Records	Scatology	https://somebizzarerecords.bandcamp.com/album/scatology?from=discover_page	UK	2025-12-15	https://f4.bcbits.com/img/a0422238403_16.jpg	29.24	{"Ubu Noir",Panic,"At The Heart Of It All","Tenderness of Wolves","The Spoiler",Clap,"Aqua Regis","Restless Day","Solor Lodge","The S.W.B.P","Godhead Deathead","Cathedral In Flames","Tainted Love"}	13	00:55:08	https://somebizzarerecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
454	Drifting Clouds	Bawuypawuy - Original Mix/Extended Dub	https://dddriftingcloudsss.bandcamp.com/album/bawuypawuy-original-mix-extended-dub?from=discover_page	Gapuwiyak, Australia	2025-12-17	https://f4.bcbits.com/img/a3128394838_16.jpg	30.00	{"Bawuypawuy (Original Mix)","Bawuypawuy (Harvey Sutherland's Extended Dub)"}	2	00:15:46	https://dddriftingcloudsss.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
455	gladie	No Need To Be Lonely	https://gladie.bandcamp.com/album/no-need-to-be-lonely?from=discover_page	Philadelphia, Pennsylvania	2026-03-20	https://f4.bcbits.com/img/a2650181018_16.jpg	21.25	{"Push Me Down","Brace Yourself","Car Alarm","Talk Past Each Other","I Want That For You","Fix Her",Poison,"Lucky For Another","I Will If You Will","Future Spring",Blurry,Unfolding}	12	00:38:10	https://gladie.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
456	MEMORIALS	All Clouds Bring Not Rain	https://memorialsmusic.bandcamp.com/album/all-clouds-bring-not-rain?from=discover_page	Canterbury, UK	2026-03-27	https://f4.bcbits.com/img/a1836493075_16.jpg	28.08	{"Life Could Be a Cloud","Cut Glass Hammer","I Can't See A Rainbow","Dropped Down The Well","In The Weeds","Reimagined River","Mediocre Demon","Bell Miner","Lemon Trees","Watching The Moon","Wildly Remote","Holy Invisible"}	12	00:49:49	https://memorialsmusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
457	Geordie Greep	The New Sound	https://geordiegreep.bandcamp.com/album/the-new-sound?from=discover_page	London, UK	2024-10-04	https://f4.bcbits.com/img/a0536681759_16.jpg	29.24	{Blues,Terra,"Holy, Holy","The New Sound","Walk Up","Through a War","Bongo Season",Motorbike,"As if Waltz","The Magician","If You Are But a Dream"}	11	01:02:59	https://geordiegreep.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
458	Water From Your Eyes	It''s A Beautiful Place	https://waterfromyoureyes.bandcamp.com/album/its-a-beautiful-place?from=discover_page	Brooklyn, New York	2025-08-22	https://f4.bcbits.com/img/a0209688797_16.jpg	23.39	{"One Small Step","Life Signs","Nights in Armor","Born 2","You Don't Believe in God?",Spaceship,"Playing Classics","It's a Beautiful Place","Blood on the Dollar","For Mankind"}	10	00:29:11	https://waterfromyoureyes.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
459	Twenty One Children	After The Storm	https://twentyonechildren.bandcamp.com/album/after-the-storm?from=discover_page	Soweto, South Africa	2025-12-05	https://f4.bcbits.com/img/a1884620456_16.jpg	17.00	{"Thulas Reborn Skit","Life Thing","Abdula Rebirth Skit","Fine Wine",99,SCAB,"Rain Dance","Kasi Ghost Stories"}	8	00:18:49	https://twentyonechildren.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
460	black midi	Schlagenheim	https://bmblackmidi.bandcamp.com/album/schlagenheim?from=discover_page	London, UK	2019-06-21	https://f4.bcbits.com/img/a2743601976_16.jpg	20.21	{953,Speedway,Reggae,"Near DT, MI",Western,"Of Schlagenheim",bmbmbm,"Years Ago",Ducter}	9	00:43:15	https://bmblackmidi.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
461	SAULT	10	https://saultglobal.bandcamp.com/album/10-2?from=discover_page	UK	2025-04-19	https://f4.bcbits.com/img/a2767522291_16.jpg	29.25	{T.H.,R.L.,K.T.Y.W.S.,P.,I.L.T.S.,L.U.,S.I.T.L.,H.T.T.R.,W.A.L.,S.O.T.H.}	10	00:43:16	https://saultglobal.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
462	Aukai	Chambers	https://aukai.bandcamp.com/album/chambers?from=discover_page	Durango, Colorado	2026-03-01	https://f4.bcbits.com/img/a3589628358_16.jpg	20.00	{Tierra,Waterlight,"Raíces al Viento",Yobue,Aleteas,"Get To Live Again",Scent,Lure,Held,Vulture,"Las Lluvias"}	11	00:36:54	https://aukai.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
463	Horsegirl	Phonetics On and On	https://thisishorsegirl.bandcamp.com/album/phonetics-on-and-on?from=discover_page	Brooklyn, New York	2025-02-14	https://f4.bcbits.com/img/a3935950205_16.jpg	23.39	{"Where'd You Go?","Rock City","In Twos",2468,"Well I Know You're Shy",Julie,"Switch Over","Information Content",Frontrunner,"Sport Meets Sound","I Can't Stand To See You"}	11	00:37:47	https://thisishorsegirl.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
464	Ichiko Aoba	Luminescent Creatures	https://ichikoaoba.bandcamp.com/album/luminescent-creatures-2?from=discover_page	Tokyo, Japan	2025-02-28	https://f4.bcbits.com/img/a0232619269_16.jpg	5500.00	{COLORATURA,"24° 3′ 27.0″ N, 123° 47′ 7.5″ E",mazamun,tower,aurora,FLAG,Cochlea,Luciférine,pirsomnia,SONAR,"惑星の泪 (Wakusei no Namida)"}	11	00:35:46	https://ichikoaoba.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
465	Buck Meek	The Mirror	https://buckmeek.bandcamp.com/album/the-mirror?from=discover_page	Brooklyn, New York	2026-02-27	https://f4.bcbits.com/img/a3916470919_16.jpg	19.49	{Gasoline,"Pretty Flowers","Can I Mend It?","Ring Of Fire",Demon,"God Knows Why","Heart In The Mirror",Worms,"Soul Feeling","Deja Vu","Outta Body"}	11	00:39:58	https://buckmeek.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
466	SAULT	5	https://saultglobal.bandcamp.com/album/5?from=discover_page	UK	2019-05-05	https://f4.bcbits.com/img/a1929582517_16.jpg	29.25	{"Up All Night","Don't Waste My Time","Foot on Necks","Why Why Why Why Why","Pink Sands","Let Me Go",Masterpiece,"Add A Little Bit of SAULT","Something's In The Air","Think About It","Wild Hundreds Pt. 5","We Are the Sun","Wild Hundreds Pt. 55",B.A.B.E}	14	00:41:47	https://saultglobal.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
467	Saya Gray	SAYA	https://sayagray.bandcamp.com/album/saya?from=discover_page	London, UK	2025-02-21	https://f4.bcbits.com/img/a4023870095_16.jpg	28.08	{"..THUS IS WHY ( I DON’T SPRING 4 LOVE )","SHELL ( OF A MAN )","LINE BACK 22","PUDDLE ( OF ME )","HOW LONG CAN YOU KEEP UP A LIE?","CATS CRADLE!","10 WAYS ( TO LOSE A CROWN )",H.B.W,"EXHAUST THE TOPIC","LIE DOWN.."}	10	00:39:14	https://sayagray.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
468	Black Country, New Road	Forever Howlong	https://blackcountrynewroad.bandcamp.com/album/forever-howlong?from=discover_page	London, UK	2025-04-04	https://f4.bcbits.com/img/a2991836176_16.jpg	39.70	{Besties,"The Big Spin",Socks,"Salem Sisters","Two Horses",Mary,"Happy Birthday","For the Cold Country","Nancy Tries to Take the Night","Forever Howlong","Goodbye (Don’t Tell Me)"}	11	00:52:15	https://blackcountrynewroad.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
469	Mei Semones	Animaru	https://meisemones.bandcamp.com/album/animaru?from=discover_page	Brooklyn, New York	2025-05-02	https://f4.bcbits.com/img/a3543886199_16.jpg	21.25	{"Dumb Feeling",Dangomushi,"Tora Moyo","I can do what I want",Animaru,Donguri,"Norwegian Shag","Rat with Wings",Zarigani,"Sasayaku Sakebu"}	10	00:37:54	https://meisemones.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
470	TFS	Fairyland Codex	https://tropicalfstorm.bandcamp.com/album/fairyland-codex?from=discover_page	Melbourne, Australia	2025-06-20	https://f4.bcbits.com/img/a2644629526_16.jpg	40.95	{"Irukandji Syndrome","Goon Show","Stepping On A Rake","Teeth Marché","Fairyland Codex","Dunning Kruger's Loser Cruiser",Bloodsport,"Joe Meek Will Inherit the Earth","Bye Bye Snake Eyes",Moscovium}	10	00:50:42	https://tropicalfstorm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
471	Wet Leg	Wet Leg	https://wetleg.bandcamp.com/album/wet-leg?from=discover_page	England, UK	2022-04-08	https://f4.bcbits.com/img/a2623916533_16.jpg	30.00	{"Being In Love","Chaise Longue",Angelica,"I Don't Wanna Go Out","Wet Dream",Convincing,"Loving You","Ur Mum","Oh No","Piece Of Shit",Supermarket,"Too Late Now"}	12	00:36:53	https://wetleg.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
500	Shaking Hand	Shaking Hand	https://shakinghandband.bandcamp.com/album/shaking-hand?from=discover_page	Manchester, UK	2026-01-16	https://f4.bcbits.com/img/a1359376198_16.jpg	25.74	{Sundance,Mantras,"In For A... Pound!","Night Owl","Up The Ante(lope)",Italics,"Cable Ties"}	7	00:41:59	https://shakinghandband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
472	Neutral Milk Hotel	In the Aeroplane Over the Sea	https://neutralmilkhotel.bandcamp.com/album/in-the-aeroplane-over-the-sea?from=discover_page		1998-02-20	https://f4.bcbits.com/img/a0307642145_16.jpg	16.13	{"King of Carrot Flowers Pt. 1","King of Carrot Flowers Pts. 2 & 3","In the Aeroplane Over the Sea","Two-Headed Boy",Fool,"Holland, 1945","Communist Daughter","Oh Comely",Ghost,[untitled],"Two-Headed Boy Pt. 2"}	11	00:39:54	https://neutralmilkhotel.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
473	Baxter Dury	B.E.D	https://baxterdury.bandcamp.com/album/b-e-d?from=discover_page	London, UK	2018-10-26	https://f4.bcbits.com/img/a4133914668_16.jpg	29.24	{"Tais Toi","Walk Away","How Do You Make Me Feel","Fly Away","White Coats","Only My Honesty Matters",Centipedes,"But I Think","baxter dury, etienne de crécy, delilah holliday - Eurostars"}	9	00:19:15	https://baxterdury.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
474	Ulrika Spacek	EXPO	https://ulrikaspacek.bandcamp.com/album/expo?from=discover_page	London, UK	2026-02-06	https://f4.bcbits.com/img/a4159761882_16.jpg	35.09	{Intro,Picto,"I Could Just Do It","Build a Box Then Break It","This Time I'm Present","Showroom Poetry",Expo,"Square Root of None","Weights & Measures","A Modern Low","Incomplete Symphony"}	11	00:45:31	https://ulrikaspacek.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
475	Mitski	Be The Cowboy	https://mitski.bandcamp.com/album/be-the-cowboy?from=discover_page	New York, New York	2018-08-17	https://f4.bcbits.com/img/a2337835939_16.jpg	20.39	{Geyser,"Why Didn't You Stop Me?","Old Friend","A Pearl","Lonesome Love","Remember My Name","Me and My Husband","Come into the Water",Nobody,"Pink in the Night","A Horse Named Cold Air","Washing Machine Heart","Blue Light","Two Slow Dancers"}	14	00:32:34	https://mitski.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
476	Mitski	The Land Is Inhospitable and So Are We	https://mitski.bandcamp.com/album/the-land-is-inhospitable-and-so-are-we?from=discover_page	New York, New York	2023-09-15	https://f4.bcbits.com/img/a2771200531_16.jpg	22.09	{"Bug Like an Angel","Buffalo Replaced",Heaven,"I Don't Like My Mind","The Deal","When Memories Snow","My Love Mine All Mine","The Frost",Star,"I'm Your Man","I Love Me After You"}	11	00:32:22	https://mitski.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
477	WWW.ROTATORVINYL.COM	THE NILZ - AMBIVERT	https://rotatorvinyl.bandcamp.com/album/the-nilz-ambivert?from=discover_page	Dublin, Ireland	2026-01-09	https://f4.bcbits.com/img/a2977997415_16.jpg	17.00	{"THE NILZ - THREE WAY KISS","THE NILZ - THIS IS ME SMILING (featuring Eli Uptihht)","THE NILZ - TURN OFF MY GAS (featuring Glen/Def Nettle)","THE NILZ - DEAF TONGUED (featuring Deep in the Woods)","THE NILZ - FOOD FOR THOT (Def Nettle Remix)"}	5	00:17:53	https://rotatorvinyl.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
478	SAULT	UNTITLED (Black Is)	https://saultglobal.bandcamp.com/album/untitled-black-is?from=discover_page	UK	2020-06-19	https://f4.bcbits.com/img/a1783879351_16.jpg	35.10	{"Out The Lies","Stop Dem","Hard Life","Don't Shoot Guns Down",Wildfires,X,"Sorry Ain't Enough","Black Is","Bow feat Michael Kiwanuka","This Generation feat Laurette Josiah","Why We Cry Why We Die",Black,US,"Eternal Life","Only Synth in Church",Monsters,"June Child",Miracles,"Hold Me","Pray Up Stay Up"}	20	00:56:35	https://saultglobal.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
479	Cinedelic	Maxwell Elemuo Acc. By Friimen Music Coy	https://cinedelic.bandcamp.com/album/maxwell-elemuo-acc-by-friimen-music-coy?from=discover_page	Cattolica, Italy	2026-02-02	https://f4.bcbits.com/img/a0940096375_16.jpg	24.00	{"Talking Time","Ajiboye Special","Thousand Kisses","Carry On","My Sweet Lord",Justina,"My Lady"}	7	00:42:11	https://cinedelic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
480	HOUSE Of ALL	Inklings	https://houseofall.bandcamp.com/album/inklings?from=discover_page	Manchester, UK	2026-03-06	https://f4.bcbits.com/img/a3749081902_16.jpg	26.91	{"Spirit Salient","Rebel Duke",Wrecked,"Valiant Heart","Prince Of This World","Time Is Out Of Joint","My Throbbing Heart Shall Rock Thee","Ours Is The Fall","Sweet Remembrancer","I Am Thine","Archangel Thunderbird (exclusive to bonus cd, originally by Amon Düül)","Dracula (exclusive to bonus cd, originally by Cindy Lee)","You Know More Than I Know  (exclusive to bonus cd, originally by John Cale)","Burning Moonlight (exclusive to bonus cd, originally by Marianne Faithfull)"}	14	00:52:01	https://houseofall.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
481	Vulgaires Machins	Contempler l''abîme	https://lesvulgairesmachins.bandcamp.com/album/contempler-lab-me?from=discover_page	Montreal, Québec	2025-11-14	https://f4.bcbits.com/img/a2363594489_16.jpg	25.00	{"Terminé le fun","Om mani padme hum","Travail à la chaîne","L'effondrement qui vient (feat Jenny 'J. KYLL' Salgado)","On continue","Encore du soleil pour quelques heures","Tout recommence",Avalanche,"Il faut se jeter à l'eau","Libérer la foudre","Faire sécession","Me croire seul à me croire inutile"}	12	00:38:50	https://lesvulgairesmachins.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
482	Cinedelic	The Cold Crusher	https://cinedelic.bandcamp.com/album/the-cold-crusher?from=discover_page	Cattolica, Italy	2026-02-02	https://f4.bcbits.com/img/a2249423262_16.jpg	26.00	{"Roast Fish & Stout","Raw Meat","White Whale","Cold Crusher",11-9-0,"Dub Them Roots Man",Murderer,"Run For Cover","Dub Me Right","Corn Meal Porridge"}	10	00:31:52	https://cinedelic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
483	ACTORS	Acts of Worship LP	https://actors.bandcamp.com/album/acts-of-worship-lp?from=discover_page	Vancouver, British Columbia	2021-10-01	https://f4.bcbits.com/img/a3345540043_16.jpg	23.80	{"Love U More","Like Suicide","Cold Eyes",Obsession,"Death From Above","Killing Time (Is Over)","Only Lonely",Strangers,"End of the World","Once More With Feeling"}	10	00:37:00	https://actors.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
484	Andris Mattson	FLUGEL	https://andrismattson.bandcamp.com/album/flugel?from=discover_page	Los Angeles, California	2025-12-05	https://f4.bcbits.com/img/a4121398938_16.jpg	21.25	{WING,Continuum,ALA,Still,...Still,SPĀRNS,aloe}	7	00:16:16	https://andrismattson.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
485	The Five Techniques	The Five Techniques Ft. Roisín El Cherif & Paul Weller - Resistance In The Dark	https://thefivetechniques.bandcamp.com/album/the-five-techniques-ft-roisi-n-el-cherif-paul-weller-resistance-in-the-dark?from=discover_page	Belfast, UK	2025-12-03	https://f4.bcbits.com/img/a3336623877_16.jpg	18.71	{"Resistance In The Dark","Resistance In The Dark (Instrumental)"}	2	00:08:36	https://thefivetechniques.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
486	good flying birds	Talulah''s Tape	https://goodflyingbirds.bandcamp.com/album/talulahs-tape?from=discover_page	Indianapolis, Indiana	2025-10-17	https://f4.bcbits.com/img/a2035065518_16.jpg	22.09	{"down on me",gfb,"i care for you",wallace,dynamic,"fall away","hard ass beat","every day is another",...,"eric's eyes",golfball,glass,...2,"pulling hair","i will find","last straw"}	16	00:39:55	https://goodflyingbirds.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
487	Imarhan	Essam	https://imarhan.bandcamp.com/album/essam?from=discover_page	Tamanrasset, Algeria	2026-01-16	https://f4.bcbits.com/img/a2855425680_16.jpg	29.00	{Ahitmanin,"Derhan N’Oulhine",Tellalt,Tamiditin,Okcheur,"Azaman Amoutay","Tin Arayth",Tinfoussen,"Adounia Tochal",Assagasswar}	10	00:44:42	https://imarhan.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
488	Perfume Genius	Glory	https://perfumegenius.bandcamp.com/album/glory?from=discover_page	Los Angeles, California	2025-03-28	https://f4.bcbits.com/img/a2870520195_16.jpg	25.27	{"It's a Mirror","Perfume Genius feat. Aldous Harding - No Front Teeth","Clean Heart","Me & Angel","Left For Tomorrow","Full On",Capezio,Dion,"In a Row","Hanging Out",Glory}	11	00:41:20	https://perfumegenius.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
489	Jazz Life	Blame The Clown	https://jazzlife.bandcamp.com/album/blame-the-clown?from=discover_page	UK	2026-02-13	https://f4.bcbits.com/img/a1645056856_16.jpg	23.40	{"Is It Real?","Wild Connection","I Operate","Little Seed","100 Bill Is Gone!","Peekaboo Hand","Not Real","Who Could It Be","Circus Clown",Hurricane,"White Hot Coal","Corpse Pose"}	12	00:30:25	https://jazzlife.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
490	Slowdive	everything is alive	https://slowdive.bandcamp.com/album/everything-is-alive?from=discover_page	UK	2023-09-01	https://f4.bcbits.com/img/a3812998304_16.jpg	21.24	{shanty,"prayer remembered",alife,"andalucia plays",kisses,"skin in the game","chained to a cloud","the slab"}	8	00:41:47	https://slowdive.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
491	Lemondaze	subtext	https://lemondaze.bandcamp.com/album/subtext?from=discover_page	London, UK	2025-12-05	https://f4.bcbits.com/img/a2256284708_16.jpg	40.94	{polari,c=bain,o(type),gravemind,terra}	5	00:24:27	https://lemondaze.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
492	SAULT	UNTITLED (Rise)	https://saultglobal.bandcamp.com/album/untitled-rise?from=discover_page	UK	2020-09-18	https://f4.bcbits.com/img/a1012577001_16.jpg	35.10	{Strong,Fearless,Rise,"I Just Want to Dance","Street Fighter","Son Shine","Rise Intently","The Beginning & the End",Free,"You Know It Ain't",Uncomfortable,"No Black Violins in London","Scary Times","The Black & Gold","Little Boy"}	15	00:50:55	https://saultglobal.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
493	A garota não	FERRY GOLD	https://agarotanao.bandcamp.com/album/ferry-gold?from=discover_page	Portugal	2025-05-05	https://f4.bcbits.com/img/a3795441999_16.jpg	45.00	{"A CASA DE BERNARDA ALBA","ESTE PAÍS NÃO É PARA MÃES",AURORA,"NO TRAIN A CURTIR COLTRANE","NO LOVE","FERRY GOLD","OS SAPATOS DA MINHA MÃE","NÃO TE DÊS À TRISTEZA","LEVANTE-SE UMA ESCOLA","FRONTEIRAS INVISÍVEIS","A garota não - LIMPA PALATO",TOPIÁRIA,IMPOSSÍVEL,"FALEMOS DAS CARTAS","NÃO INVENTES",ALASKA,"IRMÃOS DE SANGUE","O HOMEM QUE VIU A ABELHA MORRER","VAGAMENTE VAGA II","A garota não - O TESTAMENTO DO TIGRE","TIGRE I","TIGRE II","TIGRE III"}	23	01:16:23	https://agarotanao.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
494	LEATHERS	Ultraviolet	https://leathers.bandcamp.com/album/ultraviolet?from=discover_page	Vancouver, British Columbia	2024-08-16	https://f4.bcbits.com/img/a4232777457_16.jpg	25.50	{Ultraviolet,Highrise,Crash,Fascination,"Day For Night",Divine,"Phantom Heart","Daydream Trash",Runaway,Mary}	10	00:34:11	https://leathers.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
495	arm''s length	Never Before Seen, Never Again Found	https://armslengthontario.bandcamp.com/album/never-before-seen-never-again-found?from=discover_page	Quinte West, Ontario	2022-10-28	https://f4.bcbits.com/img/a3655650180_16.jpg	23.80	{Overture,"Object Permanence","Aries (Moth Song)","Tough Love","Formative Age","Muscle Memory","Playing Mercy","Everything As I Knew It","In Loving Memory","Family And Friends",Dirge}	11	00:38:13	https://armslengthontario.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
496	Brigitte Calls Me Baby	The Future Is Our Way Out	https://brigittecallsmebaby.bandcamp.com/album/the-future-is-our-way-out?from=discover_page	Chicago, Illinois	2024-08-02	https://f4.bcbits.com/img/a2537245260_16.jpg	19.55	{"The Future Is Our Way Out","Pink Palace","Eddie My Love","Fine Dining","I Wanna Die In The Suburbs","Too Easy","Palm Of Your Hand","Impressively Average","We Were Never Alive","You Are Only Made Of Dreams","Always Be Fine"}	11	00:37:50	https://brigittecallsmebaby.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
497	Snooper	Worldwide	https://snooper7.bandcamp.com/album/worldwide?from=discover_page	Nashville, Tennessee	2025-10-03	https://f4.bcbits.com/img/a1902331596_16.jpg	25.50	{"Opt Out","On Line","Company Car",Worldwide,"Guard Dog",Hologram,"Star 6 9",Blockhead,"Come Together","Pom Pom",Relay,Subdivision}	12	00:28:10	https://snooper7.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
498	the Mountain Goats	All Hail West Texas (Remastered)	https://themountaingoats.bandcamp.com/album/all-hail-west-texas-remastered?from=discover_page	Durham, North Carolina	2002-02-19	https://f4.bcbits.com/img/a2603313414_16.jpg	19.53	{"The Best Ever Death Metal Band in Denton","Fall of the Star High School Running Back","Color in Your Cheeks",Jenny,"Fault Lines",Balance,"Pink and Blue","Riches and Wonders","The Mess Inside","Jeff Davis County Blues","Distant Stations","Blues in Dallas","Source Decay","Absolute Lithops Effect","Hardpan Song (Bonus Track)","Answering the Phone (Bonus Track)","Indonesia (Bonus Track)","Midland (Bonus Track)","Jenny (alt. take) [Bonus Track]","Tape Travel Is Lonely (Bonus Track)","Waco (Bonus Track)"}	21	01:01:49	https://themountaingoats.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
499	the Mountain Goats	Tallahassee	https://themountaingoats.bandcamp.com/album/tallahassee?from=discover_page	Durham, North Carolina	2003-01-27	https://f4.bcbits.com/img/a3365013137_16.jpg	16.60	{Tallahassee,"First Few Desperate Hours","Southwood Plantation Road","Game Shows Touch Our Lives","The House That Dripped Blood","Idylls Of The King","No Children","See America Right",Peacocks,"International Small Arms Traffic Blues","Have To Explode","Old College Try","Oceanographer's Choice","Alpha Rats Nest"}	14	00:44:34	https://themountaingoats.bandcamp.com?from=discover_page	2026-02-23 13:22:19.639272	2026-02-23 13:22:19.639272
501	Crooked Fingers	Swet Deth	https://crookedfingers.bandcamp.com/album/swet-deth?from=discover_page	North Carolina	2026-02-27	https://f4.bcbits.com/img/a0829321041_16.jpg	21.23	{"Cold Waves (w/ Mac McCaughan)","From All Ways (w/ Matt Berninger)","Spray Tan Speed Queen (In A German Car)",Insomnia,"Empty Love and Cheap Thrills","Haunted (w/ Sharon Van Etten)",Hospital,"(I'm Your) Bodhisattva",Lena,"Steady Now"}	10	00:36:24	https://crookedfingers.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
502	boygenius	the record	https://xboygeniusx.bandcamp.com/album/the-record?from=discover_page		2023-03-31	https://f4.bcbits.com/img/a1880961717_16.jpg	25.50	{"Without You Without Them",$20,"Emily I'm Sorry","True Blue","Cool About It","Not Strong Enough",Revolution,"Leonard Cohen",Satanist,"We're In Love",Anti-Curse,"Letter To An Old Poet"}	12	00:42:18	https://xboygeniusx.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
503	saturdays at your place	always cloudy	https://saturdaysatyourplace.bandcamp.com/album/always-cloudy?from=discover_page	Kalamazoo, Michigan	2023-01-20	https://f4.bcbits.com/img/a0443623433_16.jpg	21.25	{Future,Fetch,"Tarot Cards","Hospital Bed","It's Always Cloudy In Kalamazoo","Eat Me Alive"}	6	00:18:32	https://saturdaysatyourplace.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
504	Mitski	Laurel Hell	https://mitski.bandcamp.com/album/laurel-hell?from=discover_page	New York, New York	2022-02-04	https://f4.bcbits.com/img/a3045628589_16.jpg	21.24	{"Valentine, Texas","Working for the Knife","Stay Soft",Everyone,"Heat Lightning","The Only Heartbreaker","Love Me More","There's Nothing Left Here for You","Should've Been Me","I Guess","That's Our Lamp","Love Me More (Clark Remix)"}	12	00:37:22	https://mitski.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
505	Midding	.44 EP	https://middingband.bandcamp.com/album/44-ep?from=discover_page	Cardiff, UK	2026-02-06	https://f4.bcbits.com/img/a3596579891_16.jpg	18.72	{"All For You",Nuisance,"For A Little While",Sunshine,.44}	5	00:24:29	https://middingband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
506	Ches Smith	Clone Row	https://chessmith.bandcamp.com/album/clone-row?from=discover_page	Brooklyn, New York	2025-06-06	https://f4.bcbits.com/img/a3412842128_16.jpg	25.50	{"Ready Beat","Abrade With Me","Clone Row","Town Down","Heart Breakthrough","Sustained Nightmare","Play Bell (For Nick)"}	7	00:39:41	https://chessmith.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
507	Adrianne Lenker	songs	https://adriannelenker.bandcamp.com/album/songs?from=discover_page		2020-10-23	https://f4.bcbits.com/img/a1829975877_16.jpg	33.92	{"two reverse",ingydar,anything,"forwards beckon rebound","heavy focus","half return",come,"zombie girl","not a lot, just forever","dragon eyes","my angel"}	11	00:39:39	https://adriannelenker.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
508	Hania Rani	Ghosts	https://haniarani.bandcamp.com/album/ghosts?from=discover_page	Warsaw, Poland	2023-10-06	https://f4.bcbits.com/img/a2324340904_16.jpg	31.58	{"Oltre Terra",Hello,"Don’t Break My Heart",24.03,"Dancing with Ghosts","A Day in Never","Whispering House","The Boat",Moans,"Thin Line",Komeda,Utrata,Nostalgia}	13	01:06:19	https://haniarani.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
509	Cate Le Bon	Michelangelo Dying	https://catelebon.bandcamp.com/album/michelangelo-dying?from=discover_page	UK	2025-09-26	https://f4.bcbits.com/img/a0306244169_16.jpg	23.79	{Jerome,"Love Unrehearsed","Mothers of Riches","Is It Worth It (Happy Birthday)?","Pieces of My Heart","About Time","Heaven Is No Feeling","Body as a River","Ride feat. John Cale","I Know What's Nice"}	10	00:43:25	https://catelebon.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
510	Gulp	Wildflower Remixes	https://gulp1.bandcamp.com/album/wildflower-remixes?from=discover_page	Scotland, UK	2025-11-28	https://f4.bcbits.com/img/a4153729845_16.jpg	16.38	{"Wildflower (Richard Norris Remix)","Wildflower (Ben Chatwin Remix)","Wildflower (Richard Norris Remix Instrumental)","Wildflower (Original Version)"}	4	00:23:10	https://gulp1.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
511	Boards of Canada	Music Has The Right To Children	https://boardsofcanada.bandcamp.com/album/music-has-the-right-to-children?from=discover_page		1998-04-20	https://f4.bcbits.com/img/a3351001335_16.jpg	32.76	{"Wildlife Analysis","An Eagle In Your Mind","The Color Of The Fire","Telephasic Workshop","Triangles & Rhombuses",Sixtyten,"Turquoise Hexagon Sun","Kaini Industries",Bocuma,Roygbiv,"Rue The Whirl",Aquarius,Olson,"Pete Standing Alone","Smokes Quantity","Open The Light","One Very Important Thought","Happy Cycling"}	18	01:11:02	https://boardsofcanada.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
512	PAULA PAULA	bald	https://paulapaula.bandcamp.com/album/bald?from=discover_page	Berlin, Germany	2026-01-30	https://f4.bcbits.com/img/a1628163413_16.jpg	27.00	{"Kein Arschloch",[2],[3],[4],[5],[6],[7],[8],[9],[10],[11]}	11	00:37:08	https://paulapaula.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
513	The Notwist	News from Planet Zombie	https://thenotwist.bandcamp.com/album/news-from-planet-zombie?from=discover_page	Germany	2026-03-13	https://f4.bcbits.com/img/a1266328602_16.jpg	27.99	{Teeth,X-Ray,Propeller,"Red Sun","The Turning",Snow,"Silver Lines","Who We Used to Be","How the Story Ends",Projectors,"Like This River"}	11	00:45:37	https://thenotwist.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
514	Joshua Idehen	I know you’re hurting, everyone is hurting, everyone is trying, you have got to try.	https://joshuaidehen.bandcamp.com/album/i-know-you-re-hurting-everyone-is-hurting-everyone-is-trying-you-have-got-to-try?from=discover_page	London, UK	2026-03-06	https://f4.bcbits.com/img/a2620878931_16.jpg	29.24	{"You Wanna Dance Or What?","Interlude – It Won’t Always Be Like This","It Always Was","This Is The Place","Interlude – What You Need To Hear","Could Be Forever","Mum Does The Washing","Don’t Let It Get You Down","My Love","Interlude – How I Found Forgiveness",Brother,"Whatever Comes","Choose Yourself","Everything Everywhere All At Once","Everything Everywhere All At Once Reprise","Turn It Around","What Is Redemption"}	17	00:47:22	https://joshuaidehen.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
515	Magic Wands	Cascades	https://magic-wands.bandcamp.com/album/cascades?from=discover_page	Los Angeles, California	2025-10-24	https://f4.bcbits.com/img/a3578942989_16.jpg	24.65	{"Across The Water",Armour,Hide,Albatross,Moonshadow,"Time To Dream",Cascades,Golden,"Room With A View",Riverbed}	10	00:32:45	https://magic-wands.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
516	Jim E. Brown	I Urinated on a Butterfly	https://jimebrown.bandcamp.com/album/i-urinated-on-a-butterfly?from=discover_page	Manchester, UK	2025-09-11	https://f4.bcbits.com/img/a2989007058_16.jpg	35.10	{"I Urinated on a Butterfly","The Queue at Greggs","I Opened My Mouth Too Wide Today (And It Hurts)","I Sat on a Wet Bench in St. Peter's Square","I Dreamed That You Liked My Instagram Post","There's a Duck in Alex Park With a Plastic Ring Around Its Beak","Post Coital Dysphoria","Mice Have Bitten Holes Into All My Childhood Toys","Didsbury Is a Dump","The Liquid From My Brain is Leaking Out My Nose","Spaghetti Hoops on Toast","I Want to Swallow Stones Like a Bird","Dog in Peril","I Have a Horrible Relationship With Food and Self-Image","I Scream Your Name","Fatty Liver","Rat in Bin","I'm Becoming Vegan After Watching Bambi","You Don't Find Me Attractive Anymore","My Entire Life is Utter Bilge","Every Time I Speak I Regret It Immensely","I Vomited on Britney Spears' Autobiography",Toxic,"I Am at My Happiest When I'm Unconscious","I'm Writing Love Letters at McDonald's (LIVE)","I Urinated on a Butterfly (Reprise)"}	26	01:07:02	https://jimebrown.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
517	Songs: Ohia	Magnolia Electric Co. (Deluxe Edition)	https://songsohia.bandcamp.com/album/magnolia-electric-co-deluxe-edition?from=discover_page	Chicago, Illinois	2013-11-12	https://f4.bcbits.com/img/a3722717630_16.jpg	23.79	{"Farewell Transmission","I've Been Riding With the Ghost","Just Be Simple","Almost Was Good Enough","The Old Black Hen","Peoria Lunch Box Blues","John Henry Split My Heart","Hold On Magnolia","The Big Game Is Every Night (Bonus Track)","Whip Poor Will (Bonus Track)","Farewell Transmission (Demo)","I've Been Riding With the Ghost (Demo)","Just Be Simple (Demo)","The Old Black Hen (Demo)","Peoria Lunch Box Blues (Demo)","John Henry Split My Heart (Demo)","Hold On Magnolia (Demo)","The Big Game Is Every Night (Demo)","Whip Poor Will (Demo)"}	19	01:43:35	https://songsohia.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
518	Baxter Dury	Allbarone	https://baxterdury.bandcamp.com/album/allbarone?from=discover_page	London, UK	2025-09-12	https://f4.bcbits.com/img/a0576965910_16.jpg	28.07	{Allbarone,"Schadenfreude Ft. JGrrey.","Kubla Khan","Alpha Dog","The Other Me",Hapsburg,"Mocking Jay","Return of the Sharp Heads Ft. J Grrey.","Mr W4"}	9	00:34:37	https://baxterdury.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
519	Car Seat Headrest	The Scholars	https://carseatheadrest.bandcamp.com/album/the-scholars?from=discover_page		2025-05-02	https://f4.bcbits.com/img/a0071278009_16.jpg	38.60	{"CCF (I'm Gonna Stay With You)",Devereaux,"Lady Gay Approximately","The Catastrophe (Good Luck With That, Man)",Equals,Gethsemane,Reality,"Planet Desperation","True/False Lover"}	9	01:10:36	https://carseatheadrest.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
520	Rosegarden Funeral Party	MARTYR	https://rosegardenfuneralparty.bandcamp.com/album/martyr?from=discover_page	Dallas, Texas	2019-11-24	https://f4.bcbits.com/img/a3349101627_16.jpg	23.50	{"Fade to Black","Mirror's Image",AMC,MARTYR,"Never Coming Home",Pills,Gaslighting,Streetlights}	8	00:37:33	https://rosegardenfuneralparty.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
521	Black Country, New Road	For the first time	https://blackcountrynewroad.bandcamp.com/album/for-the-first-time?from=discover_page	London, UK	2021-02-05	https://f4.bcbits.com/img/a1090225129_16.jpg	19.12	{Instrumental,"Athens, France","Science Fair",Sunglasses,"Track X",Opus}	6	00:40:46	https://blackcountrynewroad.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
522	Everyone Asked About You	Paper Airplanes, Paper Hearts	https://everyoneasked.bandcamp.com/album/paper-airplanes-paper-hearts?from=discover_page	Little Rock, Arkansas	2023-09-08	https://f4.bcbits.com/img/a2009801660_16.jpg	29.75	{"Paper Airplanes, Paper Hearts","Me Vs. You","It's Days Like This That Make Me Wish The Summer Would Last Forever","Everyone Asked About You","A Better Way To A Broken Heart","I Will Wait","Sometimes Memory Fails Me Sometimes","Handsome, Beautiful",Crazy,Boston,"Song For Chris","Letters Never Sent",Taxi,"Last Dance","Let's Be Enemies",Solitaire,"Across Puddles","Greek To Me",Outro}	19	00:59:43	https://everyoneasked.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
523	Osees	ABOMINATION REVEALED AT LAST	https://ohsees.bandcamp.com/album/abomination-revealed-at-last?from=discover_page	Los Angeles, California	2025-08-08	https://f4.bcbits.com/img/a0861207370_16.jpg	23.80	{ABOMINATION,SNEAKER,"GOD'S GUTS","INFECTED CHROME",GLÜE,"ASHES 2","COFFIN WAX","ASHES 1","FIGHT SIMULATOR",PROTECTION,"GLASS WINDOW",GLITTER-SHOT}	12	00:35:36	https://ohsees.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
524	Dälek	Brilliance of a Falling Moon	https://dalek.bandcamp.com/album/brilliance-of-a-falling-moon?from=discover_page	Union City, New Jersey	2026-03-27	https://f4.bcbits.com/img/a1964807385_16.jpg	21.24	{"Better Than","Knowledge | Understanding | Wisdom","Normalized Tragedy","Expressions Of Love",Substance,"I AM A MAN","For the People","By the Time We Arrive in El Salvador"}	8	00:40:00	https://dalek.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
525	Moderator	Silent Cinema	https://moderator.bandcamp.com/album/silent-cinema?from=discover_page	Αθήνα, Greece	2026-04-03	https://f4.bcbits.com/img/a3324491787_16.jpg	25.00	{"Dark Art",Macabre,Nymph,Banshee,Crypt,"Forbidden Fruit","Shadows on the Ceiling","First Blood","Hollow Ground","Cut to Black","Slow Burn",Eldritch,Fin}	13	00:40:04	https://moderator.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
526	Eyedlmode	Fogville (30th anniversary restored & remastered edition)	https://eyedlmode.bandcamp.com/album/fogville-30th-anniversary-restored-remastered-edition?from=discover_page	San Francisco, California	2025-11-01	https://f4.bcbits.com/img/a4044894823_16.jpg	42.50	{Intro,Vibeway,"Smoke Filled","Say What?!","The Third","Roll Call #1","Washington Square","Pavement Trials","I Said","Back To The Fog","G-Boogs & Da Monk",Forecast,"Clown Alley","Paint The Town","In The Mood Uno","The Drive-Thru","In My Life","A Word From Moose",Inkwell,"Just Don't Know","In The Mood Dos","The Meaning"}	22	01:01:35	https://eyedlmode.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
527	Mr. Dibbs	Ohio Dirt	https://mrdibbs.bandcamp.com/album/ohio-dirt?from=discover_page	Cincinnati, Ohio	2026-01-09	https://f4.bcbits.com/img/a3483981413_16.jpg	25.49	{S'CURITY,SPEEDBEARD}	2	00:36:47	https://mrdibbs.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
528	Rozewood	[Channel/13].exe	https://rozewoodghxstgxd.bandcamp.com/album/channel-13-exe?from=discover_page	Los Angeles, California	2026-01-09	https://f4.bcbits.com/img/a2404853901_16.jpg	85.00	{"[GhxstGxd] prod. Arch Druids","[Gumar Oz Dubar] Prod. Bozack Morris","[On.My.Own] Prod. Dj Skizz","[Ghxsts.Of.Winter] Prod. Big Ghost","[True.Friend] Prod. Dj Skizz","[Super.Nice] Prod. Dj Skizz","[Cocaine80s] Prod. Custodian Of Records","[Pyrex.Ghxsts] Prod. EyeDee","[Lightwork] Prod. Fortes","[Elevators] Feat. Hus Kingpin Prod. Dj Skizz","[Yakuza.Ring.Finger] Feat. Sage Infinite Prod.By Astrovandalist","[Orange Moon] Prod. By One Session"}	12	00:36:51	https://rozewoodghxstgxd.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
529	Sleep Sinatra	DIVINENATION	https://sleepsinatra1.bandcamp.com/album/divinenation?from=discover_page	Lincoln, Nebraska	2021-05-07	https://f4.bcbits.com/img/a2572124540_16.jpg	12.75	{"Freedom Writer",Vessel,TheDownerz,"Late Feez feat Rich Jones",OldWorld,"Hermes feat Maze Overlay","Judo Ippon","Sleep's Fortitude","EzekielsCraft Feat Davis the Dorchester Bully",Rubble,"Technicolor feat Amir Bilal",BrokenHaloz}	12	00:32:07	https://sleepsinatra1.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
530	Perpetual Stew Goods	All Shall Perish	https://perpetualstew.bandcamp.com/album/all-shall-perish?from=discover_page	Gresham, Oregon	2026-01-07	https://f4.bcbits.com/img/a3609925704_16.jpg	34.00	{Realest,"Killing Birds Ft. BUB STYLES","Perpetual Stew","Give Em Hell","All Shall Perish Ft. CHUBS & BOOB BRONX","Bad Mon","Soft Ones Ft. SAGEINFINITE","Sometimes The Predator is Prey","Real Recognize"}	9	00:29:36	https://perpetualstew.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
531	Danny Brown	Stardust	https://dannybrown.bandcamp.com/album/stardust-1?from=discover_page	Detroit, Michigan	2025-11-07	https://f4.bcbits.com/img/a4200104189_16.jpg	35.10	{"Danny Brown & Quadeca - Book of Daniel",Starburst,"Danny Brown & underscores - Copycats","Danny Brown & JOHNNASCUS - 1999","Danny Brown & 8485 - Flowers","Lift You Up","Danny Brown & Frost Children - Green Light","Danny Brown & Quadeca - What You See","Danny Brown & underscores - Baby","Danny Brown & IssBrokie - Whatever The Case","Danny Brown & Femtanyl - 1L0v3myL1f3!","Danny Brown & NNAMDI - RIGHT FROM WRONG","Danny Brown, Ta Ukrainka, Zheani, & Quadeca & Cynthoni - The End","Danny Brown & Jane Remover - All4U"}	14	00:49:38	https://dannybrown.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
532	Ballasrecords	HFS	https://ballasrecords.bandcamp.com/album/hfs?from=discover_page	France	2025-12-05	https://f4.bcbits.com/img/a2039634329_16.jpg	20.00	{Intro,Menace,#AntiChekem,"Hooligans Feyenoord",VVS,Welkom,"Sac Hermes",WAP,"Rico Verhoeven",Outro}	10	00:25:01	https://ballasrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
533	Forced Resignation Records	Block Music / Been Bout It	https://forcedresignationrecords.com/album/block-music-been-bout-it?from=discover_page	Denver, Colorado	2026-01-09	https://f4.bcbits.com/img/a1356482852_16.jpg	46.75	{Intro,"Man Time","Brand New Check","Block Music (feat. Lil Percy)","Spike Lee Joint","Walk in Da Park","Do Not Play Dis Shit","Dirty Reeboks","A1 Thunda",Intro,"Hustle & Flow","Pocket Watchin",Misconduct,"Souljah Rag Party (feat. Niontay)",Canvas,"Good Gracious","4 Flats (feat. Honorable Smacky & Haku)","Dior Flow","Work of Art","In My Lane","Drip on My Body (feat. 65 Cent)","Ok Cool","Pesos (feat. OkayMaine)","Swift Move Outro"}	24	00:56:28	https://forcedresignationrecords.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
534	Tom Caruana Remix Projects	Enter The Magical Mystery Chambers	https://tomcaruanamashups.bandcamp.com/album/enter-the-magical-mystery-chambers?from=discover_page	UK	2010-01-04	https://f4.bcbits.com/img/a0307947263_16.jpg	32.17	{"Wu Vs Beatles (Intro)",C.R.E.A.M.,"Got Your Money","Forget Me Not","Back In The Game","Uh Huh",Criminology,"Da Mystery Of Chessboxin'","Daytona 500",Labels,"Smith Bros","R.E.C. Room","Wu Vs Beatles (skit)","Mighty Healthy","Clientele Kidd","Cutting It Up","Release Yo Delf","City High",Run,"Cross My Heart","Uzi (Pinky Ring)",Bizarre,"Slang Editorial","Save Me Dear","The Movement","Wu Tang Cream Team Line Up","Wu Vs Beatles (Outro)"}	27	01:17:35	https://tomcaruanamashups.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
535	Armand Hammer	Mercy	https://armandhammer.bandcamp.com/album/mercy?from=discover_page	New York	2025-11-07	https://f4.bcbits.com/img/a0965573993_16.jpg	33.98	{Laraaji,Peshawar,"Calypso Gene (feat. Silka & Cleo Reed)","Glue Traps (feat. Quelle Chris)",Scandinavia,"Nil by Mouth","Dogeared (feat. Kapwani)","Crisis Phone (feat. Pink Siifu)",Moonbow,"No Grabba","u know my body","Longjohns (feat. Quelle Chris & Cleo Reed)","California Games (feat. Earl Sweatshirt)","Super Nintendo"}	14	00:41:51	https://armandhammer.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
536	Battle Weapons	BW-010	https://battleweapons.bandcamp.com/album/bw-010?from=discover_page	England, UK	2026-01-30	https://f4.bcbits.com/img/a2121065642_16.jpg	9.36	{"Hallmighty - Sorcerer's Sympathy","Silk - I Can't Stop (Dharma Collective Edit)"}	2	00:08:20	https://battleweapons.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
537	SALT-N-PEPA	Push It	https://salt-n-pepa.bandcamp.com/album/push-it?from=discover_page	Queens, New York	2021-08-06	https://f4.bcbits.com/img/a3204553507_16.jpg	127.50	{"Push It","Push It (Instrumental)",Shoop,"Whatta Man"}	4	00:18:15	https://salt-n-pepa.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
538	Skyzoo	Views of a Lifetime	https://skyzoo-hipnott.bandcamp.com/album/views-of-a-lifetime?from=discover_page	Brooklyn, New York	2025-12-05	https://f4.bcbits.com/img/a3781876010_16.jpg	25.49	{"Tags at the MoMA","Pardon Me","The Wager","Sky Is Like",Devotion,"Love Day","Hope & Pray","The Soloist","Half Bloom"}	9	00:36:01	https://skyzoo-hipnott.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
539	KNEECAP	No Comment	https://kneecap.bandcamp.com/album/no-comment?from=discover_page	Belfast, UK	2026-01-30	https://f4.bcbits.com/img/a1845201681_16.jpg	14.03	{"No Comment Ft. Sub Focus","Get Your Brits Out"}	2	00:05:14	https://kneecap.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
540	J Dilla	Donuts	https://dilla.bandcamp.com/album/donuts?from=discover_page	Detroit, Michigan	2006-02-07	https://f4.bcbits.com/img/a3193518945_16.jpg	26.35	{"Donuts (Outro)",Workinonit,Waves,"Light It","The New",Stop!,People,"The Diff'rence",Mash,"Time: The Donut of the Heart",Glazed,Airworks,Lightworks,"Stepson of the Clapper","The Twister (Huh, What)","One Eleven","Two Can Win","Don't Cry","Anti-American Graffiti","Geek Down",Thunder,Gobstopper,"One for Ghost","Dilla Says Go",Walkinonit,"The Factory",U-Love,Hi.,Bye.,"Last Donut of the Night","Welcome to the Show"}	31	00:43:38	https://dilla.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
541	Dälek	HAYWARDxDÄLEK	https://dalek.bandcamp.com/album/haywardxd-lek?from=discover_page	Union City, New Jersey	2025-12-05	https://f4.bcbits.com/img/a0141645297_16.jpg	25.50	{Increments,"Between the Word and the Drum","Breathe Slow",Salvage,Antiphony,Asymmetric,Sojourn,"As Children Chant",Re-Evolution}	9	00:54:18	https://dalek.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
542	clipping.	Dead Channel Sky	https://clppng.bandcamp.com/album/dead-channel-sky?from=discover_page	Los Angeles, California	2025-03-14	https://f4.bcbits.com/img/a3843558528_16.jpg	25.50	{Intro,Dominator,"Change the Channel","Run It",Go,"Simple Degradation (Plucks 1-13) (with Bitpanic)",Code,Dodger,"Malleus (with Nels Cline)","Scams (ft. Tia Nomore)","Keep Pushing","\\"From Bright Bodies\\" (Interlude)","Mood Organ",Polaroids,"Simple Degradation (Plucks 14-18) (with Bitpanic)",Madcap,"Mirrorshades pt. 2 (ft. Cartel Madras)","\\"And You Called\\" (Interlude)","Welcome Home Warrior (ft. Aesop Rock)","Ask What Happened"}	20	00:53:38	https://clppng.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
543	S. Fidelity	I Guess I’ll Never Learn	https://sfidelity.bandcamp.com/album/i-guess-i-ll-never-learn?from=discover_page	Berlin, Germany	2026-03-20	https://f4.bcbits.com/img/a0238393252_16.jpg	21.99	{"Limelight (feat. Teddy Bryant)","When Dumb Thoughts Learn How To Walk","Limbo (feat. Collard; Meron)","Siena (64kbit/s) (feat. Raelle; Meron)","Play (feat. Dawn Richard)","Two Steps on the Water","Crimson (64kbit/s) (feat. Raelle)","Bobby Hollywood","So Good (feat. Jerome Thomas)","Grey Mirror (feat. Raelle)","24h (Joyride) (feat. Jerome Thomas)","Glass on the Floor (feat. Collard)","I Guess I’ll Never Learn (feat. Wandl)"}	13	00:34:59	https://sfidelity.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
544	Jim Legxacy	black british music (2025)	https://jimlegxacy.bandcamp.com/album/black-british-music-2025?from=discover_page	London, UK	2025-07-18	https://f4.bcbits.com/img/a3260800725_16.jpg	23.39	{context,stick,"new david bowie",sun,"'06 wayne rooney","issues of trust",father,d.b.a.b,"big time forward",sos,"i just banged a snus in canada water","dexters phone call",3x,"tiger driver '91",brief}	15	00:34:57	https://jimlegxacy.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
545	Ho99o9	Tomorrow We Escape	https://ho99o9.bandcamp.com/album/tomorrow-we-escape?from=discover_page	Newark, New Jersey	2025-09-09	https://f4.bcbits.com/img/a3640009859_16.jpg	23.78	{"I Miss Home feat. MoRuf",Escape,"Target Practice","OK, I'm Reloaded","Psychic Jumper","Incline Feat. Nova Twins, Pink Siifu & Yung Skrrt","Upside Down","Tapeworm feat. Greg Puciato","Immortal feat. Chelsea Wolfe","LA Riots",Godflesh}	11	00:36:01	https://ho99o9.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
546	KNEECAP	Fine Art	https://kneecap.bandcamp.com/album/fine-art?from=discover_page	Belfast, UK	2024-06-14	https://f4.bcbits.com/img/a2365536250_16.jpg	31.58	{"3CAG (ft. Radie Peat)","Fine Art","Interlude: Making Headlines","I bhFiacha Linne","Interlude: Never Gets A Round","I'm Flush","Interlude: State Of Ya","Better Way To Live (ft. Grian Chatten)","Sick In The Head","Love Making (ft. Nino)","Interlude: Amhrán Na Scadán","Drug Dealin Pagans","Interlude: KNEECAP Chaps","Harrow Road (ft. Jelani Blackman)",Parful,"Rhino Ket","Interlude: Last Orders","Way Too Much"}	18	00:37:55	https://kneecap.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
547	Conway The Machine	You Can''t Kill God With Bullets	https://conwaythemachine.bandcamp.com/album/you-cant-kill-god-with-bullets?from=discover_page	Buffalo, New York	2025-12-12	https://f4.bcbits.com/img/a1161185699_16.jpg	38.25	{"Gun Powder","The Lightning Above The Adriatic Sea",BMG,"Diamonds (feat. Roc Marciano)","Hell Let Loose (feat. Whoo Kid & Tony Yayo)","Crazy Avery","The Painter","The Undying","Nu Devils (feat. G Herbo)","Otis Driftwood","Mahogany Walls","Parisian Nights (feat. KNDRX)",Se7enteen5ive,"Attached (feat. KNDRX & Lady London)","I Never Sleep","Hold Back Tears","Organized Mess (feat. KNDRX)","Don’t Even Feel Real (Dreams) [Bonus Track] (feat. Heather Victoria)"}	18	01:00:32	https://conwaythemachine.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
548	FILUKA	FORGLEMMIGEJ	https://filuka.bandcamp.com/album/forglemmigej?from=discover_page	Copenhagen, Denmark	2025-08-15	https://f4.bcbits.com/img/a0579160074_16.jpg	460.00	{HOWDY,"RADIO EDIT","FUCKER IKK MED DET",HÅNDTEGN,"FØLT SÅDAN HER","FRI FUGL",SENSOMMERVISE,FORGLEMMIGEJ,"UDEN DIG","LANG VEJ HJEM"}	10	00:29:53	https://filuka.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
549	Chillhop Music	Chillhop Essentials Winter 2025	https://chillhop.bandcamp.com/album/chillhop-essentials-winter-2025?from=discover_page	Rotterdam, Netherlands	2025-12-04	https://f4.bcbits.com/img/a3536794596_16.jpg	34.00	{"dennisivnvc - Always White, ft. Dani Catalá","anbuu, Blue Wednesday - Cold Start","goosetaf, Idan Morim - At First There Was Rain","Saib - Color Flow","Sweeps, luv pug - Night Waltz","Philanthrope, invention_ - Akxnyte","L'Indécis, ØDYSSEE - Machine Learning","No Spirit - Last Month","Mr Slipz - Winter in Patagonia","Tesk - Strobelight","King I Divine - Fireplace","The BREED - Soulistica","Aviino - Citrus Snow, ft. Lozz","Aphrow - Crossroads","Psalm Trees - Mudanca","Leavv - How It Is","\\"chromo, the dreamer\\" - Apricity","Ben Bada Boom - Frostbite Funk","Dotlights, zakè - Sediment Bloom","Ward Wills - Ghost of You","Flitz&Suppe - Stand Alone Complex","Ian Ewing - Cosmic Gumbo","J.Folk - Some Days","Enough Cereals - Mirage","lloom - Más o Menos","cocabona, less.people - Subtle","Vhsceral - So Worth It","Mac Kay - Rubin"}	28	01:09:39	https://chillhop.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
550	OnHand	PORTISHUS 2: BONUS PORTIS (BONUS DISC)	https://onhand.bandcamp.com/album/portishus-2-bonus-portis-bonus-disc?from=discover_page	New York, New York	2026-01-14	https://f4.bcbits.com/img/a2495099315_16.jpg	34.00	{"SPELLS (PROD. PA DRE)","SNOW BEACH GANG ft. MAR, KYLE RAPPS (PROD. OWLTREE)","CHAPTER 0 (PROD. 067RED)","BERGHAIN BLOW (PROD. CHIN BEATS)","MOST HATED REMIX ft. NATURE (PROD. MANNY MEGZ)"}	5	00:10:57	https://onhand.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
551	Mog.Y	Capital Funk	https://mog-y.bandcamp.com/album/capital-funk?from=discover_page	Melbourne, Australia	2025-12-12	https://f4.bcbits.com/img/a1530822688_16.jpg	50.00	{"Church of the G",Backsteppa,"Walk It In",Briquette,"Roll Call","The Beyond (Interlude)","Mack Machine","Good Morning","Kush & Kenzo","When This $hit Ends"}	10	00:31:34	https://mog-y.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
552	eevee	seeds	https://eeveebeats.bandcamp.com/album/seeds-2?from=discover_page	Netherlands	2017-03-17	https://f4.bcbits.com/img/a2451204107_16.jpg	21.24	{fragments,"m i s t","like this","já é verão",belas,seems,"lay it down",lua,"when I met you","I wonder if we're dead",admire,feel,forget}	13	00:31:41	https://eeveebeats.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
553	TT5BR	BXQNS	https://tt5br.bandcamp.com/album/bxqns?from=discover_page	New York, New York	2025-02-21	https://f4.bcbits.com/img/a2360084353_16.jpg	17.50	{BXQNS,"BXQNS (Remix)"}	2	00:05:41	https://tt5br.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
554	Pounz / Poupoune	rencontre.s	https://pounz.bandcamp.com/album/rencontre-s?from=discover_page	La Feuillée, France	2026-03-25	https://f4.bcbits.com/img/a0258634395_16.jpg	20.00	{Rencontre.s,"Les murs des maisons"}	2	00:06:59	https://pounz.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
555	Run The Jewels	Run The Jewels 3	https://runthejewels.bandcamp.com/album/run-the-jewels-3-2?from=discover_page	Brooklyn, New York	2016-12-24	https://f4.bcbits.com/img/a1068167516_16.jpg	29.73	{"Down (feat. Joi)","Talk to Me","Legend Has It","Call Ticketron","Hey Kids (Bumaye) [feat. Danny Brown]","Stay Gold","Don't Get Captured","Thieves! (Screamed the Ghost) [feat. Tunde Adebimpe]","2100 (feat. BOOTS)","Panther Like a Panther (Miracle Mix) [feat. Trina]","Everybody Stay Calm","Oh Mama","Thursday in the Danger Room (feat. Kamasi Washington)","A Report to the Shareholders / Kill Your Masters"}	14	00:51:34	https://runthejewels.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
556	KNEECAP	KNEECAP (ORIGINAL SOUNDTRACK)	https://kneecap.bandcamp.com/album/kneecap-original-soundtrack?from=discover_page	Belfast, UK	2024-08-30	https://f4.bcbits.com/img/a0474124526_16.jpg	35.09	{"KNEECAP - Parful","KNEECAP - ITS BEEN AGES","Mikey J - RUN","‘Nothing but a H.O.O.D’","Mikey J - CIVIL RIGHTS","‘A wee operation’","Mikey J - DAD’S GONE","KNEECAP - Amach Anocht","'You bring a stolen car here’","Mikey J - CEASEFIRE BABIES","KNEECAP - Guilty Conscience","‘Love affair with the shniff’","KNEECAP - C.E.A.R.T.A","Mikey J - ARRESTED","Dirty Faces - 80%","KNEECAP - 3CAG","The Bonny Men - The A Minor Set","‘No need to panic’","KNEECAP - Thart agus Thart","'What the fuck was that?!’","BICEP - Glue","‘There are 80,000 native Irish speakers…’","KNEECAP - Sick In The Head","Fontaines D.C. - Liberty Belle","'Special delivery’","Mikey J, Gemma Doherty and Simone Kirby  - Phone Booth","Absolute Lilt - Ash Plant","Orbital - Belfast","KNEECAP - Better Way To Live (ft. Grian Chatten)","Mikey J - KNEECAPPED","Alanna Royale  - Fall In Love Again","Mikey J, Gemma Doherty and Simone Kirby - Is a bullet","‘The Irish for the end is…’","KNEECAP - H.O.O.D","Orbital - 'Belfast' - KNEECAP OST Version."}	35	01:19:12	https://kneecap.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
557	clipping.	Visions of Bodies Being Burned	https://clppng.bandcamp.com/album/visions-of-bodies-being-burned?from=discover_page	Los Angeles, California	2020-10-23	https://f4.bcbits.com/img/a0034985728_16.jpg	23.80	{Intro,"Say the Name","Wytchboard (Interlude)","'96 Neve Campbell (feat. Cam & China)","Something Underneath","Make Them Dead","She Bad","Invocation (Interlude) [with Greg Stuart]","Pain Everyday (with Michael Esposito)","Check the Lock","Looking Like Meat (feat. Ho99o9)","Drove (Interlude)","Eaten Alive (with Jeff Parker & Ted Byrnes)","Body for the Pile (with SICKNESS)",Enlacing,"Secret Piece"}	16	00:52:40	https://clppng.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
558	MIKE	Showbiz! (Deluxe)	https://mikelikesrap.bandcamp.com/album/showbiz-deluxe?from=discover_page	New York, New York	2025-12-11	https://f4.bcbits.com/img/a2109151044_16.jpg	34.00	{"Bear Trap","Clown of the Class (Work Harder)","Then we could be free..","Watered down","man in the mirror","MIKE & Venna - Artist of the Century","MIKE & 454 - What U Bouta Do?/A Star was Born (feat. 454)","MIKE & SURF GANG - Belly 1","Da Roc","The Weight (2k20)","Lost Scribe","You're the Only One Watching",Lucky,#82,"Too Hot (interlude)","Pieces Of A Dream","Strange Feeling","Zombie pt.2","Burning House","Showbiz! (Intro)","Spun Out","MIKE & duendita - Miss U (feat. duendita)","When it Rains","Diamond Dancing (Broke)","MIKE & Band of the Century - Intro (Tiny Desk version)","MIKE & Band of the Century - Burning Desire (Tiny Desk version)","MIKE & Band of the Century - man in the mirror (Tiny Desk version)","MIKE & Band of the Century - Artist Of The Century (Tiny Desk version)","MIKE & Band of the Century - Evil Eye (Tiny Desk version)","MIKE & Band of the Century - World Market (Mo' Money) (Tiny Desk version)","MIKE & Band of the Century - Diamond Dancing (Broke) (Tiny Desk version)","MIKE & Band of the Century - Leaders of Tomorrow (Tiny Desk version)","MIKE & Band of the Century - nite flite (Tiny Desk version)","MIKE & Band of the Century - parkS (Tiny Desk version)","MIKE & Band of the Century - What Do I Do? (Tiny Desk version)"}	35	01:09:29	https://mikelikesrap.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
559	Cut Beetlez	YUP / IUNDERSTAND	https://cutbeetlez.bandcamp.com/album/yup-iunderstand?from=discover_page	Finland	2026-01-09	https://f4.bcbits.com/img/a1452673907_16.jpg	35.00	{YUP}	1	00:04:10	https://cutbeetlez.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
560	Emapea	Seeds, Roots & Fruits	https://emapea.bandcamp.com/album/seeds-roots-fruits?from=discover_page	Poland	2016-01-29	https://f4.bcbits.com/img/a0444538380_16.jpg	22.10	{Laka,"Stinky Freaky Sticky Icky",Jazzy,Orange,"Ruffneck Madness","Strange Seed",Yugen,Enjoy,"Smooth Walk","Sun Is Life",Timewarp,"What The Funk","Workout Theme","Good Old Days","Milky Haze","Baby Mind"}	16	00:52:38	https://emapea.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
561	Three Dollar Pistol Music LLC	Flyetism	https://threedollarpistol.com/album/flyetism?from=discover_page	Philadelphia, Pennsylvania	2026-01-12	https://f4.bcbits.com/img/a0951426000_16.jpg	40.80	{"Camden Beach (Height Keech Remix)","Get There Fast feat DJ Skipmode (prod by Zilla Rocca)","Upkeep (OldGold Remix)",Comeback,"Shotei (Small Professor Marvin Harrison Remix)","I Made Peace with the Algorithm (Esh & The Isoliations Remix)","Adam Goldberg's Vine (prod by Height Keech)","Talk King feat Curly Castro (ialive Remix)","Dad Class (Garfunkle Remix)","The Ballad of Mint and Chip (Rocky Road Remix)","Oscillate feat SelfSays (andrew Remix)",Poolside}	12	00:37:19	https://threedollarpistol.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
562	MAVI	The Pilot	https://mavi.bandcamp.com/album/the-pilot?from=discover_page	Charlotte, North Carolina	2025-11-25	https://f4.bcbits.com/img/a4086907871_16.jpg	23.80	{"Heavy Hand","Triple Nickel","Silent Film","G-ANNIS FREESTYLE",Typewriter,"31 Days","Denise Murrell",Mender,Landgrab,Potluck}	\N	00:52:10	https://mavi.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
563	d.b.h	watching the world from space	https://djdbh.bandcamp.com/album/watching-the-world-from-space?from=discover_page	Vienna, Austria	2026-02-20	https://f4.bcbits.com/img/a0106349265_16.jpg	25.00	{"Perfect World",Echtzeit,"Watching the World from a Space Station","Half Way Down (feat. møsiba & Koko Cappelle)",Sentinel-3,"Drifting in Space",Sentinel-5P,"Back in '99","Low Earth Orbit","Aural Float","Space Night","Dark Sky",Blackout,PNR,STS-15}	16	00:44:19	https://djdbh.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
564	Danny Brown	Atrocity Exhibition	https://dannybrown.bandcamp.com/album/atrocity-exhibition?from=discover_page	Detroit, Michigan	2016-09-30	https://f4.bcbits.com/img/a0747334388_16.jpg	32.76	{"Downward Spiral","Tell Me What I Don't Know","Danny Brown & Petite Noir - Rolling Stone","Danny Brown & Kendrick Lamar & Ab-Soul & Earl Sweatshirt - Really Doe",Lost,"Ain't it Funny",Golddust,"White Lines",Pneumonia,"Dance In The Water","Danny Brown & Kelela - From The Ground","When It Rain",Today,"Danny Brown & B-Real - Get Hi","Hell For It"}	15	00:46:47	https://dannybrown.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
565	Shungu	Faith in the Unknown	https://shungujazz.bandcamp.com/album/faith-in-the-unknown?from=discover_page	Brussels, Belgium	2025-11-07	https://f4.bcbits.com/img/a0597607688_16.jpg	29.25	{"Written Down (feat. Pink Siifu)","Talk to the Mass (Feat. Fly Anakin, Goya Gumbani & Fatima)","Serti Dial (feat. Navy Blue)","Did You Hear The News (feat. Ruqqiyah)","Faith in the Unknown (feat. Maxo)","Stay Alive (feat. Pink Siifu)","Last Time (feat. Liv.e)","Thin Line (feat. Chester Watson)","Pray 4 My Friends (feat. Dreamcastmoe)","Butterfly (feat. ZEKEULTRA)","It Echoes and Sings Like You (feat. Fatima)","The Wind Must Have Heard Your Voice Once","The Devil Might Want Me Gone (feat. Pink Siifu & Maxo)","All I Needed Was A Little A Bit (feat. Pink Siifu)"}	14	00:37:55	https://shungujazz.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
566	Degrand Island Records	DIA Vol.1	https://degrandislandrecords.bandcamp.com/album/dia-vol-1-2?from=discover_page	Detroit, Michigan	2026-01-01	https://f4.bcbits.com/img/a4092228728_16.jpg	29.75	{"U Know",Gouda,"Admantium Chain",Solitude,Intimidated,Rasclott,"How Ya Light it Up",Artifacts,"Steph Curry","Mick Scorcese","U Got It","Drug Deal"}	12	00:39:34	https://degrandislandrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
567	The Allergies	As We Do Our Thing	https://theallergies.bandcamp.com/album/as-we-do-our-thing?from=discover_page	Bristol, UK	2016-06-15	https://f4.bcbits.com/img/a0183742305_16.jpg	29.24	{Intro,"Blast Off (feat. Andy Cooper)","As We Do Our Thing","Sound Advice (feat. HypeMan Sage)",Heartbreaker,"Real Thing Interlude","Flip the Scripture (feat. BluRum13)","Be With You","Seven Days","Rock Rock (feat. Andy Cooper)","Special People","You Wouldn’t Know","Love's Supposed to Be","Infinito Interlude","God Walked Down"}	15	00:49:21	https://theallergies.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
568	Jihad the Roughneck MC	Strange Wisdom	https://jihadtheroughneckmc.bandcamp.com/album/strange-wisdom?from=discover_page	Los Angeles, California	2025-10-24	https://f4.bcbits.com/img/a3277074754_16.jpg	21.25	{Style,"The Future",Distant,"The Human Mind",Hallucination,Horror,Indigenous,Venus,"Lord Opium Flower",Outro,"Lord Opium","Snake Eyes"}	12	00:15:17	https://jihadtheroughneckmc.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
569	dj pnutz	Goodbye San Diego	https://djpnutz.bandcamp.com/album/goodbye-san-diego?from=discover_page	California	2026-01-13	https://f4.bcbits.com/img/a1097988142_16.jpg	10.20	{"Goodbye San Diego","Seasoned Woman","45 DJ ft. Steven Flex","Be Kind Please Rewind","Dollar Bin Drum Breaks","60 Tons of Steal","Sample This","Smoke Ribs Everyday","Did the Best She Could","We Be Basting","Hard Enough for a Man But Made by a Woman","Bon Voyage"}	12	00:42:06	https://djpnutz.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
570	Battle Weapons	BW-003	https://battleweapons.bandcamp.com/album/bw-003?from=discover_page	England, UK	2024-02-10	https://f4.bcbits.com/img/a0904131046_16.jpg	9.36	{"Hardly Subtle - You Got The Praise VIP","Peggy Lee - Sittin on the Dock of the Bay (Wonderlove's Edit)"}	2	00:07:52	https://battleweapons.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
571	Ill Conscious	The Aggregation of Marginal Gains	https://illconsciousdagod.bandcamp.com/album/the-aggregation-of-marginal-gains?from=discover_page	Baltimore, Maryland	2005-12-12	https://f4.bcbits.com/img/a0014619917_16.jpg	42.50	{"Fine-Tuning (Feat. Soul Intellect)","Marginal Gains (Feat. Snook Da Crook)","Mark 8:36","Beautiful Mirage (Feat. JoLy Bmore)","Amalgamation (Feat. Awon & Fresh Daily)","Incremental Improvements","Carpe Diem","Israelites Mist (Feat. DJ Grazzhoppa)","Fonky Azz (Feat. Soul Intellect)","Nautical Lanes (Feat. Debonair P)","Progressive Change"}	11	00:26:53	https://illconsciousdagod.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
572	Anti-Lilly & Phoniks	All Good Things	https://antilillyandphoniks.bandcamp.com/album/all-good-things?from=discover_page	Houston, Texas	2025-11-28	https://f4.bcbits.com/img/a0023456867_16.jpg	85.00	{"Too Late (ft. Scienze)","Play Me In","Wonder Why (ft. Devante)","Polarity Flow","Swim In Fire (ft. Awon)","Nights In Cologne",Visions,"New Dream",Finite,Window,"Nirvana Flow","Aunt Penny","If I Fly","All Good Things"}	14	00:39:59	https://antilillyandphoniks.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
573	Battle Weapons	DW-006	https://battleweapons.bandcamp.com/album/dw-006?from=discover_page	England, UK	2024-11-29	https://f4.bcbits.com/img/a1359673089_16.jpg	9.36	{"DJ LBR - Let Me Clear My Funk","DC's Finest - Can I Have it Like Wack"}	2	00:09:33	https://battleweapons.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
574	Mad Keys	Go Where You''re Led	https://madkeys.bandcamp.com/album/go-where-youre-led?from=discover_page	St Louis, Missouri	2025-07-29	https://f4.bcbits.com/img/a1238977827_16.jpg	33.99	{"More Than Happenstance","Citrus Punch (With Kaelin Ellis)","Compound Interest","Grown Folk Juice","VIolet Greys","Wishful Thinking",Vibrance,"Go Where You're Led (With Josh2800 & Mr. Turner)"}	8	00:20:54	https://madkeys.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
575	Tea Breaks (45s)	HELLO	https://teabreaks.bandcamp.com/album/hello?from=discover_page	Todmorden, UK	2025-12-01	https://f4.bcbits.com/img/a1262349647_16.jpg	11.70	{HELLO,TAXMAN}	2	00:07:22	https://teabreaks.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
576	Chillhop Music	Chillhop Raccoon Nighttime Ramen	https://chillhop.bandcamp.com/album/chillhop-raccoon-nighttime-ramen?from=discover_page	Rotterdam, Netherlands	2025-07-07	https://f4.bcbits.com/img/a2548262462_16.jpg	34.00	{"FloFilz - Blue Orchard","GlobulDub - Foreign Exchange","SwuM - The Dream","Middle School\t- Plush Pocket","Tesk\t- Doin It","Ruck P - Le Voyage Du Coeur","junior state - Mighty","Brock Berrigan - Crossing Paths","L'Indécis\t- Fried Potatoes","Mono:Massive\t- Somewhat","Taro, Middle School - At This Point","Ian Ewing, Strehlow - Poke Date","Yasper, Louk -\tMoody","Monma, Misha - Moon","Ruck P - Coffee Break","Moose Dawa - Menti","Psalm Trees - Wherever You Are","Epektase, Nymano\t- Wandering At Night","cocabona, Monma\t- Sleepy"}	19	00:51:16	https://chillhop.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
577	Dälek	Precipice	https://dalek.bandcamp.com/album/precipice?from=discover_page	Union City, New Jersey	2022-04-29	https://f4.bcbits.com/img/a3847332513_16.jpg	30.60	{"Lest We Forget",Boycott,"Decimation (Dis Nation)",Good,Holistic,"The Harbingers","Devotion (when I cry the wind disappears)","A Heretic’s Inheritance",Precipice,Incite}	10	00:46:28	https://dalek.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
578	Pirates Of Marseille	Pirates Of Marseille- Vinyle Le Voyage 10 Ans	https://piratesofmarseille.bandcamp.com/album/pirates-of-marseille-vinyle-le-voyage-10-ans?from=discover_page	Marseille, France	2024-12-06	https://f4.bcbits.com/img/a1976557774_16.jpg	22.00	{"Le Voyage","Le Voyage Instrumental","Le Voyage Remix By Pimouss Fanatik","Bonus Track By Pimouss Fanatik"}	4	00:17:18	https://piratesofmarseille.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
579	Digga Please?	Rolling In The Dub	https://diggaplease.bandcamp.com/album/rolling-in-the-dub?from=discover_page	London, UK	2025-10-03	https://f4.bcbits.com/img/a4267155649_16.jpg	17.54	{"Rolling In The Dub",Missin}	2	00:08:54	https://diggaplease.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
580	Armand Hammer	We Buy Diabetic Test Strips	https://armandhammer.bandcamp.com/album/we-buy-diabetic-test-strips?from=discover_page	New York	2023-09-29	https://f4.bcbits.com/img/a1265013984_16.jpg	42.50	{"Landlines (produced by JPEGMAFIA)","Woke Up And Asked Siri How I'm Gonna Die (produced by JPEGMAFIA)","The Flexible Unreliability Of Time And Memory (produced by Child Actor))","When It Doesn't Start With A Kiss (produced by JPEGMAFIA & Pudge)","I Keep A Mirror In My Pocket feat. Cavalier (produced by Preservation)","Trauma Mic feat. Pink Siifu (produced by DJ Haram)","Niggardly (Blocked Call) (produced by August Fanon)","The Gods Must Be Crazy (produced by El-P)","Y'all Can't Stand Right Here feat. Moneynicca (Soul Glo) (produced by Steel Tipped Dove & Messiah Musik)","Total Recall (produced by Kenny Segal)","Empire BLVD feat. Curly Castro (produced by Willie Green)","Don't Lose Your Job feat. Pink Siifu & Moor Mother (produced by Black Noi$e & Jeff Markey)","Supermooned (produced by DJ Haram & Elucid)","Switchboard (produced by Sebb Bash)","The Key Is Under The Mat (produced by JPEGMAFIA)",Doves}	16	01:00:17	https://armandhammer.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
581	M25	The Trust Of Justice	https://m25music.bandcamp.com/album/the-trust-of-justice?from=discover_page	San Diego, California	2026-01-09	https://f4.bcbits.com/img/a3646021442_16.jpg	42.50	{"Lxor & Trust One - Dissentro Ft. Rootz","Aeon Demolition Ft. Scratches by DJ Somnium",Indignation,Legacy,"Nothing Ft. Rootz",Attitude,"The Trust","Fulcrum Point",Beneficence,"Anxious Ft. Heres Johnny","Arc Of Justice Ft. Nuse Tyrant & Ghostvolume","Reapers Lament","Center's Contemplation (Outro)"}	13	00:34:56	https://m25music.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
582	pushpause	Video Game LoFi: GoldenEye 007	https://pushpauselofi.bandcamp.com/album/video-game-lofi-goldeneye-007?from=discover_page	Philadelphia, Pennsylvania	2023-02-17	https://f4.bcbits.com/img/a2193707838_16.jpg	23.80	{"Chemical Warfare Facility (from \\"GoldenEye 007\\")","Severnaya Installation (from \\"GoldenEye 007\\")","Soviet Missile Silo (from \\"GoldenEye 007\\")","Frigate 'La Fayette' (from \\"GoldenEye 007\\")","Severnaya Installation - Night (from \\"GoldenEye 007\\")","Severnaya Bunker (from \\"GoldenEye 007\\")","Archives (from \\"GoldenEye 007\\")","Janus Control Center (from \\"Goldeneye 007\\")","Subterranean Caverns (from \\"GoldenEye 007\\")","el-Saghira Temple (from \\"GoldenEye 007\\")"}	10	00:28:13	https://pushpauselofi.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
583	MIKE	Showbiz!	https://mikelikesrap.bandcamp.com/album/showbiz?from=discover_page	New York, New York	2025-01-31	https://f4.bcbits.com/img/a2541534871_16.jpg	42.50	{"Bear Trap","Clown of the Class (Work Harder)","Then we could be free..","Watered Down","man in the mirror","Artist of the Century","What U Bouta Do?/A Star was Born ft. 454","Belly 1","Da Roc","The Weight (2k20)","Lost Scribe","You’re the Only One Watching",Lucky,#82,"Too Hot (interlude)","Pieces Of A Dream","Strange Feeling","Zombie pt.2","Burning House",Showbiz!,"Spun Out","Miss U ft. duendita","When it Rains","Diamond Dancing (Broke)"}	24	00:47:30	https://mikelikesrap.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
584	Tom Caruana Remix Projects	Natural Forces	https://tomcaruanamashups.bandcamp.com/album/natural-forces?from=discover_page	UK	2025-10-31	https://f4.bcbits.com/img/a2845573291_16.jpg	40.95	{"Top 10 List","Born To Roll","The I.N.C. Ride","Conflict (w/ Guru)",Slaughtahouse,"Reminds Me (w/ Edo G)","Freedom House","I Refuse (w/ Wordsworth)",Wishing,"Fly Wunz","Uncle Larry","Ace Radio","Ain't U Da Masta","Ya Hardcore","Juanita Estefan (w/ Stricklin)","The B-Side Freestyle","Freedom House (Marco Polo Remix)"}	17	01:02:04	https://tomcaruanamashups.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
585	clipping.	There Existed an Addiction to Blood	https://clppng.bandcamp.com/album/there-existed-an-addiction-to-blood?from=discover_page	Los Angeles, California	2019-10-18	https://f4.bcbits.com/img/a3980257472_16.jpg	23.80	{Intro,"Nothing is Safe","He Dead (feat. Ed Balloon)","Haunting (interlude)","La Mala Ordina (with The Rita) (feat. Elcamino & Benny The Butcher)","Club Down (with Sarah Bernat)","Prophecy (interlude)","Run for Your Life (feat. La Chat)","The Show","Possession (interlude)","All in Your Head (feat. Counterfeit Madison & Robyn Hood)","Blood of the Fang","Story 7","Attunement (with Pedestrian Deposit)","Piano Burning"}	15	01:08:35	https://clppng.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
586	Blunt Shelter Records	Gnork Meets The Jazzbois (In Random Places)	https://bluntshelter.bandcamp.com/album/gnork-meets-the-jazzbois-in-random-places?from=discover_page	Budapest, Hungary	2025-12-12	https://f4.bcbits.com/img/a0984219822_16.jpg	28.00	{"Spring 25",Meduza,Spacewalk,"Sunday Jazz","Sour & Sweet","Discoboiz (Album Version)","Warmed Up"}	7	00:31:56	https://bluntshelter.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
587	Verb T	To Love a Phantom	https://verbt.bandcamp.com/album/to-love-a-phantom?from=discover_page	London	2025-12-11	https://f4.bcbits.com/img/a3259925500_16.jpg	32.76	{"Through the Wall Feat. Rozsa (Act 1 - 01)","Introvert (Act 1 - 02)","Illusion of Self Feat. Farma G & BVA (Act 1 - 03)","Absorbing Imagery (Act 1 - 04)","Distraction (Act 1 - 05)","See the Truth Feat. Leaf Dog (Act 1 - 06)","Change Feat. Verbz (Act 1 - 07)","Motivation Pt.2 Feat. Karizz (Act 1 - 08)","Alien Concept (Act 1 - 09)","No Expression Feat. Scorzayzee & Teach Em (Act 1 - 10)","Adrenaline Feat. Beano (Act 1 - 11)","Suspense and Tension Feat. Harry Shotta & Jah Digga (Act 1 - 12)","To Kill a Phantom (Act 1 - 13)","Not There (Act 2 - 01)","Anti-Stress (Act 2 - 02)","1000 Features Pt.2 (Act 2 - 03)","Swerve a Lot (Act 2 - 04)","By Myself (Act 2 - 05)","Minimal Feat. TrueMendous (Act 2 - 06)","Don't Waste Time Rushing Feat. JayaHadADream (Act 2 - 07)","Prior to Existence (Act 2 - 08)","Bring it All Together (Act 2 - 09)","Late to School Feat. Donkobz (Act 2 - 10)","Rejuvenate Feat. Fliptrix (Act 2 - 11)","Everything Feat. Isaiah Dreads (Act 2 - 12)","Phantom Laugh (Act 2 - 13)"}	26	01:17:55	https://verbt.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
588	FloFilz	Hagaki 葉書	https://flofilzmpm.bandcamp.com/album/hagaki?from=discover_page	Berlin, Germany	2025-09-12	https://f4.bcbits.com/img/a0018764976_16.jpg	30.00	{"Furo 風呂","Setagaya Samba","Taito City Hideout (feat. Takuya Kuroda)","Kimochi ii 気持ちいい","Yoinokuchi 宵の口","6F Encounters","Yokohama Yard (feat. tajima hal & Lidly)","Inemuri 居眠り","20today (feat. 12Vince)","Kaki 柿","Ma 間","Atélier (feat. Matt Wilde & Toshiki Soejima)","Insomnia (feat. Nao Yoshioka)","Yōkai 妖怪","Forest Crab (feat. Budamunk)","Sunken Stones"}	16	00:37:27	https://flofilzmpm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
589	TXRINX	Leather Rose	https://txrinx.bandcamp.com/album/leather-rose?from=discover_page	London, UK	2025-08-18	https://f4.bcbits.com/img/a0241287160_16.jpg	35.09	{"Dark Whispers","Carnegie Hall / NY Mix","Air It Out","Bonnie & Clyde","Carnegie Hall / HK Mix","We Outside",Faith,"Mobster Novel"}	16	01:06:34	https://txrinx.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
590	Oddisee	En Route	https://oddiseemmg.bandcamp.com/album/en-route?from=discover_page	Brooklyn, New York	2025-05-30	https://f4.bcbits.com/img/a4010562136_16.jpg	23.80	{"Tomorrow Can't Be Borrowed","A Rare Thing","Small Talk","Natural Selection"}	4	00:11:55	https://oddiseemmg.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
591	Run The Jewels	Run The Jewels	https://runthejewels.bandcamp.com/album/run-the-jewels?from=discover_page	Brooklyn, New York	2013-06-26	https://f4.bcbits.com/img/a0076673999_16.jpg	21.23	{"Run The Jewels","Banana Clipper (feat. Big Boi)","36\\" Chain",DDFH,"Sea Legs","Job Well Done (feat. Until the Ribbon Breaks)","No Come Down","Get It","Twin Hype Back (feat. Prince Paul)","A Christmas Fucking Miracle"}	10	00:33:01	https://runthejewels.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
592	Danny Brown	Quaranta	https://dannybrown.bandcamp.com/album/quaranta?from=discover_page	Detroit, Michigan	2023-11-17	https://f4.bcbits.com/img/a3189957632_16.jpg	25.74	{Quaranta,Tantor,"Ain't My Concern","Dark Sword Angel","Danny Brown featuring Bruiser Wolf - Y.B.P.","Danny Brown featuring Kassa Overall - Jenn’s Terrific Vacation","Down Wit It","Danny Brown featuring MIKE - Celibate",Shakedown,Hanami,"Bass Jam"}	11	00:34:21	https://dannybrown.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
593	Sampa The Great	As Above So Below	https://sampathegreat.bandcamp.com/album/as-above-so-below?from=discover_page	Melbourne, Australia	2022-09-09	https://f4.bcbits.com/img/a3942653799_16.jpg	55.00	{Shadows,Lane,"Never Forget","Mask On",Bona,"Can I Live?","Imposter Syndrome",Tilibobo,"Lo Rain",IDGAF,"Let Me Be Great"}	11	00:39:12	https://sampathegreat.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
594	Retro-Respect Records	Back 2 Life W/ Devilz Pie	https://retro-respect.bandcamp.com/album/back-2-life-w-devilz-pie?from=discover_page		2022-10-07	https://f4.bcbits.com/img/a2902377247_16.jpg	11.90	{"Back 2 Life (DJ A-L Edit)","Back 2 Life (DJ A-L Drumapella)","Devil'z Pie (DJ A-L Drumapella)"}	3	00:05:19	https://retro-respect.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
595	eevee	unexpected	https://eeveebeats.bandcamp.com/album/unexpected-2?from=discover_page	Netherlands	2016-06-04	https://f4.bcbits.com/img/a3410180856_16.jpg	21.24	{lily,jasmine,azalea,viola,rosemary,salvia,lotus,sakura,dahlia}	9	00:16:10	https://eeveebeats.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
596	Joey Aich	Moments Like These	https://joeyaich.bandcamp.com/album/moments-like-these?from=discover_page	Columbus, Ohio	2025-10-06	https://f4.bcbits.com/img/a4126989654_16.jpg	21.25	{"Moments Like These",Schoolboy,"Die Old ft. Grandace","Footprints ft. Sarob","Take 1 Raise 1",Midsummer,"How Many?","424 West ft. OG VERN","Grind ft. Blueprint","Show Out ft. Trav Hen","After Love ft. N'shai Iman"}	11	00:43:27	https://joeyaich.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
597	Blunt Shelter Records	Jazzbois Goes Blunt	https://bluntshelter.bandcamp.com/album/jazzbois-goes-blunt-2?from=discover_page	Budapest, Hungary	2019-10-23	https://f4.bcbits.com/img/a3007663400_16.jpg	28.00	{Monsun,Jass,"Midnight Drop",Girlfriend,Narctis,Interloop,Beat4,Smoothies,"Make Sum Noiz","Mellow High","Moon Rocks"}	11	00:37:28	https://bluntshelter.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
598	DJ Preservation	Sortilège	https://djpreservation.bandcamp.com/album/sortil-ge?from=discover_page	New York, New York	2025-08-15	https://f4.bcbits.com/img/a0296008877_16.jpg	29.75	{Harmattan,Spire,Shadowstep,"Muay Sok",Bascinet,"Morning Star","Hierophant (feat. Koncept Jack$on)","War (feat. billy woods)","Ball & Chain","Nom De Guerre (feat. Ze Nkoma Mpaga Ni Ngoko)","Respected Calligraphy","Mondo Cane (feat. Armand Hammer & Benjamin Booker)",Kurtz,"Lotus Flower"}	14	00:39:41	https://djpreservation.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
599	clipping.	Wriggle (Expanded)	https://clppng.bandcamp.com/album/wriggle-expanded-2?from=discover_page	Los Angeles, California	2021-05-12	https://f4.bcbits.com/img/a0276252130_16.jpg	19.55	{Intro,Shooter,"Back Up 2021 (feat. Debby Friday & SB The Moor)",Wriggle,"Hot Fuck No Love (feat. Cakes Da Killa & Maxi Wild)","Our Time (feat. Nailah Middleton)","Wriggle (Homemade Weapons Remix)","Back Up (Dave Quam Remix)","Shooter (Jana Rush's Face Rearranged Remix)","Wriggle (Cardopusher's EBM Remix)"}	10	00:38:16	https://clppng.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
600	TELEVANGEL	Montage Music: Director''s Cut	https://televangel.bandcamp.com/album/montage-music-directors-cut?from=discover_page	Portland, Oregon	2025-08-07	https://f4.bcbits.com/img/a2671462049_16.jpg	34.00	{Footloose,Twins,"Weird Science","X Country Feat. AJ Suede","Aurora To 82nd","Tubbs & Crockett",T2,"Oregon Trail","Vince & Jules","Thug On The Spectrum","The Whole Salmon",Streaming}	12	00:39:20	https://televangel.bandcamp.com?from=discover_page	2026-02-23 13:22:19.661536	2026-02-23 13:22:19.661536
601	NOWAAH THE FLOOD	TRILL LIFE MATHEMATIKS III	https://nowaahtheflood7.bandcamp.com/album/trill-life-mathematiks-iii?from=discover_page	Dallas, Texas	2026-01-11	https://f4.bcbits.com/img/a2701748184_16.jpg	85.00	{"FIRES IN KALI",SCIENTIFIK,"IN THE KNOW",FESTIVUS,"LEAN ON ME",FLAMBÉ,"THIS TIME",TRULY,"THE LORD","ROLL UP"}	10	00:19:04	https://nowaahtheflood7.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
602	Poldoore	Chroma Dream (LP)	https://poldoore.bandcamp.com/album/chroma-dream-lp?from=discover_page	Leuven, Belgium	2025-05-30	https://f4.bcbits.com/img/a2578914065_16.jpg	38.25	{"Look Into My Eyes","Bumpy Roads","Take Care Of U","Tears On My Face","Heaven Sent","Dusty Echoes","Soliloquy Interlude","Chroma Dream","Mellow Breeze","Two For One",Landmark,"Step Outside"}	12	00:48:40	https://poldoore.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
603	Kurious	God''s Time	https://kurious.bandcamp.com/album/gods-time?from=discover_page	New York, New York	2025-10-10	https://f4.bcbits.com/img/a3749641651_16.jpg	45.00	{"Birds Fly","No Way Around It",Toilet,"Kids Eating Cereal","When The Coffee Kick In","Cloud Nine",Wonder}	7	00:20:51	https://kurious.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
604	Awon & Phoniks	Golden Era 2	https://awonandphoniks.bandcamp.com/album/golden-era-2?from=discover_page	Newport News, Virginia	2024-08-09	https://f4.bcbits.com/img/a2739546387_16.jpg	27.20	{"King Midas ft. Napoleon Da Legend",Memories,"Grey Skies","Time Waits For No Man",Duality,"Gold Dust ft. Anti Lilly","Pel's Interlude","The Long Run ft. John Robinson","Keep Clear ft. Dephlow","Everything ft. Hex One","Late Night ft. Tiff The Gift","Holograms ft. Demetrius Rhymes","What A Day","Laidback In The Streets ft. V Knuckles","Universal Minds ft. Anti Lilly"}	15	00:40:30	https://awonandphoniks.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
605	Retro-Respect Records	MM.. EDITS	https://retro-respect.bandcamp.com/album/mm-edits?from=discover_page		2021-11-26	https://f4.bcbits.com/img/a0504770292_16.jpg	11.90	{"Super Sweet Hoe Cakes (DJ A-L Blend)","Friendz and Strangerz (DJ A-L Blend)","Kon Karne (DJ A-L Bonus bEats)"}	3	00:06:04	https://retro-respect.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
606	Trellion	Dive By Night	https://lilheartattack.com/album/dive-by-night?from=discover_page	Sheffield, UK	2009-09-04	https://f4.bcbits.com/img/a0108469047_16.jpg	38.61	{"Dive By Night","Muddy Track (ft. Sniff)","Strange Lights (ft Figment)","Wasted in stasis","The night the fog came (ft. Figment)","Moon Beacon (ft. Figment)","Lunaville Island (ft. Figment)","Story of the shadow pt.1","Cardtrix (ft. Sniff)","End of the line (ft. Sniff and Tk1)"}	10	00:27:05	https://lilheartattack.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
607	PLANET SIC	Cold Catalog	https://sicrecords.bandcamp.com/album/cold-catalog?from=discover_page		2025-11-21	https://f4.bcbits.com/img/a1675064124_16.jpg	25.49	{"Down 2 Size (feat. Kemuri Nine4)",Thaiweed,Joey,"Real wit' u",Lonestar,"Down 2 Dust (feat. Kemuri Nine4)",Hudson,"Microphone Wrath (feat. Kemuri Nine4)",Nas,Chills,Backseat,Fog,Wuntwothree,"Clown (feat. Professor Creepshow)",Valentina,"Glass Eyes",Forgotten,"Sleep under northface jackets",Shing02,"Wine 4 Blood"}	20	00:45:15	https://sicrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
608	Real Bad Man	Conversational Pieces	https://realbadman.bandcamp.com/album/conversational-pieces?from=discover_page	Los Angeles, California	2025-05-03	https://f4.bcbits.com/img/a4014887860_16.jpg	54.99	{"Class Clown","Tap the Brakes Twice","ITT Tech","Fear of God (feat. CONWAY the Machine)","Come Back Around (feat. dreamcastmoe)",Cutthroats,Aspen,"Triple Plantinum","Bag It Up","Burn In Hell","It Factor (feat. EL-P)","Say Less","Conversational Pieces"}	13	00:39:22	https://realbadman.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
609	Action Figure 973	DOOM WAS RIGHT	https://actionfigure973.bandcamp.com/album/doom-was-right?from=discover_page	Belleville, New Jersey	2025-05-09	https://f4.bcbits.com/img/a0331503675_16.jpg	127.50	{"TAKE ME TO YOUR LEADER","OPERATION DOOMSDAY",ECHELON,NANLIB,"DAN BEARD","PUERTO RICAN WRESTLING",MMM...FOOD,"MADVILLAINY FEAT. VEGA7 THE RONIN","RAE'S KILLA TAPE FEAT. BLOO AZUL","DOOM TATTOO FEAT. ERICTHERED13","ROMANTIC COMEDY","LATIN PORN IN THE 90'S"}	12	00:35:08	https://actionfigure973.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
610	The Architect	Une plage sur la lune	https://thearchitectone.bandcamp.com/album/une-plage-sur-la-lune?from=discover_page	Saint Étienne, France	2020-06-12	https://f4.bcbits.com/img/a0729993083_16.jpg	30.00	{"Une plage sur la lune",Jacqueline,"Run X Rêverie","Crétin de terrien","Tigerz X Johaz",Darling,"Peanut X DJ Olegg X Kill Emil","Baile De Sol","East Raw X Aaron Cohen X Chip Fu","Sin Jaza X Paz","Boogie Dola X Troy Berkley X Killa P","Watch Me Dance",Rêve,"Royom X Fliptrix","Nulle Part X Ours Samplus"}	15	00:54:46	https://thearchitectone.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
611	Apollo Brown	SARDINES	https://apollobrown360.bandcamp.com/album/sardines?from=discover_page	Detroit, Michigan	2023-09-08	https://f4.bcbits.com/img/a2088105779_16.jpg	27.20	{"Bird Food","Get The Dough Off","Panama Sun (feat. Marv Won)",Stones,"Fly Anomalies","Wizardry (feat. TriState)","Jungle Juice","Wide Awake","Acid Rain (feat. Sick Jacken)","Peas & Onions","Broad Dayin'","'88 S-Curl (feat. Ty Farris)",Bazookas,"Can You Believe It"}	14	00:46:34	https://apollobrown360.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
612	Henry Canyons & Fresh Kils	Educated Guesses	https://henrycanyons-freshkils.bandcamp.com/album/educated-guesses?from=discover_page	Brooklyn, New York	2025-02-14	https://f4.bcbits.com/img/a1271278939_16.jpg	20.40	{"Show & Tell","Henry Canyons, Fresh Kils, Solemn Brigham - Eeyeah","Henry Canyons, Fresh Kils, Ollie Chanin - Move Back","Henry Canyons, Fresh Kils, ShrapKnel - Pulse Cheque","Been Around The World","From Here","Henry Canyons, Fresh Kils, Mike Ladd - Arts & Leisure",Wash}	8	00:31:02	https://henrycanyons-freshkils.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
613	L''Orange	Time? Astonishing!	https://lorange360.bandcamp.com/album/time-astonishing?from=discover_page	North Carolina	2015-07-24	https://f4.bcbits.com/img/a2352108689_16.jpg	21.25	{"Time? Astonishing! (inst.)","The Traveler (feat. J-Live)","The Green Ray","Twenty Fifty Three (feat. Mr. Lif)","Meanwhile, Back Home (feat. Open Mike Eagle)","The Wanderer","This New World (feat. Blu, Montage One & DJ Trackstar)","Dr. Bipolar","Suspended Animation (feat. MC Paul Barman) (Interlude)","I Need Out Of This World (feat. MindsOne)","Upwards. To Space!","Days I Used To Know (inst.)","Bonus: Sometimes I Feel"}	13	00:33:31	https://lorange360.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
614	Digga Please?	Get It On / Hipness	https://diggaplease.bandcamp.com/album/get-it-on-hipness?from=discover_page	London, UK	2024-12-06	https://f4.bcbits.com/img/a0871448116_16.jpg	17.54	{"Get It On",Hipness}	2	00:07:55	https://diggaplease.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
615	Nordachse CashGroup	S1	https://nordachsecashgroup.bandcamp.com/album/s1?from=discover_page	Berlin, Germany	2022-11-15	https://f4.bcbits.com/img/a2447411832_16.jpg	26.99	{Intro,"Unter Strom","Prahlen Und Vorangehen",Fame,Vogelperspektive,"Motiviert (feat. Saftboys & Klapse Mane)","Interlude 1","Back 2 The Streets",Nordberliner,Diskohengst,"Papi Chulo","Elefantenrunde (feat. Morlockk Dilemma)","Interlude 2","Endstation S1 (feat. Ivo Der Bandit, Tiger 104er, G.G.B & MC Kneipenkrieger)","Da Seh Ich Mich","Mein Streifen","Neuer Morgen"}	17	00:45:47	https://nordachsecashgroup.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
616	Valid	Peach Brandy	https://valid313.bandcamp.com/album/peach-brandy?from=discover_page	Detroit, Michigan	2024-07-26	https://f4.bcbits.com/img/a3203147874_16.jpg	25.50	{"Peach Slayer","There He Is","One Of A Kind",Places,"Nine To Five (Ft. Stretch Money)","May 6th","Never Question (ft. Neisha Neshae)","The One Who Decides","Plush (ft. Boog Brown)",Sci-Non-Fi,"Cigareta (Ft. Jon Connor & Philmore Greene)","Stara Škola (ft. BARS, Ghet, Random, Frenkie, LD Pistolero, & Struka)",Nirdala,"This Day","Graycious (ft. Koolade)"}	15	00:52:08	https://valid313.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
617	The Jazz Hop Café	Thank You for the Tragedy, I Need It for My Art.	https://jazzhopcafe.bandcamp.com/album/thank-you-for-the-tragedy-i-need-it-for-my-art?from=discover_page	England, UK	2025-08-04	https://f4.bcbits.com/img/a0388129995_16.jpg	25.74	{"MAXGONZ - Jazz It Up","Nicobox - Saudade","LVDS - Jazz & Ashes","Soulwanderer - Citrus","iwamizu - Enri","Innigma - Light Green","Tuelv & Lez Lemon - Worth A Lot","Erwin Do & Toti Cisneros - Spinnin'","Eastern Sage - Stomata","Aphrow - Morning Vibe","hotpotatoes, saint rumi & Erwin Do - Making Moves","P.R. - Figuring Things Out","kf13 - rule","Soulwanderer - Orange","Simber & Dreamfield - Sunset Beach","untldrm - Smoked","Devon Rea - Floating"}	17	00:41:47	https://jazzhopcafe.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
618	Chillhop Music	Chillhop Timezones Nigeria	https://chillhop.bandcamp.com/album/chillhop-timezones-nigeria?from=discover_page	Rotterdam, Netherlands	2025-05-15	https://f4.bcbits.com/img/a3937283836_16.jpg	34.00	{"Dunnie, Mac Kay - Ayọ̀","Trill Xoe, JohnWav - Marina Blues","Lady Donli, Ruck P - Tarkwa Bay","Nsikak David, Ian Ewing - Lagos Sundown","Wondamagik - Alone Together","Le Mav - The Cleanest","Sholz, Arieenati - Gusto","Louddaaa - Hope","Wondamagik, less.people - Wonderless","Suté Iwar - Close Ties","Nsikak David - Emem","Yinka Bernie - Pace Thyself","Yimeeka - Omi","Sholz, Kreatev - Land Cruiser","Lady Donli, JMS - WantU2Stay","Le Mav, DESH - Fridays","Suté Iwar, chromo, the dreamer - Dooshima’s Groove","Dunnie - Elope","Louddaaa, Molly McPhaul - Overnight","Yimeeka, Stan Forebee - Isimi","Trill Xoe, Kissamilé - Èkó Rhythm","Yinka Bernie, No Spirit - Day Before Yesterday"}	22	00:57:39	https://chillhop.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
619	Opulent Recordings	Regal	https://opulentrecordings.bandcamp.com/album/regal?from=discover_page	Indianapolis, Indiana	2024-06-20	https://f4.bcbits.com/img/a3905441597_16.jpg	25.50	{Sayumi,Atlantis,Quicksand,"On My Side","Granny's Mints","Bend Don't Break",Krush,Queen,Mystique,Textures}	10	00:30:20	https://opulentrecordings.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
620	Gyptology Records	Curtom Gold-Breax Vol. 1	https://gyptology.bandcamp.com/album/curtom-gold-breax-vol-1?from=discover_page	Luxor, Egypt	2021-10-11	https://f4.bcbits.com/img/a0967006454_16.jpg	11.70	{"Leroy Hutson - Never Know What You Can Do","June Conquest - All I Need","Mavis Staples - Chocolate City","Arnold Blair - Trying To Get Next To You","Linda Clifford - Runaway Love 7min Version","Curtis Mayfield - Do Do Wap Is Strong Here","Leroy Hutson - Blackberry Jam","Mavis Staples - Koochie Koochie Koochie","The Notations - Superpeople","Curtis Mayfield - Here But I'm Gone"}	10	00:44:18	https://gyptology.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
621	JayaHadADream	Redemption Songs	https://jayahadadream.bandcamp.com/album/redemption-songs?from=discover_page	UK	2024-08-23	https://f4.bcbits.com/img/a0084973795_16.jpg	35.10	{"Hold It Down",Stubborn,Twiggy,"Ur In Love","Sunny Day","Redemption Songs"}	6	00:20:00	https://jayahadadream.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
622	Trad Vibe Records	CORTEX - INEDIT 79	https://tradviberecords.bandcamp.com/album/cortex-inedit-79?from=discover_page	Nantes, France	2025-08-02	https://f4.bcbits.com/img/a2805564554_16.jpg	35.00	{"I Heard A Sigh","Back To My World","Said I Do","A Winning Team","High On The Funk","Bring My Bonnie Back",Moanin',"Stand And Move","Hannibal March","The Sky Is Grey,I'm So Blue",Maïlys,Emily}	12	00:52:32	https://tradviberecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
623	Tea Breaks (45s)	BREATH & STOP	https://teabreaks.bandcamp.com/album/breath-stop?from=discover_page	Todmorden, UK	2025-05-29	https://f4.bcbits.com/img/a0452612290_16.jpg	11.70	{"BREATH & STOP","TEA & BEER","BROAD NOD FACTOR","MS FAT BOOTY"}	4	00:08:41	https://teabreaks.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
624	Kero One	Qtip - Breathe / Playaz (Edits 7”)	https://keroone.bandcamp.com/album/qtip-breathe-playaz-edits-7?from=discover_page	Los Angeles, California	2025-07-14	https://f4.bcbits.com/img/a4279587191_16.jpg	17.00	{"Breathe (Lafufu edit)","Playaz (Lafufu edit)"}	2	00:07:16	https://keroone.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
675	Richie Cunning	Night Train	https://richiecunning.bandcamp.com/album/night-train?from=discover_page	San Francisco	2010-01-15	https://f4.bcbits.com/img/a0881029057_16.jpg	42.50	{"The Station","Work It Out","One Dollar Wonder","The City","Transfer Pt. I","Still Livin'",Trainjumpin',Smoke,"Transfer Pt. II","The Cold","Night Train","Last Stop"}	12	00:44:41	https://richiecunning.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
625	BBGuns	RUST BELT	https://bbguns.bandcamp.com/album/rust-belt?from=discover_page	Pittsburgh, Pennsylvania	2026-01-16	https://f4.bcbits.com/img/a1143134851_16.jpg	25.50	{"Lich (prod. by Height Keech)","Unk (prod. by Height Keech)","Outlanders (feat. AARIE) (prod. by Height Keech)","Float (feat. Eliy Orcko, Cain Canary, M.E.L.T.) (prod. by q no rap name)","Crying in Walmart (prod. by Height Keech)","Cooked (feat. Copywrite) (prod. by Height Keech)","Dungeons of Rap (prod. by Billy Hoyle)","Soul Stoned (prod. by Height Keech)","Fire Walk with Me (prod. by Height Keech)","Ixion's Feast (feat. Cory Eaux) (prod. by Billy Hoyle)","I'm Afraid That Love is Not Enough (prod. by C. Scott)"}	11	00:41:28	https://bbguns.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
626	The Allergies	Promised Land	https://theallergies.bandcamp.com/album/promised-land?from=discover_page	Bristol, UK	2021-10-01	https://f4.bcbits.com/img/a2259172159_16.jpg	25.73	{"Lean on You (feat. Dynamite MC)","Love Somebody","Promised Land","New Thing","Utility Man (feat. Andy Cooper)","Move On Baby","Going to the Party (feat. Lyrics Born)","Are You Ready (feat. Andy Cooper & Marietta Smith)","Working On Me","Jumping Off","The Beat","Up Down Left Right (feat. Andy Cooper & Marietta Smith)",You}	\N	00:58:10	https://theallergies.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
627	DANGERDOOM	The Mouse & The Mask	https://dangerdoom.bandcamp.com/album/the-mouse-the-mask?from=discover_page	New York, New York	2005-10-10	https://f4.bcbits.com/img/a3992669689_16.jpg	35.10	{"El Chupa Nibre","Sofa King","The Mask Feat. Ghostface Killah","Perfect Hair","Benzi Box Feat. Cee-Lo Green","Old School Rules Feat. Talib Kweli","A.T.H.F. (Aqua Teen Hunger Force)","Basket Case","No Names (Black Debbie)",Crosshairs,"Mince Meat","Vats of Urine","Space Ho's","Bada Bing","Sofa King (Danger Mouse Remix) Feat. Danger Mouse","Space Ho's (Madlib Remix) Feat. Madlib"}	16	00:46:37	https://dangerdoom.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
628	Roots Manuva	Run Come Save Me	https://rootsmanuva.bandcamp.com/album/run-come-save-me?from=discover_page	London, UK	2001-08-01	https://f4.bcbits.com/img/a2484407380_16.jpg	28.05	{"No Strings (Intro)","Bashment Boogie (feat. Ricky Ranking)","Witness (1 Hope)","Join The Dots (feat. Chali 2na)","Black Box interlude","Ital Visions","Kicking The Cack","Dub Styles","Trim Body",Artical,"Hol' It Up (feat. Riddla)","Stone The Crows","Sinny Sin Sins","Evil Rabbit","Roots Manuva featuring Skeme, Niara Scarlett, Big P, Rodney P, Blackitude and Fallacy & Skeme & Niar - Swords In The Dirt","Roots Manuva featuring Seanie T & Seanie T - Highest Grade","Dreamy Days"}	17	00:58:01	https://rootsmanuva.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
629	Mega Ran	Buddy’s Magic Tree House	https://megaranmusic.com/album/buddy-s-magic-tree-house?from=discover_page	Phoenix, Arizona	2025-06-27	https://f4.bcbits.com/img/a4267833380_16.jpg	22.10	{"Good Morning","Have A Great Time!","I Love That Guy","The Library Jawn","Dino Stomp On The Playground","Just Like That","Brush Them Teeth!","A Bit Of Advice","You're Enough","Water Plug (Splish Splash)","The Alphabet Jawn","Why Do People Go?","Inventors pt 1&2","Sing A Song (for Miss Ella)"}	14	00:43:38	https://megaranmusic.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
630	Dälek	Negro Necro Nekros	https://dalek.bandcamp.com/album/negro-necro-nekros?from=discover_page	Union City, New Jersey	2024-05-10	https://f4.bcbits.com/img/a1509283514_16.jpg	31.45	{"Swollen Tongue Bums","Three Rocks Blessed","Images of .44 Casings","The Untraveled Road","Praise Be the Man","And Hell is Coming with Us","Pelt I’s to End (Demo Instrumental)","Gates of Dawn (Instrumental)","Praise Be the Man (Remix)","Cement (Demo Instrumental)","Sweetwood Sound Session 404"}	11	01:11:00	https://dalek.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
631	Chlorine Free	nEW bASICS #1	https://chlorinefree.bandcamp.com/album/new-basics-1?from=discover_page	Paris, France	2025-06-19	https://f4.bcbits.com/img/a0230621245_16.jpg	25.00	{"Don't Let the Gang Down","Elevation (Feat.Raashan Ahmad)","Bass Bass Bass","Come Alone (Feat.Days & Mike Ladd)","Basics (Feat.Days)","The Claw","Driver Seat (Feat. Nya)","Nasty Fit","Dangerously Lazy","Recreation (Feat.Days)","BONUS TRACK Elevation instrumental extended"}	11	00:45:37	https://chlorinefree.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
632	Nell	90s Mentality	https://neweranell.bandcamp.com/album/90s-mentality?from=discover_page	Miami, Florida	2025-12-19	https://f4.bcbits.com/img/a1428470479_16.jpg	42.50	{Intro,"Just Smoke","Pistol Grip","Break Yo self","275 be the team","Swangin & Bangin","Da Phonky South","Southside Worldwide","The Mac","Smoke Dat shit","Weed & Brews","G - Phonk","Back in the dayz","Freestyle Skit","What can I do","Serving Da Fiends","Smoke & Ride","Southern Hospitality","Bone Verses","Dre Day Freestyle",Vicious,"38 Hott","Shots From The Double Glock","Puerto Banus",Bars,"Hvzy  Trips","Trippy Phonk",Slangin,"Mask & the glock"}	29	01:35:09	https://neweranell.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
633	The Expert	Ritual	https://theexpert.bandcamp.com/album/ritual?from=discover_page	Dublin, Ireland	2023-06-16	https://f4.bcbits.com/img/a0316368825_16.jpg	25.00	{BlacAmerica,"Uknowhut? (ft. Blu)","Cost Of Business","Rob Peter, Pay Pallbearer (ft. Daniel Luke)","Slo Pokes","The Green Monster (ft. Solemn Brigham)","Zambezi Zinger (ft. Tanya Morgan)","Lonely Planet","Yah's Shorthand","Service (ft. Defcee)","President Streets","The All (ft. Sleep Sinatra)","The Forgotten"}	13	00:35:55	https://theexpert.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
634	Kero One	Glory Remixes	https://keroone.bandcamp.com/album/glory-remixes?from=discover_page	Los Angeles, California	2024-09-18	https://f4.bcbits.com/img/a1802393921_16.jpg	17.00	{"Glory remix (24 bit hi​​​-​​​res)","Roads Remix (24 bit hi​​​-​​​res)"}	2	00:06:04	https://keroone.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
635	Digga Please?	Bigger Than Jamrock / Sleng Hop	https://diggaplease.bandcamp.com/album/bigger-than-jamrock-sleng-hop?from=discover_page	London, UK	2023-08-04	https://f4.bcbits.com/img/a0454270575_16.jpg	17.54	{"Bigger Than Jamrock","Sleng Hop"}	2	00:07:37	https://diggaplease.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
648	Silk Road Assassins	State Of Ruin	https://silkroadassassins.bandcamp.com/album/state-of-ruin?from=discover_page	Bath, UK	2019-02-08	https://f4.bcbits.com/img/a2842479001_16.jpg	22.22	{Overgrown,"Split Matter (ft. Kuedo)",Armament,Vessel,Familiars,Bloom,"Pulling The String",Bowman,"Shadow Realm (ft. WWWINGS)","Taste Of Metal (Instrumental)",Saint,"Feeling Blu",Thorns,Blink}	14	00:43:30	https://silkroadassassins.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
636	Run The Jewels	Run The Jewels 10th Anniversary Edition	https://runthejewels.bandcamp.com/album/run-the-jewels-10th-anniversary-edition?from=discover_page	Brooklyn, New York	2023-10-09	https://f4.bcbits.com/img/a3448793650_16.jpg	39.08	{"Run The Jewels","Banana Clipper (feat. Big Boi)","36\\" Chain",DDFH,"Sea Legs","Job Well Done (feat. Until the Ribbon Breaks)","No Come Down","Get It","Twin Hype Back (feat. Prince Paul)","A Christmas Fucking Miracle","Run The Jewels (Instrumental)","Banana Clipper (Instrumental)","36\\" Chain (Instrumental)","DDFH (Instrumental)","Sea Legs (Instrumental)","Job Well Done (feat. Until the Ribbon Breaks) (Instrumental)","No Come Down (Instrumental)","Get It (Instrumental)","Twin Hype Back (feat. Prince Paul) (Instrumental)","A Christmas Fucking Miracle (Instrumental)"}	20	01:06:02	https://runthejewels.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
637	Digga Please?	Dancehall Scenario / Bashment Buddy	https://diggaplease.bandcamp.com/album/dancehall-scenario-bashment-buddy?from=discover_page	London, UK	2024-05-03	https://f4.bcbits.com/img/a3454459073_16.jpg	17.54	{"Dancehall Scenario","Bashment Buddy"}	2	00:08:52	https://diggaplease.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
638	Sampa The Great	Birds And The BEE9	https://sampathegreat.bandcamp.com/album/birds-and-the-bee9?from=discover_page	Melbourne, Australia	2017-11-10	https://f4.bcbits.com/img/a0212942528_16.jpg	23.38	{Healing,"Flowers (feat. REMI)","Protect Your Queen","Rhymes To The East","Can I Get a Key","Black Girl Magik (feat. Nicole Gumbe)","Casper (feat. Syreneyiscreamy)","Karma The Villain","Bye River","Inner Voice (feat. Mwanje Tembo)","The Truth","I Am Me","Healer (feat. Zaachariaha)"}	13	00:50:12	https://sampathegreat.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
639	Esbe	Late Night Headphones Vol. 3	https://switchy.bandcamp.com/album/late-night-headphones-vol-3-2?from=discover_page	Los Angeles	2025-07-25	https://f4.bcbits.com/img/a3225652480_16.jpg	32.30	{Sing,"Like This","Breakbeat Kids",Purity,Someday,Fo(u)nd,"Winter Solstice","Vibes Up","Where You Are","No Regrets","Jazz ‘n’ Stuff","Green Eyed","Dusty Finger",Lush,"Thinking Of When",Addicted,"Future Talk","Full Moon Sway"}	18	01:14:49	https://switchy.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
640	Memphis Rap collection	Da Hard Ov Frayser	https://memphisrap.bandcamp.com/album/da-hard-ov-frayser?from=discover_page	Memphis, Tennessee	2024-10-15	https://f4.bcbits.com/img/a1333995914_16.jpg	23.80	{Intro,"Ridgecrest Anthem","Down With The Click","Glock-Tight Smoked-Out","Ridgecrest Taking Over",Interlude,"Dead In His tracks","I Just Need Yo Cheese (ft. Nigga Creep)","Load The Ammo","Shout Outs (ft. Dirty Red & Lil' Bay)","Bout Our Hogg Outro"}	11	00:38:30	https://memphisrap.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
641	Sampa The Great	Emi Aluta (Zamrock Remix)	https://sampathegreat.bandcamp.com/album/emi-aluta-zamrock-remix?from=discover_page	Melbourne, Australia	2025-02-14	https://f4.bcbits.com/img/a1938286363_16.jpg	12.00	{"Emi Aluta (Zamrock Remix)","Emi Aluta (45 Edit)"}	2	00:07:19	https://sampathegreat.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
642	Perpetual Stew Goods	The Apes That Was Left Behind	https://perpetualstew.bandcamp.com/album/the-apes-that-was-left-behind?from=discover_page	Gresham, Oregon	2025-09-26	https://f4.bcbits.com/img/a0330035927_16.jpg	34.00	{"Blood Sofa","Otto From The Simpson","Damaged Wraith","Crawfish Stew","Distorted Views",Fittsburgh,"Bodybag Registry","Ain't No King Of Chicago","UPS Has My Sneakers",Jimshoe,"Poisonous Calamari","PF Cuttin' Invasion",iBrowse,Immediately,"Ear Wax"}	15	00:44:39	https://perpetualstew.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
643	DEGIHEUGI	Degiheugi - Dancing chords and fireflies	https://endlesssmile.bandcamp.com/album/degiheugi-dancing-chords-and-fireflies?from=discover_page	Leeward Islands, French Polynesia	2012-11-12	https://f4.bcbits.com/img/a4203481097_16.jpg	35.00	{"Some beat in my head","Interlude 1 / Only a dance","In the shadow","You ! (feat. Miscellaneous)","Interlude 2 / Les portes de l'harmonie","Interlude 3 / Degi's goomies",Finalement,"Touché (feat. Miscellaneous)","The consumer (Sold, make money, get rich and buy)","I know a woman (feat. Astrid Van Peeterssen & Andrre)","Interlude 4 / Oh yes !","Dancing chords and fireflies","I touch your lips","Embers (feat. Pierre the Motionless & Brzowski)","Interlude 5 / Lo-fi recreation",L.O.V.E,"The loop (feat. Miscellaneous)","More than abstract hip-hop","Un jour comme un autre",Venise}	21	01:19:34	https://endlesssmile.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
644	Monster Rally	Flowering Jungle	https://monsterrally.bandcamp.com/album/flowering-jungle?from=discover_page	Los Angeles, California	2017-12-15	https://f4.bcbits.com/img/a2885883802_16.jpg	23.79	{"Sunny Sloth",Toucans,"Vaqueros De La Isla",Tideline,"Las Bambinas De La Selva",Sunshine,"Lights From Lahaina",Love,"Giant Leaves","Bahia Mar",Río,"Jungle Cruise","Hot Flash","Sweet Fire",Tropico,"Let's Go Faraway"}	16	00:36:40	https://monsterrally.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
645	Monster Rally	Botanica Dream	https://monsterrally.bandcamp.com/album/botanica-dream?from=discover_page	Los Angeles, California	2022-07-22	https://f4.bcbits.com/img/a3885421946_16.jpg	23.79	{"Golden Shores","Flowers in the Air","Lily Pad","Through the Jasmine","Grassy Crystals","Imaginary Palms",Honeysuckle,"Torchlit Cenote","Moon Flower Bloom","Isle Eyes","Island Hopping","Fever Dream (We'll Never Forget This Place)","Willows Hymn","Phthalo Blue",McGilacuddy,"Hanging Gardens"}	16	00:43:44	https://monsterrally.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
646	Blunt Shelter Records	Lunar Flow & Sunwave Sessions	https://bluntshelter.bandcamp.com/album/lunar-flow-sunwave-sessions?from=discover_page	Budapest, Hungary	2025-09-26	https://f4.bcbits.com/img/a2518594587_16.jpg	28.00	{"We've Got The Music",Sunwave,Waiting,"Morning Swing","Love Interlude",Hinode,"Solar Brazil",Melodies,"Good Ol Times","We'll Be Right Back","Night Break",Cannonball,"Moon Beams","One 4 Wun Two","Lunar Flow","Silent Steps","After Hours","Sayonara (feat. Leavv)","Summer Groove"}	19	00:41:44	https://bluntshelter.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
647	Mounika.	Don''t look at me	https://mounika.bandcamp.com/album/dont-look-at-me?from=discover_page	Tours, France	2023-05-12	https://f4.bcbits.com/img/a0233425908_16.jpg	20.00	{20,"little love (ft. Roland Faunte)","I Looked into Her Eyes (ft. Ural Thomas & The Pain)",BonXair,Nomadics,"See you dancing in the dark",Emotional,"don't smoke","thinking of","Memories (ft. Lord Apex)",Dreams,Mo1994by,cuzratatat,aye,"When my heart in your heart","Outro (end of the Part.1)",Piano6}	17	00:47:24	https://mounika.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
650	LabOhr	Wolken aus Beton	https://labohr.bandcamp.com/album/wolken-aus-beton?from=discover_page	Thuringia, Germany	2026-02-06	https://f4.bcbits.com/img/a2066529107_16.jpg	18.00	{"Intro (feat. DJ Ceeriouz)","Wolken aus Beton (feat. Stevie Drumz)","Eins für die Liebe","Nasi Goreng (feat. Ol Dirty T-Shirt)","Politik (feat. Stevie Drumz)","Windbreaker (feat. Slize & DJ Chuck Borris)","Hardcore (feat. Lazer Pi & Reibe)","Psycho Killa (feat. Norman Gein & Ol Dirty T-Shirt)","Taugenichtse (feat. Joeseph Hill)","Nebula (feat. Colt Seevaz)","Galaxien und Planeten (feat. Stevie Drumz)","Outro (feat. DJ Ceeriouz)"}	12	00:34:19	https://labohr.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
651	Dälek	Endangered Philosophies	https://dalek.bandcamp.com/album/endangered-philosophies?from=discover_page	Union City, New Jersey	2017-09-01	https://f4.bcbits.com/img/a1157126491_16.jpg	23.80	{"Echoes Of...",Weapons,"Few Understand","The Son of Immigrants","Beyond the Madness",Sacrifice,"Nothing Stays Permanent","A Collective Cancelled Thought",Battlecries,"Straight Razors",Numb}	11	00:55:38	https://dalek.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
652	The Allergies	Knock Me Off My Feet	https://theallergies.bandcamp.com/album/knock-me-off-my-feet?from=discover_page	Bristol, UK	2024-10-25	https://f4.bcbits.com/img/a0565331354_16.jpg	10.52	{"Knock Me Off My Feet"}	1	00:03:13	https://theallergies.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
653	Beats & Culture	BNC004 - Prisma & Martin Boder feat. Maria Barone, Umoja	https://beatsnculture.bandcamp.com/album/bnc004-prisma-martin-boder-feat-maria-barone-umoja?from=discover_page	Athens, Greece	2022-06-10	https://f4.bcbits.com/img/a1238441161_16.jpg	11.50	{"Prisma & Martin Boder feat. Maria Barone - Turbina de amor","Umoja - Rabia"}	2	00:08:29	https://beatsnculture.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
654	The Allergies	Mash Up The Sound	https://theallergies.bandcamp.com/album/mash-up-the-sound?from=discover_page	Bristol, UK	2023-02-24	https://f4.bcbits.com/img/a0634838271_16.jpg	10.52	{"Mash Up The Sound"}	1	00:03:34	https://theallergies.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
655	MÄDNESS	MAGGO LEBT	https://maedness.bandcamp.com/album/maggo-lebt?from=discover_page	Berlin, Germany	2023-06-25	https://f4.bcbits.com/img/a2850787129_16.jpg	20.00	{"Maggo lebt",Geschichte,Klappergasse,"Lass gehen lass los (feat. Fatoni)","Nicht anders","Kommt vor (feat. Amewu)",Casio}	7	00:20:27	https://maedness.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
656	Run The Jewels	Run The Jewels 2 10th Anniversary Edition	https://runthejewels.bandcamp.com/album/run-the-jewels-2-10th-anniversary-edition?from=discover_page	Brooklyn, New York	2024-10-24	https://f4.bcbits.com/img/a2462658165_16.jpg	38.23	{Jeopardy,"Oh My Darling Dont Cry","Blockbuster Night Part 1","Close Your Eyes (And Count To Fuck) (Feat. Zack De La Rocha)","All My Life","Lie, Cheat, Steal","Early (feat. BOOTS)","All Due Respect (feat. Travis Barker)","Love Again (Akinyele Back) (feat. Gangsta Boo)","Crown (feat. Diane Coffee)","Angel Duster","Blockbuster Night Part 2 (feat. Despot & Wiki)"}	\N	00:48:00	https://runthejewels.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
657	Davodka	Boite Noire	https://davodkalv2t.bandcamp.com/album/boite-noire?from=discover_page	Paris, France	2026-01-30	https://f4.bcbits.com/img/a1229673346_16.jpg	25.00	{"S au S",TVPLM,"Plus on est de fous, plus on rime (feat. L’Uzine)","Cocktail monotone",Misanthrope,"Ecchymose (feat. Hidan)","Requiem for a drill","Des joies des peines (feat. Hash 24)","Aux commandes",Loser,"En silence","Ce qu'ils veulent (feat Dady S)",Fatality}	13	00:38:27	https://davodkalv2t.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
658	Grand Tapestry	Tides	https://grandtapestry.bandcamp.com/album/tides?from=discover_page	Los Angeles, California	2020-10-23	https://f4.bcbits.com/img/a0006753342_16.jpg	21.25	{"Seagulls (feat. Raaginder & Kamaljeet Ahluwalia)",Tides,Believe,"Radiant (feat. Zumbi & Jay Gandhi)",Youth,"Iman Kalyan (Evening Raga)","Seagulls (Instrumental) feat. Raaginder & Kamaljeet Ahluwalia","Tides (Instrumental)","Believe (Instrumental)"}	9	00:36:29	https://grandtapestry.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
659	MF DOOM	JJ DOOM - Key To The Kuffs	https://mfdoom.bandcamp.com/album/jj-doom-key-to-the-kuffs?from=discover_page		2012-08-20	https://f4.bcbits.com/img/a3572542506_16.jpg	32.76	{Waterlogged,Guv'nor,Banished,"Bite The Thong feat. Damon Albarn","Rhymin Slang","Dawg Friendly","Borin Convo","Snatch That Dough","GMO feat. Beth Gibbons","Bout The Shoes feat. Boston Fielder","Winter Blues","Still Kaps feat. Khujo Goodie","Retarded Fren","Viberian Sun Part II","Wash Your Hands"}	15	00:42:06	https://mfdoom.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
660	Koralle	Collecting Vol. 2	https://koralle.bandcamp.com/album/collecting-vol-2?from=discover_page	Bologna, Italy	2019-09-27	https://f4.bcbits.com/img/a1627705754_16.jpg	20.00	{River,"Gettin' Mine","In My Room",Metro,"Night Train",Birds,Escape,Weed,"When We First Met"}	9	00:20:57	https://koralle.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
661	The Skull Eclipses	The Skull Eclipses	https://theskulleclipses.bandcamp.com/album/the-skull-eclipses?from=discover_page	Austin, Texas	2018-03-09	https://f4.bcbits.com/img/a4287145174_16.jpg	17.85	{"Yearn Infinite I","All Fall (feat. Def Rain)","Angels Don't Mind","Pillars (feat. Baba Maraire & Felicia Douglass)","Take My",Encyclopedia,"Gone (feat. Open Mike Eagle)","Gun Glitters (feat. Lojii)","Pushing Up the Hills","Yearn Infinite II (feat. Laraaji)","Spacecrafts in Rajasthan"}	11	00:38:45	https://theskulleclipses.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
662	Valid	Bill & Isiah	https://valid313.bandcamp.com/album/bill-isiah?from=discover_page	Detroit, Michigan	2025-03-27	https://f4.bcbits.com/img/a3715811415_16.jpg	17.00	{"89' Cadillacs","You Know I Like It","Revenge (Ft. Booster & Aaron Taylor)","Game Film","Sentimental (Ft. Kelly Kerr)","The Girls",Commentate,"Eastern Conference Finals","Drink With Me","So Divine","Like This"}	11	00:36:29	https://valid313.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
663	MK Ortiz	Ask God for Help	https://mk-ortiz.bandcamp.com/album/ask-god-for-help?from=discover_page	Granada, Spain	2025-05-02	https://f4.bcbits.com/img/a2892983430_16.jpg	27.90	{"Heart of Bullets","On The Road feat. Bub Styles & Cousin Feo","Leonard Nimoy feat. SmooVth & Falcon Outlaw","Chequing Balances feat. Shottie","For Help (Instrumental)","Debaucherous Diary","Married To Money",Tabernacle321,"Ask God","Para Ti feat. Maze Overlay"}	10	00:30:04	https://mk-ortiz.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
664	SHABAAM SAHDEEQ	Timeless: of the Collection ( ALBUM )	https://shabaamsahdeeq.bandcamp.com/album/timeless-of-the-collection-album?from=discover_page	Brooklyn, New York	2018-01-01	https://f4.bcbits.com/img/a4083286211_16.jpg	29.75	{"black book session","Fly script","its a must","Get up & Get it",Bars,"Freedom (Remix)","Shabaam sahdeeq - Elevate","Street Code","Cold Corners","Graffiti the World",Darkness,Haters,"Love You","Grown Man Rap (GMR)",Limitless,Timeless,"Darkness (Remix)"}	17	01:02:07	https://shabaamsahdeeq.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
665	DDM (Drowning Dog and Malatesta)	Critical Beats (2003)	https://drowningdogandmalatesta.bandcamp.com/album/critical-beats-2003?from=discover_page	Berlin, Germany	2024-07-31	https://f4.bcbits.com/img/a1503039637_16.jpg	20.00	{"Freedom Now","American Nightmare","Policy Of Genocide","Police State","Entartete Kunst","Neo Liberalism Is A Hate Crime"}	6	00:28:17	https://drowningdogandmalatesta.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
666	Black Rain Entertainment	Conspiracy Theory	https://blackrainentertainment.bandcamp.com/album/conspiracy-theory?from=discover_page	Memphis, Tennessee	2022-04-01	https://f4.bcbits.com/img/a3427038194_16.jpg	25.50	{Intro,"Here It Is","Blood In Blood Out","Let The Hammer Go","What U Know (Featuring Kingpin Skinny Pimp & Wylecat)","I'm In It","Mary Jane (Featuring Area 51)","Benz Lacs (Featuring Odd 1)","Nigga 4 Da Job","Mr. Big Man.","Look Deep In Da Eyes","What U Doing 4 It (Featuring J-Love)","Make a Scene (Featuring C.I.A.)","Da Ghetto (Featuring Chilly Rakin)","No Remorse (Featuring Lyrical Child, 6ix Shot & C-Mac)","International Terrorists (Featuring C.I.A., Wylecat, Miss T., Da Crime-Click, Area-51, II Tone & 240 North)",Outro}	17	01:13:56	https://blackrainentertainment.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
667	Shaka Amazulu The 7th	School Of The Gifted 0.1 (Al-Hajar-Ul-Aswad Edition)	https://shakaamazuluthe7th.bandcamp.com/album/school-of-the-gifted-01-al-hajar-ul-aswad-edition?from=discover_page	Bhutan	2021-06-04	https://f4.bcbits.com/img/a4157655701_16.jpg	59.50	{"Black Sunday ft. Black Knights [Crisis & Rugged Monk] (USA) & Cali Vera (Argentina)","Monday Morning ft. Napoleon (USA), Dogge Doggelito (Sweden)","Tuesday Never Comes ft. Godzkilla, MC NoFoil, Scratch by NASTAV (Russia), American Poets 2099 [The Holocaust & Masta of Ceremoniez] (USA)","Ash Wednesday  ft. Hírwevők [Skuga & Dhok] (Hungary), Solomon Childs, Rubbabandz (USA)","Stormy Thursday ft. Warstar (Poland), Shaka Amazulu the 7th (UK)","Next Friday ft. Loki The MC (South Africa), ANA MC beretta bronze (Mexico), Rubbabandz (USA)","Six Days To Saturday  ft. African Killa Beez [Leggazin Fin (Angola/Portugal), Shaka Amazulu the 7th (Ghana/Grenada/UK)], Kinetic 9 (USA)","Sunday Instrumental (CD Only)","Monday Instrumental (CD Only)","Tuesday Instrumental (CD Only)","Wednesday Instrumental (CD Only)","Thursday Instrumental (CD Only)","Friday Instrumental (CD Only)","Saturday Instrumental (CD Only)"}	7	00:23:57	https://shakaamazuluthe7th.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
668	Howard Stevens Music	Greedy Fingers ft MF DOOM & Megalon I Sell Rhymes Like Dimes Remastered Version	https://howardstevensmusic.bandcamp.com/album/greedy-fingers-ft-mf-doom-megalon-i-sell-rhymes-like-dimes-remastered-version?from=discover_page	Germany	2022-01-21	https://f4.bcbits.com/img/a1766948314_16.jpg	11.69	{"Greedy Fingers ft MF DOOM & Megalon I Sell Rhymes Like Dimes Remastered Version","Greedy Fingers ft MF DOOM & Megalon I Sell Rhymes Like Dimes Remastered Version Instrumental"}	2	00:08:07	https://howardstevensmusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
669	Knxwledge.	Hud Dreems	https://knxwledge.bandcamp.com/album/hud-dreems?from=discover_page	Los Angeles, California	2018-07-05	https://f4.bcbits.com/img/a3340065932_16.jpg	28.05	{kometostai.aintreallynootherwaytoputitro,time&tide,tkekareofit,mylife,shuremng,noflowrs[instrw],frmnowhere,thtroll,letuleave.[geekdop],onlijournitro,thtbodi,bodies[TOTW],behindme,faraway,flyinglizrds,mydesire[fortwin][vanuys],trsh,jstowee,nvrending,stilluhme,Aintitovr,demskreets.fekts,beleeveibne,rightaftr[THK],okaiokai}	25	00:35:02	https://knxwledge.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
670	Weaponize Records	Almost Human	https://weaponizerecords.bandcamp.com/album/almost-human?from=discover_page	UK	2025-09-26	https://f4.bcbits.com/img/a2587486523_16.jpg	31.59	{"Jaz Kahina - Demi Moor","Lone Ranger","Flies On The Wall",S.O.S.,"Special Interest","Let's Dance","Paid My Subs feat. Doc Brown","Live Love Laugh",Run,"Writing On The Wall feat. Curt Cataract","Doom feat. King Kashmere",Slingshot}	12	00:38:23	https://weaponizerecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
671	Trellion	The Judas Clock	https://lilheartattack.com/album/the-judas-clock?from=discover_page	Sheffield, UK	2010-06-03	https://f4.bcbits.com/img/a0736997471_16.jpg	38.61	{Foreword,"The Judas Clock","Down Here","The Clock Shop (ft. Figment)","Luna Dunes (ft. Figment)","Lakeside kickin it","The Centre (ft. Figment)","Hollow Weights","Anti Clockwise (ft. Figment & Sniff)","The Mirror Room (ft. Lax Luther)"}	10	00:29:30	https://lilheartattack.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
672	Legacy Echo	SKWR Remixes	https://legacyecho.bandcamp.com/album/skwr-remixes?from=discover_page	UK	2025-12-04	https://f4.bcbits.com/img/a0876209478_16.jpg	14.04	{"Nightshift - Carlskee Remix","C'mon Ya'll - Chilla Ninja Remix","Electrified - Funkychild Remix","Sundown - Dexplorist Remix"}	4	00:09:37	https://legacyecho.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
673	Ben Living	Themes From Another World	https://benlivingmusic.bandcamp.com/album/themes-from-another-world-2?from=discover_page	Louisiana	2025-10-28	https://f4.bcbits.com/img/a0547780721_16.jpg	34.00	{"Prologue/Welcome to Creepshow","Trioxin Theme","Chariots of Pumpkins","L'Alba Dei Morti Viventi (Dawn of the Dead)","Theme From The Fog (2025)","Humanity-Pt 2","Main Title (Phantasm)","Carol Anne's Theme","Main Title (A Nightmare On Elm Street)","Laurie and Jimmy"}	10	00:45:15	https://benlivingmusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
674	Skyzoo	Keep Me Company	https://skyzoo.bandcamp.com/album/keep-me-company?from=discover_page	Brooklyn, New York	2024-11-29	https://f4.bcbits.com/img/a3453347058_16.jpg	25.50	{"Community Service (feat. JRose)","Finders Keepers","Home Away From Home","Ayinde at The March","Drug Free School Zone","Prayers For The Customers","Courtesy Call (feat. Chuck D)",Esoteric,"Store Runs (Interlude)","Record Store Day","Sleeping Beauty","Wins of the Father","Jazz In The Projects"}	13	00:49:54	https://skyzoo.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
713	GUAPO	Modular Fields - Volume Two	https://guapo1.bandcamp.com/album/modular-fields-volume-two-2?from=discover_page	London, UK	2026-01-12	https://f4.bcbits.com/img/a1109273237_16.jpg	17.55	{"Field III","Field IV"}	2	00:33:13	https://guapo1.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
676	ビクター ＭＫＩＩ	Soft(er) Shade	https://mkii.bandcamp.com/album/soft-er-shade?from=discover_page		2024-06-07	https://f4.bcbits.com/img/a3003339244_16.jpg	25.50	{home_happy,"love notes",the_city_after,"could’ve been","soft(er) shade",subtly,"interlude III","Summer Crush","low & slow",Dancin’,"fool proof","all I need 2 know","Take it slow",Melt}	14	00:26:45	https://mkii.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
677	Shabazz Palaces	The Don Of Diamond Dreams	https://shabazzpalaces.bandcamp.com/album/the-don-of-diamond-dreams?from=discover_page	Seattle, Washington	2020-04-17	https://f4.bcbits.com/img/a3511438249_16.jpg	19.55	{"Portal North: Panthera","Ad Ventures","Fast Learner (feat. Purple Tape Nate)",Wet,"Chocolate Souffle","Portal South: Micah","Bad Bitch Walking (feat. Stas THEE Boss)","Money Yoga (feat. Darrius)","Thanking The Girls","Reg Walks By The Looking Glass (feat. Carlos Overall)"}	10	00:42:19	https://shabazzpalaces.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
678	FASTFORWARD	Final Portrait	https://fastforward22.bandcamp.com/album/final-portrait?from=discover_page	Munich, Germany	2023-12-29	https://f4.bcbits.com/img/a3154185607_16.jpg	30.00	{"Même Envie (Intro)","Geht Noch Was","Beschissenes Jahr","Als Ich Jung War (Skit)","Trauriges Kapitel","Geld Machen - Arbeiten (Interlude)","En Mouvement","Peefke Unterwegs","Ein Wiedersehen","Da Gewesen","Scheiß Wandmalerei (Skit)",Utopie,"Negative Arbeit (Skit)",Farce,"Mauseloch (Skit)","Was Bleibt","Misodemie (Outro)","Ich Muss Aufhören (Skit)","So Ein Schöner Tag","Petites Fenêtres","Petites Fenêtres (Remix)",B.I.T.D.,"Unfertig (Skit)","Giesinger Line / Ligne Lausanne","Devoir Simple","’S Gleiche",Tropenstadt}	27	01:20:23	https://fastforward22.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
679	Daupe	HWH 12 (Cover 1)	https://daupe.bandcamp.com/album/hwh-12-cover-1?from=discover_page	London, UK	2025-03-03	https://f4.bcbits.com/img/a1521558159_16.jpg	43.28	{"Michelle World","Boswell Ft Estee Nack & Stove God Cooks","Adam Page Ft Stove God Cooks","Veert Ft Estee Nack & Stove God Cooks","055  Ft Stove God Cooks","Health Science Ft Brother Tom Sos","Gumbo Yaya Ft Brother Tom Sos","East Miami Ft Estee Nack","Bury Me With A Stove Ft Estee Nack",Outlander,"Dump World Ft  Stove God Cooks & Elijah Hook"}	11	00:43:49	https://daupe.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
680	EastSide Edits	Eastside Edits 006	https://eastsideedits.bandcamp.com/album/eastside-edits-006?from=discover_page	Toronto, Ontario	2023-12-01	https://f4.bcbits.com/img/a4278390242_16.jpg	11.89	{"Heres My Name","Suckside - Heard it Through Creedence"}	2	00:07:42	https://eastsideedits.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
681	Crown (Grim Reaperz)	Game of Crown	https://crowndareaperz.bandcamp.com/album/game-of-crown?from=discover_page	France	2023-06-16	https://f4.bcbits.com/img/a1573144916_16.jpg	30.00	{"Game of Crown | Dj Venum","Mon Exutoire | Saké, Nesta & Dton","Ma Posologie | Swift Guad","Cœur de Glace | Melan","Drôle d'Epoque | Nozey & Anté","03h30 | Tupan","Le Syndrome d'Arlequin | Cenzino","Erratum | Eska","Débats Sans Fin | Sales Gosses & Cabron Cito","Derriere Mon Sourire | Abrazif, Anton Serra, Rager & Lil Dap (Group Home)","Dans la Sauce | Convok","Ce Monde | Relo, Hermano Salvatore & Le 3eme Œil","Moments de Vie | Templar, Tupan & Resolute","Elevation | Ali & Prodigal Sunn","C'est la Vie | Youssef Swatt's"}	15	00:51:55	https://crowndareaperz.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
682	Daupe	HWH 12 (Cover 2)	https://daupe.bandcamp.com/album/hwh-12-cover-2?from=discover_page	London, UK	2025-03-10	https://f4.bcbits.com/img/a3948962519_16.jpg	43.28	{"Michelle World","Boswell Ft Estee Nack & Stove God Cooks","Adam Page Ft Stove God Cooks","Veert Ft Estee Nack & Stove God Cooks","055 Ft Stove God Cooks","Health Science Ft Brother Tom Sos 03:23","Gumbo Yaya Ft Brother Tom Sos","East Miami Ft Estee Nack 04:23","Bury Me With A Stove Ft Estee Nack",Outlander,"Dump World Ft Stove God Cooks & Elijah Hook"}	11	00:43:49	https://daupe.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
683	Edan	Beauty and the Beat	https://edan2.bandcamp.com/album/beauty-and-the-beat?from=discover_page	New York, New York	2017-02-03	https://f4.bcbits.com/img/a3486255623_16.jpg	29.24	{"Polite Meeting (Intro)","Funky Voltron (featuring Insight)","I See Colours","Fumbling Over Words That Rhyme","Murder Mystery","Torture Chamber (featuring Percee P)","Making Planets (featuring Mr. Lif)","Time Out (Segue)","Rock and Roll (featuring Dagha)",Beauty,"The Science Of The Two Featuring Insight",Smile,"Promised Land","Torture Chamber (Cut Chemist Remix) Featuring Percee-P"}	14	00:48:10	https://edan2.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
684	Pufuleti	GOTICO ROMANZO	https://pufuleti.bandcamp.com/album/gotico-romanzo?from=discover_page	Saarbrücken, Germany	2024-06-28	https://f4.bcbits.com/img/a2869732710_16.jpg	22.50	{"Muri di mattoni",Fantasma,"Giubbotti gialli",Larva,"Calici di gemme","Pianto d'avorio","Oreilles d'onyx","Corona di ginestre",Sublime,"Chiese nere",Plancton,"Il giorno del tuo compleanno"}	12	00:23:39	https://pufuleti.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
685	2.L.O.C.O. IN CRIME	Veinz Of Paint	https://2locoincrime.bandcamp.com/album/veinz-of-paint?from=discover_page	Sydney, Australia	2022-07-07	https://f4.bcbits.com/img/a2807344768_16.jpg	40.00	{"Interviewz In Smoke (Intro)","Subway Globetrotter","Kash Money","Veinz Of Paint","Worldz Gone Maaad","How Could It Be","Blast Em Off","Sociopath Mentality"}	8	00:22:22	https://2locoincrime.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
686	Snowgoons	Black Snow 3	https://snowgoons.bandcamp.com/album/black-snow-3?from=discover_page	Crailsheim, Germany	2026-01-16	https://f4.bcbits.com/img/a3020624852_16.jpg	29.99	{"GoonsGear ft Sicknature, Reef The Lost Cauze & Sean Strange","Juggernauts ft Evil Ebenezer & Suave-Ski","The Hatred 3 ft Madchild, Slaine, Benny Holiday & DJ Crypt","Let It Be Known ft PMD, Fredro Starr & Tone Spliff"}	4	00:11:35	https://snowgoons.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
687	Weltuntergäng	15 (Instrumentals)	https://weltuntergaeng.bandcamp.com/album/15-instrumentals?from=discover_page	München, Germany	2025-08-25	https://f4.bcbits.com/img/a0183572797_16.jpg	25.00	{"Entropie (Instrumental)","Hoehenflug (Instrumental)","Gruppenchat (Instrumental)","Big Rip (Instrumental)","Weit Weg Pt. 3 (Instrumental)","Ein gutes Ende (Instrumental)","Entropie (Acapella)"}	7	00:19:18	https://weltuntergaeng.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
714	Glass Beams	Mahal	https://glassbeams.bandcamp.com/album/mahal?from=discover_page	Melbourne, Australia	2024-03-22	https://f4.bcbits.com/img/a2967668498_16.jpg	19.55	{Horizon,Mahal,Orb,"Snake Oil","Black Sand"}	5	00:18:31	https://glassbeams.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
688	Mo Cess & Chrisfader	Neie Ufer	https://mocesschrisfader.bandcamp.com/album/neie-ufer?from=discover_page	Tyrol, Austria	2026-02-27	https://f4.bcbits.com/img/a2157815234_16.jpg	30.00	{"Neie Ufer",Gfålln,Fischer,"Im Netz",Entscheidungen,"Wenn du älter bisch",Hubi,"I Trink","An Song","Schnea von Gestern",Interlude,Rollen,"No Fear feat. Worst Messiah","Wås wår",Winkelzug,Frågen,"Neie Ufer (Instrumental)","Gfålln (Instrumental)","Fischer (Instrumental)","Im Netz (Instrumental)","Entscheidungen (Instrumental)","Wenn du älter bisch (Instrumental)","Hubi (Instrumental)","I Trink (Instrumental)","An Song (Instrumental)","Schnea von Gestern (Instrumental)","Interlude (Instrumental)","Rollen (Instrumental)","No Fear (Instrumental)","Wås wår (Instrumental)","Winkelzug (Instrumental)","Frågen (Instrumental)"}	32	01:37:38	https://mocesschrisfader.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
689	Illect Recordings	Future Infinite	https://illect.bandcamp.com/album/future-infinite?from=discover_page	Seattle	2025-10-24	https://f4.bcbits.com/img/a1433154405_16.jpg	21.25	{Bloom,"Consider It Joy (ft. Nomis)","Vapour Trails","Short Change (ft. Ozay Moore)","Beyond the Static","Let Go (ft. Sareem Poems)",Drifting,"Higher Ground (ft. K.I.N.E.T.I.K. & Elias Wallace)","Falling Embers","Stereo Polaroid (ft. Jackson Mathod)","Go No Go (ft. Kay Sade)","Outta Sight Outta Mind (ft. DIE-REK)","Woven Silence"}	13	00:36:14	https://illect.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
690	The Other Guys	No Validation	https://otherguysmusic.bandcamp.com/album/no-validation?from=discover_page	Washington, D.C.	2025-08-29	https://f4.bcbits.com/img/a0768693777_16.jpg	127.50	{"Incense Burning (Ft: Jack Davey)","Smooth Jazz (38 Spesh)","Sugar Water","Moroccan Mint (Ft: Jae Skeese)","Katastwof (Ft: Ransom & Skyzoo)","Dollar Tree (Ft: Skyzoo & Von Pea)","Ego Trips (Ft: DJ Eveready)","Susie (Ft: Smoke DZA)"}	8	00:22:10	https://otherguysmusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
691	Tall Black Guy Productions	8 Miles To Moenart (10th Anniversary Edition)	https://tallblackguy.bandcamp.com/album/8-miles-to-moenart-10th-anniversary-edition?from=discover_page	Detroit, Michigan	2024-10-18	https://f4.bcbits.com/img/a2543028186_16.jpg	28.08	{"Black Detroit Intro","The Dark Streets","Funeral Biz / Welcome to Detroit (Interlude) [feat. Malice & Mario Sweet]","From Home, To Work And Back Again (Reprise)","Mon Amie De'troit (7\\" Version) [feat. Ozay Moore]","Running the Motor (Reprise)","The Motor Is Running","There's No More Soul (feat. Diggs Duke)","Rain into the Nite (Outro)",Floating}	10	00:46:35	https://tallblackguy.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
692	saturn	MY LIFE	https://saturnon.bandcamp.com/album/my-life-2?from=discover_page	Sacramento, California	2024-12-25	https://f4.bcbits.com/img/a2368823806_16.jpg	21.24	{brrr,omegle,"Less Intro",Sunny,Days,"go white boy go",meangirls,grinning,qpid,Another,Raise,"King Duncan",Traffic,"Brutal Truth (212)","Matryoshka Redrum","WORKOUT 4",SS1,SS2,"Flow state"}	19	00:37:56	https://saturnon.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
693	Chalk	Moonlight Music	https://oddparticlerecords.bandcamp.com/album/moonlight-music?from=discover_page	Manchester, UK	2026-02-01	https://f4.bcbits.com/img/a0551940563_16.jpg	23.40	{"Music by Moonlight","Donne Della Luna","Night Time Love Affair","Natalia's Nocturne","Music by Moonlight *Bonus Instrumental","Night Time Love Affair *Bonus Instrumental"}	6	00:13:08	https://oddparticlerecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
694	Farhot	Kabul Fire Vol. 2	https://farhot.bandcamp.com/album/kabul-fire-vol-2?from=discover_page	Hamburg, Germany	2021-01-29	https://f4.bcbits.com/img/a1130089476_16.jpg	19.00	{"Bale Bale (Intro)",Kalun,"Yak Sher","Check feat. JuJu Rogers & Nneka",Kishmish,"Feel Ugly",Azadi,Pul,"Sampling Watana / Biya Bachem feat. Moshtari",Arusi,"Ahange Qadimi","Baqi Manda","Shirin (Outro)"}	13	00:32:25	https://farhot.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
695	Sage Francis	Copper Gone	https://sagefrancis.bandcamp.com/album/copper-gone?from=discover_page	Providence, Rhode Island	2014-06-03	https://f4.bcbits.com/img/a3304098483_16.jpg	34.00	{"Pressure Cooker",Grace,"ID Thieves","Cheat Code","Dead Man's Float","Over Under","Make Em Purr","Vonnegut Busy","Thank You","The Set Up","The Place She Feared Most","Once Upon A Blood Moon","Say Uncle","MAINT REQD"}	14	00:54:09	https://sagefrancis.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
696	14KT	The Power Of Same	https://14kt.bandcamp.com/album/the-power-of-same?from=discover_page	Los Angeles, California	2019-03-01	https://f4.bcbits.com/img/a3216079905_16.jpg	5.85	{"The Power Of Same (ft Muhsinah)","The Power Of Same (Kaidi Tatham Remix) 7\\" Edit","The Power Of Same (Kaidi Tatham Remix)"}	3	00:14:41	https://14kt.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
697	Eric Lau	Examples Volume Two	https://ericlau.bandcamp.com/album/examples-volume-two?from=discover_page	London, UK	2018-11-02	https://f4.bcbits.com/img/a4173378640_16.jpg	17.55	{Runway,Righteous,"Do You Like Music?","Val In Time","One And Two And...","Without A Doubt",7even,"Favourite Truth","NE (Good En)","Take Me To Brasil",Mirage,"Oh Dara","Groovin Sweet",Training,"Jeff's Piano","Dr Slump","What Was On Your Mind?","Super Moon","Feeling Connected","Tape's Rolling","Between Piano","By The Sea",Uploading...,"Slow Down","In Plane Astral","The Best Good","Time Is The Greatest Teacher","Our Future"}	29	01:31:13	https://ericlau.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
698	Gas-Lab	Trans Pacific	https://gas-lab.bandcamp.com/album/trans-pacific?from=discover_page	Belén De Escobar, Argentina	2022-11-25	https://f4.bcbits.com/img/a1600150360_16.jpg	21.24	{"Pipe Dream (ft. David Lavoie & Javier Martinez Vallejos)","Be Water","Getaway (ft. Hector Mario)",Panacea,"Recollect (ft. Andrew Gould & Javier Martinez Vallejos)","Something like that?","Impressions (ft. Juan Klappenbach & Javier Martinez Vallejos)","Swell (ft. Andrew Gould)",Mantra}	9	00:24:04	https://gas-lab.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
699	BLACK FONDU	BLACKFONDUISM	https://blackfondu.bandcamp.com/album/blackfonduism?from=discover_page	London, UK	2025-11-21	https://f4.bcbits.com/img/a0003312325_16.jpg	21.06	{"holla back girl",BOYS,"im not sleeping","IN D4 CLUB","C00N V2",BLACK1E,#music}	7	00:22:24	https://blackfondu.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
715	XKatedral	Spheres Collapser	https://xkatedral.bandcamp.com/album/spheres-collapser?from=discover_page	Stockholm, Sweden	2026-02-27	https://f4.bcbits.com/img/a2263268530_16.jpg	27.00	{"Phase I Organ","Phase II Organ"}	2	00:48:56	https://xkatedral.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
700	Madlib	Rock Konducta Pt. 1	https://madlib.bandcamp.com/album/rock-konducta-pt-1?from=discover_page	Los Angeles, California	2023-05-30	https://f4.bcbits.com/img/a0805125695_16.jpg	22.10	{Zucker,Rot,"Motorik Matching","Far Faust","Knickers Turned","Gentle Pilz","Black Widow","Giant Okra","Ege Malesch","Soap Guillotine","Hallucination Amon",Siebenjäger,"Mantra Guru","Düül Shop","Hold The Organ",Floh,"Harmonia Inventions",Crimson,"Agitation Musik","Yeti Move",Anima,"Derum Dig","Tarot Ash","Cluster Ghosts","Känguru Join"}	25	00:42:36	https://madlib.bandcamp.com?from=discover_page	2026-02-23 13:22:19.685369	2026-02-23 13:22:19.685369
701	Darkhouse Family	An Extra Offering	https://darkhousefamily.bandcamp.com/album/an-extra-offering?from=discover_page	Cardiff, UK	2018-06-15	https://f4.bcbits.com/img/a2692694240_16.jpg	9.36	{"The Accession (Kaidi Tatham Remix)","Another World ft Esther (DJ Spinna Galactic Soul Mix)","Just So You Know ft Vanity Jay (DJ Spinna Galactic Funk Remix)","Gaea (Alfie Swan Remix)","Journey To Love (Andromeda Jones Remix)",Synergy,"Another World (Instrumental)"}	7	00:38:24	https://darkhousefamily.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
702	Hus "Wavo" Kingpin	PAID IN FULL [LP] LIMITED VINYL & CD	https://huskingpin.bandcamp.com/album/paid-in-full-lp-limited-vinyl-cd?from=discover_page	New York, New York	2023-06-20	https://f4.bcbits.com/img/a0315383000_16.jpg	68.00	{"PAID IN FULL (PROD. MACAPELLA)","RAIN (PROD. MACAPELLA)","EPISODES (PROD. GIALLO POINT)","CROSSLINE FT. PURE (PROD. MACAPELLA)","ICE MAN FT. MAV (PROD. MACAPELLA)","GET MONEY FT. YOUNG OLD SOUL (PROD. MACAPELLA)","PANDORA'S BOX (PROD. DJ PHANTOM)","BLISS (PROD. SEAN WRECKLESS)","SOUND LIKE (PROD. WUN TWO)","FRANK MATTHEWS (PROD. STINKY J)"}	10	00:30:07	https://huskingpin.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
703	Stu Bangas	Guerilla Dynasty 3	https://brutalmusic.bandcamp.com/album/guerilla-dynasty-3?from=discover_page	Boston, Massachusetts	2025-03-14	https://f4.bcbits.com/img/a1560067158_16.jpg	32.30	{"GD3 Intro","3 Peat",Rebellious,"Silent Killers featuring Sage Infinite","Most Dangerous","Guerillas featuring Born Unique and Lord Goat",Interlude,"Smell of Death featuring Frankie Krueger","Legend of My Time cuts by DJ TMB","Dope Peddling featuring Verbal Kent and A-F-R-O","Kill Swines for Less","Righteous Weapons featuring Blacastan",Capo,"Rebels Terrain featuring Boob Bronx (cuts by DJ Tray)",Outro}	15	00:38:10	https://brutalmusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
704	Kool Keith	Your Mom Is My Wife	https://koolkeith.bandcamp.com/album/your-mom-is-my-wife?from=discover_page	Bronx	2016-12-31	https://f4.bcbits.com/img/a0286032308_16.jpg	127.50	{"Your Mom Is My Wife","Black Sheriff","Happy New Year","Pussy Blockers","You Model, You Dance","Me And You"}	6	00:23:36	https://koolkeith.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
705	Bonnie "Prince" Billy	We Are Together Again	https://bonnieprincebilly.bandcamp.com/album/we-are-together-again?from=discover_page	Louisville, Kentucky	2026-03-06	https://f4.bcbits.com/img/a3003050591_16.jpg	21.25	{"Why is the Lion","They Keep Trying To Find You","Strange Trouble","Life is Scary Horses","(Everybody's Got a) Friend Named Joe","Vietnam Sunshine","Hey Little","Davey Dead","The Children Are Sick","Bride of the Lion"}	10	00:47:09	https://bonnieprincebilly.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
706	Isabel Pine	Fables	https://isabelpine.bandcamp.com/album/fables?from=discover_page	British Columbia	2026-02-20	https://f4.bcbits.com/img/a0683556481_16.jpg	18.70	{Wolves,Winnow,"Untitled / Kindled / Waxing","Never Been Here Before",Wandering,Fables,West,Snow,"A Flickering Light","Sun Dog",Hollow,Moonlight,Bare,Perennial,"Butterfly Lands On A Flower"}	15	00:40:14	https://isabelpine.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
707	toby summerfield	Bodies of Water	https://tobysummerfield.bandcamp.com/album/bodies-of-water?from=discover_page	Lyme, New Hampshire	2026-01-13	https://f4.bcbits.com/img/a0833833090_16.jpg	21.25	{"Post Pond","Lake Anza","The Shaker Dam at Reservoir Pond","Caulk the Wagon and Float It","North Branch of the Chicago River","Slowly Down the Russian River","The Dog River","Gallup Park Canoe Livery","The Pools Below Tannery Falls","Grant Brook"}	10	00:43:55	https://tobysummerfield.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
708	Ben Vince	Street Druid	https://benvince.bandcamp.com/album/street-druid?from=discover_page	London, UK	2026-02-20	https://f4.bcbits.com/img/a2611007175_16.jpg	25.74	{Prelude,"Peace Spell",Deepbluereflection,"Street Druid","Sentient Interlude","Sentient Kinetics","(Ride A) Wave",Longville}	8	00:44:18	https://benvince.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
709	Kronos Quartet	Glorious Mahalia	https://kronosquartet.bandcamp.com/album/glorious-mahalia?from=discover_page	San Francisco, California	2026-04-03	https://f4.bcbits.com/img/a0771352588_16.jpg	17.83	{"Glorious Mahalia: I. Hold on","Glorious Mahalia: II. Stave in the ground","Glorious Mahalia: III. Are you being treated right","Glorious Mahalia: IV. Sometime I feel like a motherless child","Glorious Mahalia: V. This world will make you think","God Shall Wipe All Tears Away","Peace Be Till: I. Doors of Justice / Black Thread","Peace Be Till: II. Protest","Peace Be Till: III. Copter","Peace Be Till: IV. Symphony of Social Justice","Peace Be Till: V. Tell 'em about the dream"}	11	00:50:47	https://kronosquartet.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
710	ZU	Ferrum Sidereum	https://zuhom.bandcamp.com/album/ferrum-sidereum?from=discover_page	Italy	2026-01-09	https://f4.bcbits.com/img/a2137056100_16.jpg	33.14	{Charagma,Golgotha,Kether,"A.I. Hive Mind","La Donna Vestita Di Sole",Pleroma,"Fuoco Saturnio","The Celestial Bull and the White Lady","Hymn of the Pearl",Perseidi,"Ferrum Sidereum"}	11	01:19:52	https://zuhom.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
711	Pre-Echo Press	Blue Abstraction: Prepared Piano Project 1985–1987	https://pre-echo.bandcamp.com/album/blue-abstraction-prepared-piano-project-1985-1987?from=discover_page	New York, New York	2025-11-21	https://f4.bcbits.com/img/a0174413742_16.jpg	21.25	{"Blue Abstraction","Portrait of Picasso II","Portrait of Matisse","The Spider",Odun-de,"The Banshee","Half Circle Song",Snow}	8	00:40:20	https://pre-echo.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
712	Elori Saxl	Seeing Is Forgetting	https://elorisaxl.bandcamp.com/album/seeing-is-forgetting?from=discover_page	New York, New York	2026-02-06	https://f4.bcbits.com/img/a1502137488_16.jpg	21.25	{Reverence,Raindrops,Symmetries,"Reno Silver","A Thousand Steps","Hiding Place",Dream,Heart,"Seeing Is Forgetting"}	9	00:37:31	https://elorisaxl.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
716	Duval Timothy	My Father''s Shadow (Original Motion Picture Soundtrack)	https://duvaltimothy.bandcamp.com/album/my-fathers-shadow-original-motion-picture-soundtrack?from=discover_page	England, UK	2026-02-06	https://f4.bcbits.com/img/a1405101860_16.jpg	35.10	{"Incantation ft. Roxanne Tataei",Arriving,"Journey Begins","Journey to Lagos","Puppet Dance",Horses,"Fairground ft. Roxanne Tataei","Beach Arriving","Passing On","Coup pt.1","Coup pt.2","A O Pade Leti O Do (feat. Okikioluwa Adewale)"}	12	00:38:17	https://duvaltimothy.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
717	William Basinski	The Disintegration Loops - Arcadia Archive Edition	https://williambasinski.bandcamp.com/album/the-disintegration-loops-arcadia-archive-edition?from=discover_page	Los Angeles, California	2025-11-14	https://f4.bcbits.com/img/a3382454403_16.jpg	170.00	{"dlp 1.1","dlp 2.1","dlp 2.2","dlp 3","dlp 4","dlp 5","dlp 6","dlp 1.2","dlp 1.3"}	9	04:55:44	https://williambasinski.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
718	Jefre Cantu-Ledesma	Gift Songs	https://jefrecantu-ledesma.bandcamp.com/album/gift-songs?from=discover_page	New York	2025-03-21	https://f4.bcbits.com/img/a3311978894_16.jpg	22.94	{"The Milky Sea","Gift Song I","Gift Song II","Gift Song III","River That Flows Two Ways","September (Bonus Track)"}	6	01:40:24	https://jefrecantu-ledesma.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
719	Takuro Okada	Konoma	https://hitujiotoko22.bandcamp.com/album/konoma?from=discover_page	Tokyo, Japan	2025-11-21	https://f4.bcbits.com/img/a1460679021_16.jpg	20.40	{"Mahidere Birhan",Sunrise,Nefertite,Galaxy,"Portrait of Yanagi",Love,"Acute Angle Black Button","November Owens Valley"}	8	00:39:29	https://hitujiotoko22.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
720	SANAM	Sametou Sawtan	https://sanambeirut.bandcamp.com/album/sametou-sawtan?from=discover_page	Beirut, Lebanon	2025-09-19	https://f4.bcbits.com/img/a0660145393_16.jpg	25.50	{"Harik - حريق","Goblin - غوبلن","Habibon - حبيبٌ","Hadikat Al Ams - حديقة الأمس","Hamam - حمام","Sayl Damei - سيل دمعي","Tatayoum - تتيم","Sametou Sawtan - سمعت صوتاً"}	8	00:40:44	https://sanambeirut.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
721	Booker Stardrum	Close-up On The Outside	https://bookerstardrum.bandcamp.com/album/close-up-on-the-outside?from=discover_page	Kingston, New York	2026-02-27	https://f4.bcbits.com/img/a1319152048_16.jpg	20.00	{"Close-up On The Outside",Telluric,Reset,"Third Nature",Dusk,Hover,Minturn,"Inside Sounds"}	8	00:33:40	https://bookerstardrum.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
722	Thorn Wych	Aesthesis	https://thornwych.bandcamp.com/album/aesthesis?from=discover_page	UK	2026-01-10	https://f4.bcbits.com/img/a3368126025_16.jpg	29.25	{"Ouch Epi Ptoe","Out of the Eater Came Something to Eat","The Blue Rose of Forgetfulness","Longing Song","Serpent Psalm","Auld Haunt","Ramble in the Brambles","May the Immortal Amma keep you seated","The is Nothing in the Well","Anaro Knows"}	10	00:43:45	https://thornwych.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
723	Pijama Piyama	Lazer Moon Vol. 1	https://pijamapiyama.bandcamp.com/album/lazer-moon-vol-1?from=discover_page	Phoenix, Arizona	2026-03-06	https://f4.bcbits.com/img/a2887520950_16.jpg	25.50	{"Ciber Ciudad","La Paila",Piyoya,Galopando,"Deidad de Cactus","Lazer Moon","Hechele Primo","Quítate la Ropa Cuando Bailes","Hace Mucho Tiempo","Teclado De Juanito"}	10	00:34:19	https://pijamapiyama.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
724	Mandy, Indiana	URGH	https://mandyindiana.bandcamp.com/album/urgh?from=discover_page	Manchester, UK	2026-02-06	https://f4.bcbits.com/img/a1361983612_16.jpg	22.95	{Sevastopol,Magazine,"Try Saying",Dodecahedron,"A Brighter Tomorrow","Life Hex","ist halt so","Sicko! ft. billy woods",Cursive,"I'll Ask Her"}	10	00:34:33	https://mandyindiana.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
725	Yussef Kamaal	Black Focus	https://yussefkamaal.bandcamp.com/album/black-focus?from=discover_page	London, UK	2016-11-04	https://f4.bcbits.com/img/a2077159990_16.jpg	23.40	{"Black Focus","Strings Of Light",Remembrance,"Yo Chavez",Ayla,O.G.,Lowrider,"Mansur's Message","WingTai Drums","Joint 17"}	10	00:43:46	https://yussefkamaal.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
726	Lobby Art Editions	Language At An Angle	https://lobbyartrecs.bandcamp.com/album/language-at-an-angle?from=discover_page	Brooklyn, New York	2026-01-30	https://f4.bcbits.com/img/a3871044879_16.jpg	18.70	{"Limitless of Blue","Draw Water Down","Blue Consonance","Run the River Clear","Clear of Itself","Threshold Arises",Staying,"Caught String"}	8	00:41:43	https://lobbyartrecs.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
727	Infrequent Seams	Concrete Sun (Evelyn Ficarra, Heather Frasch & Myra Melford)	https://infrequentseams.com/album/concrete-sun-evelyn-ficarra-heather-frasch-myra-melford?from=discover_page	New York	2026-02-13	https://f4.bcbits.com/img/a0113488402_16.jpg	25.50	{"the mundane uncanny","bug on water","concrete sun"}	3	00:40:58	https://infrequentseams.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
728	Phage Tapes	Tokyo Pure Decadence	https://phagetapes.bandcamp.com/album/tokyo-pure-decadence?from=discover_page	Minneapolis, Minnesota	2025-12-12	https://f4.bcbits.com/img/a0741844099_16.jpg	18.70	{"Queasy and Kaleidoscopic Eyes Stare in Neon Wonder. Tokyo, Pure Decadence","Blacklight Over Tangled Sheets. Down an Alley in Kabukicho, Love Hotel Fuck","My Vision Swirls, Flecks of Stomach Bile Stuck Around Your Mouth. Street Girl Smiling Bright","Thin Angel of Intoxication. Rain in Shibuya","All Stars Lead Toward You, Hymen Eidolon","Lined up at the Curb, Feigning Shy. Streetlights Sparkle Under Dark Waves","Dogenzaka Labyrinth. Dreams and Fantasy, Dying Every Night"}	7	00:36:50	https://phagetapes.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
729	Andy Hay	Apple Pie	https://andyhay.bandcamp.com/album/apple-pie?from=discover_page	UK	2025-12-05	https://f4.bcbits.com/img/a3898240711_16.jpg	52.65	{Hearts,"Return to Inca.","Apple Pie","De Angel Oh","2nd Harvest","Water is life","Joy Spirit",Catrin}	8	00:46:10	https://andyhay.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
730	Paul Riedl	«Demystification» // «Forestscapes»	https://paulriedl.bandcamp.com/album/demystification-forestscapes?from=discover_page	Denver, Colorado	2025-12-05	https://f4.bcbits.com/img/a3716798274_16.jpg	34.00	{"Into The Solar Prominence","Spacewalk (Auf Wiedersehen)","Memories Of A Future World","Your Echo","Song For Remembrance & Rejuvenation","Daybreak On The Mountain Of Light","Song For My Wife’s Love","hanging moss - View From My Hammock Perched","hanging moss - Healing Mists Of Ancient Forest"}	9	01:21:44	https://paulriedl.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
731	Anika	Father Mother Sister Brother (Original Music From The Film)	https://anika.bandcamp.com/album/father-mother-sister-brother-original-music-from-the-film?from=discover_page	Berlin, Germany	2025-11-14	https://f4.bcbits.com/img/a1631927096_16.jpg	21.25	{Spooky,Disorder,"Skaters (Short Version)","The Lake 1","The Lake 2","The World In Reverse",Afterwards,Order,Twins,Skaters,Return,Emptiness,"These Days",Jetlag,"Paris Bleu","These Days (Berlin Version)"}	16	00:31:18	https://anika.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
732	My Pet Flamingo	Blood and Sacrifice	https://mypetflamingo.bandcamp.com/album/blood-and-sacrifice?from=discover_page	Wales, UK	2025-11-19	https://f4.bcbits.com/img/a3279412491_16.jpg	26.90	{"The Forgotten Covenant","Collapse of the Divine","Gods in Exile","Blood and Sacrifice","Beckoning Gravitas","Sky Beyond Eyes","Fading Prayers","Lost in the Halls of Ivory","Timelapse of the Parthenon","Ages Apart"}	10	00:48:39	https://mypetflamingo.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
733	Yazz Ahmed	A Paradise In The Hold	https://yazzahmed.bandcamp.com/album/a-paradise-in-the-hold?from=discover_page	UK	2025-02-28	https://f4.bcbits.com/img/a4140564360_16.jpg	45.03	{"She Stands On The Shore","A Paradise In The Hold","Mermaids' Tears","Her Light","Al Naddaha","Dancing Barefoot","Into The Night","Though My Eyes Go To Sleep, My Heart Does Not Forget You","To The Lonely Sea","Waiting For The Dawn"}	10	01:10:02	https://yazzahmed.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
734	Automatic	Is It Now?	https://automatic-band.bandcamp.com/album/is-it-now?from=discover_page	Los Angeles, California	2025-09-26	https://f4.bcbits.com/img/a1271542228_16.jpg	26.35	{"Black Box",mq9,Mercury,Lazy,"Country Song","Is It Now?","Don't Wanna Dance","Smog Summer","The Prize",PlayBoi,Terminal}	11	00:42:00	https://automatic-band.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
735	laaps	Light Behind Me	https://laaps-records.com/album/light-behind-me?from=discover_page	Brittany, France	2026-01-05	https://f4.bcbits.com/img/a2534725406_16.jpg	20.00	{"I Didn't Have To Open My Eyes","Can't Help But Feel","Light Behind Me","Field Floating In The Dusk","Harmless Light","Things Were Visible Again","Frailest Beginnings"}	7	00:41:30	https://laaps-records.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
736	Subb-an	Love Tempo	https://subban.bandcamp.com/album/love-tempo?from=discover_page	London, UK	2025-11-19	https://f4.bcbits.com/img/a2804228687_16.jpg	17.55	{"Love Tempo",Illusions,System,"System Dub","Love Tempo - Instrumental Piano Tool","Love Tempo - Radio Edit"}	6	00:31:35	https://subban.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
737	Equipment Pointed Ankh	Eggs A Little Late	https://equipmentpointedankh.bandcamp.com/album/eggs-a-little-late-2?from=discover_page	Louisville, Kentucky	2025-11-28	https://f4.bcbits.com/img/a0989453698_16.jpg	19.55	{"Eggs A Little Late","A Spectral Math","The Shelbyville Codes",M'Ladies,"Cleaning the Secret Weapon","Every Night Since Harry","Bean Soup and Rolls (The Peasant's Song)","Swordfish in Khaki","A Single Shot of Metabolism Between Us","Cincinnati Hush Job","Exiting Freedom Frontier"}	11	00:35:01	https://equipmentpointedankh.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
738	Andrea Laszlo De Simone	Una Lunghissima Ombra	https://andrealaszlodesimoneofficial.bandcamp.com/album/una-lunghissima-ombra?from=discover_page	Turin, Italy	2025-10-17	https://f4.bcbits.com/img/a2312913325_16.jpg	32.00	{"Il buio","Ricordo tattile",Neon,"La notte",Colpevole,Quando,Aspetterò,"Per te","Un momento migliore",Diffrazione,Pienamente,"Planando sui raggi del sole",Spiragli,"Quello che ero una volta",Rifrazione,"Non è reale","Una lunghissima ombra"}	17	01:07:01	https://andrealaszlodesimoneofficial.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
739	Webber/Morris Big Band	Unseparate	https://webbermorrisbigband.bandcamp.com/album/unseparate?from=discover_page	New York, New York	2025-09-26	https://f4.bcbits.com/img/a2556240029_16.jpg	29.75	{"Just Intonation Etudes for Big Band - Unseparate 1","Just Intonation Etudes for Big Band - Pulse","Just Intonation Etudes for Big Band - Timbre","Just Intonation Etudes for Big Band - Metaphor",Mist/Missed,"Unseparate 2",Microchimera,"Unseparate 3","Unseparate 4",Habitual,"Spur 7: Metamorphosis"}	11	01:10:03	https://webbermorrisbigband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
740	mats gustafsson	TRACES	https://matsgustafsson.bandcamp.com/album/traces?from=discover_page	Vienna, Austria	2025-05-23	https://f4.bcbits.com/img/a1514196167_16.jpg	25.00	{"Father and Son","TRACES of Brown Rice","Love Train","Right Here Right Now","Do It (Again) – For Sofia Jernberg","TRACES of Codona and Mali *CD & digi only*"}	6	00:48:59	https://matsgustafsson.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
741	Jonny Greenwood	One Battle After Another (Original Motion Picture Soundtrack)	https://jonnygreenwood.bandcamp.com/album/one-battle-after-another-original-motion-picture-soundtrack?from=discover_page		2025-11-14	https://f4.bcbits.com/img/a3270523993_16.jpg	28.90	{"One Battle After Another","The French 75","Baktan Cross","Baby Charlene","Perfidia Beverly Hills","Mean Alley","I Need the Greeting Code","Ocean Waves","Guitar for Willa","Battle After Battle","Sisters of the Brave Beaver","Like Tom Fkn Cruise","Operation Boot Heel","Avanti Q","River of Hills","Greeting Code Reprise","Trust Device","Trio for Willa"}	18	00:49:01	https://jonnygreenwood.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
742	Kindohm	variadic daemon	https://kindohm.bandcamp.com/album/variadic-daemon?from=discover_page	Chaska, Minnesota	2026-01-08	https://f4.bcbits.com/img/a0820590196_16.jpg	21.25	{"orrin shell",vurnace,vane,"veron 5lip",silect,eversion,pxturn,daetrace,4rypll}	9	00:39:55	https://kindohm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
743	raster - artistic platform	<3	https://raster-raster.bandcamp.com/album/3?from=discover_page	Germany	2020-04-17	https://f4.bcbits.com/img/a1831313879_16.jpg	15.45	{"0.9 (Almost a Unit)",#,"Tech Talk","AC Boy/DC Girl",Simplicity,R3V,G01p,"Time 2 Kill","Almost a Unit (0.9)"}	9	00:40:30	https://raster-raster.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
744	Will Epstein	Yeah, mostly	https://willepstein.bandcamp.com/album/yeah-mostly?from=discover_page	Woodstock, New York	2026-01-09	https://f4.bcbits.com/img/a0054559029_16.jpg	18.70	{"Saturday Night","Brideshead Revisited Revisited",Dishwasher,Riverside,"Socks in LA","That'll Be Me","Little Tony Soprano","Window Window Window","Dimmer Switch","Standing At My Standing Desk","Lauren Bacall"}	11	00:32:51	https://willepstein.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
745	toe	the book about my idle plot on a vague anxiety	https://toe-music.bandcamp.com/album/the-book-about-my-idle-plot-on-a-vague-anxiety?from=discover_page	Japan	2013-08-20	https://f4.bcbits.com/img/a0056601041_16.jpg	25.50	{反逆する風景,孤独の発明,"tremolo + delay",むこう岸が視る夢,"all i understand is that i don't understand",c,"past and language","music for you","i do still wrong",メトロノーム,"everything means nothing"}	11	00:38:21	https://toe-music.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
746	Yu Su	Foundry / Bonita	https://yusu.bandcamp.com/album/foundry-bonita?from=discover_page	London, UK	2025-11-14	https://f4.bcbits.com/img/a2682283077_16.jpg	17.54	{Foundry,Bonita}	2	00:09:27	https://yusu.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
747	YHWH Nailgun	45 Pounds	https://yhwhnailgun.bandcamp.com/album/45-pounds?from=discover_page	New York, New York	2025-03-21	https://f4.bcbits.com/img/a0025566220_16.jpg	26.91	{Penetrator,"Castrato Raw (Fullback)","Pain Fountain","Animal Death Already Breathing","Ultra Shade (Beat My Blood Dog Down)","Iron Feet","Tear Pusher","Sickle Walk",Blackout,Changer}	10	00:21:04	https://yhwhnailgun.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
748	Benoît Pioulard	Stanza IV	https://pioulard.bandcamp.com/album/stanza-iv?from=discover_page	Brooklyn, New York	2025-07-11	https://f4.bcbits.com/img/a3816177301_16.jpg	25.50	{Xaipe,"Ersatz Immortality","Fog Dialect","Steeples Writhe","Xaipe (Markus Guentner version)","Steeples Writhe (James Devane version)","Fog Dialect (MJ Guider version)","Fog Dialect (arovane version)","Ersatz Immortality (Clarice Jensen version)","Ersatz Immortality (Viul version)"}	10	01:20:41	https://pioulard.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
749	Niteworks	Solas na Maidne Live	https://niteworksband.bandcamp.com/album/solas-na-maidne-live?from=discover_page	Scotland, UK	2025-11-28	https://f4.bcbits.com/img/a3621765689_16.jpg	46.80	{Lùths,Dookin,"Gura mise tha fo Èislein (feat. Ellen Macdonald)","Ian McGee's","Guns of Ajaccio",Somhairle,"Maraiche (feat. Ellen Macdonald)","Highlanders Farewell",Farewell,"An Toll Dubh (feat. Sian)","Teannaibh Dlùth (feat. Sian)","John Riley (feat. Beth Malcolm)",1999,"Obair Oidhche","Arp Choir","Sub Disco","Air Fàir an Là Intro","Air Fàir an Là (feat. Sian)","A' Ghrian (feat. Sian and Binneas)"}	19	01:22:56	https://niteworksband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
750	Hen Ogledd	DISCOMBOBULATED	https://henogledd.bandcamp.com/album/discombobulated?from=discover_page	Newcastle Upon Tyne, UK	2026-02-20	https://f4.bcbits.com/img/a2252643019_16.jpg	28.05	{"Nell’s prologue","Scales will fall","Dead in a post-truth world",Clara,"End of the rhythm","Amser a ddengys","Clear pools","Land of the dead"}	8	00:49:39	https://henogledd.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
751	Nala Sinephro	Endlessness	https://nalasinephro.bandcamp.com/album/endlessness?from=discover_page	London, UK	2024-09-06	https://f4.bcbits.com/img/a3962253974_16.jpg	32.76	{"Continuum 1","Continuum 2","Continuum 3","Continuum 4","Continuum 5","Continuum 6","Continuum 7","Continuum 8","Continuum 9","Continuum 10"}	10	00:45:23	https://nalasinephro.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
752	GUAPO	Modular Fields - Volume One	https://guapo1.bandcamp.com/album/modular-fields-volume-one?from=discover_page	London, UK	2025-10-31	https://f4.bcbits.com/img/a0509950179_16.jpg	17.55	{"Field I","Field II"}	2	00:30:13	https://guapo1.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
753	Anika	Abyss	https://anika.bandcamp.com/album/abyss?from=discover_page	Berlin, Germany	2025-04-04	https://f4.bcbits.com/img/a3359349384_16.jpg	19.55	{Hearsay,Abyss,Honey,"Walk Away","Into The Fire",Oxygen,"Out Of The Shadows","One Way Ticket","Last Song",Buttercups}	10	00:35:56	https://anika.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
754	The Cosmic Tones Research Trio	The Cosmic Tones Research Trio	https://thecosmictonesresearchtrio.bandcamp.com/album/the-cosmic-tones-research-trio?from=discover_page	Portland, Oregon	2025-10-24	https://f4.bcbits.com/img/a3240419765_16.jpg	17.00	{Awakenings,Sankofa,"The Sacred Garden","Spirit of Truth","Ba Hi Yah",Photosynthesis,Invocation}	7	00:25:03	https://thecosmictonesresearchtrio.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
755	Beacon Sound	Sculptures	https://beaconsound.bandcamp.com/album/sculptures?from=discover_page	Portland, Oregon	2026-02-20	https://f4.bcbits.com/img/a0720018706_16.jpg	18.70	{"Fort Stevens","Battery 247","Salish Sea","Cape Disappointment","Deception Pass","Benson Beach"}	6	00:39:06	https://beaconsound.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
756	Lobby Art Editions	The Wringing Cloth	https://lobbyartrecs.bandcamp.com/album/the-wringing-cloth?from=discover_page	Brooklyn, New York	2025-10-17	https://f4.bcbits.com/img/a3909453642_16.jpg	25.50	{"Song For Paloma","Tilt of the Lamp","Long Distance Engraving",Lacustrina,"The Flood Spires","Blood Sumac","Ribbons of Marble","Redaction Hiss","Mock Silver",Aproxmare,Pearlash,"Salt Tar"}	12	01:13:23	https://lobbyartrecs.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
757	Phew	Paper Masks	https://phewjapan.bandcamp.com/album/paper-masks?from=discover_page	Tokyo, Japan	2026-02-20	https://f4.bcbits.com/img/a1407589900_16.jpg	30.58	{"The Cat","Der Verpasste Kaffee",Amnesie,"Sugar Sprinkles",Pixelwissen,Iceberg,"Paper Memories","Im Nebel"}	8	00:38:16	https://phewjapan.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
758	Apport!	A!016 // Turf genesis psalms: resin	https://apport.bandcamp.com/album/a-016-turf-genesis-psalms-resin?from=discover_page	Vilnius, Lithuania	2026-01-09	https://f4.bcbits.com/img/a1883950565_16.jpg	24.00	{"Jurbarko m. sergančių artritu ir proto negalios asociacijos ansamblis „Į_Duba“ - World creation (psalm)","Nulis:S:S:S - Tarp smėlio ir dangaus","GyS - Damāvand","Wejdas - Skerspjūvyje","Semănat - Smėlio veidrodžiai","McKaras - Skaitmeninėje Ahrimano tuštumoje","Oorchach - Atarata"}	7	00:34:37	https://apport.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
759	Chaki	From L.A. to the Bay	https://chaki.bandcamp.com/album/from-l-a-to-the-bay-2?from=discover_page	Los Angeles, California	2026-03-13	https://f4.bcbits.com/img/a3137077684_16.jpg	29.75	{"The Contract To Dance (feat. Steve Bartek)","Hamburgers For America","A Vampire In Van Nuys","Get In Line","The Water","Funky Frankenstein","Freak Funk","Sleep Standing Up","How To Hanukkah","When U Were Mine","F*ck ICE (Chinga La Mira) feat. Black Bibles + EL Vez"}	11	00:35:32	https://chaki.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
760	Galecstasy	Wattzotica	https://galecstasy.bandcamp.com/album/wattzotica?from=discover_page	Los Angeles, California	2026-01-28	https://f4.bcbits.com/img/a4261156747_16.jpg	22.10	{Wattzotica,"Neon Mermaid","Walk the Talk",Divers,"Wander In",Shaba,"Imitation Squid","Black Glove","Swirl Pools"}	9	00:41:57	https://galecstasy.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
761	Björk	Vespertine	https://bjork.bandcamp.com/album/vespertine?from=discover_page	Iceland	2001-08-27	https://f4.bcbits.com/img/a2693979845_16.jpg	31.58	{"Hidden Place",Cocoon,"It's Not Up To You",Undo,"Pagan Poetry",Frosti,Aurora,"An Echo, A Stain","Sun In My Mouth",Heirloom,"Harm Of Will",Unison}	12	00:55:41	https://bjork.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
762	Japanese Breakfast	For Melancholy Brunettes (& sad women)	https://michellezauner.bandcamp.com/album/for-melancholy-brunettes-sad-women?from=discover_page	Philadelphia, Pennsylvania	2025-03-21	https://f4.bcbits.com/img/a0371583987_16.jpg	33.99	{"Here is Someone","Orlando in Love","Honey Water","Mega Circuit","Little Girl",Leda,"Picture Window","Men in Bars","Winter in LA","Magic Mountain"}	10	00:32:22	https://michellezauner.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
763	Lea Bertucci	The Oracle	https://leabertucci.bandcamp.com/album/the-oracle?from=discover_page	New York, New York	2025-10-17	https://f4.bcbits.com/img/a0815537349_16.jpg	55.25	{"Oracular Chasm","The Place Where the Sky Was Born","The Oracle","Sister of Sleep","Two Way Mirror","In This Time"}	6	00:46:08	https://leabertucci.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
764	Anika	Change	https://anika.bandcamp.com/album/change?from=discover_page	Berlin, Germany	2021-07-23	https://f4.bcbits.com/img/a0345103488_16.jpg	18.70	{"Finger Pies",Critical,Change,Naysayer,"Sand Witches","Never Coming Back",Rights,Freedom,"Wait For Something"}	9	00:36:31	https://anika.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
765	Muslimgauze	Hamas Arc	https://muslimgauze.bandcamp.com/album/hamas-arc?from=discover_page	Berlin, Germany	2020-05-25	https://f4.bcbits.com/img/a4168775986_16.jpg	24.00	{"Jerusalem Knife","Khan Younis",Farsi,"Jerusalem Knife","Yasser Arafat's Radio",Zindabad,"Yasser Arafat's Radio"}	7	00:40:32	https://muslimgauze.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
766	Maude Vôs	Astral Intervals	https://maudevos.bandcamp.com/album/astral-intervals?from=discover_page	Los Angeles, California	2025-11-21	https://f4.bcbits.com/img/a1121767452_16.jpg	19.89	{"Theta Fugue",Solarcoaster,"Blue Phosphenes","Floating in Youphoria","Magic Always Lateball","Theta Fugue (Prieste5s Remix)"}	6	00:27:14	https://maudevos.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
767	Dark Companion Records	Then Again	https://darkcompanionrecords.bandcamp.com/album/then-again?from=discover_page	Italy	2025-12-29	https://f4.bcbits.com/img/a0609325960_16.jpg	31.00	{"Now Then Part. 1","Now Then Part. 2","Now Then Part. 3","Now Then Part. 4","Now Then Part. 5","Now Then Part. 6","Now Then Part. 7"}	7	01:03:34	https://darkcompanionrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
768	Blue Tapes	x-ray four: Piano Mating LP	https://bluetapes.bandcamp.com/album/x-ray-four-piano-mating-lp?from=discover_page	UK	2015-09-10	https://f4.bcbits.com/img/a1300028624_16.jpg	11.70	{"side a","side b"}	2	00:34:22	https://bluetapes.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
769	Blue Tapes	Jolly New Songs	https://bluetapes.bandcamp.com/album/jolly-new-songs?from=discover_page	UK	2017-10-27	https://f4.bcbits.com/img/a1639362840_16.jpg	12.87	{"Against Breaking Heart of a Breaking Heart",Coffin,Falling,Mist,"Jolly New Song","Leave It All","Love Supreme","Never Forget","None of Us","Only Good Weather","To Me"}	11	00:49:26	https://bluetapes.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
770	Yogg	Don''t You	https://yogg.bandcamp.com/album/dont-you?from=discover_page	Antwerp, Belgium	2026-01-30	https://f4.bcbits.com/img/a1429146230_16.jpg	16.00	{"The Ductile Swing","Don't You","It's Always Seven","Low On Life"}	4	00:19:07	https://yogg.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
771	@	Mind Palace Music	https://atcomputer.bandcamp.com/album/mind-palace-music?from=discover_page	Baltimore, Maryland	2023-02-17	https://f4.bcbits.com/img/a4039527842_16.jpg	22.09	{Parapet,"Star Game",Letters,"Friendship is Frequency","Boxwood Lane","Where'd You Put Me","Major Blue Empty","First Journal","Cut From Toxic Cloth","Camera Phone","My Garden"}	11	00:29:01	https://atcomputer.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
772	Violent Magic Orchestra	DEATH RAVE	https://violentmagicorchestra.bandcamp.com/album/death-rave?from=discover_page	Osaka, Japan	2024-03-13	https://f4.bcbits.com/img/a1136365482_16.jpg	25.00	{"PLANET HELVETECH",WARP,"The Destroyer electric utilities version","Choking Persuasion",Kokka,"Welcome to DEATH RAVE feat. Ican Harem - Gabber Modus Operandi","Satanic Violence Device feat. Dylan Walker - Full of Hell","MARTELLO MOSH PIT feat. Gabber Eleganza",VENOM,"Abyss feat. Kælan Mikla","Ecsedi Báthory Erzsébet",SUPERGAZE,"FYRE feat. Infinity Division","Song for the moon feat. Attila Csihar - MAYHEM","Flapping Dragon Wing"}	\N	00:32:20	https://violentmagicorchestra.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
773	tottomori	Black Lake	https://tottomori.bandcamp.com/album/black-lake?from=discover_page	Sweden	2026-01-09	https://f4.bcbits.com/img/a3705602825_16.jpg	450.00	{Havregryn,Syrup,"New Mast Sings With The Wind",Squidheart,Quarryman,"Yagi Phasing","This Island Of Clay","Lead Crest",Cistern,"Black Lake Radio Department","True Wood"}	11	00:34:39	https://tottomori.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
774	Purelink	Faith	https://purelink.bandcamp.com/album/faith?from=discover_page	Brooklyn, New York	2025-06-06	https://f4.bcbits.com/img/a1878222548_16.jpg	16.15	{"Looked Me Right In The Eye","Rookie (feat. Loraine James)","Kite Scene",Yoke,"First Iota (feat. Angelina Nonaj)","Circle of Dust"}	6	00:38:23	https://purelink.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
775	Severed Heads	Dead Eyes Opened	https://severedheads.bandcamp.com/album/dead-eyes-opened?from=discover_page	Sydney, Australia	2018-10-06	https://f4.bcbits.com/img/a4017495226_16.jpg	12.75	{"Dead Eyes Opened",Bullet,Mount}	3	00:11:35	https://severedheads.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
846	Tee Vee Repairmann	Only A Memory / Bad News	https://teeveerepairman.bandcamp.com/album/only-a-memory-bad-news?from=discover_page	Sydney, Australia	2025-11-21	https://f4.bcbits.com/img/a0148212783_16.jpg	15.00	{"Only A Memory","Bad News"}	2	00:05:08	https://teeveerepairman.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
776	Lyra Pramuk	Hymnal	https://lyrapramuk.bandcamp.com/album/hymnal?from=discover_page	Berlin, Germany	2025-06-13	https://f4.bcbits.com/img/a1003987123_16.jpg	25.00	{Rewild,Unchosen,Render,Incense,Oracle,Babel,Meridian,Gravity,Swallow,Umbra,Crimson,Reality,Solace,Ending}	14	00:49:44	https://lyrapramuk.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
777	Mike Paradinas	1979	https://mikeparadinas.bandcamp.com/album/1979?from=discover_page	Hove, UK	2025-10-31	https://f4.bcbits.com/img/a4196719554_16.jpg	50.00	{"Majadahonda at Dawn","Clari 1",Billowy,Galletas,Floatation,Pulsar,Radox,"Houzz 14",Tente,Holmbush,"The Next Room","Clari 2","Majadahonda at Dusk",Yemas,Escorial}	15	01:00:41	https://mikeparadinas.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
778	keiyaA	hooke’s law	https://keiyaa.bandcamp.com/album/hooke-s-law?from=discover_page	Chicago, Illinois	2025-10-31	https://f4.bcbits.com/img/a0471695150_16.jpg	29.75	{"waltz d'hethert","i h8 u","stupid prizes","take it","be quiet!!!","think about it/what u think?",k.i.s.s.,"make good","keiyaA feat. Rahrah Gabor & Rahrah Gabor - this time",lateeee,"get close 2 me","fire sign oath",motions,"motions (reprise)","break it",thirsty,devotions,"nobody show","until we meet again"}	19	00:52:34	https://keiyaa.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
779	Björk	Post	https://bjork.bandcamp.com/album/post?from=discover_page	Iceland	1995-06-13	https://f4.bcbits.com/img/a4075712728_16.jpg	28.07	{"Army Of Me",Hyperballad,"The Modern Things","It's Oh So Quiet",Enjoy,"You've Been Flirting Again",Isobel,"Possibly Maybe","I Miss You","Cover Me",Headphones}	11	00:46:15	https://bjork.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
780	Max Jaffe	You Want That Too!	https://maxjaffe.bandcamp.com/album/you-want-that-too?from=discover_page	Los Angeles, California	2025-11-21	https://f4.bcbits.com/img/a3245842387_16.jpg	27.20	{"Up Top Up","Pedro Point",S-NARE,"Gulf Of Mexico","Wooden Wire Tap","Looking At The Inside Of Your Eyelids","Putney Waltz","Ancestral Creeks","In Green","Zen and Pteent"}	10	00:33:44	https://maxjaffe.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
781	XIU XIU	Xiu Mutha Fuckin'' Xiu: Vol. 1	https://xiuxiu69.bandcamp.com/album/xiu-mutha-fuckin-xiu-vol-1?from=discover_page	Los Angeles, California	2026-01-16	https://f4.bcbits.com/img/a1988952091_16.jpg	18.70	{"Psycho Killer","Warm Leatherette","I Put a Spell on You","Hamburger Lady","In Dreams","Sex Dwarf","Dancing on My Own",SPQR,"Lick or Sum","Some Things Last a Long Time","Triple Sun","Cherry Bomb","Brand New Bitch (7\\" - Side A)","Enola Gay (7\\" - Side B)"}	14	00:51:57	https://xiuxiu69.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
782	Robohands	Oranj	https://robohands.bandcamp.com/album/oranj?from=discover_page	London, UK	2026-01-16	https://f4.bcbits.com/img/a3362371160_16.jpg	22.10	{"One Good Deed Every Day","Hermit Part III",1989,Achilles,"Leonid The Athlete","Regular Exercise",Marea,Recreation,Object,"New Era Part I",Oranj,"New Era Part II",1990,"One Good Deed Every Day (Dark Outro Version)"}	14	00:34:35	https://robohands.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
783	TFS	A Laughing Death in Meatspace	https://tropicalfstorm.bandcamp.com/album/a-laughing-death-in-meatspace?from=discover_page	Melbourne, Australia	2018-05-04	https://f4.bcbits.com/img/a0654956755_16.jpg	19.55	{"You Let My Tyres Down","Antimatter Animals","Chameleon Paint","The Future of History","Two Afternoons","Soft Power","Shellfish Toxin","A Laughing Death in Meatspace","Rubber Bullies"}	9	00:47:17	https://tropicalfstorm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
784	Maple Death Records	Flowers Are Blooming In Antarctica	https://mapledeathrecords.bandcamp.com/album/flowers-are-blooming-in-antarctica?from=discover_page	Bologna, Italy	2025-01-31	https://f4.bcbits.com/img/a1305432499_16.jpg	48.00	{Ittiolalia,"Cuttlefish REM Phase","The Drowned World","P.P.R.N (Physarum Polycephalum Rail Network)","Are We Dinos?","Oasi Bar","Solvay Beach","Emperor Penguin Lullaby"}	8	00:43:27	https://mapledeathrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
785	Vox Populi	Sucre De Pastèque	https://vox-populi.bandcamp.com/album/sucre-de-past-que?from=discover_page	France	2025-12-05	https://f4.bcbits.com/img/a0174426080_16.jpg	29.75	{"Yarom Lalou",Pellucidar,Neoplastie,Opium,Echreman,"Ovan III","Bio Berim","Be Mafu","Gutta Percha II","Tibetan Cowboy","Glassy Stare","Atal Matal Toutoule",Apnée,"Baby Sex",Yek!,"Alternative Fresh",Divane,Djostodjou}	18	00:45:47	https://vox-populi.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
786	GHETTO SCI-FI	BLUNTS ROLLED [GSF13]	https://ghettoscifi.bandcamp.com/album/blunts-rolled-gsf13?from=discover_page	Los Angeles, California	2025-12-11	https://f4.bcbits.com/img/a3352378814_16.jpg	85.00	{"Blunts Rolled By.. (ft Ras_G)","Toast Up The Broccoli (Ft. Kahil Sadiq)","2High (Ft. The Koreatown Oddity)","Sourdiesel (Interlude)","Edeus OG (Spacebase Hybrid)",Haze,Ate2ManyEdibles,"Smoking? (ft. Zeroh)","NickelSackkah (ft. Kahil Sadiq)","Kush OG",Blunt2ThaFace,GrabbaSkills,"LordSunLib OG (Spacebase Hybrid)","47 + 2","Last Nugg","Regular (SomeBeforeNone) Outro"}	16	00:32:01	https://ghettoscifi.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
787	Richard Youngs	Hidden	https://nofansrecords.bandcamp.com/album/hidden?from=discover_page	Glasgow, UK	2025-12-05	https://f4.bcbits.com/img/a0446212931_16.jpg	28.50	{"Hidden I","Hidden II"}	2	00:35:30	https://nofansrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
788	SPELLLING	Portrait of My Heart	https://spellling.bandcamp.com/album/portrait-of-my-heart?from=discover_page	Oakland, California	2025-03-28	https://f4.bcbits.com/img/a2218025435_16.jpg	17.85	{"Portrait of My Heart","Keep It Alive",Alibi,Waterfall,"Destiny Arrives",Ammunition,"Mount Analogue",Drain,Satisfaction,"Love Ray Eyes",Sometimes}	11	00:41:02	https://spellling.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
789	James Holden	The Universe Will Take Care Of You	https://jamesholden.bandcamp.com/album/the-universe-will-take-care-of-you?from=discover_page	London, UK	2025-06-13	https://f4.bcbits.com/img/a2348964125_16.jpg	25.74	{"You Are Gods","Sunbeam Path","Time Ring Rattles","Sparkles, Crystals, Miracles","Incredible Bliss","The Universe Will Take Care Of You"}	6	00:50:38	https://jamesholden.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
790	Mary Ocher	Weimar	https://maryocher.bandcamp.com/album/weimar?from=discover_page	Berlin, Germany	2026-03-13	https://f4.bcbits.com/img/a4288319282_16.jpg	80.00	{"The Dance","(As Free As) The Great Outdoors (revisited)","On The Streets of Hard Labor (revisited)",Divorce,"The Narrative (First Movement)","The Narrative (Second Movement)","The Narrative (Third Movement)","To Transcend"}	8	00:20:50	https://maryocher.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
791	Hushtones	Everywhere At The End Of Bikini Bottom	https://hushtones.bandcamp.com/album/everywhere-at-the-end-of-bikini-bottom?from=discover_page	Portland, Maine	2025-07-29	https://f4.bcbits.com/img/a2897070750_16.jpg	35.70	{"I Can Still Remember Jellyfish Fields","Kelp Forest Deforestation","Missing The Soft Buzz Of The Jellyfish","Gary Has Passed, But His Memories Linger Still","Remember Browsing The Aisles","My Heart Rips Another Time","Mind Washing Away Slowly Like Sand","The Feelings That Fade Eventually","My Past Friend Who Has Given Up On Me","Sometimes, Things Still Seem F.U.N","The Time Wasted In That Cursed Trap","That Dance With Her Was So Long Ago","Memories Keep Repeating","Art By My Neighbor","The Sunlight No Longer Reaches The Ocean Floor","Dancing Is Sadly An Activity Of The Past","Sea Kelp Entanglements","Bitter Liquid, Release My Pain","My Memories Of Her Keep Escaping Me",Bottom,"The Knowledge Of The Secret Is No Longer Important","Echoing Remains Of Memories That I Am Unsure Are Real","I Am Proof Neptune Has No Mercy","Momentary Panic Before Losing Lucidity","Eyes Staring At Me From Rock Bottom, They Are Calling","The Journey To Shell City Is Soon To End"}	26	01:28:00	https://hushtones.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
792	Björk	Homogenic	https://bjork.bandcamp.com/album/homogenic?from=discover_page	Iceland	1997-09-22	https://f4.bcbits.com/img/a1651737507_16.jpg	28.07	{Hunter,Joga,Unravel,Bachelorette,"All Neon Like","5 Years",Immature,"Alarm Call",Pluto,"All Is Full Of Love"}	10	00:43:35	https://bjork.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
793	Sam Wilkes, Craig Weinrib, and Dylan Day	Sam Wilkes, Craig Weinrib, and Dylan Day	https://samcraigdylan.bandcamp.com/album/sam-wilkes-craig-weinrib-and-dylan-day?from=discover_page	Los Angeles, California	2024-07-12	https://f4.bcbits.com/img/a1374760705_16.jpg	21.25	{"Standing In The Doorway","Too Young To Go Steady","How Insensitive",Rain,Snow,"When I Can Read My Titles Clear","I'll Find A Way (To Carry It All)"}	7	00:31:51	https://samcraigdylan.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
794	Sophomore Lounge	RYAN DAVIS & the Roadhouse Band "Dancing on the Edge"	https://sophomorelounge.bandcamp.com/album/ryan-davis-the-roadhouse-band-dancing-on-the-edge?from=discover_page	Jeffersonville, Indiana	2023-10-27	https://f4.bcbits.com/img/a0327828919_16.jpg	27.20	{"Free From the Guillotine","Learn 2 Re-Luv","Flashes of Orange","Bluebirds in a Fight","Junk Drawer Heart","A Suitable Exit","Bluebirds Revisited"}	7	00:51:14	https://sophomorelounge.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
795	Geometric Lullaby	永遠の愛	https://geometriclullaby.bandcamp.com/album/--59?from=discover_page	Pittsburgh, Pennsylvania	2025-09-05	https://f4.bcbits.com/img/a3490519594_16.jpg	53.83	{あなたを残す,昇天,永遠に夢,水の下にキス,あなたと一人で数分,心と魂の核変換／私たちの感情は一緒になって,永遠の愛,真夜中の訪問者,いつもそこに私のために,楽園で別の日。。。,アストラルセックス}	11	01:43:59	https://geometriclullaby.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
796	KALI MALONE	The Sacrificial Code (2025 edition)	https://kalimalone.bandcamp.com/album/the-sacrificial-code-2025-edition?from=discover_page	Stockholm, Sweden	2025-04-11	https://f4.bcbits.com/img/a3267509691_16.jpg	35.00	{"Spectacle Of Ritual","Sacrificial Code","Rose Wreath Crown (for CW)","Sacer Profanare","Litanic Cloth Wrung","Fifth Worship II","Hagakyrka Bells","Sacrificial Code II","Sacrificial Code III"}	9	01:15:33	https://kalimalone.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
797	Ivan The Tolerable	Chromophobia (2LP, Riot Season, 2026)	https://ivanthetolerable.bandcamp.com/album/chromophobia-2lp-riot-season-2026?from=discover_page	Middlesbrough, UK	2026-02-05	https://f4.bcbits.com/img/a2144567040_16.jpg	29.25	{"Pale Dogwood","Field Drab","Ceder Chest","Wild Blue Yonder",Inchworm,Vetiver,"Orange Crayola","Black Olive","Wild Strawberry","African Violet","Deep Sky","Permanent Geranium Lake",Carnelian,Heliotrope}	14	01:20:37	https://ivanthetolerable.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
798	Keanu Nelson	Place Where I Go	https://keanunelson.bandcamp.com/album/place-where-i-go?from=discover_page	Papunya, Australia	2025-04-25	https://f4.bcbits.com/img/a2679636634_16.jpg	20.00	{"Place Where I Go","Kapi Ngalyananni"}	2	00:07:23	https://keanunelson.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
799	LAYER Records	LAYER ONE REMIXES	https://layerrecords.bandcamp.com/album/layer-one-remixes?from=discover_page	Berlin, Germany	2025-12-12	https://f4.bcbits.com/img/a3253181263_16.jpg	19.00	{"Ben Klock & Fadi Mohem feat. Flowdan - Our Sector (Azu Tiwaline & Cinna Peyghamy Remix)","Ben Klock & Fadi Mohem feat. Coby Sey - Ultimately (Amotik Remix)","Ben Klock & Fadi Mohem feat. Flowdan - Our Sector (Quelza Reinterpretation)","Ben Klock & Fadi Mohem feat. Coby Sey - Clean Slate (Alarico Remix)"}	4	00:23:27	https://layerrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
800	Patricia Wolf	Hrafnamynd	https://patriciawolf.bandcamp.com/album/hrafnamynd?from=discover_page	Portland, Oregon	2025-07-11	https://f4.bcbits.com/img/a3477744615_16.jpg	35.00	{"Early Memories","Subconscious Familiarity","Krummi’s Theme","Huginn and Muninn","The Return to Iceland","Reykjavík by the Sea","I Thought I Could Fly",Hrafnaþing,"Surfing on Wind","Echoes Through Time","I’ll Take Care of You"}	11	00:44:24	https://patriciawolf.bandcamp.com?from=discover_page	2026-02-23 13:22:19.707017	2026-02-23 13:22:19.707017
801	Mary Lattimore	Silver Ladders	https://marylattimoreharpist.bandcamp.com/album/silver-ladders?from=discover_page	Los Angeles, California	2020-10-09	https://f4.bcbits.com/img/a0354576578_16.jpg	17.00	{"Pine Trees","Silver Ladders","Til A Mermaid Drags You Under","Sometimes He's In My Dreams","Chop on the Climbout","Don't Look","Thirty Tulips"}	7	00:40:18	https://marylattimoreharpist.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
802	Clark	Steep Stims	https://clark.bandcamp.com/album/steep-stims?from=discover_page	UK	2025-11-07	https://f4.bcbits.com/img/a1442063294_16.jpg	33.93	{"Gift and Wound","Infinite Roller","No Pills U","Janus Modal","18EDO Bailiff","Globecore Flats","Blowtorch Thimble",Civilians,"Inpatient's Day Out","Who Booed the Goose","5 Millionth Cave Painting","Negation Loop","Micro Lyf"}	13	00:47:59	https://clark.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
803	Buried Treasure	THEY CAME FROM BEYOND SPACE	https://buriedtreasure.bandcamp.com/album/they-came-from-beyond-space-2?from=discover_page	UK	2025-10-03	https://f4.bcbits.com/img/a1266879740_16.jpg	19.89	{"M1 Main Title","1M2 Meterorites At Robert's Farm","2M2 You May Chose Your Target And Connect","2M4 Not This One","3M4 Lee, I've Got To Talk To You","3M6 The Crimson Plague","4M2 Rocket Launch","6M2 Temple Escapes","Moon Music x 3","8M1 Three Scientists From Earth","8M2 Follow Me","8M3 We Only Need Have Asked"}	12	00:19:01	https://buriedtreasure.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
804	Adhémar	Mountain View [OSP004]	https://adhemar.bandcamp.com/album/mountain-view-osp004?from=discover_page	Paris, France	2025-10-06	https://f4.bcbits.com/img/a3696314464_16.jpg	19.55	{"The Oak Tree","Rain On The Lake","Touching The Clouds","Between Two Rivers","Touching The Clouds (Night Sea Remix)"}	5	00:33:31	https://adhemar.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
805	GoGo Penguin	v2.0 (Deluxe Edition)	https://gogopenguin.bandcamp.com/album/v20-deluxe-edition?from=discover_page	Manchester, UK	2018-04-21	https://f4.bcbits.com/img/a1576244414_16.jpg	29.24	{Murmuration,"Garden Dog Barbecue",Kamaloka,Fort,"One Percent",Home,"The Letter","To Drown In You","Shock And Awe",Hopopono,"Break (Bonus Track)","In Amber (Bonus Track)","Wash (Bonus Track)"}	13	01:01:14	https://gogopenguin.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
806	Sonic Youth	Sister	https://sonicyouth.bandcamp.com/album/sister?from=discover_page	New York, New York	2020-11-30	https://f4.bcbits.com/img/a4237859239_16.jpg	15.30	{Schizophrenia,"Catholic Block","Beauty Lies In The Eye","Stereo Sanctity","Pipeline/Kill Time","Tuff Gnarl","Pacific Coast Highway","Hot Wire My Heart","Kotton Krown","White Cross"}	10	00:37:32	https://sonicyouth.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
807	INDEX:Records	Department	https://indexrecords.bandcamp.com/album/department?from=discover_page	Glasgow, UK	2025-12-12	https://f4.bcbits.com/img/a0196166380_16.jpg	18.72	{Cogent,Recovery}	2	00:17:25	https://indexrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
808	Mandy, Indiana	i''ve seen a way	https://mandyindiana.bandcamp.com/album/ive-seen-a-way?from=discover_page	Manchester, UK	2023-05-19	https://f4.bcbits.com/img/a2760412963_16.jpg	21.24	{"Love Theme (4K VHS)","Drag [Crashed]","Pinking Shears","Injury Detail",Mosaick,"The Driving Rain (18)","2 Stripe","Iron Maiden","Peach Fuzz","(ノ>ω<)ノ :。・:*:・゚’★,。・:*:♪・゚’☆ (Crystal Aura Redux)","Sensitivity Training"}	11	00:37:07	https://mandyindiana.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
809	Sublunar	Dont Be Naive	https://sublunarrecords.bandcamp.com/album/dont-be-naive?from=discover_page	Florence, Italy	2025-04-04	https://f4.bcbits.com/img/a1237053657_16.jpg	12.00	{MM6,Aspects,"Dont Be Naive",Eventide,"Keepers Of Secret","Chapter X"}	6	00:30:33	https://sublunarrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
810	Station Model Violence	Station Model Violence	https://stationmodelviolence.bandcamp.com/album/station-model-violence?from=discover_page	Sydney, Australia	2026-02-27	https://f4.bcbits.com/img/a4217277643_16.jpg	32.00	{"Learn to Hate",Cliffs,Immolation,Leisure,"Drip Away","Apex Calling","Heat (Single Version)","Two Eyes for an Eye","Crepe Throne","Falling Down"}	10	00:34:14	https://stationmodelviolence.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
811	Institute	Institute	https://institute.bandcamp.com/album/institute?from=discover_page	Austin, Texas	2026-02-20	https://f4.bcbits.com/img/a3708144523_16.jpg	15.00	{"The Shooter","A Privilege","Why Are These Men Still Alive?"}	3	00:09:44	https://institute.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
812	Landowner	Assumption	https://landowner.bandcamp.com/album/assumption?from=discover_page	Holyoke, Massachusetts	2026-02-27	https://f4.bcbits.com/img/a1226589881_16.jpg	18.70	{Assumption,"PRAY For The Environment","Linear Age","Rival Males","Expensive Rent","Enemy Attack",Uninhabitable,"Parapet Wall",Unboxing,"Bow To Your Superior","Slippery Abyss","Normal Returns To Normal"}	12	00:34:57	https://landowner.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
813	The Boojums	The Boojums	https://theboojums.bandcamp.com/album/the-boojums?from=discover_page	Port Hawkesbury, Nova Scotia	2025-10-31	https://f4.bcbits.com/img/a3169030712_16.jpg	25.00	{"Outta My Head","Wings of Fire","Stick Together","Burnin Up","Meet Me In The Middle","Like It","Garden of the Sons",Football,Gravy,"Don't Wanna Love","Dan's Transmission","Yellow Lines"}	12	00:31:51	https://theboojums.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
814	Commitment	Fear Of	https://commitmentphl.bandcamp.com/album/fear-of?from=discover_page	Philadelphia, Pennsylvania	2026-04-03	https://f4.bcbits.com/img/a1388236214_16.jpg	21.25	{Thirsty,"Let's Begin",Bukakkracy,Hellraiser,"Pluto in Aquarius","DOG POUND","Hall of Meat",Content,STD,Lickback,"Hard Candy","Affirmative Action","Bada Bing!",Neuromancer,"Fear Of"}	15	00:20:46	https://commitmentphl.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
815	Artificial Go	Musical Chairs	https://artificialgo.bandcamp.com/album/musical-chairs?from=discover_page	Cincinnati, Ohio	2025-05-16	https://f4.bcbits.com/img/a0295590264_16.jpg	16.99	{Lasso,Circles,Yaya,"The World is My Runway","Red Convertible",Hallelujah,"Tight Rope Walker","Playing Puppet","Late to the Party","Sky Burial"}	10	00:26:02	https://artificialgo.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
816	Mães Solteiras	Vamos ser breves	https://maesolteiras.bandcamp.com/album/vamos-ser-breves?from=discover_page	Lisbon, Portugal	2026-01-06	https://f4.bcbits.com/img/a2548982110_16.jpg	20.00	{"Pedra fedelho","Não peçam horas extra a uma mãe solteira","Recursos humanos","Casa com pernas","O teu nome no edital","Sala de espera",Alcindo,"Tu és bué","Tique taque","Lembrete amigável","Vem devagar","Amor ponto corp","Vamos ser breves"}	13	00:29:16	https://maesolteiras.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
817	ALIEN SNATCH!	SWEET REAPER - Still Nothing	https://aliensnatch.bandcamp.com/album/sweet-reaper-still-nothing?from=discover_page	Berlin, Germany	2026-01-16	https://f4.bcbits.com/img/a4268334176_16.jpg	15.95	{Clean,Sacrifice,Motion,"Thought Police","Walk Away","Zero Candles",Hideaway,"Sick n Tired","Mee Mees",Ratchet,Energy}	11	00:26:51	https://aliensnatch.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
818	Scowl	Are We All Angels	https://scowl831.bandcamp.com/album/are-we-all-angels?from=discover_page	Santa Cruz, California	2025-04-04	https://f4.bcbits.com/img/a4080746162_16.jpg	21.24	{Special,B.A.B.E.,Fantasy,"Not Hell, Not Heaven","Tonight (I’m Afraid)","Fleshed Out","Let You Down",Cellophane,"Suffer The Fool (How High Are You?)",Haunted,"Are We All Angels"}	11	00:32:51	https://scowl831.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
819	Lambrini Girls	Who Let The Dogs Out	https://lambrinigirlsband.bandcamp.com/album/who-let-the-dogs-out?from=discover_page	Brighton, UK	2025-01-10	https://f4.bcbits.com/img/a1851543162_16.jpg	24.00	{"Bad Apple","Company Culture","Big Dick Energy","No Homo","Nothing Tastes As Good As It Feels","You’re Not From Around Here","Scarcity Is Fake","Filthy Rich Nepo Baby","Special Different",Love,"Cuntology 101"}	11	00:29:26	https://lambrinigirlsband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
820	ALIEN SNATCH!	KÜKEN - Palermo	https://aliensnatch.bandcamp.com/album/k-ken-palermo?from=discover_page	Berlin, Germany	2026-01-14	https://f4.bcbits.com/img/a4154190203_16.jpg	6.66	{Palermo,"Grass Green","Split Mind","Ocean Breeze"}	4	00:06:49	https://aliensnatch.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
821	KÜKEN	Palermo EP	https://kueken.bandcamp.com/album/palermo-ep?from=discover_page	Hamburg, Germany	2026-01-14	https://f4.bcbits.com/img/a0586935874_16.jpg	9.00	{Palermo,"Grass Green","Split Mind","Ocean Breeze"}	4	00:06:49	https://kueken.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
822	The Ziggens	Well Qualified To Represent the L.B. Sea!	https://theziggens.bandcamp.com/album/well-qualified-to-represent-the-l-b-sea?from=discover_page	Long Beach, California	2026-01-30	https://f4.bcbits.com/img/a1867468227_16.jpg	25.49	{"One Note After Another","Finders Keepers","Secret Spot","The Hole","Locals Only!",Churches,"Little Sweater","Chop Wood","Spaghetti Western","Lightning Bolt","Stingray Shuffle","Sunset Session","Bert Surfsanka","Primatene Missed","Reese Without Her Spoon","Previously On Glee","Dark Shadow (feat. Tunnel Vision and Chuck Treece)","After The Rain (feat. Johnny Cosmic)","Hotel Can't Afford Ya","Free Adrenaline","Sieze Candy","Don't Let Me Down (Any More Alcohol)","Your Shenanigans Are Gonna Cost Me","Veronica Wipes The Face Of Jesus","Theme to A Future Surf Movie","St. Berto"}	26	01:17:34	https://theziggens.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
823	Pigmé Records	Lucky Pepper - Cooking Without Singing!	https://pigmerecords.bandcamp.com/album/lucky-pepper-cooking-without-singing?from=discover_page	Travaillan, France	2026-01-14	https://f4.bcbits.com/img/a3585534577_16.jpg	18.00	{"Ragin' Cajun",Hyperdrive,"Operation Pedro Marquez","The Fight","Lucky Poppers",Supernova,"Mermaid Cove","Venus Beach"}	8	00:19:22	https://pigmerecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
824	Radioactivity	Time Won''t Bring Me Down	https://radioactivitytx.bandcamp.com/album/time-wont-bring-me-down?from=discover_page	Austin, Texas	2025-10-31	https://f4.bcbits.com/img/a4202447809_16.jpg	18.00	{"Time Won't Bring Me Down","Watch Me Bleed","This One Time",Why,"Ignorance Is Bliss","I Thought","One Day",Sleep,"Analog Ways",Shell,Pain}	11	00:30:32	https://radioactivitytx.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
825	ONYON	Pale Horses	https://onyon.bandcamp.com/album/pale-horses?from=discover_page	Leipzig, Germany	2025-11-11	https://f4.bcbits.com/img/a0653040049_16.jpg	18.00	{"Moony Cat",Molasses,"Schiefe Bahn","Whiffs of Smoke","The Figurine","The Demon",Stereometrie,"Triple Moon Ride","Secret of the Ooze","Pferdchen, bis bald!"}	10	00:29:11	https://onyon.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
826	Motorbike	Kick It Over	https://motorbikernr.bandcamp.com/album/kick-it-over?from=discover_page	Cincinnati, Ohio	2025-03-21	https://f4.bcbits.com/img/a3398931896_16.jpg	18.69	{"Scrap Heap",Currency,"Cold Sweat","Afraid of Guns","Western Front","Gears Never Dry","Quite Nice","Nie Wrócimy","Jungle Land","What Have I Done"}	14	00:39:45	https://motorbikernr.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
827	Total Punk Records	Greetings From	https://totalpunkrecords.bandcamp.com/album/greetings-from?from=discover_page	Portland, Oregon	2026-02-06	https://f4.bcbits.com/img/a3355906042_16.jpg	17.00	{"Theme Song","Nudie Beach","Gimmie A Break","Smelly Boys",T.V.,"Waiting Around",Cartoon,Secrets,"Fortune Teller","Going Out",Lies,"City Line"}	12	00:21:42	https://totalpunkrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
828	Beach Impediment Records	Fascist EP	https://beachimpedimentrecords.bandcamp.com/album/fascist-ep?from=discover_page	Richmond, Virginia	2025-12-05	https://f4.bcbits.com/img/a0248673169_16.jpg	8.92	{Fascist,"No Straight Edge","Speed of the Presses","American Way","Jump Up My Ass",Suburbanite,"Nuke Attack","Having Fun",Outro}	9	00:05:35	https://beachimpedimentrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
829	Twenty One Children	TWENTY ONE CHILDREN "S/T" EP	https://twentyonechildren.bandcamp.com/album/twenty-one-children-s-t-ep?from=discover_page	Soweto, South Africa	2025-05-23	https://f4.bcbits.com/img/a0210392859_16.jpg	9.31	{"Ice Cube","Talk Shows","Let it Doom","Looney Bin"}	4	00:08:31	https://twentyonechildren.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
830	Flat Moon	Cookin'' Up A Groove	https://flatmoonband.bandcamp.com/album/cookin-up-a-groove?from=discover_page	Leeds, UK	2025-12-05	https://f4.bcbits.com/img/a3593798042_16.jpg	30.42	{"Said Groove","A Moon's Bouche","Private Rendezvous","B-Funk (Get Out The Way)","Bois In Blu (Interlude)",Ndujathinkhesaurus,"Soupe Du Jour (Interlude)",Schleep,"Fogz & Snek","I Dunno...Pub? (Interlude)","Too Drunk To Funk",Dizzy,"On A Close"}	13	00:46:57	https://flatmoonband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
831	Landowner	Escape the Compound	https://landowner.bandcamp.com/album/escape-the-compound?from=discover_page	Holyoke, Massachusetts	2023-07-21	https://f4.bcbits.com/img/a3851642922_16.jpg	15.30	{"Witch Museum","Heat Stroke","Swimmer of Note","Victim of a Narcissist's Tactics",Nineties,"Escape the Compound","Beyond the Darkened Library",Aftermath,"Thousands of Years in Fast Forward","Damning Evidence","Slow Tactics",Floodwatch}	12	00:36:19	https://landowner.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
973	GNAC, Vetchinsky Settings, The Montgolfier Brothers, Mark Tranmer, Wingdisk	An Octave Of Silence	https://marktranmer.bandcamp.com/album/an-octave-of-silence?from=discover_page	Stirling, UK	2026-04-16	https://f4.bcbits.com/img/a1858461582_16.jpg	46.80	{"Les Flâneuses",12:41,2:37,1:51,4:02,12:44}	6	00:06:25	https://marktranmer.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
832	JER	Death of the Heart	https://jerska.bandcamp.com/album/death-of-the-heart?from=discover_page	Gainesville, Florida	2025-08-15	https://f4.bcbits.com/img/a2389949027_16.jpg	21.25	{"I'M STILL BOTHERED","The Way You Tune It Out","Couldn't Be Me","Silence is Violence","DO SOMETHING (Interlude)","Capitalism Breeds Devastation","What Will You Do?","Cult of the Lonely","They Hear Us, But They Ain't Listenin' (Interlude)","Death of the Heart","Claim Yr True Feelings, Wounded Child","Tryin, I Really Am","I'd Like To Be Better","Log Off","Grow Through What We Go Through"}	15	00:42:28	https://jerska.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
833	Pest Productions	Visual Kill: The Blossoming of Psychotic Depravity	https://pestproductions.bandcamp.com/album/visual-kill-the-blossoming-of-psychotic-depravity?from=discover_page	China	2025-03-26	https://f4.bcbits.com/img/a2483502681_16.jpg	22.94	{"Genocidal Bloodfiend","Desecration of a Lustful Illusion","Sick Abducted Purity","Switchblade Paradise","Seraphic lullaby","Veins of The Wicked","Tears Seeping Through Beautiful Agony","Visual Kill",Suffer}	9	00:36:48	https://pestproductions.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
834	Sextile	yes, please.	https://sextile.bandcamp.com/album/yes-please?from=discover_page	Los Angeles, California	2025-05-02	https://f4.bcbits.com/img/a3577642530_16.jpg	21.25	{Intro,"Women Respond to Bass","Freak Eyes","Penny Rose","Push Ups",Kids,"99 Bongos","S is For",Rearrange,Resist,Kiss,Hospital,"Soggy Newports"}	13	00:37:04	https://sextile.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
835	Huggy Bear	Basic Strategies for Going Out: Peel Sessions	https://huggybear.bandcamp.com/album/basic-strategies-for-going-out-peel-sessions?from=discover_page	UK	2026-02-14	https://f4.bcbits.com/img/a1604370989_16.jpg	20.40	{"Nu Song","Teen Tighterns","Her Jazz",Hopscorch,"Limit 2 Surf","You Don't","Our Voltage","Steppin On Bugs"}	8	00:17:01	https://huggybear.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
836	Hot Mulligan	you''ll be fine	https://hotmulligan.bandcamp.com/album/youll-be-fine-2?from=discover_page	Lansing, Michigan	2020-03-06	https://f4.bcbits.com/img/a1841740172_16.jpg	21.25	{"OG Bule Sky","*Equip Sunglasses*","Feal Like Crab","Green Squirrel In Pretty Bad Shape","Dirty Office Bongos","Analog Fade (New Bule Sky)","We're Gonna Make It To Kilby!","Digging In",SPS,BCKYRD,"The Song Formerly Known As Intro"}	11	00:31:17	https://hotmulligan.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
837	Kælan Mikla	Undir Köldum Norðurljósum	https://kaelanmikla.bandcamp.com/album/undir-k-ldum-nor-urlj-sum?from=discover_page	Reykjavik, Iceland	2021-10-15	https://f4.bcbits.com/img/a2278116213_16.jpg	29.75	{"Svört Augu",Sólstöður,Örlögin,Halastjarnan,Ósýnileg,Sírenur,Stormurinn,Óskasteinar,"Hvítir Sandar (feat. Alcest)",Saman}	10	00:45:55	https://kaelanmikla.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
838	Chopping Block	Nowhere To Run	https://choppingxblock.bandcamp.com/album/nowhere-to-run?from=discover_page	Seattle, Washington	2026-01-09	https://f4.bcbits.com/img/a1487699539_16.jpg	21.25	{"Big Man","Push You Away","How Can I Be Sure","Eyes Fall",Phony,"Same Old Shit","Fuck Wrong","You Think You Know",Monsters,"Rumor Mill","Burn. Fade. Rise. Fall.",Burning,"Look Within","Regime Change"}	14	00:17:39	https://choppingxblock.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
839	Tomb Tree Tapes	O Merciful	https://tombtreetapes.bandcamp.com/album/o-merciful?from=discover_page	Nanaimo, British Columbia	2026-01-12	https://f4.bcbits.com/img/a1014939562_16.jpg	25.50	{Judy,"Generational Blues",Ennui,"Prayer from a Sinful Man",Bogie,Confined,"Please, Be Careful","A Reflection"}	8	00:16:46	https://tombtreetapes.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
840	Orange Whip	Orange Whip	https://orangewhip.bandcamp.com/album/orange-whip?from=discover_page	Boston, Massachusetts	2025-10-31	https://f4.bcbits.com/img/a3165716194_16.jpg	8.50	{"Horse Phase","Drippy City","Wash My Hair","Fake Ghost Video","Pepsi Clear"}	5	00:08:29	https://orangewhip.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
841	High Vis	Blending	https://highvis.bandcamp.com/album/blending?from=discover_page	London, UK	2022-09-30	https://f4.bcbits.com/img/a2588336529_16.jpg	12.74	{"Talk For Hours",0151,"Out Cold",Blending,"Trauma Bonds","Fever Dream","Morality Test","Join Hands",Shame}	9	00:37:41	https://highvis.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
842	Flatspot Records	FSR85 - Wrong Side Of Heaven	https://flatspotrecords.bandcamp.com/album/fsr85-wrong-side-of-heaven?from=discover_page	Baltimore, Maryland	2025-08-29	https://f4.bcbits.com/img/a3425238653_16.jpg	21.25	{"Wrong Side Of Heaven","Pale Horse","Exploiter (SYBAU)","Billion Dollar Question",Cloutbusting,"Life Sublime","Optical Delusions","I Lament","Used 2 Be",Anti-Colonial,"Future Without A Past","Disdain (U Mad)",Hookworm,"Could You Love Me?","Empire's Demise"}	15	00:22:38	https://flatspotrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
843	Bob Vylan	We Live Here (Deluxe)	https://bobvylan.bandcamp.com/album/we-live-here-deluxe-2?from=discover_page	London, UK	2021-02-12	https://f4.bcbits.com/img/a3752216242_16.jpg	23.40	{Intro,"We Live Here","England's Ending","Pulled Pork","Lynch Your Leaders","Northern Line","Save Yourself","Moment of Silence","I Heard You Want Your Country Back (Bonus Track)","CGSB (Bonus Track)"}	10	00:23:24	https://bobvylan.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
844	The ETTERS	The ETTERS maken je hartstikke DOOD!	https://theetters.bandcamp.com/album/the-etters-maken-je-hartstikke-dood?from=discover_page	Netherlands	2025-09-26	https://f4.bcbits.com/img/a1241729126_16.jpg	20.00	{A.S.O.,"Geen hoofd","Ik pis in je brievenbus",Engnek,"Ik ben zo blij (dat ik jou niet ben)","Lauwe halve liters","Patat met een snack","Vuilnis en stront",Kettingzaag,"Iedereen haat jou",1312,Botergeil,"Je mag 't niet zeggen","John Wayne Gacy geeft een feessie",Kaassouflé,"Anders dan de rest","Kleine lul","Iedereen is fan van The ETTERS",Viennetta,"Harder dan je vriendje","Lekker speed snuiven"}	21	00:19:46	https://theetters.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
845	Lambrini Girls	You''re Welcome	https://lambrinigirlsband.bandcamp.com/album/youre-welcome?from=discover_page	Brighton, UK	2023-05-19	https://f4.bcbits.com/img/a0859892131_16.jpg	24.56	{"Boys In The Band","Terf Wars","Mr Lovebomb","Lads Lads Lads","Help Me I'm Gay","White Van"}	6	00:16:28	https://lambrinigirlsband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
847	sealedrecords	Rudimentary Peni	https://sealedrecords2.bandcamp.com/album/rudimentary-peni?from=discover_page	London, UK	2022-04-28	https://f4.bcbits.com/img/a4061786682_16.jpg	9.36	{"Media Person","Him Hymn","Blind Dogs","Rudimentary Peni - B-Ward","Crazy Chain","The Gardener","Teenage Time Killer",Hearse,"Dead Living","Black President","Tower Of Strength","Rudimentary Peni - Play"}	12	00:11:58	https://sealedrecords2.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
848	Public Figures	Figure It Out! EP	https://publicfigures4eva.bandcamp.com/album/figure-it-out-ep?from=discover_page	Melbourne, Australia	2026-02-18	https://f4.bcbits.com/img/a1939402194_16.jpg	35.00	{"Cut It Out",Honeycomb,"Landed In A Trap","Onto Something","Repeat It","How I'm Feeling"}	6	00:13:13	https://publicfigures4eva.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
849	Sleepytime Trio	Memory Minus Plus Minus	https://sleepytimetrio.bandcamp.com/album/memory-minus-plus-minus?from=discover_page	Richmond, Virginia	2025-10-24	https://f4.bcbits.com/img/a3778663161_16.jpg	22.95	{"Butter Scaryflies","Jesus Extract","Like My Plain","Flake City","Rock Candy","You're Dead; Lava","All Ease","Lancing Organic","I'm Not A Spy","Dear Hands",Onomatopoeia,"Speak Again Twice","30 Equals","Not Without My (Swimmies)"}	14	00:36:59	https://sleepytimetrio.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
850	Amyl and the Sniffers	Comfort To Me	https://amylandthesniffers.bandcamp.com/album/comfort-to-me?from=discover_page	Melbourne, Australia	2021-09-10	https://f4.bcbits.com/img/a3383741548_16.jpg	20.40	{"Guided by Angels","Freaks to the Front",Choices,Security,Hertz,"No More Tears",Maggot,Capital,"Don't Fence Me In",Knifey,"Don't Need A Cunt (Like You To Love Me)",Laughing,Snakes}	13	00:34:58	https://amylandthesniffers.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
851	R.M.F.C.	Club Hits	https://rockmusicfanclub.bandcamp.com/album/club-hits?from=discover_page	Sydney, Australia	2023-11-03	https://f4.bcbits.com/img/a2827906655_16.jpg	32.00	{Introduction,Spectrum,"Sterile Century","The Trap",Access,"Vanishing Aisle","Two Stars",Frogs,"Harmless Activity","The Web","New Diversion","Human State","Rock Tune"}	13	00:29:57	https://rockmusicfanclub.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
852	Chalk	Conditions III	https://chalkbelfast.bandcamp.com/album/conditions-iii?from=discover_page	Belfast, UK	2025-02-21	https://f4.bcbits.com/img/a1016455640_16.jpg	26.91	{"Leipzig 87",Afraid,"Tell Me","Pool Scene"}	4	00:14:27	https://chalkbelfast.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
853	Wall of Voodoo	Museums	https://wallofvoodoo.bandcamp.com/album/museums?from=discover_page	Los Angeles, California	2026-02-13	https://f4.bcbits.com/img/a3333597208_16.jpg	25.48	{Museums,"Deep In The Jungle","BOC (She Sleeps With Her Hat On)",Commercials,"I Believe","Big City","In My Night","Iron Horse","Deep In The Jungle II","Museums II"}	10	00:38:53	https://wallofvoodoo.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
854	DITZ	Never Exhale	https://ditzband.bandcamp.com/album/never-exhale?from=discover_page	Brighton, UK	2025-01-24	https://f4.bcbits.com/img/a3429837592_16.jpg	32.76	{V70,"Taxi Man",Space/Smile,"Senor Siniestro",Four,"God on a Speed Dial","Smells Like Something Died in Here","18 Wheeler","The Body As A Structure",Britney}	10	00:38:20	https://ditzband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
855	Wristwatch	III	https://wristwatch420.bandcamp.com/album/iii?from=discover_page		2026-01-01	https://f4.bcbits.com/img/a3959888944_16.jpg	21.24	{Screwed,Spells,Size,Rules,Floor,"Sweet Tooth",Hints,Dü,Goat,Fix}	10	00:30:30	https://wristwatch420.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
856	Minor Threat	Out Of Step	https://minorthreat.bandcamp.com/album/out-of-step?from=discover_page	Washington, D.C.	1983-06-01	https://f4.bcbits.com/img/a0296118990_16.jpg	15.30	{Betray,"It Follows","Think Again","Look Back And Laugh","Sob Story","No Reason","Little Friend","Out Of Step","Cashing In"}	9	00:21:40	https://minorthreat.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
857	Sunny War	Anarchist Gospel	https://sunnywar.bandcamp.com/album/anarchist-gospel?from=discover_page	Los Angeles, California	2023-02-03	https://f4.bcbits.com/img/a2277788656_16.jpg	18.70	{"Love's Death Bed","No Reason","Shelter And Storm","I Got No Fight","Swear To Gawd",Earth,"New Day","Baby Bitch","His Love",Hopeless,Higher,"Test Dummy","Sweet Nothing",Whole}	14	00:49:35	https://sunnywar.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
858	GHOSTWOMAN®	Ghost Woman	https://ghostwoman.bandcamp.com/album/ghost-woman-2?from=discover_page		2022-07-01	https://f4.bcbits.com/img/a1892526333_16.jpg	26.90	{"All The Time","Do You","Dead & Gone",Along,Clockwork,"Behind Your Eyes","All Your Love",Jreaming,Good,"Comes On"}	10	00:33:33	https://ghostwoman.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
859	Bob Vylan	Bob Vylan Presents The Price Of Life	https://bobvylan.bandcamp.com/album/bob-vylan-presents-the-price-of-life?from=discover_page	London, UK	2022-04-22	https://f4.bcbits.com/img/a3556620614_16.jpg	23.40	{"Walter Speaks","Wicked & Bad","Big Man","Take That","Health Is Wealth","He Sold Guns","Must Be More","Pretty Songs","Turn Off The Radio (Radio Single)",GDP,"Bait The Bear","Phone Tap (Alexa)","Drug War",Whatchugonnado?}	14	00:34:16	https://bobvylan.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
860	dust	Sky is Falling	https://dustdustdust.bandcamp.com/album/sky-is-falling?from=discover_page	Newcastle, Australia	2025-10-10	https://f4.bcbits.com/img/a0738560706_16.jpg	23.78	{Drawbacks,"Just Like Ice",Alastair,"Two Dogs",Swamped,Restless,Aside,Fairy,"Day Tight","In Reverie"}	10	00:42:17	https://dustdustdust.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
861	Bristol Archive Records	The Famous Five Session	https://bristolarchiverecords.bandcamp.com/album/the-famous-five-session?from=discover_page	UK	2026-01-30	https://f4.bcbits.com/img/a1588473888_16.jpg	26.90	{Stay,"Times The Only Thing",She,"Too Fast","Absent Friends","Karaoke Ballad",Devotion,"Passive Aggressive","Money Shot"}	9	00:29:11	https://bristolarchiverecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
945	Pinback	Information Retrieved	https://pinback.bandcamp.com/album/information-retrieved?from=discover_page	San Diego, California	2012-10-16	https://f4.bcbits.com/img/a2677695837_16.jpg	22.95	{"Proceed to Memory",Glide,Drawstring,Sherman,"His Phase",Diminished,"True North","A Request","Denslow, You Idiot!",Sediment,"Thee Srum Progitt (Bonus Track)","CLOAD \\"Q\\" (Bonus Track)"}	12	00:46:49	https://pinback.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
862	My Life With The Thrill Kill Kult	I See Good Spirits And I See Bad Spirits	https://mylifewiththethrillkillkult.bandcamp.com/album/i-see-good-spirits-and-i-see-bad-spirits?from=discover_page	Chicago, Illinois	2024-06-21	https://f4.bcbits.com/img/a0896986106_16.jpg	27.20	{Heresy,X-Communication,"Do You Fear (For Your Child)","Easy Girl","Universal Blackness","...And This Is What The Devil Does!","These Remains","On This Rack","Gateway To Hell","Scene One, Seen 'Em All!!","First Cut - Early Version 1987","Do You Fear - Early Version 1987","Universal Blackness - Early Version 1987","These Remains - Early Version 1988","Nervous Xians - Early Version 1988","Burning Dirt - Early Version 1988","On This Rack - Early Version 1987","Gateway To Hell - Early Version 1987"}	18	01:30:27	https://mylifewiththethrillkillkult.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
863	Say She She	Prism	https://saysheshe.bandcamp.com/album/prism?from=discover_page	Brooklyn, New York	2022-10-07	https://f4.bcbits.com/img/a1765552813_16.jpg	19.55	{Prism,"Don't Wait","Pink Roses","Same Things","Fortune Teller","Apple Of My Eye",Believe,"Better Man"}	8	00:29:01	https://saysheshe.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
864	Grafjammer	De Tyfus, De Teerling	https://grafjammer.bandcamp.com/album/de-tyfus-de-teerling?from=discover_page	Utrecht, Netherlands	2025-01-10	https://f4.bcbits.com/img/a0416977657_16.jpg	20.00	{"1. De Dijk is Dicht (Intro)","2. Hachel Mijn Bout","3. Lijdensverlenger","4. Bloedbruid","5. Krengenslagers","6. Bertken","7. Rampokker",Schoftensermoen,"9. Varkensbocht","10. Waanzee"}	10	00:34:36	https://grafjammer.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
865	Mangel	War Crimes & Love Songs	https://mangelrecords.bandcamp.com/album/war-crimes-love-songs?from=discover_page	Berlin, Germany	2025-12-11	https://f4.bcbits.com/img/a3497339084_16.jpg	16.00	{"Für ihre Zukunft","no men (end of a rope)",Kriegslust,"Epilepsy Dance","no place to play",Trümmerballade}	6	00:18:23	https://mangelrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
866	SAINT SAUVEUR RECORDS	NZ BOOTBOYS	https://saint-sauveur.bandcamp.com/album/nz-bootboys?from=discover_page	France	2025-09-01	https://f4.bcbits.com/img/a1891431231_16.jpg	20.00	{"Friday night","Debts to pay","Have a good week-end","All night drinking","Shit factory","Straight down the pub","You won't change me","Rock'n roll outlaws"}	8	00:21:46	https://saint-sauveur.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
867	Lifeguard	Ministry / Energie	https://lifeguardband100.bandcamp.com/album/ministry-energie?from=discover_page	Chicago, Illinois	2024-07-10	https://f4.bcbits.com/img/a1981244511_16.jpg	8.65	{"Ministry / Energie","Telepathic Love"}	2	00:04:44	https://lifeguardband100.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
868	Kiss The Anus Of A Black Cat	An Interlude To The Outermost	https://kisstheanusofablackcat.bandcamp.com/album/an-interlude-to-the-outermost?from=discover_page	Gent, Belgium	2007-01-01	https://f4.bcbits.com/img/a0070245530_16.jpg	20.00	{"Prelude (The World Is In Fear Again And It Has All Been Manufactured)","The Firesky","A Scatterbrain Sings Of Christains And The Ghoul Bear Teeth","The Cranes Are Scared Of Sunwords",Salt,"You Will Reap A Whirlwind","Beyond The Tanarian Hills","Cornflowers For Our Brothers","All Movements Are Targets In The Minds Of Tigers"}	9	00:51:17	https://kisstheanusofablackcat.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
869	Lifeguard	Ripped and Torn	https://lifeguardband100.bandcamp.com/album/ripped-and-torn?from=discover_page	Chicago, Illinois	2025-06-06	https://f4.bcbits.com/img/a2911842719_16.jpg	19.49	{"A Tightwire","It Will Get Worse","Me and My Flashes","Under Your Reach","How to Say Deisar","(I Wanna) Break Out","Like You'll Lose","Music for 3 Drums","France And","Charlie's Vox","Ripped + Torn",T.L.A.}	12	00:30:48	https://lifeguardband100.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
870	IDLES	TANGK	https://idlesband.bandcamp.com/album/tangk?from=discover_page	Bristol, UK	2024-02-16	https://f4.bcbits.com/img/a0164604132_16.jpg	21.25	{"IDEA 01","Gift Horse","POP POP POP",Roy,"A Gospel",Dancer,Grace,"Hall & Oates",Jungle,Gratitude,Monolith}	11	00:40:11	https://idlesband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
871	AJJ	Good Luck Everybody	https://ajjtheband.bandcamp.com/album/good-luck-everybody?from=discover_page	Phoenix, Arizona	2020-01-17	https://f4.bcbits.com/img/a0029012792_16.jpg	17.55	{"A Poem","Normalization Blues","Body Terror Song",Feedbag,"No Justice, No Peace, No Hope","Mega Guillotine 2020",Loudmouth,Maggie,"Psychic Warfare","Your Voice, as I Remember it","A Big Day for Grimley"}	11	00:27:22	https://ajjtheband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
872	toe	New Sentimentality	https://toe-music.bandcamp.com/album/new-sentimentality?from=discover_page	Japan	2013-11-12	https://f4.bcbits.com/img/a0623812379_16.jpg	22.10	{繋がる遥か彼方,1/21,"New Sentimentality",グッドバイ}	4	00:20:40	https://toe-music.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
873	The Devil Makes Three	Spirits	https://thedevilmakesthree.bandcamp.com/album/spirits?from=discover_page	Burlington, Vermont	2025-02-28	https://f4.bcbits.com/img/a3586758173_16.jpg	21.25	{"Lights on Me",Spirits,"Ghosts are Weak","Half as High","Hard Times","The Devil Wins","The Dark Gets the Best of You","Fallen Champions","The Gift","Divide and Conquer","I Love Doing Drugs","Poison Well","Holding On"}	13	00:45:38	https://thedevilmakesthree.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
874	LA VIDA ES UN MUS DISCOS	Choque Asimétrico	https://lavidaesunmus.bandcamp.com/album/choque-asim-trico?from=discover_page	London, UK	2025-12-05	https://f4.bcbits.com/img/a0602195325_16.jpg	21.06	{"Absoluta Falsedad","Choque Asímetrico","Morirán Jovenes",Huir,"Fuerza Trabajadora",Horizonte,Colapso,Posthumanista,Progreso,"Prisión (Sur) Global"}	10	00:21:11	https://lavidaesunmus.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
875	The Spiky Tops	Spiky Tops - PoGo Drunx	https://thespikytops.bandcamp.com/album/spiky-tops-pogo-drunx?from=discover_page	Easton, Pennsylvania	2026-02-14	https://f4.bcbits.com/img/a0128172224_16.jpg	17.00	{"PoGo Drunx",Infected,"In Too Deep",Rotten,"No Work","Operation PoGo"}	6	00:12:45	https://thespikytops.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
876	Danny Ayala	Only Fools Love Again	https://danny-ayala.bandcamp.com/album/only-fools-love-again?from=discover_page	Hicksville, New York	2025-09-26	https://f4.bcbits.com/img/a0452601747_16.jpg	21.25	{"I Was Wrong","Something With You","I Don't Like Her","Life's Always Worth It","The Ballad","The Village",Pluto,"Don't Hold Me","I Wanna Come Back To You","Smile For Me"}	10	00:27:50	https://danny-ayala.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
877	Crass	The Feeding Of The 5000	https://crass.bandcamp.com/album/the-feeding-of-the-5000?from=discover_page	Epping, UK	2020-02-20	https://f4.bcbits.com/img/a0363717202_16.jpg	28.07	{Asylum,"Do They Owe Us A Living?","End Result","They've Got A Bomb","Punk Is Dead","Reject Of Society","General Bacardi","Banned From The Roxy","G's Song","Fight War Not Wars",Women,Securicor,Sucks,"You Pay",Angels,"What A Shame","So What","Well? ... Do They?"}	18	00:31:56	https://crass.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
878	The New Eves	The New Eve Is Rising	https://theneweves.bandcamp.com/album/the-new-eve-is-rising?from=discover_page	Brighton And Hove, UK	2025-08-01	https://f4.bcbits.com/img/a1482990519_16.jpg	29.24	{"The New Eve","Highway Man","Cow Song","Mid-Air Glass",Astrolabe,Circles,Mary,"Rivers Run Red",Volcano}	9	00:39:48	https://theneweves.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
879	Zu	Jazzisdead Live	https://zuband.bandcamp.com/album/jazzisdead-live?from=discover_page	Rome, Italy	2025-04-18	https://f4.bcbits.com/img/a3703079166_16.jpg	18.00	{Gravestone,Speedball,Asmodeo,"La Grande Madre Delle Bestie",Vexoprakta,"Burning Stone",Hyderomastgroningen,Sanctuary,"Memories Of Zworrisdeh","Muro Torto","Mar Glaciale Artico","Solar Anus"}	12	00:41:47	https://zuband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
880	Whiskey Dick Mountain	BYOB	https://whiskeydickmountain.bandcamp.com/album/byob?from=discover_page	Spokane, Washington	2011-01-01	https://f4.bcbits.com/img/a1948001696_16.jpg	13.60	{"Almost Gone","Family Tree","Bang Bang","Had Money","No Patience","Be Wrong","Whiskey Over Water","Baby Jesus Eyes","Squeezin' Honey from a Bee","Angel Feather","Quit Drinkin'","Sin & Save"}	12	00:38:15	https://whiskeydickmountain.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
881	No Idea Records	The Great Depression	https://noidearecords.bandcamp.com/album/the-great-depression-2?from=discover_page	Gainesville, Florida	2006-04-13	https://f4.bcbits.com/img/a3894402868_16.jpg	25.50	{"Petty Problems",Enough,"Oh, Susquehanna!","The New World Order","Calling Old Friends","Trip and Stumble","This Feels Better","This Year","Grandma Song","Letter Home","The Temperature is Dropping","Lambs at the Slaughter","Condition 11:11"}	13	00:29:50	https://noidearecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
882	Hella	Hold Your Horse Is (Deluxe Reissue)	https://hella.bandcamp.com/album/hold-your-horse-is-deluxe-reissue?from=discover_page	Sacramento, California	2023-09-01	https://f4.bcbits.com/img/a3623601716_16.jpg	22.10	{"The D.Elkan","Biblical Violence","Been A Long Time Cousin","Republic of Rough and Ready",1-800-Ghost-Dance,"Brown Metal","Cafeteria Bananas","City Folk Sitting, Sitting","Better Get a Broom!","The Republic of Rough and Ready (Demo)","Biblical Violence (Demo)","City Folk Sitting Sitting (Demo)"}	12	00:47:10	https://hella.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
883	Yard Act	Dark Days EP	https://yardact.bandcamp.com/album/dark-days-ep?from=discover_page	Leeds, UK	2021-02-03	https://f4.bcbits.com/img/a3863640365_16.jpg	17.55	{"Dark Days",Peanuts,"Fixer Upper","The Trapper's Pelts"}	4	00:13:15	https://yardact.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
884	The Front Bottoms	Talon of the Hawk	https://thefrontbottoms.bandcamp.com/album/talon-of-the-hawk?from=discover_page	New Jersey	2013-05-21	https://f4.bcbits.com/img/a2248276769_16.jpg	18.70	{"Au Revoir (Adios)",SKELETON,"Swear To God The Devil Made Me Do It","TWIN SIZE MATTRESS",Peach,"Santa Monica","The Feud","Funny You Should Ask","Tattooed Tears","Lone Star","Back Flip","Everything I Own"}	12	00:42:31	https://thefrontbottoms.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
885	Say She She	Silver	https://saysheshe.bandcamp.com/album/silver?from=discover_page	Brooklyn, New York	2023-09-29	https://f4.bcbits.com/img/a0984351724_16.jpg	28.05	{Reeling,"Don't You Dare Stop","Astral Plane","C'est Si Bon","Entry Level","Passing Time","Think About It",Questions,"Forget Me Not","Never Say Never","The Water","Echo In The Chamber","Bleeding Heart","Find A Way",NORMA,Silver}	16	01:06:00	https://saysheshe.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
886	Lip Cream	Kill Ugly Pop	https://lipcream.bandcamp.com/album/kill-ugly-pop?from=discover_page	Tokyo, Japan	1986-01-01	https://f4.bcbits.com/img/a3331203198_16.jpg	22.95	{Shangri-La,"Fight In The Street (Teenage Warning)","Stop The City","Give Us The Truth","The Pusher",夕焼け,"Kill Ugly Pop","No Rules","For My Life","Fareless Drunker","Kill The Hincty","Back In The Anger","赤羽線バイオレンス (Violence In Red Wing Line No.2)",Suicidal}	14	00:30:43	https://lipcream.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
887	High Vis	Guided Tour	https://highvis.bandcamp.com/album/guided-tour?from=discover_page	London, UK	2024-10-18	https://f4.bcbits.com/img/a0269072802_16.jpg	22.94	{"Guided Tour","Drop Me Out","Worth the Wait","Feeling Bless","Fill the Gap",Farringdon,"Mob DLA",Untethered,"Deserve It","Mind's a Lie","Gone Forever"}	11	00:37:39	https://highvis.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
888	Lip Cream	9 Shocks Terror	https://lipcream.bandcamp.com/album/9-shocks-terror?from=discover_page	Tokyo, Japan	1987-01-01	https://f4.bcbits.com/img/a3612123271_16.jpg	22.95	{Terror,Breakin,"Cold Lover","Kick Out The Jam","Amateur Baby (素人娘)","Enough Time","9th Nightmare","Shock Treatment","R.I.P. Off"}	9	00:13:48	https://lipcream.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
889	Kernkrach	Horreur Cosmique	https://kernkrach.bandcamp.com/album/horreur-cosmique?from=discover_page	Münster, Germany	2025-10-05	https://f4.bcbits.com/img/a4048224678_16.jpg	24.95	{"Un Labyrinthe Sans Fin","Le Philosophe S´Est Éteint","La Légende De Tittenhurst Park","Horreur Cosmique","Ballet De L´Oubli","Tous Piégés Dans Ce Crépuscule","L´Obscurité M´Enlace","Le Sommeil Comme Un Sillage","Sombras, Sombras","Noyés Dans L´Acier, Nos Corps Sans Désir","Raconter De Salades",Distances}	12	00:48:13	https://kernkrach.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
890	Rogue Records	Feelings	https://roguerecords.bandcamp.com/album/feelings?from=discover_page	Toulouse, France	2026-01-19	https://f4.bcbits.com/img/a2430065604_16.jpg	10.00	{Feelings,"Foolish Lies"}	2	00:05:40	https://roguerecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
891	Lathe of Heaven	Aurora	https://latheofheaven.bandcamp.com/album/aurora?from=discover_page	Brooklyn, New York	2025-08-29	https://f4.bcbits.com/img/a0929268626_16.jpg	21.25	{Exodus,Aurora,"Portrait of a Scorched-Earth","Just Beyond the Reach of Light",Oblivion,Kaleidoscope,"Matrix of Control",Catatonia,"Infinity's Kiss","Automation Bias",Rorschach}	11	00:41:44	https://latheofheaven.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
892	Alien Nosejob	Forced Communal Existence	https://aliennosejob.bandcamp.com/album/forced-communal-existence?from=discover_page	VIC, Australia	2025-06-06	https://f4.bcbits.com/img/a0932448250_16.jpg	34.00	{"Family Dinner","Clear the Clutter",Tired,"Guilt and Blame","Caffeine OD",Flyblown,"Sydney Sizzles","Over the Bridge","Government Flu","I Still Call This Punk Scene My Home","Bond Clean","Explosives in the Headlights","Chemical Solution",Cabanossi,"The Scene Expands","Opinionated Fuck","Nothing Ever Goes Your Way","Fatal Collision","Circular Motion","Beyond the Pale","The Executioner","West Side Story","S-O-S '75"}	23	00:47:09	https://aliennosejob.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
893	Motorists	Never Sing Alone	https://motoristswearetime.bandcamp.com/album/never-sing-alone?from=discover_page	Toronto, Ontario	2026-03-06	https://f4.bcbits.com/img/a2421909542_16.jpg	50.00	{Cristobal,"Scattered White Horses","The Damage",Frogman,Stander,Diogenes,Anomaniacs,"Man in the Circular Window","Next Blue Kings",PCSD,Reprise}	11	00:33:40	https://motoristswearetime.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
894	Silicone Prairie	Vol. II	https://siliconeprairie.bandcamp.com/album/vol-ii?from=discover_page	Kansas City, Missouri	2023-07-28	https://f4.bcbits.com/img/a0618369190_16.jpg	17.00	{"Serpent in the Grass","Victorian Flame",Willkommen,Cows,"Mirror on the Wall","Neon Moon","Elysian Fields","Freed's Wet Tape","Painting Trains","The Minotaur"}	10	00:29:15	https://siliconeprairie.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
895	Mini Skirt	All That We Know	https://miniskirt666.bandcamp.com/album/all-that-we-know?from=discover_page	Byron Bay, Australia	2025-11-14	https://f4.bcbits.com/img/a0243887075_16.jpg	25.73	{"Pottsville River",Roundabouts,"Smart Enough","Chew The Cud","Been A While","White Range Club",Mud,"Squeeze Down","Stay Soft","Ned Kelly Letter Box","Series 3"}	11	00:33:13	https://miniskirt666.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
896	Mekons	Fear and Whiskey	https://mekons.bandcamp.com/album/fear-and-whiskey?from=discover_page	Chicago, Illinois	2019-09-20	https://f4.bcbits.com/img/a2612059464_16.jpg	16.13	{Chivalry,"Trouble Down South","Hard to Be Human Again","Darkness and Doubt","Psycho Cupid - Danceband On the Edge of Time",Flitcraft,Country,"Abernant 1984/5","Last Dance","Lost Highway"}	10	00:35:17	https://mekons.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
897	MOROS	Weapon	https://moros-666.bandcamp.com/album/weapon?from=discover_page	Philadelphia, Pennsylvania	2019-03-29	https://f4.bcbits.com/img/a3457646554_16.jpg	12.75	{(vortexwound),"We Don't Deserve Death","Devil Worshipper","Wizard Of Lonliness","Death Nebula","Everyday Is Worse Than The Last",Weapon}	7	00:31:38	https://moros-666.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
898	KISSLAND	GIRLS MIGNON	https://kissland.bandcamp.com/album/girls-mignon?from=discover_page	Melbourne, Australia	2025-06-25	https://f4.bcbits.com/img/a0279694286_16.jpg	15.00	{"Welcome To Kissland","Joan Coco Blue","Girls Mignon","I don't care you broke your elbow","Random One",Nannas,"My Pwincess","A letter for the culture","Next Life","If The Dare came to Kissland practice","Kissland Theme"}	11	00:08:15	https://kissland.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
899	VOX PROJECT	Ouais	https://music.voxproject.fr/album/ouais?from=discover_page	Saint Etienne, France	2020-02-22	https://f4.bcbits.com/img/a1298927385_16.jpg	10.00	{Terfuge,Stance,Jugué,Til,Zidiaire}	5	00:29:18	https://music.voxproject.fr?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
900	Hot Mulligan	The Sound a Body Makes When It''s Still	https://hotmulligan.bandcamp.com/album/the-sound-a-body-makes-when-its-still?from=discover_page	Lansing, Michigan	2025-08-22	https://f4.bcbits.com/img/a2194209199_16.jpg	23.80	{"Moving to Bed Bug Island","And a Big Load","It Smells Like Fudge Axe In here","Island in the Sun (feat. Cory Castro of Free Throw)","Bon Jonah","This Makes Me Yummy","Monica Lewinskibidi","Milam Minute","Cream of Wheat of Feet Naw Cream of (Feat)","Mix Master Wade On The Beat","Carbon Monoxide Hotel","This Makes Me Yucky","Let Me See Your Mounts","Monster Burger and a $5 Beer","Slumdog Scungillionaire","My Dad Told Me To Write A Nice One For Nana So Here It Is"}	16	00:42:53	https://hotmulligan.bandcamp.com?from=discover_page	2026-02-23 13:22:19.728943	2026-02-23 13:22:19.728943
901	Xiu Xiu	The Air Force	https://xiuxiu.bandcamp.com/album/the-air-force?from=discover_page	Los Angeles, California	2006-09-12	https://f4.bcbits.com/img/a2841870725_16.jpg	17.00	{"Buzz Saw","Boy Soprano","Hello From Eau Claire","Vulture Piano","PJ In The Streets","Bishop, CA","Saint Pedro Glue Stick","The Pineapple vs. The Watermelon","Save Me Save Me","The Fox And The Rabbit","Wig Master"}	11	00:34:42	https://xiuxiu.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
902	Alexis Taylor	Paris In The Spring	https://alexistaylor.bandcamp.com/album/paris-in-the-spring?from=discover_page	London, UK	2026-03-13	https://f4.bcbits.com/img/a1011711431_16.jpg	29.25	{"Your Only Life","I Can Feel Your Love","Out Of Phase (feat. Lola Kirke)","Wild Horses",Colombia,"For A Toy","On A Whim (feat. Green Gartside)","Fainting By Numbers","mp3s Can Make You Cry","Black Lodge In The Sky"}	10	00:48:47	https://alexistaylor.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
903	Pia Fraus	Nature Heart Software	https://piafraus.bandcamp.com/album/nature-heart-software?from=discover_page	Tallinn, Estonia	2006-02-24	https://f4.bcbits.com/img/a4064463231_16.jpg	27.00	{"Birds Still Swing","Pretend To Be Here","Chromatic Nights","Day Week or Season","You Know There Are People Living in the Country","Teenage Girl","Super Timeknowing Gentleman","Thank You Peter Parker","Come to Me","Feeling is New","No Borders","Japanese Heart Software"}	12	00:40:59	https://piafraus.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
904	VERO	Razor Tongue [LP]	https://veroband.bandcamp.com/album/razor-tongue-lp?from=discover_page	Stockholm, Sweden	2026-03-20	https://f4.bcbits.com/img/a2966003374_16.jpg	20.99	{"Dead Train",Kick,Calico,Habit,"The Hand","Taste the Ten","Dumb It",Requiem,"Silver Lakes","100 Calls"}	10	00:36:42	https://veroband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
931	David Sylvian	Sleepwalkers	https://davidsylvian.bandcamp.com/album/sleepwalkers?from=discover_page		2023-05-12	https://f4.bcbits.com/img/a0278763474_16.jpg	30.00	{Sleepwalkers,"Money for all","Do you know me now?",Angels,"World citizen - I won´t be disappointed","Five lines","The day the earth stole heaven","Modern interiors","Exit - Delete","Pure genius","Wonderful world",Transit,"World citizen","The world is everything",Thermal,Sugarfuel,Trauma}	17	01:12:53	https://davidsylvian.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
905	WIZZZ	French psychorama - 1967/1979 - Volume 5	https://wizzzcompilation.bandcamp.com/album/french-psychorama-1967-1979-volume-5?from=discover_page	Paris, France	2026-01-09	https://f4.bcbits.com/img/a0639529028_16.jpg	100.00	{"Robert Pico - le chien fidèle","Annie Girardot - La femme faux cils (Ost Erotissimo)","Spauv Georges - Je suis l'état","Zoé - Zoé","Jacques Da Sylva - Fou","Valentin - Je suis un vagabond","Jacques Malia - Histoire de gitan","Bernard Jamet - Raison légale","Jean-Pierre Lebrot - Barbara au chapeau rose","Les concentrés - Fils de dégénérés","Les Missiles - Publicité","Hegessipe - Le credo","Maréchalement votre - Ethero-disco","Mamlouk - Décollez les","Mozaique - L'amour nu","Jean-Marc Garrigues - Je dis non","Penuel - Astronef 328"}	17	00:46:17	https://wizzzcompilation.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
906	The Cords	The Cords	https://thecordsband.bandcamp.com/album/the-cords-2?from=discover_page	Greenock, UK	2025-09-26	https://f4.bcbits.com/img/a3564814333_16.jpg	24.57	{Fabulist,"Just Don't Know (How To Be You)",October,Vera,"Doubt It's Gonna Change",You,"Bo's New Haircut","I'm Not Sad","Yes It's True","Weird Feeling","Done With You","Rather Not Stay","When You Said Goodbye"}	13	00:30:35	https://thecordsband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
907	Nourished By Time	The Passionate Ones	https://nourishedbytime.bandcamp.com/album/the-passionate-ones?from=discover_page	Baltimore, Maryland	2025-08-22	https://f4.bcbits.com/img/a3577438092_16.jpg	18.77	{"Automatic Love","Idiot In The Park","Max Potential","It's Time","Cult Interlude","9 2 5","Crazy People","Nourished by Time feat. Tony Bontana - Jojo","BABY BABY","Tossed Away","When The War Is Over","The Passionate Ones"}	12	00:45:21	https://nourishedbytime.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
908	Fort Not	You On Repeat	https://fortnot.bandcamp.com/album/you-on-repeat?from=discover_page	Kungälv, Sweden	2026-02-27	https://f4.bcbits.com/img/a0481053612_16.jpg	18.00	{Ragdoll,"Still Do Drugs","Beverly Hills Kills","Careless Love",Dream,"My Mind Is Off",Gymnast,Stationary,"Waiting For The Sun","Heaven To Me","My Favorite Rum",Stop}	12	00:34:16	https://fortnot.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
909	Lavinia Blackwall	The Making	https://laviniablackwall.bandcamp.com/album/the-making?from=discover_page	Glasgow, UK	2025-05-30	https://f4.bcbits.com/img/a2760808977_16.jpg	23.40	{"Keep Me Away From The Dark","The Damage We Have Done","Scarlett Fever","My Hopes Are All Mine","Morning To Remember","The Making","We All Get Lost","The Art Of Leaving","The Will To Be Wild","Sisters In Line"}	10	00:38:05	https://laviniablackwall.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
910	Phil Keaggy - Deluxe Studio vocal albums	Love Broke Thru (50th Anniversary Deluxe Edition)	https://pk-deluxestudiovocalalbums.bandcamp.com/album/love-broke-thru-50th-anniversary-deluxe-edition?from=discover_page	Nashville, Tennessee	2026-01-05	https://f4.bcbits.com/img/a1036104963_16.jpg	63.75	{"Your Love Broke Through","Take Me Closer","As The Ruin Falls","Wild Horse",Disappointment,Time,Portrait,"Just The Same","Things I Will Do",Abraham,"Isaiah 25 (Outtake)","Lookin' for Treasures (Outtake)","Wild Horse (1st Take)","As The Ruin Falls (Instr. Mix)","Send Out Your Light (Outtake)","Things I will Do (Piano Mix)","Take Me Closer (Take 1 Partial)","Wild Horse (Strings Mix)","Your Love Broke Through (Vocal Blend)","Just The Same (X-Ray Mix)","Abraham (Aco. Mix)","Take Me Closer (Alt. Mix)","As The Ruin Falls (Alt. Mix)","Time (1985 Version)","Wild Horse (Vox and Guitars)","Portrait (Alt. Mix)","Time (X-Ray Mix 2)","Disappointment (Aco. Mix)","Take Me Closer (X-Ray Mix)","Your Love Broke Through (Instr. Mix)","Send Out Your Light (Instr. Mix)","Short Jam (Outtake)","Wild Horse (Alt. Strings Mix)","Time (Alt. Mix)","Isaiah 25 (Inst. Mix)","Things I Will Do (X-Ray Mix)","Your Love Broke Through (Strings Mix)","Send Out Your Light (1st Take Instr. Mix)","Abraham (Instr. Mix w/BGVs)","Take Me Closer (Instr. Mix)","Long Jam (Outtake)","Time w/ Rex Paul (2019)","Take Me Closer (demo)","Lift Your Hands (demo)","Only Say Yes (demo)","Covenant Love (demo)","Just The Same (demo)","Wild Horse (demo)","Send Out Your Light","As The Ruin Falls (demo)","Psalm 139 (demo)","Disappointment (demo)","Isaiah 25 (demo)","Things I Will Do (demo)","Psalm 73 (demo)","Arise Shine (demo)","Portrait (demo)","With You (demo)"}	58	03:54:31	https://pk-deluxestudiovocalalbums.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
911	maya ongaku	Electronic Phantoms	https://mayaongakuggb.bandcamp.com/album/electronic-phantoms?from=discover_page	Fujisawa, Japan	2024-08-30	https://f4.bcbits.com/img/a1803191058_16.jpg	27.00	{"Iyo no Hito","Anoyo Drive","Love with Phantom","Meiso Ongaku 1","Meiso Ongaku 2","Meiso Ongaku 3"}	6	00:29:01	https://mayaongakuggb.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
912	Heavenlyindie	Highway To Heavenly	https://heavenlyindie.bandcamp.com/album/highway-to-heavenly?from=discover_page	UK	2026-02-27	https://f4.bcbits.com/img/a3850842468_16.jpg	24.57	{"Scene Stealing","Portland Town","Press Return","Skep Wax",Deflicted,"Excuse Me","A Different Beat","Good Times","The Neverseen","She Is The One","That Last Day"}	11	00:40:34	https://heavenlyindie.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
913	Kelly Lee Owens	Dreamstate	https://kellyleeowens.bandcamp.com/album/dreamstate?from=discover_page	London, UK	2024-10-18	https://f4.bcbits.com/img/a1682363168_16.jpg	28.08	{"Dark Angel",Dreamstate,"Love You Got",Higher,Rise,"Ballad (In The End)",Sunshine,Air,"Time To","Trust and Desire"}	10	00:44:02	https://kellyleeowens.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
914	Sylvan Esso	Sylvan Esso	https://sylvanesso.bandcamp.com/album/sylvan-esso?from=discover_page	Durham, North Carolina	2014-05-13	https://f4.bcbits.com/img/a0837854985_16.jpg	18.70	{"Hey Mami","Dreamy Bruises","Could I Be",Wolf,Dress,H.S.K.T.,Coffee,Uncatena,"Play It Right","Come Down"}	10	00:38:16	https://sylvanesso.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
915	Torus	Summer of Love (2024)	https://torus.bandcamp.com/album/summer-of-love-2024?from=discover_page	The Hague, Netherlands	2024-09-13	https://f4.bcbits.com/img/a0061633431_16.jpg	33.86	{"Offshore ’07","Slow Break","Lose Control","Anything Your Heart Desires","Summer Of Love ft. Malibu","We Share The Same Breath","Swirling Like A Rocket"}	8	00:28:55	https://torus.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
916	Friendship	Caveman Wakes Up	https://friendshipphl.bandcamp.com/album/caveman-wakes-up?from=discover_page	Philadelphia, Pennsylvania	2025-05-16	https://f4.bcbits.com/img/a4197344643_16.jpg	21.23	{"Salvage Title","Tree of Heaven","Betty Ford","Free Association","Hollow Skulls",Artex,"Love Vape","Wildwood in January","Resident Evil","All Over the World",Fantasia}	11	00:46:00	https://friendshipphl.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
917	Too Slow To Disco	THE SUNSET MANIFESTO Volume 2 - The Remixes	https://tooslowtodisco.bandcamp.com/album/the-sunset-manifesto-volume-2-the-remixes?from=discover_page	Berlin, Germany	2026-02-13	https://f4.bcbits.com/img/a2200586774_16.jpg	14.00	{"Joel Sarakula - Hands Of Love (Ben Jamin Remix)","Kimchii - Do You Ever (Monsieur van Pratt Deep Remix)","Joel Sarakula - Hands of Love (Monsieur van Pratt Dub Remix)","Kimchii - Do You Ever (Instrumental)","Goodvibes Sound - Stay One More Night (Matt Hughes' Late Night Radio Remix)","Goodvibes Sound - Stay One More Night (Matt Hughes' Late Night Radio Remix - Echo)","Turbotito - Time Starts Moving Slow (Instrumental)","1-900 - Breakin' 84 (Vibes4YourSoul Remix)"}	8	00:35:33	https://tooslowtodisco.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
918	waterbaby	Memory Be a Blade	https://waterbabyonline.bandcamp.com/album/memory-be-a-blade?from=discover_page	Stockholm, Sweden	2026-03-06	https://f4.bcbits.com/img/a1252797828_16.jpg	19.55	{Sink,"Memory Be a Blade",Clay,"Beck n Call",Minnie,"Minnie Too",Amiss,"Srs Ice"}	8	00:25:51	https://waterbabyonline.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
919	maya ongaku	Approach to Anima	https://mayaongakuggb.bandcamp.com/album/approach-to-anima?from=discover_page	Fujisawa, Japan	2023-05-26	https://f4.bcbits.com/img/a1532765582_16.jpg	27.00	{Approach,Nuska,"Description Of A Certain Sound",Melting,"Something In Morning Rain",Rakusui,"Water Dreams","Pillow Song"}	8	00:42:47	https://mayaongakuggb.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
920	Sylvan Esso	No Rules Sandy	https://sylvanesso.bandcamp.com/album/no-rules-sandy?from=discover_page	Durham, North Carolina	2022-08-12	https://f4.bcbits.com/img/a0051230364_16.jpg	21.23	{Moving,"Look At Me","(Bad Fills)","Echo Party","How Did You Know","(Betty’s, May 4, 2022)","Didn’t Care","(Vegas // Dad)","Your Reality",(#1vm),"Cloud Walker",Sunburn,(?),Alarm,"(No Rules Sandy)","Coming Back To You"}	16	00:34:39	https://sylvanesso.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
921	jellyskin	In Brine	https://jellyskin.bandcamp.com/album/in-brine?from=discover_page	Leeds, UK	2023-06-09	https://f4.bcbits.com/img/a2048770652_16.jpg	14.04	{"Lift (Come In)","Bringer Of Brine","Fox Again","Chicken, Milk and Oranges",Marmalade,"I Was The First Tetrapod","Pulpy Mouth and Skin","52 Blue",Punnet}	9	00:38:11	https://jellyskin.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
922	Eliana Glass	E	https://elianaglass.bandcamp.com/album/e?from=discover_page	New York, New York	2025-04-25	https://f4.bcbits.com/img/a2995672067_16.jpg	25.00	{"All My Life",Shrine,"Good Friends Call Me E",Flood,"Human Dust","Solid Stone",Dreams,"Sing Me Softly Of The Blues","On The Way Down","Song for Emahoy",Da,"Good Friends Call Me E (reprise)"}	12	00:48:29	https://elianaglass.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
923	Caravan Palace	<I°_°I>	https://caravanpalace.bandcamp.com/album/i-i-2?from=discover_page	Paris, France	2015-10-16	https://f4.bcbits.com/img/a0071716708_16.jpg	28.08	{"Lone Digger",Comics,"Mighty (feat JFTH)",Aftermath,Wonderland,Tattoos,Midnight,Russian,Wonda,"Human Leather Shoes for Crocodile Dandies","Lay Down"}	11	00:39:22	https://caravanpalace.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
924	Parcels	LOVED	https://parcelsmusic.bandcamp.com/album/loved-1?from=discover_page		2025-09-12	https://f4.bcbits.com/img/a1270752713_16.jpg	25.00	{Tobeloved,Ifyoucall,Safeandsound,Sorry,Yougotmefeeling,Leaves,Everybodyelse,Summerinlove,Leaveyourlove,Thinkaboutit,Finallyover,Iwanttobeyourlightagain}	12	00:45:53	https://parcelsmusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
925	СОЮЗ / SOYUZ	KROK	https://gruppasoyuz.bandcamp.com/album/krok?from=discover_page	Warsaw, Poland	2025-10-24	https://f4.bcbits.com/img/a2393948265_16.jpg	26.91	{"Крок / Krok","Lingua Do Mundo (feat. Tim Bernardes)","Ніці / Nici","Калі ты запытаеш / Kali ty zapytaješ","Ціхі карагод / Cichi karahod","P7 Blues","Voo Livre",VCB,"Смак жыцця / Smak žyćcia (feat. Manami Kakudo)"}	9	00:27:59	https://gruppasoyuz.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
926	Flunk	Lost Causes	https://flunk.bandcamp.com/album/lost-causes?from=discover_page	Oslo, Norway	2013-04-22	https://f4.bcbits.com/img/a2567963739_16.jpg	30.00	{"Queen Of The Underground",Sanctuary,"Love And Halogen",Awkward,"Lost Causes","Subway (J aime la pluie d été)",Primer,Bummed,"Bus Ride","As If You Didn't Already Know"}	10	00:46:26	https://flunk.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
927	Soundway Records	Ayo Ke Disco: Boogie, Pop & Funk from the South China Sea (1974-88)	https://soundwayrecords.bandcamp.com/album/ayo-ke-disco-boogie-pop-funk-from-the-south-china-sea-1974-88?from=discover_page	UK	2024-10-25	https://f4.bcbits.com/img/a2063263364_16.jpg	26.90	{"Fatimah Razak - Dahaga","Black Brothers - Mangge Mangge","Marini & The Steps - Kuingin Dekatmu","Tian Niu [ 恬妞 ] - Deng Ni Zai Yu Zhong [ 等你在雨中 ]","The Rollies - Disco","Regalado - Pinoy Funk","John Philips & The Steps - Ayo Ke Disco","Aria Yunior - Salah Tingkah","Ahmadi Hassan - Habibi (Mari Bersatu)","Pongsri Woranuch [ ผ่องศรี วรนุช ] - Aew...Phu Chai  [ เอ๊ว…ผู้ชาย ]"}	10	00:38:33	https://soundwayrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
928	Flunk	Take Me Places	https://flunk.bandcamp.com/album/take-me-places?from=discover_page	Oslo, Norway	2025-05-23	https://f4.bcbits.com/img/a3512589282_16.jpg	20.00	{Capitalism,Trapdoor,"Climbing Kilimanjaro","Sleeping On The Phone Side","I Think I Like You","Acid House","Slow Motion (Revolution Rock)","Sub Zero Sundays","Paradise Circus",Noise,Omens}	11	00:38:32	https://flunk.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
929	Seksound Record Label	Nature Heart Software	https://seksound.bandcamp.com/album/nature-heart-software?from=discover_page	Tallinn, Estonia	2006-02-24	https://f4.bcbits.com/img/a0236823120_16.jpg	27.00	{"Birds Still Swing","Pretend To Be Here","Chromatic Nights","Day Week Or Season","You Know There Are People Living In The Country","Teenage Girl","Super Timeknowing Gentleman","Thank You Peter Parker","Come To Me","Feeling Is New","No Borders","Japanese Heart Software"}	12	00:41:01	https://seksound.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
930	Cheb Nacer	Maroc Électronique Vol. 1	https://chebnacer.bandcamp.com/album/maroc-lectronique-vol-1?from=discover_page	Brussels, Belgium	2025-12-05	https://f4.bcbits.com/img/a2397830577_16.jpg	22.00	{"Olé... Olé... Olé...","Malou Malou","OK OK",Bombom}	4	00:21:35	https://chebnacer.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
932	Sylvan Esso	Sylvan Esso (10 Year Anniversary Edition)	https://sylvanesso.bandcamp.com/album/sylvan-esso-10-year-anniversary-edition?from=discover_page	Durham, North Carolina	2024-05-17	https://f4.bcbits.com/img/a2807029538_16.jpg	35.70	{"Hey Mami","Dreamy Bruises","Could I Be",Wolf,Dress,H.S.K.T.,Coffee,Uncatena,"Play It Right","Come Down","Hey Mami (Rick Wade Remix)","H.S.K.T. (Dntel Remix)","Coffee (Helado Negro Remix)","Hey Mami (Charles Spearin Remix)","H.S.K.T. (Hercules And Love Affair Remix)","Coffee (J Rocc Remix)","Jaime's Song","The Cosmos"}	18	01:17:41	https://sylvanesso.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
933	Cigarettes After Sex	Cigarettes After Sex	https://cigarettesaftersex.bandcamp.com/album/cigarettes-after-sex?from=discover_page	Los Angeles, California	2017-06-09	https://f4.bcbits.com/img/a2340015657_16.jpg	26.35	{K.,"Each Time You Fall In Love",Sunsetz,Apocalypse,Flash,Sweet,"Opera House",Truly,"John Wayne","Young & Dumb"}	10	00:47:00	https://cigarettesaftersex.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
934	EUPHORIA. AGAIN.	Destination Heaven	https://euphoriaagain.bandcamp.com/album/destination-heaven?from=discover_page	Philadelphia, Pennsylvania	2026-01-07	https://f4.bcbits.com/img/a2496742397_16.jpg	21.25	{Prelude,"Destination Heaven","It's Not Hard To Laugh",Candy,"Nah Nah Nah","At Least I'm Not Lonely Tonight",Circkets,"See Through","Slackers & Go Getters",Albuquerque}	10	00:45:25	https://euphoriaagain.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
935	LA FEMME	MYSTERE	https://lafemme.bandcamp.com/album/mystere?from=discover_page	Paris, France	2016-09-02	https://f4.bcbits.com/img/a3923485675_16.jpg	34.00	{Sphynx,"Le vide est ton nouveau prénom","Ou va le monde",Septembre,Tatiana,"Conversations nocturnes",S.S.D,Exorciseur,"Elle ne t'aime pas",Mycose,"Tueur de fleurs","Al Warda",Psyzook,"Le chemin",Vagues,"Always in the sun"}	16	01:11:38	https://lafemme.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
936	Marie Davidson	City Of Clowns (MDJ Tools)	https://mariedavidson.bandcamp.com/album/city-of-clowns-mdj-tools?from=discover_page	Montreal, Québec	2025-10-31	https://f4.bcbits.com/img/a2531724259_16.jpg	15.21	{"Push Me Fuckhead (Soulwax Dub Mix)","Sexy Clown (Soulwax Dub Mix)","Sexy Clown (MDJ Tool)"}	3	00:16:56	https://mariedavidson.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
937	Sword II	Electric Hour	https://swordii.bandcamp.com/album/electric-hour?from=discover_page	Atlanta, Georgia	2025-11-14	https://f4.bcbits.com/img/a0960856641_16.jpg	21.25	{Disconnection,Sentry,"Under the Scar",Sugarcane,"Gun You Hold","Passionate Nun",Halogen,"Violence of the Star","Who's Giving You Love","Even if it's Just a Dream"}	10	00:35:01	https://swordii.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
938	The Postal Service	Give Up (Deluxe 10th Anniversary Edition)	https://thepostalservice.bandcamp.com/album/give-up-deluxe-10th-anniversary-edition?from=discover_page	Seattle, Washington	2013-04-09	https://f4.bcbits.com/img/a1259394800_16.jpg	34.00	{"The District Sleeps Alone Tonight","Such Great Heights","Sleeping In","Nothing Better","Recycled Air","Clark Gable","We Will Become Silhouettes","This Place Is a Prison","Brand New Colony","Natural Anthem","Turn Around","A Tattered Line of String","Be Still My Heart","There's Never Enough Time","Suddenly Everything Has Changed","Against All Odds (Take a Look At Me Now)","Grow Old With Me","Such Great Heights (John Tejada Remix)","The District Sleeps Alone Tonight (DJ Downfall Persistent Beat Mix)","Be Still My Heart (Nobody Remix)","We Will Become Silhouettes (Matthew Dear Remix)","Nothing Better (Styrofoam Remix)","Recycled Air (Live on KEXP)","We Will Become Silhouettes (Performed by The Shins)","Such Great Heights (Performed by Iron & Wine)"}	25	01:44:24	https://thepostalservice.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
939	Molly Nilsson	Amateur	https://mollynilsson.bandcamp.com/album/amateur?from=discover_page	Berlin, Germany	2025-10-01	https://f4.bcbits.com/img/a2403920812_16.jpg	21.06	{"Die Cry Lie",Valhalla,"Swedish Nightmare",Classified,"Long Time No See","Fatal Distraction","Get A Life","Joe Hill's Last Will","How Much Is The World","Creeping Beauty","Big Life","All The Way","The Bitter End"}	13	00:43:20	https://mollynilsson.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
940	Marie Davidson	Chasing The Light / Work It (Soulwax Remix) x Lara (Daniel Avery Remix)	https://mariedavidson.bandcamp.com/album/chasing-the-light-work-it-soulwax-remix-x-lara-daniel-avery-remix-2?from=discover_page	Montreal, Québec	2019-08-07	https://f4.bcbits.com/img/a1221619779_16.jpg	10.16	{"Chasing The Light","Work It (Soulwax Remix)","Lara (Daniel Avery Remix)"}	3	00:16:30	https://mariedavidson.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
941	Helado Negro	This Is How You Smile	https://heladonegro.bandcamp.com/album/this-is-how-you-smile?from=discover_page	Brooklyn, New York	2019-03-08	https://f4.bcbits.com/img/a1839972112_16.jpg	20.40	{"Please Won't Please","Imagining What To Do","Echo for Camperdown Curio","Fantasma Vaga","Pais Nublado",Running,"Seen My Aura","Sabana de luz","November 7","Todo Lo Que Me Falta","Two Lucky","My Name Is For My Friends"}	12	00:40:51	https://heladonegro.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
942	Grace Ives	Janky Star	https://graceives.bandcamp.com/album/janky-star?from=discover_page	New York, New York	2022-06-10	https://f4.bcbits.com/img/a3369832763_16.jpg	21.25	{"Isn't It Lovely",Loose,"Burn Bridges","Angel Of Business","Lazy Day",Shelly,"Back In LA","On The Ground","Win Win",Lullaby}	10	00:27:04	https://graceives.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
943	congratulations	Join Hands	https://congratulations2u.bandcamp.com/album/join-hands?from=discover_page	Brighton, UK	2026-02-13	https://f4.bcbits.com/img/a1378212493_16.jpg	28.07	{Nevagonna,"Fought 4 Love","My Hair","This Life","Dr. Doctor","Jonny Hands","City Boy","I Feel Severe",Bubbles,"Hollywood Swingers"}	10	00:37:05	https://congratulations2u.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
944	Sacred Skin	Born in Fire	https://sacredskin.bandcamp.com/album/born-in-fire?from=discover_page	Los Angeles, California	2024-09-13	https://f4.bcbits.com/img/a4014345590_16.jpg	35.70	{Waiting,Runaway,"Show You Love","Call It Off","On The Ice","Too Hard To Find",Surrender,"Breaking The Waves","Born In Fire",Paranoid,"The Lights","Static Blue","Waiting (Single Mix)","Paranoid (Single Mix)","Waiting (Ronnie Stone Remix)","Call It Off (Dancing Plague Remix)"}	16	01:08:50	https://sacredskin.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
946	Kito Jempere	Sea Monster (Director''s Cut)	https://kitojempere.bandcamp.com/album/sea-monster-directors-cut?from=discover_page		2019-08-02	https://f4.bcbits.com/img/a2433239416_16.jpg	19.00	{"Uohha! (Original Mix)","Grid Cells","Ampa (Album Version)","Ampa (Black Spuma Energy Thieves Vocal Remix)","Lifetime Theme (Lipelis Kebab House Remix)","To Marvin","Ampa (Max Essa Remix)","Ampa (No Drums)","Ampa (Max Essa Dub Reprise)",Puzzled,"Lifetime Theme","To Talk","Puzzled (Jimi Tenor Remix)","Lifetime Theme (Bell Towers Remix)","Ampa (Black Spuma Energy Thieves Dub Instrumental)","Ampa (Miskotom Old Spice Remix)","Uohha! (Instrumental)"}	17	01:31:47	https://kitojempere.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
947	Boys Go To Jupiter	Meet Me After Practice	https://boysgotojupiter.bandcamp.com/album/meet-me-after-practice?from=discover_page	Brooklyn, New York	2025-02-28	https://f4.bcbits.com/img/a4007235008_16.jpg	25.50	{practice,Overconfident,"Wall St",Tiltawhirl,"Lovers Always Lose","Last Last Time",Astronauts,"wish u were here",Virginia,"Theme Song"}	10	00:36:31	https://boysgotojupiter.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
948	Hen Hoose Collective	The Twelve	https://henhoose.bandcamp.com/album/the-twelve?from=discover_page	Glasgow, UK	2026-01-23	https://f4.bcbits.com/img/a1292312838_16.jpg	26.91	{"Wipe Out","Rich (Katy's in Space","Out My Mind","Sirens Call My Name",Promise,"Game Of Two","Ego Death","In Control","Blessings On The Day"}	9	00:28:59	https://henhoose.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
949	Ão	Ao Mar	https://bandao.bandcamp.com/album/ao-mar?from=discover_page	Brussels, Belgium	2023-10-06	https://f4.bcbits.com/img/a0529310140_16.jpg	26.00	{Meninas,Outra,Mulher,Mãe,Avó,Speak,Guardar,O,Vazio,Crowd,Caixinha,More}	12	00:38:00	https://bandao.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
950	Lone Assembly	Knots & Chains	https://loneassembly.bandcamp.com/album/knots-chains?from=discover_page	Switzerland	2026-02-27	https://f4.bcbits.com/img/a3083133804_16.jpg	23.00	{"Call of the Swift",Fantasy,"Nocturnal Vision","The Pain Keeper","The City Works Like This","In the Open","My Life's Solid","You're Pulling at the Same Strings","Paler Streams","A Dark Score"}	10	00:38:43	https://loneassembly.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
951	Urban Heat	The Tower	https://urbanheat.bandcamp.com/album/the-tower?from=discover_page	Austin, Texas	2024-08-16	https://f4.bcbits.com/img/a2434556341_16.jpg	85.00	{"Take It to Your Grave",Sanitizer,"Too Much Too Soon","You've Got That Edge","Blindfolds and Magic Bullets","Savor Not the Thrill","Right Time of Night","Say the Words","Seven Safe Places","Addicted to the Sounds"}	10	00:39:44	https://urbanheat.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
952	Jay Reatard	Blood Visions	https://jayreatard.bandcamp.com/album/blood-visions?from=discover_page	Memphis, Tennessee	2009-11-23	https://f4.bcbits.com/img/a2853979018_16.jpg	17.85	{"Blood Visions","Greed, Money, Useless Children","It's So Easy","My Shadow","My Family","Death Is Forming","Oh It's Such a Shame","Not a Substitute",Nightmares,"I See You Standing There","We Who Wait","Fading All Away","Turning Blue","Puppet Man","Waiting for Something"}	15	00:29:17	https://jayreatard.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
953	Jerskin Fendrix	Winterreise	https://jerskinfendrix.bandcamp.com/album/winterreise?from=discover_page	London, UK	2020-04-17	https://f4.bcbits.com/img/a4273027945_16.jpg	29.25	{Manhattan,Onigiri,"Last Night In New York","Black Hair",Swamp,"A Star Is Born","I'll Clean Your Sheets","I'll Wait For It",Depecc,"Oh God"}	10	00:41:07	https://jerskinfendrix.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
954	Weval	CHOROPHOBIA	https://weval.bandcamp.com/album/chorophobia?from=discover_page	Amsterdam, Netherlands	2025-09-05	https://f4.bcbits.com/img/a4249313163_16.jpg	24.65	{CHOROPHOBIA,"MOVING ON",MOVEMENT,"JUST FRIENDS","Weval & Nsanshi - HEAD FIRST",DOPAMINE,"THIS IS…",BETTER,"Weval & KILIMANJARO - OPEN UP THAT DOOR",MERCATOR,FREE}	11	00:33:19	https://weval.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
955	cootie catcher	Something We All Got	https://cootiecatcher69.bandcamp.com/album/something-we-all-got?from=discover_page	Toronto, Ontario	2026-02-27	https://f4.bcbits.com/img/a3411096387_16.jpg	22.09	{"Loiter for the love of it",Lyfestyle,"Straight drop","From here to Halifax","No biggie","Rhymes with rest","Quarter note rock","Take me for granted","Wrong choice","Gingham dress","Puzzle pop","Stick figure","Going places",Pirouette}	14	00:39:41	https://cootiecatcher69.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
956	Dad Feels	Record	https://dadfeels.bandcamp.com/album/record?from=discover_page		2025-10-03	https://f4.bcbits.com/img/a3151730072_16.jpg	18.89	{"Human Limbs (Dad Is On REMIX)","Dad Feels Like Hell","Tear Me In Half",FOOD,Loops,"Melt (feat. Chris Conley)","The Wreck","Can't Be Stopped","No Kiss You",Beyond,"EVERYTHING IS FINE","2015 Ford Transit Minivan","Dad Bod","True Value","Diane (Jankins Remix) [feat. Yelle]",OBLITERATE}	16	00:49:01	https://dadfeels.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
957	Shannon and the Clams	Onion	https://shannonandtheclams.bandcamp.com/album/onion?from=discover_page	Oakland, California	2018-02-16	https://f4.bcbits.com/img/a3306537080_16.jpg	20.40	{"The Boy","It's Gonna Go Away",Backstreets,"If You Could Know","I Never Wanted Love",Onion,"Did You Love Me","Love Strike","I Leave Again",Tryin',"Tell Me When You Leave","Strange Wind","Don't Close Your Eyes"}	13	00:41:21	https://shannonandtheclams.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
958	Plums	jen	https://plums.bandcamp.com/album/jen-2?from=discover_page		2015-07-14	https://f4.bcbits.com/img/a4283042544_16.jpg	21.25	{"Parking Lots","Julia Gloria",Jen,Lounger,"Fine Madeline","Room Song","They Love Me They Love Me"}	7	00:19:51	https://plums.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
959	Magdalena Bay	mini mix vol. 1-3	https://magdalenabay.bandcamp.com/album/mini-mix-vol-1-3?from=discover_page	Los Angeles, California	2025-08-01	https://f4.bcbits.com/img/a1593413629_16.jpg	34.00	{Intro,"Afternoon in Heaven","El Dorado","Turning Off the Rain","U Wanna Dance?","Nothing Baby",Mine,"Live 4ever","I Don't Want to Cry Anymore",Sky2Fall,Body,Woww,Hideaway,"Sky2Fall (Reprise)","Slug Song",EXO,"2 Wheel Drive","Top Dog",Tonguetwister,"Wandering Eyes","Slug Song (Reprise)"}	21	00:41:16	https://magdalenabay.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
960	CoLD SToRAGE	wipE''out'''' - The Zero Gravity Soundtrack Vol. 2	https://coldstorage.bandcamp.com/album/wipeout-the-zero-gravity-soundtrack-vol-2?from=discover_page	Switzerland	2025-11-14	https://f4.bcbits.com/img/a1173387373_16.jpg	60.00	{"Scratch Pad 1","Messij Received","God's Gift",Tentative,"Canada 2048","Wiped Out","Body in Motion (Body Plus Mix)","Onyx (Dark Side of the Moon)","Messij Received (WSTWGBE Mix)","Canada (Drunken Auslander Mix)","Tentative (Woffenfum Mix)","Messij (Bobbing Boat Mix)","Body in Motion (Timeless Techno Mix)","DOH-T (AM / FM Mix)","'95 Future Echoes",Turbine,"Pencil Neck","Messij 2005 (New Science Mix)","Canada (Tim Reaper Remix)","Messij (SHERELLE's Messij in a Bottle Hardcore Remix)","DOH-T (Mantra Remix)","Canada (NikNak Remix)"}	22	02:18:25	https://coldstorage.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
961	Air Traffic Controller	Black Box	https://airtrafficcontroller.bandcamp.com/album/black-box?from=discover_page	Boston, Massachusetts	2016-03-11	https://f4.bcbits.com/img/a4034223167_16.jpg	21.25	{"People Watching",Phantom,"Get It Over With","The House","What You Do To My Soul",Warrior,"Water Falls","Creature Of The Night","This Is Love","On The Wire",Island,"Are You With Me?","What You Do To My Soul (Ronson Remix)"}	13	00:47:13	https://airtrafficcontroller.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
962	Magdalena Bay	A Little Rhythm and a Wicked Feeling	https://magdalenabay.bandcamp.com/album/a-little-rhythm-and-a-wicked-feeling?from=discover_page	Los Angeles, California	2020-03-13	https://f4.bcbits.com/img/a1935549572_16.jpg	19.55	{"How to Get Physical",Story,"Good Intentions",Airplane,Venice,Killshot,"Stop & Go","Oh Hell"}	8	00:28:02	https://magdalenabay.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
963	Dreamscape	La-Di-Da Recordings	https://dreamscape-uk.bandcamp.com/album/la-di-da-recordings?from=discover_page	Bristol, UK	2012-08-20	https://f4.bcbits.com/img/a3112277414_16.jpg	18.70	{"Seperate Sense","Greater Than God","Finally Through","Soft Fists","So Far from Belief",Cradle,"Nine Times to Die","Dreamsleep Eternal","No More But Thought"}	9	00:39:56	https://dreamscape-uk.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
964	Ela Minus	DÍA	https://elaminus.bandcamp.com/album/d-a?from=discover_page	Brooklyn, New York	2025-01-17	https://f4.bcbits.com/img/a1560541484_16.jpg	22.10	{"ABRIR MONTE",BROKEN,IDOLS,IDK,QQQQ,"I WANT TO BE BETTER",ONWARDS,AND,UPWARDS,COMBAT}	10	00:33:47	https://elaminus.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
965	Pan Dan	Mi Manifesto	https://pandan.bandcamp.com/album/mi-manifesto?from=discover_page	Turin, Italy	2025-12-04	https://f4.bcbits.com/img/a3867040078_16.jpg	27.00	{Spasmi,Primavera,"Il Contadino",Water,Scappa,"Freccia Rouge","I Cloud","Il Discorsetto","Inception (prod. Enea Pascal)","Gallina Vecchia"}	10	00:37:28	https://pandan.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
966	Flunk	Cover Ups (vol 1 & 2 - physical version)	https://flunk.bandcamp.com/album/cover-ups-vol-1-2-physical-version?from=discover_page	Oslo, Norway	2023-04-21	https://f4.bcbits.com/img/a0321570654_16.jpg	30.00	{"True Faith","See You","Only You","Make It Good","Femme Fatale","Last Word",Hero,"Silent Night","Wish Upon A Star","I Don't Want To Talk About It","Golden Brown","Cigarette Burns","Cherry Came Too","Karma Police","Two Icicles","Sound Of Silence","Speed Skating",Torch,"I Get You","Your Koolest Smile","Under The Covers"}	21	01:12:28	https://flunk.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
967	Château Forte	Château Forte	https://chateauforte.bandcamp.com/album/ch-teau-forte?from=discover_page	France	2023-03-24	https://f4.bcbits.com/img/a1517971757_16.jpg	20.00	{Aveux,"Tes yeux",Insolomnie,"Mélancolie (à la fin du jour v.2)","Le cri"}	5	00:28:16	https://chateauforte.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
968	SKYGGE + Artificial Intelligence	Hello World	https://skyggewithai.bandcamp.com/album/hello-world?from=discover_page	Paris, France	2018-01-12	https://f4.bcbits.com/img/a4054773990_16.jpg	15.00	{"Ballad of The Shadow","Sensitive (feat. C Duncan)","One Note Samba (feat. generated vocals from The Pirouettes)","In the House of Poetry (feat. Kyrie Kristmanson)","Magic Man","Mafia Love","Paper Skin (feat. JATA)","Valise (feat. The Pirouettes)","Je vais te Manger (feat. Sarah Yu Zeebroeke, Laurent Bardainne)","Multi Mega Fortune (feat. Michael Lovett)",Cryyyy,"Hello Shadow","Whistle Theme (feat. generated vocals from Catastrophe)","Cake Woman (feat. Camille Bertault et Mederic Collignon)","Cold Song"}	15	00:49:11	https://skyggewithai.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
969	KANGA	Under Glass	https://kanga.bandcamp.com/album/under-glass?from=discover_page	Los Angeles, California	2023-10-06	https://f4.bcbits.com/img/a3354010979_16.jpg	23.80	{Forward,Crashing,"Under Glass","Bad Girl",Rehab,Romance,Magnolia,"Dark Lullaby","Midnight Horses","Only Revolutions","Last Drive",Water}	12	00:38:43	https://kanga.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
970	jeanines	How Long Can It Last	https://jeanines.bandcamp.com/album/how-long-can-it-last?from=discover_page	Massachusetts	2025-06-27	https://f4.bcbits.com/img/a0841965513_16.jpg	24.57	{"To Fail","You Can't Get It Back","You'll Figure It Out","Coaxed A Storm","That's What You Say","What's Done Is Done","On And On","What's Lost","What You Do","One Art",Satisfied,"How Long Can It Last","Wrong Direction"}	13	00:21:43	https://jeanines.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
971	Caroline Polachek	Desire, I Want To Turn Into You	https://carolinepolachek.bandcamp.com/album/desire-i-want-to-turn-into-you?from=discover_page	Los Angeles, California	2023-02-14	https://f4.bcbits.com/img/a4080748776_16.jpg	19.53	{"Welcome To My Island","Pretty In Possible","Bunny Is A Rider",Sunset,"Crude Drawing Of An Angel","I Believe","Fly To You (feat. Grimes and Dido)","Blood And Butter","Hopedrunk Everasking","Butterfly Net",Smoke,Billions}	12	00:45:29	https://carolinepolachek.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
972	Caroline Polachek	Desire, I Want To Turn Into You: Everasking Edition	https://carolinepolachek.bandcamp.com/album/desire-i-want-to-turn-into-you-everasking-edition?from=discover_page	Los Angeles, California	2024-02-14	https://f4.bcbits.com/img/a1334755198_16.jpg	68.00	{"Welcome To My Island","Pretty In Possible","Bunny Is A Rider",Sunset,"Crude Drawing Of An Angel","I Believe","Fly To You (feat. Grimes & Dido)","Blood And Butter","Hopedrunk Everasking","Butterfly Net",Smoke,Billions,Dang,"Spring Is Coming With A Strawberry In The Mouth","Butterfly Net (feat. Weyes Blood)",Meanwhile,Coma,"Gambler's Prayer","Long Road Home","I Believe - Acoustic Version"}	20	01:16:56	https://carolinepolachek.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
974	Ulver	The Assassination of Julius Caesar	https://ulver.bandcamp.com/album/the-assassination-of-julius-caesar?from=discover_page	Oslo, Norway	2017-04-07	https://f4.bcbits.com/img/a2575559421_16.jpg	28.04	{Nemoralia,"Rolling Stone","So Falls the World","Southern Gothic","Angelus Novus",Transverberation,1969,"Coming Home"}	8	00:43:42	https://ulver.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
975	Second End Records	Jonnnah - What They Left LP (SER003)	https://secondendrec.bandcamp.com/album/jonnnah-what-they-left-lp-ser003?from=discover_page	Lyon, France	2025-12-12	https://f4.bcbits.com/img/a0700886090_16.jpg	25.00	{"N-zero pt.1 (digital only)","N-zero pt.2","The Triadic Space","Me, Elsewhere","We Are Not I","A Decade","Insomnia Never Ends 3","Magic Straw Mat (digital only)","Consume Me","The Blue Comet","O-one pt.1","O-one pt.2 (digital only)","O-one pt.3 (digital only)"}	13	01:03:39	https://secondendrec.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
976	Pearl & The Oysters	Planet Pearl	https://pearlandtheoysters.bandcamp.com/album/planet-pearl?from=discover_page	Los Angeles, California	2024-09-20	https://f4.bcbits.com/img/a2019848610_16.jpg	23.80	{"Side Quest","Halfway Where?","Together, Alone",Phototropic,"Cruise Control","A Planet Upside Down",Ripples,"Big Time","Triangular Girl","Feed the Meter","I Fell Into a Piano",4D,"Mid City"}	13	00:37:19	https://pearlandtheoysters.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
977	Phil Keaggy - Deluxe Studio vocal albums	What A Day (50th Anniversary Deluxe Edition)	https://pk-deluxestudiovocalalbums.bandcamp.com/album/what-a-day-50th-anniversary-deluxe-edition?from=discover_page	Nashville, Tennessee	2026-01-09	https://f4.bcbits.com/img/a2962130140_16.jpg	29.75	{"That Is What The Lord Will Do For You","King Of The Jews","Walking With Our Lord","A Time And A Place",Rejoice,"What A Day","Now I Can See","Behold All Things Are Become New",Hallelujah,"I Will Sing","That Is What The Lord Will Do For You (Alt. Mix)","King Of The Jews (Alt. Extended Mix)","Walking With Our Lord (Instr. Mix)","A Time And A Place (Alt. Mix)","Rejoice (Alt. Mix)","What A Day (Instr. Mix)","What A Day (End Tag v1)","What A Day (End Tag v2)","Now I Can See (Alt. Mix)","Behold All Things Become New (Acoustic Mix)","Hallelujah (Instr. Mix)","Hallelujah (Vocal Mix)","I Will Sing (Instr. Mix)","Psalm 98 (Instr. outtake)","Children At Play (Instr. Outtake)","\\"Original Idea\\" (Outtake)","That Is What The Lord Will Do For You","Walking With Our Lord",Rejoice,"What A Day","Now I Can See/I Shall Not Be Moved","Behold All Things Become New",Hallelujah,"I Will Sing","He is Risen","Give Thanks","Taste And See","Heaven is Home","Unchanging Love For You (Bernadette Keaggy vocal)","Field of Flowers","Happy Are We","Sweet Dreams Tonight","Voice Of God Call Out","I Believe (excerpt)","Our Island (With You)","Lovely Jesus (Bernadette Keaggy Vocal)","Heaven Is Home (bonus / 1970 early home demo)"}	47	02:57:51	https://pk-deluxestudiovocalalbums.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
978	Fever Ray	Radical Romantics	https://feverray.bandcamp.com/album/radical-romantics?from=discover_page	Stockholm, Sweden	2023-03-10	https://f4.bcbits.com/img/a2669781793_16.jpg	35.78	{"What They Call Us",Shiver,"New Utensils",Kandy,"Even It Out","Looking For A Ghost","Carbon Dioxide",North,"Tapping Fingers","Bottom Of The Ocean"}	10	00:44:12	https://feverray.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
979	Indigo De Souza	Precipice	https://indigodesouza.bandcamp.com/album/precipice?from=discover_page	North Carolina	2025-07-25	https://f4.bcbits.com/img/a1636644954_16.jpg	22.10	{"Be My Love","Crying Over Nothing",Crush,"Not Afraid","Be Like the Water",Heartthrob,Dinner,"Clean It Up",Heartbreaker,"Pass It By",Precipice}	11	00:31:43	https://indigodesouza.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
980	MUNA	MUNA	https://muna.bandcamp.com/album/muna?from=discover_page	Los Angeles, California	2022-06-24	https://f4.bcbits.com/img/a1733857658_16.jpg	20.39	{"Silk Chiffon","What I Want","Runner's High","Home By Now","Kind Of Girl","Handle Me","No Idea",Solid,"Anything But Me","Loose Garment","Shooting Star"}	11	00:39:19	https://muna.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
981	Stereolab	Dots And Loops	https://stereolab.bandcamp.com/album/dots-and-loops?from=discover_page	London, UK	2025-02-28	https://f4.bcbits.com/img/a0376615696_16.jpg	32.76	{Brakhage,"Miss Modular","The Flower Called Nowhere",Diagonals,"Prisoner of Mars","Rainbo Conversation","Refractions in the Plastic Pulse",Parsec,"Ticker-tape of the Unconscious",Contronatura}	10	01:06:15	https://stereolab.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
982	Yalla Miku	2	https://yallamiku.bandcamp.com/album/2?from=discover_page	Geneva, Switzerland	2025-11-07	https://f4.bcbits.com/img/a3300777753_16.jpg	20.00	{"Al Sayf السيف","Alemuye ኣለሙየ","Maximum Self-Care","Le Palais de Bachar","Embeyto እምበይቶ","Il fait trop cuit ይፈትወኪ","Scarlett Chien سكارليت كلب",Post-Aventures,"Al 3Mal العمل ስራሕ","La Tour Eiffel ቱር ኤፌል"}	10	00:38:34	https://yallamiku.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
983	yeule	softscars	https://yeule.bandcamp.com/album/softscars?from=discover_page		2023-09-22	https://f4.bcbits.com/img/a4141983950_16.jpg	23.80	{"x w x","sulky baby",softscars,4ui12,ghosts,dazies,"fish in the pool","software update",inferno,bloodbunny,"cyber meat","aphex twin flame"}	12	00:40:05	https://yeule.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
984	Gary Numan	Telekon (45th Anniversary Expanded Edition)	https://garynuman.bandcamp.com/album/telekon-45th-anniversary-expanded-edition?from=discover_page	London, UK	2025-12-12	https://f4.bcbits.com/img/a1421893295_16.jpg	47.67	{"This Wreckage","The Aircrash Bureau",Telekon,"Remind Me to Smile","Sleep by Windows","I'm an Agent","I Dream of Wires","Remember I Was Vapour","Please Push No More","The Joy Circuit","Like a B-Film","Please Push No More (Early Version)","The Aircrash Bureau (Early Version)","I'm an Agent (Early Version)"}	14	01:08:43	https://garynuman.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
985	konkord	Sie sagt 1 2 3 4	https://shop.konkord.org/album/sie-sagt-1-2-3-4?from=discover_page	Austria	2025-12-05	https://f4.bcbits.com/img/a3418664748_16.jpg	30.00	{"Candy sagt [Vogerlmischung]","Kerstin sagt","Lisa sagt","Stefanie sagt"}	4	00:16:12	https://shop.konkord.org?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
1043	Tycho	Infinite Health	https://tycho.bandcamp.com/album/infinite-health?from=discover_page	San Francisco, California	2024-08-30	https://f4.bcbits.com/img/a3772691981_16.jpg	24.65	{"Consciousness Felt",Phantom,Restraint,Devices,"Tycho and Cautious Clay - Infinite Health",Green,"DX Odyssey",Totem,Epilogue}	9	00:33:17	https://tycho.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
986	Julia Holter	Something in the Room She Moves	https://juliaholter.bandcamp.com/album/something-in-the-room-she-moves?from=discover_page	Los Angeles, California	2024-03-22	https://f4.bcbits.com/img/a0656787190_16.jpg	31.99	{"Sun Girl","These Morning","Something in the Room She Moves",Materia,Meyou,Spinning,Ocean,"Evening Mood","Talking to the Whisper","Who Brings Me"}	10	00:53:51	https://juliaholter.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
987	Specific Recordings	Haru To Shura	https://specific.bandcamp.com/album/haru-to-shura?from=discover_page	Metz, France	2019-04-26	https://f4.bcbits.com/img/a0731609525_16.jpg	15.00	{"Make More Noize Of You",Narashite,Underground,"Haru To Shura",ZZZ,"Lost Planet","Take Back The World","Night Swimming",ZZZ,Nineteen,"Let's Dream",ZZZ,"Rock'n'roll Never Dies"}	13	00:36:30	https://specific.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
988	Devours	Sports Car Era	https://devours.bandcamp.com/album/sports-car-era?from=discover_page	Vancouver, British Columbia	2025-03-14	https://f4.bcbits.com/img/a0989541805_16.jpg	25.00	{Bodyguard,"Armageddon Mood Ring","Swordswallower (Zendaya's Fortress)",November,"Canada's Next Top Fat Otter","Quite Possessed",Pirouette,Loudmouth,XY,"Sports Car Era"}	10	00:41:07	https://devours.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
989	Kelly Lee Owens	KELLY	https://kellyleeowens.bandcamp.com/album/kelly?from=discover_page	London, UK	2025-11-21	https://f4.bcbits.com/img/a1123263638_16.jpg	17.55	{ASCEND,"132 TECHNO",DESCEND,"LOSE YOUR HEAD"}	4	00:15:41	https://kellyleeowens.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
990	Julia Holter	Have You In My Wilderness	https://juliaholter.bandcamp.com/album/have-you-in-my-wilderness?from=discover_page	Los Angeles, California	2015-09-25	https://f4.bcbits.com/img/a3587684738_16.jpg	36.55	{"Feel You",Silhouette,"How Long?","Lucette Stranded on the Island","Sea Calls Me Home","Night Song","Everytime Boots","Betsy On The Roof",Vasquez,"Have You In My Wilderness"}	10	00:46:05	https://juliaholter.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
991	The Notwist	Magnificent Fall	https://thenotwist.bandcamp.com/album/magnificent-fall?from=discover_page	Germany	2025-11-14	https://f4.bcbits.com/img/a2284275494_16.jpg	29.99	{"One Of These Days","Magnificent Fall","Boneless (Grizzly Bear Remix)","Blank Air",Avalanche,"Run Run Run (Ada Remix)","Red Room","Come In","Solo Swim","Sleep (Odd Nosdam Remix)","Intro Live From Alien Research Center","Who We Used To Be","Das Verschwinden"}	13	00:54:39	https://thenotwist.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
992	Suzie True	How I Learned To Love What''s Gone	https://suzietrue.bandcamp.com/album/how-i-learned-to-love-whats-gone?from=discover_page	Los Angeles, California	2025-11-27	https://f4.bcbits.com/img/a3364372590_16.jpg	25.49	{Glow,"Get Prettier Overnight!!!","Every Dog","Win Me Over",Sober,"Oh, Baby!!!","So Blame Me","Love Like Cement","LEECHES (PLAY DEAD!)","Love For Nihilists",Perfect}	11	00:34:26	https://suzietrue.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
993	Phat ''n'' Phunky	Bull Shannon - Stamina	https://phatnphunky.bandcamp.com/album/bull-shannon-stamina?from=discover_page	San Jose, California	2026-01-02	https://f4.bcbits.com/img/a0767902575_16.jpg	17.00	{Wesley,"Dragon Boy","Top Billin'","Cabo Cab Co.","Cacio e Pepe",Beasty}	6	00:15:22	https://phatnphunky.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
994	Romanie	It''s Not That Funny	https://romaniemusic.bandcamp.com/album/its-not-that-funny?from=discover_page	Melbourne, Australia	2026-02-20	https://f4.bcbits.com/img/a2189938348_16.jpg	59.99	{"Anything or Anyone","I Tried To Erase You",Falling,"My Eyes Don't Light Up When I Look At You","When Will We Lose Hope?","I Won't Yell","Only Darkness Grows","Thrift Shop","I Can't Think About A Future","Uh Oh","Power At Play"}	11	00:34:33	https://romaniemusic.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
995	Pearl & The Oysters	Coast 2 Coast	https://pearlandtheoysters.bandcamp.com/album/coast-2-coast?from=discover_page	Los Angeles, California	2023-04-21	https://f4.bcbits.com/img/a1372672954_16.jpg	26.35	{"Intro (...on the Sea-Forest)",Fireflies,Konami,"Pacific Ave",Timetron,"Loading Screen","Space Coast","Moon Canyon Park","D'Ya Hear Me!",Paraiso,"Read the Room (feat. Laetitia Sadier)","Vicarious Voyage","Joyful Science"}	13	00:33:45	https://pearlandtheoysters.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
996	Yaeji	With A Hammer	https://kraejiyaeji.bandcamp.com/album/with-a-hammer?from=discover_page	Brooklyn, New York	2023-04-07	https://f4.bcbits.com/img/a2946819062_16.jpg	20.21	{"Submerge FM","For Granted",Fever,"Passed Me By","With A Hammer","I’ll Remember For Me, I’ll Remember For You","Done (Let’s Get It)","Yaeji feat. K Wata - Ready or Not","Yaeji feat. Enayet - Michin","Away x5","Yaeji feat. Nourished by Time - Happy","Yaeji feat. Loraine James - 1 Thing To Smash","Be Alone In This"}	13	00:43:39	https://kraejiyaeji.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
997	Fever Ray	Fever Ray	https://feverray.bandcamp.com/album/fever-ray?from=discover_page	Stockholm, Sweden	2009-01-12	https://f4.bcbits.com/img/a4252305423_16.jpg	22.08	{"If I Had A Heart","When I Grow Up","Dry And Dusty",Seven,"Triangle Walks","Concrete Walls","Now's The Only Time I Know","I'm Not Done","Keep The Streets Empty For Me",Coconut}	10	00:48:06	https://feverray.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
998	Anderson .Paak	Malibu	https://breezylovejoy.bandcamp.com/album/malibu?from=discover_page	Los Angeles, California	2016-01-15	https://f4.bcbits.com/img/a3384380896_16.jpg	21.23	{"The Bird","Heart Don't Stand A Chance","Anderson Paak, BJ The Chicago Kid - The Waters (feat. BJ The Chicago Kid)","The Season | Carry Me","Put Me Thru","Anderson Paak, ScHoolboy Q - Am I Wrong (feat. ScHoolboy Q)","Without You","Parking Lot","Anderson Paak, The Free Nationals United Fellowship Choir - Lite Weight (feat. The Free Nationals United Fellowship Choir)","Anderson Paak, The Game, Sonya Elise - Room In Here (feat. The Game & Sonyae Elise)","Water Fall (Interluuube)","Your Prime","Come Down","Silicon Valley",Celebrate,"Anderson Paak, Talib Kweli, Timan Family Choir - The Dreamer (feat. Talib Kweli & Timan Family Choir)"}	16	01:01:02	https://breezylovejoy.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
1011	Clara La San	Made Mistakes	https://claralasanofficial.bandcamp.com/album/made-mistakes?from=discover_page		2024-06-07	https://f4.bcbits.com/img/a0608431610_16.jpg	22.10	{"Another Night","Don't Worry About It","Things You Didn't Know",Runnin,"Talking To You","All I Wanna Do","Far Away","Upset With Ya",Solo,"Made Me Feel"}	10	00:29:44	https://claralasanofficial.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
999	Akuphone	The Golden Voice of Phnom Penh, 1962-1974	https://akuphone.bandcamp.com/album/the-golden-voice-of-phnom-penh-1962-1974?from=discover_page	France	2025-09-26	https://f4.bcbits.com/img/a0355172381_16.jpg	24.90	{"So Savoeun & Meas Saman - ហៅបងរែកទឹក (Calling For You To Fetch Water)","គេលេងភ្លេងហើយ (The Music Has Started)","So Savoeun & Meas Saman - ខ្លាចប្រុសចិត្តព្រាន (Afraid of Heartbreaking Men)","លលកវាយំ (Crying Doves)","So Savoeun & Meas Saman - ក្រសាហូតដាវ (Sword Weaving Heron)","So Savoeun & Meas Saman - ឃុនពីម៉ូច (Bad From The Start)","So Savoeun & Meas Saman - អាឈ្មោលខ្នាយវែង (Long Clawed Rooster)","លលកហើរទំចុងក្រស់ (Dove Perched On The End Vine)","រូចទឹកចោលទៅ (Wash It Away With Water)","So Savoeun & Sinn Sisamouth - ប៉ាឡេឡៃ (Pa Le Lai)","So Savoeun & Lek Savath - ដេកថ្ងៃសំចៃតុកយប់ (Sleep During The Day Preparing For Night)","ឱ!ពពេជចៀប (Oh! Little Peep Bird)","ម្លប់ដូង (Coconut Shade)","ខំផ្គាប់ប៉ុណ្ណឹងហើយ (Tired of Pleasing You)"}	16	00:55:18	https://akuphone.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
1000	maya ongaku	Maybe Psychic	https://mayaongakuggb.bandcamp.com/album/maybe-psychic?from=discover_page	Fujisawa, Japan	2025-11-28	https://f4.bcbits.com/img/a3022030478_16.jpg	27.00	{"Maybe Psychic"}	1	00:04:43	https://mayaongakuggb.bandcamp.com?from=discover_page	2026-02-23 13:22:19.749713	2026-02-23 13:22:19.749713
1001	sealedrecords	Can''t Cheat Karma	https://sealedrecords2.bandcamp.com/album/cant-cheat-karma?from=discover_page	London, UK	2019-02-01	https://f4.bcbits.com/img/a4155160964_16.jpg	21.06	{War,Subvert,"Can't Cheat Karma",Demystification,"Great White Hunter",Dancing,"True Love","More Trouble Coming Everyday",Knife,Biafra,"Not Me",Fear,Wolves}	13	00:40:47	https://sealedrecords2.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1002	ESCAPE-ISM	Charge of the Love Brigade	https://escape-ism.bandcamp.com/album/charge-of-the-love-brigade?from=discover_page		2025-03-07	https://f4.bcbits.com/img/a2749079345_16.jpg	21.25	{"The Rebel Outlaw","Black Gold","Last of the Sellouts","Rock 'N' Roll Man","Charge of the Love Brigade","Beneath the Underground","If You Feel Like Rockin'","One of the Greats","Fire in Malibu","Beneath the Underground (Pt. II)"}	10	00:32:22	https://escape-ism.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1003	Dua Saleh	I SHOULD CALL THEM	https://duasaleh.bandcamp.com/album/i-should-call-them?from=discover_page	Los Angeles, California	2024-10-11	https://f4.bcbits.com/img/a4223191189_16.jpg	22.95	{"chi girl",want,"time & time again (feat. Sid Sriram)","bo peep","pussy suicide","unruly (feat. serpentwithfeet)","playing games",cradle,"television (feat. Ambré)","coast (feat. Gallant)",2excited}	11	00:32:59	https://duasaleh.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1004	INDEX:Records	Zona	https://indexrecords.bandcamp.com/album/zona?from=discover_page	Glasgow, UK	2024-11-29	https://f4.bcbits.com/img/a1323530152_16.jpg	18.72	{"Deep Hard","Y La Tuya Cual Es?","How I Feel","What's The Meaning","Get In The Zone"}	5	00:21:37	https://indexrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1005	Stars	Set Yourself On Fire (20th Anniversary Edition)	https://starsband.bandcamp.com/album/set-yourself-on-fire-20th-anniversary-edition?from=discover_page	Montreal, Québec	2024-09-30	https://f4.bcbits.com/img/a1768617444_16.jpg	47.00	{"Your Ex-Lover Is Dead","Set Yourself On Fire","Ageless Beauty",Reunion,"The Big Fight","What I'm Trying To Say","One More Night","Sleep Tonight","The First Five Times","He Lied About Death","Celebration Guns","Soft Revolution","Calendar Girl"}	15	01:00:01	https://starsband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1006	CoLD SToRAGE	wipE''out'''' - The Zero Gravity Soundtrack	https://coldstorage.bandcamp.com/album/wipeout-the-zero-gravity-soundtrack?from=discover_page	Switzerland	2023-11-17	https://f4.bcbits.com/img/a3506793683_16.jpg	39.00	{"wipE'out'' Intro (2023 Remaster)","Hakapik Murder (2023 Remaster)","Messij (2023 Remaster)","Canada (2023 Remaster)","Tenation (2023 Remaster)","DOH-T (2023 Remaster)","Trancevaal (2023 Remaster)","Surgeon (2023 Remaster)","Cairodrome (2023 Remaster)","Body in Motion (2023 Remaster)","Cardinal Dancer (2023 Remaster)","Cold Comfort (2023 Remaster)","Kinkong (2023 Remaster)","Operatique (2023 Remaster)","Plasticity (2023 Remaster)","Messij Extended (2023 Remaster)","Argon (2023 Remaster)","Phloem (2023 Remaster)","Xenon (2023 Remaster)","Xylem (2023 Remaster)","wipE'out'' Intro (µ-Ziq Remix)","DOH-T (Wordcolour Remix)","Xylem (Brainwaltzera Remix)","Canada (James Shinra Remix)","Messij (Kode9 Remix)","Trancevaal (Simo Cell Remix)","Cairodrome (Surgeons Girl Remix)","Messij (Datassette Remix)"}	28	01:59:59	https://coldstorage.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1007	ANOHNI	My Back Was A Bridge For You To Cross	https://anohni.bandcamp.com/album/my-back-was-a-bridge-for-you-to-cross-2?from=discover_page	New York, New York	2023-07-07	https://f4.bcbits.com/img/a0577757592_16.jpg	27.19	{"It Must Change","Go Ahead","Sliver Of Ice",Can't,Scapegoat,"It's My Fault",Rest,"There Wasn't Enough","Why Am I Alive Now?","You Be Free"}	10	00:41:23	https://anohni.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1008	Peter Gabriel	US	https://petergabriel.bandcamp.com/album/us-2?from=discover_page	England, UK	1992-09-27	https://f4.bcbits.com/img/a2181148078_16.jpg	24.37	{"Come Talk to Me","Love to be Loved","Blood of Eden",Steam,"Only Us","Washing of the Water","Digging in the Dirt","Fourteen Black Paintings","Kiss that Frog","Secret World"}	10	00:57:49	https://petergabriel.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1009	Night Moves	Double Life	https://nightmoves.bandcamp.com/album/double-life?from=discover_page	Minneapolis, Minnesota	2025-07-25	https://f4.bcbits.com/img/a3694558128_16.jpg	33.00	{"Trying To Steal A Smile",Daytona,"Hold On To Tonight","Almost Perfect","State Sponsored Psychosis","Ring My Bell","The Judge","White Liquor","The Abduction","This Time Tomorrow",Desperation}	11	00:40:18	https://nightmoves.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1010	Lone Assembly	That Never Happened - Extended Version	https://loneassembly.bandcamp.com/album/that-never-happened-extended-version?from=discover_page	Switzerland	2025-04-19	https://f4.bcbits.com/img/a2896185387_16.jpg	16.00	{"Cut the Roses","Blue Morning","All Around Me","Seven Souls",Backwards,"Keep this Flame","Seven Souls (Acoustic Version)","Blue Morning (Acoustic Version)"}	8	00:29:41	https://loneassembly.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1012	Liniker	CAJU	https://liniker.bandcamp.com/album/caju?from=discover_page	São Paulo, Brazil	2025-04-25	https://f4.bcbits.com/img/a0857395649_16.jpg	35.00	{Caju,Tudo,"Veludo Marrom","Ao Teu Lado (feat. Amaro Freitas and Anavitória)","Me Ajude a Salvar os Domingos","Negona dos Olhos Terriveis Ft Baiana System",Mayonga,"Papo de Edredom (feat. Melly)",Popstar,Febre,"Pote de Ouro (feat. Priscila Senna)","Deixa Estar Ft Lulu Santos, Pabllo Vittar","So special Ft Tropkillaz"}	13	01:04:27	https://liniker.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1013	The Particles	1980s Bubblegum	https://theparticles.bandcamp.com/album/1980s-bubblegum?from=discover_page	Sydney, Australia	2023-07-07	https://f4.bcbits.com/img/a3943808421_16.jpg	33.00	{"Driving Me","Apricot's Dream","Zig Zag","Truth About You","(Bits Of) Wood","Remington Rand","The Trumpet Song","Dresses and Shoes",Observations,"Family Life","I Know A Place (live)","(Bits Of) Wood (early version)",Intro/Interview,"Truth About You (live)","Walking Talking (live)","(Bits Of) Wood (live)","Remington Rand (live)","The Trumpet Song (live)"}	18	00:54:26	https://theparticles.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1014	The RAH Band	Going Up (2025 Remaster)	https://therahband.bandcamp.com/album/going-up-2025-remaster?from=discover_page	London, UK	2025-12-16	https://f4.bcbits.com/img/a0273445068_16.jpg	25.74	{"Messages From The Stars (2025 Remaster)","Roll Me Down To Rio (2025 Remaster)","Perfumed Garden (2025 Remaster)","Hunger For Your Jungle Love (2025 Remaster)","Sam The Samba Man (2025 Remaster)","Winter Love (2025 Remaster)","Tears & Rain (2025 Remaster)","Two Bodies (2025 Remaster)","Party Games (2025 Remaster)","Riding On A Fantasy (2025 Remaster)"}	10	00:53:09	https://therahband.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1015	Roosevelt	Embrace	https://iamroosevelt.bandcamp.com/album/embrace?from=discover_page	Cologne, Germany	2023-09-22	https://f4.bcbits.com/img/a3239363240_16.jpg	23.80	{"Ordinary Love",Rising,Luna,"Yucca Mesa",Paralyzed,"Lake Shore",Realize,"Fall Right In",Forevermore,Alive}	10	00:39:52	https://iamroosevelt.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1016	Mathias Ruppnig	FOAM	https://mathiasruppnig.bandcamp.com/album/foam?from=discover_page	Berlin, Germany	2025-12-12	https://f4.bcbits.com/img/a1402918234_16.jpg	35.00	{"Petrology Kid",Exhale,Ivy,"Fathers and Sons",Scopes,Vortex,"Stranger Than Fiction","Shy One Wondering",Jimbo}	10	00:50:59	https://mathiasruppnig.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1017	Pinback	Some Offcell Voices	https://pinback.bandcamp.com/album/some-offcell-voices?from=discover_page	San Diego, California	2017-03-17	https://f4.bcbits.com/img/a2440789746_16.jpg	21.25	{"Some Voices",Trainer,Manchuria,June,"Microtonic Wave","Victorious D",Offcell,B,"Grey Machine"}	9	00:45:38	https://pinback.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1018	Brooklyn Funk Essentials	Take The L Train (To 8 Ave.) (Calibre Remix)	https://brooklynfunkessentials.bandcamp.com/album/take-the-l-train-to-8-ave-calibre-remix?from=discover_page	Brooklyn, New York	2025-01-14	https://f4.bcbits.com/img/a0970314692_16.jpg	17.55	{"Take The L Train (To 8 Ave.) (Calibre Remix)","Take The L Train (To 8 Ave.) (Calibre Ambient Remix)"}	2	00:14:36	https://brooklynfunkessentials.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1019	Rebelski	Algorithms	https://rebelski.bandcamp.com/album/algorithms?from=discover_page	UK	2026-02-13	https://f4.bcbits.com/img/a2857090922_16.jpg	29.25	{Today,Sanctuary,Photograph,Calculate,Snow,Momentum,Roads,Mirror,Leaf,Waves}	10	00:35:50	https://rebelski.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1020	Past Inside the Present	The Disappearing Collective Vol. II	https://pitp.bandcamp.com/album/the-disappearing-collective-vol-ii?from=discover_page	Indianapolis, Indiana	2026-01-14	https://f4.bcbits.com/img/a0744788244_16.jpg	18.70	{"I Never Will Forget Those Nights","A Light in the Window at Home",Ephemeris,Tenshi,"I Had a Dream About This Place","Send Me An Angel","Blue Suburban Skies"}	7	00:39:05	https://pitp.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1021	Past Inside the Present	Cantus for Winter in Six Parts	https://pitp.bandcamp.com/album/cantus-for-winter-in-six-parts?from=discover_page	Indianapolis, Indiana	2026-01-01	https://f4.bcbits.com/img/a3261620356_16.jpg	18.70	{"Cantus for Winter, Part One","Cantus for Winter, Part Two","Cantus for Winter, Part Three","Cantus for Winter, Part Four","Cantus for Winter, Part Five","Cantus for Winter, Part Six"}	6	00:41:13	https://pitp.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1022	Kalahari Oyster Cult	Yapping After Dawn	https://kalaharioystercult.bandcamp.com/album/yapping-after-dawn?from=discover_page	Amsterdam, Netherlands	2026-01-30	https://f4.bcbits.com/img/a2340606027_16.jpg	14.99	{"Trick Speech","Full Of Fools","Red Cocktail (K-Hole Dub)",1000,"Again (Serious Mix)"}	5	00:23:35	https://kalaharioystercult.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1023	morctapes	Unfurling	https://morctapes.bandcamp.com/album/unfurling?from=discover_page	Gent, Belgium	2026-01-31	https://f4.bcbits.com/img/a1673084294_16.jpg	20.00	{"Green bound in ice and snow","Sun Flecks","The dissonance","The sun of the West","My breath the sea","The moon unveiled"}	6	00:39:52	https://morctapes.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1024	Kalahari Oyster Cult	MINERAL01	https://kalaharioystercult.bandcamp.com/album/mineral01?from=discover_page	Amsterdam, Netherlands	2025-11-25	https://f4.bcbits.com/img/a2657236822_16.jpg	12.99	{"Morose - Holy Ghost"}	1	00:07:57	https://kalaharioystercult.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1025	Arrival	Arrival featuring Kevin McCormick	https://arrival1.bandcamp.com/album/arrival-featuring-kevin-mccormick?from=discover_page	Stockport, UK	2026-01-12	https://f4.bcbits.com/img/a0275591760_16.jpg	21.06	{"One - (Underbank Mix)","One - (Solstice Mix)","Common Place - (Thought Leadership Mix)","Common Place"}	\N	00:49:30	https://arrival1.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1026	Sunny Crypt	Slide Into Yellow Dimensions	https://sunnycrypt.bandcamp.com/album/slide-into-yellow-dimensions?from=discover_page	Italy	2026-02-01	https://f4.bcbits.com/img/a3265699835_16.jpg	20.00	{"Waving The Sky","Into Your Head","Into our Head (DJ Normal 4's psychotropic refixX)","Slide Into Yellow Dimensions"}	4	00:28:28	https://sunnycrypt.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1027	Matthew Halsall	Bright Sparkling Light	https://matthewhalsall.bandcamp.com/album/bright-sparkling-light?from=discover_page	Manchester, UK	2024-03-01	https://f4.bcbits.com/img/a4244760927_16.jpg	23.39	{"Bright Sparkling Light","Newborough Forest","The Tide and the Moon"}	3	00:24:55	https://matthewhalsall.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1028	Aphex Twin	Selected Ambient Works Volume II (Expanded Edition)	https://aphextwin.bandcamp.com/album/selected-ambient-works-volume-ii-expanded-edition?from=discover_page	UK	2024-10-04	https://f4.bcbits.com/img/a0497903782_16.jpg	56.16	{#1,#2,#3,#4,#5,#6,#7,#8,#9,#10,#11,#12,"Blue Calx",#14,#15,#16,#17,#18,#19,#20,#21,#22,#23,#24,#25,"th1 [evnslower]","Rhubarb Orc. 19.53 Rev"}	27	03:04:54	https://aphextwin.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1029	Evigt Mörker	6	https://evigtmorker.bandcamp.com/album/6?from=discover_page	Stockholm, Sweden	2026-02-02	https://f4.bcbits.com/img/a3464099955_16.jpg	19.00	{"Kapa alla grenar","Hägn vid tidens ände","Stängt rike öppnas","Tala glödande","Ljus som äter himlen","Negativ eld"}	6	00:30:38	https://evigtmorker.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1030	Hayden Pedigo	I''ll Be Waving As You Drive Away	https://haydenpedigo.bandcamp.com/album/ill-be-waving-as-you-drive-away?from=discover_page	Amarillo, Texas	2025-06-06	https://f4.bcbits.com/img/a1906007774_16.jpg	22.94	{"Long Pond Lily","All the Way Across",Smoked,Houndstooth,Hermes,"Small Torch","I'll Be Waving As You Drive Away","End Credits (Bonus Track)"}	8	00:30:36	https://haydenpedigo.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1031	Four Tet	Into Dust (Still Falling)	https://fourtet.bandcamp.com/album/into-dust-still-falling?from=discover_page	London, UK	2025-06-17	https://f4.bcbits.com/img/a0738629308_16.jpg	17.54	{"Into Dust (Still Falling)"}	1	00:05:33	https://fourtet.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1032	Rebirth Records	Paraíso. The True Spirit Of Ibiza (selected by DJ Alfredo)	https://rebirthrecordings.bandcamp.com/album/para-so-the-true-spirit-of-ibiza-selected-by-dj-alfredo?from=discover_page	Brescia, Italy	2025-09-26	https://f4.bcbits.com/img/a1599897970_16.jpg	50.00	{"Max Berlin's - Elle Et Moi (Instrumental)","It’s Immaterial - Driving Away From Home (Wicked Weather For Walking)","The Woodentops - Why Why Why (Leo Mas & Fabrice Balearic Militant Dub)","Nitzer Ebb - Join In The Chant (Lies! Instrumental)","Exotica Maximus - Western Fields","Georgie Red - Help The Man (Help Yourself Alternative Mix)","Elkin & Nelson - Jibaro (enrolle)","Willie Colón - Set Fire To Me (Inferno Dub)","Ketama - Domo Arigato","Funkapolitan - As The Time Goes By","Mandy Smith - I Just Can't Wait (The Cool and Breezy Jazz Version)","Mr. Fingers - Mystery Of Love","Alfredo - Inspiration  (0224 Mix)","Atlas - Compassion","The Metaluna Mutant - Blinky Blue Eyed Sunrise (Original Mix)","Voices Of Kwahn - Third Whale Trip","Penguin Cafe Orchestra - Perpetuum Mobile","Thrashing Doves - Je$u$ on the Payroll (Unreleased Instrumental Version)","Deep Joy - Fall (Andrew Weatherall Let There Be Drums Mix)","Raze - Break 4 Love (Extended Mix)","Joe Smooth Inc. Feat. Anthony Thomas - The Promised Land","Kc Flightt - Let’s Get Jazzy (Dope Dub Mix)","DJ Alfredo, Cathy Battistessa & Arian 911 - Moral Of The Story","Paco Fernández - Junto Al Mar","Josè Padilla - Still Waters (A Man Called Adam Mix)","Dubtribe - Sunshine’s Theme","Acupressure - We Are the Future (Instrumental Mix)","808 State - Pacific State","Miro - Sunrise","51 Days - Paper Moon","The Woodleigh Research Facility - Borderland (Andrew Weatherall Mix)","Wim Mertens - Maximizing The Audience","The Sabres Of Paradise - Smokebelch II (Beatless Mix)"}	33	03:21:27	https://rebirthrecordings.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1033	naff recordings	Fly In Amber	https://naffrecordings.bandcamp.com/album/fly-in-amber?from=discover_page	Montreal, Québec	2025-10-30	https://f4.bcbits.com/img/a1380985369_16.jpg	21.25	{"Slip Logic",Softening,"Fly In Amber",Rummage,"Stepping Stoned"}	5	00:30:55	https://naffrecordings.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1034	Rødhåd	fabric presents Rødhåd	https://rodhad.bandcamp.com/album/fabric-presents-r-dh-d-2?from=discover_page	Berlin, Germany	2024-09-27	https://f4.bcbits.com/img/a1051229826_16.jpg	28.08	{"Inception Report","Clotur - Apexis","Beste Hira - Time","Casual Treatment - Falling Backwards","Mathys Lenne - The Moon Speaks","Rill - Molar","Arkan - The Ones Who Suffers","Nightlife Experiences feat. Theo Nasa","Delano Legito - Kyoshi","DVS1 - Droid","Inox Traxx - DSF","SAMA - Can You Find Meaning Within?","Ignez - First Light","Nastia Reigel - Chaotic","UFO95 - Suspense","A Morgan - I Don't","Alarico - Hubris","Peryl - Eternal Delay","HIGHLIMITER - Lost In Fractals","Tascamboy - Recovery","Rene Wise - Children Of The Night","Klint - Drunk With Fuel","Marcal - Fear Is Your Enemy (Space Mix)","Augusto Taito - Mi Tierra","Phil Berg - Photons","Holden Federico - Close",".VRIL - Pump Out Kids","Out Of Place Artefacts - Science Faction","fabric presents Rødhåd"}	29	03:54:13	https://rodhad.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1035	ILIAN TAPE	ITX039 - Locked in, Locked on	https://iliantape.bandcamp.com/album/itx039-locked-in-locked-on?from=discover_page	Munich, Germany	2025-06-26	https://f4.bcbits.com/img/a0575129543_16.jpg	10.00	{"Locked in, Locked on","Levitation Dub",Ruffhouse,"Big Munch"}	4	00:22:48	https://iliantape.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1036	Legowelt	Technolife Supernature	https://legowelt.bandcamp.com/album/technolife-supernature?from=discover_page	The Hague, The Netherlands	2025-08-26	https://f4.bcbits.com/img/a4080229022_16.jpg	24.99	{"Gato Expresso","Lamas in Absurdopolis","Sad Lonely Jupiter","On My Casio",Zeitverwarpung,"Birds Fly To Sirius","On My Casio Extended Version (Bandcamp Only)"}	7	00:37:00	https://legowelt.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1037	Andrea Cichecki	Drawn Into The Edge Effect	https://andreacichecki.bandcamp.com/album/drawn-into-the-edge-effect?from=discover_page	Dresden, Germany	2025-03-21	https://f4.bcbits.com/img/a2927260791_16.jpg	11.70	{"Allow Me To Escape Time","A Lost Memory","Different Step","The Edge Effect","Connection Between Us","Choosing Paths","A Tale Not Everyone Knows","Naked Animal","Diffused Reflection Of Yourself"}	9	00:38:44	https://andreacichecki.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1038	Kalahari Oyster Cult	A Detroit Summer	https://kalaharioystercult.bandcamp.com/album/a-detroit-summer?from=discover_page	Amsterdam, Netherlands	2025-12-19	https://f4.bcbits.com/img/a3947372329_16.jpg	16.99	{"Who We Are","Sun's Poem","You're Becoming Everything I Hoped You Would","That Feeling Again"}	4	00:32:31	https://kalaharioystercult.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1039	Warrington-Runcorn New Town Development Plan	The Nation''s Most Central Location.	https://warrington-runcorn-cis.bandcamp.com/album/the-nations-most-central-location?from=discover_page	Runcorn, UK	2023-05-19	https://f4.bcbits.com/img/a0448440109_16.jpg	11.70	{"Just Off the M56 (J12)",Rocksavage,"Daresbury Laboratory","London's Moving Our Way","Thelwall Viaduct","Europa Boulevard",Busway,"A Brighter and More Prosperous Future"}	8	00:39:57	https://warrington-runcorn-cis.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1040	Moving Mountains	Pruning of the Lower Limbs	https://movingmountains.bandcamp.com/album/pruning-of-the-lower-limbs?from=discover_page	New York, New York	2025-06-27	https://f4.bcbits.com/img/a3346456081_16.jpg	29.75	{Ghosts,Cars,"Design Ideas","Everyone Is Happy, and Nothing Is Good","All Here",Voices,Houses,"Snow On Norris Street",Blue,"Wedding Clothes"}	10	00:46:24	https://movingmountains.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1041	raster - artistic platform	Contemplating	https://raster-raster.bandcamp.com/album/contemplating?from=discover_page	Germany	2023-09-29	https://f4.bcbits.com/img/a3165354291_16.jpg	18.00	{"Joy 100","Light and Dust",Morphingeist,"Hans Rivers","Dubby Doo","Summer Photons",LoveX,"Autumn Rivers","Trumpets of Andromeda"}	9	00:46:31	https://raster-raster.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1042	Burial	Phoneglow / Eyes Go Blank	https://burial.bandcamp.com/album/phoneglow-eyes-go-blank?from=discover_page	London, UK	2024-06-18	https://f4.bcbits.com/img/a2325395711_16.jpg	17.54	{"Burial - Phoneglow","Kode9 - Eyes Go Blank"}	2	00:14:39	https://burial.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1044	Martin Stürtzer	Circular Oscillations	https://phelios.bandcamp.com/album/circular-oscillations?from=discover_page	Wuppertal, Germany	2023-08-25	https://f4.bcbits.com/img/a0358662478_16.jpg	24.00	{"Circular Oscillations","Underwater Underworld","Forest Dome","Harmonic Motion",Bioluminescence,"Phase Space"}	\N	00:47:50	https://phelios.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1045	Opal Sunn	Elastic – Phases I – III	https://opalsunn.bandcamp.com/album/elastic-phases-i-iii?from=discover_page	Berlin, Germany	2024-12-06	https://f4.bcbits.com/img/a2587020884_16.jpg	17.55	{"Elastic – Phase I","Elastic – Phase II","Elastic – Phase III"}	3	00:23:55	https://opalsunn.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1046	WRWTFWW Records	Interwoven	https://wrwtfww.com/album/interwoven?from=discover_page	Geneva, Switzerland	2026-03-04	https://f4.bcbits.com/img/a0788703705_16.jpg	29.00	{Valleria,"Autumn Has Broken",Veiled,"White Eye",Swift,Penumbra,Susurration,Palinode,"All Bound Up Together"}	9	00:36:52	https://wrwtfww.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1047	Agonis	Mantis 18	https://agonis.bandcamp.com/album/mantis-18?from=discover_page	Zürich, Switzerland	2025-11-14	https://f4.bcbits.com/img/a0002165994_16.jpg	14.00	{"Snow Field Fractals",Kongruenz,"Cloud Roller",Bristle}	4	00:23:20	https://agonis.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1048	Facta	GULP	https://facta.bandcamp.com/album/gulp?from=discover_page	London, UK	2025-06-20	https://f4.bcbits.com/img/a2125084243_16.jpg	21.06	{terminal,BDB,Jets,"Skyline 4",SLoPE,Laguna,settle}	7	00:27:21	https://facta.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1049	Max Cooper	On Being	https://maxcooper.bandcamp.com/album/on-being?from=discover_page	London, UK	2025-02-28	https://f4.bcbits.com/img/a3994509303_16.jpg	42.12	{"On Being feat. Felix Gerbelot","Peace Exists Here","I Am In A Church In Gravesend Listening To Old Vinyl And Drinking Coffee","A Sense Of Getting Closer","I Exist Inside This Machine feat. Aneek Thapar","My Choices Are Not My Own feat. Tawiah","The Sun In A Box","True Under Certain Conditions","When I Sit Alone. In My Thoughts. I Am Crushed feat. Aho Ssan","You Couldn't Love Me Enough And I've Spent My Whole Life Making Up For It feat. Niels Orens","My Mind Is Slipping","Mother Nature Must Have A Different Plan For Me feat. Tom VR","The Missing Piece"}	13	01:15:10	https://maxcooper.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1050	kelly moran	Don''t Trust Mirrors	https://kellymoran.bandcamp.com/album/dont-trust-mirrors?from=discover_page	New York, New York	2025-10-01	https://f4.bcbits.com/img/a0732217010_16.jpg	29.25	{"Echo in the Field","Prism drift","Sans sodalis","Kelly Moran - Don’t Trust Mirrors (ft. Bibio)","Lunar wave",Chrysalis,Systems,Reappearing,"Above the vapours",Cathedral}	10	00:40:30	https://kellymoran.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1051	DiN	Caged (25th Anniversary Edition)	https://din.org.uk/album/caged-25th-anniversary-edition?from=discover_page	Sunderland, UK	2025-11-28	https://f4.bcbits.com/img/a3129981395_16.jpg	33.93	{"Concussed (2025 Remaster)","Coriolis (2025 Remaster)","Slab (2025 Remaster)","Sub-Aura (2025 Remaster)","Disembodied (2025 Remaster)","Caged (2025 Remaster)","Under-dub (2025 Remaster)",Claustrophobia,Uncaged}	9	01:15:03	https://din.org.uk?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1052	Kerrie	Echoes of the Live Wire	https://kerrie-music.bandcamp.com/album/echoes-of-the-live-wire?from=discover_page	Manchester, UK	2025-10-24	https://f4.bcbits.com/img/a3535725510_16.jpg	11.00	{"System Awakens","Live Wire (Zirp Zirp)","Echoes Of","Together In A Rural Place","Moment To Memory",Recircuit,Reclaim}	7	00:34:35	https://kerrie-music.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1053	Fundamental Frequencies	Telepathic Fish: Trawling The Early 90s Ambient Underground	https://fundamentalfrequencies.bandcamp.com/album/telepathic-fish-trawling-the-early-90s-ambient-underground?from=discover_page	London, UK	2025-09-05	https://f4.bcbits.com/img/a2305416703_16.jpg	40.95	{"Barbarella - Barbarella (The Irresistible Force Remix)","Spacetime Continuum - Fluresence","Nightmares On Wax - Nights Interlude","Insides - Skinned Clean","Global Communication - Incidental Harmony","Caustic Window - Cordialatron (VINYL ONLY)","Keiichi Suzuki - Satellite Serenade (Trans Asian Express Mix)","Tranquility Bass - Cantamilla (Bomb Pop)","Golden Girls - Kinetic (Morley’s Apollo Remix)","No-Man - Days In The Trees - Reich"}	10	01:11:19	https://fundamentalfrequencies.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1054	Luke Schneider	For Dancing in Quiet Light	https://lukeschneider.bandcamp.com/album/for-dancing-in-quiet-light?from=discover_page	Nashville, Tennessee	2025-08-22	https://f4.bcbits.com/img/a1667019961_16.jpg	21.25	{"For Dancing In Quiet Light","A Map of Invisible Trails","Where the Wind Left Traces","For Dancing in Quiet Light (coda)"}	4	00:37:08	https://lukeschneider.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1055	Madis	EOL+SOT+POE	https://madis.bandcamp.com/album/eol-sot-poe?from=discover_page	Kraków, Poland	2025-03-28	https://f4.bcbits.com/img/a0427842552_16.jpg	279.00	{"EOL - Place Called Home","EOL - Elements of Life","EOL - Deus Solis","EOL - Continents Movement","EOL - Solar Wind","EOL - Northern Lights","EOL - Lunar Dance","SOT - Sea of Tranquility part 1","SOT - Sea of Tranquility part 2","SOT - Sea of Tranquility part 3","SOT - Carrying the Fire","SOT - Moondust part 1","SOT - Moondust part 2","SOT - Otherside","POE - Matter of Time","POE - Mount Olympus","POE Plains of Elysium","POE - Jezero","POE - Redstorm","POE - Distant Earth","POE - Phobos and Deimos","Elements of Life (Continuous Mix)","Sea of Tranquility (Continuous Mix)","Plains of Elysium (Continuous Mix)"}	24	04:42:17	https://madis.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1056	Cole Pulice	Land''s End Eternal	https://colepulice.bandcamp.com/album/lands-end-eternal?from=discover_page	Oakland, California	2025-05-09	https://f4.bcbits.com/img/a2021106570_16.jpg	21.25	{"Fragments of a Slipstream Dream","In a Hidden Nook Between Worlds I","In a Hidden Nook Between Worlds II","In a Hidden Nook Between Worlds III","In This & Every Life","After the Rain"}	6	00:32:44	https://colepulice.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1057	Brendan Eder	Cape Cod Cottage	https://brendaneder.bandcamp.com/album/cape-cod-cottage?from=discover_page	Los Angeles, California	2021-09-10	https://f4.bcbits.com/img/a1795428329_16.jpg	23.80	{"Tuesday at the Pond","Cape Cod Cottage","Sunlight Through the Leaves","Where Else","New Dreams",Up,"Discovery at the Beach",Three,Theme,Snowing,Retirement,"Your Bliss","Overgrown Garden",Heat,Natalie,"Greeting Visual","Miss Her",Lullaby,"West Coast",Memories,Waltz,Four}	22	00:44:29	https://brendaneder.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1058	raster - artistic platform	Decadent Yet Depraved	https://raster-raster.bandcamp.com/album/decadent-yet-depraved?from=discover_page	Germany	2017-08-25	https://f4.bcbits.com/img/a0501595525_16.jpg	18.00	{"Unnatural Instinct","The Conduit","Submission Of Thought","Slipping Away","No Future","Opium Den",Deliverance,"Fake Disciples","No Hope No Fear","Disembarking Horizon"}	10	00:53:42	https://raster-raster.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1059	ILIAN TAPE	ITX041 - DVLA	https://iliantape.bandcamp.com/album/itx041-dvla?from=discover_page	Munich, Germany	2025-11-27	https://f4.bcbits.com/img/a3017274949_16.jpg	10.00	{E-Style,"The Crawlers Type 2",DVLA,"That Sound"}	4	00:29:00	https://iliantape.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1060	Dopplereffekt	Metasymmetry	https://dopplereffekt.bandcamp.com/album/metasymmetry?from=discover_page	Germany	2025-12-12	https://f4.bcbits.com/img/a3289633196_16.jpg	11.00	{"Time Modulation-Graviton Pulse","Multiverse Wavefunction","Collapse of Simultaneity","Olbers Paradox"}	4	00:24:23	https://dopplereffekt.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1061	M83	Saturdays=Youth	https://ilovem83.bandcamp.com/album/saturdays-youth?from=discover_page	France	2008-04-14	https://f4.bcbits.com/img/a2128461625_16.jpg	33.98	{"You Appearing","Kim & Jessie","Skin Of The Night","Graveyard Girl",Couleurs,Up!,"We Own The Sky","Highway Of Endless Dreams","Too Late","Dark Moves Of Love","Midnight Souls Still Remain"}	11	01:02:16	https://ilovem83.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1062	Barry Walker Jr.	Paleo Sol	https://barrywalker.bandcamp.com/album/paleo-sol?from=discover_page	Portland, Oregon	2026-01-30	https://f4.bcbits.com/img/a1754879491_16.jpg	19.55	{Quiessence,"Son, Don't Brighten The Bear Creek Rhyolite","Leaving Lower Big Basin","A Trip Into Town","Under Leaf Hill","Peridot, Call Me","Sentient Lithosphere","Aether Ore"}	8	00:36:13	https://barrywalker.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1063	Biosphere	Substrata	https://biosphere.bandcamp.com/album/substrata?from=discover_page	Tromsø, Norway	2011-12-01	https://f4.bcbits.com/img/a1535970875_16.jpg	46.23	{"As The Sun Kissed The Horizon","Poa Alpina",Chukhung,"The Things I Tell You","Times When I Know You´ll Be Sad",Hyperborea,Kobresia,Antennaria,Uva-Ursi,"Sphere Of No-Form",Silene,Prologue,"The Silent Orchestra","City Wakes Up",Freeze-frames,Manicure,"The Club",Ballerina,"The Eye Of The Cyclone",Endurium,Laika}	21	02:06:43	https://biosphere.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1064	Kalahari Oyster Cult	MINERAL09	https://kalaharioystercult.bandcamp.com/album/mineral09?from=discover_page	Amsterdam, Netherlands	2025-01-17	https://f4.bcbits.com/img/a0332084180_16.jpg	14.99	{"Stressman - House The Party"}	1	00:05:24	https://kalaharioystercult.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1065	Susumu Yokota	Will (Skintone Edition)	https://susumuyokota.bandcamp.com/album/will-skintone-edition?from=discover_page	Tokyo, Japan	2025-12-05	https://f4.bcbits.com/img/a1894636662_16.jpg	35.10	{"Level 21","Pegasus Man","Alpine Nation","Red Door","Illusion River","Black Sea","Pony Tail","Rabbit Earring","Flower and Butterfly"}	9	00:56:39	https://susumuyokota.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1066	Mammal Hands	Gift from the Trees	https://mammalhands.bandcamp.com/album/gift-from-the-trees?from=discover_page	Norwich, UK	2023-03-31	https://f4.bcbits.com/img/a4009675732_16.jpg	29.24	{"The Spinner",Riser,Nightingale,Kernel,"(Intro) Dimu",Dimu,"Deep within Mountains",Labyrinth,Kai,"Sleeping Bear"}	10	00:49:00	https://mammalhands.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1067	Nous''klaer Audio	Rift	https://nousklaer.bandcamp.com/album/rift?from=discover_page	Rotterdam, Netherlands	2021-11-26	https://f4.bcbits.com/img/a0240232672_16.jpg	30.00	{"Absorption (Citywide)",Submerged,safe-/-sound,"Thunder Road","Cirrus Apparition","Rose Suffix","In time we’ll know","d i a s p a r","Om und Draag (Reduced mix)",Monolith,Velvet,"...in all it's splendor"}	13	01:20:03	https://nousklaer.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1068	ILIAN TAPE	ITX038 - 89! Gloom	https://iliantape.bandcamp.com/album/itx038-89-gloom?from=discover_page	Munich, Germany	2025-05-22	https://f4.bcbits.com/img/a2834472990_16.jpg	10.00	{"Left Hand Path","89! Gloom","Shake And Lurk"}	3	00:14:57	https://iliantape.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1069	Anoushka Shankar	Chapter III: We Return to Light	https://anoushkashankar.bandcamp.com/album/chapter-iii-we-return-to-light?from=discover_page	London, UK	2025-03-14	https://f4.bcbits.com/img/a0133317113_16.jpg	30.00	{Daybreak,Hiraeth,"Dancing on Scorched Earth","We Burn So Brightly",Amrita,"We Return to Love"}	6	00:25:56	https://anoushkashankar.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1070	Mammal Hands	Shadow Work	https://mammalhands.bandcamp.com/album/shadow-work?from=discover_page	Norwich, UK	2017-11-03	https://f4.bcbits.com/img/a0484557308_16.jpg	26.90	{"Black Sails",Wringer,"Boreal Forest","Solitary Bee","Three Good Things","Living Frost",Near/Far,"Straight Up Raining",Transfixed,"Being Here"}	10	00:46:41	https://mammalhands.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1071	Biosphere	The Way of Time	https://biosphere.bandcamp.com/album/the-way-of-time?from=discover_page	Tromsø, Norway	2025-06-20	https://f4.bcbits.com/img/a2005500448_16.jpg	25.74	{"Time Of Man","The Way Of Time","Like The End Of The World","All Stars Have Names","The Old Way Was Gone","The Way Of Time (On And On)"}	6	00:41:39	https://biosphere.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1072	Mutual Rytm	Sweet Dreams	https://mutual-rytm.bandcamp.com/album/sweet-dreams?from=discover_page	Stuttgart, Germany	2025-12-19	https://f4.bcbits.com/img/a1794998027_16.jpg	29.00	{D17,"Sweet Dreams","Hinn Víðförli","State Of Mind (Thomsen 98 Mix)","Glaður Og Reifur","North Of January",Hvarvetna,"Fögur Er Hliðin","101 After Dark","The Dolphin Oracle",Shock,Freefall,Ljósaskiptin,"Deep Sleep","Paradise Lost"}	15	01:17:43	https://mutual-rytm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1073	Congi	Quartz	https://congi.bandcamp.com/album/quartz?from=discover_page	Nottingham, UK	2025-11-21	https://f4.bcbits.com/img/a3868518629_16.jpg	17.54	{Quartz,"Can Be","Burn Feat. Ayaluna","When We Met","Paint Pictures","Beyond This"}	6	00:23:54	https://congi.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1074	Astral Underground	Star Struck Gutz	https://astralunderground.bandcamp.com/album/star-struck-gutz-2?from=discover_page	Enosburg, Vermont	2025-10-15	https://f4.bcbits.com/img/a2260404672_16.jpg	25.50	{"The Hardest Hidden Caravan Ever","City University","Doug and Molly",Magnum,Saba,"Star Struck Gutz","Your Father is/was a Vampire"}	7	00:39:42	https://astralunderground.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1075	Hiroshi Yoshimura	Surround	https://hiroshi-yoshimura.bandcamp.com/album/surround?from=discover_page	Tokyo, Japan	2023-10-06	https://f4.bcbits.com/img/a0958687535_16.jpg	25.50	{"Time after time",Surround,"Something blue","Time forest","Water planet","Green shower"}	6	00:39:52	https://hiroshi-yoshimura.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1076	Bogdan Raczynski	You''re Only Young Once But You Can Be Stupid Forever	https://bogdanraczynski.bandcamp.com/album/youre-only-young-once-but-you-can-be-stupid-forever?from=discover_page		2024-10-18	https://f4.bcbits.com/img/a0961901055_16.jpg	29.25	{gearee,newdiv,fairalign,coughyspns,bangsaft,djstus,hundrecision,zownthram,visionsrevisions,bowgh,fallybli,faq,yewt,shttwobe,sicksicksicks,deweyedair,rew,gauq}	18	00:35:11	https://bogdanraczynski.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1077	Ambient Sans	Music From Alejo	https://ambientsans.bandcamp.com/album/music-from-alejo?from=discover_page	Spain	2026-01-01	https://f4.bcbits.com/img/a2926554720_16.jpg	35.00	{"空に浮かぶ直線 Straight Line Floating in the Sky",Oldfashioned「オールドファッションド」,"あらわれる魚の午後 An Afternoon When Fish Appeared","ミストラル Mistral","アレッホのテーマ Alejo’s Theme"}	5	00:47:42	https://ambientsans.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1078	Steve Hauschildt	Aeropsia	https://stevehauschildt.bandcamp.com/album/aeropsia?from=discover_page	Tbilisi, Georgia	2025-10-17	https://f4.bcbits.com/img/a0115432352_16.jpg	25.99	{"Statue of Verdigris","Your Call is Important",Dividua,"Inertia & Refugia","Forgetting in the Static",Aeropsia,Pyramidal,Slipping,"Amongst Automata"}	9	01:00:11	https://stevehauschildt.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1079	Susumu Yokota	Grinning Cat (Skintone Edition)	https://susumuyokota.bandcamp.com/album/grinning-cat-skintone-edition?from=discover_page	Tokyo, Japan	2025-10-31	https://f4.bcbits.com/img/a1840873226_16.jpg	35.10	{"I Imagine","King Dragonfly","Card Nation","Sleepy Eye","Lapis Lazuli","Balloon in the Cage","Cherry Blossom","Love Bird","Fearful Dream","Tears of a Poet","So Red","Flying Cat","Lost Child"}	13	00:49:18	https://susumuyokota.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1080	Robert Henke / monolake	Hongkong	https://roberthenke.bandcamp.com/album/hongkong-2?from=discover_page	Berlin, Germany	2023-05-26	https://f4.bcbits.com/img/a1007333474_16.jpg	32.00	{Cyan,Index,Lantau,Macao,Arte,Occam,"Mass Transit Railway"}	7	01:08:34	https://roberthenke.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1081	Fluid Electronics	Harvest Time EP (Incl. Deniro Remix)	https://fluidelectronics.bandcamp.com/album/harvest-time-ep-incl-deniro-remix?from=discover_page	Rotterdam, Netherlands	2025-12-12	https://f4.bcbits.com/img/a3822857946_16.jpg	15.00	{"Harvest Time","Harvest Time (Deniro Remix)","Dust Yourself Down",Rhea,MAV}	5	00:33:52	https://fluidelectronics.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1082	Hiroshi Yoshimura	Flora	https://hiroshi-yoshimura.bandcamp.com/album/flora?from=discover_page	Tokyo, Japan	2025-03-20	https://f4.bcbits.com/img/a1781739056_16.jpg	32.30	{"Over The Clover オーバー·ザ·クローバー","Flora フローラ","Asagao アサガオ","Ojigisou オジギソウ","Maple Syrup Factory メイプル·シロップ·ファクトリー","Adelaide アデレード","Wind Echo ウィンド·エコー","Trick Tree トリック·ツリー","Kasumi カスミ","Silence サイレンス","Satie On The Grass サティ·オン·ザ·グラス"}	11	00:58:21	https://hiroshi-yoshimura.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1083	Nous''klaer Audio	Chiral	https://nousklaer.bandcamp.com/album/chiral?from=discover_page	Rotterdam, Netherlands	2023-09-22	https://f4.bcbits.com/img/a2391941583_16.jpg	20.00	{Reverie,"Open Up The Blinds",Demise,"Locked In","Surface Tension","Take Me There",Devotion,"An Inclination","Exit (to Bliss)"}	10	00:56:54	https://nousklaer.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1084	Broken Social Scene	You Forgot It In People	https://brokensocialscene.bandcamp.com/album/you-forgot-it-in-people?from=discover_page	Toronto, Ontario	2003-03-18	https://f4.bcbits.com/img/a1655571252_16.jpg	37.00	{"Capture The Flag","KC Accidental","Stars And Sons","Almost Crimes","Looks Just Like The Sun","Pacific Theme","Anthems For A Seventeen-Year Old Girl",Cause=Time,"Late Nineties Bedroom Rock For The Missionaries","Shampoo Suicide","Lover's Spit","I'm Still Your Fag","Pitter Patter Goes My Heart"}	13	00:56:12	https://brokensocialscene.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1085	Totorro	Sofa So Good	https://totorro.bandcamp.com/album/sofa-so-good?from=discover_page	Rennes, France	2025-10-03	https://f4.bcbits.com/img/a1610756527_16.jpg	29.90	{"Bang Bang","Matthews Bridge","New Music","Destiny's Chives","Sofa So Good","Sensation IRL","Bernard Guez","Bonnet Free Jazz","Smile Paste"}	9	00:39:17	https://totorro.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1086	Hania Rani	Music for Film and Theatre	https://haniarani.bandcamp.com/album/music-for-film-and-theatre?from=discover_page	Warsaw, Poland	2021-06-18	https://f4.bcbits.com/img/a2851210436_16.jpg	25.73	{"Prayer - from xAbo: Father Boniecki","In Between - from xAbo: Father Boniecki","Journey - from xAbo: Father Boniecki","Trip to Ireland - from I Never Cry","The Beach - from I Never Cry","The Locker Room - from I Never Cry","At the Hospital - from I Never Cry","Waiting - from At Home","Wildfires - from Truth in Fire","Ghosts - from Pradziady","Soleil Pâle","Nora - from Nora"}	12	00:38:36	https://haniarani.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1087	Hemelbestormer	The Radiant Veil	https://hemelbestormer.bandcamp.com/album/the-radiant-veil?from=discover_page	Belgium	2025-07-25	https://f4.bcbits.com/img/a3624310830_16.jpg	34.00	{Usil,Turms,Turan,Cel,Tiur,Laran,Tinia,Satre}	8	01:05:38	https://hemelbestormer.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1088	ILIAN TAPE	ISS010 - ISS010	https://iliantape.bandcamp.com/album/iss010-iss010?from=discover_page	Munich, Germany	2024-03-28	https://f4.bcbits.com/img/a3034648281_16.jpg	20.00	{"Dub Schneider",Dachtekker,Matchpoint,"Double Standard","The Bills",Stomp,"Small Stone S700"}	7	00:40:03	https://iliantape.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1089	Nils Frahm	Tripping with Nils Frahm	https://nilsfrahm.bandcamp.com/album/tripping-with-nils-frahm?from=discover_page	Berlin, Germany	2020-12-03	https://f4.bcbits.com/img/a0045084377_16.jpg	29.25	{Enters,Sunson,"Fundamental Values","My Friend The Forest","The Dane","All Melody",#2,"Ode – Our Own Roof"}	8	01:15:57	https://nilsfrahm.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1090	Labyrinthus Stellarum	Tales of the Void	https://labyrinthusstellarum.bandcamp.com/album/tales-of-the-void?from=discover_page	Odesa, Ukraine	2023-03-24	https://f4.bcbits.com/img/a1904392645_16.jpg	42.50	{"Void Dwellers","Nebular Temple","The Eternity","Cosmic Winds","The Birth","Star Chant","Stellar Nursery"}	7	00:42:42	https://labyrinthusstellarum.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1091	INDEX:Records	Luvaphy	https://indexrecords.bandcamp.com/album/luvaphy?from=discover_page	Glasgow, UK	2024-03-29	https://f4.bcbits.com/img/a2386790075_16.jpg	29.25	{Within,Luvaphy,23724,Sued,Lust05,MxB,Lllaao3,Squarpy,Glazed}	9	00:33:45	https://indexrecords.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1092	Geometric Lullaby	あなたの愛	https://geometriclullaby.bandcamp.com/album/--60?from=discover_page	Pittsburgh, Pennsylvania	2025-09-05	https://f4.bcbits.com/img/a2775197138_16.jpg	37.77	{私はあなたのことをいつまでも愛します,手放す,あなたの愛は私の救世主です,私はちょうどあなたを愛したいと思った,あなたの視線で失わ,恋愛中,あなたの夢幻は私の現実である,私は同じように感じることはありません,あなたの愛なしで失われた,ナイトクラブ,あなたの目で}	11	01:17:03	https://geometriclullaby.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1093	Coil	Time Machines	https://coilofficial.bandcamp.com/album/time-machines?from=discover_page	London, UK	2017-09-01	https://f4.bcbits.com/img/a3850597092_16.jpg	33.99	{"7-Methoxy-β-Carboline- (Telepathine)","2,5-Dimethoxy-4-Ethyl-Amphetamine- (DOET-Hecate)","5-Methoxy-N,N-Dimethyl- (5-MeO-DMT)","4-Indolol,3-[2-(Dimethylamino)Ethyl],Phosphate Ester- (Psilocybin)"}	4	01:13:32	https://coilofficial.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1094	Tycho	Dive	https://tycho.bandcamp.com/album/dive?from=discover_page	San Francisco, California	2011-11-15	https://f4.bcbits.com/img/a0978734060_16.jpg	28.90	{"A Walk",Hours,Daydream,Dive,"Coastal Brake",Ascension,Melanine,Adrift,Epigram,Elegy}	10	00:50:42	https://tycho.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1095	Paysage d''Hiver	Die Berge	https://paysagedhiver.bandcamp.com/album/die-berge?from=discover_page		2024-11-08	https://f4.bcbits.com/img/a1309353400_16.jpg	46.74	{Urgrund,Verinnerlichung,"Transzendenz I","Transzendenz II","Transzendenz III",Ausstieg,Gipfel}	7	01:42:51	https://paysagedhiver.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1096	Naibu	Abandon	https://naibu.bandcamp.com/album/abandon?from=discover_page	Paris, France	2026-01-23	https://f4.bcbits.com/img/a1014987973_16.jpg	21.00	{Youth,Concave,Convex,Belong,Martial,Enemy,Warface,Abandon}	11	00:49:53	https://naibu.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1097	Piotr Kurek	Songs and Bodies	https://piotrkurek.bandcamp.com/album/songs-and-bodies?from=discover_page	Warszawa, Poland	2025-09-26	https://f4.bcbits.com/img/a0791659876_16.jpg	24.00	{"Forever / The Way In","It Used to Be a Song","And Yet Through This","More Than One","Nothing Holds Still","Songs and Bodies","Turtle Heart","Try To Be True","The Water Is Wide","This Is Where I Thought You'd Be"}	10	00:42:18	https://piotrkurek.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
1098	Coatshek	Sound Bath	https://coatshek.bandcamp.com/album/sound-bath?from=discover_page	San Francisco, California	2025-08-01	https://f4.bcbits.com/img/a1750210754_16.jpg	17.00	{Softest,Slipping,"The Feelings","Triple Virgo",Labyrinth,"Eternal Lovers","Sound Bath (mixed)"}	7	01:23:00	https://coatshek.bandcamp.com?from=discover_page	2026-02-23 13:22:19.771191	2026-02-23 13:22:19.771191
\.


--
-- Data for Name: vinyl_genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vinyl_genre (id, vinyl_id, genre_id, created_at) FROM stdin;
1	1	1	2026-02-23 13:22:19.538136
2	2	1	2026-02-23 13:22:19.538136
3	2	8	2026-02-23 13:22:19.538136
4	3	1	2026-02-23 13:22:19.538136
5	4	1	2026-02-23 13:22:19.538136
6	4	4	2026-02-23 13:22:19.538136
7	5	1	2026-02-23 13:22:19.538136
8	5	4	2026-02-23 13:22:19.538136
9	6	1	2026-02-23 13:22:19.538136
10	7	1	2026-02-23 13:22:19.538136
11	7	4	2026-02-23 13:22:19.538136
12	7	6	2026-02-23 13:22:19.538136
13	8	1	2026-02-23 13:22:19.538136
14	9	1	2026-02-23 13:22:19.538136
15	10	1	2026-02-23 13:22:19.538136
16	10	2	2026-02-23 13:22:19.538136
17	10	3	2026-02-23 13:22:19.538136
18	10	6	2026-02-23 13:22:19.538136
19	11	1	2026-02-23 13:22:19.538136
20	12	1	2026-02-23 13:22:19.538136
21	12	3	2026-02-23 13:22:19.538136
22	13	1	2026-02-23 13:22:19.538136
23	14	1	2026-02-23 13:22:19.538136
24	14	3	2026-02-23 13:22:19.538136
25	15	1	2026-02-23 13:22:19.538136
26	15	2	2026-02-23 13:22:19.538136
27	15	3	2026-02-23 13:22:19.538136
28	15	4	2026-02-23 13:22:19.538136
29	16	1	2026-02-23 13:22:19.538136
30	17	1	2026-02-23 13:22:19.538136
31	17	4	2026-02-23 13:22:19.538136
32	18	1	2026-02-23 13:22:19.538136
33	18	2	2026-02-23 13:22:19.538136
34	18	4	2026-02-23 13:22:19.538136
35	19	1	2026-02-23 13:22:19.538136
36	19	7	2026-02-23 13:22:19.538136
37	20	1	2026-02-23 13:22:19.538136
38	20	4	2026-02-23 13:22:19.538136
39	21	1	2026-02-23 13:22:19.538136
40	22	1	2026-02-23 13:22:19.538136
41	22	4	2026-02-23 13:22:19.538136
42	23	1	2026-02-23 13:22:19.538136
43	23	3	2026-02-23 13:22:19.538136
44	23	7	2026-02-23 13:22:19.538136
45	23	9	2026-02-23 13:22:19.538136
46	24	1	2026-02-23 13:22:19.538136
47	24	4	2026-02-23 13:22:19.538136
48	25	1	2026-02-23 13:22:19.538136
49	25	3	2026-02-23 13:22:19.538136
50	25	4	2026-02-23 13:22:19.538136
51	25	9	2026-02-23 13:22:19.538136
52	26	1	2026-02-23 13:22:19.538136
53	27	1	2026-02-23 13:22:19.538136
54	27	7	2026-02-23 13:22:19.538136
55	28	1	2026-02-23 13:22:19.538136
56	29	1	2026-02-23 13:22:19.538136
57	29	3	2026-02-23 13:22:19.538136
58	29	4	2026-02-23 13:22:19.538136
59	30	1	2026-02-23 13:22:19.538136
60	31	1	2026-02-23 13:22:19.538136
61	32	1	2026-02-23 13:22:19.538136
62	32	4	2026-02-23 13:22:19.538136
63	33	1	2026-02-23 13:22:19.538136
64	34	1	2026-02-23 13:22:19.538136
65	35	1	2026-02-23 13:22:19.538136
66	35	2	2026-02-23 13:22:19.538136
67	35	6	2026-02-23 13:22:19.538136
68	36	1	2026-02-23 13:22:19.538136
69	37	1	2026-02-23 13:22:19.538136
70	37	4	2026-02-23 13:22:19.538136
71	38	1	2026-02-23 13:22:19.538136
72	39	1	2026-02-23 13:22:19.538136
73	39	4	2026-02-23 13:22:19.538136
74	39	7	2026-02-23 13:22:19.538136
75	40	1	2026-02-23 13:22:19.538136
76	41	1	2026-02-23 13:22:19.538136
77	42	1	2026-02-23 13:22:19.538136
78	42	2	2026-02-23 13:22:19.538136
79	42	6	2026-02-23 13:22:19.538136
80	42	7	2026-02-23 13:22:19.538136
81	43	1	2026-02-23 13:22:19.538136
82	43	5	2026-02-23 13:22:19.538136
83	44	1	2026-02-23 13:22:19.538136
84	44	3	2026-02-23 13:22:19.538136
85	45	1	2026-02-23 13:22:19.538136
86	46	1	2026-02-23 13:22:19.538136
87	46	2	2026-02-23 13:22:19.538136
88	46	3	2026-02-23 13:22:19.538136
89	46	6	2026-02-23 13:22:19.538136
90	47	1	2026-02-23 13:22:19.538136
91	48	1	2026-02-23 13:22:19.538136
92	49	1	2026-02-23 13:22:19.538136
93	50	1	2026-02-23 13:22:19.538136
94	51	1	2026-02-23 13:22:19.538136
95	52	1	2026-02-23 13:22:19.538136
96	52	4	2026-02-23 13:22:19.538136
97	53	1	2026-02-23 13:22:19.538136
98	54	1	2026-02-23 13:22:19.538136
99	55	1	2026-02-23 13:22:19.538136
100	56	1	2026-02-23 13:22:19.538136
101	56	4	2026-02-23 13:22:19.538136
102	56	8	2026-02-23 13:22:19.538136
103	57	1	2026-02-23 13:22:19.538136
104	57	6	2026-02-23 13:22:19.538136
105	58	1	2026-02-23 13:22:19.538136
106	58	2	2026-02-23 13:22:19.538136
107	58	9	2026-02-23 13:22:19.538136
108	59	1	2026-02-23 13:22:19.538136
109	60	1	2026-02-23 13:22:19.538136
110	60	4	2026-02-23 13:22:19.538136
111	61	1	2026-02-23 13:22:19.538136
112	61	3	2026-02-23 13:22:19.538136
113	62	1	2026-02-23 13:22:19.538136
114	63	1	2026-02-23 13:22:19.538136
115	63	3	2026-02-23 13:22:19.538136
116	64	1	2026-02-23 13:22:19.538136
117	64	4	2026-02-23 13:22:19.538136
118	65	1	2026-02-23 13:22:19.538136
119	66	1	2026-02-23 13:22:19.538136
120	66	4	2026-02-23 13:22:19.538136
121	66	7	2026-02-23 13:22:19.538136
122	67	1	2026-02-23 13:22:19.538136
123	68	1	2026-02-23 13:22:19.538136
124	68	4	2026-02-23 13:22:19.538136
125	69	1	2026-02-23 13:22:19.538136
126	70	1	2026-02-23 13:22:19.538136
127	70	7	2026-02-23 13:22:19.538136
128	71	1	2026-02-23 13:22:19.538136
129	72	1	2026-02-23 13:22:19.538136
130	72	4	2026-02-23 13:22:19.538136
131	73	1	2026-02-23 13:22:19.538136
132	73	2	2026-02-23 13:22:19.538136
133	73	6	2026-02-23 13:22:19.538136
134	74	1	2026-02-23 13:22:19.538136
135	75	1	2026-02-23 13:22:19.538136
136	75	6	2026-02-23 13:22:19.538136
137	75	8	2026-02-23 13:22:19.538136
138	76	1	2026-02-23 13:22:19.538136
139	77	1	2026-02-23 13:22:19.538136
140	77	2	2026-02-23 13:22:19.538136
141	77	3	2026-02-23 13:22:19.538136
142	77	4	2026-02-23 13:22:19.538136
143	77	6	2026-02-23 13:22:19.538136
144	78	1	2026-02-23 13:22:19.538136
145	79	1	2026-02-23 13:22:19.538136
146	79	2	2026-02-23 13:22:19.538136
147	79	4	2026-02-23 13:22:19.538136
148	79	8	2026-02-23 13:22:19.538136
149	80	1	2026-02-23 13:22:19.538136
150	80	2	2026-02-23 13:22:19.538136
151	80	3	2026-02-23 13:22:19.538136
152	80	4	2026-02-23 13:22:19.538136
153	80	6	2026-02-23 13:22:19.538136
154	81	1	2026-02-23 13:22:19.538136
155	81	4	2026-02-23 13:22:19.538136
156	82	1	2026-02-23 13:22:19.538136
157	82	4	2026-02-23 13:22:19.538136
158	82	6	2026-02-23 13:22:19.538136
159	82	7	2026-02-23 13:22:19.538136
160	83	1	2026-02-23 13:22:19.538136
161	83	4	2026-02-23 13:22:19.538136
162	83	8	2026-02-23 13:22:19.538136
163	84	1	2026-02-23 13:22:19.538136
164	85	1	2026-02-23 13:22:19.538136
165	85	3	2026-02-23 13:22:19.538136
166	85	9	2026-02-23 13:22:19.538136
167	86	1	2026-02-23 13:22:19.538136
168	86	2	2026-02-23 13:22:19.538136
169	86	3	2026-02-23 13:22:19.538136
170	86	4	2026-02-23 13:22:19.538136
171	86	6	2026-02-23 13:22:19.538136
172	86	7	2026-02-23 13:22:19.538136
173	86	8	2026-02-23 13:22:19.538136
174	87	1	2026-02-23 13:22:19.538136
175	88	1	2026-02-23 13:22:19.538136
176	88	4	2026-02-23 13:22:19.538136
177	88	7	2026-02-23 13:22:19.538136
178	89	1	2026-02-23 13:22:19.538136
179	89	3	2026-02-23 13:22:19.538136
180	89	4	2026-02-23 13:22:19.538136
181	90	1	2026-02-23 13:22:19.538136
182	90	2	2026-02-23 13:22:19.538136
183	90	3	2026-02-23 13:22:19.538136
184	90	4	2026-02-23 13:22:19.538136
185	90	6	2026-02-23 13:22:19.538136
186	91	1	2026-02-23 13:22:19.538136
187	91	2	2026-02-23 13:22:19.538136
188	91	3	2026-02-23 13:22:19.538136
189	91	4	2026-02-23 13:22:19.538136
190	91	6	2026-02-23 13:22:19.538136
191	92	1	2026-02-23 13:22:19.538136
192	93	1	2026-02-23 13:22:19.538136
193	93	4	2026-02-23 13:22:19.538136
194	94	1	2026-02-23 13:22:19.538136
195	95	1	2026-02-23 13:22:19.538136
196	95	2	2026-02-23 13:22:19.538136
197	95	9	2026-02-23 13:22:19.538136
198	96	1	2026-02-23 13:22:19.538136
199	96	7	2026-02-23 13:22:19.538136
200	97	1	2026-02-23 13:22:19.538136
201	98	1	2026-02-23 13:22:19.538136
202	98	6	2026-02-23 13:22:19.538136
203	99	1	2026-02-23 13:22:19.538136
204	100	1	2026-02-23 13:22:19.538136
205	101	1	2026-02-23 13:22:19.567666
206	101	4	2026-02-23 13:22:19.567666
207	101	7	2026-02-23 13:22:19.567666
208	102	1	2026-02-23 13:22:19.567666
209	103	1	2026-02-23 13:22:19.567666
210	103	3	2026-02-23 13:22:19.567666
211	103	4	2026-02-23 13:22:19.567666
212	103	6	2026-02-23 13:22:19.567666
213	103	7	2026-02-23 13:22:19.567666
214	103	8	2026-02-23 13:22:19.567666
215	103	9	2026-02-23 13:22:19.567666
216	104	1	2026-02-23 13:22:19.567666
217	104	8	2026-02-23 13:22:19.567666
218	105	1	2026-02-23 13:22:19.567666
219	105	8	2026-02-23 13:22:19.567666
220	106	1	2026-02-23 13:22:19.567666
221	107	1	2026-02-23 13:22:19.567666
222	108	1	2026-02-23 13:22:19.567666
223	108	4	2026-02-23 13:22:19.567666
224	109	1	2026-02-23 13:22:19.567666
225	109	3	2026-02-23 13:22:19.567666
226	109	4	2026-02-23 13:22:19.567666
227	109	6	2026-02-23 13:22:19.567666
228	109	7	2026-02-23 13:22:19.567666
229	110	1	2026-02-23 13:22:19.567666
230	110	7	2026-02-23 13:22:19.567666
231	111	1	2026-02-23 13:22:19.567666
232	112	1	2026-02-23 13:22:19.567666
233	112	4	2026-02-23 13:22:19.567666
234	113	1	2026-02-23 13:22:19.567666
235	114	1	2026-02-23 13:22:19.567666
236	114	4	2026-02-23 13:22:19.567666
237	115	1	2026-02-23 13:22:19.567666
238	116	1	2026-02-23 13:22:19.567666
239	117	1	2026-02-23 13:22:19.567666
240	118	1	2026-02-23 13:22:19.567666
241	118	3	2026-02-23 13:22:19.567666
242	118	6	2026-02-23 13:22:19.567666
243	118	7	2026-02-23 13:22:19.567666
244	118	8	2026-02-23 13:22:19.567666
245	118	9	2026-02-23 13:22:19.567666
246	119	1	2026-02-23 13:22:19.567666
247	119	3	2026-02-23 13:22:19.567666
248	119	6	2026-02-23 13:22:19.567666
249	120	1	2026-02-23 13:22:19.567666
250	121	1	2026-02-23 13:22:19.567666
251	122	1	2026-02-23 13:22:19.567666
252	123	1	2026-02-23 13:22:19.567666
253	123	6	2026-02-23 13:22:19.567666
254	123	7	2026-02-23 13:22:19.567666
255	124	1	2026-02-23 13:22:19.567666
256	124	6	2026-02-23 13:22:19.567666
257	124	9	2026-02-23 13:22:19.567666
258	125	1	2026-02-23 13:22:19.567666
259	125	3	2026-02-23 13:22:19.567666
260	125	6	2026-02-23 13:22:19.567666
261	126	1	2026-02-23 13:22:19.567666
262	127	1	2026-02-23 13:22:19.567666
263	128	1	2026-02-23 13:22:19.567666
264	129	1	2026-02-23 13:22:19.567666
265	129	6	2026-02-23 13:22:19.567666
266	130	1	2026-02-23 13:22:19.567666
267	131	1	2026-02-23 13:22:19.567666
268	132	1	2026-02-23 13:22:19.567666
269	133	1	2026-02-23 13:22:19.567666
270	133	9	2026-02-23 13:22:19.567666
271	134	1	2026-02-23 13:22:19.567666
272	135	1	2026-02-23 13:22:19.567666
273	136	1	2026-02-23 13:22:19.567666
274	136	3	2026-02-23 13:22:19.567666
275	137	1	2026-02-23 13:22:19.567666
276	137	6	2026-02-23 13:22:19.567666
277	138	1	2026-02-23 13:22:19.567666
278	138	6	2026-02-23 13:22:19.567666
279	139	1	2026-02-23 13:22:19.567666
280	140	1	2026-02-23 13:22:19.567666
281	140	6	2026-02-23 13:22:19.567666
282	141	1	2026-02-23 13:22:19.567666
283	142	1	2026-02-23 13:22:19.567666
284	142	7	2026-02-23 13:22:19.567666
285	143	1	2026-02-23 13:22:19.567666
286	143	3	2026-02-23 13:22:19.567666
287	144	1	2026-02-23 13:22:19.567666
288	145	1	2026-02-23 13:22:19.567666
289	145	3	2026-02-23 13:22:19.567666
290	146	1	2026-02-23 13:22:19.567666
291	147	1	2026-02-23 13:22:19.567666
292	148	2	2026-02-23 13:22:19.567666
293	149	2	2026-02-23 13:22:19.567666
294	149	9	2026-02-23 13:22:19.567666
295	150	2	2026-02-23 13:22:19.567666
296	151	2	2026-02-23 13:22:19.567666
297	151	9	2026-02-23 13:22:19.567666
298	152	2	2026-02-23 13:22:19.567666
299	153	2	2026-02-23 13:22:19.567666
300	154	2	2026-02-23 13:22:19.567666
301	154	8	2026-02-23 13:22:19.567666
302	155	2	2026-02-23 13:22:19.567666
303	155	9	2026-02-23 13:22:19.567666
304	156	2	2026-02-23 13:22:19.567666
305	156	9	2026-02-23 13:22:19.567666
306	157	2	2026-02-23 13:22:19.567666
307	158	2	2026-02-23 13:22:19.567666
308	158	6	2026-02-23 13:22:19.567666
309	158	9	2026-02-23 13:22:19.567666
310	159	2	2026-02-23 13:22:19.567666
311	159	6	2026-02-23 13:22:19.567666
312	160	2	2026-02-23 13:22:19.567666
313	161	2	2026-02-23 13:22:19.567666
314	162	2	2026-02-23 13:22:19.567666
315	162	6	2026-02-23 13:22:19.567666
316	163	2	2026-02-23 13:22:19.567666
317	163	9	2026-02-23 13:22:19.567666
318	164	2	2026-02-23 13:22:19.567666
319	165	2	2026-02-23 13:22:19.567666
320	165	4	2026-02-23 13:22:19.567666
321	166	2	2026-02-23 13:22:19.567666
322	167	2	2026-02-23 13:22:19.567666
323	168	2	2026-02-23 13:22:19.567666
324	169	2	2026-02-23 13:22:19.567666
325	170	2	2026-02-23 13:22:19.567666
326	170	6	2026-02-23 13:22:19.567666
327	170	9	2026-02-23 13:22:19.567666
328	171	2	2026-02-23 13:22:19.567666
329	172	2	2026-02-23 13:22:19.567666
330	173	2	2026-02-23 13:22:19.567666
331	173	9	2026-02-23 13:22:19.567666
332	174	2	2026-02-23 13:22:19.567666
333	174	9	2026-02-23 13:22:19.567666
334	175	2	2026-02-23 13:22:19.567666
335	175	6	2026-02-23 13:22:19.567666
336	175	9	2026-02-23 13:22:19.567666
337	176	2	2026-02-23 13:22:19.567666
338	177	2	2026-02-23 13:22:19.567666
339	177	4	2026-02-23 13:22:19.567666
340	177	6	2026-02-23 13:22:19.567666
341	177	9	2026-02-23 13:22:19.567666
342	178	2	2026-02-23 13:22:19.567666
343	179	2	2026-02-23 13:22:19.567666
344	179	4	2026-02-23 13:22:19.567666
345	180	2	2026-02-23 13:22:19.567666
346	180	9	2026-02-23 13:22:19.567666
347	181	2	2026-02-23 13:22:19.567666
348	182	2	2026-02-23 13:22:19.567666
349	183	2	2026-02-23 13:22:19.567666
350	183	9	2026-02-23 13:22:19.567666
351	184	2	2026-02-23 13:22:19.567666
352	184	6	2026-02-23 13:22:19.567666
353	185	2	2026-02-23 13:22:19.567666
354	185	9	2026-02-23 13:22:19.567666
355	186	2	2026-02-23 13:22:19.567666
356	187	2	2026-02-23 13:22:19.567666
357	187	9	2026-02-23 13:22:19.567666
358	188	2	2026-02-23 13:22:19.567666
359	188	8	2026-02-23 13:22:19.567666
360	189	2	2026-02-23 13:22:19.567666
361	190	2	2026-02-23 13:22:19.567666
362	190	9	2026-02-23 13:22:19.567666
363	191	2	2026-02-23 13:22:19.567666
364	191	3	2026-02-23 13:22:19.567666
365	192	2	2026-02-23 13:22:19.567666
366	193	2	2026-02-23 13:22:19.567666
367	193	6	2026-02-23 13:22:19.567666
368	194	2	2026-02-23 13:22:19.567666
369	195	2	2026-02-23 13:22:19.567666
370	196	2	2026-02-23 13:22:19.567666
371	196	9	2026-02-23 13:22:19.567666
372	197	2	2026-02-23 13:22:19.567666
373	197	6	2026-02-23 13:22:19.567666
374	198	2	2026-02-23 13:22:19.567666
375	198	6	2026-02-23 13:22:19.567666
376	199	2	2026-02-23 13:22:19.567666
377	200	2	2026-02-23 13:22:19.567666
378	201	2	2026-02-23 13:22:19.593737
379	201	9	2026-02-23 13:22:19.593737
380	202	2	2026-02-23 13:22:19.593737
381	202	9	2026-02-23 13:22:19.593737
382	203	2	2026-02-23 13:22:19.593737
383	204	2	2026-02-23 13:22:19.593737
384	204	6	2026-02-23 13:22:19.593737
385	204	9	2026-02-23 13:22:19.593737
386	205	2	2026-02-23 13:22:19.593737
387	206	2	2026-02-23 13:22:19.593737
388	206	6	2026-02-23 13:22:19.593737
389	206	9	2026-02-23 13:22:19.593737
390	207	2	2026-02-23 13:22:19.593737
391	207	9	2026-02-23 13:22:19.593737
392	208	2	2026-02-23 13:22:19.593737
393	208	9	2026-02-23 13:22:19.593737
394	209	2	2026-02-23 13:22:19.593737
395	210	2	2026-02-23 13:22:19.593737
396	211	2	2026-02-23 13:22:19.593737
397	211	5	2026-02-23 13:22:19.593737
398	212	2	2026-02-23 13:22:19.593737
399	213	2	2026-02-23 13:22:19.593737
400	214	2	2026-02-23 13:22:19.593737
401	215	2	2026-02-23 13:22:19.593737
402	216	2	2026-02-23 13:22:19.593737
403	216	9	2026-02-23 13:22:19.593737
404	217	2	2026-02-23 13:22:19.593737
405	218	2	2026-02-23 13:22:19.593737
406	218	4	2026-02-23 13:22:19.593737
407	219	2	2026-02-23 13:22:19.593737
408	219	9	2026-02-23 13:22:19.593737
409	220	2	2026-02-23 13:22:19.593737
410	221	2	2026-02-23 13:22:19.593737
411	221	9	2026-02-23 13:22:19.593737
412	222	2	2026-02-23 13:22:19.593737
413	223	2	2026-02-23 13:22:19.593737
414	223	9	2026-02-23 13:22:19.593737
415	224	2	2026-02-23 13:22:19.593737
416	224	6	2026-02-23 13:22:19.593737
417	225	2	2026-02-23 13:22:19.593737
418	226	2	2026-02-23 13:22:19.593737
419	227	2	2026-02-23 13:22:19.593737
420	228	2	2026-02-23 13:22:19.593737
421	229	2	2026-02-23 13:22:19.593737
422	230	2	2026-02-23 13:22:19.593737
423	230	9	2026-02-23 13:22:19.593737
424	231	2	2026-02-23 13:22:19.593737
425	231	6	2026-02-23 13:22:19.593737
426	232	2	2026-02-23 13:22:19.593737
427	233	2	2026-02-23 13:22:19.593737
428	234	2	2026-02-23 13:22:19.593737
429	235	2	2026-02-23 13:22:19.593737
430	236	2	2026-02-23 13:22:19.593737
431	237	2	2026-02-23 13:22:19.593737
432	237	9	2026-02-23 13:22:19.593737
433	238	2	2026-02-23 13:22:19.593737
434	239	2	2026-02-23 13:22:19.593737
435	240	2	2026-02-23 13:22:19.593737
436	241	2	2026-02-23 13:22:19.593737
437	242	2	2026-02-23 13:22:19.593737
438	242	9	2026-02-23 13:22:19.593737
439	243	2	2026-02-23 13:22:19.593737
440	243	4	2026-02-23 13:22:19.593737
441	243	9	2026-02-23 13:22:19.593737
442	244	2	2026-02-23 13:22:19.593737
443	244	9	2026-02-23 13:22:19.593737
444	245	2	2026-02-23 13:22:19.593737
445	246	2	2026-02-23 13:22:19.593737
446	247	2	2026-02-23 13:22:19.593737
447	247	4	2026-02-23 13:22:19.593737
448	248	2	2026-02-23 13:22:19.593737
449	249	2	2026-02-23 13:22:19.593737
450	250	2	2026-02-23 13:22:19.593737
451	251	2	2026-02-23 13:22:19.593737
452	251	6	2026-02-23 13:22:19.593737
453	251	9	2026-02-23 13:22:19.593737
454	252	2	2026-02-23 13:22:19.593737
455	252	9	2026-02-23 13:22:19.593737
456	253	2	2026-02-23 13:22:19.593737
457	253	9	2026-02-23 13:22:19.593737
458	254	2	2026-02-23 13:22:19.593737
459	255	2	2026-02-23 13:22:19.593737
460	255	6	2026-02-23 13:22:19.593737
461	256	2	2026-02-23 13:22:19.593737
462	257	2	2026-02-23 13:22:19.593737
463	257	8	2026-02-23 13:22:19.593737
464	257	9	2026-02-23 13:22:19.593737
465	258	2	2026-02-23 13:22:19.593737
466	258	9	2026-02-23 13:22:19.593737
467	259	2	2026-02-23 13:22:19.593737
468	259	9	2026-02-23 13:22:19.593737
469	260	2	2026-02-23 13:22:19.593737
470	260	6	2026-02-23 13:22:19.593737
471	260	9	2026-02-23 13:22:19.593737
472	261	2	2026-02-23 13:22:19.593737
473	262	2	2026-02-23 13:22:19.593737
474	262	6	2026-02-23 13:22:19.593737
475	262	9	2026-02-23 13:22:19.593737
476	263	2	2026-02-23 13:22:19.593737
477	263	6	2026-02-23 13:22:19.593737
478	263	9	2026-02-23 13:22:19.593737
479	264	2	2026-02-23 13:22:19.593737
480	265	2	2026-02-23 13:22:19.593737
481	266	2	2026-02-23 13:22:19.593737
482	266	6	2026-02-23 13:22:19.593737
483	267	2	2026-02-23 13:22:19.593737
484	268	2	2026-02-23 13:22:19.593737
485	269	2	2026-02-23 13:22:19.593737
486	269	6	2026-02-23 13:22:19.593737
487	270	2	2026-02-23 13:22:19.593737
488	271	2	2026-02-23 13:22:19.593737
489	272	2	2026-02-23 13:22:19.593737
490	273	2	2026-02-23 13:22:19.593737
491	274	2	2026-02-23 13:22:19.593737
492	275	2	2026-02-23 13:22:19.593737
493	276	2	2026-02-23 13:22:19.593737
494	276	6	2026-02-23 13:22:19.593737
495	276	7	2026-02-23 13:22:19.593737
496	277	2	2026-02-23 13:22:19.593737
497	278	2	2026-02-23 13:22:19.593737
498	278	9	2026-02-23 13:22:19.593737
499	279	2	2026-02-23 13:22:19.593737
500	280	2	2026-02-23 13:22:19.593737
501	281	2	2026-02-23 13:22:19.593737
502	281	4	2026-02-23 13:22:19.593737
503	281	9	2026-02-23 13:22:19.593737
504	282	2	2026-02-23 13:22:19.593737
505	282	4	2026-02-23 13:22:19.593737
506	283	2	2026-02-23 13:22:19.593737
507	283	6	2026-02-23 13:22:19.593737
508	284	2	2026-02-23 13:22:19.593737
509	285	2	2026-02-23 13:22:19.593737
510	286	2	2026-02-23 13:22:19.593737
511	287	2	2026-02-23 13:22:19.593737
512	288	2	2026-02-23 13:22:19.593737
513	289	2	2026-02-23 13:22:19.593737
514	289	9	2026-02-23 13:22:19.593737
515	290	2	2026-02-23 13:22:19.593737
516	291	2	2026-02-23 13:22:19.593737
517	292	2	2026-02-23 13:22:19.593737
518	292	4	2026-02-23 13:22:19.593737
519	293	2	2026-02-23 13:22:19.593737
520	293	4	2026-02-23 13:22:19.593737
521	293	6	2026-02-23 13:22:19.593737
522	294	2	2026-02-23 13:22:19.593737
523	295	2	2026-02-23 13:22:19.593737
524	296	2	2026-02-23 13:22:19.593737
525	296	6	2026-02-23 13:22:19.593737
526	297	2	2026-02-23 13:22:19.593737
527	297	4	2026-02-23 13:22:19.593737
528	297	9	2026-02-23 13:22:19.593737
529	298	2	2026-02-23 13:22:19.593737
530	299	2	2026-02-23 13:22:19.593737
531	300	2	2026-02-23 13:22:19.593737
532	301	2	2026-02-23 13:22:19.617157
533	301	6	2026-02-23 13:22:19.617157
534	301	9	2026-02-23 13:22:19.617157
535	302	2	2026-02-23 13:22:19.617157
536	303	2	2026-02-23 13:22:19.617157
537	303	6	2026-02-23 13:22:19.617157
538	303	9	2026-02-23 13:22:19.617157
539	304	2	2026-02-23 13:22:19.617157
540	305	2	2026-02-23 13:22:19.617157
541	306	2	2026-02-23 13:22:19.617157
542	306	4	2026-02-23 13:22:19.617157
543	306	9	2026-02-23 13:22:19.617157
544	307	2	2026-02-23 13:22:19.617157
545	308	2	2026-02-23 13:22:19.617157
546	309	2	2026-02-23 13:22:19.617157
547	310	2	2026-02-23 13:22:19.617157
548	310	6	2026-02-23 13:22:19.617157
549	311	2	2026-02-23 13:22:19.617157
550	312	2	2026-02-23 13:22:19.617157
551	312	6	2026-02-23 13:22:19.617157
552	313	2	2026-02-23 13:22:19.617157
553	313	6	2026-02-23 13:22:19.617157
554	314	2	2026-02-23 13:22:19.617157
555	314	6	2026-02-23 13:22:19.617157
556	314	9	2026-02-23 13:22:19.617157
557	315	2	2026-02-23 13:22:19.617157
558	316	2	2026-02-23 13:22:19.617157
559	317	2	2026-02-23 13:22:19.617157
560	318	3	2026-02-23 13:22:19.617157
561	318	4	2026-02-23 13:22:19.617157
562	318	6	2026-02-23 13:22:19.617157
563	319	3	2026-02-23 13:22:19.617157
564	320	3	2026-02-23 13:22:19.617157
565	321	3	2026-02-23 13:22:19.617157
566	321	7	2026-02-23 13:22:19.617157
567	322	3	2026-02-23 13:22:19.617157
568	322	6	2026-02-23 13:22:19.617157
569	323	3	2026-02-23 13:22:19.617157
570	323	7	2026-02-23 13:22:19.617157
571	324	3	2026-02-23 13:22:19.617157
572	324	6	2026-02-23 13:22:19.617157
573	325	3	2026-02-23 13:22:19.617157
574	326	3	2026-02-23 13:22:19.617157
575	327	3	2026-02-23 13:22:19.617157
576	327	4	2026-02-23 13:22:19.617157
577	327	7	2026-02-23 13:22:19.617157
578	328	3	2026-02-23 13:22:19.617157
579	329	3	2026-02-23 13:22:19.617157
580	330	3	2026-02-23 13:22:19.617157
581	331	3	2026-02-23 13:22:19.617157
582	332	3	2026-02-23 13:22:19.617157
583	333	3	2026-02-23 13:22:19.617157
584	333	6	2026-02-23 13:22:19.617157
585	334	3	2026-02-23 13:22:19.617157
586	335	3	2026-02-23 13:22:19.617157
587	335	7	2026-02-23 13:22:19.617157
588	336	3	2026-02-23 13:22:19.617157
589	336	9	2026-02-23 13:22:19.617157
590	337	3	2026-02-23 13:22:19.617157
591	338	3	2026-02-23 13:22:19.617157
592	338	4	2026-02-23 13:22:19.617157
593	338	7	2026-02-23 13:22:19.617157
594	339	3	2026-02-23 13:22:19.617157
595	340	3	2026-02-23 13:22:19.617157
596	341	3	2026-02-23 13:22:19.617157
597	342	3	2026-02-23 13:22:19.617157
598	343	3	2026-02-23 13:22:19.617157
599	343	6	2026-02-23 13:22:19.617157
600	344	3	2026-02-23 13:22:19.617157
601	345	3	2026-02-23 13:22:19.617157
602	346	3	2026-02-23 13:22:19.617157
603	347	3	2026-02-23 13:22:19.617157
604	348	3	2026-02-23 13:22:19.617157
605	349	3	2026-02-23 13:22:19.617157
606	350	3	2026-02-23 13:22:19.617157
607	351	3	2026-02-23 13:22:19.617157
608	352	3	2026-02-23 13:22:19.617157
609	353	3	2026-02-23 13:22:19.617157
610	354	3	2026-02-23 13:22:19.617157
611	355	3	2026-02-23 13:22:19.617157
612	356	3	2026-02-23 13:22:19.617157
613	357	3	2026-02-23 13:22:19.617157
614	358	3	2026-02-23 13:22:19.617157
615	359	3	2026-02-23 13:22:19.617157
616	360	3	2026-02-23 13:22:19.617157
617	361	3	2026-02-23 13:22:19.617157
618	362	3	2026-02-23 13:22:19.617157
619	363	3	2026-02-23 13:22:19.617157
620	364	3	2026-02-23 13:22:19.617157
621	365	3	2026-02-23 13:22:19.617157
622	366	3	2026-02-23 13:22:19.617157
623	367	3	2026-02-23 13:22:19.617157
624	368	3	2026-02-23 13:22:19.617157
625	369	3	2026-02-23 13:22:19.617157
626	370	3	2026-02-23 13:22:19.617157
627	371	3	2026-02-23 13:22:19.617157
628	372	3	2026-02-23 13:22:19.617157
629	373	3	2026-02-23 13:22:19.617157
630	374	3	2026-02-23 13:22:19.617157
631	375	3	2026-02-23 13:22:19.617157
632	376	3	2026-02-23 13:22:19.617157
633	377	3	2026-02-23 13:22:19.617157
634	378	3	2026-02-23 13:22:19.617157
635	379	3	2026-02-23 13:22:19.617157
636	380	3	2026-02-23 13:22:19.617157
637	381	3	2026-02-23 13:22:19.617157
638	382	3	2026-02-23 13:22:19.617157
639	383	3	2026-02-23 13:22:19.617157
640	384	3	2026-02-23 13:22:19.617157
641	385	3	2026-02-23 13:22:19.617157
642	386	3	2026-02-23 13:22:19.617157
643	387	3	2026-02-23 13:22:19.617157
644	388	3	2026-02-23 13:22:19.617157
645	389	3	2026-02-23 13:22:19.617157
646	390	3	2026-02-23 13:22:19.617157
647	391	3	2026-02-23 13:22:19.617157
648	392	3	2026-02-23 13:22:19.617157
649	393	3	2026-02-23 13:22:19.617157
650	394	3	2026-02-23 13:22:19.617157
651	395	3	2026-02-23 13:22:19.617157
652	396	3	2026-02-23 13:22:19.617157
653	397	3	2026-02-23 13:22:19.617157
654	398	3	2026-02-23 13:22:19.617157
655	399	3	2026-02-23 13:22:19.617157
656	400	3	2026-02-23 13:22:19.617157
657	401	3	2026-02-23 13:22:19.639272
658	402	3	2026-02-23 13:22:19.639272
659	403	3	2026-02-23 13:22:19.639272
660	404	3	2026-02-23 13:22:19.639272
661	405	3	2026-02-23 13:22:19.639272
662	405	7	2026-02-23 13:22:19.639272
663	406	3	2026-02-23 13:22:19.639272
664	407	3	2026-02-23 13:22:19.639272
665	408	3	2026-02-23 13:22:19.639272
666	409	3	2026-02-23 13:22:19.639272
667	410	3	2026-02-23 13:22:19.639272
668	410	7	2026-02-23 13:22:19.639272
669	411	3	2026-02-23 13:22:19.639272
670	412	3	2026-02-23 13:22:19.639272
671	413	3	2026-02-23 13:22:19.639272
672	414	3	2026-02-23 13:22:19.639272
673	415	3	2026-02-23 13:22:19.639272
674	415	6	2026-02-23 13:22:19.639272
675	416	3	2026-02-23 13:22:19.639272
676	417	3	2026-02-23 13:22:19.639272
677	418	3	2026-02-23 13:22:19.639272
678	419	3	2026-02-23 13:22:19.639272
679	420	3	2026-02-23 13:22:19.639272
680	421	3	2026-02-23 13:22:19.639272
681	422	3	2026-02-23 13:22:19.639272
682	423	3	2026-02-23 13:22:19.639272
683	424	3	2026-02-23 13:22:19.639272
684	425	3	2026-02-23 13:22:19.639272
685	426	3	2026-02-23 13:22:19.639272
686	427	3	2026-02-23 13:22:19.639272
687	428	3	2026-02-23 13:22:19.639272
688	429	3	2026-02-23 13:22:19.639272
689	430	4	2026-02-23 13:22:19.639272
690	431	4	2026-02-23 13:22:19.639272
691	432	4	2026-02-23 13:22:19.639272
692	433	4	2026-02-23 13:22:19.639272
693	434	4	2026-02-23 13:22:19.639272
694	435	4	2026-02-23 13:22:19.639272
695	436	4	2026-02-23 13:22:19.639272
696	437	4	2026-02-23 13:22:19.639272
697	438	4	2026-02-23 13:22:19.639272
698	439	4	2026-02-23 13:22:19.639272
699	440	4	2026-02-23 13:22:19.639272
700	440	6	2026-02-23 13:22:19.639272
701	441	4	2026-02-23 13:22:19.639272
702	442	4	2026-02-23 13:22:19.639272
703	443	4	2026-02-23 13:22:19.639272
704	444	4	2026-02-23 13:22:19.639272
705	445	4	2026-02-23 13:22:19.639272
706	446	4	2026-02-23 13:22:19.639272
707	446	8	2026-02-23 13:22:19.639272
708	447	4	2026-02-23 13:22:19.639272
709	447	7	2026-02-23 13:22:19.639272
710	448	4	2026-02-23 13:22:19.639272
711	449	4	2026-02-23 13:22:19.639272
712	450	4	2026-02-23 13:22:19.639272
713	450	6	2026-02-23 13:22:19.639272
714	450	9	2026-02-23 13:22:19.639272
715	451	4	2026-02-23 13:22:19.639272
716	452	4	2026-02-23 13:22:19.639272
717	453	4	2026-02-23 13:22:19.639272
718	453	6	2026-02-23 13:22:19.639272
719	454	4	2026-02-23 13:22:19.639272
720	454	8	2026-02-23 13:22:19.639272
721	455	4	2026-02-23 13:22:19.639272
722	456	4	2026-02-23 13:22:19.639272
723	457	4	2026-02-23 13:22:19.639272
724	457	6	2026-02-23 13:22:19.639272
725	458	4	2026-02-23 13:22:19.639272
726	459	4	2026-02-23 13:22:19.639272
727	459	7	2026-02-23 13:22:19.639272
728	460	4	2026-02-23 13:22:19.639272
729	461	4	2026-02-23 13:22:19.639272
730	462	4	2026-02-23 13:22:19.639272
731	462	9	2026-02-23 13:22:19.639272
732	463	4	2026-02-23 13:22:19.639272
733	464	4	2026-02-23 13:22:19.639272
734	465	4	2026-02-23 13:22:19.639272
735	466	4	2026-02-23 13:22:19.639272
736	467	4	2026-02-23 13:22:19.639272
737	468	4	2026-02-23 13:22:19.639272
738	469	4	2026-02-23 13:22:19.639272
739	470	4	2026-02-23 13:22:19.639272
740	470	6	2026-02-23 13:22:19.639272
741	470	7	2026-02-23 13:22:19.639272
742	471	4	2026-02-23 13:22:19.639272
743	472	4	2026-02-23 13:22:19.639272
744	473	4	2026-02-23 13:22:19.639272
745	474	4	2026-02-23 13:22:19.639272
746	475	4	2026-02-23 13:22:19.639272
747	476	4	2026-02-23 13:22:19.639272
748	477	4	2026-02-23 13:22:19.639272
749	477	7	2026-02-23 13:22:19.639272
750	478	4	2026-02-23 13:22:19.639272
751	479	4	2026-02-23 13:22:19.639272
752	480	4	2026-02-23 13:22:19.639272
753	481	4	2026-02-23 13:22:19.639272
754	481	7	2026-02-23 13:22:19.639272
755	482	4	2026-02-23 13:22:19.639272
756	483	4	2026-02-23 13:22:19.639272
757	484	4	2026-02-23 13:22:19.639272
758	484	9	2026-02-23 13:22:19.639272
759	485	4	2026-02-23 13:22:19.639272
760	486	4	2026-02-23 13:22:19.639272
761	487	4	2026-02-23 13:22:19.639272
762	488	4	2026-02-23 13:22:19.639272
763	489	4	2026-02-23 13:22:19.639272
764	490	4	2026-02-23 13:22:19.639272
765	490	9	2026-02-23 13:22:19.639272
766	491	4	2026-02-23 13:22:19.639272
767	492	4	2026-02-23 13:22:19.639272
768	493	4	2026-02-23 13:22:19.639272
769	494	4	2026-02-23 13:22:19.639272
770	494	8	2026-02-23 13:22:19.639272
771	495	4	2026-02-23 13:22:19.639272
772	495	7	2026-02-23 13:22:19.639272
773	496	4	2026-02-23 13:22:19.639272
774	497	4	2026-02-23 13:22:19.639272
775	497	7	2026-02-23 13:22:19.639272
776	498	4	2026-02-23 13:22:19.639272
777	499	4	2026-02-23 13:22:19.639272
778	500	4	2026-02-23 13:22:19.639272
779	501	4	2026-02-23 13:22:19.661536
780	502	4	2026-02-23 13:22:19.661536
781	503	4	2026-02-23 13:22:19.661536
782	504	4	2026-02-23 13:22:19.661536
783	505	4	2026-02-23 13:22:19.661536
784	506	4	2026-02-23 13:22:19.661536
785	506	6	2026-02-23 13:22:19.661536
786	506	9	2026-02-23 13:22:19.661536
787	507	4	2026-02-23 13:22:19.661536
788	508	4	2026-02-23 13:22:19.661536
789	508	9	2026-02-23 13:22:19.661536
790	509	4	2026-02-23 13:22:19.661536
791	510	4	2026-02-23 13:22:19.661536
792	511	4	2026-02-23 13:22:19.661536
793	512	4	2026-02-23 13:22:19.661536
794	512	8	2026-02-23 13:22:19.661536
795	513	4	2026-02-23 13:22:19.661536
796	513	8	2026-02-23 13:22:19.661536
797	514	4	2026-02-23 13:22:19.661536
798	515	4	2026-02-23 13:22:19.661536
799	516	4	2026-02-23 13:22:19.661536
800	517	4	2026-02-23 13:22:19.661536
801	518	4	2026-02-23 13:22:19.661536
802	519	4	2026-02-23 13:22:19.661536
803	520	4	2026-02-23 13:22:19.661536
804	521	4	2026-02-23 13:22:19.661536
805	522	4	2026-02-23 13:22:19.661536
806	523	4	2026-02-23 13:22:19.661536
807	524	5	2026-02-23 13:22:19.661536
808	525	5	2026-02-23 13:22:19.661536
809	526	5	2026-02-23 13:22:19.661536
810	527	5	2026-02-23 13:22:19.661536
811	528	5	2026-02-23 13:22:19.661536
812	529	5	2026-02-23 13:22:19.661536
813	530	5	2026-02-23 13:22:19.661536
814	531	5	2026-02-23 13:22:19.661536
815	532	5	2026-02-23 13:22:19.661536
816	533	5	2026-02-23 13:22:19.661536
817	534	5	2026-02-23 13:22:19.661536
818	535	5	2026-02-23 13:22:19.661536
819	536	5	2026-02-23 13:22:19.661536
820	537	5	2026-02-23 13:22:19.661536
821	538	5	2026-02-23 13:22:19.661536
822	539	5	2026-02-23 13:22:19.661536
823	539	7	2026-02-23 13:22:19.661536
824	540	5	2026-02-23 13:22:19.661536
825	541	5	2026-02-23 13:22:19.661536
826	542	5	2026-02-23 13:22:19.661536
827	543	5	2026-02-23 13:22:19.661536
828	544	5	2026-02-23 13:22:19.661536
829	545	5	2026-02-23 13:22:19.661536
830	545	6	2026-02-23 13:22:19.661536
831	545	7	2026-02-23 13:22:19.661536
832	546	5	2026-02-23 13:22:19.661536
833	546	7	2026-02-23 13:22:19.661536
834	547	5	2026-02-23 13:22:19.661536
835	548	5	2026-02-23 13:22:19.661536
836	549	5	2026-02-23 13:22:19.661536
837	550	5	2026-02-23 13:22:19.661536
838	551	5	2026-02-23 13:22:19.661536
839	552	5	2026-02-23 13:22:19.661536
840	553	5	2026-02-23 13:22:19.661536
841	554	5	2026-02-23 13:22:19.661536
842	555	5	2026-02-23 13:22:19.661536
843	556	5	2026-02-23 13:22:19.661536
844	556	7	2026-02-23 13:22:19.661536
845	557	5	2026-02-23 13:22:19.661536
846	558	5	2026-02-23 13:22:19.661536
847	559	5	2026-02-23 13:22:19.661536
848	560	5	2026-02-23 13:22:19.661536
849	561	5	2026-02-23 13:22:19.661536
850	562	5	2026-02-23 13:22:19.661536
851	563	5	2026-02-23 13:22:19.661536
852	564	5	2026-02-23 13:22:19.661536
853	565	5	2026-02-23 13:22:19.661536
854	565	6	2026-02-23 13:22:19.661536
855	566	5	2026-02-23 13:22:19.661536
856	567	5	2026-02-23 13:22:19.661536
857	568	5	2026-02-23 13:22:19.661536
858	569	5	2026-02-23 13:22:19.661536
859	570	5	2026-02-23 13:22:19.661536
860	571	5	2026-02-23 13:22:19.661536
861	572	5	2026-02-23 13:22:19.661536
862	573	5	2026-02-23 13:22:19.661536
863	574	5	2026-02-23 13:22:19.661536
864	575	5	2026-02-23 13:22:19.661536
865	576	5	2026-02-23 13:22:19.661536
866	577	5	2026-02-23 13:22:19.661536
867	578	5	2026-02-23 13:22:19.661536
868	579	5	2026-02-23 13:22:19.661536
869	580	5	2026-02-23 13:22:19.661536
870	581	5	2026-02-23 13:22:19.661536
871	582	5	2026-02-23 13:22:19.661536
872	583	5	2026-02-23 13:22:19.661536
873	584	5	2026-02-23 13:22:19.661536
874	585	5	2026-02-23 13:22:19.661536
875	586	5	2026-02-23 13:22:19.661536
876	587	5	2026-02-23 13:22:19.661536
877	588	5	2026-02-23 13:22:19.661536
878	589	5	2026-02-23 13:22:19.661536
879	590	5	2026-02-23 13:22:19.661536
880	591	5	2026-02-23 13:22:19.661536
881	592	5	2026-02-23 13:22:19.661536
882	593	5	2026-02-23 13:22:19.661536
883	594	5	2026-02-23 13:22:19.661536
884	595	5	2026-02-23 13:22:19.661536
885	596	5	2026-02-23 13:22:19.661536
886	597	5	2026-02-23 13:22:19.661536
887	598	5	2026-02-23 13:22:19.661536
888	599	5	2026-02-23 13:22:19.661536
889	600	5	2026-02-23 13:22:19.661536
890	601	5	2026-02-23 13:22:19.685369
891	602	5	2026-02-23 13:22:19.685369
892	603	5	2026-02-23 13:22:19.685369
893	604	5	2026-02-23 13:22:19.685369
894	605	5	2026-02-23 13:22:19.685369
895	606	5	2026-02-23 13:22:19.685369
896	607	5	2026-02-23 13:22:19.685369
897	608	5	2026-02-23 13:22:19.685369
898	609	5	2026-02-23 13:22:19.685369
899	610	5	2026-02-23 13:22:19.685369
900	611	5	2026-02-23 13:22:19.685369
901	612	5	2026-02-23 13:22:19.685369
902	613	5	2026-02-23 13:22:19.685369
903	614	5	2026-02-23 13:22:19.685369
904	615	5	2026-02-23 13:22:19.685369
905	616	5	2026-02-23 13:22:19.685369
906	617	5	2026-02-23 13:22:19.685369
907	618	5	2026-02-23 13:22:19.685369
908	619	5	2026-02-23 13:22:19.685369
909	620	5	2026-02-23 13:22:19.685369
910	621	5	2026-02-23 13:22:19.685369
911	622	5	2026-02-23 13:22:19.685369
912	623	5	2026-02-23 13:22:19.685369
913	624	5	2026-02-23 13:22:19.685369
914	625	5	2026-02-23 13:22:19.685369
915	626	5	2026-02-23 13:22:19.685369
916	627	5	2026-02-23 13:22:19.685369
917	628	5	2026-02-23 13:22:19.685369
918	629	5	2026-02-23 13:22:19.685369
919	630	5	2026-02-23 13:22:19.685369
920	631	5	2026-02-23 13:22:19.685369
921	632	5	2026-02-23 13:22:19.685369
922	633	5	2026-02-23 13:22:19.685369
923	634	5	2026-02-23 13:22:19.685369
924	635	5	2026-02-23 13:22:19.685369
925	636	5	2026-02-23 13:22:19.685369
926	637	5	2026-02-23 13:22:19.685369
927	638	5	2026-02-23 13:22:19.685369
928	639	5	2026-02-23 13:22:19.685369
929	640	5	2026-02-23 13:22:19.685369
930	641	5	2026-02-23 13:22:19.685369
931	642	5	2026-02-23 13:22:19.685369
932	643	5	2026-02-23 13:22:19.685369
933	644	5	2026-02-23 13:22:19.685369
934	645	5	2026-02-23 13:22:19.685369
935	646	5	2026-02-23 13:22:19.685369
936	647	5	2026-02-23 13:22:19.685369
937	648	5	2026-02-23 13:22:19.685369
938	649	5	2026-02-23 13:22:19.685369
939	650	5	2026-02-23 13:22:19.685369
940	651	5	2026-02-23 13:22:19.685369
941	652	5	2026-02-23 13:22:19.685369
942	653	5	2026-02-23 13:22:19.685369
943	654	5	2026-02-23 13:22:19.685369
944	655	5	2026-02-23 13:22:19.685369
945	656	5	2026-02-23 13:22:19.685369
946	657	5	2026-02-23 13:22:19.685369
947	658	5	2026-02-23 13:22:19.685369
948	659	5	2026-02-23 13:22:19.685369
949	660	5	2026-02-23 13:22:19.685369
950	661	5	2026-02-23 13:22:19.685369
951	662	5	2026-02-23 13:22:19.685369
952	663	5	2026-02-23 13:22:19.685369
953	664	5	2026-02-23 13:22:19.685369
954	665	5	2026-02-23 13:22:19.685369
955	666	5	2026-02-23 13:22:19.685369
956	667	5	2026-02-23 13:22:19.685369
957	668	5	2026-02-23 13:22:19.685369
958	669	5	2026-02-23 13:22:19.685369
959	670	5	2026-02-23 13:22:19.685369
960	671	5	2026-02-23 13:22:19.685369
961	672	5	2026-02-23 13:22:19.685369
962	673	5	2026-02-23 13:22:19.685369
963	674	5	2026-02-23 13:22:19.685369
964	675	5	2026-02-23 13:22:19.685369
965	676	5	2026-02-23 13:22:19.685369
966	677	5	2026-02-23 13:22:19.685369
967	678	5	2026-02-23 13:22:19.685369
968	679	5	2026-02-23 13:22:19.685369
969	680	5	2026-02-23 13:22:19.685369
970	681	5	2026-02-23 13:22:19.685369
971	682	5	2026-02-23 13:22:19.685369
972	683	5	2026-02-23 13:22:19.685369
973	684	5	2026-02-23 13:22:19.685369
974	685	5	2026-02-23 13:22:19.685369
975	686	5	2026-02-23 13:22:19.685369
976	687	5	2026-02-23 13:22:19.685369
977	688	5	2026-02-23 13:22:19.685369
978	689	5	2026-02-23 13:22:19.685369
979	690	5	2026-02-23 13:22:19.685369
980	691	5	2026-02-23 13:22:19.685369
981	692	5	2026-02-23 13:22:19.685369
982	693	5	2026-02-23 13:22:19.685369
983	694	5	2026-02-23 13:22:19.685369
984	695	5	2026-02-23 13:22:19.685369
985	696	5	2026-02-23 13:22:19.685369
986	697	5	2026-02-23 13:22:19.685369
987	698	5	2026-02-23 13:22:19.685369
988	699	5	2026-02-23 13:22:19.685369
989	700	5	2026-02-23 13:22:19.685369
990	701	5	2026-02-23 13:22:19.707017
991	702	5	2026-02-23 13:22:19.707017
992	703	5	2026-02-23 13:22:19.707017
993	704	5	2026-02-23 13:22:19.707017
994	705	6	2026-02-23 13:22:19.707017
995	706	6	2026-02-23 13:22:19.707017
996	706	9	2026-02-23 13:22:19.707017
997	707	6	2026-02-23 13:22:19.707017
998	708	6	2026-02-23 13:22:19.707017
999	709	6	2026-02-23 13:22:19.707017
1000	710	6	2026-02-23 13:22:19.707017
1001	711	6	2026-02-23 13:22:19.707017
1002	712	6	2026-02-23 13:22:19.707017
1003	712	9	2026-02-23 13:22:19.707017
1004	713	6	2026-02-23 13:22:19.707017
1005	714	6	2026-02-23 13:22:19.707017
1006	715	6	2026-02-23 13:22:19.707017
1007	716	6	2026-02-23 13:22:19.707017
1008	717	6	2026-02-23 13:22:19.707017
1009	717	9	2026-02-23 13:22:19.707017
1010	718	6	2026-02-23 13:22:19.707017
1011	718	9	2026-02-23 13:22:19.707017
1012	719	6	2026-02-23 13:22:19.707017
1013	719	9	2026-02-23 13:22:19.707017
1014	720	6	2026-02-23 13:22:19.707017
1015	721	6	2026-02-23 13:22:19.707017
1016	722	6	2026-02-23 13:22:19.707017
1017	722	7	2026-02-23 13:22:19.707017
1018	723	6	2026-02-23 13:22:19.707017
1019	724	6	2026-02-23 13:22:19.707017
1020	725	6	2026-02-23 13:22:19.707017
1021	726	6	2026-02-23 13:22:19.707017
1022	726	9	2026-02-23 13:22:19.707017
1023	727	6	2026-02-23 13:22:19.707017
1024	728	6	2026-02-23 13:22:19.707017
1025	729	6	2026-02-23 13:22:19.707017
1026	730	6	2026-02-23 13:22:19.707017
1027	730	9	2026-02-23 13:22:19.707017
1028	731	6	2026-02-23 13:22:19.707017
1029	732	6	2026-02-23 13:22:19.707017
1030	732	9	2026-02-23 13:22:19.707017
1031	733	6	2026-02-23 13:22:19.707017
1032	734	6	2026-02-23 13:22:19.707017
1033	735	6	2026-02-23 13:22:19.707017
1034	735	9	2026-02-23 13:22:19.707017
1035	736	6	2026-02-23 13:22:19.707017
1036	737	6	2026-02-23 13:22:19.707017
1037	738	6	2026-02-23 13:22:19.707017
1038	739	6	2026-02-23 13:22:19.707017
1039	739	9	2026-02-23 13:22:19.707017
1040	740	6	2026-02-23 13:22:19.707017
1041	741	6	2026-02-23 13:22:19.707017
1042	742	6	2026-02-23 13:22:19.707017
1043	743	6	2026-02-23 13:22:19.707017
1044	744	6	2026-02-23 13:22:19.707017
1045	745	6	2026-02-23 13:22:19.707017
1046	745	7	2026-02-23 13:22:19.707017
1047	746	6	2026-02-23 13:22:19.707017
1048	746	9	2026-02-23 13:22:19.707017
1049	747	6	2026-02-23 13:22:19.707017
1050	748	6	2026-02-23 13:22:19.707017
1051	748	9	2026-02-23 13:22:19.707017
1052	749	6	2026-02-23 13:22:19.707017
1053	750	6	2026-02-23 13:22:19.707017
1054	750	8	2026-02-23 13:22:19.707017
1055	751	6	2026-02-23 13:22:19.707017
1056	751	9	2026-02-23 13:22:19.707017
1057	752	6	2026-02-23 13:22:19.707017
1058	753	6	2026-02-23 13:22:19.707017
1059	754	6	2026-02-23 13:22:19.707017
1060	755	6	2026-02-23 13:22:19.707017
1061	755	9	2026-02-23 13:22:19.707017
1062	756	6	2026-02-23 13:22:19.707017
1063	756	9	2026-02-23 13:22:19.707017
1064	757	6	2026-02-23 13:22:19.707017
1065	758	6	2026-02-23 13:22:19.707017
1066	758	9	2026-02-23 13:22:19.707017
1067	759	6	2026-02-23 13:22:19.707017
1068	759	7	2026-02-23 13:22:19.707017
1069	760	6	2026-02-23 13:22:19.707017
1070	761	6	2026-02-23 13:22:19.707017
1071	762	6	2026-02-23 13:22:19.707017
1072	762	8	2026-02-23 13:22:19.707017
1073	763	6	2026-02-23 13:22:19.707017
1074	764	6	2026-02-23 13:22:19.707017
1075	765	6	2026-02-23 13:22:19.707017
1076	765	9	2026-02-23 13:22:19.707017
1077	766	6	2026-02-23 13:22:19.707017
1078	766	9	2026-02-23 13:22:19.707017
1079	767	6	2026-02-23 13:22:19.707017
1080	768	6	2026-02-23 13:22:19.707017
1081	768	9	2026-02-23 13:22:19.707017
1082	769	6	2026-02-23 13:22:19.707017
1083	770	6	2026-02-23 13:22:19.707017
1084	771	6	2026-02-23 13:22:19.707017
1085	772	6	2026-02-23 13:22:19.707017
1086	773	6	2026-02-23 13:22:19.707017
1087	774	6	2026-02-23 13:22:19.707017
1088	774	9	2026-02-23 13:22:19.707017
1089	775	6	2026-02-23 13:22:19.707017
1090	775	8	2026-02-23 13:22:19.707017
1091	775	9	2026-02-23 13:22:19.707017
1092	776	6	2026-02-23 13:22:19.707017
1093	777	6	2026-02-23 13:22:19.707017
1094	777	9	2026-02-23 13:22:19.707017
1095	778	6	2026-02-23 13:22:19.707017
1096	779	6	2026-02-23 13:22:19.707017
1097	780	6	2026-02-23 13:22:19.707017
1098	781	6	2026-02-23 13:22:19.707017
1099	782	6	2026-02-23 13:22:19.707017
1100	782	9	2026-02-23 13:22:19.707017
1101	783	6	2026-02-23 13:22:19.707017
1102	783	7	2026-02-23 13:22:19.707017
1103	784	6	2026-02-23 13:22:19.707017
1104	784	9	2026-02-23 13:22:19.707017
1105	785	6	2026-02-23 13:22:19.707017
1106	786	6	2026-02-23 13:22:19.707017
1107	787	6	2026-02-23 13:22:19.707017
1108	788	6	2026-02-23 13:22:19.707017
1109	788	8	2026-02-23 13:22:19.707017
1110	789	6	2026-02-23 13:22:19.707017
1111	789	9	2026-02-23 13:22:19.707017
1112	790	6	2026-02-23 13:22:19.707017
1113	791	6	2026-02-23 13:22:19.707017
1114	791	9	2026-02-23 13:22:19.707017
1115	792	6	2026-02-23 13:22:19.707017
1116	793	6	2026-02-23 13:22:19.707017
1117	793	9	2026-02-23 13:22:19.707017
1118	794	6	2026-02-23 13:22:19.707017
1119	795	6	2026-02-23 13:22:19.707017
1120	795	9	2026-02-23 13:22:19.707017
1121	796	6	2026-02-23 13:22:19.707017
1122	797	6	2026-02-23 13:22:19.707017
1123	797	9	2026-02-23 13:22:19.707017
1124	798	6	2026-02-23 13:22:19.707017
1125	799	6	2026-02-23 13:22:19.707017
1126	799	9	2026-02-23 13:22:19.707017
1127	800	6	2026-02-23 13:22:19.707017
1128	800	9	2026-02-23 13:22:19.707017
1129	801	6	2026-02-23 13:22:19.728943
1130	801	9	2026-02-23 13:22:19.728943
1131	802	6	2026-02-23 13:22:19.728943
1132	802	9	2026-02-23 13:22:19.728943
1133	803	6	2026-02-23 13:22:19.728943
1134	804	6	2026-02-23 13:22:19.728943
1135	804	9	2026-02-23 13:22:19.728943
1136	805	6	2026-02-23 13:22:19.728943
1137	805	9	2026-02-23 13:22:19.728943
1138	806	6	2026-02-23 13:22:19.728943
1139	807	6	2026-02-23 13:22:19.728943
1140	807	9	2026-02-23 13:22:19.728943
1141	808	6	2026-02-23 13:22:19.728943
1142	809	6	2026-02-23 13:22:19.728943
1143	810	7	2026-02-23 13:22:19.728943
1144	811	7	2026-02-23 13:22:19.728943
1145	812	7	2026-02-23 13:22:19.728943
1146	813	7	2026-02-23 13:22:19.728943
1147	814	7	2026-02-23 13:22:19.728943
1148	815	7	2026-02-23 13:22:19.728943
1149	816	7	2026-02-23 13:22:19.728943
1150	817	7	2026-02-23 13:22:19.728943
1151	818	7	2026-02-23 13:22:19.728943
1152	819	7	2026-02-23 13:22:19.728943
1153	820	7	2026-02-23 13:22:19.728943
1154	821	7	2026-02-23 13:22:19.728943
1155	822	7	2026-02-23 13:22:19.728943
1156	823	7	2026-02-23 13:22:19.728943
1157	824	7	2026-02-23 13:22:19.728943
1158	825	7	2026-02-23 13:22:19.728943
1159	826	7	2026-02-23 13:22:19.728943
1160	827	7	2026-02-23 13:22:19.728943
1161	828	7	2026-02-23 13:22:19.728943
1162	829	7	2026-02-23 13:22:19.728943
1163	830	7	2026-02-23 13:22:19.728943
1164	831	7	2026-02-23 13:22:19.728943
1165	832	7	2026-02-23 13:22:19.728943
1166	833	7	2026-02-23 13:22:19.728943
1167	834	7	2026-02-23 13:22:19.728943
1168	835	7	2026-02-23 13:22:19.728943
1169	836	7	2026-02-23 13:22:19.728943
1170	837	7	2026-02-23 13:22:19.728943
1171	838	7	2026-02-23 13:22:19.728943
1172	839	7	2026-02-23 13:22:19.728943
1173	840	7	2026-02-23 13:22:19.728943
1174	841	7	2026-02-23 13:22:19.728943
1175	842	7	2026-02-23 13:22:19.728943
1176	843	7	2026-02-23 13:22:19.728943
1177	844	7	2026-02-23 13:22:19.728943
1178	845	7	2026-02-23 13:22:19.728943
1179	846	7	2026-02-23 13:22:19.728943
1180	847	7	2026-02-23 13:22:19.728943
1181	848	7	2026-02-23 13:22:19.728943
1182	849	7	2026-02-23 13:22:19.728943
1183	850	7	2026-02-23 13:22:19.728943
1184	851	7	2026-02-23 13:22:19.728943
1185	852	7	2026-02-23 13:22:19.728943
1186	853	7	2026-02-23 13:22:19.728943
1187	854	7	2026-02-23 13:22:19.728943
1188	855	7	2026-02-23 13:22:19.728943
1189	856	7	2026-02-23 13:22:19.728943
1190	857	7	2026-02-23 13:22:19.728943
1191	858	7	2026-02-23 13:22:19.728943
1192	859	7	2026-02-23 13:22:19.728943
1193	860	7	2026-02-23 13:22:19.728943
1194	861	7	2026-02-23 13:22:19.728943
1195	862	7	2026-02-23 13:22:19.728943
1196	862	9	2026-02-23 13:22:19.728943
1197	863	7	2026-02-23 13:22:19.728943
1198	864	7	2026-02-23 13:22:19.728943
1199	865	7	2026-02-23 13:22:19.728943
1200	866	7	2026-02-23 13:22:19.728943
1201	867	7	2026-02-23 13:22:19.728943
1202	868	7	2026-02-23 13:22:19.728943
1203	869	7	2026-02-23 13:22:19.728943
1204	870	7	2026-02-23 13:22:19.728943
1205	871	7	2026-02-23 13:22:19.728943
1206	872	7	2026-02-23 13:22:19.728943
1207	873	7	2026-02-23 13:22:19.728943
1208	874	7	2026-02-23 13:22:19.728943
1209	875	7	2026-02-23 13:22:19.728943
1210	876	7	2026-02-23 13:22:19.728943
1211	876	8	2026-02-23 13:22:19.728943
1212	877	7	2026-02-23 13:22:19.728943
1213	878	7	2026-02-23 13:22:19.728943
1214	879	7	2026-02-23 13:22:19.728943
1215	880	7	2026-02-23 13:22:19.728943
1216	881	7	2026-02-23 13:22:19.728943
1217	882	7	2026-02-23 13:22:19.728943
1218	883	7	2026-02-23 13:22:19.728943
1219	884	7	2026-02-23 13:22:19.728943
1220	885	7	2026-02-23 13:22:19.728943
1221	886	7	2026-02-23 13:22:19.728943
1222	887	7	2026-02-23 13:22:19.728943
1223	888	7	2026-02-23 13:22:19.728943
1224	889	7	2026-02-23 13:22:19.728943
1225	890	7	2026-02-23 13:22:19.728943
1226	891	7	2026-02-23 13:22:19.728943
1227	892	7	2026-02-23 13:22:19.728943
1228	893	7	2026-02-23 13:22:19.728943
1229	893	8	2026-02-23 13:22:19.728943
1230	894	7	2026-02-23 13:22:19.728943
1231	895	7	2026-02-23 13:22:19.728943
1232	896	7	2026-02-23 13:22:19.728943
1233	897	7	2026-02-23 13:22:19.728943
1234	898	7	2026-02-23 13:22:19.728943
1235	898	8	2026-02-23 13:22:19.728943
1236	899	7	2026-02-23 13:22:19.728943
1237	900	7	2026-02-23 13:22:19.728943
1238	901	7	2026-02-23 13:22:19.749713
1239	902	8	2026-02-23 13:22:19.749713
1240	902	9	2026-02-23 13:22:19.749713
1241	903	8	2026-02-23 13:22:19.749713
1242	904	8	2026-02-23 13:22:19.749713
1243	905	8	2026-02-23 13:22:19.749713
1244	906	8	2026-02-23 13:22:19.749713
1245	907	8	2026-02-23 13:22:19.749713
1246	908	8	2026-02-23 13:22:19.749713
1247	909	8	2026-02-23 13:22:19.749713
1248	910	8	2026-02-23 13:22:19.749713
1249	911	8	2026-02-23 13:22:19.749713
1250	911	9	2026-02-23 13:22:19.749713
1251	912	8	2026-02-23 13:22:19.749713
1252	913	8	2026-02-23 13:22:19.749713
1253	914	8	2026-02-23 13:22:19.749713
1254	915	8	2026-02-23 13:22:19.749713
1255	915	9	2026-02-23 13:22:19.749713
1256	916	8	2026-02-23 13:22:19.749713
1257	917	8	2026-02-23 13:22:19.749713
1258	918	8	2026-02-23 13:22:19.749713
1259	919	8	2026-02-23 13:22:19.749713
1260	919	9	2026-02-23 13:22:19.749713
1261	920	8	2026-02-23 13:22:19.749713
1262	921	8	2026-02-23 13:22:19.749713
1263	922	8	2026-02-23 13:22:19.749713
1264	923	8	2026-02-23 13:22:19.749713
1265	924	8	2026-02-23 13:22:19.749713
1266	925	8	2026-02-23 13:22:19.749713
1267	926	8	2026-02-23 13:22:19.749713
1268	927	8	2026-02-23 13:22:19.749713
1269	928	8	2026-02-23 13:22:19.749713
1270	929	8	2026-02-23 13:22:19.749713
1271	930	8	2026-02-23 13:22:19.749713
1272	931	8	2026-02-23 13:22:19.749713
1273	932	8	2026-02-23 13:22:19.749713
1274	933	8	2026-02-23 13:22:19.749713
1275	934	8	2026-02-23 13:22:19.749713
1276	935	8	2026-02-23 13:22:19.749713
1277	936	8	2026-02-23 13:22:19.749713
1278	937	8	2026-02-23 13:22:19.749713
1279	938	8	2026-02-23 13:22:19.749713
1280	939	8	2026-02-23 13:22:19.749713
1281	940	8	2026-02-23 13:22:19.749713
1282	941	8	2026-02-23 13:22:19.749713
1283	942	8	2026-02-23 13:22:19.749713
1284	943	8	2026-02-23 13:22:19.749713
1285	944	8	2026-02-23 13:22:19.749713
1286	945	8	2026-02-23 13:22:19.749713
1287	946	8	2026-02-23 13:22:19.749713
1288	947	8	2026-02-23 13:22:19.749713
1289	948	8	2026-02-23 13:22:19.749713
1290	949	8	2026-02-23 13:22:19.749713
1291	950	8	2026-02-23 13:22:19.749713
1292	951	8	2026-02-23 13:22:19.749713
1293	952	8	2026-02-23 13:22:19.749713
1294	953	8	2026-02-23 13:22:19.749713
1295	954	8	2026-02-23 13:22:19.749713
1296	955	8	2026-02-23 13:22:19.749713
1297	956	8	2026-02-23 13:22:19.749713
1298	957	8	2026-02-23 13:22:19.749713
1299	958	8	2026-02-23 13:22:19.749713
1300	959	8	2026-02-23 13:22:19.749713
1301	960	8	2026-02-23 13:22:19.749713
1302	961	8	2026-02-23 13:22:19.749713
1303	962	8	2026-02-23 13:22:19.749713
1304	963	8	2026-02-23 13:22:19.749713
1305	964	8	2026-02-23 13:22:19.749713
1306	965	8	2026-02-23 13:22:19.749713
1307	966	8	2026-02-23 13:22:19.749713
1308	967	8	2026-02-23 13:22:19.749713
1309	968	8	2026-02-23 13:22:19.749713
1310	969	8	2026-02-23 13:22:19.749713
1311	970	8	2026-02-23 13:22:19.749713
1312	971	8	2026-02-23 13:22:19.749713
1313	972	8	2026-02-23 13:22:19.749713
1314	973	8	2026-02-23 13:22:19.749713
1315	974	8	2026-02-23 13:22:19.749713
1316	975	8	2026-02-23 13:22:19.749713
1317	976	8	2026-02-23 13:22:19.749713
1318	977	8	2026-02-23 13:22:19.749713
1319	978	8	2026-02-23 13:22:19.749713
1320	979	8	2026-02-23 13:22:19.749713
1321	980	8	2026-02-23 13:22:19.749713
1322	981	8	2026-02-23 13:22:19.749713
1323	982	8	2026-02-23 13:22:19.749713
1324	983	8	2026-02-23 13:22:19.749713
1325	984	8	2026-02-23 13:22:19.749713
1326	985	8	2026-02-23 13:22:19.749713
1327	986	8	2026-02-23 13:22:19.749713
1328	987	8	2026-02-23 13:22:19.749713
1329	988	8	2026-02-23 13:22:19.749713
1330	989	8	2026-02-23 13:22:19.749713
1331	990	8	2026-02-23 13:22:19.749713
1332	991	8	2026-02-23 13:22:19.749713
1333	992	8	2026-02-23 13:22:19.749713
1334	993	8	2026-02-23 13:22:19.749713
1335	994	8	2026-02-23 13:22:19.749713
1336	995	8	2026-02-23 13:22:19.749713
1337	996	8	2026-02-23 13:22:19.749713
1338	997	8	2026-02-23 13:22:19.749713
1339	998	8	2026-02-23 13:22:19.749713
1340	999	8	2026-02-23 13:22:19.749713
1341	1000	8	2026-02-23 13:22:19.749713
1342	1001	8	2026-02-23 13:22:19.771191
1343	1002	8	2026-02-23 13:22:19.771191
1344	1003	8	2026-02-23 13:22:19.771191
1345	1004	8	2026-02-23 13:22:19.771191
1346	1005	8	2026-02-23 13:22:19.771191
1347	1006	8	2026-02-23 13:22:19.771191
1348	1007	8	2026-02-23 13:22:19.771191
1349	1008	8	2026-02-23 13:22:19.771191
1350	1009	8	2026-02-23 13:22:19.771191
1351	1010	8	2026-02-23 13:22:19.771191
1352	1011	8	2026-02-23 13:22:19.771191
1353	1012	8	2026-02-23 13:22:19.771191
1354	1013	8	2026-02-23 13:22:19.771191
1355	1014	8	2026-02-23 13:22:19.771191
1356	1015	8	2026-02-23 13:22:19.771191
1357	1016	8	2026-02-23 13:22:19.771191
1358	1017	8	2026-02-23 13:22:19.771191
1359	1018	9	2026-02-23 13:22:19.771191
1360	1019	9	2026-02-23 13:22:19.771191
1361	1020	9	2026-02-23 13:22:19.771191
1362	1021	9	2026-02-23 13:22:19.771191
1363	1022	9	2026-02-23 13:22:19.771191
1364	1023	9	2026-02-23 13:22:19.771191
1365	1024	9	2026-02-23 13:22:19.771191
1366	1025	9	2026-02-23 13:22:19.771191
1367	1026	9	2026-02-23 13:22:19.771191
1368	1027	9	2026-02-23 13:22:19.771191
1369	1028	9	2026-02-23 13:22:19.771191
1370	1029	9	2026-02-23 13:22:19.771191
1371	1030	9	2026-02-23 13:22:19.771191
1372	1031	9	2026-02-23 13:22:19.771191
1373	1032	9	2026-02-23 13:22:19.771191
1374	1033	9	2026-02-23 13:22:19.771191
1375	1034	9	2026-02-23 13:22:19.771191
1376	1035	9	2026-02-23 13:22:19.771191
1377	1036	9	2026-02-23 13:22:19.771191
1378	1037	9	2026-02-23 13:22:19.771191
1379	1038	9	2026-02-23 13:22:19.771191
1380	1039	9	2026-02-23 13:22:19.771191
1381	1040	9	2026-02-23 13:22:19.771191
1382	1041	9	2026-02-23 13:22:19.771191
1383	1042	9	2026-02-23 13:22:19.771191
1384	1043	9	2026-02-23 13:22:19.771191
1385	1044	9	2026-02-23 13:22:19.771191
1386	1045	9	2026-02-23 13:22:19.771191
1387	1046	9	2026-02-23 13:22:19.771191
1388	1047	9	2026-02-23 13:22:19.771191
1389	1048	9	2026-02-23 13:22:19.771191
1390	1049	9	2026-02-23 13:22:19.771191
1391	1050	9	2026-02-23 13:22:19.771191
1392	1051	9	2026-02-23 13:22:19.771191
1393	1052	9	2026-02-23 13:22:19.771191
1394	1053	9	2026-02-23 13:22:19.771191
1395	1054	9	2026-02-23 13:22:19.771191
1396	1055	9	2026-02-23 13:22:19.771191
1397	1056	9	2026-02-23 13:22:19.771191
1398	1057	9	2026-02-23 13:22:19.771191
1399	1058	9	2026-02-23 13:22:19.771191
1400	1059	9	2026-02-23 13:22:19.771191
1401	1060	9	2026-02-23 13:22:19.771191
1402	1061	9	2026-02-23 13:22:19.771191
1403	1062	9	2026-02-23 13:22:19.771191
1404	1063	9	2026-02-23 13:22:19.771191
1405	1064	9	2026-02-23 13:22:19.771191
1406	1065	9	2026-02-23 13:22:19.771191
1407	1066	9	2026-02-23 13:22:19.771191
1408	1067	9	2026-02-23 13:22:19.771191
1409	1068	9	2026-02-23 13:22:19.771191
1410	1069	9	2026-02-23 13:22:19.771191
1411	1070	9	2026-02-23 13:22:19.771191
1412	1071	9	2026-02-23 13:22:19.771191
1413	1072	9	2026-02-23 13:22:19.771191
1414	1073	9	2026-02-23 13:22:19.771191
1415	1074	9	2026-02-23 13:22:19.771191
1416	1075	9	2026-02-23 13:22:19.771191
1417	1076	9	2026-02-23 13:22:19.771191
1418	1077	9	2026-02-23 13:22:19.771191
1419	1078	9	2026-02-23 13:22:19.771191
1420	1079	9	2026-02-23 13:22:19.771191
1421	1080	9	2026-02-23 13:22:19.771191
1422	1081	9	2026-02-23 13:22:19.771191
1423	1082	9	2026-02-23 13:22:19.771191
1424	1083	9	2026-02-23 13:22:19.771191
1425	1084	9	2026-02-23 13:22:19.771191
1426	1085	9	2026-02-23 13:22:19.771191
1427	1086	9	2026-02-23 13:22:19.771191
1428	1087	9	2026-02-23 13:22:19.771191
1429	1088	9	2026-02-23 13:22:19.771191
1430	1089	9	2026-02-23 13:22:19.771191
1431	1090	9	2026-02-23 13:22:19.771191
1432	1091	9	2026-02-23 13:22:19.771191
1433	1092	9	2026-02-23 13:22:19.771191
1434	1093	9	2026-02-23 13:22:19.771191
1435	1094	9	2026-02-23 13:22:19.771191
1436	1095	9	2026-02-23 13:22:19.771191
1437	1096	9	2026-02-23 13:22:19.771191
1438	1097	9	2026-02-23 13:22:19.771191
1439	1098	9	2026-02-23 13:22:19.771191
\.


--
-- Data for Name: wish_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wish_item (id, wish_list_id, vinyl_id, created_at) FROM stdin;
\.


--
-- Data for Name: wish_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wish_list (id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: cart_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_item_id_seq', 1, false);


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_id_seq', 2701, true);


--
-- Name: credit_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.credit_card_id_seq', 1, false);


--
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genre_id_seq', 9, true);


--
-- Name: order_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_history_id_seq', 1, false);


--
-- Name: order_vinyl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_vinyl_id_seq', 1, false);


--
-- Name: shopping_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shopping_cart_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 101, true);


--
-- Name: vinyl_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vinyl_genre_id_seq', 1439, true);


--
-- Name: vinyl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vinyl_id_seq', 1098, true);


--
-- Name: wish_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wish_item_id_seq', 1, false);


--
-- Name: wish_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wish_list_id_seq', 1, false);


--
-- Name: cart_item cart_item_cart_id_vinyl_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT cart_item_cart_id_vinyl_id_key UNIQUE (cart_id, vinyl_id);


--
-- Name: cart_item cart_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT cart_item_pkey PRIMARY KEY (id);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: credit_card credit_card_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_card
    ADD CONSTRAINT credit_card_pkey PRIMARY KEY (id);


--
-- Name: genre genre_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_name_key UNIQUE (name);


--
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);


--
-- Name: order_history order_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_history
    ADD CONSTRAINT order_history_pkey PRIMARY KEY (id);


--
-- Name: order_vinyl order_vinyl_order_id_vinyl_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_vinyl
    ADD CONSTRAINT order_vinyl_order_id_vinyl_id_key UNIQUE (order_id, vinyl_id);


--
-- Name: order_vinyl order_vinyl_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_vinyl
    ADD CONSTRAINT order_vinyl_pkey PRIMARY KEY (id);


--
-- Name: shopping_cart shopping_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_pkey PRIMARY KEY (id);


--
-- Name: shopping_cart shopping_cart_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_user_id_key UNIQUE (user_id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: vinyl_genre vinyl_genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vinyl_genre
    ADD CONSTRAINT vinyl_genre_pkey PRIMARY KEY (id);


--
-- Name: vinyl_genre vinyl_genre_vinyl_id_genre_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vinyl_genre
    ADD CONSTRAINT vinyl_genre_vinyl_id_genre_id_key UNIQUE (vinyl_id, genre_id);


--
-- Name: vinyl vinyl_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vinyl
    ADD CONSTRAINT vinyl_pkey PRIMARY KEY (id);


--
-- Name: wish_item wish_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wish_item
    ADD CONSTRAINT wish_item_pkey PRIMARY KEY (id);


--
-- Name: wish_item wish_item_wish_list_id_vinyl_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wish_item
    ADD CONSTRAINT wish_item_wish_list_id_vinyl_id_key UNIQUE (wish_list_id, vinyl_id);


--
-- Name: wish_list wish_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wish_list
    ADD CONSTRAINT wish_list_pkey PRIMARY KEY (id);


--
-- Name: wish_list wish_list_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wish_list
    ADD CONSTRAINT wish_list_user_id_key UNIQUE (user_id);


--
-- Name: cart_item cart_item_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT cart_item_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.shopping_cart(id) ON DELETE CASCADE;


--
-- Name: cart_item cart_item_vinyl_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_item
    ADD CONSTRAINT cart_item_vinyl_id_fkey FOREIGN KEY (vinyl_id) REFERENCES public.vinyl(id) ON DELETE CASCADE;


--
-- Name: comment comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: comment comment_vinyl_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_vinyl_id_fkey FOREIGN KEY (vinyl_id) REFERENCES public.vinyl(id) ON DELETE CASCADE;


--
-- Name: credit_card credit_card_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_card
    ADD CONSTRAINT credit_card_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: order_history order_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_history
    ADD CONSTRAINT order_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: order_vinyl order_vinyl_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_vinyl
    ADD CONSTRAINT order_vinyl_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.order_history(id) ON DELETE CASCADE;


--
-- Name: order_vinyl order_vinyl_vinyl_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_vinyl
    ADD CONSTRAINT order_vinyl_vinyl_id_fkey FOREIGN KEY (vinyl_id) REFERENCES public.vinyl(id) ON DELETE CASCADE;


--
-- Name: shopping_cart shopping_cart_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: vinyl_genre vinyl_genre_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vinyl_genre
    ADD CONSTRAINT vinyl_genre_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genre(id) ON DELETE CASCADE;


--
-- Name: vinyl_genre vinyl_genre_vinyl_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vinyl_genre
    ADD CONSTRAINT vinyl_genre_vinyl_id_fkey FOREIGN KEY (vinyl_id) REFERENCES public.vinyl(id) ON DELETE CASCADE;


--
-- Name: wish_item wish_item_vinyl_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wish_item
    ADD CONSTRAINT wish_item_vinyl_id_fkey FOREIGN KEY (vinyl_id) REFERENCES public.vinyl(id) ON DELETE CASCADE;


--
-- Name: wish_item wish_item_wish_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wish_item
    ADD CONSTRAINT wish_item_wish_list_id_fkey FOREIGN KEY (wish_list_id) REFERENCES public.wish_list(id) ON DELETE CASCADE;


--
-- Name: wish_list wish_list_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wish_list
    ADD CONSTRAINT wish_list_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict WuerKXdR5vBfh3cbmbN9u3AzJQGghBlGUoHwAa4Cu5FbxcvBDwEVN2NRB9haEdZ

