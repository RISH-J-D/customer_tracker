--
-- PostgreSQL database dump
--

\restrict POtQrLuKWbesVLipxX9KkyiMlQRmWxYISxq9mbn0PIpeBd0DRzEmrJyW4KAcdK0

-- Dumped from database version 18.6 (Ubuntu 18.6-1.pgdg24.04+2)
-- Dumped by pg_dump version 18.6 (Ubuntu 18.6-1.pgdg24.04+2)

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
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id integer NOT NULL,
    client_id integer,
    account_name text NOT NULL,
    company text NOT NULL,
    project_name text NOT NULL,
    client_representative text NOT NULL,
    rep_email text,
    rep_phone text,
    rep_designation text,
    deal_value double precision,
    steel_tonnage double precision,
    status text,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    rep_first_name text,
    rep_last_name text,
    city text,
    state text,
    country text
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.accounts_id_seq OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activity_logs (
    id integer NOT NULL,
    user_name character varying(100),
    user_username character varying(60),
    action character varying(50) NOT NULL,
    entity_type character varying(50) NOT NULL,
    entity_id integer,
    entity_name character varying(200),
    description text NOT NULL,
    changes text,
    created_at timestamp without time zone
);


ALTER TABLE public.activity_logs OWNER TO postgres;

--
-- Name: activity_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activity_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activity_logs_id_seq OWNER TO postgres;

--
-- Name: activity_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activity_logs_id_seq OWNED BY public.activity_logs.id;


--
-- Name: app_meta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_meta (
    key character varying(100) NOT NULL,
    value text,
    updated_at timestamp without time zone
);


ALTER TABLE public.app_meta OWNER TO postgres;

--
-- Name: client_notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_notes (
    id integer NOT NULL,
    client_id integer NOT NULL,
    content text NOT NULL,
    author character varying(100),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.client_notes OWNER TO postgres;

--
-- Name: client_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_notes_id_seq OWNER TO postgres;

--
-- Name: client_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_notes_id_seq OWNED BY public.client_notes.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    name text NOT NULL,
    company text,
    email text,
    phone text,
    category text,
    status text,
    is_lead boolean,
    positive_approach boolean,
    lead_converted_at timestamp without time zone,
    deal_value double precision,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    "position" text,
    city text,
    state text,
    country text,
    account_converted_at timestamp without time zone,
    marked_negative_at timestamp without time zone,
    prospect_marked_at timestamp without time zone,
    company_email character varying(255),
    company_phone character varying(255)
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_id_seq OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: followups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.followups (
    id integer NOT NULL,
    client_id integer NOT NULL,
    title character varying(200) NOT NULL,
    type character varying(50),
    scheduled_at timestamp without time zone NOT NULL,
    priority character varying(20),
    status character varying(30),
    is_positive_result boolean,
    notes text,
    location character varying(200),
    meeting_link character varying(255),
    reminder_sent boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    completed_at timestamp without time zone
);


ALTER TABLE public.followups OWNER TO postgres;

--
-- Name: followups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.followups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.followups_id_seq OWNER TO postgres;

--
-- Name: followups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.followups_id_seq OWNED BY public.followups.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    title character varying(150) NOT NULL,
    message text NOT NULL,
    type character varying(50),
    client_id integer,
    followup_id integer,
    is_read boolean,
    created_at timestamp without time zone
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(60) NOT NULL,
    name character varying(100) NOT NULL,
    password character varying(200) NOT NULL,
    role character varying(50),
    avatar character varying(200),
    created_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: activity_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_logs ALTER COLUMN id SET DEFAULT nextval('public.activity_logs_id_seq'::regclass);


--
-- Name: client_notes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_notes ALTER COLUMN id SET DEFAULT nextval('public.client_notes_id_seq'::regclass);


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: followups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followups ALTER COLUMN id SET DEFAULT nextval('public.followups_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, client_id, account_name, company, project_name, client_representative, rep_email, rep_phone, rep_designation, deal_value, steel_tonnage, status, notes, created_at, updated_at, rep_first_name, rep_last_name, city, state, country) FROM stdin;
\.


--
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activity_logs (id, user_name, user_username, action, entity_type, entity_id, entity_name, description, changes, created_at) FROM stdin;
1	Admin	admin	IMPORT_EXCEL	Lead	\N	Client_Details.xlsx	Replaced all data with 2487 leads from Client_Details.xlsx	\N	2026-10-16 17:50:35.64161
2	Admin	admin	UPDATE_CLIENT	Client	2487	Kelvin Dancel (Steel Structures Inc)	Updated Kelvin Dancel: email: 'None' -> 'test.rep@example.com', status: 'Lead' -> 'Prospect', is_lead: 'True' -> 'False' (+1 more fields)	{"email": {"old": null, "new": "test.rep@example.com"}, "status": {"old": "Lead", "new": "Prospect"}, "is_lead": {"old": true, "new": false}, "position": {"old": null, "new": "Estimator"}}	2026-10-16 17:53:07.004339
3	Admin	admin	UPDATE_CLIENT	Lead	2487	Kelvin Dancel (Steel Structures Inc)	Updated Kelvin Dancel: email: 'test.rep@example.com' -> 'None', status: 'Prospect' -> 'Lead', is_lead: 'False' -> 'True' (+1 more fields)	{"email": {"old": "test.rep@example.com", "new": null}, "status": {"old": "Prospect", "new": "Lead"}, "is_lead": {"old": false, "new": true}, "position": {"old": "Estimator", "new": null}}	2026-10-16 17:53:12.340879
4	Abarna S	abarna.s	LOGIN	Auth	1	Abarna S	User Abarna S (abarna.s) logged in to ClientFlow	\N	2026-10-21 06:50:16.514828
\.


--
-- Data for Name: app_meta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_meta (key, value, updated_at) FROM stdin;
client_details_import	2487 leads	2026-10-16 17:43:23.0969
client_details_import_v2	2487 leads	2026-10-16 17:50:35.643001
\.


--
-- Data for Name: client_notes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_notes (id, client_id, content, author, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (id, name, company, email, phone, category, status, is_lead, positive_approach, lead_converted_at, deal_value, notes, created_at, updated_at, "position", city, state, country, account_converted_at, marked_negative_at, prospect_marked_at, company_email, company_phone) FROM stdin;
1	Luis Andria	McMohan steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Engineer	Chula Vista	CA	USA	\N	\N	\N	admin@crm.com	(619) 671-9700
2	Kal Kimbrough	2-K Steel Products, Inc.(resume)	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ashville	AL	USA	\N	\N	\N	\N	(205) 594-5446 / (205) 594-7437
3	Tim Limon	4G Steel Fabrication LLC	tim@4gsteelfab.com	402-904-8578	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Co-owner	Lincoln	NE	USA	\N	\N	\N	\N	402-904-8578
4	gary fiveash	5 Star fabrications Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Jonestown	TX	USA	\N	\N	\N	sales@5starfabrications.com	5122670470
5	A & B Steel Shearing Inc.	A & B Steel Shearing Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Detroit	MI	USA	\N	\N	\N	\N	313-892-8100
6	Margaret Williams	A.Lucas & Sons	margaret@alucasiron.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IL	\N	\N	\N	\N	mgg@alucasiron.com	\N
7	Mark Johnson/ Bob Noaker	A.S.P Services, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Selinsgrove	PA	USA	\N	\N	\N	mjohnson@aspservicesinc.com	(570) 374-5333
8	A-1 steell	A-1 steell	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	775-358-8666
9	Cyle Clark	Able Steel Fabricators, LLC	cclark@ablesteel.com	480-830-2253	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP of Estimating	Mesa	AZ	USA	\N	\N	\N	\N	480-830-2253
10	Scott Mitchell	Absolute welding & consulting LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Douglasville	GA	USA	\N	\N	\N	scottm@absolute-welding.com	770-726-0903
11	Eric Anderson / Dennis Sandberg	ABW Technologies, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President/ Ch.Estimator	Arlington	WA	USA	\N	\N	\N	\N	+1 360-618-4400
12	ABZ Steel Fab	ABZ Steel Fab	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Clinton Townshop	MI	USA	\N	\N	\N	\N	586-792-2669
13	AC Custom Welding	AC Custom Welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pesotum	IL	USA	\N	\N	\N	info@accustomwelding.com	1)  217-766-6078              2) Toll - Free - 833-599-ACCW (2229)
14	Troy Blanchard	Acadian Contractors LLC  (four locations)	troyb@acadiancontractors.com	281.994.7883  (or)   mobile: 713.503.4765	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Vice president & Business Development	Abbeville	LA	USA	\N	\N	\N	\N	337-893-6397
15	Accelerated Steel	Accelerated Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	WI	USA	\N	\N	\N	\N	\N
16	Accu-Fab-Inc	Accu-Fab-Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Raleigh	NC	USA	\N	\N	\N	anand@struzon.com	919.212.6400 (EXT 117)
17	Jeremy Moore	Ace Fabricators	jeremy@acefabricatorsinc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	Houston	TX	USA	\N	\N	\N	\N	281-442-0992 x104
18	Ace iron & steel shop	Ace iron & steel shop	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Milwaukee	WI	USA	\N	\N	\N	\N	\N
19	ASHLEY OBRIEN	Ace Iron and Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing	Milwaukee	WI	USA	\N	\N	\N	\N	414-466-9200
20	Ackerman Brothers Inc.	Ackerman Brothers Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bay City	MI	USA	\N	\N	\N	ackermanbros@yahoo.com	(989) 892-4122
21	Actron Steel	Actron Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	MI	USA	\N	\N	\N	actron@actronsteel.com	231-947-3981
22	Manuel	Adams Iron Co Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing	Santa Ana	CA	USA	\N	\N	\N	manuel@adamsiron.com	714 543 4227 / 113
23	Keith Shaw	ADS Steel services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fort Worth	TX	USA	\N	\N	\N	\N	817) 763-8223?
24	Advance iron works, Inc.	Advance iron works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	East Hazel Crest	IL	USA	\N	\N	\N	info@advanceiw.com	708.798.3540
25	Advance Steel Services	Advance Steel Services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chicago	IL	USA	\N	\N	\N	\N	773-619-2977
26	Richard Holmes	Advanced Metal Sales LLC	richardholmessr@advancedmetalsales.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	info@advancedmetalsales.com	(623) 434-8343
27	Walter Kilbreth	Advanced Resources & Construction Enterprises, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kingfield	ME	USA	\N	\N	\N	\N	(207) 265-2646
28	Neil Bruegeman	Advanced Welding & Steel, Inc.	neilb@awssteel.com	208-983-7608 x110	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Operations Manager	Grangeville	ID	USA	\N	\N	\N	ethans@awssteel.com	208-983-7608
29	John Bunton	Advantage Steel	jb@advantagesteelinc.com	813-241-2345	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	Tampa	FL	USA	\N	\N	\N	estimating@advsteel.com, info@advsteel.com	\N
30	John Bunton	Advantage steel Inc	jb@advantagesteelinc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	Tampa	FL	USA	\N	\N	\N	info@advantagesteelinc.com	(813) 241-2345
31	Advantage Steel Service, Inc.	Advantage Steel Service, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fort Worth	TX	USA	\N	\N	\N	engineering@advantagesteelservice.com	817-284-1693
32	Clint Ruckman	Advantage Terrafab	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing admin	Muskogee	OK	USA	\N	\N	\N	Clint.Ruckman@advantageterrafab.com	(918) 232-3926 / DD 918-302-1374
33	Tom Morris	AF Steel Fab	tmorris@afsteelfab.com	602) 344-4200	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	AZ	\N	\N	\N	\N	afsteel@arizonafireplaces.com	602) 344-4200
34	AFCO Steel	AFCO Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oklahoma City	OK	USA	\N	\N	\N	\N	\N
35	Jim land	Affiliated metal industries Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	Olmsted Falls	OH	USA	\N	\N	\N	jland@affiliatedmetal.com	(440) 235-3345
36	Adam Williams	Affton Fabricating & Welding Co., Inc.	awilliams@afwc.com	618-337-5450	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailer	East St. Louis	IL	USA	\N	\N	\N	\N	618-337-5450
37	Angel Martinez	Agate Steel, Inc.	angel.martinez@agatesteel.com	480-994-9455	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Operations Manager	Scottsdale	AZ	USA	\N	\N	\N	\N	480-994-9455
38	Jonathan	AIM industrial solutions	jonathan@aimmfgllc.com	4238020576	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MD	Kimball	TN	USA	\N	\N	\N	\N	1) 4238020576 - Jonathan           2) 4238477824 - Gregory
39	Lizy / mohan	AIM Steel International INC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Atlanta	GA	USA	\N	\N	\N	\N	1-678-422-5075
40	Robert C Hodge Jr	AIW, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hyattsville	MD	USA	\N	\N	\N	\N	(301) 277-8444
41	Gwendolyn (Postle) Perkins	Alabama Metal Fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Elberta	AL	USA	\N	\N	\N	\N	251-986-6257
42	Alberici constructors	Alberici constructors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	St. Louis	MO	USA	\N	\N	\N	\N	\N
43	William Freytag / Eric	Albert Freytag Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Minster	OH	USA	\N	\N	\N	\N	(419) 628-2018
44	Albina Co., Inc.	Albina Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tualatin	OR	USA	\N	\N	\N	\N	(503) 692-6010
45	Jeff Whitaker	Alfab, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Enterprise	AL	USA	\N	\N	\N	ggothard@alfabinc.com	334-347-9516 ext 208
46	All design and Fabrication (railing)	All design and Fabrication (railing)	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	alldesignfab@gmail.com	702-527-8982
47	Barry Pitts	Allstate Steel	bpitts@allstatesteel.com	602-699-6500	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Phoenix	AZ	USA	\N	\N	\N	Bpitts@allstatesteel.com	904.694.0670
48	All steel construction	All steel construction	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Benton	AR	USA	\N	\N	\N	\N	501-315-2800
49	Chris Szpringiel	ALL STEEL IRON WORKS Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bedford Park	IL	USA	\N	\N	\N	chris@asteeliron.com	708-357-3231
50	Derek ()	All Things Metal	dereks@atmphx.com	(623) 582-3900	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr PM	\N	AZ	\N	\N	\N	\N	lindab@atmphx.com	(623) 582-3900
51	Allen Builders LLC	Allen Builders LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Colorao Springs	CO	USA	\N	\N	\N	\N	719-301-0669
52	Bobby LAlley	Alley's welding Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bakersfield	CA	USA	\N	\N	\N	bob@alleyswelding.com	+1 661-588-5998
53	Jim Buchan /Tony Morfitt	Alliance industrial group/Alpha Iron	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President/PM	Ridgefield	WA	USA	\N	\N	\N	corinnep@aisteel.us	360-823-1777
54	Chris Chapman	Allied Steel	chris@alliedsteelco.com	O: (951)241-7000 C:(323)370-3320 C:(323)	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	CA	\N	\N	\N	\N	\N	O: (951)241-7000 C:(323)370-3320 C:(323)
55	Alex Majano	Allied Steel Co., Inc.	alex@alliedsteelco.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Riverside	CA	USA	\N	\N	\N	\N	(951) 241-7000
56	Steve Roth	Alloy Construction Services, Inc.	steve@alloyconstruction.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Midland	MI	USA	\N	\N	\N	\N	989.486.6960
57	Robert Singh	Allpro fabricators and erectors Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	Burris Rd Davie	FL	USA	\N	\N	\N	info@allprofab.com	(954) 797 - 7300
58	Ray Fulkerson / Tyler Comer	Allstate Tower Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Dir of engg / Estimator & Pm	Henderson	KY	USA	\N	\N	\N	rfulkerson@pttg.com	(270) 830-8512/ 2708269000
59	Alpha welding & fabrication Inc.	Alpha welding & fabrication Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Shreveport	LA	USA	\N	\N	\N	\N	318-424-1146
60	Nick Fagernes	AL's Welding & Steel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chehalis	WA	USA	\N	\N	\N	\N	(360) 740-8020
61	Alstate Steel	Alstate Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602-699-6500
62	Jeff T Wallis	Alstate Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albuquerque	NM	USA	\N	\N	\N	\N	(505) 877-5454
63	Jerry Reffner	Altoona Pipe and Steel Supply	\N	(814) 944-1631	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	PA	\N	\N	\N	\N	gmansfield@altoonapipeandsteel.com	(814) 944-1631
64	Julian Salgado	Altra Builders	julian@altrabuilders.net	(708)534-1100x304	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	IL	\N	\N	\N	\N	estimating@altrabuilders.net	(708)534-1100x304
65	Ambassador Steel Corporation	Ambassador Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ankeny	IA	USA	\N	\N	\N	\N	641-792-7142
66	Mike Smith	Amber Steel Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chandler	AZ	USA	\N	\N	\N	\N	(480) 821-0004
67	AMECO USA	AMECO USA	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cleveland	OH	USA	\N	\N	\N	\N	\N
68	American Iron Custom Fabrication and Welding	American Iron Custom Fabrication and Welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pocatello	ID	USA	\N	\N	\N	\N	208-252-5076
69	American Iron Inc	American Iron Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Schenectady	NY	USA	\N	\N	\N	\N	+1 518-357-9309
70	American Iron works Inc	American Iron works Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hyattsville	MD	USA	\N	\N	\N	\N	\N
71	Ted Samders	American Marine & Fabricators	ted@americanfabricatorsnc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	New Bern	NC	USA	\N	\N	\N	\N	252-637-2600
72	American piping group inc	American piping group inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Morrison	IL	USA	\N	\N	\N	\N	(815) 772-7470
73	Rob	American Steel & Aluminum Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Grand Prairie	TX	USA	\N	\N	\N	info@asafab.com	(972) 264-1533
74	Martin Vollrath	American Steel & Stairways Inc.	vollrath@americansteelandstairways.com	408-848-2992	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	Gilroy	CA	USA	\N	\N	\N	Danielg@americansteelandstairways.com	408-848-2992
75	Jem willianson	American Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AZ	USA	\N	\N	\N	\N	480-474-0100
76	Tyler Jones	American Steel Fabricators Inc	tjones@amsteelfabricators.com	847-807-4200	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	Chicago	IL	USA	\N	\N	\N	jazzalerja@amsteelfabricators.com (or) estimating@amsteelfabricators.com	847-807-4200
77	Mark Carter	American Steel Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Greenfield	NH	USA	\N	\N	\N	info@americansteelfab.com	(603) 547-2585
78	American Steel Works	American Steel Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Riverview	MI	USA	\N	\N	\N	\N	+1 734-282-0300
79	American Steel Works Inc	American Steel Works Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kansas City	OH	USA	\N	\N	\N	\N	+1 816-483-8222
80	David Lewis	American Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Billings	MT	USA	\N	\N	\N	\N	(406) 294-0032
81	American steelworks inc	American steelworks inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Melrose Park	IL	USA	\N	\N	\N	\N	+1 708-538-0295
82	Ted Karsos	American Structural Corporate	\N	(844) 257-9504	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	FL	\N	\N	\N	\N	\N	(844) 257-9504
83	Mitch Ortner	American Structural Metals	\N	Mitch - (715) 247-1039	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing manager	Somerset	WI	USA	\N	\N	\N	\N	715-247-5950
84	Fred Riermann	American Structural Metals, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Somerset	WI	USA	\N	\N	\N	\N	(715) 247-1011
85	American Welding and Fabrication LLC	American Welding and Fabrication LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Wilder	ID	USA	\N	\N	\N	\N	208-281-7177
86	Eric Greene	American Welding Company, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	West Greenwich	RI	USA	\N	\N	\N	\N	(401) 397-9155
87	Amanda Smith	Americase Fabrication & Construction	amanda@afc-llc.com	972-910-2296	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Office Manager	\N	TX	\N	\N	\N	\N	anthony@afc-llc.com	972-910-2296
88	John Beu	Ameron Pole Products	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tulsa	OK	USA	\N	\N	\N	\N	(918) 585-5611
89	Mark Mosher	Amfab Incorporated	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bernalillo	NM	USA	\N	\N	\N	\N	(505) 867-6737
90	Richard Daines / Dean	Amfab Steel Specialties, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/PM	North Salt Lake	UT	USA	\N	\N	\N	\N	(801) 298-2900
91	Nima ()	Ammco Steel	ammcoinc@aol.com	310-675-8983, 323-772-4874	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	OwnersSon	\N	CA	\N	\N	\N	\N	info@ammcoiron.com, ammcoinc@aol.com	310-675-8983, 323-772-4874
92	AMS Steel LLC	AMS Steel LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Madison Heights	MI	USA	\N	\N	\N	\N	248-282-2218
93	Cheryl Turpen	AMT Metal Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Richmond	CA	USA	\N	\N	\N	\N	(510) 236-1414 x206
94	Patrick McMahon	Am-Tec Designs	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Scandia	MN	USA	\N	\N	\N	pat@am-tec.net (or)  trent@am-tec.net	(651) 433-2339
95	Justin Carrara	Amthor Steel	justincarrara@amthorsteel.com	Tel: (814) 452-4700	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	PA	\N	\N	\N	\N	PCarrara@amthorsteel.com	Tel: (814) 452-4700
96	Anderson Building Materials Co.	Anderson Building Materials Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	St. Joseph	MI	USA	\N	\N	\N	info@abmrack.com	269-983-5543
97	Craig Charnesky	Anderson Charnesky Structural Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating Department	Beaumont	CA	USA	\N	\N	\N	craig@acssinc	(951) 769-5700
98	Don Anderson	Anderson Industrial Contracting	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Baltimore	MD	USA	\N	\N	\N	\N	(410) 525-2537
99	Ed Hobbs	Anderson Steel Supply, Inc	ehobbs@andersonsteel.net	(406)-761-4354 EXT:213	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr PM	\N	MT	\N	\N	\N	\N	\N	(406)-761-4354 EXT:213
100	Ann Arbor Fabrication Inc.	Ann Arbor Fabrication Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ann Arbor	MI	USA	\N	\N	\N	sales@wse1.com	734-424-0674
101	Rick Cook	Anvil Steel	rickc@anvilsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	CA	\N	\N	\N	\N	RickC@AnvilSteel.com	\N
102	Claribel ()	Apache Fabricators	claribel@apachefabricators.com	832-804-6236	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	christian@apachefabricators.com	832-804-6236
103	Jerome Lambert	Apel Steel Corporation	Jerome@apelsteel.net	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cullman	AL	USA	\N	\N	\N	\N	256-739-6280 ext. 115
104	Bob Koch	Apex Steel Corp.	rkoch@apexsteelcorp.com	919-362-6611	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Raleigh	NC	USA	\N	\N	\N	\N	919-362-6611
105	Apollo steel corp	Apollo steel corp	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Niagara Falls	NY	USA	\N	\N	\N	\N	(716) 283-8758
106	Jeff Pelissier	Apollo steel LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Jaffrey	NH	USA	\N	\N	\N	cliff@apollostelllc.com	6035321156
107	Archer day Inc	Archer day Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Avenel	NJ	USA	\N	\N	\N	\N	732-417-0333
108	ERIC FRASZ	Architectural elements LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Lead PM	Bellingham,	WA	USA	\N	\N	\N	\N	3607468205
109	Architectural Iron & Aluminium	Architectural Iron & Aluminium	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mount Clemens	MI	USA	\N	\N	\N	\N	(586) 231-2078
110	Arcorp Structures	Arcorp Structures	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chicago	IL	USA	\N	\N	\N	info@arcorpgroup.com, sales@arcorpgroup.com	866.312.IRON (4766) (p)
111	James	Ardency steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Arlington	TX	USA	\N	\N	\N	james@ardencysteel.com	+1 817-776-1808
112	Karen Edmonston	Area Iron & Steel Works, Inc.	areairon@sbcglobal.net	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	El Paso	TX	USA	\N	\N	\N	\N	(915) 833-9494
113	Mark	Arizona custom iron & fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cottonwood	AZ	USA	\N	\N	\N	\N	Shop: 928-300-9958  (OR) Cell: 928-282-4400
114	Arizona fabrication solutions	Arizona fabrication solutions	arizonafabricationsolutions@gmail.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Queen Creek	AZ	USA	\N	\N	\N	\N	480-703-7842
115	Arizona steel construction	Arizona steel construction	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Goodyear	AZ	USA	\N	\N	\N	\N	623-853-1711
116	Bill Downey	Arlington Structural Steel	bdowney@arlingtonsteel.com	(847)577-2200x234, C:(815)900-8445	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	IL	\N	\N	\N	\N	sales@arlingtonsteel.com	(847)577-2200x234, C:(815)900-8445
117	Randy Stockton	Arning Companies, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cassville	MO	USA	\N	\N	\N	\N	(417) 847-3131 (or) 800-732-5074
118	David / LP Flaster	Arnold Steel Company, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM / Owner	Howell	NJ	USA	\N	\N	\N	lpflaster@arnoldsteel.com	(732) 363-1079
119	Robert Schlatter	Art Iron, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Toledo	OH	USA	\N	\N	\N	\N	(419) 725-2959
120	J. Ashley Seabrook	Ashley Steel Inc.	sales@ashleysteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	North Charleston	SC	USA	\N	\N	\N	info@ashleysteel.com / support@ashleysteel.com	843-552-7400
121	ASI Metal Fabrication & Sales	ASI Metal Fabrication & Sales	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Springfield	IL	USA	\N	\N	\N	\N	217-523-4740
287	Ferman Garrett	Central Alabama Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	USA	\N	\N	\N	ferman@caf-inc.com	205-669-6120/25
122	Jeff ()	Associated Steel Fabricators	jeff@associatedsteelfab.com	281-516-0909	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	TX	\N	\N	\N	\N	?carlos@associatedsteelfab.com	281-516-0909
123	Steve Atchley	Atchley Steel Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Salem	AL	USA	\N	\N	\N	\N	(334) 298-3121
124	Paul Ladakakos / Jason Freeman	Atlantic Bridge & Engineering	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP FABRICATION	Candia	NH	USA	\N	\N	\N	jfreeman@atlanticbr.com	603-601-7487
125	Atlantic constructors Inc	Atlantic constructors Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Richmond	VA	USA	\N	\N	\N	\N	804.222.3400
126	Jason ()	Atlas Iron Works	jason@atlasironworks.com	(314) 383-7200 Jason Cell: 314-363-1377	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	BDM	\N	MO	\N	\N	\N	\N	\N	(314) 383-7200 Jason Cell: 314-363-1377
127	Patti Ramsey (Female)	Atlas Welding & Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	New Castle	DE	USA	\N	\N	\N	\N	(302) 326-1900
128	Atmostfear Fabricationi	Atmostfear Fabricationi	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602-677-7834
129	John St. Marie	Auciello Iron Works	john@aucielloiron.com	978) 568-8382	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	MA	\N	\N	\N	\N	mail@aucielloiron.com	\N
130	Melissa Fulwider	Augusta Iron & Steel Works, Inc	melissa@augustairon.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Purchasing Manager	\N	GA	\N	\N	\N	\N	\N	\N
131	Aura Fabricators Inc	Aura Fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dalton	MN	USA	\N	\N	\N	\N	\N
132	Adrian Nichols	Avenue Fabricating, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Batavia	OH	USA	\N	\N	\N	\N	(513) 752-1911
133	Victor	AWI Builders	victor@awibuilders.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	TopGUy	\N	CA	USA	\N	\N	\N	support@awibuilders.com	(562) 948-1133 (323) 585-2026
134	Jasen Craik	B & A Strctural steel	Jcraik@grilloco.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	\N	USA	\N	\N	\N	\N	586-948-2220
135	Ken Roberts	B & B Fabricators	kenr@bandbfab.com	360-474-0156	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Lead PM	\N	WA	\N	\N	\N	\N	\N	360-474-0156
136	Mike Lifto	B & B Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Knapp	WI	USA	\N	\N	\N	Estimator =  mlifto@b-bsteel.com	715-665-2900
137	Pete Bullock	B&B Steel Fabrication, Inc	\N	Pete: 435-229-2235	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	WA	\N	\N	\N	\N	\N	Pete: 435-229-2235
138	Bryan Weigel	B & C steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Operations Manager	Denver	CO	USA	\N	\N	\N	\N	(303) 297-3842
139	Joe Villareal	B & F Fabricating Inc.	joev@bffabricating.com	(708) 758-7878	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IL	\N	\N	\N	\N	\N	(708) 758-7878
140	Stacy	B & S IRON WORKS LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	NY	USA	\N	\N	\N	stacy@bsironworks.com	(718) 401-4339
141	Barbara Blundell	B Metal Fabrication	barbarab@bmetalfabrication.com	(650)615-7705	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	CFO	\N	CA	\N	\N	\N	\N	jimb@bmetalfabrication.com	(650)615-7705
142	Vincent Belgiovine / John	B&B Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating	Clifton	NJ	USA	\N	\N	\N	estimating@bbironworksinc.com	(862) 238-7203
143	Jackie D Keller / Dan Oldham	B.L.T Steel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Moody	AL	USA	\N	\N	\N	dan@bltsteelfab.com	(205) 702-7085
144	Bach ornamental & structural steel	Bach ornamental & structural steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Holt	\N	USA	\N	\N	\N	nels@bachsteel.com	517-581-6243
145	Nels Raynor	Bach Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	owner	Holt	MI	USA	\N	\N	\N	\N	517-581-6243
146	Baker Industrial Fabrication	Baker Industrial Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Frederick	CO	USA	\N	\N	\N	estimating@bakerindustrialfab.com	720-500-7057
147	Stacy Guess	Baltimore Fabrication	sguess@baltimorefab.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Purchasing and Logistics	\N	MD	\N	\N	\N	\N	Mark@baltimorefab.com	\N
148	Bill frazer (Ex_109)	Baltimore Steel Erectors, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	White Marsh	MD	USA	\N	\N	\N	billf@baltimoresteelerectors.com	+1 410-335-0556
149	Dewayne Minnick	Banker Steel Co., LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lynchburg	VA	USA	\N	\N	\N	\N	(434) 847-4575
150	Ravindra Meesala	Banker Steel Co.	rmeesala@bankersteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	VA	\N	\N	\N	\N	\N	4348474575
151	Kevin McSweeney	Bannon Constrcution Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	San Francisco	CA	USA	\N	\N	\N	\N	(480) 296-6825
152	Bare Metal Fabrication	Bare Metal Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Show Low	AZ	USA	\N	\N	\N	\N	928-240-4514
153	Barker Steel Construction, Inc.	Barker Steel Construction, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tucson	AZ	USA	\N	\N	\N	\N	520-325-6131
154	Randy haricharran	Barone Steel Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Brooklyn,	NY	USA	\N	\N	\N	\N	?+1 718-369-4304
155	Randy Allen	Barry Steel Fabrication, Inc.	rallen@barrysteel.com	716) 433-2144	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	NY	\N	\N	\N	\N	jbarry@barrysteel.com	716) 433-2144
156	Lauren Ranke	Barton Malow Company	lauren.ranke@bmco.com	248) 436-5000	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Design Manager	\N	MI	\N	\N	\N	\N	\N	\N
157	TAYLOR MAGGERT	Barton Supply	tmaggert@barton-supply.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	DETAILING MANAGER	Aurora	CO	USA	\N	\N	\N	Sales@Barton-Supply.Com	303-576-2200 *5910
158	Camil Mfarej	Basden Steel	camil@basdensteel.com	C: 817-965-4329	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	BigBoss	\N	TX	\N	\N	\N	\N	bids@basdensteel.com	C: 817-965-4329
159	Billy Scott/Greg	Basic Machinery Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Siler City	NC	USA	\N	\N	\N	josh_johnson@basicmachinery.com	(919) 663-2244/364
160	Ronald J. Myers/ Kyle Jones	Bass Mechanical, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Elizabethtown	PA	USA	\N	\N	\N	\N	(717) 367-9890
161	Jennifer Davila	Battle Born Steel	jennifer@battlebornsteel.com	702-749-3230 C: 702-580-6841	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	NV	\N	\N	\N	\N	info@battlebornsteel.com	702-749-3230 C: 702-580-6841
371	Otto Schatz	Cornell & Company, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Westville	NJ	USA	\N	\N	\N	\N	(856) 742-1900
162	BCS (or) Beatty Construction Services LLC	BCS (or) Beatty Construction Services LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Loveland	CO	USA	\N	\N	\N	Info@bcsfab.com	+1 720-472-0736
163	Scotty Scott	Bear Creek Fabrication, LLC	sscott@bearcreekfabrication.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sales and Estimates	\N	NC	\N	\N	\N	\N	\N	\N
164	Beck Steel	Beck Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	702-260-8700
165	John Jr./Randy Young/ChrisWidy	Beck Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lubbock	TX	USA	\N	\N	\N	chrisw@becksteel.com	(806) 762-3255
166	David begala	begala & associates	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	Grand Rapids	MI	USA	\N	\N	\N	\N	(317) 322-1555
167	Brad Maust	Beitzel Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Grantsville	MD	USA	\N	\N	\N	\N	(301) 245-4108
168	Jeff Glover	Bell Steel, a Divison of SteelFab	jeff@bell-steel.com	480) 833-5538	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	AZ	\N	\N	\N	\N	rberkley@bellsteel.com	480) 833-5538
169	Allison Russo	Bell Steel Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chandler	AZ	USA	\N	\N	\N	info@bell-steel.com	(480) 833-5538
170	Bell Steel Inc. West Shop	Bell Steel Inc. West Shop	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	1 602-257-8822
171	Kurt Beller	Beller Fabrication Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Canon City	CO	USA	\N	\N	\N	\N	(719) 888-3306?
172	Peter Bagatourian	Ben Ash Iron works Inc	peter@benashiron.com	7143364337	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PRESIDENT	Compton	CA	USA	\N	\N	\N	anand@struzon.com	310.635.0170
173	Alex Willingham	Ben Hur Steel Worx	aaw@benhurconstruction.com	AlexCell (314) 634-6567	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	MO	\N	\N	\N	\N	\N	AlexCell (314) 634-6567
174	Chris Usher	Ben Parker Company, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP of Technical Services	Chattanooga	TN	USA	\N	\N	\N	\N	(423) 697-0088
175	Matt Jarvis	Benchmark Fabricated Steel	matt@benchmarksteel.com	(812) 238-2691	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IN	\N	\N	\N	\N	\N	(812) 238-2691
176	Robert Meierhoff	BendTec, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Duluth	MN	USA	\N	\N	\N	\N	(218) 722-0205
177	Victor Miller	Bennett Steel Fabrication, Inc.	victor@bennettsteel.com	918-227-2564	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr PM	Sapulpa	OK	USA	\N	\N	\N	\N	918-227-2564
178	Bennett Steel LLC	Bennett Steel LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Grand Rapids	MI	USA	\N	\N	\N	\N	616-676-7150
179	Bloomsdale fabrication & welding	Bloomsdale fabrication & welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bloomsdale	MO	USA	\N	\N	\N	\N	\N
180	Bart Reich	Ben's Structural Fabrication	bart.reich@builtbybens.com	320-251-8563	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	Waite Park	MN	USA	\N	\N	\N	info@builtbybens.com	320-251-8563
181	Dawn Schwartz	Benson Steel Fabricators	dawn@bensonsteelfabricators.com	845-246-3066	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Saugerties	NY	USA	\N	\N	\N	Info@bensonsteelfabricators.com	845-246-3066
182	Xavier Diaz	Berger Steel	\N	(916) 640-8778	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Senior Estimator	\N	CA	\N	\N	\N	\N	mark@bergersteel.com	(916) 640-8778
183	Mike Bergh	Bergh's Fabricating, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Willmar	MN	USA	\N	\N	\N	info@steelfabusa.com	(320) 235-7761
184	Dennis Fusini	Berkshire Bridge & Iron Company, Inc.	dennisfusini@gmail.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	MA	\N	\N	\N	\N	\N	\N
185	Catheyn Moser/David	Berlin steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	West Chester	PA	USA	\N	\N	\N	\N	(610) 240-8953
186	Chet Wojtaszek	Berlin Steel / Pillar Enterprise Ltd	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	White Post	VA	USA	\N	\N	\N	\N	(860) 652-5614
187	Timothy Cote	Berlin Steel Construction Co	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Engineering/Detailing  department	\N	CT	USA	\N	\N	\N	\N	(860) 828-3531?
188	Tim Moskall	Berlin Steel/FEI Ltd	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Natural Bridge Station	VA	USA	\N	\N	\N	\N	(860) 828-2542
189	Bill Hodge	Besco Steel Supply	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Birmingham	AL	USA	\N	\N	\N	\N	205-591-2540
190	Bevans steel company Inc	Bevans steel company Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Davenport	IA	USA	\N	\N	\N	\N	0000000000
191	Richard Ashton	Beverly Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Knoxville	TN	USA	\N	\N	\N	\N	(865) 687-7921
192	Tom Rowekamp	Bickers Metal Products, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Miamitown	OH	USA	\N	\N	\N	\N	(513) 353-4000
193	BENJAMIN CHARLES LADNER	Bid lake drafting services LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	LAKE CHARLES	LA	USA	\N	\N	\N	\N	\N
194	Ronda Cross	Big C Industries, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Longview	WA	USA	\N	\N	\N	\N	(844) 406-2442
195	Katie Pitzrick	Birschbach Manufacturing LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Drafter	Fond du Lac	WI	USA	\N	\N	\N	\N	(920)375-0656
196	Ronnie Sparks	BJORK FABRICATION, WELDING & DESIGN	rsparks@bfwdtx.com	(210)-900-9936	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	\N	Off: 210-649-4086/Cell: 210-300-1973
197	Kristi Schlitt	BK Welding	kristi@bkwelding.net	970-685-4435	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	CO	\N	\N	\N	\N	kristi@bkwelding.net	970-685-4435
198	Black & Veatch	Black & Veatch	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Arlington	VA	USA	\N	\N	\N	\N	1 703-243-0938
199	Dustin Ells	Black Label Steel	Dustin@BlackLabelSteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	(602) 354-7739
200	Alan Sleyster	Blattner Steel Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cape Girardeau	MO	USA	\N	\N	\N	plans@blattnersteel.com  = estimator	(573) 339-1129
201	Paul Blouin / Brent Blouin	Blouin Steel Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/ ESTIMATOR	Northfield	NH	USA	\N	\N	\N	paul@blouinsteel.com	(603) 286-7900 / 101
202	Chad Bludau	Bludau Steel, LLC	chad@bludaufab.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	GM	\N	TX	\N	\N	\N	\N	rick@bludaufab.com	\N
288	Matt	Central Construction Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimation department	\N	CT	USA	\N	\N	\N	purchasing@ccict.com	(860)963-8902
203	Mistie ()	Blue Star Steel	mistie@bluestarsteel.com	(801) 908-8302	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating Manager	\N	UT	\N	\N	\N	\N	mistie@bluestarsteel.com	(801) 908-8302
204	David Deibel	Boardman steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Columbiana	OH	USA	\N	\N	\N	\N	1-330-758-0951
205	Bobuco	Bobuco	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	New Orleans	LA	USA	\N	\N	\N	\N	504.949.7553
206	Craig D. Boes	Boes Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	New Orleans	LA	USA	\N	\N	\N	\N	(504) 827-1869
207	Ryan Wheeler	Bohling Steel, Inc	rwheeler@bohlingsteel.com	434) 385-5175	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM / Quality Manager	\N	VA	\N	\N	\N	\N	\N	\N
208	Boise metal works	Boise metal works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Boise	ID	USA	\N	\N	\N	\N	208-376-7777
209	Ron Kemp / Ken/ Bred	Boman & Kemp Mfg.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/GM / bred	Ogden	UT	USA	\N	\N	\N	\N	(801) 731-4138/(801) 731-0615
210	Mickey	Bonita Steel Builders	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	x117	Tucson	AZ	USA	\N	\N	\N	\N	520-293-0440
211	John Piccolomini	Boston Bridge & Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP Engg. & Estimating	East Boston	MA	USA	\N	\N	\N	jpiccolomini@bostonbridgesteel.com	617.569.8373?/ 617 347-0191(cell)
212	Michael Franklin	Boudreauswelding,Co Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Fabrications Supervisor / Estimator	\N	CT	USA	\N	\N	\N	michael@boudreauswelding.com	860 774 2771
213	Tommy Zitting	Bountiful Enterprises	\N	(417) 955-4947	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Quality assurance and safety manager	Humansville	MO	USA	\N	\N	\N	\N	417-276-2520
214	Les Lewis	BP WHITEN	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IN	USA	\N	\N	\N	Leslie.Lewis@bp.com	\N
215	Chris	BR welding Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Howell	NJ	USA	\N	\N	\N	\N	732-363-8253
216	Frank Versace	Brakewell Steel Inc.	frankv@brakewell.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	\N	NY	\N	\N	\N	\N	\N	\N
217	Branch Iron works	Branch Iron works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Alvarado	TX	USA	\N	\N	\N	\N	817-783-5183
218	Kimberly Branch(F)	Branch structural solutions	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cleburne	TX	USA	\N	\N	\N	mohep@branchss.com	(817) 615-9433
219	Tom Mahan	Bratton Steel	tmahan@bratsteel.com	C: 214-837-2181	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	TX	\N	\N	\N	\N	\N	C: 214-837-2181
220	Jay Walsh	Bridgeport steel sales Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chicago	IL	USA	\N	\N	\N	\N	(312)326-4800
221	Rico sardelli	BRINDLEY ENGINEERING	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IL	USA	\N	\N	\N	raccomando@brindleyengineering.com	Office: 630-796-2020 Cell: 815-280-9112
222	Matt Payne	Bristol Steel	mpayne@bristolsteel.com	(810) 658-9510	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	MI	\N	\N	\N	\N	MPayne@BristolSteel.com	(810) 658-9510
223	Joe Pepe	Broadway Steel, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tamworth	NH	USA	\N	\N	\N	joesr@broadwaysteel.net	(603) 323-8592
224	Brett Hartman	Broadwind Heavy Fabrications	brett.hartman@bwen.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	WI	\N	\N	\N	\N	\N	\N
225	David Frazier	Brookfield Fabricating Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating & Sales	Brookfield	MO	USA	\N	\N	\N	lfaulkner@brookfab.com	660-258-2214
226	Stan Watson	Brookfield Fabricating Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Brookfield	MO	USA	\N	\N	\N	\N	(660) 258-2214
227	Jeffery Edison / Joshua Gilbert	Brooklyn Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM / Estimator	Spokane	WA	USA	\N	\N	\N	\N	(509) 468-2310
228	Brute Steel	Brute Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cottonwood	ID	USA	\N	\N	\N	\N	208-962-3738
229	Richard W. Pryor	Buckeye Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Barnesville	OH	USA	\N	\N	\N	\N	(740) 425-2306
230	Buckey's contracting & services inc.	Buckey's contracting & services inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Midland	MI	USA	\N	\N	\N	\N	989-835-9512
231	Brad harmon	Buckner Miscellaneous Iron	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	SOUTH\r\n GRAHAM	NC	USA	\N	\N	\N	amyc@buckercompanies.com	(336) 376-1264
232	Buffalo constrcution Inc	Buffalo constrcution Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Louisville	KY	USA	\N	\N	\N	\N	502-327-4686
233	Thomas Latona	Buffalo Structural Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Titusville	PA	USA	\N	\N	\N	\N	(716) 639-7714/+1 814-827-6245
234	Kathie Kruizenga	Builder's Iron, Inc.	kathiek@buildersiron.com	616) 647-9288	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	\N	MI	\N	\N	\N	\N	info@buildersiron.com	\N
235	Alex Koch	Builders Steel Company	akoch@builders-steel.com	(816) 471-1626	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailier	\N	MO	\N	\N	\N	\N	\N	(816) 471-1626
236	Builders steel supply	Builders steel supply	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lilburn	GA	USA	\N	\N	\N	\N	2
237	Fermin	Building Envelope systems	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Coordinator	?Plainville	MA	USA	\N	\N	\N	fermin@teambes.com / info@teambes.com	?508-381-0429 ?/ 102
238	Building Supply Group	Building Supply Group	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Waunakee	WI	USA	\N	\N	\N	bsginfo@erdman.com	(608) 410-8400
239	Angela /James nick Sr	Bulldog Ironworks LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Waxahachie	TX	USA	\N	\N	\N	\N	(972) 935-0575
240	Bunger Steel	Bunger Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	sales@bungersteel.com.	623-936-7181
241	Burgess steel	Burgess steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Englewood	NJ	USA	\N	\N	\N	\N	201-567-1675
242	Bo Burt	Burt Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Montgomery	AL	USA	\N	\N	\N	getinfo@BurtSteel.com	(334) 265-9268
243	Troy Johnson	C & F Steel Company, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hamilton	TX	USA	\N	\N	\N	troy_johnson@candfsteel.com	(254) 386-8847
244	Estimation Department	C & K Johnson Industries, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Arcata	CA	USA	\N	\N	\N	dwattenbarger@ckjohnsonind.com	(707) 822-7688
245	C& S Engineering & design group	C& S Engineering & design group	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albany	NY	USA	\N	\N	\N	\N	732-292-4490
246	Thomas Dews	C. L. Dews and Sons Foundry and Machinery, Co., Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hattiesburgh	MS	USA	\N	\N	\N	\N	(601) 582-4427
247	Bobby Aguirre	C. S. Aguirre and Sons	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Odessa	TX	USA	\N	\N	\N	\N	(432) 381- 5221
248	Andrew Toland / rey trias	C.E Toland & son	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator/detailing Manager	Benicia	CA	USA	\N	\N	\N	rey_t@cetoland.com	707-747-1000 / 232
249	C.H.Yarber construction	C.H.Yarber construction	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cheyenne	WY	USA	\N	\N	\N	\N	\N
250	Ron Miller	C.M. Steel Inc.	rmiller@cm-steel.com	803-619-1075	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Chief Estimator	York	SC	USA	\N	\N	\N	\N	803-619-1075
251	Janet Witter / Ali	C.T. and S. Metalworks	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Irving	TX	USA	\N	\N	\N	ali@ctands.com	(972) 554-9629
252	Karla Hansen	CAB Construction	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mankato	MN	USA	\N	\N	\N	\N	(507) 625-2233
253	Cadillac Fabrication	Cadillac Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cadillac	MI	USA	\N	\N	\N	\N	(231) 775-1600
254	Cadvanced design Inc	Cadvanced design Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Painesville	OH	USA	\N	\N	\N	\N	+1 440-357-7529
255	Detailing department	CAID Industries, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tucson	AZ	USA	\N	\N	\N	\N	(520) 294-3126
256	Calfab inc	Calfab inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Boise	ID	USA	\N	\N	\N	\N	(208) 333-0099
257	Daniel	California steel Fab Inc/ S & B Sons US	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Structural Engineer/Senior Estimator	Bakersfield	CA	USA	\N	\N	\N	dsierra@sbsonsus.com / info@sbsonsus.com / Benny@californiasteelfab.com / Jerry@californiasteelfab.com / Renato@californiasteelfab.com	(661) 392-9100
258	Brian K. Callaway, President	Callaway  detailing company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	St. Joseph	MO	USA	\N	\N	\N	brian@callawaydetailing.com	?(816) 676-0780
259	Cam Fab	Cam Fab	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Martin	MI	USA	\N	\N	\N	\N	1 269-685-1000
260	Greg Householder	Cambria Welding & Fabricating, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Carrolltown	PA	USA	\N	\N	\N	8149375071 cell	(814) 948-5072/103
261	Sarah Kudebeh	Camelot Metals, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Blaine	MN	USA	\N	\N	\N	\N	(651) 636-3450
262	David Fowler	Campbell & Shaw Steel, Inc	\N	810-364-5100 Ext. 104	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Ch.estimator	Marysville	MI	USA	\N	\N	\N	\N	810-364-5100
263	Campbell certified Inc	Campbell certified Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oceanside	CA	USA	\N	\N	\N	Estimating@campbellcertified.com	760-722-9353
264	Ralph Poulin	Canatal Industries	rpoulin@canatal.net	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	\N	\N	CANADA	\N	\N	\N	\N	\N
265	Tom Baggett	Canyon Steel Fabricators	tbaggett@canyonsteelfab.com	951) 683-2352 Blake: (909)615-0250	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	CA	\N	\N	\N	\N	jdavenport@canyonsteelfab.com	951) 683-2352 Blake: (909)615-0250
266	Kelli (Mock) Hart	Capco steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Capco steel	TX	USA	\N	\N	\N	\N	(210) 493-9992
267	Nicole Refino	Capco Steel Erection Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Providence	RI	USA	\N	\N	\N	\N	(401) 383-9388
268	Capital Steel & builders supply	Capital Steel & builders supply	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Holt	MI	USA	\N	\N	\N	\N	517-694-0451
269	Capitol Engineering Co.	Capitol Engineering Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602-252-5754
270	Ruben Reyes	Capitol Iron Works	ruben@capitolironworks.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	CA	USA	\N	\N	\N	steve@capitolironworks.com	(916)381-1554 x3026
271	James moran	Capitol steel fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	DETAILER	Commerce	CA	USA	\N	\N	\N	carol.travischavez@capitolsteel.com, erik.santizo@capitolsteel.com	323-721-5460
272	Alex Aleman	Capitol Steel Structures	alex@capitolsteelstructures.com	305-633-5008	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr Estimator	Miami	FL	USA	\N	\N	\N	\N	305-633-5008
273	Cardinal fabricatiing Corporation	Cardinal fabricatiing Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Milwaukee	WI	USA	\N	\N	\N	\N	\N
274	Cardinal Fabricating Corporation	Cardinal Fabricating Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Milwaukee	WI	USA	\N	\N	\N	\N	414.744.9700
275	Cardinal fabricating inc.	Cardinal fabricating inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	\N	USA	\N	\N	\N	\N	\N
276	Nelson Carlo	Carlo steel corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chicago	IL	USA	\N	\N	\N	Number not in service	773-375-9600
277	Patrick Halligan	Carolina Fabricators Inc	phalligan@carolinafab.com	803-794-4906 C: 803-383-2033	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sales Manager	\N	SC	\N	\N	\N	\N	\N	803-794-4906 C: 803-383-2033
278	Jeff Matuszak	Carolina Metal Fabrications	jmatuszak@cm-fabricators.com	C: 919-880-9865	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	NC	\N	\N	\N	\N	sales@cm-fabricators.com	C: 919-880-9865
279	Eric Epshteyn	Casadei Structural Steel Inc	eepshteyn@casadeisteel.com	586-698-2898	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP of Estimating and Operations	Sterling Heights	MI	USA	\N	\N	\N	info@casadeisteel.com	586-698-2898
280	Casco & Sons	Casco & Sons	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Livonia	MI	USA	\N	\N	\N	cascostephen@gmail.com  - ESTIMATING	(248) 579-8979
281	Bryon Tait	Casco Bay Steel Structures, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	South Portland	ME	USA	\N	\N	\N	\N	(207) 780-6722
282	Tony	Castle Steel Inc	tonyz@castlesteelinc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	(602) 243-2766
283	Sharon Sowers	Cateck, Inc. dba Commercial Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	St. Peters	MO	USA	\N	\N	\N	\N	(636) 928-1086
284	Cave's canopies and steel	Cave's canopies and steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Apache Junction	AZ	USA	\N	\N	\N	\N	480-982-0890
285	Vic Dent/maily	Cayce Steel Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cayce	SC	USA	\N	\N	\N	\N	(803) 794-1736
286	Todd Wandro	Cedar Valley Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cedar Rapids	IA	USA	\N	\N	\N	\N	319.373.0291
289	Central Iowa Fabrication	Central Iowa Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IA	USA	\N	\N	\N	\N	0000000000
290	Jack Winder	Central Metals, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Camden	NJ	USA	\N	\N	\N	\N	(856) 963-5844
291	Don Mord	Central Minnesota Fabricating, Inc. (CMF)	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Willmar	MN	USA	\N	\N	\N	\N	(320) 214-5255
292	Central Steel Fabricators Inc.	Central Steel Fabricators Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IL	USA	\N	\N	\N	sales@centralsteelfab.com	708-652-2037
293	Kelly Bonta	Central Steel, Inc.	kelly@centralsteelinc.com	316-265-8639	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Wichita	KS	USA	\N	\N	\N	\N	316-265-8639
294	Jeff Squyres	Central Texas Iron Works	jsquyres@ctiw.com	254-776-8000	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating Manager	Waco	TX	USA	\N	\N	\N	rfoil@ctiw.com	254-776-8000
295	Diego Aguilar	Central Valley Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	Stockton	CA	USA	\N	\N	\N	\N	(209) 948-6448.
296	Carlo Zenti	Central Western Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Atlantic	IA	USA	\N	\N	\N	\N	(712) 243-4000
297	Greg Sheets	Century Steel Fabricating, Inc.	gregsheets@comcast.net	317-834-1295	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IN	\N	\N	\N	\N	\N	317-834-1295
298	Chambers Welding & Fabrication Corp.	Chambers Welding & Fabrication Corp.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chattanooga	TN	USA	\N	\N	\N	Chambersweldingteam@gmail.com	(423) 401-0422
299	Noah Dell	Champion Bridge Company	noah@steelchampion.com	937-382-2521	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	Wilmington	OH	USA	\N	\N	\N	\N	937-382-2521
300	Brian Jones	Chaparral Welding & Fabrication	bjones@chaparralwelding.com	972-243-7747	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	TX	\N	\N	\N	\N	bjones@chaparralwelding.com	972-243-7747
301	Charles Ladner & Associates Inc	Charles Ladner & Associates Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lake Charles	LA	USA	\N	\N	\N	\N	\N
302	Ryan Smith	Charleston Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	________	Dunbar	WV	USA	\N	\N	\N	\N	(800) 627-6601
303	John IV	Charleston Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dunbar	WV	USA	\N	\N	\N	\N	(800) 627-6601
304	Charleston steel warehouse & fabrication	Charleston steel warehouse & fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dunbar	VA	USA	\N	\N	\N	\N	(800) 627-6601
305	Jason Riddell	Chattanooga Boiler & Tank Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chattanooga	TN	USA	\N	\N	\N	\N	(423) 755-6721
306	Keith Overfield	cHc Manufacturing, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Cincinnati	OH	USA	\N	\N	\N	\N	(513) 821-7757
307	Checkpoint Fabrication	Checkpoint Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Marrero	LA	USA	\N	\N	\N	\N	504-340-0770
308	BILL	Cherokee Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	RETIRED ESTIMATOR	PL Lebanon	TN	USA	\N	\N	\N	info@cherokeesteel.net	6155474490
309	David Ford/William ford	Cherokee Steel Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	White Oak	TX	USA	\N	\N	\N	david.ford@cherokeesteelfabricators.com	(903) 759-3866/+1 903-759-3844
310	Sam Jimenez	Chesapeake Bay Steel	sjimenez@chesbaysteel.com	757.622.2520 Sams Cell: 720-323-2563	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	VA	\N	\N	\N	\N	\N	757.622.2520 Sams Cell: 720-323-2563
311	Ronald Baskins	Chesapeake Bay Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Norfolk	VA	USA	\N	\N	\N	\N	(757) 622-2520
312	Chicago Metal Fabricators	Chicago Metal Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chicago	IL	USA	\N	\N	\N	sales@chicagometal.com	773.523.5755
313	Kara L. Rounkles	Chillicothe Iron & Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chillicothe	MO	USA	\N	\N	\N	\N	(660) 646-2250
314	CODY LAKENEN	Chocolay Ironworks LLC | Welding & Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP & Project Manager	Marquette	MI	USA	\N	\N	\N	\N	(906) 361-6400
315	Raymond Shortsleeve/Rob Bagley	Cianbro Fabrication & Coating Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Ch.Draftsman	Georgetown	MA	USA	\N	\N	\N	\N	(978) 234-5314
316	Jeremy Rodrigue	Cives Steel, NE Division	jrodrigue@cives.com	(207) 622-6141	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating Manager	\N	ME	\N	\N	\N	\N	civessouthwest@cives.com	\N
317	Tyson Ward	Cives Steel Company, North-West Division (Fabrication Facility)	tward@cives.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating Manager	\N	ID	\N	\N	\N	\N	civesnorthwest@cives.com	\N
318	Clark construction Group	Clark construction Group	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bethesda	MD	USA	\N	\N	\N	\N	(301) 272-8100
319	Dan Hefner	Clark Machine Corp.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Baltimore	MD	USA	\N	\N	\N	\N	(410) 687-3020
320	kevin/Gabe Vega	Clark Steel Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Lakeside	CA	USA	\N	\N	\N	Rick@ClarkSteelFab.com, kevin@ClarkSteelFab.com	(619) 390-1502
321	Kenneth Miller	Clermont Steel Fabricators, LLC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Batavia	OH	USA	\N	\N	\N	\N	(513) 732-6033
322	Marvin Turner	CMC Alamo Steel Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Waco	TX	USA	\N	\N	\N	\N	(254) 799-2471
323	CMC steel Fabricators	CMC steel Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Seguin	TX	USA	\N	\N	\N	\N	830-372-8200
324	Mike Morris	CNC Metal Shape Construction, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oklahoma City	OK	USA	\N	\N	\N	\N	(405) 380-6085
325	Yong Kim	Coast Iron & steel co	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	Santa Fe Springs	CA	USA	\N	\N	\N	\N	+1 562-946-4421
326	Carl F. Ducote	Coastal Metal Works LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Picayune	MS	USA	\N	\N	\N	coastalmetalworks@cox.net	(504) 738-1793
327	Estimating department	Coastal steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cocoa	FL	USA	\N	\N	\N	\N	321-632-8228
328	Daisy Wilson	Coastline steel corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	Los Angeles	CA	USA	\N	\N	\N	\N	310-764-0227
329	David Wilkins	Cobb Industrial Fabricators	dwilkins@cobbfab.com	770-422-7054     EXT 228	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Acworth	GA	USA	\N	\N	\N	\N	770-422-7054
330	Matt Aurand	Cobb Industrial	daurand@cobbindustrialinc.com	678-581-COBB MattC: 678-557-4382	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	GA	\N	\N	\N	\N	\N	678-581-COBB MattC: 678-557-4382
331	Corey	CoBuilt LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Senior Estimator	Memphis	TN	USA	\N	\N	\N	sales@cobuilt.com	(901) 775-9050
332	Winston W. Cole	Cold Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Farmington	NM	USA	\N	\N	\N	\N	(505) 326-2327
333	Brian Bennett	Columbia Building Products Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Olmsted Falls	OH	USA	\N	\N	\N	\N	(440) 235-3363
334	Gary Corso / Scott Van Raden	Columbia Industries, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Eng.Manager	Hillsboro	OR	USA	\N	\N	\N	\N	(503) 531-0600
335	Jon ryther	Columbia Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	Rialto	CA	USA	\N	\N	\N	jryther@csirialto.com	(909) 874-8840
336	David	Columbian Iron works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Paterson	NJ	USA	\N	\N	\N	columbianironworks@yahoo.com	+1 973-684-2303
337	Commercial Fabricating and Engineering, Inc.	Commercial Fabricating and Engineering, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Highland	MI	USA	\N	\N	\N	cfeadmin@comfab.us	(248) 887-1595
338	John Tucker	Commercial fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Newton	NC	USA	\N	\N	\N	\N	828) 465-1010
339	Commercial metal company	Commercial metal company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Irving	TX	USA	\N	\N	\N	\N	214.689.4300
340	Ronald McMonigle	Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Louisville	KY	USA	\N	\N	\N	\N	(502) 361-5445
341	Concentric Steel	Concentric Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Detroit	\N	USA	\N	\N	\N	\N	(313) 401-6365 (doubt)
342	Eric Ruiz	Concord Fabricators Inc.	eruiz@concordfab.com	D: 614-957-5917 / C: 614-560-7673	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Structural PM & Detailing	\N	OH	\N	\N	\N	\N	bhitchcock@concordfab.com	D: 614-957-5917 / C: 614-560-7673
343	Briton Kitching	Cutting edge steel Inc	\N	303-659-3180	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Director of Engineering	Dacono	CO	USA	\N	\N	\N	\N	303-659-3180
344	Hector Acosta	Concord Iron Works	hacosta@concordiron.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Pittsburg	CA	USA	\N	\N	\N	mbiddle@concordiron.com	O:(925)432-0136, C:(925)250-2256
345	John Hagarman/ Jeffry Miles	Conewago Enterprises, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hanover	PA	USA	\N	\N	\N	\N	(717) 632-7722/
346	R Von Klotzbach	Con-Fab Engineering & Welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Shreveport	LA	USA	\N	\N	\N	\N	(318) 861-1282
347	Conley Steel, Inc.	Conley Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Naperville	IL	USA	\N	\N	\N	\N	(630) 851-0022
348	Paul ()	Connected Structural Group	manager@connectedsg.com	(702) 804-1535	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	NV	\N	\N	\N	\N	office@connectedsg.com	(702) 804-1535
349	Constructon GC	Consigli construction	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Boston	MA	USA	\N	\N	\N	\N	\N
350	John/Chris	Consolidated Steel Services, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fallentimber	PA	USA	\N	\N	\N	Jzack@Csteel.com	(814) 944-5890
351	Steve Jaksa	Construct, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Wilson	NC	USA	\N	\N	\N	tbarbee@constructwilson.com	(252) 246-0639?
352	Jack Kriesel	Construction Resources Group	jack@constrg.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Russelville	AR	USA	\N	\N	\N	bids@constrg.com	(479) 968-5416
353	Wayde Henrie	Construction Steel	whenrie@constructionsteelinc.com	O: 435-586-6380 C: 435-592-2896	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	UT	\N	\N	\N	\N	whenrie@constructionsteelinc.com	O: 435-586-6380 C: 435-592-2896
354	Thomas Henke	Construction Supply & Erection, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Germantown	WI	USA	\N	\N	\N	aheinze@cseconstruction.com	(262) 255-3003
355	Construction supply and erection	Construction supply and erection	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Germantown	WI	USA	\N	\N	\N	\N	262-255-3003
356	Wyman Haberer	Construction Systems, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Maple Plain	MN	USA	\N	\N	\N	info@csiminnesota.net	(763) 479-1717
357	Joe Cornelius	Continental Steel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kansas City	MO	USA	\N	\N	\N	\N	(816) 471-7200
358	Contract fabrications	Contract fabrications	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Holly Springs	MS	USA	\N	\N	\N	sales@contractfab.com	662-252-6330
359	Spencer Reed	Contracting engineering consultants	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	General Manager	Maidsville	WV	USA	\N	\N	\N	info@cecsteel.com	(304) 598-3055
360	Spencer Reed	Contracting Engineering Consultants, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Maidsville	WV	USA	\N	\N	\N	\N	(304) 554-0302
361	Contractor Service & Fabrication, Inc.	Contractor Service & Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Decatur	AL	USA	\N	\N	\N	\N	(256) 350-3303
362	Steven Holladay	Contractors Steel Supply Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	USA	\N	\N	\N	seholladay@contractors-steel.com	334-284-8213
363	Cooper fabrication LLC	Cooper fabrication LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Post falls	ID	USA	\N	\N	\N	\N	208-777-0114
364	Chad Johnson	Cooper Steel	cjohnson@coopersteel.com	931-684-7962	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	Shelbyville	TN	USA	\N	\N	\N	\N	931-684-7962
365	Josh Bobo	Cooper Steel of Virginia	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Monroe	VA	USA	\N	\N	\N	\N	(931) 488-2114
366	Cooper steel south	Cooper steel south	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Childersburg	AL	USA	\N	\N	\N	\N	1
367	Coosa Valley Steel Co. Inc.	Coosa Valley Steel Co. Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Attalla	AL	USA	\N	\N	\N	\N	256.538.3734
368	CopperSmith Inc. Steel Fabricators	CopperSmith Inc. Steel Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Flowery Branch	GA	USA	\N	\N	\N	Info@coppersmithinc.com	(770) 967-8002
369	Corcoran Fabrication	Corcoran Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Alsip	IL	USA	\N	\N	\N	\N	708-407-5506
370	Core Brace	Core Brace	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pocatello	ID	USA	\N	\N	\N	\N	(801) 280 - 0701
372	Nino Corsetti	Corsetti Structural Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Joliet	IL	USA	\N	\N	\N	\N	815.726.4083
373	Corson Fabricating LLC	Corson Fabricating LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	St. Clair	\N	USA	\N	\N	\N	\N	(810) 553-6871
374	Costa Fab	Costa Fab	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rathdrum	ID	USA	\N	\N	\N	office@costafab.com	+1 (208) 719-9005
375	Bob Windle	Cos-Win, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pine Forge	PA	USA	\N	\N	\N	\N	(610) 323-8560
376	Philip Benza / Kevin Marino	County Fabricators, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pleasantville	NY	USA	\N	\N	\N	kmarino@countyfabricators.com	(914) 741-0219/309(kevin)
377	James Turner	Covenant Steel Warehouse, Inc.	jturner@covenantsteel.com	334 794-2326 ext 104	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dothan	AL	USA	\N	\N	\N	\N	334 794-2326 ext 104
378	Tom ()	CoWelco Steel Contractors	tthigpen@cowelco.com	562-432-5766	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	CA	\N	\N	\N	\N	tthigpen@cowelco.com	562-432-5766
379	Russell Cox	Cox Brothers Machining, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Jackson	MI	USA	\N	\N	\N	\N	(517) 796-4662
380	Cox Design & Metal Fabrication	Cox Design & Metal Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Altoona	IA	USA	\N	\N	\N	\N	515-967-6969
381	Aaron Laird	COX Industrial Services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AZ	USA	\N	\N	\N	\N	(928) 341-9489
382	Dean Rick	CREATION IRON LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Washington	DC	USA	\N	\N	\N	drick@creationironllc.com	202-726-5510
383	Dragan Savich	Crest Metal craft Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chicago	IL	USA	\N	\N	\N	\N	7739780950
384	John Crocker	Crocker Steel Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Terrell	TX	USA	\N	\N	\N	realsteel@sbcglobal.net	?972-551-0525
385	Mike Cannady	Crowder Industrial Construction LLC	mcannady@crowderusa.com	864-661-1728	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Quality Control	Spartanburg	SC	USA	\N	\N	\N	\N	864-661-1757 C: 864-542-3106
386	Brock ()	Crown Fabricators	brock@crownfabricators.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	NV	\N	\N	\N	\N	info@crownfabricators.com	\N
387	Crown Steel Fabrication	Crown Steel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TN	USA	\N	\N	\N	\N	\N
388	Brian Rush	Crystal Metalworks, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hatfield	PA	USA	\N	\N	\N	\N	(703) 686-6853
389	Alex Whitacre	Crystal Steel Fabricators, Inc. - Memphis	\N	901.867.3859 # 403	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP - Operations at Memphis	Arlington	TN	USA	\N	\N	\N	\N	901.867.3859 # 403
390	Barbara Welsandt	Crystal Steel Memphis, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Gallaway	TN	USA	\N	\N	\N	\N	(901) 867-3859
391	Mark Nelson / David	CSD Services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Parkwood	TX	USA	\N	\N	\N	sales@csdservices.com	281-992-0888
392	Mike Hanneman	Cubic Designs, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Waupaca	WI	USA	\N	\N	\N	\N	(715) 256-9292
393	TOM COOP	Cumberland Welding and Fabrication	coop@cumberlandweldingfabrication.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	TN	USA	\N	\N	\N	\N	(615) 610-2689
394	Lisa Cundiff / Jeff Cundiff	Cundiff Steel Fabricators & Erectors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/Estimator & Pm	Louisville	KY	USA	\N	\N	\N	\N	(502) 366-9133
395	Curtis Steel Co. Inc.	Curtis Steel Co. Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	702-952-3000
396	Lindsay Freeman	Custom Fabrication & Engineering, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Fort Smith	AR	USA	\N	\N	\N	\N	(479) 782-6535
397	Jeff Ruckenbrod	Custom Fabrications and Coatings	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Granite City	IL	USA	\N	\N	\N	\N	(618) 452-9540
398	Brian P Grace	Custom Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Coventry	RI	USA	\N	\N	\N	\N	(401) 826-3310
399	Jeremy Ingram	Custom metals	jeremyi@lexcion-inc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Director of Plant Operations	Little Rock	AR	USA	\N	\N	\N	\N	501-490-4400
400	Custom steel	Custom steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lavalette	WV	USA	\N	\N	\N	\N	\N
401	Scott Longdo	Custom Steel Inc.	scott.longdo@customsteelinc.com	715-355-1300	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Structural Steel Manager	Schofield	WI	USA	\N	\N	\N	\N	715-355-1300
402	Custom Steel Service Inc	Custom Steel Service Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ames	IA	USA	\N	\N	\N	\N	515-233-1075
403	Custom structural Inc.	Custom structural Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Big Bend, Waukesha	WI	USA	\N	\N	\N	\N	262-662-3556
404	Cutter Steel & Contracting	Cutter Steel & Contracting	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Marana	AZ	USA	\N	\N	\N	\N	(520) 268-7864
405	Jessica Almada	Cutting Edge Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tucson	AZ	USA	\N	\N	\N	\N	(520) 791-3394
406	Cyclops Welding & Manufacturing Co.	Cyclops Welding & Manufacturing Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	La Salle	IL	USA	\N	\N	\N	\N	815-223-0685
407	Cypress fabrication services	Cypress fabrication services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	LA	USA	\N	\N	\N	\N	\N
408	D & A Fabrications inc	D & A Fabrications inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Urbana	IA	USA	\N	\N	\N	\N	319-533-4702
409	D & D welding & fabrication LLC	D & D welding & fabrication LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mukilteo	WA	USA	\N	\N	\N	\N	425-315-8505.
410	D & F steel	D & F steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Idaho Falls	ID	USA	\N	\N	\N	\N	208-552-6215
411	Matt White	D & L Fabricating	mwhite@dnlfab.com	602) 253-4922	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	AZ	\N	\N	\N	\N	mwhite@dnlfab.com	602) 253-4922
412	Joe Martinez	D & E Steel Services	\N	303-427-4804	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	CO	\N	\N	\N	\N	\N	303-427-4804
413	Casey Drysdale	D&D Welding and Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cove	UT	USA	\N	\N	\N	casey@d-dwelding.com	(435) 258-2499
414	Travis Crumpton	D & T steel, Inc.	travis@dtsteelinc.com	803-894-6005	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Pelion	SC	USA	\N	\N	\N	info@dtsteelinc.com	803-894-6005 C: 803-600-7301
415	Call the reception	D.Cronin's welding servic Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lawrence	MA	USA	\N	\N	\N	\N	(978) 664-4488
416	D.S. Duggins Welding Inc	D.S. Duggins Welding Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Winston-Salem	NC	USA	\N	\N	\N	admin@dugginswelding.com	336-924-5484
417	D5 iron works LLC	D5 iron works LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Union	IL	USA	\N	\N	\N	\N	847.516.1172
418	Steven Daigle	Daigle Brothers, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tomahawk	WI	USA	\N	\N	\N	\N	(715) 453-4999
419	Kevin Anderson	DAKA fabrication - structural steel - Joist & Deck	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pine City	MN	USA	\N	\N	\N	metal@dakacorp.com	(320) 629-6737
420	Hunter Wright	Daniel Iron a DBA of Vulcan Fabricated Metals, Inc.	\N	205-868-3071	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Birmingham	AL	USA	\N	\N	\N	rbenson@danieliron.com	(205) 655-7869
421	Bernie Schaber	Dan's Welding & Machine, LLC	\N	(775) 225-6579	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sparks	NV	USA	\N	\N	\N	danswelding1@yahoo.com	775-358-2254
422	Bruce Merrick	Dant Clayton Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Louisville	KY	USA	\N	\N	\N	\N	(502) 634-3655
423	Sam Moore	Dark Horse Industrial Services, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Idaho Falls	ID	USA	\N	\N	\N	skm.darkhorse@gmail.com	(208) 520-7305
424	David McCurry	Dave Steel Company	dmccurry@davesteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr Estimator	\N	NC	\N	\N	\N	\N	info@davesteel.com	\N
425	Canyon Wilson	Davis Iron Works	canyon.wilson@davisiron.com	254) 666-1000	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	TX	\N	\N	\N	\N	\N	\N
426	Kevin Richie/Michael Irvine	Davis Iron works Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Ch.estimator/Ch.draftsman	Charter Twp	MI	USA	\N	\N	\N	\N	+1 248-624-5960
427	Amanda Morris	DCM Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Orange	TX	USA	\N	\N	\N	\N	4093304923
428	Donald ()	DE Steel	donald@desteelinc.com	(719) 573-7887	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	CO	\N	\N	\N	\N	donald@desteelinc.com	(719) 573-7887
429	Delongs, Inc	Delongs, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Jefferson City	MO	USA	\N	\N	\N	\N	\N
430	Delong's, Inc	Delong's, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Jefferson City	MO	USA	\N	\N	\N	\N	573-635-6121
431	Liz Maczik	Delta Steel Inc.	liz@deltasteelinc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President/CEO	\N	MI	\N	\N	\N	\N	\N	\N
432	Delta structural steel services	Delta structural steel services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Idaho Falls	ID	USA	\N	\N	\N	\N	208-528-6110
433	Peter Doctors	Delta Welding & Fabrication	peter@delta-fabrication.com	O:(805)685-8008, C:(805)450-0737	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	\N	CA	\N	\N	\N	\N	peter@delta-fabrication.com	O:(805)685-8008, C:(805)450-0737
434	deltamachineinc	deltamachineinc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Baton Rouge	LA	USA	\N	\N	\N	\N	\N
435	Matt Dougherty	Deluxe Welding Inc. (R & D Welding)	mattd@rdwstructural.com	775-329-6029	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	\N	NV	\N	\N	\N	\N	\N	775-329-6029
436	Paul devincentz	Delvania Industrial fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pine Forge,	PA	USA	\N	\N	\N	pdevincentz@delvania.com	(484) 624-8480
437	Jimmy Huisenga	Dennis Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Leander	TX	USA	\N	\N	\N	jhuisenga@dennissteel.com	(512) 259-4001
438	Larry Spikes	Derby Trailer Technologies, LLC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Derby	KS	USA	\N	\N	\N	\N	(316) 788-3331
439	Des Moines Metal Fabrication	Des Moines Metal Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Des Moines	IA	USA	\N	\N	\N	\N	515-244-5474
440	Desert Fabrications Inc.	Desert Fabrications Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602-233-1661
441	Ron Wedewer	Design Build Structures LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Peosta	IA	USA	\N	\N	\N	\N	0000000000
442	Jim Schmidt / Brian H.	DHSteel Products, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Erie	PA	USA	\N	\N	\N	\N	(814) 450-2715
443	Jack Dietrich	Dietrich Iron works Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Operations Manager / Estimating	Santa Cruz	CA	USA	\N	\N	\N	\N	(831) 426-5577
444	Wendy Gintz	DIS-Tran Steel, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pineville	LA	USA	\N	\N	\N	\N	318-448-0274
445	Jim Mattin	DiversaTech Metalfab	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Gridley	IL	USA	\N	\N	\N	\N	248 585-0493
446	Diversatech metalfab llc	Diversatech metalfab llc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Gridley	IL	USA	\N	\N	\N	nsurma@diversatech-metalfab.com, jmattina@diversatech-metalfab.com, msurma@diversatech-metalfab.com	(309) 747-4159
447	Diversified steel fabricators	Diversified steel fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Wetumpka	AL	USA	\N	\N	\N	\N	334-567-2955
448	Diversified Welding and Fabrication	Diversified Welding and Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Holland	MI	USA	\N	\N	\N	sales@dwfab.com	(616) 738-0400
449	John MacDowell	Division 5 Inc	\N	770-577-0355 EXT  320	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Winston	GA	USA	\N	\N	\N	estimatingdepartment@division5inc.com	770-577-0355
450	Division 5 Metal Works	Division 5 Metal Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kalamazoo	MI	USA	\N	\N	\N	\N	269-492-0355
451	Robert Dove	Division 5 Metals Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Burlington	NC	USA	\N	\N	\N	\N	+1 336-395-8738
452	Alina Valdez	Division 5 Steel, Inc.	alina@division5steel.com	904-964-4513	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	HeadLady	Starke	FL	USA	\N	\N	\N	Alina@division5steel.com	904-964-4513
453	Roy W. Prescott	Division Five, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hollywood	SC	USA	\N	\N	\N	\N	(843) 889-1199
454	Justin Smith	Dixie Metal Products, Inc.	justinsmith@dixiemetals.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Director of Project Management	Ocala	FL	USA	\N	\N	\N	estimating@dixiemetals.com	3528732554
455	John Snipes	Dixie Southern Industrial, Inc.	johnsnipes@dsisteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	Polk City	FL	USA	\N	\N	\N	estimating-sales@dsisteel.com	863-984-1900 x100
456	DoBro Steel	DoBro Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Gallatin	TN	USA	\N	\N	\N	info@dobrosteel.com	615.989.1128
457	Chris Vlk/Greg Burnett	Dobson Industrial Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner/PM	Bay City	MI	USA	\N	\N	\N	\N	(989) 684-7131/(800) 298-6063
458	John Marquard	Doing Steel, Inc.	jmarquard@doingsteel.com	417-866-5020	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Springfield	MO	USA	\N	\N	\N	jmarquard@doingsteel.com	417-866-5020
459	Dominion steel specialities	Dominion steel specialities	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lafayette	LA	USA	\N	\N	\N	\N	337-233-4434
460	Donald Chase	Donald's Welding, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chinquapin	NC	USA	\N	\N	\N	\N	(910) 298-5234
461	Jason Alvarez	Donner Steel Works Inc	jalvarez@donnersteelworks.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	NE	\N	\N	\N	\N	\N	\N
462	Tony Spencer	Doral Corporation	tony.spencer@doralcorp.net	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	WI	\N	\N	\N	\N	\N	\N
463	Dothan Steel Fabricators LLC	Dothan Steel Fabricators LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	USA	\N	\N	\N	\N	334-677-1588
464	Chris Lowe	Douglas Steel Fabricating Company	clowe@douglassteel.com	517) 322-2050	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Engineering Manager	\N	MI	\N	\N	\N	\N	SalesInquiry@DouglasSteel.com	517) 322-2050
465	Ervin Tarkhanian	Dragon steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Sun Valley	CA	USA	\N	\N	\N	\N	818.252.4840
466	Drake-Williams Steel Inc.	Drake-Williams Steel Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Aurora	CO	USA	\N	\N	\N	\N	+1 303-721-9500
467	Kyle Fitch	Drake-Williams Steel, Inc.	kfitch@dwsteel.com	402-943-3431	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP Engineering	Omaha	NE	USA	\N	\N	\N	kblack@dwsteel.com	Direct: 402-943-3475 Cell: 402-350-2858
468	Martin Kossick	DuBose National Energy Services, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Clinton	NC	USA	\N	\N	\N	\N	(910) 590-2151
469	Jakob Hales	Ducworks, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Engg.manager	Logan	UT	USA	\N	\N	\N	\N	(435) 792-4667 / 222
470	Duke & Duke services Inc	Duke & Duke services Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Taylor	MI	USA	\N	\N	\N	\N	734 941-6050
471	Dungeon Steel	Dungeon Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Nashville	TN	USA	\N	\N	\N	\N	615-479-7027
472	Elizabeth DeLong	Duo-Gard Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Architectural Estimating Manager	Canton	MI	USA	\N	\N	\N	info@duo-gard.com	734.207.9700
473	Ken Leach	Dura Bond Pipe, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Steelton	PA	USA	\N	\N	\N	\N	(717) 986-1100
474	Dura-Bond Steel Corporation	Dura-Bond Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Export	PA	USA	\N	\N	\N	\N	(724) 327-0280
475	Dutchy Enterprises LLC	Dutchy Enterprises LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cocoa	FL	USA	\N	\N	\N	\N	(321)877-0700
476	W James Duthie	Duthie Enterprises INC, d.b.a Standard Steel Fabricating Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Seattle	WA	USA	\N	\N	\N	\N	(206) 767-3314
477	Kenneth or Eddie Collier	DWI Custom Steel Fab Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	USA	\N	\N	\N	\N	334-567-8737
478	D-works	D-works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	McCall	ID	USA	\N	\N	\N	\N	208-634-0081
479	Hugo Sanchez	Dynamic Iron works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Miami,	FL	USA	\N	\N	\N	\N	305-263-0028
480	Tim T Corey	Dynamic Iron works Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager / Senior Estimator	Rio Linda	CA	USA	\N	\N	\N	timcoreydiw@gmail.com	916-238-4188
481	Dynamic Structural Steel	Dynamic Structural Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Proctor	MN	USA	\N	\N	\N	\N	(218) 628-2501
482	David Metzger	E & D Specialty Stands, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	North Collins	NY	USA	\N	\N	\N	\N	(716) 337-0161
483	Robert Sloane	E&H Steel Corporation	rsloane@ehsteel.com	(334) 983-5636	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	AL	\N	\N	\N	\N	\N	(334) 983-5636
484	E P S Iron works	E P S Iron works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mineola	NY	USA	\N	\N	\N	\N	+1 516-294-5840
485	Dan Fremont	E.B.P. Inc. dba EPIC Steel Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cleveland	OH	USA	\N	\N	\N	\N	(216) 241-2550
486	Tom	E.T. GRESHAM COMPANY, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Norfolk	VA	USA	\N	\N	\N	mail@etgresham.com	757-627-4583     (or)    800-617-4583
487	Troy ()	Eagle Fabricators	troy@eaglefabsteel.com	281-442-8787	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	\N	TX	\N	\N	\N	\N	\N	281-442-8787
488	Dalia Morfa	East Coast Metal Structures, Corporation	estimating@eastcoastmetals.net	561-766-2579	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating Coordinator	Lantana	FL	USA	\N	\N	\N	estimating@eastcoastmetals.net	561-766-2579
489	Ronald J Keating	East Coast Steel Fab LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sinking Spring	PA	USA	\N	\N	\N	\N	(610) 898-3445
490	East Coast Steel Fabrication Inc.	East Coast Steel Fabrication Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Nertford	NC	USA	\N	\N	\N	info@ecsfi.com	757-351-2601
491	EASTERN Inc. Steel Contracting	EASTERN Inc. Steel Contracting	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimation department	\N	CT	USA	\N	\N	\N	\N	203-563-9535
492	Rich Anderson	Eastern Metal Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Head Estimator	Milford	CT	USA	\N	\N	\N	estimating@easternmetalworks.com	(203) 878-6995
493	Mark Vorobik / Mike Edco/ Tasha St.Clair	EDCO, INC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/PM/ Detailing & PM	Mt. Vernon	WA	USA	\N	\N	\N	\N	(360) 424-6600
494	Mary Eddy	Eddy's Welding, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ellicott City	MD	USA	\N	\N	\N	mary@EDDYSWELDING.COM	(410) 480-9938/104
495	Mike cook	Edwards, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Spring Hope	NC	USA	\N	\N	\N	mcook@edwardsinc.com	(252) 478-4661
496	Jim Larson	Egger Steel Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sioux Falls	SD	USA	\N	\N	\N	\N	(605) 336-2490
497	Tom Sulliman	Electronics Research, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chandler	IN	USA	\N	\N	\N	\N	(812) 925-6000
498	Karl Haines	Element architectural metals	KHaines@ElementalMetals.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602-258-7916
499	Lucky Damiao	Elite Steel Fabricators	ldamiao@elite-steel.com	631) 285-1008	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	\N	NY	\N	\N	\N	\N	info@elite-steel.com/salman@elite-steel.com	631) 285-1008
500	Mike Ross	Ellis Steel Co.	mike.ross@ellissteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	QC Manager	\N	MS	\N	\N	\N	\N	\N	\N
501	Brent Campbell	EMCO Metals, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cicero	IL	USA	\N	\N	\N	\N	(708) 222-1011
502	EMIT Technologies	EMIT Technologies	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Greeley	CO	USA	\N	\N	\N	info@emittechnologies.com	307-673-0883
503	EMV Welding Inc.	EMV Welding Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Aurora	IL	USA	\N	\N	\N	\N	(630) 264-0893
504	Derek Maggio	Encore Steel	\N	480-663-3505	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	\N	USA	\N	\N	\N	contact@encoresteelinc.com	480-663-3505
505	Endres Manufacturing Company	Endres Manufacturing Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Waunakee	WI	USA	\N	\N	\N	\N	(608) 849-4143
506	Ken Ballweg	Endres Manufacturing Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Waunakee	WI	USA	\N	\N	\N	\N	(608) 849-4143
507	Brian Hills	Engineered Building Products, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Chief Detailer	Bloomfield	CT	USA	\N	\N	\N	bhills@ebpfabfab.com	(860) 243-1110/112
508	Rick Ramsey / David Lovin	Engineered Steel Products, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sophia	NC	USA	\N	\N	\N	dlovin@engineeredsteel.com	336) 438-9140
509	Engineering welding & fabricating co Inc	Engineering welding & fabricating co Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	North Kingstown	RI	USA	\N	\N	\N	\N	(401) 884-1484
510	Jerry Mims	Ennis Steel Industries, Inc.	jerry@ennissteel.com	972-878-0400 x5604	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	GM	Ennis	\N	USA	\N	\N	\N	brian@ennissteel.com	972-878-0400 x5604
511	John A. Smith/Chirs coble	Environmental Air Systems, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	High Point	NC	USA	\N	\N	\N	ccoble@easinc.net	(336) 273-1975
512	EPI iron & welding	EPI iron & welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	702-251-8230
513	Epic steel	Epic steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Missoula	MT	USA	\N	\N	\N	\N	406-542-1711
514	Dan Hetzel	Erdman Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Waunakee	WI	USA	\N	\N	\N	\N	(608) 410-8403
515	Gary George/Mark	Erection & Welding Contractors, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Berlin	CT	USA	\N	\N	\N	mbellisle@erectionwelding.com	(860) 828-9353/107,111
516	Tyler Neilson	ESI steel and fabrication	tyler@esisteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Salem	IL	USA	\N	\N	\N	\N	618-548-3017
517	Europ Iron Construction Group	Europ Iron Construction Group	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Parkridge	IL	USA	\N	\N	\N	\N	(847) 451-1705
518	Evadx	Evadx	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kinmel Bay	RI	USA	\N	\N	\N	\N	44 1745 336413
519	David Evans	Evans Metal Products Co, Inc	david@evansmetal.com	(574) 264-2166 (w) (814) 397-6920 (m)	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IN	\N	\N	\N	\N	\N	(574) 264-2166 (w) (814) 397-6920 (m)
520	Estimating department	Everglades Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Miami	FL	USA	\N	\N	\N	\N	+1 305-591-9460
521	Gene Johnson	Evraz Rocky Mountain Steel	\N	970-323-6323 EXT 103	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailer	Olathe	CO	USA	\N	\N	\N	\N	970-323-6323
522	Tiberio Esparza	EW Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	El Centro	CA	USA	\N	\N	\N	\N	760-337-0020
523	Kyle Curtis	Extreme Steel	\N	(540) 868-9150  EXT  212	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Winchester	VA	USA	\N	\N	\N	\N	(540) 868-9150
524	Ryan Chewning	Extreme Steel Inc	rchewning@extremesteelinc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	VA	\N	\N	\N	\N	\N	\N
525	Chris Bock/Olivia Garcia/Jeff Wrobleski/Lorena	E-Z Line Pipe Support Co., LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Manvel	TX	USA	\N	\N	\N	purchasing@ezline.com	(713) 675-6693
526	Jonathan Dean	EZ Metals, Inc. dba Suncoast Industries of Florida	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fort Myers	FL	USA	\N	\N	\N	\N	(239) 936-7887
527	Phil Kenney	F.A. Wilhelm Construction Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Indianapolis	IN	USA	\N	\N	\N	\N	(317) 359-5411
528	Fab Shop	Fab Shop	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rose city	MI	USA	\N	\N	\N	\N	248-673-2505
529	David Bennett	FabArc Steel Supply Inc	david.bennett@fabarc.com	David Dt: 256-241-1619 C: 256-499-5089	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Oxford	AL	USA	\N	\N	\N	sales@fabarc.com	Nathan C: 256-452-9550
530	David Garcia	Fabco Metal Products LLC	dgarcia@fabcometal.com	386-252-3730 x4	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Main Man	Daytona Beach	\N	USA	\N	\N	\N	DGarcia@fabcometal.com	386-252-3730 x4
531	Rich Schick	Fabco steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fontana	CA	USA	\N	\N	\N	r.schick@fabcosteel.com	(909) 350-1535
532	Joseph Mandarano	Fabcor, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Jessup	PA	USA	\N	\N	\N	greingold@fabcorinc.com	5703070965
533	Ian Brown	Fabricari LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kenner	LA	USA	\N	\N	\N	\N	(504) 275-1275
534	James Watson	Fabricated Steel Products	jwatson@fabricatedsteel.net	225) 272-8990	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP Project Management	\N	LA	\N	\N	\N	\N	\N	\N
535	Fabricating & Welding Corporation	Fabricating & Welding Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chicago	IL	USA	\N	\N	\N	\N	773-928-2050
536	Marsha Dee / Greg Sword/ Timothy Spahr	Fabrication Products, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President / VP/ PM	Vancouver	WA	USA	\N	\N	\N	tims@fabproducts.com	(360) 696-1324
537	Fabrication services	Fabrication services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	LA	USA	\N	\N	\N	\N	\N
538	Charles Green	Fabricraft, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bristol	TN	USA	\N	\N	\N	info@fabricraft.us	(423) 968-7747
539	Greg/dyen	Fabritex, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hartwell	GA	USA	\N	\N	\N	\N	(706) 376-6584/254/227 (or) 706-981-5770
540	It's a big group and having 6 sister concerns.Refer website and call to all concern individually	FabSouth LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oakland Park	FL	USA	\N	\N	\N	\N	954-938-5800
541	fabsteel co.inc	fabsteel co.inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Northwood	OH	USA	\N	\N	\N	\N	\N
542	FabTec Enterprises	FabTec Enterprises	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Byron Center	MI	USA	\N	\N	\N	sales@fabtecent.com	616.878.9288
543	Tonya King	Fab Weld Steel, LLC	tking@fabweldsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Administrative Assistant	Randolph	AL	USA	\N	\N	\N	\N	205-688-4654
544	Fairchild fabricators	Fairchild fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	LA	USA	\N	\N	\N	\N	\N
545	Jack Wilcox	Falcon Steel America	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Haltom City	TX	USA	\N	\N	\N	\N	(817) 581-9500
546	Sherry	Farwest steel corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Eugene	OR	USA	\N	\N	\N	\N	(541) 686-2000
547	Fast Fab Steel. Co	Fast Fab Steel. Co	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Schaumburg	IL	USA	\N	\N	\N	\N	847-301-7425
548	Wendy Dunkle (or) Zack Hall	FCC Construction Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Caledonia	MI	USA	\N	\N	\N	\N	(616) 891-4000
549	Scott Longnecker/ Nick Rea	Federal Steel & Erection Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	East Alton	IL	USA	\N	\N	\N	\N	(618) 254-0106
550	Ferro Fab LLC d/b/a ABZ steel systems	Ferro Fab LLC d/b/a ABZ steel systems	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Clinton Twp	MI	USA	\N	\N	\N	\N	(586) 791-3561
551	Mark Rains	Fiedeldey Steel Fabricators, Inc.	markr@fiedeldeysteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	OH	\N	\N	\N	\N	\N	\N
552	Ryan Fields	Fields Welding, Inc.	ryan@fieldswelding.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	KY	\N	\N	\N	\N	\N	\N
553	Tascha Farris	Fig Tree Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sales & Estimating	\N	AR	USA	\N	\N	\N	sales@figtreesteel.com	(479) 751-3647 ext. 226
554	Estimating department	Finfrock Design Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Apopka	FL	USA	\N	\N	\N	\N	407.293.4000
555	Kyle Marquis	Firelands Fabrication	kyle@firelandsfab.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Steel Detailer	\N	OH	\N	\N	\N	\N	\N	\N
556	FJM FERRO INC	FJM FERRO INC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Brooklyn	NY	USA	\N	\N	\N	\N	718-331-5464
557	Victor Garcia	Flawless Steel Welding	victor@fsw-denver.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	CO	\N	\N	\N	\N	email@fsw-denver.com	\N
558	Katie Starkey	Florida fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Orlando	FL	USA	\N	\N	\N	estimating@floridafabrication.net	(407) 212 0105
559	Gregory Harris	Florida Structural Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Gibsonton	FL	USA	\N	\N	\N	sales@tti-fss.com	(813) 241-4261
560	Floyd Steel Erectors	Floyd Steel Erectors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Wood Dale	IL	USA	\N	\N	\N	INFO@FLOYDSTEEL.COM	630-238-8383
561	Robby Cole	FMW Mechanical Inc	Rcole@fwmmech.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project management and estimating	Minden	LA	USA	\N	\N	\N	\N	318-371-2225
562	Alana Porter	Ford Steel LLC	aporter@fordsteelllc.com	281-354-3011	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	GM	\N	TX	\N	\N	\N	\N	ahutzler@fordsteelllc.com	281-354-3011
563	Forestville welding & Ironworks	Forestville welding & Ironworks	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Upper Marlboro	MD	USA	\N	\N	\N	\N	+1 301-735-4220
564	Keith Porta	Forge Fabrication Services, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Belle Chasse	LA	USA	\N	\N	\N	\N	(504) 539-4259
565	Dennis Fritz / Rick	Formit Metal Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	York	PA	USA	\N	\N	\N	rpurnell@formitmetfab.com	(717) 650-2895
566	Scott Forney	Forney Welding Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albuquerque	NM	USA	\N	\N	\N	\N	\N
567	Jacob G. Fruchter	Fort Miller FAB3 Corp.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Greenwich	NY	USA	\N	\N	\N	\N	(518) 584-4400
568	Fort Payne Steel	Fort Payne Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fort Payne	AL	USA	\N	\N	\N	\N	256-845-7033
569	David Amaya	Fought & Company	damaya@foughtsteel.com	503-639-3141	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	QC	Tigard	OR	USA	\N	\N	\N	\N	503-639-3141
570	Todd Cooper/Rick Dietl(970-456-2314 mob)	Foundation Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project manager/ GM structural steel	Swanton	OH	USA	\N	\N	\N	info@foundationsteel.net	419) 402-4241
571	Francis Steel Inc	Francis Steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Aberdeen	NC	USA	\N	\N	\N	admin@francis-steel.com	(910) 944-9681
572	Travis Nishi	Fresno Fab Tech	tnishi@ffti.us	(559)875-9800	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Director	\N	CA	\N	\N	\N	\N	tnishi@ffti.us/ bobbyj@ffti.us	(559)875-9800
573	Front Range Industrial, Inc.	Front Range Industrial, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	CO	USA	\N	\N	\N	\N	(720) 259-1777
574	Gerry Tittle	Front Range Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	Wellington	CO	USA	\N	\N	\N	\N	(970)-568-9002
575	Jeffrey Hills	G P METAL FABRICATION	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Williamsport	PA	USA	\N	\N	\N	jlh60@verizon.net	570-494-1002
576	G&G Steel, Inc.	G&G Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Russellville	AL	USA	\N	\N	\N	\N	(256) 277-0139
577	John LeCoq	G.A West & Co., Inc.	info@gawest.com	251-679-1965	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	Creola	\N	USA	\N	\N	\N	info@gawest.com	251-679-1965
578	John Newby	G.F. Munich Welding Co. LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Jeffersonville	IN	USA	\N	\N	\N	\N	(812) 282-0488
579	G.L. Nause Co., Inc.	G.L. Nause Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Loveland	OH	USA	\N	\N	\N	\N	\N
580	Sid Gunter	G.T.E Metal Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Canby	OR	USA	\N	\N	\N	\N	(503) 266-6433
581	Jeremy Silva	G2 Metal Fab	jsilva@g2metalfab.com	(925)443-7903, (925)525-8414	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Director	\N	CA	\N	\N	\N	\N	jsilva@g2metalfab.com, kho@g2metalfab.com	(925)443-7903, (925)525-8414
747	JAGS Fabrication	JAGS Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Athens	WI	USA	\N	\N	\N	\N	715-257-7901
582	Tyler Cannell	Garbe Iron Works, Inc	tcannell@giwinc.com	630) 897-5100	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	IL	\N	\N	\N	\N	info@giwinc.com	630) 897-5100
583	Greg	Garden state Iron Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Wanamassa	NJ	USA	\N	\N	\N	ga@gardenstateiron.com	732-918-0760
584	Kevin Tomlinson/Kimber Woodruff	Garner Brothers Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rome	GA	USA	\N	\N	\N	\N	706-234-6334
585	Cole Garrison	Garrison Steel Erectors Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pell City	AL	USA	\N	\N	\N	\N	1 205-884-4766
586	david crunk	Gastonia Iron works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mt Holly	NC	USA	\N	\N	\N	\N	+1 704-827-1146
587	Gayle Manufacturing Company	Gayle Manufacturing Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Nampa	ID	USA	\N	\N	\N	Marketing@GMCx.com.	1 208-468-0400
588	GCB Metal Building Systems	GCB Metal Building Systems	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Elgin	IL	USA	\N	\N	\N	contact@gcbmetal.com	(224) 268-3792
589	GCI welding and fabrication	GCI welding and fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kenner	LA	USA	\N	\N	\N	\N	(504) 450-4465
590	Steve Knitter	Geiger & Peters, Inc.	sales@gpsteel.com	317-359-9521	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Indianapolis	\N	USA	\N	\N	\N	sales@gpsteel.com.	317-359-9521
591	Scott Massie	Geiger Brothers, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Jackson	OH	USA	\N	\N	\N	\N	(740) 286-0800
592	GEM Buildings	GEM Buildings	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Brigham City	UT	USA	\N	\N	\N	\N	\N
593	Graime Weyland	Gem City Steel Supply, Inc.	gw@gemcitysteel.com	770-422-0637	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Marietta	\N	USA	\N	\N	\N	gw@gemcitysteel.com / gweyland1@gmail.com	770-422-0637
594	Aaron Cottle	GEM Industries Inc	acottle@gemindustriesincorporated.com	321-631-3977	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Cocoa	FL	USA	\N	\N	\N	Aminer@GEMIndustriesIncorporated.com	321-631-3977
595	General Steel	General Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sterling Heights	MI	USA	\N	\N	\N	\N	586-264-6102
596	Derek ()	Genesis Iron works	derek@genironworks.com	775-867-4766	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	NV	\N	\N	\N	\N	tina@genironworks.com	775-867-4766
597	Gen-Oak Fabricators Inc	Gen-Oak Fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lake Orion	MI	USA	\N	\N	\N	\N	248-373-1515
598	John Pearson	Gentry Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chattanooga	TN	USA	\N	\N	\N	sales@gentrysteelinc.com	(423) 624-3322
599	Genzink steel	Genzink steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Holland	MI	USA	\N	\N	\N	\N	800.968.2002
600	Jim Graham	George Steel Fabricating, Inc.	\N	(513) 888-7653	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Chief estimator	Lebanon	OH	USA	\N	\N	\N	\N	(513) 932-2887
601	Jorge Amador	George's Welding Services, Inc.	jorgejr@georgeswelding.com	305-822-2445	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	OwnerSon	Miami	\N	USA	\N	\N	\N	jorgejr@georgeswelding.com	305-822-2445
602	Kenny Grant	Gerace construction company, inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	Midland	MI	USA	\N	\N	\N	info@geraceconstruction.com	989.496.2440
603	Jeffrey Clack	Gerdau Ameristeel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albany	GA	USA	\N	\N	\N	\N	(229) 439-2211
604	David Armstrong	Germantown Iron & Steel Corporation	davida@gogis.com	262-677-2530 x143(David) x128 (Aaron)	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	\N	WI	\N	\N	\N	\N	\N	262-677-2530 x143(David) x128 (Aaron)
605	Gibson Industrial Inc.	Gibson Industrial Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Richmond	VA	USA	\N	\N	\N	\N	804-222-7340
606	Mississippi Steel Processing	Mississippi Steel Processing	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Columbus	MS	USA	\N	\N	\N	\N	662-327-3150
607	Rene DuVal	Gibson Industrial, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Richmond	VA	USA	\N	\N	\N	\N	(804) 338-1400
608	Gilbane building company	Gilbane building company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rhode Island	RI	USA	\N	\N	\N	\N	844-240-0004
609	Elton Hogan	Gipson Steel, Inc.	ehogan@gipsonsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Chief estimator	Meridian	MS	USA	\N	\N	\N	\N	(601) 482-5131
610	Gira Patel	Gira Steel	\N	803-796-9495	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	W. Columbia	\N	USA	\N	\N	\N	\N	803-796-9495
611	Estimators ()	Glazier Steel, Inc.	estimating@glaziersteel.com	510-471-5300	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating Dept	Hayward	CA	USA	\N	\N	\N	estimating@glaziersteel.com	510-471-5300
612	Paul Clemons	Glenco Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	production manager	Clovis	NM	USA	\N	\N	\N	\N	575-763-4414
613	William Moscrop	Glenco Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Fontana	CA	USA	\N	\N	\N	\N	(909) 854-9000
614	glenn ihde & co	glenn ihde & co	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	McKinney	TX	USA	\N	\N	\N	\N	972-964-3310
615	Global Fabrication II	Global Fabrication II	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Picayune	MS	USA	\N	\N	\N	\N	\N
616	Stephen Peet	Global Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Drafting Services Manager	Shafter	CA	USA	\N	\N	\N	\N	(661) 746-7700
617	Johan Gidstedt	Global Steel Fabricators	johang@globalsteelfab.com	(559)360-9011	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	CA	\N	\N	\N	\N	\N	(559)360-9011
618	Mike Crase	GMac Steel inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Es/Detailer	Salt Lake City	UT	USA	\N	\N	\N	\N	+1 801-973-2117
619	Terry Johnson	GMF Industries, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lakeland	FL	USA	\N	\N	\N	procurement@gmfsteel.com	863-577-0210
620	Goddard Industrial Inc.	Goddard Industrial Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Knoxville	TN	USA	\N	\N	\N	Info@GoddardIndustrial.com	865-573-1161
621	Trent Hendrickson / Brandon Wells	Golden Empire Manufacturing, Inc. dba GEM Buildings	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Enng manager/ detailing manager	Brigham City	UT	USA	\N	\N	\N	\N	(435) 723-5000
622	Brian Nishimura	Golden State Steel	bnishimura@goldenstatesteel.com	(559) 834-6209	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating	\N	CA	\N	\N	\N	\N	brian@goldenstatesteel.com	(559) 834-6209
623	John Tuttle	Golden State Steel & Stair Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator / Project Manager	Vacaville	CA	USA	\N	\N	\N	\N	(707) 455-1635/5107632205(direct)
624	Goodell's welding and fabrication Inc	Goodell's welding and fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	St. Cloud	MN	USA	\N	\N	\N	\N	\N
625	Bob Fisher/Barry Teel	Goodhart Sons Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lancaster	PA	USA	\N	\N	\N	\N	(717) 656-2404
626	Grace Steel and Fabrication	Grace Steel and Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	480-859-0577
627	Marj Oliver(female)	Great Denver Iron	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator/Project Manager	Denver	CO	USA	\N	\N	\N	marj@greatdenveriron.com / meenu@greatdenveriron.com	(303) 991-0537
628	Great Lake Fabricators & Erectors Association	Great Lake Fabricators & Erectors Association	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Southfield	\N	USA	\N	\N	\N	btreharne@glfea.org	586-817-9905
629	Great Lakes Contracting, Inc.	Great Lakes Contracting, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Grand Haven	MI	USA	\N	\N	\N	\N	616.846.8888
630	Justin Isaac	Great western iron works fabrication & Erection LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Goodyear	AZ	USA	\N	\N	\N	\N	(623) 398-7338
631	Russ Mason / Justin Price	Greenberry Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Corvallis	OR	USA	\N	\N	\N	\N	(541) 757-8458
632	Cody Guidry	Greenberry Industrial - Gulf Coast	Cody.Guidry@greenberry.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Director of Estimating - SW Region	Sulphur	LA	USA	\N	\N	\N	\N	1)  Gulf Coast -  (337) 558-7702                                  2) 888-247-9973
633	Clay (Butch) Brandt / Wayne Gish	Greiner Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mount Joy	PA	USA	\N	\N	\N	info@greinerindustries.com	(717) 653-8111
634	Steve Bishop	GreyBeard Steel LLC	\N	(208) 457-4196	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	GM	\N	ID	\N	\N	\N	\N	info@greybeardsteel.com	(208) 457-4196
635	Grillo Companies	Grillo Companies	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chesterfield Twp.	MI	USA	\N	\N	\N	\N	586-598-2222
636	Jimmy Grinder	Grinder Fabricating & Erection, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Millington	TN	USA	\N	\N	\N	sgrinder@grinderfab.com	(901) 358-4558
637	Grosse Steel Co. Inc	Grosse Steel Co. Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cedar Falls	IA	USA	\N	\N	\N	info@grossesteel.com	319-277-5900
638	Grunau Metals	Grunau Metals	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oak Creek	WI	USA	\N	\N	\N	\N	414.216.6900
639	Brad Landry	Grunau Metals	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oak Creek	WI	USA	\N	\N	\N	\N	(414) 216-6951
640	()	GST Manufacturing	sales@gstmanufacturing.com	817-520-2320	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	bshockley@gstmanufacturing.com	817-520-2320
641	Estimating department	GT Grandstands, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Plant City	FL	USA	\N	\N	\N	\N	(866) 550 - 5511
642	Eric Guccione	Gucci One Fabrication LLC	eric@gucci1fab.com	504-259-6427	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	General manager - sales	Belle Chasse	LA	USA	\N	\N	\N	\N	504-433-7677
643	Shyanne Cottle	GWI Steel	shyanne@gwisteel.com	801-392-9611	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	UT	\N	\N	\N	\N	\N	801-392-9611
644	Liam McNelis	H&L Ironworks	liam@hlironworks.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	NY	\N	\N	\N	\N	\N	\N
645	H&S Mechanical, Inc.	H&S Mechanical, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bartonville	IL	USA	\N	\N	\N	\N	(309) 696-7066
646	Tyson Drysdale / Sheldon /Randy Stewart	H.A. Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/Owner /PM	Logan	UT	USA	\N	\N	\N	tyson@hafab.net / hafab@hafab.net	(435) 750-5050
647	Derek Haberle/Chiristian	Haberle Steel Inc. - Souderton	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Souderton	PA	USA	\N	\N	\N	\N	(215) 723-8848
648	Hallmark Iron Works Inc.	Hallmark Iron Works Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Newington	VA	USA	\N	\N	\N	rene@hallmarkiron.com	703-550-9560 (or) 703-550-0106
649	Charles D. Mercer	Hallmark Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Newington	VA	USA	\N	\N	\N	\N	(703) 550-0106
650	Ham Engineering	Ham Engineering	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	South Charleston	WV	USA	\N	\N	\N	\N	\N
651	Rick Hambric Sr	Hambric Steel and Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albany	GA	USA	\N	\N	\N	\N	229.432.7147
652	Bruce Moser	Hamilton Iron Works Inc	bruce.moser@hamiltoniron.com	703) 497-4766 Bruce C: 703-862-1772	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	GM	\N	VA	\N	\N	\N	\N	bids@hamiltoniron.com	703) 497-4766 Bruce C: 703-862-1772
653	Yasmin ()	Hammer Haag Steel	yalbizreh@hammerhaag.com	727-216-6903	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Clearwater	\N	USA	\N	\N	\N	yalbizreh@hammerhaag.com	727-216-6903
654	Hammerts Iron	Hammerts Iron	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	St. Louis	MO	USA	\N	\N	\N	\N	?+1 314-389-0666
655	Andy Boyce	Hancock Structural Steel	andyboyce@hancocksteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP Operations	\N	OH	\N	\N	\N	\N	\N	\N
656	Edward C Counsil III	Hanley Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Peoria	IL	USA	\N	\N	\N	counsil@hanleysteel.com (or) infor@hanleysteel.com	(309) 692-5250
657	Talisa	Hanson Welding & Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	?Nephi	UT	USA	\N	\N	\N	\N	(801) 465-5060
658	Hunter Harrell	Harrell's Metal Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Grenada	MS	USA	\N	\N	\N	HUNTER@HARRELLSMETALWORKS.COM	(662) 226-0982
659	Heather Harris	Harry Gordon Steel Company, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Winchester	KY	USA	\N	\N	\N	\N	(859) 255-2442
660	Dave Eaden	Haskell Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bellingham	WA	USA	\N	\N	\N	\N	(360) 734-1200
661	Azeem Atta	Haskell Steel	azeem.atta@haskell.com	904) 357-4980	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Jacksonville	FL	USA	\N	\N	\N	info@haskell.com	904) 357-4980
662	Bill kaeser	Heartland Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Brownsville	PA	USA	\N	\N	\N	bill.kaeser@hl-companies.com	7245571483(Brian)/ 724-963-0783(bill)
663	Hebert Steel Co. Inc.	Hebert Steel Co. Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Gonzales	LA	USA	\N	\N	\N	sales@hebertsteel.com	225-644-5316
664	Adam Jones	Hefco Enterprises Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fresno	TX	USA	\N	\N	\N	adam@hefco.com	(281) 431-9305
665	heather helcrist	Helcrist ? Steel Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Philadelphia	PA	USA	\N	\N	\N	heatherhelcrist@gmail.com	215 727 2050
666	Hot Az Hell Welding & Fabrication, LLC	Hot Az Hell Welding & Fabrication, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chino Valley	AZ	USA	\N	\N	\N	\N	928-713-4749
667	Jamey Jodway	Helgeson Steel Inc	jamey@helgesonsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailer	\N	IN	\N	\N	\N	\N	info@helgesonsteel.com  (OR)  ITB@helgesonsteel.com	\N
668	Jessica	Henard Metal Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	DM	Kingsport	TN	USA	\N	\N	\N	jhgaude@henard.com	(423) 246-1129
669	Lewis Jourdan	Hercules Steel Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fayetteville	NC	USA	\N	\N	\N	\N	(910) 488-5110
670	John Hershberger	Hershberger Bros Welding Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	danny@unionerectors.com	(702) 896-2245
671	Scott Snowberger	HG Global Services Inc	ssnowberger@hgglobalinc.com	704-819-4799	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	RockHill	SC	USA	\N	\N	\N	sales@hgglobalinc.com	803-216-1525
672	Tom Bean	High Steel Structures	tbean@high.net	717) 299-5211	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Head	\N	PA	\N	\N	\N	\N	\N	717) 299-5211
673	Don ()	Hill Country Steel Fabrication	donw@hillcountrysteel.com	210-667-9737	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	TX	\N	\N	\N	\N	\N	210-667-9737
674	Carl Janson	Hillsdale Fabricators	cjanson@alberici.com	Carls Cell: 314-733-2446	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	St. Louis	MO	USA	\N	\N	\N	\N	Carls Cell: 314-733-2446
675	John Wittig/ Jeff Bellows	Hirschfeld Steel Group LP	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	San Angelo	TX	USA	\N	\N	\N	\N	(325) 486-4609/336.271.8316
676	Hittite steel	Hittite steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Arlington	VA	USA	\N	\N	\N	\N	1
677	Micah Harris	HK Custom Works	hk_metal@icloud.com	775-232-3851	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Reno	\N	USA	\N	\N	\N	hk_metal@icloud.com	775-232-3851
678	Denise ()	HMB Steel Corp.	info@hmbsteel.com	321-636-6511	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Secretary	Rockledge	\N	USA	\N	\N	\N	info@hmbsteel.com	321-636-6511
679	Bobbi Fletchall	HME, Inc.	bfletchall@hmeinc.net	785-235-1524	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainWoman	Topeka	\N	USA	\N	\N	\N	\N	Direct : 785-430-5908 C: 785-806-3856
680	Hoffa Steel Inc	Hoffa Steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Des Moines	IA	USA	\N	\N	\N	bryan@hoffasteel.com	515-318-8462
681	Adam Hogan	HOGAN FAB	adam@hoganfab.com	503-774-4940	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	Portland	\N	USA	\N	\N	\N	adam@hoganfab.com	503-774-4940
682	Kevin O'Neill	Hohl Industrial Services, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM/DM	Tonawanda	NY	USA	\N	\N	\N	\N	(716) 332-0466
683	Matt Clay	Holley Steel Inc.	mclay@holleysteel.com	3342907631	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Elmore	AL	USA	\N	\N	\N	staff@holleysteel.com	334-290-7631
684	Joseph Caparelli	Hollywood Iron Works, Inc.	jcaparelli@hollywoodiron.com	954-962-0556	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	Hollywood	\N	USA	\N	\N	\N	officemanager@hollywoodiron.com	954-962-0556
685	Horn Steel	Horn Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Geneva	IL	USA	\N	\N	\N	wmhornstr@aol.com	630-232-0111
686	HotRodIronworks & Welding Services(HRI)	HotRodIronworks & Welding Services(HRI)	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	LA	USA	\N	\N	\N	contact@hriwelding.com	(504) 662-3380
687	Julio Rochell	Howard Steel	julio@howardsteel.net	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	TX	\N	\N	\N	\N	jm1@howardsteelinc.com	\N
688	Pat ()	Howard Structural Steel	\N	989-752-3000	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	MI	\N	\N	\N	\N	\N	989-752-3000
689	John Meacham	Hub Steel	john@gohubsteel.com	4079896067	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Groveland	FL	USA	\N	\N	\N	\N	4079896067
690	James Wahoski	Hubbard & Drake General/Mech Cont. Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Decatur	AL	USA	\N	\N	\N	\N	(256) 350-9244    cell:-(256) 476-3898
691	Jose Hunt	Hunt Steel	proj.admin@huntsteellv.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	NV	\N	\N	\N	\N	estimating@huntsteellv.com	\N
692	Hunter metal forge and iron works	Hunter metal forge and iron works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Verdi	NV	USA	\N	\N	\N	info@huntermetal.org	(530) 546-6001
693	Brandon Smick/Andrew Pittman	Huntington steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Esti/PM	Pikeville	KY	USA	\N	\N	\N	\N	(304) 522-8218
694	David Brammer	Huntington Steel & Supply Co.	dbrammer@huntingtonsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Fabrication Manager	\N	WV	\N	\N	\N	\N	\N	\N
695	Hurtado Fence LLC	Hurtado Fence LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AZ	USA	\N	\N	\N	\N	0000000000
696	IACONO IRON	IACONO IRON	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Asbury Park	NJ	USA	\N	\N	\N	\N	973-420-6597
697	IK constrcution Inc	IK constrcution Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	South Orange	NJ	USA	\N	\N	\N	\N	(201) 306-3161
698	Jason	Ikon steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Apache Junction	AZ	USA	\N	\N	\N	\N	480-892-6865
699	Bruce Verge/Bill Leftwich	Immec Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Social Circle	GA	USA	\N	\N	\N	\N	(770) 464-1001
700	()	Imperial Iron Inc.	info@imperialiron.com	702-873-8678	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	NV	\N	\N	\N	\N	info@imperialiron.com	702-873-8678
701	Tom Reinbold	Imperial Ornamental Metal Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fenton	MO	USA	\N	\N	\N	\N	(636) 343-8825
702	Paul Vozzo/Ryan Parsons(15)	Independence Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Prospect Park	PA	USA	\N	\N	\N	\N	6103881826
703	Greg Dowden	Indiana Steel Fabricating	gregd@indianasteelfab.com	317-247-4545	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating Manager	Indianapolis	\N	USA	\N	\N	\N	\N	(765) 742-1031
704	Greg Dowden	Indiana steel fabricating, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sales and Estimating	Indianapolis	IN	USA	\N	\N	\N	info@indianasteelfab.com	(317) 247-4545
705	Michael? Vessell	Kupferer Brothers Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	St. Louis	MO	USA	\N	\N	\N	\N	(314) 807-9785
706	Jamie Hodges	Industrial Constructors/Managers, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Executive VP	Pueblo	CO	USA	\N	\N	\N	jamie@icmpueblo.com	(719) 545-0296 (or) 303-287-4400
707	Industrial Fabricating Systems	Industrial Fabricating Systems	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	MI	USA	\N	\N	\N	\N	248-685-7373
708	Brandon Dietrich	Industrial Fabricators, Inc.	bdietrich@indfab.biz	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator/PM	\N	TN	\N	\N	\N	\N	\N	\N
709	Phillip Atkins	Industrial Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Columbus	MS	USA	\N	\N	\N	\N	(662) 327-1776
710	Industrial Resources Inc.	Industrial Resources Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fairmont	WV	USA	\N	\N	\N	sales@indres.com	304.363.4100
711	Mr. Raymond Perr	Industrial Resources, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fairmont	WV	USA	\N	\N	\N	\N	(304) 534-1820
712	Buck Roberds	Industrial Steel Construction - ISC Gary	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Gary	IN	USA	\N	\N	\N	\N	(219) 885-7600
713	Nick Petkus	Industrial Steel Construction, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hodgkins	IL	USA	\N	\N	\N	\N	(219) 885-7600
714	Ted Stegeman	Industrial Steel Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hazelwood	MO	USA	\N	\N	\N	\N	(314) 895-1447
715	Michael Corn	Inline Steel Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Yakima	WA	USA	\N	\N	\N	\N	(509) 248-4554/105(DM)
716	Olivia ()	InstaFab	olivia@instafab.com	(360) 737-8235	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Purchasing	\N	WA	\N	\N	\N	\N	ralphie@instafab.com	(360) 737-8235
717	Justin Cimino / Jeff Gannett(PM)	Integrated Structures Corp.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bethpage	NY	USA	\N	\N	\N	\N	516.937.9200
718	Intermountain Erectors	Intermountain Erectors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Idaho Falls	ID	USA	\N	\N	\N	\N	208-528-7544
719	International Steel Frame Tech	International Steel Frame Tech	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sparks	NV	USA	\N	\N	\N	\N	702-940-0461
720	International Welding and Fabrication	International Welding and Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Moss Point	MS	USA	\N	\N	\N	\N	(228) 474-9353
721	Intrepid Metal Works Inc.	Intrepid Metal Works Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	702-439-6754
722	Shane Bevans	Iowa Engineered Processes Corp.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Independence	IA	USA	\N	\N	\N	steve@iepc.com	319-334-7274
723	Kevin Dixon	Iowa Specialties Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cedar Rapids	IA	USA	\N	\N	\N	\N	(319) 366-4766
724	Bryan Hoffa	Iowa Steel Fabrication,LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Greenfield	IA	USA	\N	\N	\N	\N	(641) 342-2134
725	Raleigh Osborne	IRA G Steffy & Son Inc	rosborne@iragsteffyandson.com	717-733-2001	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Vice President	Ephrata	\N	USA	\N	\N	\N	rosborne@iragsteffyandson.com	717-733-2001
726	Ali ()	Iron Fabrication Services	bids@ironfs.com	410-712-7070 ex1002	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	MD	\N	\N	\N	\N	bids@ironfs.com	410-712-7070 ex1002
727	Josh Chiniquy	Iron force constructors inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mesa	AZ	USA	\N	\N	\N	lauri@ironforce.us	480-257-4321
728	Joe Rodriguez eulogio rodriguez	Ironco enterprices Inc.,	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AZ	USA	\N	\N	\N	\N	(602) 243-5750
729	Joey Stepleton	Ironfab, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Columbus	OH	USA	\N	\N	\N	\N	(614) 443-3900
730	Ore Dagan	Ironman, Inc.	ore@ironmaninc.net	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Managing Director	\N	CA	\N	\N	\N	\N	arie@ironmaninc.net	\N
731	Ironworker Inc.	Ironworker Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Prescott	AZ	USA	\N	\N	\N	ironworker056@yahoo.com	928-445-2560
732	Jim Schroeder	IRV SCHRODER & SONS INC	issisteel@gmail.com	518 - 828-0194	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	NY	\N	\N	\N	\N	ISSISteel@gmail.com	518 - 828-0194
733	Monty Magner	Irwin Steel	monty@irwinsteel.net	8176362508	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	Justin	WA	USA	\N	\N	\N	monty@irwinsteel.net	817-636-2508
734	Joseph Corcella	Island Steel & Detailing Corp	joe@islandstl.com	631-395-6844	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Operation Manager	\N	\N	USA	\N	\N	\N	\N	631-395-6844
735	Howard Johnston	IWS Aquisition Corp	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Port	OR	USA	\N	\N	\N	\N	(503) 849-7994
736	Erwin Erwin	J&D Fabrication & Repair Inc	erwin@jdfabandweld.com	805) 928-9674	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	CA	\N	\N	\N	\N	\N	805) 928-9674
737	Dave Mitchell/Jeremy mitchell	J&A Mitchell Steel Fabricators,Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kankakee	IL	USA	\N	\N	\N	jeremy@jamitchellsteel.com	815-939-2144
738	Jeff Spota	J. C. MacElroy Company, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Piscataway	NJ	USA	\N	\N	\N	\N	(732) 572-7100
739	Chris DeYoung	J.B. Steel	\N	541-773-8325	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Director of Construction	Mediumford	\N	USA	\N	\N	\N	info@jbsteel.net	(520) 748-8062
740	Robert C. Schlaier	J.G. Schmidt Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Passaic	NJ	USA	\N	\N	\N	\N	(973) 473-4822
741	Ryan Braun	J.L. Walter & Associates	rbraun@jlwalt.com	3173135504	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP Estimating	\N	IN	USA	\N	\N	\N	\N	3173135504
742	Estimating department	J.P. Donovan Construction, Inc. (JPD Fabrication - Rockledge, FL)	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rockledge	FL	USA	\N	\N	\N	\N	(321) 383-1171
743	Robert Arch	J.R. Hoe & Sons	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Middlesboro	KY	USA	\N	\N	\N	\N	800-245-5521
744	Jacks metal works	Jacks metal works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Garden City	ID	USA	\N	\N	\N	metalinfo.jmw@gmail.com	208-375-5272
745	Jacksonville Steel Inc.	Jacksonville Steel Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Beebe	AR	USA	\N	\N	\N	\N	501-882-3563
746	Doug Stewart	Jacksonville Steel, Inc.	doug@jaxsteel.com	501-882-3563	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing and Project Manager	\N	\N	USA	\N	\N	\N	Doug@jaxsteel.com	501-882-3563
748	Brian Howe	Jake Marshall, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chattanooga	TN	USA	\N	\N	\N	\N	(423) 698-3132
749	James McBrady	James A. McBrady, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Scarborough	ME	USA	\N	\N	\N	\N	(207) 883-4176
750	Ashley Puryear	James Puryear Welding	jpuryearwelding@sbcglobal.net	325) 672-2009	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainLady	\N	TX	\N	\N	\N	\N	\N	325) 672-2009
751	Mike Smith	Jameson steel fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oakwood	IL	USA	\N	\N	\N	\N	217-354-2205
752	John Ruth	Jarco Steel	john.ruth@jarcosteel.com	(713) 644-4900	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	TX	\N	\N	\N	\N	josh.hampton@jarcosteel.com	(713) 644-4900
753	Eric Gurney	Jarosz welding company Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Ch.estimator	Hartford	CT	USA	\N	\N	\N	egurney@jwcsteel.com	860-296-5517 /860 937 5475(DD)
754	JB Erectors	JB Erectors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IL	USA	\N	\N	\N	\N	0000000000
755	Hamilton Brown	JBH Steel, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chattanooga	TN	USA	\N	\N	\N	MSindler@JBHSteel.com	(423) 267-9655
756	Angelica ()	JC Steel Fabricators	info@jcsteelfabricators.com	702) 567-0040	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainWoman	\N	NV	\N	\N	\N	\N	info@jcsteelfabricators.com	\N
757	Steve Knudsvig	JD2 Inc.	sknudsvig@jd2inc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr PM	\N	CA	\N	\N	\N	\N	info@jd2inc.com	\N
758	Larry Jeffords	Jeffords Steel & Engineering Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Plattsburgh	NY	USA	\N	\N	\N	\N	(518) 561-4061
759	Steve Bell	Jesse Company	sbell@jesse-co.com	253-922-7433	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	WA	\N	\N	\N	\N	\N	253-922-7433
760	Joseph Messner	JGM Fabricators & Constructors	jmessnerjr@jgmusa.com	610-873-0081	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP of Estimating	Coatesville	PA	USA	\N	\N	\N	\N	610-873-0081
761	Ivan ()	JHDS Structural Steel Fabricators	estimating@jhdsllc.com	(973) 782-4086	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Estimator	\N	NJ	\N	\N	\N	\N	estimating@jhdsllc.com	(973) 782-4086
762	Craig Gil	Joel Hewatt Company	cgil@joelhewattco.com	O:(925)252-0200, C:(925)876-3960	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	CA	\N	\N	\N	\N	joelhewatt@spcglobal.net	O:(925)252-0200, C:(925)876-3960
763	Joel ()	Joel's Iron Works	joel-q@charter.net	775-745-5721	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	NV	\N	\N	\N	\N	joel-q@charter.net	775-745-5721
764	John Maltese Iron works Inc	John Maltese Iron works Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	North Brunswick	NJ	USA	\N	\N	\N	\N	(732) 249-4350
765	Johnson Machine Works	Johnson Machine Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chariton	IA	USA	\N	\N	\N	\N	641-774-2191
766	Jeff Johnson	Johnson Machine Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chariton	IA	USA	\N	\N	\N	\N	(641) 774-2191
767	Ben Joiner	Joiner & Associates, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Louisville	GA	USA	\N	\N	\N	\N	(706) 829-1238/478-625-7129
768	Paul Campbell	Jon Edwards Steel Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Columbus	OH	USA	\N	\N	\N	\N	(614) 274-7015
769	Jones valley fabrication, Inc	Jones valley fabrication, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oneonta	AL	USA	\N	\N	\N	steel@jonesvalleyfab.com	(205) 675-0151
770	Corey Battle	Jonquil Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mableton	GA	USA	\N	\N	\N	\N	(770) 948-9876
771	Corey Battle	Jonquil Steel & Construction Co., Inc.	cbattle@jonquilsteel.com	770-948-9876	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	Atlanta	GA	USA	\N	\N	\N	\N	770-948-9876 CoreyC: 678-886-1157
772	John McDonald	Joseph Oat Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Camden	NJ	USA	\N	\N	\N	\N	(856) 541-2900
773	Matt Freund	JPW Companies	mattfreund@jpwcompanies.com	315) 432-1111	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	NY	\N	\N	\N	\N	\N	315) 432-1111
774	Kyle Bruckelmyer	JRK steel Inc	kyle@jrksteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Duluth	MN	USA	\N	\N	\N	office@jrksteel.com	218-624-5793
775	JSTEEL Inc	JSTEEL Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Windham	ME	USA	\N	\N	\N	\N	\N
776	Jeremy Arnold	JT Steel	jarnold@jtsteel.com	801-856-5546, 801-280-3520	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP Estimating	\N	UT	\N	\N	\N	\N	jarnold@jtsteel.com	801-856-5546, 801-280-3520
777	Detailing department	JV Driver Fabricators Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	(602) 734-4134
778	Diego Penafiel	K & K Iron Works, LLC	dpenafiel@kkironworks.com	708-924-0000 x7521	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	McCook	IL	USA	\N	\N	\N	\N	708-924-0000 x7521
779	Jared Bolander	K&J Steel	jared@kjsteel.net	435-674-2250 C: 435-619-9973	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	UT	\N	\N	\N	\N	kbkjs@infowest.com	435-674-2250 C: 435-619-9973
780	William Koch / Josh Brazelton	K&T Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Twin Falls	ID	USA	\N	\N	\N	\N	(208) 733-2554
781	K.B. Steel fabrication LLC	K.B. Steel fabrication LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Geraldine	AL	USA	\N	\N	\N	\N	256-659-6813
782	Kalis Steel & Fab	Kalis Steel & Fab	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Edmore	MI	USA	\N	\N	\N	\N	989-427-3816
783	David E. Fuller	Kansas City Steel Werx, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kansas City	MO	USA	\N	\N	\N	\N	(913) 915-5133
784	Mike Bachtle	Kansas City Werx, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	Kansas City	MO	USA	\N	\N	\N	info@kcsteelwerx.com	816-437-9199
785	Ken Osterloh	Kard Welding, Inc	estimating@kardwelding.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	\N	OH	\N	\N	\N	\N	info@kardwelding.com	\N
786	Ken Kimura	Kasco Fab Inc	estimating@kascofab.com	559-442-1018	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	\N	CA	\N	\N	\N	\N	estimating@kascofab.com	559-442-1018
787	Todd Reichart	Katelman Fabrication	treichart@katelman.com	712-323-3131	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	NE	\N	\N	\N	\N	webmaster@katelman.com	712-323-3131
788	Matt Heffington / Frank Martinez	KB Fabrication & welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Meridian	ID	USA	\N	\N	\N	matt@kbwelding.biz/frank@kbwelding.biz / bill@kbwelding.biz	208-898-9353
789	KC Engineering PC	KC Engineering PC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sioux City	IA	USA	\N	\N	\N	\N	0000000000
790	Lynn Bogh	KCB Towers, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Highland	CA	USA	\N	\N	\N	\N	(909) 862-0322
791	Keeler Ironworks Inc	Keeler Ironworks Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Memphis	TN	USA	\N	\N	\N	keeleriron@aol.com	901-947-4816
792	Kenneth Kennedy	Kennedy Fabricating	kokennedy@kennedyfab.com	281-399-3008	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	TX	\N	\N	\N	\N	\N	281-399-3008
793	Robert Quintana	Kern Steel	robert@kernsteel.com	O:(661)327-9588, RobertC:(661)343-0312	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	CA	\N	\N	\N	\N	robert@kernsteel.com	O:(661)327-9588, RobertC:(661)343-0312
794	Kertz Iron works Inc	Kertz Iron works Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	St. Louis	MO	USA	\N	\N	\N	\N	+1 314-481-3406
795	Scott Hackney	Keystone Steel Services, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rhome	TX	USA	\N	\N	\N	shackney@keystonesynergy.com	(817) 636-3306/817.636.3300
796	Ashley Thornton	King Fabrication	athornton@kingfab.com	(281) 209-0811	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	Houston	TX	USA	\N	\N	\N	receptionist@kingfab.com	281-209-0811
797	James Jones	King Steel, Inc.	jjones@kingsteelinc.net	770-963-3888	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Senior Estimator	Lawrenceville	GA	USA	\N	\N	\N	\N	770-963-3888
798	Kingery steel fabricators	Kingery steel fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lansing	IL	USA	\N	\N	\N	\N	708-474-6665
799	Dick Marker	Kinsley Steel, Inc.	dmarker@kinsleysteel.com	Eric:717-757-8779	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Chief Estimator	\N	PA	\N	\N	\N	\N	rmarker@kinsleyconstruction.com	Eric:717-757-8779 O:717-757-8761
800	Steve Klute	Klute, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	York	NE	USA	\N	\N	\N	\N	(402) 362-1055
801	Jay ()	Knoll Steel Inc	sales@knollsteelinc.com	(815) 675-9400	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IL	\N	\N	\N	\N	Sales@KnollSteelInc.com	(815) 675-9400
802	Knoxville Structural Steel	Knoxville Structural Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TN	USA	\N	\N	\N	\N	865-523-2323
803	Rajiv Paralkar/Nick Morson	Koenig Iron	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Chief Estimator	Astoria	NY	USA	\N	\N	\N	\N	718-433-0900/Ex.2240
804	Eric Stier	Koronis Fabricating Inc	eric.stier@koronisfab.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	MN	\N	\N	\N	\N	\N	\N
805	Extension 256	Kully Pipe and Steel Supply	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hastings	NE	USA	\N	\N	\N	\N	402-463-5678
806	Terri D. Renick	Kupferer Brothers Iron Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Department	Affton	MO	USA	\N	\N	\N	mvessell@kupferer.com	314-843-6030
807	John Hult	Kustum steel fabricator Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager / Estimator	McClellan Park	CA	USA	\N	\N	\N	\N	916-568-5322
808	Richard Daneault	L & D Steel USA Inc.	richard.daneault@ldsteelusa.com	(727) 538-9917          EXT 239	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Chief Estimator	Largo	FL	USA	\N	\N	\N	richard.daneault@ldsteelusa.com	(727) 538-9917
809	Jeff Johnson	L & M Industrial fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr. PM	Tangent	OR	USA	\N	\N	\N	Cfritz@steelfab-inc.com	541-752-0110
810	L & M welding	L & M welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mesquite	NV	USA	\N	\N	\N	lmweldingshop@gmail.com	702-346-2365
811	L & M welding Inc.	L & M welding Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chicago	IL	USA	\N	\N	\N	lsalas.l-m_welding@sbcglobal.net	(773) 237-8500 & 8501
812	L & N metal works	L & N metal works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Gillett	WI	USA	\N	\N	\N	neal@lnmetalworks.com	920-855-6100
813	Patrick  canning	L&M Fabrication & Machine, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bath	PA	USA	\N	\N	\N	\N	(610) 837-1848
814	Luigi Liberato	L. Liberato Steel Fabricating Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Spring City	PA	USA	\N	\N	\N	info@liberatosteel.com	(610) 948-9540
815	Mike Simon	LaBelleCo Fabrication	msimon@labellecofab.com	409-225-5499	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Structural Estimator	\N	TX	\N	\N	\N	\N	wleach@labellecofab.com	409-225-5499
816	Lamar's Fabrication Inc	Lamar's Fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Beech Island	SC	USA	\N	\N	\N	\N	706-513-1992
817	Land metal builders	Land metal builders	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sierra Vista	AZ	USA	\N	\N	\N	\N	520-803-0639
818	Lane Steel Fabricators, LLC	Lane Steel Fabricators, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chattanooga	TN	USA	\N	\N	\N	brian@lanesteelfab.us	423-867-2846
819	Ronnie Jones	Lane Supply, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Arlington	TX	USA	\N	\N	\N	\N	(817) 261-9116
820	Donnie Blacksher	Larco Industries	donnie@larcoind.com	(409) 866-9155	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	GM	\N	TX	\N	\N	\N	\N	\N	\N
821	Adam Coates	Lawton Welding Company	adamc@lawtonwelding.com	(978) 887-0005	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	MA	\N	\N	\N	\N	ryanm@lawtonwelding.com, johnp@lawtonwelding.com	(978) 887-0005
822	Brett Austin	LB Constrcution Inc	baustin@lbconstructioninc.com	C:916-477-0955 O:(916) 624-8404	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailer	Roseville	CA	USA	\N	\N	\N	rsalle@lbconstructioninc.com	C:916-477-0955 O:(916) 624-8404
823	John Gall	Lee's Imperial Welding, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fremont	CA	USA	\N	\N	\N	\N	(510) 657-4900
824	Legacy steel	Legacy steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Grand Rapids	MI	USA	\N	\N	\N	\N	(616) 333-2878
825	Dawn Sanchez	Legna Iron Works	dsanchez@legnairon.com	(630)894-8056x107x105x101	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	HeadEstimator	\N	IL	\N	\N	\N	\N	dsanchez@legnairon.com	(630)894-8056x107x105x101
826	Todd Erickson	Mull Iron	todd@mulliron.net	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	OH	\N	\N	\N	\N	\N	\N
827	Kurt Johnson	LeJeune Steel Company	kurt.johnson@lejeunesteel.us	612-861-3321	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Structural Steel Estimator	Minneapolis	MN	USA	\N	\N	\N	\N	612-861-3321
828	Allen Hanavan	Lenex Steel Company	allen.hanavan@lenexsteel.com	812) 232-8300	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	IN	\N	\N	\N	\N	CHRIS.HARTIGAN@LENEXSTEEL.COM	812) 232-8300
829	David Mushko	Levan Associates Inc	dmushko@levanfab.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	\N	PA	\N	\N	\N	\N	MMiller@levanfab.com	\N
830	Joe Tannehill	Lexicon dba Steel Fabricators of Monroe	jtannehill@steelfab.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	LA	\N	\N	\N	\N	lexiconinfo@lexicon-inc.com	\N
831	Steven Mitchell	Liberty Steel Fabrication	steven@libertysteelinc.com	256-623-3027	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	\N	\N	\N	\N	info@libertysteelinc.com	256-623-3027
832	Lichtenwald-Johnston Iron Works	Lichtenwald-Johnston Iron Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Morton Groove	IL	USA	\N	\N	\N	\N	847-966-1100
833	Travez	Lincoln Contracting & Equipment Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Somerset	PA	USA	\N	\N	\N	\N	(814) 629-2112
834	Frank Perriello	Lincoln Fabricating Company, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pittsburgh	PA	USA	\N	\N	\N	\N	(412) 361-2400
835	Bennett C. Hey	Liphart Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Richmond	VA	USA	\N	\N	\N	info@liphartsteel.com	804-355-7481
836	Ed Jennings	Liphart Steel Co. Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Richmond	VA	USA	\N	\N	\N	\N	(804) 355-7481
837	Eugenio Fernandez	Litecrete, Inc.	efernandez@litecrete.com	305-500-9373	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Vice President	Miami	\N	USA	\N	\N	\N	efernandez@litecrete.com	305-500-9373
838	Scott Durbin	Littell Steel Company	sdurbin@littellsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	\N	PA	\N	\N	\N	\N	\N	\N
839	Steven Koval/ Jonas	Little Washington Fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	PA	USA	\N	\N	\N	jonas@littlewashingtonfab.com	610-979-0079
840	John Liverett / Jennifer Reed	Liverett Fabricating Company, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rome	GA	USA	\N	\N	\N	JBallard@Liverett.com?	(706) 234-8689/19
841	Mike Nail	LIVI Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Manager	Warren	OH	USA	\N	\N	\N	livisteel@embarqmail.com	(330) 373-1181
842	LIW Corportation	LIW Corportation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ramsey	MN	USA	\N	\N	\N	\N	763-323-8114
843	Steven Ancelet	Loadmaster Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Broussard	LA	USA	\N	\N	\N	\N	(337) 837-5429
844	Lochert Steel Construction	Lochert Steel Construction	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602-268-1880
845	Ron Farnaus	Lockport Steel Fabricators	rfarnaus@lockportsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	Lockport	IL	USA	\N	\N	\N	lsfhub@lockportsteel.com	815.726.6281
846	Lopez Welding SSE LLC.	Lopez Welding SSE LLC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Harvey	LA	USA	\N	\N	\N	?info@lopezweldingsse.com	504-919-6150
847	Louden steel detailing	Louden steel detailing	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Indianapolis	IN	USA	\N	\N	\N	\N	(317) 483-1134
848	Karen Smith	Louis Smith Construction, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Gulfport	MS	USA	\N	\N	\N	\N	(228) 896-1221
849	Lou's Welding & Repair, LLC	Lou's Welding & Repair, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sagle	ID	USA	\N	\N	\N	lou@sandpointwelding.com	208.597.6157
850	Lowcounty steel detailers	Lowcounty steel detailers	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Goose Creek	SC	USA	\N	\N	\N	\N	843-572-1123
851	Tyler Scott	Lundahl Iron Works	tbscott@lundahlironworks.com	Tyler: 208.646.2600 C: 435.230.2268	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	ID	\N	\N	\N	\N	tbscott@lundahlironworks.com	CheckContacts
852	Pete Aguilar	LV Iron & Steel	pete@lviron-steel.com	702.608.4766	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	\N	NV	\N	\N	\N	\N	info@lvironsteel.com	\N
853	David Reid	Lyndon Steel Company	\N	336-785-0848	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	BigDawg	Winston Salem	\N	USA	\N	\N	\N	\N	336-785-0848
854	Griffin Thrash	M&J Steel, LLC	gthrash@mnj.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	\N	\N	\N	\N	\N	\N
855	Craig Moseley	M&N Structures, Inc	craigm@mnstructures.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	MN	\N	\N	\N	\N	\N	\N
856	Mac A lijon fabrication	Mac A lijon fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Savannah	GA	USA	\N	\N	\N	\N	2
857	Mace Iron Works	Mace Iron Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Frankfort	IL	USA	\N	\N	\N	\N	815-469-2345 or 708-479-2456
858	Machanix Fabrication	Machanix Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Henderson	NV	USA	\N	\N	\N	info@url.com	702-566-1128
859	Larry Ledford	Maco Incorporated of Shelby	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Shelby	NC	USA	\N	\N	\N	\N	704-286-0849
860	brad	Maco metal fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Shelby	NC	USA	\N	\N	\N	brad@macoincorporated.com	(704) 434-6800
861	Gary Cowart / Lee Mooney/Kevin Pruett	Macuch Steel Products, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Augusta	GA	USA	\N	\N	\N	info@macuchsteel.com (or) estimating@macuchsteel.com	(706) 823-2420/7063966123(kevin DD)
862	Erik Falk	Madden Bolt Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Houston	TX	USA	\N	\N	\N	\N	(713) 939-9999
863	Chris Madden	Madden Fabrication	cmadden@madfab.com	503-226-3968	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Portland	OR	USA	\N	\N	\N	cmadden@madfab.com	503-226-3968
864	Maeco Fabrication Inc	Maeco Fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	USA	\N	\N	\N	\N	251-865-6203
865	Patty  - Co-Owner/ John	Magna Steel Sales, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimation department	\N	CT	USA	\N	\N	\N	\N	(203) 888-0300
866	Dave Cox	Maico Industries Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ellsworth	KS	USA	\N	\N	\N	\N	(785) 472-5390
867	Mainline welding (or) Main Mechanical Inc.	Mainline welding (or) Main Mechanical Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lake Havasu City	AZ	USA	\N	\N	\N	\N	928-219-9246
868	Man of Steel of Louisiana	Man of Steel of Louisiana	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Slidell	LA	USA	\N	\N	\N	perrymanofsteel@gmail.com	504-319-3029
869	Dave Duley	Manowske Welding Corp	dduley@manowskewelding.com	(920) 922-3340	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	WI	\N	\N	\N	\N	Sales@ManowskeWelding.com	(920) 922-3340
870	Don Cerny	Manowske Welding Corp.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fond du Lac	WI	USA	\N	\N	\N	\N	920-922-3340
871	Mansell Welding Inc.	Mansell Welding Inc.	mansell@mansellwelding.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lake Havasu City	AZ	USA	\N	\N	\N	\N	928-855-6743
872	Timber Finn	Manufab	timber@manufabmetal.com	208.390.9087	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rexburg	ID	USA	\N	\N	\N	\N	208-356-9515
873	Justin M. Frederick	MANUFAB Partners LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kenner	LA	USA	\N	\N	\N	\N	(504) 466-2368
874	Marcum's Welding & Steel Processing, Inc	Marcum's Welding & Steel Processing, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Morristown	IN	USA	\N	\N	\N	\N	\N
875	Bobby Esmilla	Maricopa Metals, Inc.,	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AZ	USA	\N	\N	\N	info@maricopametals.com	602-437-0276
876	AJ Comito	Maricopasteel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Apache Junction	AZ	USA	\N	\N	\N	info@maricopasteel.com	480.671.5730
877	James Vemich / Jay Gaisford	Mark Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/Vp Estimating	Salt Lake City	UT	USA	\N	\N	\N	\N	(801) 527-0670
878	Jose Bernal	Markle Manufacturing	j.bernal@marklemfg.com	(210) 655-7130 Ext: 13	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	TX	\N	\N	\N	\N	RBadillo@Marklemfg.com	(210) 655-7130 Ext: 13
879	Charlie ()	Marquette Steel Supply Fabrication Inc.	charlie.marqstl@sbcglobal.net	815-433-0178	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IL	\N	\N	\N	\N	1) charlie.marqstl@sbcglobal.net             2) jessica@marquettesteelsupply.com	815-433-0178
880	Scott	Marr Ironworks Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bakersfield	CA	USA	\N	\N	\N	s.harper@bak.rr.com , marrworks@bak.rr.com	661-587-9927
881	Josh Anderson	Marshall Machine Shop, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Marshall	MN	USA	\N	\N	\N	\N	(866) 262-4418 (or) (507) 532-3613
882	Marshfield Steel	Marshfield Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Marshfield	WI	USA	\N	\N	\N	\N	715-384-5484
883	Piero Bullentini	Martin Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Reno	NV	USA	\N	\N	\N	BarryM@martinironworks.net	(775) 329-8631
884	Martin Steel	Martin Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Huntington	WV	USA	\N	\N	\N	martinsi@martinsteelinc.com	304.429.5534
885	Bryan Lovelady / Nathan Whitman/rob mann	Miscellaneous Steel Industries, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kyle	TX	USA	\N	\N	\N	\N	(512) 268-2831
886	Matt Athy	Martin Steel Fabrication, Inc	mattathy@martinsteelfab.com	618-556-9610 C: 618-410-7108	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	\N	MO	\N	\N	\N	\N	martyathy@martinsteelfab.com	618-556-9610 C: 618-410-7108
887	Martin Steel Inc	Martin Steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Huntington	WV	USA	\N	\N	\N	\N	\N
888	Tom Graef	MARTIN’S METAL FABRICATION & WELDING, INC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager/Estimator	Vacaville	CA	USA	\N	\N	\N	quotes@MartinsMetalFab.com	1-707-678-4117
889	Marvin Metals Fabricating	Marvin Metals Fabricating	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Waupaca	WI	USA	\N	\N	\N	\N	\N
890	Mason Structural Steel, Inc.	Mason Structural Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cleveland	OH	USA	\N	\N	\N	\N	(440) 439-1040
891	Charles Grant	Material Storage Systems, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Humble	TX	USA	\N	\N	\N	\N	(281) 446-7144
892	Mathfab llc	Mathfab llc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oshkosh	WI	USA	\N	\N	\N	Estimating@mathfab.com	(920)231-6060
893	Jeff Remington	MATHFAB LLC (Snell Shop)	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oshkosh	WI	USA	\N	\N	\N	\N	(920) 231-6060
894	MaXX Steel Erectors	MaXX Steel Erectors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Maple Plain	MN	USA	\N	\N	\N	\N	\N
895	Maxxweiss Company	Maxxweiss Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Milwaukee	WI	USA	\N	\N	\N	\N	414.355.8220
896	John Norby	Maya Steel	johnnorby@mayasteel.com	310-532-8830	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Chief Estimator	\N	CA	\N	\N	\N	\N	johnnorby@Mayasteel.com	310-532-8830
897	Vincent Mazzella	Mazzella Welding & Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Wellsburg	WV	USA	\N	\N	\N	\N	(304) 829-4300
898	Phillip B. Mazzella	Mazzella Welding & Fabrication, Inc.	\N	(304) 829 4300 EXT 110	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Industrial Management - estimation	Wellsburg	WV	USA	\N	\N	\N	mwf@mazzella.com	(304) 829 4300
899	Joe Leslie	MBM Fabricators	jleslie@mbmfab.com	734) 941-0100	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	GM/MainMan	\N	MI	\N	\N	\N	\N	\N	734) 941-0100
900	Mc Gill Steel LLC	Mc Gill Steel LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hixson	TN	USA	\N	\N	\N	\N	423-842-7072
901	John Concelliere	MC Iron Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bath	PA	USA	\N	\N	\N	\N	(610) 837-9914
902	Ryan Rodbro	Mc Kinney Steel & Sales Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Zion	IL	USA	\N	\N	\N	info@mckinneysteel.com	847-746-3344
903	Jeff Ramsey	McClean Iron Works	jeffr@mcciron.com	(425) 493-5525	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Engineering Manager	\N	WA	\N	\N	\N	\N	jeffr@mcciron.com	(425) 493-5525
904	Tony La Rosa	McCombs Steel Company, Inc.	tlarosa@mccombs-steel.com	704-873-7563 x230	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	Statesville	NC	USA	\N	\N	\N	rhughes@mccombs-steel.com	704-873-7563 x230
905	Matthew Moxon	McFarlane Mfg. Company, Inc.	mmoxon@mcfarlanemfg.com	(608) 643-3322	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	WI	\N	\N	\N	\N	\N	(608) 643-3322
906	Bob McGregor / Grace	McGregor Industries, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dunmore	PA	USA	\N	\N	\N	rmcgregor@mcgregorindustries.com	(570) 343-2436
907	McGregor Steel Fabrication	McGregor Steel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oxford	MS	USA	\N	\N	\N	\N	\N
908	Gregg Liske	McWhirter Steel	gliske@mcwhirtersteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lancaster	CA	USA	\N	\N	\N	\N	(661) 951-8998
909	Philip Spagnoli	Mechanical & Industrial Steel Services, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rock Tavern	NY	USA	\N	\N	\N	\N	(845) 245-4223
910	Dennis Belotti	Mechanical and Industrial steel services Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Channahon	IL	USA	\N	\N	\N	\N	(815) 521-1725
911	Mike Hockstad	Mechanical Industries Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bakersfield	CA	USA	\N	\N	\N	mhockstad@mii-us.com	(661) 634-9477
912	Megquier & Jones Inc	Megquier & Jones Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	South Portland	ME	USA	\N	\N	\N	\N	\N
913	Jack Olsen	Merchant Iron Works, Inc.	jolsen@merchantironworks.com	803-481-9931	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Sumter	SC	USA	\N	\N	\N	\N	803-481-9931
914	James Meaden	Merill iron & steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Schofield	WI	USA	\N	\N	\N	jmeaden@merrilliron.com	715-355-8924      715-302-0664
915	Earnest Hinner	Merrill Fab Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Merrill	WI	USA	\N	\N	\N	\N	(715) 536-9584
916	James Meaden	Merrill Steel	jmeaden@merrillsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Head	\N	WI	USA	\N	\N	\N	info@merrillsteel.com	7153934132
917	Mesa Fab Shop Inc.	Mesa Fab Shop Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pueblo	CO	USA	\N	\N	\N	\N	(719) 948-5384
918	Greg Wark	Metal Arts, LLC	greg@mtlrts.com	316-942-7958	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	Wichita	KS	USA	\N	\N	\N	\N	316-942-7958
919	Metal fabrication solutions	Metal fabrication solutions	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	McComb	MS	USA	\N	\N	\N	\N	(985) 400-8400
920	Chris	Metal Fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Atlanta	GA	USA	\N	\N	\N	\N	404-627-2428
921	Greg	Metal Man Mobile Welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	greg@milvtech.com	702-327-8658
922	Daniel Ibarra	Metal Pros LLC	daniel.ibarra@metalprosllc.com	316-942-2238 x111	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator/PM	\N	KS	\N	\N	\N	\N	\N	316-942-2238 x111
923	Metal Solutions	Metal Solutions	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ault	CO	USA	\N	\N	\N	\N	970-834-2700
924	Roda	Metal Supply, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing department	South Gate	CA	USA	\N	\N	\N	roda@metalsupply.com	562-634-9940/3128
925	Tod hamilton	Metal Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating Department	Oroville	CA	USA	\N	\N	\N	tod@mtlwks.com	530-532-3707 ex:-107
926	JP Martinez	Metals Fabrication Company, Inc.	jp@metalsfab.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr Estimator	\N	WA	\N	\N	\N	\N	jp@metalsfab.com	\N
927	metals plus Corp	metals plus Corp	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Linden	NJ	USA	\N	\N	\N	\N	908-862-7677
928	Wes Sillineri	Metalset	wesleys@metalsetinc.com	(510)233-9998	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	CA	\N	\N	\N	\N	\N	(510)233-9998
929	Benjamin Smith	Metal-Weld Specialties, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Peoria	AZ	USA	\N	\N	\N	bens@metal-weld.com	623 979 1117
930	Metalworking Solutions	Metalworking Solutions	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chattanooga	TN	USA	\N	\N	\N	\N	\N
931	Adam	Met-Con, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cocoa	FL	USA	\N	\N	\N	rai@metconinc.com	(321) 632-4880
932	metfab metals LLC	metfab metals LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	City of Orange	NJ	USA	\N	\N	\N	\N	973-675-7676
933	Metro contract services	Metro contract services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chesterfield	MO	USA	\N	\N	\N	\N	\N
934	Metro Iron corp	Metro Iron corp	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Amityville	NY	USA	\N	\N	\N	info@metroiron.com	631) 842 5929
935	Luciano Russo	Metro Erectors / Metro Fabrication	lrusso@metrosteel.net	lrusso@metroerectorsny.com	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	NY	\N	\N	\N	\N	\N	\N
936	Metro Welding and Fabrication	Metro Welding and Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Big Bend, Waukesha	WI	USA	\N	\N	\N	\N	262-662-3477
937	Matt Hager	Michael & Company Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Chief Estimator / Project Manager	Lockeford	CA	USA	\N	\N	\N	\N	209-787-8040 ex:-105
938	Tyler Hughes	Michelman Steel Enterprises	thughes@michelmansteel.com	610-739-2996	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Bethelehem	PA	USA	\N	\N	\N	\N	610-739-2996
939	Connor ()	Michelmann Steel Construction	connorc@michelmann.us	(217) 222-0555	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IL	\N	\N	\N	\N	\N	(217) 222-0555
940	Michigan Fabrication & engineering	Michigan Fabrication & engineering	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Clarkston	MI	USA	\N	\N	\N	\N	248-297-5268
941	Michigan Steel Fabrication Inc.	Michigan Steel Fabrication Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Flint	MI	USA	\N	\N	\N	info@michigansteel.com	(810) 785-1478
942	Keith ()	Mid America Steel	\N	(701) 232-8831	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	ND	\N	\N	\N	\N	\N	(701) 232-8831
943	Mid Island steel corp	Mid Island steel corp	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Medford	NY	USA	\N	\N	\N	\N	631-696-0066
944	Melissa Boulden (Female)	Mid-Atlantic Steel, LLC.	mboulden@midatlanticsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP of Project Development / Director of Engineering	New Castle	DE	USA	\N	\N	\N	mboulden@midatlanticsteel.com	(302) 323-1800
945	Chris Steindorf	Mid-City Steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	La Crosse	WI	USA	\N	\N	\N	\N	(608)-793-2309
946	Nick Goins	Mid-City Steel, Inc.	ngoins@mid-citysteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	WI	\N	\N	\N	\N	\N	\N
947	Ellen Jordan	Midland Steel Company	ejordan@midlandsteelco.com	816-891-8118	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Senior Estimator / PM	\N	KS	\N	\N	\N	\N	\N	816-891-8118
948	Chuck Staffins	Midsouth Steel, Inc.	estimating@midsouthsteel.net	770-465-3455	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	College Park	GA	USA	\N	\N	\N	estimating@midsouthsteel.net,	770-465-3455
949	Josh Jeantet	Mid-State Steel Erectors Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	Stockton	CA	USA	\N	\N	\N	\N	209) 464-9497
950	Daniel Slocumb	Midstate Steel Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Macon	GA	USA	\N	\N	\N	dslocumb@midstatesteel.com	(478) 741-4598
951	Jim Sherwood	Midstate Steel, LLC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Utica	NY	USA	\N	\N	\N	estimating@midstate-steel.net	(315) 733-9288
952	Tyler James	Mid-State welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project manager	Clinton	MS	USA	\N	\N	\N	\N	601-925-0053
953	David Zenor	Mid-States Steel Corp.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Boone	IA	USA	\N	\N	\N	mss@mssfab.com	(515) 432-1646
954	Dave Barrows	Midwest Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Detroit	MI	USA	\N	\N	\N	\N	(313) 873-2220
955	Midwest Steel Fabrication & Supply Company	Midwest Steel Fabrication & Supply Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Indianapolis	IN	USA	\N	\N	\N	\N	\N
956	Rob Ediger	Midwest Steel Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lincoln	NE	USA	\N	\N	\N	\N	(402) 476-7545
957	Anthony Tomich	Midwestern Steel Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hammond	IN	USA	\N	\N	\N	\N	(219) 933-1430
958	Darnell Joseph	MIG Steel Fabrication	darnell.joseph@migsteelhouston.com	832-758-1970	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	\N	832-758-1970
959	Fred ()	Mike Owen Fabrication	fred@mikeowenfab.com	(661) 387-1703	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	CA	\N	\N	\N	\N	fred@mikeowenfab.com	(661) 387-1703
960	Jason Soucy	Mill city Iron fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Dracut	MA	USA	\N	\N	\N	\N	978.957.6833
961	Steve ()	Miller Fab and Weld Corp	\N	(951) 359-3100	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	\N	\N	\N	\N	\N	chris@millersfab.net	(951) 359-3100
962	Marek Kulbacki	Milling Machinery, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mesa	AZ	USA	\N	\N	\N	\N	(480) 964-9041
963	Minestone Construction LLC	Minestone Construction LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hillsborough	NJ	USA	\N	\N	\N	\N	\N
964	Minnesota structural steel	Minnesota structural steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	St. Cloud	MN	USA	\N	\N	\N	\N	320-251-3640
965	Doug Pugh	Misc. Metals and Fabrication LLC	Doug.Pugh@metalsandfab.net	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Northport	AL	USA	\N	\N	\N	\N	(205) 339-3181
966	Mark E. Kissner	Miscellaneous Metals, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Walkersville	MD	USA	\N	\N	\N	\N	(301) 695-8820
967	Tim Massman	Missouri Fabricators	timm@occimofab.com	Tim C: 573-690-4433	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr PM	\N	MO	\N	\N	\N	\N	573-642-6087 x1047	Tim C: 573-690-4433
968	John Miller	MMI Industrial & Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mesa	AZ	USA	\N	\N	\N	\N	480.964.9041
969	Paul Jacobs	MMW Structural Steel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hurst	TX	USA	\N	\N	\N	\N	(817) 284-4978
970	Mike Dunavant	Mobil Steel	mdunavant@mobilsteel.com	713-991-0450	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	TX	\N	\N	\N	\N	mscott@mobilsteel.com	713-991-0450
971	Brandon Beachy	Montana Steel Industries, Inc.	brandon@montana-steel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailier	\N	MT	\N	\N	\N	\N	\N	\N
972	Kenneth J Bachini	Monterey structural steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Watsonville	CA	USA	\N	\N	\N	\N	+1 831-768-1277
973	James Morford / Matthew Druga	Moore & Morford, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Greensburg	PA	USA	\N	\N	\N	\N	724) 834-1100
974	Marilyn Moran/Lee Fayssoux	Moran Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/PM	Onaway	MI	USA	\N	\N	\N	\N	(989) 733-2011
975	Moreno Welding	Moreno Welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602-276-9508
976	Morris steel	Morris steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Powhatan	VA	USA	\N	\N	\N	\N	1
977	Chad Morrow	Morrow Steel Fabricators, Inc.	cmorrow@morrowsteel.com	813-715-0404	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Zephyrhills	FL	USA	\N	\N	\N	cmorrow@morrowsteel.com	813-715-0404
978	Maurice Sutton	Mo-Steel Fabricator & Erector	mosteel5@aol.com	305-945-4855	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	Miami	FL	USA	\N	\N	\N	mosteel5@aol.com	305-945-4855
979	Mike Copenhaver	Mound Technologies	mcopenhaver@moundtechnologies.com	(937) 748-2937	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	OH	\N	\N	\N	\N	\N	(937) 748-2937
980	Mountain metals LLC	Mountain metals LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ponderay	ID	USA	\N	\N	\N	\N	(208) 263-6031
981	Brian Connelly/Allen Puckett	Mountain Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kuna	ID	USA	\N	\N	\N	pauoa@msfboise.com	208-344-5930
982	Sean Abeyta	Mountain view welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	Longmont	CO	USA	\N	\N	\N	sean.a@mountainviewwelding.com	303.776.7845 Ext. 24
983	Willie	MR Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	willie@mrsteel.com	(602) 278-3355
984	MSI Fabrication & Construction	MSI Fabrication & Construction	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Clinton	IA	USA	\N	\N	\N	\N	563-259-8689
985	MSM sheet metal and steel fabrication inc.	MSM sheet metal and steel fabrication inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	(775) 356-5542,    (800) 356-0977
986	Rene Brown (Female)	MSSM Industrial Construction	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	General Manager/Vice President	Pueblo	CO	USA	\N	\N	\N	\N	(719) 948-3195
987	Nick Salamone	Munster Steel	nsalamone@munstersteel.com	(219)924-5198	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	IL	\N	\N	\N	\N	estimating@munstersteel.com	(219)924-5198
988	Tony Baffone	Murphy Steel, Inc.	tony@murphysteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	\N	DE	\N	\N	\N	\N	tony@murphysteel.com, greg@murphysteel.com, vinny@murphysteel.com	\N
989	Dave Potter	Mustang fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bellefonte	PA	USA	\N	\N	\N	\N	(814) 355-5026
990	MW Industrial Services, Inc.	MW Industrial Services, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	USA	\N	\N	\N	\N	205.991.0072
991	Bob Myers	Myers & Co. Architectural Metals	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Basalt	CO	USA	\N	\N	\N	info@myersandco.com	(970) 927-4761
992	Dylan Myers / John Fadenrecht	Myers Steel Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dillsburg	PA	USA	\N	\N	\N	\N	(717) 502-0266/5
993	Nelson Martinez	Myrex Industries	nmartinez@myrex.com	(713) 691-5200	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Drafting Manager	\N	TX	\N	\N	\N	\N	nmartinez@myrex.com	(713) 691-5200 NelsonC:281-731-1519
994	Henry Yue	MyWi Fabricators	henry.yue@mywifabricators.com	626-279-6994	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	CA	\N	\N	\N	\N	info@mywifabricators.com	626-279-6994
1081	Ben Leach	PAX, LLC.	bleach@paxfab.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	LA	\N	\N	\N	\N	info@paxfab.com	\N
995	AJ Fadli	NAR architectural steel and glass	A.Fadli@NARSteel.com	615-601-5619	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Nashville	TN	USA	\N	\N	\N	Info@NARSteel.com	615-712-9928
996	Nashville Fabrication	Nashville Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Nashville	TN	USA	\N	\N	\N	info@nashvillefab.com	615.352.5296
997	Douglas Kuiper	National Metals, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Deforest	WI	USA	\N	\N	\N	\N	(608) 846-9580
998	National Steel Fabricating	National Steel Fabricating	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	New Brighton	MN	USA	\N	\N	\N	\N	715-764-1335
999	National Steel Fabricator	National Steel Fabricator	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rice Lake	WI	USA	\N	\N	\N	\N	715-353-2500
1000	Brad Robeson	NCI Building Systems, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Houston	TX	USA	\N	\N	\N	\N	(281) 897-7536
1001	Nelson Fabrication & Repair	Nelson Fabrication & Repair	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hayden	ID	USA	\N	\N	\N	\N	208-772-6687
1002	Michele Perretta	New England Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cranston	RI	USA	\N	\N	\N	\N	(401) 785-1234
1003	New millenium building system	New millenium building system	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602-233-6120
1004	Thomas house	NEW Millennium Building System	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing manager	\N	FL	USA	\N	\N	\N	\N	3864661300
1005	Judson McLeod	New Orleans Iron Works, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Belle Chasse	LA	USA	\N	\N	\N	\N	(504) 656-8996
1006	New Process Steel	New Process Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Columbus	MS	USA	\N	\N	\N	\N	\N
1007	Ryan Collins	Newman Associates LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Canton	MA	USA	\N	\N	\N	\N	(781) 329-4000
1008	Ryan Gerry	Newport Industrial Fabrication, Inc.	ryan@nif-inc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP Operations	\N	ME	\N	\N	\N	\N	ryan@nif-inc.com	\N
1009	Nick's Metal Fabricating & Sons inc	Nick's Metal Fabricating & Sons inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Brookfield	IL	USA	\N	\N	\N	\N	708-485-1170
1010	Jacob Fremstadt	Nick's Welding & Fabricating, Inc	jacobfremstadt1@gmail.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	WI	\N	\N	\N	\N	\N	\N
1011	Elaine ()	Nimsgern Steel Corp	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	WI	\N	\N	\N	\N	\N	\N
1012	Curtis Drake	Nix Metals	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rockport	IN	USA	\N	\N	\N	\N	(812) 649-2630
1013	Tom Black	NJ Boom & Erectors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Henryville	PA	USA	\N	\N	\N	\N	570.620.1546
1014	Cameron Shade	NMI Industrial Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Design & Engineering Department Supervisor	Sacramento	CA	USA	\N	\N	\N	\N	916-635-7030/6512
1015	Nobel Steel Inc.	Nobel Steel Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602-257-8822
1016	Travis M Williams	Nola Steel Fabrication & Erection	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Vice President & Estimator	Harvey	LA	USA	\N	\N	\N	\N	504.264.7499
1017	Norco Manufacturing Inc.	Norco Manufacturing Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	WI	USA	\N	\N	\N	\N	\N
1018	Tom Lux	Norco Manufacturing, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Franksville	WI	USA	\N	\N	\N	\N	(262) 835-2600
1019	Dani	North Alabama Fabricating Co	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	USA	\N	\N	\N	\N	205-591-5554
1020	Jean	North Central Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	_____________	Mansfield	OH	USA	\N	\N	\N	\N	(419) 529-2744
1021	Jim Carpenetti	North coast Iron corp	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr.Pm	Anacortes	WA	USA	\N	\N	\N	\N	+1 360-755-3060
1022	North Mississippi Steel	North Mississippi Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cold Water	MS	USA	\N	\N	\N	\N	662-233-7048
1023	Roger Johnson	North Shreve Enterprises, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Shreveport	LA	USA	\N	\N	\N	\N	(318) 226-8581
1024	Bryan Chamberlain	North State Steel, Inc.	\N	252-830-8884	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Greenville	NC	USA	\N	\N	\N	info@northstatesteel.com	252-830-8884
1025	T.J. Clark	Northern Services LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	General Manager	Alaska	AK	USA	\N	\N	\N	TJ@907steel.com	907-344-1795 / (907) 334-6452
1026	Northshore Steel Fab, LLC	Northshore Steel Fab, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Slidell	LA	USA	\N	\N	\N	\N	985-649-0718
1027	Milton Larson	Northshore Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Two Harbors	MN	USA	\N	\N	\N	\N	(218) 834-2485
1028	Andy James /Joshua James	Northwest Steel Fab, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr.Est. & PM	Deer Park	WA	USA	\N	\N	\N	\N	(509) 276-1592
1029	Nothern Lights Steel Fabrication	Nothern Lights Steel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	North Branch	MN	USA	\N	\N	\N	\N	651-237-0214
1030	Raymond Proulx	Novel Iron Works	rproulx@noveliron.com	603) 436-7950	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	NH	\N	\N	\N	\N	\N	603) 436-7950
1031	William G Payton	Nucor / Vulcraft Utah	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Brigham City	UT	USA	\N	\N	\N	\N	(435) 734-4530
1032	Nucor Building Systems	Nucor Building Systems	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Swansea	SC	USA	\N	\N	\N	\N	803.568.2100
1033	Kristan Spear	Nucor Corporation Vulcraft Division Texas	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Grapeland	TX	USA	\N	\N	\N	\N	(936) 687-4665
1034	NUCOR skyline steel	NUCOR skyline steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	MS	USA	\N	\N	\N	\N	\N
1035	Detailing centre	Nucor Vulcraft - AL	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fort Payne	AL	USA	\N	\N	\N	\N	(402) 844-2400
1036	Nugent Steel & Supply . Co	Nugent Steel & Supply . Co	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Port Allen	LA	USA	\N	\N	\N	\N	225.387.0987
1037	Camron Hardin	NuSteel Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Childersburg	AL	USA	\N	\N	\N	\N	(256) 378-0880
1038	NWA Steel Co.	NWA Steel Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Springdale	AR	USA	\N	\N	\N	\N	479-751-8868
1206	RK Industries LLC	RK Industries LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Denver	CO	USA	\N	\N	\N	\N	303.355.9696
1039	Erick Blanco	Oakley Steel Products	eblanco@oakleysteel.com	(630)599-8120	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	IL	\N	\N	\N	\N	eblanco@oakleysteel.com	(630)599-8120
1040	Jack Wilson	Ocean Steel & Construction LTD	wilsonj@oceansteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sales Manager	\N	\N	CANADA	\N	\N	\N	\N	\N
1041	WA Braddy	Ogeechee Steel Inc.	wabraddy@ogeecheesteel.com	478-237-2770	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	GA	\N	\N	\N	\N	\N	478-237-2770
1042	Chris Grimm	Ohio Steel Industries	cgrimm@ohiosteel.com	740-927-9500 x335	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM for Detailing	\N	OH	\N	\N	\N	\N	dhill@ohiosteel.com	740-927-9500 x335
1043	OIK Industries	OIK Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Marquette	MI	USA	\N	\N	\N	\N	+1 269-382-1210
1044	Abilash Pyreddy	Olson Steel	apyreddy@olsonsteel.com	510-567-2200	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Assistant Detailing Manager	San Leandro	\N	USA	\N	\N	\N	\N	510-567-2200
1045	Olson Structural Steel	Olson Structural Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	12345678
1046	Omega Iron works	Omega Iron works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mesa	AZ	USA	\N	\N	\N	gasparomg@gmail.com	480-223-3303
1047	On Top fabrication LLC	On Top fabrication LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	623-931-5766
1048	Denis Kloewer	One Ton Welding, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Panama	IA	USA	\N	\N	\N	\N	(712) 489-2577
1049	Victor Cisneros	Orange County Erectors	vcisneros@ocerectors.com	(714)502-8455	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	CA	\N	\N	\N	\N	vcisneros@ocerectors.com	(714)502-8455
1050	Jason Berzsenyi,	Panel Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Loganville	GA	USA	\N	\N	\N	\N	770-466-1357/678-336-7069(DD)
1051	Mike Campo	Orange County Ironworks LLC	mikec@ocillc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	NY	\N	\N	\N	\N	\N	\N
1052	Susan Riemann	Orizon	susan.riemann@spitzerind.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr Estimating Manager	\N	TX	\N	\N	\N	\N	\N	\N
1053	Michael O'Rourke / Colleen (O'Rourke) Feury	O'Rourke & Sons, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	West? Chester	PA	USA	\N	\N	\N	\N	(610) 436-0932
1054	Orsolini Welding & Fabricating	Orsolini Welding & Fabricating	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chicago	IL	USA	\N	\N	\N	\N	773-722-9855
1055	W. Keith Osborne	Osborne Welding, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Portsmouth	VA	USA	\N	\N	\N	\N	(757) 487-0900
1056	Ossi's Iron works	Ossi's Iron works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	stephanie@ossissteel.com	702-765-7000
1057	Contact them as we will do aluminum detailing	Outdoor Aluminum Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Geneva	AL	USA	\N	\N	\N	\N	(180) 022-5424
1058	Overtime fabrication	Overtime fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Queen Creek	AZ	USA	\N	\N	\N	\N	480-768-7396
1059	Jessica Tipple	Owen Steel Company	jessica.tipple@owensteel.com	803-251-7680	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Chief Estimator	\N	SC	USA	\N	\N	\N	\N	803-251-7680
1060	Owenssteel Fabrication	Owenssteel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Springfield	TN	USA	\N	\N	\N	OSFinquiry@gmail.com	(615) 389-4660
1061	Robert Laut	Ozark Steel Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Farmington	MO	USA	\N	\N	\N	\N	(573) 756-5741
1062	Chad Meyer	P&M Steel	cmeyer@pmsteel.net	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Director of Operations-MainMan	\N	SD	\N	\N	\N	\N	\N	\N
1063	Tony Rooyakkers	Pace Metals	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albuquerque	NM	USA	\N	\N	\N	\N	\N
1064	Cliff Guenther	Pacific Coast Iron	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr. Estimator	Spring Valley	CA	USA	\N	\N	\N	cliff@pciron.net	(619) 461-9800
1065	Pacific metal works inc.	Pacific metal works inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Caldwell	ID	USA	\N	\N	\N	\N	208-454-5456
1066	RJ Padgett	Padgett Incorporated	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	New Albany	IN	USA	\N	\N	\N	\N	(812) 945-1299
1067	Rodney Paldi	Paldi Steel Services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	North Las Vegas	NV	USA	\N	\N	\N	\N	(702) 649-3335
1068	Jesse Martinez	Palm Springs Welding Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Supervisor and detailer	\N	\N	USA	\N	\N	\N	\N	760-323-4449
1069	Rosy L Ruiz	Palmer Steel Supplies Inc	rruiz@palmersteel.com	9566866575	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	McAllen	TX	USA	\N	\N	\N	\N	(956) 686-6575
1070	Michael Jr./ Kenneth Whetstone	Palmetto Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lexington	SC	USA	\N	\N	\N	\N	(803) 957-2180
1071	Glenn Papp	Papp Iron works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Vice President	Plainfield	NJ	USA	\N	\N	\N	\N	(908) 731 1000
1072	()	Paramount Iron & Handrail, Inc	paramountiron@aol.com	1 775-887-1077	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	NV	\N	\N	\N	\N	\N	1 775-887-1077
1073	Paul Stehl	Paramount Iron Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602.323.9957
1074	Terry D. Kelley	Parker Manufacturing LLC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Boggstown	IN	USA	\N	\N	\N	\N	(317) 835-2254
1075	Teri Clemens	Parker Welding & Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Winterset	IA	USA	\N	\N	\N	weldpar@qwestoffice.net	(515) 462-2294
1076	Parker's Welding	Parker's Welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Milwaukee	WI	USA	\N	\N	\N	parkersteel@hotmail.com	414/461-7110
1077	Tom Glenn	Parson's Steel Builders	tom@steelaz.com	(520) 887-6207	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	\N	AZ	\N	\N	\N	\N	tom@steelaz.com	(520) 887-6207
1078	Charlie	Parsons Steel Erectors, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AZ	USA	\N	\N	\N	info@steelaz.com	(520) 887-6207
1079	Ken Kelly	Patriot Manufacturing Group	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	____________	Carlisle	OH	USA	\N	\N	\N	MSkaggs@Patriot-MG.com	937.746.2117
1080	Bill Davenport	Patriot Steel Fabrication, Inc.	bill@patriotsteelfab.com	O: 443-477-6544 x1 C: 410-200-8464	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	MD	\N	\N	\N	\N	bill@patriotsteelfab.com	O: 443-477-6544 x1 C: 410-200-8464
1082	John Sunderman	Paxton & Vierling Steel Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Carter Lake	IA	USA	\N	\N	\N	\N	(712) 347-5500
1083	Carrie Fain	PDM Metals Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Carlisle	IA	USA	\N	\N	\N	\N	(515) 243-5118
1084	Mike Reeves	Peak Steel	mikereeves@peaksteel.com	919-362-5955	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Commercial PM	Apex	\N	USA	\N	\N	\N	\N	919-362-5955 Ex110 C: 919-505-7881
1085	Brian Pederson / Pat Zender	Pederson Bros., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Bellingham	WA	USA	\N	\N	\N	pat@pedersonbros.com	(360) 734-9180
1086	Douglas Pelet / Cindy Hohl	Pelet Welding, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Coatesville	PA	USA	\N	\N	\N	\N	(610) 384-5048
1087	Arshad Afridi	Penn Steel Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bristol	PA	USA	\N	\N	\N	ali.f@pennsteel.com	(267) 878-0705
1088	Heather Krotzer / Michael Markee	PennFab, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Morrisville	PA	USA	\N	\N	\N	\N	(215) 245-1577
1089	Perfect steel	Perfect steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lumberton	MS	USA	\N	\N	\N	suganth@perfect-steel.us	954-540-0274
1090	Performance Fabricating	Performance Fabricating	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fenton	MI	USA	\N	\N	\N	\N	+1 810-373-0322
1091	Performance Solutions LLC	Performance Solutions LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Smyrna	TN	USA	\N	\N	\N	\N	(615) 459-9104
1092	Petersen Inc.	Petersen Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Od	ID	USA	\N	\N	\N	\N	801-732-2000
1093	Dean D /James	Petersen Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr. Mech designer / Engg.Manager	Ogden	UT	USA	\N	\N	\N	\N	(801) 732-2000
1094	Steve Anderson	Phoenix fabrication & supply Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chicago Heights	IL	USA	\N	\N	\N	phoenixfab@att.net	708-754-5901
1095	Phoenix Manufacturing	Phoenix Manufacturing	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Glasgow	MO	USA	\N	\N	\N	\N	660-338-5002
1096	Robert C. Coles	Phoenix Stair, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	(602) 233-2300
1097	Robert white	Phynix Fabrication?Corp	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dripping Springs	TX	USA	\N	\N	\N	victoria@phynixfabrication.com	(512) 529-0560
1098	Mike ()	Piedmont Steel	mike@piedmontsteel.com	770) 786-4928	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	GA	\N	\N	\N	\N	\N	770) 786-4928
1099	Matt Cole	Piedmont Steel Company	matt.c@piedmontsteelco.com	336-875-5133 C: 336-926-5299	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	NC	\N	\N	\N	\N	\N	336-875-5133 C: 336-926-5299
1100	Dale Beevers	Pikes Peak Steel	\N	(719) 471-8811, ext 106	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	ESTIMATING MANAGER	Colorado Springs	CO	USA	\N	\N	\N	\N	(719) 471-8811, ext 106
1101	Tom Breen	Pioneer Group	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator at Pioneer Pipe	Marietta	OH	USA	\N	\N	\N	info@pioneergroup.us	(740) 376-2400
1102	Samantha Espinoza	Pioneer Welding & Fabrication Inc	sespinoza@pioneerwelding.com	407-880-4997	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Apopka	\N	USA	\N	\N	\N	krosario@pioneerwelding.com, pwf@pioneerwelding.com	407-880-4997
1103	Kathryn	Pipe and Steel Industrial Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Denham Springs	LA	USA	\N	\N	\N	kpatterson@pipeandsteelindustrial.com	225.665.0407
1104	Jon Waliga	Pip's Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Knoxville	TN	USA	\N	\N	\N	\N	(865) 539-4766
1105	Call the reception	Pisani steel fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimation department	Naugatuck	CT	USA	\N	\N	\N	pisanisteel@aol.com	203-574-5888
1106	Scott Grebin	PKM Steel Service, Inc.	scott.grebin@pkmsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	KS	\N	\N	\N	\N	\N	\N
1107	Bob Non / Eddie T.	Pleasant Mount Welding, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Carbondale	PA	USA	\N	\N	\N	\N	(570) 881-4441
1108	Polytech metals & fab LLC	Polytech metals & fab LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tucson	AZ	USA	\N	\N	\N	\N	0000000000
1109	Porter Corporation	Porter Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Holland	MI	USA	\N	\N	\N	\N	616.888.3500
1110	Porter Steel & Welding	Porter Steel & Welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Muskegon	MI	USA	\N	\N	\N	sales@portersteelweld.com	231-733-4495
1111	Matt Postel	Postel International, Inc.	matt@postelgroup.com	281-227-2200	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Porter	\N	USA	\N	\N	\N	\N	281-227-2200
1112	Carlos Ramirez	Powers Construction & Engineering	carlos@powersce.com	(559)999-0230	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	CA	\N	\N	\N	\N	carlos@powersce.com	(559)999-0230
1113	Powers Reinforcing Fabricators	Powers Reinforcing Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602-900-5090
1114	Prather Metal Works	Prather Metal Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Franklin	TN	USA	\N	\N	\N	info@prathermetalworks.com	615.794.1031
1115	Paul Auger	Precision Fabricating Group, LLC	pauger@pfabg.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	PA	\N	\N	\N	\N	\N	\N
1116	David Rushing	Precision Iron Fabrication	drushing@precisionironfab.com	(972) 636-7581 C: 214-718-2170	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	TX	\N	\N	\N	\N	MStroud@PrecisionIronFab.Com	(972) 636-7581 C: 214-718-2170
1117	Steve Leighton / Don Allen	Precision Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Est. & PM	Pacific	WA	USA	\N	\N	\N	\N	(253) 887-5555
1118	Precision Metal Fab Inc.	Precision Metal Fab Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Milton	WI	USA	\N	\N	\N	sales@precisionmetalfabinc.com	608-580-1122
1119	Precision Metal worx	Precision Metal worx	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Carson city	NV	USA	\N	\N	\N	precisionmetalworx@hotmail.com	775-671-0038
1120	Christopher Ryan	Precision Steel, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Calvert City	KY	USA	\N	\N	\N	\N	(270) 395-5665
1121	John T. Graziano	Precision Welding & Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Houston	TX	USA	\N	\N	\N	\N	?281-252-0151
1122	Steve Kelley	Precision Welding & Fabrication  Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Westbrook	ME	USA	\N	\N	\N	\N	(207) 854-9330
1123	Premier fabrication / Obrien steel	Premier fabrication / Obrien steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Congerville	IL	USA	\N	\N	\N	\N	0000000000
1124	Scott Aberle/DALE EASTMAN	Premier Fabrication LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Congerville	IL	USA	\N	\N	\N	\N	(309) 448-4105
1125	Andy Vanaman/Calvin Easter	Premier Steel Services, LLC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	president/estimator	Tulsa	OK	USA	\N	\N	\N	\N	(918) 227-0110
1126	Brian Kramer	Premier Technology, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Blackfoot	ID	USA	\N	\N	\N	\N	(208) 785-2274
1127	Marvin White	Preston Fabrication LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Preston	ID	USA	\N	\N	\N	\N	(208) 852-0250
1128	KEN PRINCE	Prince steel fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	owner	Poughkeepsie	NY	USA	\N	\N	\N	ken@prince-steel.com	845-452-0213
1129	Dan DeBoer	Pro Manufacturing	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albert Lea	MN	USA	\N	\N	\N	\N	(507) 377-0091
1130	William Bellamy	Process Systems Inc. Construction Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Memphis	TN	USA	\N	\N	\N	BBellamy@psicontractors.com	901-794-5652
1131	Pro-fab steel structures	Pro-fab steel structures	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AZ	USA	\N	\N	\N	\N	602-469-4600
1132	Curt DeZeeuw/Jason Bastien	Professional Metal Works, LLC	curtd@pmwfab.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Freeburg	IL	USA	\N	\N	\N	estimating@pmwfab.com	(618) 539-2214
1133	Jackie Overbey	Lexicon Industrial Contractors, a Division of Lexicon, Inc.	jackieo@lexicon-inc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AR	\N	\N	\N	\N	\N	\N
1134	Jeff Canon	ProSteel Manufacturing, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sedalia	MO	USA	\N	\N	\N	\N	(660) 829-5100
1135	Ryan Nelson	Providential Fabricators, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	TN	USA	\N	\N	\N	info@provfab.com	(901) 946-0060
1136	Sam Wallace	Providential Fabricators, Inc.	swallace@provfab.net	(901) 946-0060	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	MD	\N	\N	\N	\N	\N	(901) 946-0060
1137	Christopher Long	PSP Industries	jetweld1@yahoo.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Operations Manager	\N	TX	\N	\N	\N	\N	\N	\N
1138	Dave Geiser	PSP Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Schertz	TX	USA	\N	\N	\N	\N	(408) 942-1155/(210) 651-9595
1139	Ray Havec	PSP Industries/ Monotech of Mississippi	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Iuka	MS	USA	\N	\N	\N	\N	(210) 651-9595
1140	Wade Lewis	Puma Steel	wade.lewis@pumasteel.com	(307) 637-7177	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	Cheyenne	WY	USA	\N	\N	\N	\N	307-637-7177
1141	Jack Tarr	Puritan Manufacturing	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Omaha	NE	USA	\N	\N	\N	\N	(402) 341-3753
1142	PVB fabrications Inc.	PVB fabrications Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tucson	AZ	USA	\N	\N	\N	\N	520-623-3529
1143	Scott Jundt	PVS Structures	sjundt@pvsteel.com	712-347-4251 C:402-709-2989	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr PM	\N	NE	\N	\N	\N	\N	Sales@PVSteelfab.com	712-347-4251 C:402-709-2989
1144	David Sabella Jr /TAYLOR DURAN	QMF Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Campbell	TX	USA	\N	\N	\N	tduran@qmfsteel.com	(903)455-3618/108
1145	Malik ()	QSR Steel	malik@qsrsteel.com	860) 548-0248	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	CT	\N	\N	\N	\N	scott@qsrsteel.com	860) 548-0248
1146	Qualico Steel Co Inc	Qualico Steel Co Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Webb	AL	USA	\N	\N	\N	info@qualicosteel.com	(334) 793-1290
1147	Cindy	Quality Fab Inc.	Cindy@qualityfabinc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ariton	AL	USA	\N	\N	\N	\N	334-762-3108
1148	Kenneth Lott	Quality Iron & Steel, LLC	k.lott@qualityironsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Chief Estimator	\N	TN	\N	\N	\N	\N	\N	\N
1149	Brian Eason	Quality Iron Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Memphis	TN	USA	\N	\N	\N	\N	(901) 775-9050
1150	Ken Caz	Quality Iron	kencaz@gmail.com	(702) 387-6762	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	NV	\N	\N	\N	\N	info@qualityiron.us	(702) 387-6762
1151	Quality Iron of Loisiana	Quality Iron of Loisiana	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hammond	LA	USA	\N	\N	\N	\N	+1 985-467-0845
1152	Brian Masta	Quality Ironworks	bmasta@qiworks.com	214-688-0180 x2024	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	TX	\N	\N	\N	\N	bmasta@qiworks.com	214-688-0180 x2024
1153	John Roth	Quality Machine & Welding Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Knoxville	TN	USA	\N	\N	\N	\N	(865) 524-2162
1154	Chris Loeffler	Quality Steel Fabrication	cloeffler@saqualitysteel.com	210-545-6767 ex133 C:210-379-6069	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	San Antonio	TX	\N	\N	\N	\N	\N	210-545-6767 ex133 C:210-379-6069
1155	Clementine ()	Quality Steel Inc.	office@qualitysteelinc.com	208-523-6145	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	Idaho Falls	ID	USA	\N	\N	\N	\N	208-523-6145
1156	Jimmy Williams	R & R Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Prince Frederick	MD	USA	\N	\N	\N	\N	(301) 855-9111
1157	R & R steel fabrication	R & R steel fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tucson	AZ	USA	\N	\N	\N	bobby.gil@rrsteelfab.com	520-294-5751
1158	Tyler Daniels	R&S Steel, LLC	tdaniels@randssteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	NY	\N	\N	\N	\N	etwiss@randssteel.com	\N
1159	R Parra Steel Fab	R Parra Steel Fab	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AZ	USA	\N	\N	\N	\N	623-853-1711
1160	Brian Compton	R. K. Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fredonia	KS	USA	\N	\N	\N	\N	(620) 378-2514
1161	Lanette Currie	R.E. Campbell Company, Ltd.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Houston	TX	USA	\N	\N	\N	\N	(713) 957-8721
1162	Stephen Ranahan	R.I. Welding & Fabricating Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Providence	RI	USA	\N	\N	\N	\N	(401) 331-1355
1163	Bob McCoskery	R.T.I. Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Plains	MT	USA	\N	\N	\N	\N	(406) 544-5927
1164	Nick Jarvis / Bob Allen	R.W. Fabricators Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Est. & PM	Spokane	WA	USA	\N	\N	\N	\N	(509) 482-9254
1207	RKL manufacturing	RKL manufacturing	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mount Clemens	MI	USA	\N	\N	\N	\N	586-465-5155
1165	Charles Wentworth	RAI Industrial Fabricators, LLC	charles.wentworth@rai-usa.com	706) 613-0088	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailng Manager	Athens	GA	USA	\N	\N	\N	jermy 7068508648	706) 613-0088
1166	Rainbow steel Inc	Rainbow steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Santee	CA	USA	\N	\N	\N	\N	(619) 449-2339
1167	Dominick Jagman	Ralph H.Simpson co	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Elmhurst	IL	USA	\N	\N	\N	\N	630-782-9007
1168	Jerry Hayes	RAM Enterprise, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Elko	NV	USA	\N	\N	\N	\N	(913) 424-9123
1169	Kevin	RAM Structural steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Pomona	CA	USA	\N	\N	\N	kevin@ramsteelinc.com	909-469-1520/224
1170	Adam/ Senior VP	Ramar Steel Sales, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rochester	NY	USA	\N	\N	\N	adam@ramarsteel.com	(585) 232-7777
1171	Mark Etheridge	Ranburne Steel Fabrication	\N	no phone number	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	Sevierville	TN	USA	\N	\N	\N	holly@ranburnesteel.com	no phone number
1172	Rankin fabrication Inc	Rankin fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Springfield	TN	USA	\N	\N	\N	\N	+1 615-384-1220
1173	Zach Rineer / Steven	Raser Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	PA	USA	\N	\N	\N	steven@rasersteel.com	610.320.5130
1174	Patrick McShane	Rast Iron Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	San Antonio	TX	USA	\N	\N	\N	\N	(210) 659-6704
1175	Jimmy McClelland (Tell to him that we will provide Tekla model and  MTO at quote time itself)	Ratliff Industries Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lumberton,?	TX	USA	\N	\N	\N	\N	409.755.1830
1176	Rich Raulli / Mark Raulli	Raulli & Sons, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Es.Manager	Syracuse	NY	USA	\N	\N	\N	Mark@raulliandsons.com	(315) 479-6693
1177	Ray Steel services llc	Ray Steel services llc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	623-600-8656
1178	RB's custom fabrication	RB's custom fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Garden City	ID	USA	\N	\N	\N	\N	208-340-4671
1179	Jason Suppe	RC Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Vice President& Estimator	Wilmington	DE	USA	\N	\N	\N	\N	(302) 573-8989 x 125
1180	Scott Vesper	RCC Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Southampton	NJ	USA	\N	\N	\N	\N	(609) 859-9350
1181	Steven Capuano	Rearden Steel Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lemoyne	PA	USA	\N	\N	\N	info@reardensteelfab.com	866-540-2224
1182	melissa	RED CEDAR STEEL	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	melissad@redcedarsteel.com	602) 919-0214
1183	Adam Shaner	Redd Iron Inc.	adams@reddiron.com	303-288-4494	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	CO	\N	\N	\N	\N	\N	303-288-4494
1184	Regional Steel Products	Regional Steel Products	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Semmes	AL	USA	\N	\N	\N	rsp@regionalsteelproducts.com	251.645.6776
1185	David Gardner	Reliable steel inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	GM / Estimator	Las Vegas	NV	USA	\N	\N	\N	sales@reliablesteel.net	702-642-8390
1186	Estimating department	Remington Steel and Signs LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Miami	FL	USA	\N	\N	\N	\N	(305) 836-44.97
1187	Ralph Shindler	Reno Iron Works Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Reno	NV	USA	\N	\N	\N	accounting@renoironworks.com	(775) 329-1111
1188	Eric	Republic Iron works Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	El Monte	CA	USA	\N	\N	\N	Eric@RIWSteelFab.com	626 442-3360
1189	Residential Steel Fabricators, Inc.	Residential Steel Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	South Elgin	IL	USA	\N	\N	\N	\N	(847) 695-3400
1190	Residential Steel Services	Residential Steel Services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IL	USA	\N	\N	\N	\N	585-458-4150
1191	Chris Biddy	Re-steel supply co.Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Eddystone	PA	USA	\N	\N	\N	addrozd@www.resteel.com	610.876.8216 (ext. 246)
1192	John Reynolds Sr. / Douglas Keen/Mel Wolfe	Reynolds Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Williamsport	PA	USA	\N	\N	\N	riwi@reynoldsironworks.com	(570) 279-0756/(570) 323-4663
1193	Richard Scannell	Schiavone Construction Co., LLC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Newark	NJ	USA	\N	\N	\N	\N	(973) 483-0722
1194	Reynolds Welding & Fabrication, LLC	Reynolds Welding & Fabrication, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimation department	\N	CT	USA	\N	\N	\N	\N	860.547.0609
1195	Rezger's Structural Steel	Rezger's Structural Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chicago	IL	USA	\N	\N	\N	\N	773-202-9300
1196	Richards Welding and Metal Fabrication LLC	Richards Welding and Metal Fabrication LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Wendell	NC	USA	\N	\N	\N	terry@richardsmetalfabrication.com	919-626-0134
1197	Louis Richardson	Richardson Construction Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	North Las Vegas	NV	USA	\N	\N	\N	\N	(702) 647-2200
1198	Lance Richardson	Richardson Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	Spring Valley	CA	USA	\N	\N	\N	\N	619-697-5892 x 11
1199	Myles Millard	Rigid Global Buildings: Structural Steel Division	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Houston	TX	USA	\N	\N	\N	\N	(281) 443-9065
1200	Joseph Dorbian/Grant Baver	Ritner Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Carlisle	PA	USA	\N	\N	\N	\N	(717) 249-1449
1201	engineering & design department	River City Fabrication Mechanical Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	USA	\N	\N	\N	info@rivercityfab.com	256-351-8070
1202	River city iron works	River city iron works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Peoria	IL	USA	\N	\N	\N	Info@RiverCityIron.com	(309) 231-2788
1203	River city metal groups	River city metal groups	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Coeur d'Alene	ID	USA	\N	\N	\N	\N	509-720-6166
1204	RJ materials	RJ materials	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Glendale	AZ	USA	\N	\N	\N	\N	623-842-5825
1205	RJ Welding and Fabricator	RJ Welding and Fabricator	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chicago	IL	USA	\N	\N	\N	\N	773-447-0358
1208	RLD Fabricator	RLD Fabricator	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Gilbert	AZ	USA	\N	\N	\N	\N	480-633-5773
1209	Robert	R-N-R Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Apache Junction	AZ	USA	\N	\N	\N	\N	480-987-1927
1210	Adam Hughes	Roadway Construction Products	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Clarkson	KY	USA	\N	\N	\N	\N	(270) 242-2571
1211	Roberts welding LLC	Roberts welding LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mechanicsville	MD	USA	\N	\N	\N	\N	\N
1212	Kelly Gilligan	Rochester Rigging & Erectors, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bloomfield	NY	USA	\N	\N	\N	\N	(585) 657-7665
1213	Justin / Richard Penepent / Mike Pecora	Rochester Structural	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MD / PM / Detailer	Rochester	NY	USA	\N	\N	\N	MikeP@RochesterStructural.com	(585) 436-1250/105
1214	Rockett Inc	Rockett Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Flowood	MS	USA	\N	\N	\N	\N	\N
1215	Ryan Miller /John Clayton	Rocky mountain fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Es Manager/Engg Manager	Salt Lake City	UT	USA	\N	\N	\N	\N	801-596-2400
1216	Tyler Lorimor	Rocky Mountain Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailer	Olathe	CO	USA	\N	\N	\N	rms@kaycee.net	(970) 323-6323 Ext. 102
1217	Edward Rodgers	Rodgers Metal Craft, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fortson	GA	USA	\N	\N	\N	jeffd@rodgersmc.com	(706) 327-4536
1218	Rollie Horton	Rohn Products, L.L.C.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Peoria	IL	USA	\N	\N	\N	\N	(309) 566-3049/+1 (800) 727-7646
1219	Jose Romero	Romero Steel Company	joejr@romerosteel.com	(708)216-0001	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	IL	\N	\N	\N	\N	joejr@romerosteel.com	(708)216-0001
1220	Tom	Ron's welding & fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Engineering/Detailing	Denver	CO	USA	\N	\N	\N	\N	303) 534-8176
1221	Tim Rowland	Rose Fabricating & Industrial Solutions	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Covington	TN	USA	\N	\N	\N	\N	(901) 476-2202
1222	Ross Structural Steel	Ross Structural Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Detroit	MI	USA	\N	\N	\N	bids@rosssteel.com	313.893.7877
1223	Mark ()	ROSSIN STEEL, INC	mark@rossinsteel.com	619-656-9200	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	CA	\N	\N	\N	\N	jonathan@rossinsteel.com	619-656-9200
1224	Peter T. Rozell	Rozell Industries, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Queensbury	NY	USA	\N	\N	\N	\N	(518) 793-2634
1225	Robby A. Fisher, Sr.	RPS Machinery Sales, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Jersey Shore	PA	USA	\N	\N	\N	\N	(570) 398-7456
1226	Jonathan Eyton/ Ron Allen	RULE STEEL	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Caldwell	ID	USA	\N	\N	\N	Jon.eyton@rulesteel.com / ron.allen@rulesteel.com	Toll Free: 800.769.5636,   Office: 208.585.3031
1227	Bobby Swicegood	Russellville Steel Co Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AZ	USA	\N	\N	\N	Sales@rsvlsteel.com	479-968-2211
1228	Bobby Swicegood	Russellville Steel Company, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Chief Draftsman	Russellville	AR	USA	\N	\N	\N	Sales@rsvlsteel.com	(479) 968-2211
1229	Edward Johnson / Kevin Maze	Ryan Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/Estimator	Raynham	MA	USA	\N	\N	\N	\N	(508) 822-8001 ext 229
1230	Ryan Steel	Ryan Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Knoxville	TN	USA	\N	\N	\N	ARyan@RyanSteel.com	(865) 558-8551
1231	S & E fabrication	S & E fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Arcadia	LA	USA	\N	\N	\N	1) info@sefabrications.com                  2) quote@sefabrications.com	318-777-8221
1232	S & H erectors	S & H erectors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hixson	TN	USA	\N	\N	\N	\N	423-668-0519
1233	Roy Hunt	S & H Steel Co	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AZ	USA	\N	\N	\N	\N	480.926.6062
1234	angel guzzman	S & S Steel fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hurricane	UT	USA	\N	\N	\N	angel@sssteelfab.com	435-635-9801
1235	Thomas Stucke / Chris Graves	S & S Welding Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/Manager est.& Pm	Kent	WA	USA	\N	\N	\N	\N	(253) 872-3833
1236	Ahmet Halac	S. A. Halac Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sterling	VA	USA	\N	\N	\N	\N	(703) 406-4766
1237	Kenneth Worrell / Mike York / Lori Chasse	S.L. Chasse Welding & Fabricating, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	//vp	Hudson	NH	USA	\N	\N	\N	\N	(603) 886-3436
1238	Keith Stroup	S.T. Metal Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Marietta	GA	USA	\N	\N	\N	info@stmetalworks.com	(770) 499-7386
1239	Sabre Industries	Sabre Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bossier City	LA	USA	\N	\N	\N	\N	866-254-3707
1240	Sabre Industries	Sabre Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sioux City	IA	USA	\N	\N	\N	\N	0000000000
1241	Bob Schultz	Sabre-FWT	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Alvarado	TX	USA	\N	\N	\N	\N	(817) 852-1724
1242	Steve Padgette / Elias Ponce	SAC Incorporated	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP / BIM manager	West Jordan	UT	USA	\N	\N	\N	\N	(385) 275-2500
1243	Mark A. Laird	Saguaro Steel Industries, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	(602) 272-8800
1244	John Grossi / Gene Grossi	Samuel Grossi & Sons, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bensalem	PA	USA	\N	\N	\N	jgrossi@ererectorsinc.com	(215) 638-4470
1245	Tony Ulibarri	San Joaquin Steel	tony@sjs-steel.com	(209) 948-0541	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	CA	\N	\N	\N	\N	\N	(209) 948-0541
1246	San Mario Iron	San Mario Iron	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Warren	MI	USA	\N	\N	\N	\N	313-526-9255
1247	Oscar Salazar	Sanco Steel DBA Southern Steel Fab	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Donna	TX	USA	\N	\N	\N	\N	(956) 464-7766
1248	Andy Starling	Sanford Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Goldston	NC	USA	\N	\N	\N	\N	(919) 898-4799
1249	Sanilac steel Inc	Sanilac steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Marlette	MI	USA	\N	\N	\N	\N	(989) 635-2992
1250	Jeff Richards / Alex Richards	Sanpete Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/ VP	Moroni	UT	USA	\N	\N	\N	\N	(800) 261-1026
1251	Maria? Torriani	Santini Bros. Iron works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Medford	MA	USA	\N	\N	\N	\N	(781) 396-1450
1252	Sasco supply	Sasco supply	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Nampa	ID	USA	\N	\N	\N	\N	208-466-0025
1253	Sauer Group, Inc.	Sauer Group, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oak Hill	FL	USA	\N	\N	\N	\N	(386) 345-4423
1254	Harry Rodgers	SC Steel	\N	See Contact Info	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Taylors	SC	USA	\N	\N	\N	\N	See Contact Info
1255	SCF speciality fabricators	SCF speciality fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Calera	AL	USA	\N	\N	\N	\N	(205)668-1110
1256	Schaffer Industries	Schaffer Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	702-947-4860
1257	Schelco steel	Schelco steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	South Holland	IL	USA	\N	\N	\N	\N	+1 708-333-5380
1258	Scherer steel structures	Scherer steel structures	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	De Pere	WI	USA	\N	\N	\N	foellermjohn@gmail.com	920-362-3325
1259	Vince Gambone	Schlosser Steel, Inc.	vgambone@schlossersteel.com	215-723-9883	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sales Manager	Hatfield	PA	USA	\N	\N	\N	detailing@schlossersteel.com	215-723-9883
1260	EZ Ruvalcaba	Schroeder Iron	ez@schroederiron.com	(909)770-8724, (818)429-3899	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	CA	\N	\N	\N	\N	Estimating@schroederiron.com	(909)770-8724, (818)429-3899
1261	Mike Wolff	Schuff Steel Company - Midwest Division	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ottawa	KS	USA	\N	\N	\N	\N	(913) 201-4874
1262	Schuff Steel Company(or) Schuff International	Schuff Steel Company(or) Schuff International	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	southwestsales@schuff.com	(602) 252-7787
1263	Schuff Steel Southwest	Schuff Steel Southwest	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	702-697-1150
1264	Johnny Bledsoe	Schultz Industries, Inc. dba Sturdisteel Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hewitt	TX	USA	\N	\N	\N	\N	(254) 666-5155
1265	Robert Scott	Scott Steel Services, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Crown Point	IN	USA	\N	\N	\N	scott@scottsteelservices.com	(219) 226-9855
1266	Fred Scriba	Scriba Welding, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Baltimore	MD	USA	\N	\N	\N	\N	(410) 234-2764
1267	Carlos Rey	Sefton Steel	crey@seftonsteel.com	281-449-8677	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	\N	TX	\N	\N	\N	\N	\N	281-449-8677
1268	Kampta Persaud	Seiko Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Glendale	NY	USA	\N	\N	\N	\N	(718) 418-4477
1269	Mark Selvaggio/Luke Lowe	Selvaggio Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Springfield	IL	USA	\N	\N	\N	info@selvaggiosteel.com	(217) 528-4078
1270	Wendy Burrington	Selway Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Stevensville	MT	USA	\N	\N	\N	\N	(406) 777-5471
1271	CLAUDIA NEEDHAM/Stan Zasuwa	Service Iron works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PE/ Ch.Estimator	South Lyon	MI	USA	\N	\N	\N	\N	248-446-9750
1272	Don Hollman	Service Steel Framing, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Butler	IN	USA	\N	\N	\N	\N	(260) 868-5853
1273	Brandy ()	Service Steel, Inc	brandy@servicesteelinc.com	256-883-1190	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Office Manager	\N	AL	\N	\N	\N	\N	admin@servicesteelinc.com	256-883-1190
1274	Kristina Everingham	SES Ironworks, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Goodlettesville	TN	USA	\N	\N	\N	sales@sesginc.com	(615) 278-9986
1275	Robert Enos II	Shawmut Metal	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Swansea	MA	USA	\N	\N	\N	drafting@shawmutmetal.com	508.379.0803
1276	Craig Pardue	Shawnee Steel & Welding, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Merriam	KS	USA	\N	\N	\N	\N	(913) 432-8046
1277	Shelco Steel Works	Shelco Steel Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	South Holland	IL	USA	\N	\N	\N	\N	708-333-5380
1278	Eddie Smith/Weston Tate	Smith Ironworks, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lyerly	GA	USA	\N	\N	\N	wtate@smith-ironworks.com	(706) 895-3311/254
1279	Norbert Kropiewnicki	Shepard Steel Co	nkropiewnicki@shepardsteel.com	860-525-4446	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr PM	\N	CT	\N	\N	\N	\N	whendery@shepardsteel.com	860-525-4446
1280	Kevin Runion	Shickel Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bridgewater	VA	USA	\N	\N	\N	\N	(540) 828-2536
1281	Brad Rowlands	Shure-Line Construction	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	V.P. Structural Operations	Kenton	DE	USA	\N	\N	\N	\N	(302) 653-4610
1282	Sick Fab LLC	Sick Fab LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	0
1283	Jack McDaniel	Sigma Metals Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	project manager	\N	CO	USA	\N	\N	\N	\N	719-574-2280
1284	Scott MacKenzie	Simko Industrial Fabricators Inc	smackenzie@simkofab.com	219-933-9100	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	IN	\N	\N	\N	\N	\N	219-933-9100
1285	Simon Fabrication	Simon Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Christopher	IL	USA	\N	\N	\N	\N	618-724-7331
1286	Jeremy	Sioux City Foundry Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sioux City	IA	USA	\N	\N	\N	jlange@siouxcityfoundry.com	(712) 226-1146
1287	Cam Baker	Sippel Steel Fab	cbaker@sippelsteelfab.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Engineer	\N	PA	\N	\N	\N	\N	tbell@sippelsteelfab.com	\N
1288	Tommy Alexander	SK Commercial Construction, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Killeen	TX	USA	\N	\N	\N	\N	(254) 630-3048
1289	Daniel Allen	Skyce Steel.Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602.237.1085
1290	David Davis	Skyline Steel Inc.	david@skylinesteel.net	954-968-1912	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	FL	USA	\N	\N	\N	info@skylinesteel.net	954-968-1912
1291	Andrea Gomez Gastelum	Skyline Steel Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Engineer, Detailing & Estimating	Gilbert	AZ	USA	\N	\N	\N	\N	480 926 0122
1292	Earl	Skylite Steel Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Gilbert	AZ	USA	\N	\N	\N	\N	480-926-0122
1293	Ronnie Slay	Slay Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Meridian	MS	USA	\N	\N	\N	\N	(601) 483-3911, (800) 423-9383
1294	Sloan Metal Solutions	Sloan Metal Solutions	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Boise	ID	USA	\N	\N	\N	\N	1-888-382-8379
1295	Brett Stapel	SME Steel	brett.stapel@smesteel.com	(801) 280-0711	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	UT	\N	\N	\N	\N	\N	(801) 280-0711
1296	Justin Pitts	SME Steel Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pocatello	ID	USA	\N	\N	\N	\N	208-237-1546
1297	David Schrunk	SMI Hydraulics, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Porter	MN	USA	\N	\N	\N	\N	(507) 246-4551
1298	SMI steel llc	SMI steel llc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Detroit	MI	USA	\N	\N	\N	info@smisteel.net	313-800-8007
1299	Josh Poynter	Snake Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Nashville	TN	USA	\N	\N	\N	\N	615-256-6766
1300	SND steel fabrication	SND steel fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Shelby Township	MI	USA	\N	\N	\N	\N	586-997-1500
1301	Mark A. Snyder PE	Snyder Engineering, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Columbia	MO	USA	\N	\N	\N	\N	573-449-9177 (or) (573) 808-5310
1302	Steve Somerville	Somerville Industries	steves@somervilleindustries.com	304) 489-2672	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	\N	OH	\N	\N	\N	\N	\N	304) 489-2672
1303	Norma	SOS Steel Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	OfficeManager	Santa Clara	CA	USA	\N	\N	\N	normav@sossteelco.com	(408) 727-6363
1304	Louis Laurent / Paul Soucy	Soucy Industries Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/ ESTIMATOR	Pelham	NH	USA	\N	\N	\N	\N	(603) 883-4500
1305	South Anna stairs & rail company Inc	South Anna stairs & rail company Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ashland	VA	USA	\N	\N	\N	\N	804-798-2628
1306	Kaleigh Maness	South Central Steel Inc	kaleigh@scsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Document Control	Harpersville	AL	USA	\N	\N	\N	info@scssteel.com	Andy: 205-672-2904
1307	South East Fabricators, Inc.	South East Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Northport	AL	USA	\N	\N	\N	info@sefab.com	205-556-3227
1308	John Chesser	Southeast Texas Industries, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Vidor	TX	USA	\N	\N	\N	\N	(409) 994-3570
1309	Bruce Lee	Southeastern Construction & Maintenance, Inc.	brucel@secm.co	863-428-1511 x274	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	Mulberry	FL	USA	\N	\N	\N	jamesg@secm.co	863-428-1511 x274
1310	Southeastern Plateworks LLC	Southeastern Plateworks LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	USA	\N	\N	\N	\N	205.271.0300
1311	Stephanie Cato	Southeastern Steel Services	administration@s3steelservices.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	GM	\N	AL	\N	\N	\N	\N	craigc@sesteel.net	\N
1312	JoAnn Pettus	Southern Bleacher Co. Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Graham	TX	USA	\N	\N	\N	\N	(800) 433-0912
1313	Southern Metal Fabricators Inc	Southern Metal Fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	USA	\N	\N	\N	\N	(800) 989.1330 / 256-891-4343
1314	Jeff Clark	Southern Metal Products	jeff@southernmetals.net	502.966.3179	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	KY	\N	\N	\N	\N	\N	502.966.3179
1315	Justin P. Airhart	Southern Services and Equipment, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	St. Bernard	LA	USA	\N	\N	\N	info@sse-la.com	(504) 682-8800
1316	Southern Steel Detailers	Southern Steel Detailers	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lexington	SC	USA	\N	\N	\N	\N	2
1317	Joe Ferguson	Southern Steel Fabricators, Inc.	jferguson@southernsteelfab.com	318-345-2800 ext 205	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	\N	318-345-2800 ext 205
1318	Southern steel fabricators	Southern steel fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Donna	TX	USA	\N	\N	\N	\N	956-464-7766
1319	Mathew Richman	Southern Structural Steel - VIRGINIA	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Smithfield	VA	USA	\N	\N	\N	info@southernstructuralsteel.com	(757) 623-0862
1320	Estimating department	Southern structural steel of Florida Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	St. Petersburg	FL	USA	\N	\N	\N	info@southernstpete.com	727-327-7123
1321	Southernspear ironworks	Southernspear ironworks	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chattanooga	TN	USA	\N	\N	\N	Sean@thesouthernspear.com	423.498.2862
1322	Joey Lombardo	Southland Steel Fabricators	joey.lombardo@southlandsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	CEO	\N	LA	\N	\N	\N	\N	\N	\N
1323	Shawn Faught	Southwest Ironwork, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albuquerque	NM	USA	\N	\N	\N	\N	(505) 296-9600
1324	John Shipman	Southwest Fabrication LLC	johnshipman@sw-fab.com	623-587-4648 ext. 107	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AZ	\N	\N	\N	\N	\N	623-587-4648 ext. 107
1325	Chris Klink	Southwest Steel LLC, Arizona Plant	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	El Mirage	AZ	USA	\N	\N	\N	\N	(702) 320-4900
1326	Matt Buckner	Southwest Steel LLC	matt.buckner@sws-steel.com	(702) 320-4900	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Lead Estimator	\N	NV	\N	\N	\N	\N	contact@sws-steel.com	(702) 320-4900
1327	Timothy Clark	Space Coast General Contractor, Inc.	sales@spacecoaststeel.com	321-632-9440	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cocoa	FL	USA	\N	\N	\N	sales@spacecoaststeel.com	321-632-9440
1328	Spallinger Millwright Services	Spallinger Millwright Services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lima	OH	USA	\N	\N	\N	\N	+1 419-222-8434
1329	Quinton Rosa	Spartan Steel	quint@spartan-steel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	ID	\N	\N	\N	\N	\N	\N
1330	Juan ()	Spartan Steel Fabrication, LLC	juan@spartansteelfabrication.com	832-406-9226	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	info@spartan-steel.com	832-406-9226
1331	Brian Dwyer	Specialty Fab, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	North Lima	OH	USA	\N	\N	\N	\N	(330) 549-1004
1332	Specialty Fabricators-Erectors	Specialty Fabricators-Erectors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hammond	LA	USA	\N	\N	\N	\N	\N
1333	Specks fabrication and cutting	Specks fabrication and cutting	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Thibodaux	LA	USA	\N	\N	\N	\N	985-446-1008
1334	Gail Kirk	Speedway Steel Fabrication Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Crystal City	MO	USA	\N	\N	\N	\N	(636) 931-6500
1335	Neal Gagan	Spirit Fab Inc.	ngagan@spiritfabs.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Wrightstown	WI	USA	\N	\N	\N	\N	(920) 532-0783
1336	Troy Miller	Spirit Fabs, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Wrightstown	WI	USA	\N	\N	\N	\N	(920) 660-5040
1337	Spirit Steel Co.	Spirit Steel Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Jackson	MI	USA	\N	\N	\N	\N	517-841-1744
1338	Springfiled steel LLC	Springfiled steel LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Springfield	TN	USA	\N	\N	\N	springfieldsteel2902@gmail.com	615-927-5403
1339	Mark Hepko	ST Fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr.PM	Orting	WA	USA	\N	\N	\N	\N	253-735-2000
1340	Jason Ashbrook	St. George Steel LLC	jashbrook@stgeorgesteel.com	(435) 673-4856	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Supervisor	\N	UT	\N	\N	\N	\N	\N	(435) 673-4856
1341	Stainless steel fabrication	Stainless steel fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	702-222-0100
1342	STALCO Construction	STALCO Construction	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Islandia	NY	USA	\N	\N	\N	\N	631-254-6767
1343	Jim Rangel	Staley Steel, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Plant Manager	Pilot Point	TX	USA	\N	\N	\N	\N	9406866000
1344	William Miller	Standard Iron	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	La Vista	NE	USA	\N	\N	\N	\N	(402) 339-9400
1345	Brent Curtis	Standard Iron & Wire Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Alexandria	MN	USA	\N	\N	\N	\N	(763) 295-8711
1346	Paul Dennebaum / Jack Hubshman	Standard Iron Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Scranton	PA	USA	\N	\N	\N	\N	800-800-3072/1600
1347	Kevin Garric	Standard steel fabricating co Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Seattle	WA	USA	\N	\N	\N	\N	206-767-3314
1348	Starr Steel	Starr Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Arizona City	AZ	USA	\N	\N	\N	\N	520-251-6015
1349	charlie	State welding and fabricating inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	president	Wallingford	CT	USA	\N	\N	\N	\N	203-294-4071
1350	Paul Adam Finelli	Stateline Fabricators LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Harmony	NJ	USA	\N	\N	\N	\N	(908) 387-8800
1351	Steel & Supply Co., Inc	Steel & Supply Co., Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tuscaloosa	AL	USA	\N	\N	\N	\N	205-553-7078
1352	Ken Mebane	Steel America	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Norfolk	VA	USA	\N	\N	\N	\N	(757) 545-5311
1353	Ethan Blum	Steel & Pipe Corporation	eblum@steelandpipecorp.com	(919) 776-0751 C: 919-500-1761	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	NC	\N	\N	\N	\N	bkelly@steelandpipecorp.com	(919) 776-0751 C: 919-500-1761
1354	Steel Biz Inc.	Steel Biz Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Madison	TN	USA	\N	\N	\N	\N	615-868-4780
1355	Sean Moore	Steel Builders Inc	sean@steelbuildersinc.com	(310)225-5793	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	\N	CA	\N	\N	\N	\N	\N	(310)225-5793
1356	Steel City Metals	Steel City Metals	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Westover	AL	USA	\N	\N	\N	\N	205-791-5282
1357	Justin Beckwith	Steel Construction Services	\N	817-429-6980	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating(CheckWebsite)	\N	TX	\N	\N	\N	\N	\N	817-429-6980
1358	Steel Creations & Fabrication, Inc.	Steel Creations & Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Glendale	AZ	USA	\N	\N	\N	info@steelcreationsfab.com	623-223-1163
1359	Steve	Steel Edge Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	randres@steeledgeinc.com,          tstumbaugh@steeledgeinc.com	702-386-0023
1360	David Clifton	Steel Erectors, Inc	david@steelerectorsinc.com	912-544-1380 Ext. 104	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	GA	\N	\N	\N	\N	shelly@steelerectorsinc.com / Richard@SteelErectorsInc.com	912-544-1380 Ext. 104
1361	Dan Stoltzfus	Steel Fab Enterprises	dstoltzfus@steelfabenterprises.com	717-464-0330 x236	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	PA	\N	\N	\N	\N	CRoberts@steelfabenterprises.com	717-464-0330 DanC: 717.682.2088
1362	Jeff Campbell	Steel Fab Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tuscaloosa	AL	USA	\N	\N	\N	jcampbell@steelfabworks.com	(205)-535-0447
1363	Brian Arnold	Steel Fab, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Jackson	TN	USA	\N	\N	\N	\N	(731) 424-2600
1364	Steel Fabrication & Weld Inc	Steel Fabrication & Weld Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cicero	IL	USA	\N	\N	\N	\N	Telephone:773-343-0731, Office: 773-965-1630
1365	John Hunter	Steel Fabricators of Monroe, L.L.C.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Monroe	LA	USA	\N	\N	\N	\N	(318) 387-9426
1366	Vibin Koshy	Steel Fabricators, LLC.	vkoshy@sfab.com	954-772-0440	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	Fort Lauderdale	FL	USA	\N	\N	\N	info@sfab.com	954-772-0440
1367	Steel Integrity	Steel Integrity	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Farmington Hills	MI	USA	\N	\N	\N	\N	248-733-3833
1368	Steel lines	Steel lines	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tucson	AZ	USA	\N	\N	\N	\N	520-888-0233
1369	Steel plate fabricators	Steel plate fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Knoxville	TN	USA	\N	\N	\N	\N	\N
1370	Jim Souza	Steel Service Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Flowood	MS	USA	\N	\N	\N	info@steelservice.com	(601) 939-9222
1371	Chris Sparks	Steel Services, Inc	cs@steelservices.com	(317) 783-5255	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	IN	\N	\N	\N	\N	\N	(317) 783-5255
1372	Juan Gonzalez	Steel Specialties, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	El Paso	TX	USA	\N	\N	\N	\N	(915) 590-2337
1373	Janette Morgan	Steel Specialty, Inc.	jmorgan@steel-specialty.com	704-825-4745	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Assistant Detailing Manager	Belmont	NC	USA	\N	\N	\N	\N	704-825-4745
1374	Randy Bulloch	Steel Structures	rbulloch@steelstructuresnv.com	(702) 736-7033	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	NV	\N	\N	\N	\N	\N	(702) 736-7033 Randy C: 702-832-8054
1375	Randy Bulloch	Steel Structures Inc.	rbulloch@steelstructuresnv.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	General Manager	Las Vegas	NV	USA	\N	\N	\N	estimating@steelstructuresnv.com	702-736-7033
1376	John Marschner / Tom Morgan	Steel Structures, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/ VP	Washington	UT	USA	\N	\N	\N	\N	(702) 664-4297
1377	Sam(female)	Steel suppliers erectors Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	DETAILING DEPARTMENT	Wilmington	DE	USA	\N	\N	\N	sam@steelsupplierserectors.com	302-654-5243
1378	Jason Bosscher / Jeff Dills	Steel Supply & Engineering	\N	(616) 247-7232	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/ Est.Manager	Grand Rapids	MI	USA	\N	\N	\N	jdills@steelsupplyengineering.com	(616) 452-3281/ (616) 247-7232
1379	Steel Supply Center LLC	Steel Supply Center LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	South Haven	MI	USA	\N	\N	\N	\N	\N
1380	Randy Keifer	Stone Steel, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cookeville	TN	USA	\N	\N	\N	\N	(931) 526-1063
1381	Victor Kourganov	Steel systems engineering Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Its asteel detailing concern having office in philipines for detailing.Try once	Sherman Oaks	CA	USA	\N	\N	\N	\N	+1 818.817.4500
1382	TJ Brown	Steel Tech  fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rochester	NY	USA	\N	\N	\N	tj@steeltechfab.com	?585-323-2660
1383	William Pruden	Steel Technology, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rocky Mount	NC	USA	\N	\N	\N	\N	(252) 937-7122
1384	Mike Hoehner	Steel West, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pocatello	ID	USA	\N	\N	\N	\N	(208) 237-1580
1385	Steel wind industries, Inc.	Steel wind industries, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oak Creek	WI	USA	\N	\N	\N	\N	414-571-6000
1386	Steel works	Steel works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Henderson	NV	USA	\N	\N	\N	\N	702-568-7678
1387	Ronnie Robinson	Steel Works, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Vice President	Jackson	MS	USA	\N	\N	\N	ronnie@steelworksllc.com	601-398-4750
1388	Tillis Ross	Steel, LLC	tross@steelincga.com	404-292-7373	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	Scottdale	GA	USA	\N	\N	\N	\N	404-292-7373
1389	Steelco.Inc	Steelco.Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Porter	TX	USA	\N	\N	\N	\N	281-354-9000
1390	Amber Hodge	Steelcon, LLC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	New Waterford	OH	USA	\N	\N	\N	\N	(330) 457-2419
1391	Engineering/design department	Steelcon.Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AZ	USA	\N	\N	\N	jake@steelconinc.com	520-631-7152
1392	Steele Solutions	Steele Solutions	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Franklin	WI	USA	\N	\N	\N	\N	888-542-5099
1393	Bill Griffith / Dan DeMarco	STEELFAB	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/ Sr.Est	Anchorage	AK	USA	\N	\N	\N	bgriffith@STEELFABak.com	907-276-4303 or 1-800-845-4303
1394	Scott Edgar	SteelFab	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Columbia	SC	USA	\N	\N	\N	sedgar@steelfab-inc.com	803-978-2258
1395	Reggie ()	Steelfab Inc.	reggie@steelfab-inc.net	815-935-6540	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IL	\N	\N	\N	\N	\N	815-935-6540
1396	Ricky Dixon / Josh Kelly	SteelFab of Dublin	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dublin	GA	USA	\N	\N	\N	\N	(478) 275-9777
1397	William McCall	SteelFab of SC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Florence	SC	USA	\N	\N	\N	\N	(843) 664-1811
1398	ROB JOHEL	SteelFab of Virginia, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Emporia	VA	USA	\N	\N	\N	\N	434-348-9021 (emporia) (or) 919-828-9545
1399	Scott Edgar	SteelFab, Inc.	sedgar@steelfab-inc.com	704-526-2550	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	Charlotte	NC	USA	\N	\N	\N	wpulyer@steelfab-inc.com	704-970-1032
1400	Matthew J. McLaren	STEELFAB, Incorporated	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kankakee	IL	USA	\N	\N	\N	reggie@steelfab-inc.net	(815) 935-6540
1401	Karl J Klassen,	Stoneridge drafting	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Sumas	WA	USA	\N	\N	\N	\N	604.820.0004
1402	Brad Jacoway	Steel-Plus, LLC	bjacoway@steel-plusllc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ider	AL	USA	\N	\N	\N	sales@steel-plusllc.com	2566577320
1403	Steelsmyth Inc.	Steelsmyth Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Greendale	WI	USA	\N	\N	\N	steelsmyth.inc@gmail.com	414-858-9333
1404	Dan Jaques	Steel-Tech Industrial Corp.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Senior Detailer & Project Manager	Corona	CA	USA	\N	\N	\N	\N	(951) 270-0144
1405	Andrew Romanov	Steelwind Industries, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oak Creek	WI	USA	\N	\N	\N	\N	414-571-6000
1406	Steelworks Inc.	Steelworks Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Trenton	MI	USA	\N	\N	\N	\N	734-692-3020
1407	Hendricks	SteelWorks of the Carolinas, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Piedmont	SC	USA	\N	\N	\N	\N	(864) 295-1760
1408	Joe Ondyak	Stehl Corporation	joe@stehlcorp.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602-323-9957
1409	Stein Bros. Steel	Stein Bros. Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rice Lake         &  Chippewa Falls	WI	USA	\N	\N	\N	RICE LAKE  =   1) terry.busch@steinbros.com            2) makayla.scheil@steinbros.com                      CHIPPEWA FALLS = jon.schroetke@thesighgroup.com	1) 715.234.2108 - Rice Lake (WI)    2) 715.577.6616 - Chippewa Falls (WI)
1410	Bert J. Stein	Stein Steel & Supply Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Atlanta	GA	USA	\N	\N	\N	\N	(404) 523-2711
1411	Stellar Steel Services	Stellar Steel Services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Peoria	AZ	USA	\N	\N	\N	\N	602-723-6391
1412	Sterling Steel Fabrication	Sterling Steel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	1 602-272-4790
1413	Steve Marshal Fabricators	Steve Marshal Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lake Havasu City	AZ	USA	\N	\N	\N	\N	928-855-7544
1414	Dawn Secord	Stevens Steel West, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kalispell	MT	USA	\N	\N	\N	\N	(406) 755-3900
1415	Stevenson Fabrication Services	Stevenson Fabrication Services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Manteno	IL	USA	\N	\N	\N	info@stevensonfabrication.com	1 (815) 468-7941
1416	Roy Morton	Steward Steel, Inc. (Structural Division)	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sikeston	MO	USA	\N	\N	\N	info@stewardsteel.com.	(573) 471-2121
1417	Curt Zeigler	Stewart - Amos steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Harrisburg	PA	USA	\N	\N	\N	czeigler@stewartamossteel.com	+1 717-564-3931
1418	Jack Tepe	Stinger Bridge & Iron	jmurphy@stingerbridgeandiron.com	SeeNASCC2024	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr Estimator	\N	AZ	\N	\N	\N	\N	\N	\N
1419	Brian Carmar	Stone Bridge Iron & Steel, Inc.	brian@stonebridgeiron.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Gansevoort	NY	USA	\N	\N	\N	bj@stonebridgeiron.com	(518) 695-3752
1420	Steve Mahan	Stone City Ironworks	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bedford	IN	USA	\N	\N	\N	\N	(812) 279-3023
1421	Stone Steel LLC	Stone Steel LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cookeville	TN	USA	\N	\N	\N	\N	931-526-1063
1422	Greg Strait / Chris Reichelderfer	Strait Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Greencastle	PA	USA	\N	\N	\N	\N	(717) 597-3125
1423	Dawn ()	Strocchia Iron Works	strocchia.ny@gmail.com	516) 625-8800	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Office Manager	\N	NY	\N	\N	\N	\N	\N	516) 625-8800
1424	Jimmy Ring	Strong Structural Steel, LTD	jimmy@strongsteel.com	956-992-9725	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Pharr	TX	USA	\N	\N	\N	\N	956-992-9725
1425	Bill	Struc steel	\N	6199714897	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailer	Spring Valley	CA	USA	\N	\N	\N	bill@strucsteel.com	(619) 466-4086
1426	Kenneth Moore	STRUCTURAL AND STEEL PRODUCTS, INC.	kmoore@racerock.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Director of Operations	\N	TX	\N	\N	\N	\N	\N	\N
1427	Casey	Structural Ink LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	MESA	AZ	USA	\N	\N	\N	\N	480-326-5684
1428	Structural Metals of KC Inc	Structural Metals of KC Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kansas City	MO	USA	\N	\N	\N	\N	\N
1429	Dana ()	Structural Steel & Plate Fabrication	dana@ssandpf.com	(801) 292-8484	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	UT	\N	\N	\N	\N	\N	(801) 292-8484
1430	Structural Steel Design of Minnesota	Structural Steel Design of Minnesota	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Saint Paul	MN	USA	\N	\N	\N	info@ssdmn.com	952-423-8899
1431	Valfre Vasquez	Structural Steel of Carolina	\N	336-725-0521	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Winston	NC	USA	\N	\N	\N	\N	336-725-0521
1432	Maggie Chacon	Structural Steel Services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	El Paso	TX	USA	\N	\N	\N	\N	(915) 857-3100
1433	Tommy Dulaney	Structural Steel Services, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Meridian	MS	USA	\N	\N	\N	info@StructuralSteelService.com	(601) 483-5381
1434	Structural Steel Welding	Structural Steel Welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lakeland	LA	USA	\N	\N	\N	\N	225-424-8974
1435	Robert Schubert	STS Steel, Inc.	roberts@stssteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM / Connection Designer	\N	NY	\N	\N	\N	\N	geoff@stssteel.com	\N
1436	Stuctural Strategies Inc.	Stuctural Strategies Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Aurora	IL	USA	\N	\N	\N	\N	(630) 627-4830
1437	Reuben Netherland / Rodney Crowley	Stupp Bridge Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/VP engg..	Bowling Green	KY	USA	\N	\N	\N	\N	(270) 393-5004
1438	Greg Sable	Sturdi Iron	gsable@sturdiiron.com	(708)679-1174	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	IL	\N	\N	\N	\N	estimating@sturdiiron.com	(708)679-1174
1439	Peter Saxon / Chris Osburn	Summit Metal Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/ PM	Plaistow	NH	USA	\N	\N	\N	\N	(603) 328-2209 / 603.328.2222
1440	Matthew Rodriguez	Summit Steel Fabricators	mathew.rodriguez@summitsteelus.com	CheckEmails	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr PM	\N	TX	\N	\N	\N	\N	\N	CheckEmails
1441	Sham Thompson	SunSteel LLC	sthompson@sunsteelllc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating Manager	Vancouver	WA	USA	\N	\N	\N	kgagnon@sunsteelllc.com	360) 329-7048, Gary: 509-837-7008
1442	Suncor Inc / National Metals LLC	Suncor Inc / National Metals LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	DeForest	WI	USA	\N	\N	\N	scott@suncor.net	(608) 846-9300
1443	Sungate Unlimited, Inc	Sungate Unlimited, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Keymar	MD	USA	\N	\N	\N	\N	\N
1444	Sunset Erectors Inc.	Sunset Erectors Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	1 702-740-8541
1445	Socrates Supan	Supan detailing services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Brea	CA	USA	\N	\N	\N	\N	714-278-0151
1446	Jon Mamalakis	Superior Fabrication	jon.mamalakis@superiorfabrication.io	3373869571	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Lafayette	LA	USA	\N	\N	\N	\N	337-386-9571
1447	Kathy Landmesser	Superior Iron Works, Inc.	klandmesser@superiorironworks.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sterling	VA	USA	\N	\N	\N	\N	(703) 471-5500
1448	Jeffrey Easley, Jr.	Superior steel  Inc	jeffreyeasley@superiorsteelinc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager and Estimator	Denham Springs	LA	USA	\N	\N	\N	\N	225-275-7040
1449	Zachary Orr / Danny anderson	Superior steel & Ironworkers Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Est. & PM	South  Kent	WA	USA	\N	\N	\N	zachary.o@superiorsteel.com / danny.a@superiorsteel.com	+1 425-677-8100
1450	Superior Steel Fabrication	Superior Steel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sparks	NV	USA	\N	\N	\N	\N	775-331-2999
1451	Wes Griffitt	Superior Steel, Inc.	wgriffitt@superstl.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Chief Draftsman	\N	TN	\N	\N	\N	\N	\N	\N
1452	Ron Hofmann	Superior structural corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sales and Estimating	New Berlin	WI	USA	\N	\N	\N	1) Estimating@superiorstructural.com        2) info@superiorstructural.com	(800) 704-8830
1453	Adam Sanders	Sure Steel	adam.sanders@suresteel.com	(801) 917-5800	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	BDM/MainMan	\N	UT	\N	\N	\N	\N	info@sureiron.com	(801) 917-5800
1454	Randy Funk	SW Funk Industrial Contractors, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chester	VA	USA	\N	\N	\N	\N	888-998-3865
1455	Swanton weld	Swanton weld	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Swanton	OH	USA	\N	\N	\N	\N	\N
1456	Brian Wachowiak	Synergy Steel Structures, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lansing	IL	USA	\N	\N	\N	brianw@sssfabrication.com	(708) 474-2777
1457	Sandy Carter	Systems Fab & Machine	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing & CNC Manager	El Dorado	AR	USA	\N	\N	\N	\N	870.862.1393
1458	Szabo steel fabricators	Szabo steel fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Greenville	SC	USA	\N	\N	\N	\N	+1 864-244-6505
1459	Thomas Szoke	Szoke Brothers, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Slatington	PA	USA	\N	\N	\N	\N	+1 610-760-9065
1460	Travis Scott	T & M Manufacturing, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tremonton	UT	USA	\N	\N	\N	\N	(435) 257-1400
1461	Russ Gibbs /Michael Wittig	T BAILEY, INC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	/Detailing Manager	Anacortes	WA	USA	\N	\N	\N	\N	+1 360-284-7623
1462	Scott Triner	T.A.Bowman constructors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bloomingdale	IL	USA	\N	\N	\N	\N	630/523-5900
1463	Bill Gelthaus	T.W.S. Fabricators, Inc.	bill@twsfab.com	954-983-9749	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Main Man	Davie	\N	USA	\N	\N	\N	\N	954-983-9749 C: 954-444-5458
1464	John Talley	Talley Metal Products, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hagerstown	MD	USA	\N	\N	\N	\N	(301) 791-2500
1465	Tom Craddock	TASCO	tom@tascoonline.com	813-621-0550	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Tampa	\N	USA	\N	\N	\N	tom@TASCOonline.com	813-621-0550/104 C:813-478-6821
1466	Logan Schors	Tampa Steel Erecting Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating	Tampa	FL	USA	\N	\N	\N	\N	(813) 677-7184
1467	Tate Fabricating Company, INC	Tate Fabricating Company, INC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	White house	TN	USA	\N	\N	\N	\N	(615) 672-4909
1468	Taylors Iron Company	Taylors Iron Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Watkinsville	GA	USA	\N	\N	\N	\N	7067696834
1469	Team Industries Inc.	Team Industries Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	WI	USA	\N	\N	\N	\N	\N
1470	Thomas Tebbens	Tebbens Steel LLC	ttebbens@tebbenssteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	CEO	\N	NY	\N	\N	\N	\N	info@tebbenssteel.com/jellerson@tebbenssteel.com	\N
1471	Micah Kramer	Tech Dynamics, Inc.	micah@techdynamics.us	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP of Operations	\N	OH	\N	\N	\N	\N	\N	\N
1472	Mike Sutton	Tech Steel	\N	801.328.2543	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	UT	\N	\N	\N	\N	\N	801.328.2543
1473	Tony Sanchez	Tecktonix steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mesa	AZ	USA	\N	\N	\N	\N	(866) 928-6349
1474	Kim Rood	Ted Mannstedt & Son, Inc.	kimr@mannstedtsteel.com	(608) 784-1826	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Engineer / Estimator	\N	WI	\N	\N	\N	\N	\N	(608) 784-1826
1475	Terrance Scholes	Tek Steel Fabrication	terry@TEKstl.net	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	East Bethel	MN	USA	\N	\N	\N	\N	763-784-2203
1476	Dolan Johnson	Telko Enterprises	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	USA	\N	\N	\N	\N	256-259-1119
1477	Pat McCaffrey	Templeton steel fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Manager	St, Paso Robles	CA	USA	\N	\N	\N	\N	(805)239-5641
1478	Andrew Jones	Tennessee River Steel	andrew@tennesseeriversteel.com	256-574-2755	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Hollywood	\N	USA	\N	\N	\N	\N	256-574-2755
1479	Testa Steel Constructors	Testa Steel Constructors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Channahon	IL	USA	\N	\N	\N	\N	(815)-729-4777
1480	TGM Fabricators	TGM Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chicago Heights	IL	USA	\N	\N	\N	\N	708-533-0857
1481	PATRICK FINLEY	Thamburri Associates	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cinnaminson	NJ	USA	\N	\N	\N	pfinley@thamburri.com	856-829-4000
1482	J. Matthew Kanicki	The Arthur Louis Steel Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Geneva	OH	USA	\N	\N	\N	\N	(440) 997-5545
1483	David Lawless	The Dover Tank and Plate Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dover	OH	USA	\N	\N	\N	\N	(330) 343-4443
1484	Janice Buback	The Gateway Company of Missouri	janiceb@gatewaycompany.com	3135247440	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	CoolSecretary	\N	MO	USA	\N	\N	\N	\N	313-524-7440 CraigC: 314-629-7412
1485	The Kelly Group	The Kelly Group	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Decatur	IL	USA	\N	\N	\N	\N	217-422-1800
1486	Pat Collins	The Lynch Company, Inc.	collins@thelynchco.com	503-863-5034	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Portland	\N	USA	\N	\N	\N	\N	503-863-5034
1487	DarinW	The Metal Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lexington	SC	USA	\N	\N	\N	darinw@metalworksdirect.com	(803) 808-1888
1488	The Salinas group	The Salinas group	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Austin	TX	USA	\N	\N	\N	\N	512-442-9353
1489	JB Hettler	The Tarrier Steel Co. Inc.	jhettler@tarrier.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Senior Estimator	Columbus	OH	USA	\N	\N	\N	\N	(614) 444-4000
1490	Thieman Manufacturing Technologies	Thieman Manufacturing Technologies	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ellenboro	NC	USA	\N	\N	\N	\N	828-457-8615
1491	Jake Thomas	Thomas Steel, Inc.	jake@tsifab.com	419-483-7540	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Bellevue	OH	USA	\N	\N	\N	info@tsifab.com	419-483-7540
1492	Michael Moore	Thompson Metal Fab	mmoore@tmfab.com	3606960811	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	Vancouver	WA	USA	\N	\N	\N	MLueck@tmfab.com	360 696 0811
1493	Terry Thornberg	Thornberg Steel, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bethel	MN	USA	\N	\N	\N	\N	(763) 434-5178
1494	Bobby Carillo	Thornton Steel	bobby.carillo@thorntonsteel.com	210-633-0100, 817-926-3324	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Structural Steel Estimator	\N	TX	\N	\N	\N	\N	\N	210-633-0100, 817-926-3324
1495	Dave Linge	Thurnbeck Steel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	Forest lake	MN	USA	\N	\N	\N	\N	(651) 464-4665
1496	Dave	Tiger Steel Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	CO	USA	\N	\N	\N	dave@tigersteelco.com	970-482-2324
1497	KIM ARO/Craig MacMillan	Tim's Fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Est.Co-Or/PM	Fitchburg	MA	USA	\N	\N	\N	info@timsfab.com	978-345-0599/120
1498	Austin Ressler	Tipton Structural Fabrication	aressler@tsf-structures.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	IA	\N	\N	\N	\N	\N	\N
1499	Ryan ()	Titan Industries	ryan@titanind.us	309-440-1010	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	IL	\N	\N	\N	\N	info@titanind.us	309-440-1010
1500	Tollefsen Steel & Fabrication, INC	Tollefsen Steel & Fabrication, INC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Muskego	WI	USA	\N	\N	\N	\N	262-679-2235
1501	Rafael Toral Jr.	TORAL WELDING, INC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Jersey City	NJ	USA	\N	\N	\N	\N	(201) 386-1330
1502	Torino industrial fabrication Inc	Torino industrial fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bellport	NY	USA	\N	\N	\N	\N	631-509-1640
1503	David Towe	Towe Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Knoxville	TN	USA	\N	\N	\N	\N	(865) 546-5131
1504	Douglas Carter	Tower Innovations	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Newburgh	IN	USA	\N	\N	\N	\N	(812) 853-0595
1505	William Kavicky	Trans Bay Steel Corp.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	Richmond	CA	USA	\N	\N	\N	wkavicky@transbaysteel.com	510-719-4613
1506	Joseph Schwartz	Transco Ind., Inc.	jschwartz@transco-ind.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	QA Manager	\N	OR	\N	\N	\N	\N	\N	\N
1507	Transcontinental Steel Inc	Transcontinental Steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Newark	NJ	USA	\N	\N	\N	\N	973-596-0148 ext. 16
1508	Nefi Quito	TRC Fabrication	nefi.quito@trcfab.com	208) 542-9600	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	ID	\N	\N	\N	\N	lori.boyt@ieisteel.com	208) 542-9600
1509	Joey Caillier	Trelleborg Marine Systems North America, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Broussard	LA	USA	\N	\N	\N	\N	(337) 322-9033
1510	Cynthia Smith	Triad Steel Services Inc	csmith@triadsteel.com	602-714-9770	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Receptionist	Phoenix	\N	USA	\N	\N	\N	info@triadsteel.com	602-714-9770
1511	Triangle Metal Fabricators	Triangle Metal Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Durham	NC	USA	\N	\N	\N	\N	(919) 342-0197
1512	Jeffrey Probus	Tri-county Welding and Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Arthur	IL	USA	\N	\N	\N	\N	217-543-3304
1513	Quintin Prior	Trident Building Systems, Inc. (Behlem Mfg)	quintin.prior@behlenmfg.com	402-564-3111	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	Sarasota	\N	USA	\N	\N	\N	\N	402-564-3111
1514	Tri-Fab Steel Inc	Tri-Fab Steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Birmingham	AL	USA	\N	\N	\N	trifabcutshop@mindspring.com	205-252-6100
1515	Daniel Westfall	Trinity Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Green Cove Springs	FL	USA	\N	\N	\N	\N	(904) 284-9657
1516	Mike	Trinity Fabricators, Inc.	MIKARROW@ACEGROUP.CC	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	New Albin	IA	USA	\N	\N	\N	\N	(563) 544-4774
1517	Ross Heutel	Trinity Products, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	O'Fallon	MO	USA	\N	\N	\N	\N	800-456-7473
1518	Matt Brown	Trinity steel corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ventura	CA	USA	\N	\N	\N	matt@trinitysteelcorp.com	(805) 648-3486
1519	Richard Neal	Trinity Steel Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Trinity	TX	USA	\N	\N	\N	btreece@trinitysteelinc.com	(936) 594-3513
1520	Celeste Wilhelm	Trinity Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rankin	PA	USA	\N	\N	\N	\N	(412) 271-1620
1521	Van Buren Steel & fabricating	Van Buren Steel & fabricating	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Belleville	MI	USA	\N	\N	\N	\N	(734) 697-8609
1522	Jason Varrin	Triple Steel	jvarrin@triplesteel.com	Direct: 615-813-0270, C: 615-414-4154	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	AL	\N	\N	\N	\N	estimating@triplesteel.com	Direct: 615-813-0270, C: 615-414-4154
1523	SMITH	Tristate iron works	btsmith@tristateironworks.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator - Project manager	Memphis	TN	USA	\N	\N	\N	\N	901-942-1461
1524	Barry Todd	Tri-State Ironworks, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Memphis	TN	USA	\N	\N	\N	\N	(901) 942-1461
1525	Jim Wersota	Tri-Steel Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Trenton	NJ	USA	\N	\N	\N	\N	(609) 392-8660
1526	Stacy Guercia-Baldea	Triton Builders Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Amityville	NY	USA	\N	\N	\N	\N	(631) 841-2534
1527	True North Steel - Blaine	True North Steel - Blaine	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Blaine	MN	USA	\N	\N	\N	\N	\N
1528	Chris ()	True North Steel	structural@truenorthsteel.com	701-492-4425 ex1(Sales)	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sales	\N	ND	\N	\N	\N	\N	\N	701-492-4425 ex1(Sales)
1529	Ali Shantyaei	Trussworks International, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Vice President	Anaheim	CA	USA	\N	\N	\N	ali@twifab.com	(714) 630-2772
1530	TSF structures Inc	TSF structures Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cedar Rapids	IA	USA	\N	\N	\N	\N	0000000000
1531	Ed Van Huis	Tubal-Cain Industries, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Vidor	TX	USA	\N	\N	\N	\N	(409) 786-1783
1532	Turner construction company	Turner construction company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Huntsville	AL	USA	\N	\N	\N	\N	(256) 461-6700
1533	Michael Allbright	Turner Industries Group	mallbright@turner-industries.com	256-584-0004	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	Decatur	\N	USA	\N	\N	\N	\N	256-584-0004
1534	TW Steel Corporation	TW Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chandler	AZ	USA	\N	\N	\N	\N	480-821-7769
1535	Twisted metal works	Twisted metal works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Reno	NV	USA	\N	\N	\N	\N	775-858-8999
1536	Cleve Poston	Two State Construction Company, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Thomson	GA	USA	\N	\N	\N	\N	(706) 595-2863
1537	U.P. Fabricating Co. inc.	U.P. Fabricating Co. inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Negaunee	MI	USA	\N	\N	\N	\N	906.475.4400
1538	Rick Kehl	U.S. Bridge	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cambridge	OH	USA	\N	\N	\N	\N	(740) 421-9369
1539	U.S. Custom fabrication LLC	U.S. Custom fabrication LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	San Tan Valley	AZ	USA	\N	\N	\N	\N	480-453-5655
1540	Curt Schendel	UDC Corporation	cschendel@udccorporation.com	(714)630-8580	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	CA	\N	\N	\N	\N	cschendel@udccorporation.com	(714)630-8580
1541	Union Erectors	Union Erectors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	702-896-9474
1542	Jim Wild	Union Metal Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Canton	OH	USA	\N	\N	\N	\N	(330) 456-7653
1543	Colin Terlip	Unique Metal Fabrication	colin@umfi.com	(620) 232-3060	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	KS	\N	\N	\N	\N	\N	\N
1544	Tommy Edwards	United Steel Fabrication	blake@unitedsteelfabllc.com	256-960-9387	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fyffe	AL	USA	\N	\N	\N	\N	256-960-9387
1630	James D. Pue	Wilton Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Finksburg	MD	USA	\N	\N	\N	\N	(410) 833-8500
1545	Job Kingston	United Steel	j.kingston@unitedsteel.us	O: 385-282-6336 C: 801-664-2675	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	UT	\N	\N	\N	\N	\N	O: 385-282-6336 C: 801-664-2675
1546	United structural works Inc	United structural works Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dr, Congers	NY	USA	\N	\N	\N	\N	845-268-3600
1547	Bray Bourne/Donny Butler	Universal steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lithonia	GA	USA	\N	\N	\N	\N	770-482-5601
1548	Dunna Gant/johnson allen	Universal Steel of North Carolina, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Thomasville	NC	USA	\N	\N	\N	\N	(336) 476-3105
1549	Universal Welding & Fab Inc	Universal Welding & Fab Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	North Pole	AK	USA	\N	\N	\N	tom.zimmerman@universalwelding.net	907-488-2934
1550	Brian Smith	Unlimited Welding, Inc.	brian.smith@unlimitedwelding.com	4075096563	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	Winter Springs	FL	USA	\N	\N	\N	brian.smith@unlimitedwelding.com	407-327-3333 Brian C: 407.509.6563
1551	John Jr.	Utah Ornamental & Iron, INC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Salt Lake City	UT	USA	\N	\N	\N	\N	(801) 973-8678
1552	Clark Olsen	Utah Pacific Bridge & Steel Corp.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lindon	UT	USA	\N	\N	\N	\N	(801) 785-3557
1553	Utica Steel	Utica Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Chesterfield	\N	USA	\N	\N	\N	\N	(586) 949-1900
1554	Gregory Shaheen	V & S Schuler Engineering, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Canton	OH	USA	\N	\N	\N	\N	(330) 452-5200
1555	Gregory Shaheen	V & S Schuler Tubular Products	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Muskogee	OK	USA	\N	\N	\N	\N	(330) 452-5200
1556	Michael Butero	V.M. Iron Work & Structural Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Palm City	FL	USA	\N	\N	\N	nancy@vmironwork.com	772.781.0318
1557	Valley Fabrication	Valley Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	La Salle	IL	USA	\N	\N	\N	\N	815-223-4058
1558	Roger	Valley Fabrication, inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cottonwood	AZ	USA	\N	\N	\N	\N	(928) 220-0209
1559	Jason Carson	Valley Iron Works	jason@valleyironworks.com	(209)993-0135	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	\N	CA	\N	\N	\N	\N	jason@valleyironworks.com	(209)993-0135
1560	Engineering/Estimating	Valley Wide Construction	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Trona	CA	USA	\N	\N	\N	\N	760-372-4729
1561	Rolando Apablaza	Valmont Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Jasper	TN	USA	\N	\N	\N	\N	(423) 883-0727
1562	Steven Banghart	Valmont Industries  Valley, Neb.  Structures Division	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Valley	NE	USA	\N	\N	\N	\N	(402) 359-2201
1563	Aren Larsen	Valmont Newmark	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	El Dorado	KS	USA	\N	\N	\N	\N	(316) 321-1201
1564	Craig Wallace	Van Dam Iron Works Inc	cwallace@vdiw.net	(616) 452-8627	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Misc Detailing Manager	\N	MI	\N	\N	\N	\N	\N	(616) 452-8627
1565	Van Dellen Steel, Inc.	Van Dellen Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dutton	MI	USA	\N	\N	\N	\N	+(616) 698 9950
1566	Jim DeVries	Van Dellen Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dutton	MI	USA	\N	\N	\N	inquiries@vandellensteel.com	(616) 698-9950
1567	Joe ()	Van Linda Iron Works, Inc.	joe@vanlinda.com	561-586-8400 x 206 C:561-584-3186	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	Lake Worth	FL	USA	\N	\N	\N	Ashleigh@VanLinda.com	561-586-8400 x 206 C:561-584-3186
1568	Vanco Steel Inc.	Vanco Steel Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	North Branch	MI	USA	\N	\N	\N	drawings@vancosteel.com	(810) 688-4333
1569	George L. Henderson III	Vandiver Steel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	AL	USA	\N	\N	\N	info@VandiverSteelFab.com	(205) 672-8775
1570	Vann Owens Steel Inc	Vann Owens Steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Harpersville	AL	USA	\N	\N	\N	\N	205-672-9819
1571	Carey VanDellen	VDS West, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mesa	AZ	USA	\N	\N	\N	\N	(480) 733-1600
1572	Mike Vegter	VEGTER STEEL FABRICATION	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Morrison	IL	USA	\N	\N	\N	\N	(815) 772-7470
1573	Jeremy Duckett	Veritas Steel, LLC	jduckett@veritassteel.com	715-839-6722	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sr PM	Palatka	\N	USA	\N	\N	\N	\N	(386) 328-4683
1574	Vertex Steel	Vertex Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Milford Charter Twp	MI	USA	\N	\N	\N	\N	248-684-4177
1575	Vertical Iron works inc.	Vertical Iron works inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Reno	NV	USA	\N	\N	\N	\N	775-348-0773
1576	Vetrees Steel Fabrication Inc.	Vetrees Steel Fabrication Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Douglas	AZ	USA	\N	\N	\N	\N	520-364-6281
1577	Vic's welding co llc	Vic's welding co llc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	El Mirage	AZ	USA	\N	\N	\N	\N	1)  (623) 925-5696 - Business          2)  (602) 525-4804 - Cell
1578	Adam Vidimos	VIDIMOS INC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	East Chicago	IN	USA	\N	\N	\N	avidimos@vidimos.com	219-397-2728
1579	Chris Palmer	Vigor	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	Portland	OR	USA	\N	\N	\N	\N	(503) 653-6300/ 5032471777
1580	Sidney A. Martin	Virginia-Carolina Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Norfolk	VA	USA	\N	\N	\N	\N	(757) 853-7403
1581	Virignia Steel & Fabrication, Inc	Virignia Steel & Fabrication, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bastian	WV	USA	\N	\N	\N	davidstinson@va-steel.com	276-688-2125
1582	Herbert Beck	Vortex Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	McCarran	NV	USA	\N	\N	\N	\N	(775) 332-8477
1583	Ryan Anderson	Vulcraft - Nebraska, Division of Nucor	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Norfolk	NE	USA	\N	\N	\N	\N	(402) 644-8500
1584	David Conner	Vulcraft - South Carolina, Division of Nucor	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Florence	SC	USA	\N	\N	\N	\N	(843) 664-2259
1585	Vulcraft sales corporation	Vulcraft sales corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	WI	USA	\N	\N	\N	\N	262-251-5666
1586	W & W steel erectors (MULTIPLE LOCATIONS)	W & W steel erectors (MULTIPLE LOCATIONS)	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Vegas	NV	USA	\N	\N	\N	\N	702-364-2027
1587	W&W Structural, Inc.	W&W Structural, Inc.	estimating@w-ws.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tempe	AZ	USA	\N	\N	\N	\N	480-966-9427
1588	Todd Richburg	W&W/AFCO Steel LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lubbock	TX	USA	\N	\N	\N	\N	(806) 765-5781
1589	Jason Harder	Waggoner fabrication & Millwright	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	East Berlin	PA	USA	\N	\N	\N	\N	717.432.8403
1590	Jim Weist	Wallis steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Carson City	NV	USA	\N	\N	\N	wallis_steel@yahoo.com	775-841-3700
1591	DUSTIN HOLLAND	Walpar, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Birmingham	AL	USA	\N	\N	\N	\N	205-925-4990
1592	Tom Jenkins /Melissa Adams	Walters Metal Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Granite City	IL	USA	\N	\N	\N	\N	(618) 931-5551
1593	Randy Archer	Wanner Metal Worx, Inc.	randyarcher@wmworx.com	(740) 369-4034	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP Sales & Estimating	\N	OH	\N	\N	\N	\N	rja@wmworx.com	(740) 369-4034
1594	John/roger g lawton	Ward steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP / ESTIMATOR	Liverpool	NY	USA	\N	\N	\N	tward@wardsteel.org / rlawton@wardsteel.org	3154514566
1595	Ward welding and fabricator Inc.	Ward welding and fabricator Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Milwaukee	WI	USA	\N	\N	\N	\N	414-395-0765
1596	Kent Larson	Warrior MFG, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hutchinson	MN	USA	\N	\N	\N	\N	(320) 587-5505
1597	Gerrit Nagel	Washington Iron Works, Inc	gerrit@waironwks.com	(360) 679-4868	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	WA	\N	\N	\N	\N	\N	(360) 679-4868
1598	Eric Raz	Waukegan Steel, LLC	eraze@waukegansteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	Waukegan	IL	USA	\N	\N	\N	\N	8476622810
1599	Scott King	We Fab Steel	\N	(520) 777-8275	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	CEO	\N	AZ	\N	\N	\N	\N	ESTIMATING@WEFAB.NET	(520) 777-8275
1600	Anthony Liparini /Michael Diffley	Weir Welding Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bethlehem	PA	USA	\N	\N	\N	\N	(610) 974-8140/201-939-2284
1601	Engineering/Estimating	Weiser Iron Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fontana	CA	USA	\N	\N	\N	\N	(619) 464-8456
1602	Welco Services Inc	Welco Services Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	McPherson	KS	USA	\N	\N	\N	\N	(620) 241-3000
1603	David V. Bahl	Weldall Mfg., Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Waukesha	WI	USA	\N	\N	\N	\N	(262) 896-4040
1604	Welding Alfaro's steel	Welding Alfaro's steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	602-373-9720
1605	Welding Unlimited	Welding Unlimited	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mills River	NC	USA	\N	\N	\N	\N	828-891-8501
1606	Chris Fahey	Weldon Steel Corp	cfahey@weldonsteel.com	252-536-2113	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	NC	\N	\N	\N	\N	\N	252-536-2113
1607	Corey Dehl	Weldway Steel Fab	cdehl@weldwayinc.com	209-847-8083	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	CA	\N	\N	\N	\N	jjimenez@weldwayinc.com	209-847-8083
1608	Samuel Young	Well Fab Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mt. Holly	NJ	USA	\N	\N	\N	\N	(609) 261-1393
1609	Kyle Chance	West Coast Iron	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	Spring Valley	CA	USA	\N	\N	\N	kyle@westcoastiron.com	(619) 464-8456
1610	Chris Mayeda	Western Fabrication Center, LLC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kelso	WA	USA	\N	\N	\N	\N	(360) 575-1500
1611	Western Metal Fabricating Inc	Western Metal Fabricating Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Boise	ID	USA	\N	\N	\N	\N	208-336-4042
1612	Gorden Cole	Western Slope Iron & Supply, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Fabrication manager	Grand Junction	CO	USA	\N	\N	\N	info@wsiron.com	(970) 243-9770
1613	Rick	Western States Steel & Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating manager	Spokane	WA	USA	\N	\N	\N	rick@westernstatessteel.com	(509) 489-8046
1614	Western Structural Co	Western Structural Co	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Moline	IL	USA	\N	\N	\N	\N	(309) 764-3523
1615	Weststeel fabrication	Weststeel fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Reno	NV	USA	\N	\N	\N	info@WestSteelFabrication.com	(775) 745-5303
1616	Jason	White Dog Supply LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	480-773-9911
1617	Kaylah Williams	Whitley Steel	kaylahw@whitleysteel.com	904-289-7471	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Drafting Manager	Jacksonville	FL	USA	\N	\N	\N	\N	904-289-7471
1618	John Baylor	Whitmore steel Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Coordinator	Spring Valley	CA	USA	\N	\N	\N	\N	619.460.5196
1619	Wicked Welds LLC	Wicked Welds LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Charlotte	NC	USA	\N	\N	\N	\N	980-498-2588
1620	Ernest Wilborn	Wilborn Steel Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	San Antonio	TX	USA	\N	\N	\N	\N	(210) 532-6852
1621	Mary Karcher	Wildcat Steel & Fabricating, LLC	mary@wildcatsteel.com	843-784-7052	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	AssistantPM	Hardeeville	SC	USA	\N	\N	\N	infor@wildcatsteel.com	843-784-7052
1622	Randy Martin	Williams Steel Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Jackson	TN	USA	\N	\N	\N	SALES@WSCSTEEL.COM	(731) 423-4900
1623	WilliamsTown Fabricators, Inc.	WilliamsTown Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	WV	USA	\N	\N	\N	\N	\N
1624	Willow fabricatuions iNc	Willow fabricatuions iNc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Middleburg,	FL	USA	\N	\N	\N	\N	2
1625	Wilson Railing and Metal Fabricating	Wilson Railing and Metal Fabricating	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Park City	IL	USA	\N	\N	\N	\N	847-662-1747
1626	Wilson Works	Wilson Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	WV	USA	\N	\N	\N	\N	\N
1627	Wilson Wrought Iron Inc	Wilson Wrought Iron Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Clinton	TN	USA	\N	\N	\N	\N	(865) 457-1504
1628	Kenny W. Wilson	Wilson's Structural Steel, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fenton	MO	USA	\N	\N	\N	\N	(636) 343-4777
1629	Wilsons welding and repair	Wilsons welding and repair	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Phoenix	AZ	USA	\N	\N	\N	\N	1 623-225-3614
1631	David Brill	Winchester Metals, Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Winchester	VA	USA	\N	\N	\N	\N	(540) 667-9000
1632	WINNICK STEEL, INC.	WINNICK STEEL, INC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimation department	\N	CT	USA	\N	\N	\N	\N	(203) 377 - 4600
1633	Kyle Phillips	Winston Steel	kphillips@lyndonsteel.com	336-788-6151	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	Salem	NC	USA	\N	\N	\N	\N	336-788-6151
1634	Brad Fox	Wisconsin Structural Steel Co.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Barronett	WI	USA	\N	\N	\N	\N	\N
1635	Tim Harper	WMK Steel & Co Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Billings	MT	USA	\N	\N	\N	\N	(406) 256-3200
1636	Wolf steel construcion Inc	Wolf steel construcion Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fargo	ND	USA	\N	\N	\N	\N	701-239-6968
1637	Wolfe Industrial	Wolfe Industrial	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	La Vergne	TN	USA	\N	\N	\N	\N	\N
1638	Wolverine Steel Erectors, Inc.	Wolverine Steel Erectors, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dexter	MI	USA	\N	\N	\N	\N	734-424-0568
1639	ROSS BLANCHARD	Woodward steel Group	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator	New Orleans	LA	USA	\N	\N	\N	\N	504.822.6443
1640	Jerry Woolf /Jeff Everidge	Woolf Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Middletown	PA	USA	\N	\N	\N	jeveridge@woolfsteel.com	(717) 944-1423/30/20
1641	Robert A. Johnson	Worcester County welding Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rochdale	MA	USA	\N	\N	\N	rob@jsengineers.com	508-892-4884/508-892-1818/23
1642	Rodt	Works Steel Manufacturing LLC	\N	(225)939-2094	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	___________	Baton Rouge	LA	USA	\N	\N	\N	\N	NO COMPANY NUM AVAILABLE           1) (225)939-2094 - Rodt        2) (225)241-5282 - Barry
1643	Worth Steel LLC	Worth Steel LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pocatello	ID	USA	\N	\N	\N	worthsteel@gmail.com	208-478-0190
1644	Wright Steel Fabricator	Wright Steel Fabricator	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Redford Charter Twp	MI	USA	\N	\N	\N	\N	313-532-4210
1645	David Petty	WSI, Inc. / Washington Stair & Iron	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Baltimore	MD	USA	\N	\N	\N	\N	(410) 761-5522
1646	PATRICK CLEVENGER?	Ratliff Steel Company, LLC	patrickclevenger@ratliffsteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Brownwood	TX	USA	\N	\N	\N	\N	(325) 600-4264
1647	Deborah Beatty	Wyatt Resources, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fulshear	TX	USA	\N	\N	\N	\N	(281) 346-6100
1648	John Burroughs	Wylie Steel Fabricators, Inc.	\N	6153732875	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Springfield - shop (or) Franklin - office	TN	USA	\N	\N	\N	\N	Springfield - (615) 384-8497     Franklin - 615-373-2875
1649	Tim Nalley	XKT Engineering	tnalley@xktengineering.com	7075622500	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	\N	CA	USA	\N	\N	\N	\N	(707)562-2500
1650	Yajima USA, Ltd	Yajima USA, Ltd	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Reno	NV	USA	\N	\N	\N	\N	775-336-4422
1651	John Gehlsen	Yakima Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Yakima	WA	USA	\N	\N	\N	\N	(509) 575-1570
1652	Yanke Machine Shop and Fabrication	Yanke Machine Shop and Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Boise	ID	USA	\N	\N	\N	\N	208-342-8901
1653	Tim Reinhardt	Zalk Josephs Fabricators, LLC	timothy.reinhardt@zalkjosephs.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	WI	\N	\N	\N	\N	sales@zalkjosephs.com	\N
1654	Shelly Ensign	Zimkor LLC	sensign@zimkor.com	D:303-242-5245C: 720-581-9417	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	CO	\N	\N	\N	\N	jbrown@zimkor.com	D:303-242-5245C: 720-581-9417
1655	Estimating department	Zimmerman Metals, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Denver	CO	USA	\N	\N	\N	\N	(303) 294-0180
1656	Lizeth Loya	New Mexico Steel Fabricators Inc.	Lloya.Nmsteel@Outlook.Com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Head Estimator and Project Manager	Las Cruces	NM	USA	\N	\N	\N	\N	(575) 523-5117
1657	Santa Fe Steel	Santa Fe Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Santa Fe	NM	USA	\N	\N	\N	charles@santafesteel.com (for quotes)	505.474.5997
1658	Mike Atencio	Raysteel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP and operations manager	Albuquerque	NM	USA	\N	\N	\N	info@raysteel.com	505-898-3309
1659	Couty Design Build	Couty Design Build	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albuquerque	NM	USA	\N	\N	\N	info@coutydesignbuild.com	\N
1660	Akins Manufacturing Inc.	Akins Manufacturing Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albuquerque	NM	USA	\N	\N	\N	info@akinsmfg.com	505-503-6336
1661	American Stainless Steel Equipment, Inc.	American Stainless Steel Equipment, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albuquerque	NM	USA	\N	\N	\N	\N	(505) 255-7576
1662	Thomas Pickens	Pascetti Steel Design Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Lead Estimator	Albuquerque	NM	USA	\N	\N	\N	\N	(505) 341-2900
1663	Kerr Squared metal fabrication and erection	Kerr Squared metal fabrication and erection	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albuquerque	NM	USA	\N	\N	\N	\N	505-554-1278
1664	Anglim's Western Metal Works Inc.	Anglim's Western Metal Works Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albuquerque	NM	USA	\N	\N	\N	kevin@metalworksnm.com	(505) 822-9170
1665	Metal Fabrication Albuquerque	Metal Fabrication Albuquerque	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albuquerque	NM	USA	\N	\N	\N	\N	(505) 226-8264
1666	Brian Moore	Garvin Construction Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimator and Project Manager	Albuquerque	NM	USA	\N	\N	\N	\N	(505) 792-1291
1667	Metal Building Specialists	Metal Building Specialists	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Las Cruces	NM	USA	\N	\N	\N	\N	575-523-6617
1668	Morethangates	Morethangates	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Albuquerque	NM	USA	\N	\N	\N	office@morethangates.com	505-221-6673
1669	Basden Steel Oklahoma	Basden Steel Oklahoma	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Claremore	OK	USA	\N	\N	\N	\N	918-341-9468
1670	Bennett Steel Inc.	Bennett Steel Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sapulpa	OK	USA	\N	\N	\N	?info@bennettsteel.com	918.227.2564
1671	Larrance Steel Corporation	Larrance Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lawton	OK	USA	\N	\N	\N	\N	580-353-4600
1672	John Vick	Matrix Services	\N	918 379 6315	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Fabrication	Catoosa	OK	USA	\N	\N	\N	\N	714 289 6600
1673	Premier Steel Services	Premier Steel Services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Glenpook	OK	USA	\N	\N	\N	\N	918-227-0110
1674	Steel-Fab Inc.	Steel-Fab Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Durant	OK	USA	\N	\N	\N	\N	704.394.5376
1675	Estimators ()	Weibee Steel	estimating@weibee-steel.com	405) 360-7055	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating Dept	\N	OK	\N	\N	\N	\N	estimating@weibee-steel.com	405) 360-7055
1676	Council stainless & Sheet metal	Council stainless & Sheet metal	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oklahoma City	OK	USA	\N	\N	\N	\N	405-787-4400
1677	Five star steel Inc.	Five star steel Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	OK	USA	\N	\N	\N	fivestarsteel@coxinet.net	405-787-7620
1678	K & E Fabrication	K & E Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oklahoma City	OK	USA	\N	\N	\N	EDDIE@KEFABRICATION.COM	(405) 635-8552
1679	York Metal Fabricators	York Metal Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oklahoma City	OK	USA	\N	\N	\N	grantyork@yorkmetal.com	800-255-4703
1680	Bill Geselbracht	Steel Quest, Inc.	bgeselbracht@steelquest.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	OH	\N	\N	\N	\N	steelqueen@msn.com	\N
1681	Chris Ziegler	Osiyo Metal Fabricators	chris@osiyometals.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Estimating Manager	Broken Arrow	OK	USA	\N	\N	\N	\N	918.258.4717
1682	Whitney Steel Building Systems LLC	Whitney Steel Building Systems LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pryor	OK	USA	\N	\N	\N	office@whitney-mfg.com	918-825-6062
1683	Industrial Structures Inc	Industrial Structures Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tulsa	OK	USA	\N	\N	\N	\N	918-341-0300
1684	E-Saw welding & fabrication	E-Saw welding & fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Weatherford	OK	USA	\N	\N	\N	esaw_welding@yahoo.com	(580) 772-2448
1685	Mammoth Steel LLC	Mammoth Steel LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oklahoma City	OK	USA	\N	\N	\N	\N	580-302-0691
1686	HK&S Iron Company	HK&S Iron Company	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oklahoma City	OK	USA	\N	\N	\N	hksiron@hksiron.com	405-745-2761
1687	Stepco Steel Erectors	Stepco Steel Erectors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oklahoma City	OK	USA	\N	\N	\N	\N	405-728-1132
1688	Consolidated Fabrication & Constructors	Consolidated Fabrication & Constructors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tulsa	OK	USA	\N	\N	\N	\N	(918) 224-3500
1689	Patriot Steel LLC	Patriot Steel LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Harrah	OK	USA	\N	\N	\N	\N	405-309-6006
1690	Crimson Steel Supply	Crimson Steel Supply	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tulsa	OK	USA	\N	\N	\N	info@crimsonsteelsupply.com	918-994-5330
1691	T-Fab Custom metal fabrication	T-Fab Custom metal fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Union City	OK	USA	\N	\N	\N	\N	(405) 483-5009
1692	A & W Metal Fab	A & W Metal Fab	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Ponca City	OK	USA	\N	\N	\N	\N	580-765-1655
1693	Parfab companies	Parfab companies	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Inola	OK	USA	\N	\N	\N	\N	918.543.6310
1694	Sweeper Metal Fabricators Corp.	Sweeper Metal Fabricators Corp.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Drumright	OK	USA	\N	\N	\N	\N	918-352-2133
1695	Ray Albright Steel Products	Ray Albright Steel Products	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Oklahoma City	OK	USA	\N	\N	\N	\N	(405) 681-2352
1696	Ethic Welding & Fabrication	Ethic Welding & Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tulsa	OK	USA	\N	\N	\N	\N	918-869-3902
1697	Gerdau Ameristeel	Gerdau Ameristeel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sand Springs	OK	USA	\N	\N	\N	\N	918-241-7210
1698	Avery Barron Industries	Avery Barron Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tulsa	OK	USA	\N	\N	\N	info@abi-us.com	(918) 779-6903
1699	TMJ Construction Specialities	TMJ Construction Specialities	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cheyenne	WY	USA	\N	\N	\N	jw@DetailingSteel.com	(307) 637-1092
1700	Ellingford Brothers Inc.	Ellingford Brothers Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Evanston	WY	USA	\N	\N	\N	\N	307-789-1515
1701	Wyoming Steel Fe & Inc	Wyoming Steel Fe & Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cheyenne	WY	USA	\N	\N	\N	\N	307.634.8621
1702	Rod iron custom fabrication	Rod iron custom fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Gillette	WY	USA	\N	\N	\N	\N	307-686-1970
1703	Truenorth steel	Truenorth steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Casper	WY	USA	\N	\N	\N	STRUCTURAL@TRUENORTHSTEEL.COM	701-492-4420
1704	B & T Fabrication	B & T Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Casper	WY	USA	\N	\N	\N	\N	(307) 265-6206
1705	High Dessert Welding and Machine	High Dessert Welding and Machine	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Rawlins	WY	USA	\N	\N	\N	Info@highdesertwelding.com	307-328-2094
1706	JJC Fabrication and mine maintenance	JJC Fabrication and mine maintenance	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Green River	WY	USA	\N	\N	\N	\N	307-875-2950
1707	KL & A  Engineers & Builders	KL & A  Engineers & Builders	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Buffalo	WY	USA	\N	\N	\N	\N	307-621-7011
1708	ARCOSA Meyer Utility Structure Inc.	ARCOSA Meyer Utility Structure Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fort Worth	TX	USA	\N	\N	\N	\N	0000000000
1709	Basden Industrial Group, LLC	Basden Industrial Group, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Brookshire	TX	USA	\N	\N	\N	\N	281-375-5225
1710	Tobey ()	Lico Steel	\N	NoNeedEverythingComesDetailed	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	MO	\N	\N	\N	\N	info@qualicosteel.com	NoNeedEverythingComesDetailed
1711	Imre Szombathy	Cody Builders Supply Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Austin	TX	USA	\N	\N	\N	estimating@codybuilderssupply.com	512-339-9834
1712	CommScope	CommScope	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Euless	TX	USA	\N	\N	\N	\N	0000000000
1713	Cornerstone Building Brands	Cornerstone Building Brands	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Houston	TX	USA	\N	\N	\N	\N	0000000000
1714	Philip Savoy	Custom Fabricators & Repairds Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Drafter and detailer	Bryan	TX	USA	\N	\N	\N	info@bcs-customfab.com	(979) 775-4297
1715	Guard-All Building Solutions Manufacturing	Guard-All Building Solutions Manufacturing	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dallas	TX	USA	\N	\N	\N	sales@gnb.group	855-258-2578
1716	Harrison Walker & Harper	Harrison Walker & Harper	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Paris	TX	USA	\N	\N	\N	\N	(800) 442-TEAM
1717	Russel Lauer	Jimco Sales	jph@jimcosales.net	817-924-6173	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailing Manager	\N	TX	\N	\N	\N	\N	jimcosales.com	817-924-6173
1718	Kasco Structures LLC	Kasco Structures LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	El Paso	TX	USA	\N	\N	\N	\N	(915) 544-1210
1719	Wes Meixner	MICA Steelworks	wmeixner@micasteelworks.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	\N	TX	\N	\N	\N	\N	\N	\N
1720	Monitor Canopies, Inc.	Monitor Canopies, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sherman	TX	USA	\N	\N	\N	\N	903.893.6336
1721	Sandra Gonzalez	MSD Building Corp	info@msdbuildingcorp.com	713-477-8335	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	TX	\N	\N	\N	\N	\N	713-477-8335
1722	Red Dot Corporation	Red Dot Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Athens	TX	USA	\N	\N	\N	\N	(800) 657-2234
1723	RSL Contractors	RSL Contractors	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Spring	TX	USA	\N	\N	\N	\N	0000000000
1724	Texas Corrugators	Texas Corrugators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hutto	TX	USA	\N	\N	\N	info@txcorr.com	512-388-0588
1725	TrueNorth Steel - Lubbock	TrueNorth Steel - Lubbock	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lubbock	TX	USA	\N	\N	\N	STRUCTURAL@TRUENORTHSTEEL.COM	701-492-4420
1726	Francisco Rojas	Zinsmeyer Structural Steel	francisco@zinsmeyerss.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Lead Purchasing Agent	Castroville	TX	USA	\N	\N	\N	\N	830-985-3498
1727	()	ATX Steel	contact@atx-steel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	contact@atx-steel.com	\N
1728	Stackin Iron LLC	Stackin Iron LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Coppell	TX	USA	\N	\N	\N	\N	469-999-3582
1729	Summit Steel Fabricators, Inc.	Summit Steel Fabricators, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Houston	TX	USA	\N	\N	\N	\N	(713) 451-6960
1730	W & S Steel structures	W & S Steel structures	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bulverde	TX	USA	\N	\N	\N	\N	830-980-7208
1731	Sulta custom steel fabricator	Sulta custom steel fabricator	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sulphur Springs	TX	USA	\N	\N	\N	sultamfg@gmail.com	903-885-2139
1732	Jessica ()	Go Wild Fabrication	jessica@gowildfabrication.com	817-729-7337	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	\N	817-729-7337
1733	John Black	Aztec Steel	john@aztecsteel.com	(440) 323-7576	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sales & PM	\N	OH	\N	\N	\N	\N	Info@Aztec-Industries.com	(440) 323-7576
1734	Scott Vallee	S & S Steel Co	scott@ss-steeltx.com	512-809-5386	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	VP	\N	TX	\N	\N	\N	\N	\N	512-809-5386
1735	Thomas Campbell	NASCO Steel	thomas@nascosteel.com	817-332-7069	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Sales	\N	TX	\N	\N	\N	\N	\N	817-332-7069
1736	Pyler Steel Fabrication	Pyler Steel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Sherman	TX	USA	\N	\N	\N	info@plylerbuilds.com	(903) 893-6393
1737	Howard Steel, LLC	Howard Steel, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Austin	TX	USA	\N	\N	\N	\N	(512) 233-6600
1738	()	Texas Steel Fabricators	texassteel95@att.net	936-372-1616	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	texassteel95@att.net	936-372-1616
1739	Lone Start Iron Works	Lone Start Iron Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Waco	TX	USA	\N	\N	\N	noahsmith22@gmail.com	254-715-6690
1740	Hector Sanchez	Total Steel Fabrication	hsanchez@totalstlfab.com	972-846-4703	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	contactus@totalstlfab.com	972-846-4703
1741	Robert Young	Tyler Steel and Fabrication	ryoung@tylersteel.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Tyler	TX	USA	\N	\N	\N	\N	903-595-4553
1742	Robert Hossfeld	Harbor Fab	rhossfeld@harborfab.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	MainMan	\N	TX	\N	\N	\N	\N	\N	\N
1743	Francisco Gomez	Iron City Erectors	info@ironcityerectors.com	972-472-7021	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	info@ironcityerectors.com	972-472-7021
1744	Zach ()	Austin Iron	zach@austiniron.com	512-939-9161	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Austin	TX	USA	\N	\N	\N	zach@austiniron.com	512-939-9161
1745	AG welding	AG welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Houston	TX	USA	\N	\N	\N	info@agwelding.com    and   sales@agwelding.com	713-988-4200
1746	AMCO Steel Fabrication LLC	AMCO Steel Fabrication LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Elmendorf	TX	USA	\N	\N	\N	\N	210-488-9023
1747	()	Yellow Rose Steel	service@yellowrosesteel.com	713-862-7339	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	service@yellowrosesteel.com	713-862-7339
1748	Buffalo Steel Fabrication, Inc.	Buffalo Steel Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Crosby	TX	USA	\N	\N	\N	\N	281-743-1582
1749	()	C& D Steel Fabrication	cdsteelfab@yahoo.com	817-870-1570	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	cdsteelfab@yahoo.com	817-870-1570
1750	Gulf Coast Sheet metal and Gulf coast fabricators	Gulf Coast Sheet metal and Gulf coast fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Port Arthur	TX	USA	\N	\N	\N	rellis@gulfcoastsheetmetal.com	409 722 9690
1751	Brazos pipe and steel fabricating	Brazos pipe and steel fabricating	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Free Port	TX	USA	\N	\N	\N	\N	979-233-7895
1752	Four Star Fabrication	Four Star Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dallas	TX	USA	\N	\N	\N	\N	214-748-3494
1753	Schneider Steel LTD	Schneider Steel LTD	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	San Antonio	TX	USA	\N	\N	\N	\N	210-337-5200
1754	Beco Metal Works	Beco Metal Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Nevada	TX	USA	\N	\N	\N	estimating@becometalworks.com	972.535.5619
1755	Bosworth Steel	Bosworth Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dallas	TX	USA	\N	\N	\N	sales@bosworthsteel.com	214.371.3700
1756	Rooster fabrication & construction	Rooster fabrication & construction	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Robstown	TX	USA	\N	\N	\N	INFO@ROOSTERFAB.COM	(361) 826-0675
1757	Magna Fab	Magna Fab	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Venus	TX	USA	\N	\N	\N	info@magnafabrication.com	469 415 9100
1758	Jason Reagan	Dallas Fabrication	jason@dallasfab.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	COO	\N	TX	\N	\N	\N	\N	sales@dallasfab.com	\N
1759	United steel fabricators	United steel fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Houston	TX	USA	\N	\N	\N	\N	281-444-5300
1760	BWT welding & associates inc	BWT welding & associates inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hutto	TX	USA	\N	\N	\N	info@bwtwelding.com	(512) 759-2331 or (512) 759-3306
1761	Kensing Iron Works	Kensing Iron Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	New Braunfels	TX	USA	\N	\N	\N	\N	830-625-2815
1762	STEVE MORGAN	Fishbeck welding	stevem@fischbeckwelding.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	New Braunfels	TX	USA	\N	\N	\N	keithw@fischbeckwelding.com	(830)625-3249
1763	Ramiro ()	Steel Boss	ramiro@steel-boss.com	214-421-2141	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	Hardwork@Steel-Boss.com	214-421-2141
1764	Arc Rite	Arc Rite	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Pipe Creek	TX	USA	\N	\N	\N	office@arcrite.net	(210) 912-7177
1765	Travis Eckert	Parks Metal Fabricators Inc	treckertpmf@outlook.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Wake Village	TX	USA	\N	\N	\N	\N	903-838-0535
1766	Red Steel Co	Red Steel Co	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Dallas	TX	USA	\N	\N	\N	\N	972-243-4242
1767	Texas Stairs and Rails	Texas Stairs and Rails	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Houston	TX	USA	\N	\N	\N	\N	(281) 987-2115
1768	K & H Fabricators	K & H Fabricators	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Smithville	TX	USA	\N	\N	\N	sales@khfab.com	512.237.5020
1769	Caden Romero	True Fab Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	USA	\N	\N	\N	\N	979-233-5550
1770	B & D steel fabrication	B & D steel fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fort Worth	TX	USA	\N	\N	\N	\N	682-561-6168
1771	Modern Welding Company of Texas	Modern Welding Company of Texas	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Houston	TX	USA	\N	\N	\N	\N	0000000000
1772	Arc metal works and general contractor	Arc metal works and general contractor	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	USA	\N	\N	\N	\N	917-615-6951
1773	Unlimited Steel	Unlimited Steel	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	USA	\N	\N	\N	office@unlimitedsteel.com	(435) 315-3358
1774	ARRK Fabrication and Design	ARRK Fabrication and Design	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	USA	\N	\N	\N	\N	979-393-4763
1775	A & S Steel Group	A & S Steel Group	sales@asfabrication.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	USA	\N	\N	\N	\N	817-626-7720
1776	South Texas Steel Services	South Texas Steel Services	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Victoria	TX	USA	\N	\N	\N	mmeans@stssc.com	(361) 582-4881
1777	Waco metal products inc	Waco metal products inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	USA	\N	\N	\N	\N	254-829-1675
1778	All steel fabrication, inc	All steel fabrication, inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Godley	TX	USA	\N	\N	\N	\N	817-345-7600
1779	()	AFAB Industries	jvalendy@afabindustries.com	817-337-4776	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	\N	\N	\N	\N	\N	817-337-4776
1780	Mr. Steel Inc.	Mr. Steel Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Wylie	TX	USA	\N	\N	\N	\N	972-429-6212
1781	Estela Fuentes	Medcalf fabrication	efuentes@medcalf-fab.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	TX	USA	\N	\N	\N	\N	(281) 893-0775
1782	Meridian construction services corporation	Meridian construction services corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kingsbury	TX	USA	\N	\N	\N	\N	(830) 379-5524
1783	Fisher's Iron and Metal Ind.	Fisher's Iron and Metal Ind.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Marble Falls	TX	USA	\N	\N	\N	\N	830-693-7000
1784	Midwest fab & construction	Midwest fab & construction	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lubbock	TX	USA	\N	\N	\N	\N	806-900-9126
1785	Tech Fab	Tech Fab	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Houston	TX	USA	\N	\N	\N	sales@tech-fab.com	281-862-9001
1786	Wasco Reinforcing Steel Supply	Wasco Reinforcing Steel Supply	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Carrollton	TX	USA	\N	\N	\N	\N	972-242-4771
1787	Architextural Fabrication	Architextural Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Fort Worth	TX	USA	\N	\N	\N	\N	817.926.7270 (or) 800.962.8027
1788	East side fabrication	East side fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Manor	TX	USA	\N	\N	\N	eastsidefabrication@gmail.com	512.386.8770
1789	American steel & metal fabricators LLC	American steel & metal fabricators LLC	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Mission	TX	USA	\N	\N	\N	\N	(956) 624-6109
1790	HHI Corporation	HHI Corporation	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	UT	USA	\N	\N	\N	\N	\N
1791	Matt Blaser	Intermark Steel LLC	matt.blaser@intermarksteel.com	(435) 637-4435	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	President	\N	UT	\N	\N	\N	\N	\N	\N
1792	S  & S Steel Fabrication, Inc.	S  & S Steel Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	UT	USA	\N	\N	\N	\N	\N
1793	Justin Pitts	SME Steel Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	West Jordan	UT	USA	\N	\N	\N	\N	801-280-0711
1794	Daniel ()	Utah Fabrication	daniel@utahfab.com	435-579-4418 C:435-224-9028	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Detailier	\N	UT	\N	\N	\N	\N	\N	435-579-4418 C:435-224-9028
1795	weMFG	weMFG	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Cedar City	UT	USA	\N	\N	\N	letstalk@wemfg.com	(435) 656-9567
1796	Clark Indstrial, Inc.	Clark Indstrial, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Missoula	MT	USA	\N	\N	\N	\N	406-273-6030
1797	Continental Steel Works Inc.	Continental Steel Works Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Butte	MT	USA	\N	\N	\N	info@continentalsteelworks.com	406-782-3922
1798	AcuTech Metal Works	AcuTech Metal Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Columbia Falls	MT	USA	\N	\N	\N	\N	406-892-4030
1799	4 corners welding	4 corners welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	MT	USA	\N	\N	\N	\N	1
1800	Mountain Works	Mountain Works	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bozeman	MT	USA	\N	\N	\N	bo@montanamountainworks.com	(202) 380-6672
1801	Midland West Manufacturing	Midland West Manufacturing	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lockwood	MT	USA	\N	\N	\N	\N	406-245-6204
1802	BAILY OSTERBERG	Steel Solutions	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Steel Detailer	Laurel	MT	USA	\N	\N	\N	sbauer@steelsolutionsmt.com	406-794-3381
1803	Big Sky Welding and Repair	Big Sky Welding and Repair	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Belgrade	MT	USA	\N	\N	\N	bigskywelders@gmail.com	406-388-1680
1804	Custom II manufacturing	Custom II manufacturing	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bozeman	MT	USA	\N	\N	\N	billing@customii.build	(406) 586-6809
1805	Solid Iron	Solid Iron	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Columbia Falls	MT	USA	\N	\N	\N	solid.iron@outlook.com	(406) 892-1499
1806	Scott Slothower	Western States Steel Erection	scott@wss.build	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Project Manager	Billings	MT	USA	\N	\N	\N	\N	(406) 259-9275
1807	Stronghold Fabrication	Stronghold Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Bozeman	MT	USA	\N	\N	\N	info@strongholdfab.com	(406) 599 -BOSS (2677)
1808	Dominic Mocko	Grizzly Steel	dominic@grizsteel.com	(406) 239-2371	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Vice President	Whitehall	MT	USA	\N	\N	\N	\N	(406) 287-5555
1809	Lance Wenger	Northside welding and fabrication  Inc.	lance@northsidewelding.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Field Superintendent	Helena	MT	USA	\N	\N	\N	\N	(406) 442-5150
1810	RTI Bridge	RTI Bridge	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Plains	MT	USA	\N	\N	\N	\N	406-826-5932
1811	Flathead Ironworks, Welding & Mechanical	Flathead Ironworks, Welding & Mechanical	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	MT	USA	\N	\N	\N	\N	406-885-6311
1812	Country side welding	Country side welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kalispell	MT	USA	\N	\N	\N	office@countrysidewelding.com	(406) 755-9232
1813	Hawe steel design	Hawe steel design	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Butte	MT	USA	\N	\N	\N	\N	(406) 755-9232
1814	Arthur ()	New Steel Inc	arthur@newsteelinc.com	402-556-1280 C: 402-541-3716	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	PM	\N	NE	\N	\N	\N	\N	info@newsteelinc.com	402-556-1280 C: 402-541-3716
1815	Structural Fabricators Inc	Structural Fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Lincoln	NE	USA	\N	\N	\N	\N	402-435-3225
1816	Structural Steel Fab Division	Structural Steel Fab Division	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Hastings	NE	USA	\N	\N	\N	\N	402-463-8000
1817	Jack Lederman Co Inc	Jack Lederman Co Inc	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Kearney	NE	USA	\N	\N	\N	\N	(308)237.9995
1818	Rebellion Fabrication	Rebellion Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Wahoo	NE	USA	\N	\N	\N	info@rebellionfabrication.com	402-443-4330
1819	Gerry ()	Specialty Fabricating CO	studio@specialtyfab.biz	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Owner	\N	NE	\N	\N	\N	\N	\N	\N
1820	Moen Steel Erection	Moen Steel Erection	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Omaha	NE	USA	\N	\N	\N	\N	(402) 884-0925
1821	Nebraska welding	Nebraska welding	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	NE	USA	\N	\N	\N	\N	\N
1822	Elemental Fabrication and Machine	Elemental Fabrication and Machine	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	NE	USA	\N	\N	\N	\N	\N
1823	Plymouth Industries	Plymouth Industries	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	NE	USA	\N	\N	\N	\N	402-656-5585
1824	Cloverdale Manufacturing Company, Inc.	Cloverdale Manufacturing Company, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	Omaha	NE	USA	\N	\N	\N	\N	402-571-8824
1825	Marta Janeousek	Shaffer Stevens & Schaap, PC	marta@s3pc.com	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	Structural Specialist	Omaha	NE	USA	\N	\N	\N	\N	(402) 455-7698
1826	Troy's welding & repair	Troy's welding & repair	\N	\N	Steel Detailing	Lead	t	f	2022-09-20 20:06:17	0	\N	2022-09-20 20:06:17	2022-09-20 20:06:17	\N	\N	NE	USA	\N	\N	\N	\N	\N
1827	Ryan Reavis	AAA Steel Fabricators	aaasteelfab@gmail.com	352-601-1142	Steel Detailing	Lead	t	f	2023-02-02 15:54:05	0	\N	2023-02-02 15:54:05	2023-02-02 15:54:05	Project Manager	Deerfield Beach	FL	USA	\N	\N	\N	aaasteelfab@gmail.com	954-570-7211 C: 352-601-1142
1828	Joshua ()	CBR Fabricators & Erectors Inc.	sales@cbrfabricators.com	954-782-4111	Steel Detailing	Lead	t	f	2023-02-08 16:59:17	0	\N	2023-02-08 16:59:17	2023-02-08 16:59:17	Project Manager	Pompano Beach	FL	USA	\N	\N	\N	sales@CBRFabricators.com	954-782-4111
1829	Marisa	CMN Steel Fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2023-02-08 17:02:39	0	\N	2023-02-08 17:02:39	2023-02-08 17:02:39	\N	Miami Gardens	FL	USA	\N	\N	\N	marisa@cmnsteel.com	305-592-5466
1830	Aurelio Sandoval	Doing Steel Fabrication LLC	asandoval@doingsteel.com	\N	Steel Detailing	Lead	t	f	2023-02-09 15:13:58	0	\N	2023-02-09 15:13:58	2023-02-09 15:13:58	Florida Operations	Fort Myers	FL	USA	\N	\N	\N	asandoval@doingsteel.com	239-590-3983
1831	Hector Garza	Universal Structural Steel, Inc.	universalssteel@aol.com	\N	Steel Detailing	Lead	t	f	2023-02-09 16:08:03	0	\N	2023-02-09 16:08:03	2023-02-09 16:08:03	Owner	Sarasota	FL	USA	\N	\N	\N	\N	941-400-7627
1832	Kevin Sigl	Tampa Tank Inc. - Florida Structural Steel	ksigl@precisionbuild.com	813-241-4261 x219	Steel Detailing	Lead	t	f	2023-02-09 16:16:16	0	\N	2023-02-09 16:16:16	2023-02-09 16:16:16	Sales	Gibsonton	\N	USA	\N	\N	\N	mtorro@tti-fss.com	813-241-4261 x291
1833	Tampa Metal Fabricators	Tampa Metal Fabricators	\N	\N	Steel Detailing	Lead	t	f	2023-02-09 16:17:07	0	\N	2023-02-09 16:17:07	2023-02-09 16:17:07	\N	Tampa	FL	USA	\N	\N	\N	\N	813-664-1700
1834	Marty Williams	Suncoast Industries of Florida	mwilliams@suncoastindustries.net	239-936-7887	Steel Detailing	Lead	t	f	2023-02-09 16:18:25	0	\N	2023-02-09 16:18:25	2023-02-09 16:18:25	Detailing Manager	Fort Myers	FL	USA	\N	\N	\N	Mwilliams@suncoastindustries.net	239-936-7887
1835	Sterling Steel & Aluminum Fabrications, Inc.	Sterling Steel & Aluminum Fabrications, Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-02-09 16:19:48	0	\N	2023-02-09 16:19:48	2023-02-09 16:19:48	\N	West Palm Beach	FL	USA	\N	\N	\N	\N	561-366-8600
1836	Bryan Bennett	SSC Metal Fabrication	bbennett@sscafinc.com	561-318-7096	Steel Detailing	Lead	t	f	2023-02-09 16:24:28	0	\N	2023-02-09 16:24:28	2023-02-09 16:24:28	VP	Riviera Beach	FL	USA	\N	\N	\N	info@sscafinc.com, bbennett@sscafinc.com	561-318-7096 C: 561-601-0775
1837	Steven	Fabricated Products of Tampa, Inc.	steven@fabricatedprod.com	8134163776	Steel Detailing	Lead	t	f	2023-02-09 16:31:55	0	\N	2023-02-09 16:31:55	2023-02-09 16:31:55	MainMan	Tampa	FL	USA	\N	\N	\N	Steven@FabricatedProd.com	8132476024
1838	JS Steel Fabricators	JS Steel Fabricators	\N	\N	Steel Detailing	Lead	t	f	2023-02-09 16:42:04	0	\N	2023-02-09 16:42:04	2023-02-09 16:42:04	\N	Plantation	FL	USA	\N	\N	\N	\N	954-578-5155
1839	Frank ()	JUST Steel Inc	estimating@juststeel.net	941-755-7811	Steel Detailing	Lead	t	f	2023-02-09 16:43:16	0	\N	2023-02-09 16:43:16	2023-02-09 16:43:16	\N	Sarasota	FL	USA	\N	\N	\N	estimating@juststeel.net	941-755-7811
1840	Hunter Robinson	Lightning Steel Inc	hunter@lightningsteelinc.com	8139733032	Steel Detailing	Lead	t	f	2023-02-09 16:45:11	0	\N	2023-02-09 16:45:11	2023-02-09 16:45:11	President	Zephyrhills	FL	USA	\N	\N	\N	LightningSteel@AOL.com	813-973-3032
1841	Metal Fabrication & Sales of Tallahassee	Metal Fabrication & Sales of Tallahassee	\N	\N	Steel Detailing	Lead	t	f	2023-02-09 16:47:13	0	\N	2023-02-09 16:47:13	2023-02-09 16:47:13	\N	Tallahassee	FL	USA	\N	\N	\N	Info@MetalFabTallahassee.com	(850) 205-2300
1842	Duane Hartley	Midwest Steel Inc	dhartley@midweststeel.com	(313) 873-2220	Steel Detailing	Lead	t	f	2023-02-09 16:47:54	0	\N	2023-02-09 16:47:54	2023-02-09 16:47:54	GM	Shepherdsville	KY	USA	\N	\N	\N	\N	(313) 873-2220
1843	PRO FAB-TECH inc.	PRO FAB-TECH inc.	\N	\N	Steel Detailing	Lead	t	f	2023-02-09 16:49:06	0	\N	2023-02-09 16:49:06	2023-02-09 16:49:06	\N	Lakeland	FL	USA	\N	\N	\N	\N	863-877-3264
1844	Quality Metal Worx	Quality Metal Worx	\N	\N	Steel Detailing	Lead	t	f	2023-02-09 16:50:25	0	\N	2023-02-09 16:50:25	2023-02-09 16:50:25	\N	Haines City	FL	USA	\N	\N	\N	\N	863-287-8366
1845	Tobey Carter	Quality Steel Fabricators	qsf@verizon.net	813-247-7110	Steel Detailing	Lead	t	f	2023-02-09 16:51:18	0	\N	2023-02-09 16:51:18	2023-02-09 16:51:18	Office Manager	Tampa	FL	USA	\N	\N	\N	qsf@verizon.net	813-247-7110
1846	Drew Smith	Smith Ironworks Engineering, LLC	dsmith@smith-ironworks.com	\N	Steel Detailing	Lead	t	f	2023-02-09 16:52:28	0	\N	2023-02-09 16:52:28	2023-02-09 16:52:28	\N	\N	GA	\N	\N	\N	\N	info@siwfl.com, JC@siwfl.com	\N
1847	Neil ()	Tru Steel Corp	neil@tru-steel.com	772-460-3101 x205	Steel Detailing	Lead	t	f	2023-02-16 05:38:35	0	\N	2023-02-16 05:38:35	2023-02-16 05:38:35	PM	\N	FL	\N	\N	\N	\N	\N	772-460-3101 x205
1848	Nicole Hogan	New Jersey Boom & Erectors, Inc	Nicole@njboom.com	\N	Steel Detailing	Lead	t	f	2023-05-16 17:50:27	0	\N	2023-05-16 17:50:27	2023-05-16 17:50:27	\N	Pocono Pines	PA	USA	\N	\N	\N	Nicole@njboom.com	570-620-1546
1849	Raz Biton	CMS –CUSTOM METAL FABRICATION	\N	\N	Steel Detailing	Lead	t	f	2023-05-18 13:33:51	0	\N	2023-05-18 13:33:51	2023-05-18 13:33:51	\N	South Creek	WA	USA	\N	\N	\N	\N	\N
1850	Bronny Samardzija	Gremp Steel Company	bronny@grempsteel.com	7084891000	Steel Detailing	Lead	t	f	2023-05-18 17:39:23	0	\N	2023-05-18 17:39:23	2023-05-18 17:39:23	\N	Posen	IL	USA	\N	\N	\N	bronny@grempsteel.com	708-489-1000
1851	Doug	Page Steel Inc	doug@pagesteel.com	\N	Steel Detailing	Lead	t	f	2023-05-18 22:38:44	0	\N	2023-05-18 22:38:44	2023-05-18 22:38:44	Detailing Manager	Page	AZ	USA	\N	\N	\N	doug@pagesteel.com	9286458826
1852	Erik Lowe	Vector Custom Fabricating	\N	\N	Steel Detailing	Lead	t	f	2023-05-26 15:23:06	0	\N	2023-05-26 15:23:06	2023-05-26 15:23:06	\N	Bruno	WV	USA	\N	\N	\N	\N	9874587968
1853	Himanshu A. Goyal	A2 Engineering Services P.C	\N	\N	Steel Detailing	Lead	t	f	2023-05-26 20:22:19	0	\N	2023-05-26 20:22:19	2023-05-26 20:22:19	\N	Nelson	WI	USA	\N	\N	\N	\N	630-733-1923
1854	Ehab Girgis	G Plus Engineering Services Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-05-27 15:46:04	0	\N	2023-05-27 15:46:04	2023-05-27 15:46:04	\N	Calgary	Alberta	CANADA	\N	\N	\N	ehab.girgis@gplusengineering.com	4036174801
1855	Greg Schlickman	Steel Fabricating Inc	gschlickman@steelfabrkfd.com	(815) 977-5355	Steel Detailing	Lead	t	f	2023-05-27 16:18:25	0	\N	2023-05-27 16:18:25	2023-05-27 16:18:25	PM	\N	IL	\N	\N	\N	\N	\N	(815) 977-5355
1856	R-B Steel Fabrication Inc	R-B Steel Fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:01:51	0	\N	2023-10-31 13:01:51	2023-10-31 13:01:51	\N	\N	OR	USA	\N	\N	\N	\N	503-829-9227
1857	Doug F Ward	Royal Oak Metal Craft, Inc	\N	\N	Steel Detailing	Lead	t	f	2023-05-29 16:47:00	0	\N	2023-05-29 16:47:00	2023-05-29 16:47:00	\N	\N	WA	USA	\N	\N	\N	doug@royaloakinc.com	503-222-2977
1858	Jesse Beardon	KDM Steelworks, Co.	jesse@kdmsteelworks.com	\N	Steel Detailing	Lead	t	f	2023-05-31 18:46:57	0	\N	2023-05-31 18:46:57	2023-05-31 18:46:57	\N	Loveland	CO	USA	\N	\N	\N	info@kdmsteelworks.com	(970) 663-4000
1859	Justin Sage	Alamo Structural Steel	jsage@alamosteel.com	361-575-4561	Steel Detailing	Lead	t	f	2023-06-01 22:02:46	0	\N	2023-06-01 22:02:46	2023-06-01 22:02:46	MainMan	Waco	TX	USA	\N	\N	\N	\N	254-799-2471
1860	Mario Urquidi	Del Bravo Steel	murquidi@delbravostructures.com	\N	Steel Detailing	Lead	t	f	2023-06-01 22:16:27	0	\N	2023-06-01 22:16:27	2023-06-01 22:16:27	\N	\N	TX	\N	\N	\N	\N	\N	\N
1861	Eric Ducharme	ADF International	eric.ducharme@adfgroup.com	Eric:514-217-0722	Steel Detailing	Lead	t	f	2023-06-01 22:52:29	0	\N	2023-06-01 22:52:29	2023-06-01 22:52:29	MainMan	\N	MT	\N	\N	\N	\N	\N	Eric:514-217-0722
1862	Stephen Johnston	Advantage Steel & Construction	s_johnston@advsteel.com	724-352-4842 C: 412-585-7323	Steel Detailing	Lead	t	f	2023-06-01 23:00:32	0	\N	2023-06-01 23:00:32	2023-06-01 23:00:32	Fab Shop Manager	\N	PA	\N	\N	\N	\N	\N	724-352-4842 C: 412-585-7323
1863	Nick Beebe	Ahlborn Structural Steel, Inc	n.beebe@ahlbornco.com	707-573-0742x114 NickC:707-396-7724	Steel Detailing	Lead	t	f	2023-06-01 23:08:11	0	\N	2023-06-01 23:08:11	2023-06-01 23:08:11	Estimator	Santa Rosa	CA	USA	\N	\N	\N	\N	707-573-0742 NickC:707-396-7724
1864	David Carlson	All Pro Fabrication & Welding	david.allprofabrication@gmail.com	3368807575	Steel Detailing	Lead	t	f	2023-06-01 23:29:57	0	\N	2023-06-01 23:29:57	2023-06-01 23:29:57	\N	\N	NC	USA	\N	\N	\N	allprofabrication.welding@gmail.com	336-880-7575
1865	Dino Pertsalis	Advance Steel Erection Inc.	dino@ase2531.com	\N	Steel Detailing	Lead	t	f	2023-06-02 22:17:47	0	\N	2023-06-02 22:17:47	2023-06-02 22:17:47	\N	\N	IL	\N	\N	\N	\N	\N	8474375376
1866	Dan Patterson	Almet, Inc.	dpatterson@almetinc.com	260) 493-1556	Steel Detailing	Lead	t	f	2023-06-02 22:22:02	0	\N	2023-06-02 22:22:02	2023-06-02 22:22:02	VP of Sales	\N	IN	\N	\N	\N	\N	\N	260) 493-1556
1867	Ralph Prigden x3310	Berlin Steel Construction Company	rpridgen@berlinsteel.com	\N	Steel Detailing	Lead	t	f	2023-06-02 22:50:19	0	\N	2023-06-02 22:50:19	2023-06-02 22:50:19	\N	Glen Burnie	MD	USA	\N	\N	\N	\N	(443) 749-5500
1868	Sterling Herbert	Carpenter & Paterson	sterling.hebert@pipehangers.com	\N	Steel Detailing	Lead	t	f	2023-06-02 23:16:17	0	\N	2023-06-02 23:16:17	2023-06-02 23:16:17	\N	\N	LA	\N	\N	\N	\N	\N	\N
1869	Jake Doherty	Doherty Steel	jake.doherty@dohertysteel.com	913-557-9200	Steel Detailing	Lead	t	f	2023-06-03 01:19:26	0	\N	2023-06-03 01:19:26	2023-06-03 01:19:26	Owner	Paola	KS	USA	\N	\N	\N	\N	913-557-9200
1870	David A	High Plains Steel Services	davida@highplainscompanies.com	(970) 685-3941	Steel Detailing	Lead	t	f	2023-06-03 01:40:11	0	\N	2023-06-03 01:40:11	2023-06-03 01:40:11	\N	\N	CO	\N	\N	\N	\N	\N	(970) 685-3941
1871	Ted Sander	Indiana Bridge, Inc	ted.sander@indianabridge.net	765-288-1985	Steel Detailing	Lead	t	f	2023-06-03 01:47:42	0	\N	2023-06-03 01:47:42	2023-06-03 01:47:42	Estimating Manager	Muncie	IN	USA	\N	\N	\N	\N	765-288-1985
1872	Bion Fite	Lewis Metal Works, Inc	bion.fite@lewismetalworks.com	434-572-3043 PaulC: 434-250-2506	Steel Detailing	Lead	t	f	2023-06-06 01:20:06	0	\N	2023-06-06 01:20:06	2023-06-06 01:20:06	Engineer / PM	\N	VA	\N	\N	\N	\N	\N	434-572-3043 PaulC: 434-250-2506
1873	Mike Bennett	Kansas City Structural Steel	mike.bennett@kcstructural.com	(816) 924-0977	Steel Detailing	Lead	t	f	2023-06-06 01:31:44	0	\N	2023-06-06 01:31:44	2023-06-06 01:31:44	TopDog	\N	MO	\N	\N	\N	\N	\N	(816) 924-0977
1874	Brad Drennen	J.A. McMahon, Inc	brad@jamcmahon.com	3306522588	Steel Detailing	Lead	t	f	2023-06-06 02:16:40	0	\N	2023-06-06 02:16:40	2023-06-06 02:16:40	PM	Niles	OH	USA	\N	\N	\N	\N	3306522588
1875	Jeremy McCarn	LeMar Industries	jeremy.mccarn@lemarindustries.com	515-657-4129 Nick C:608-259-6023	Steel Detailing	Lead	t	f	2023-06-06 02:40:40	0	\N	2023-06-06 02:40:40	2023-06-06 02:40:40	\N	\N	IA	\N	\N	\N	\N	\N	515-657-4129 Nick C:608-259-6023
1876	Dustin Grim	American Steel Fabricators	d_grim@amsteelfab.com	\N	Steel Detailing	Lead	t	f	2023-06-06 22:19:35	0	\N	2023-06-06 22:19:35	2023-06-06 22:19:35	\N	\N	OH	\N	\N	\N	\N	\N	\N
1877	Aerol Peterson	Apollo Steel	aerolp@apollosteel.net	\N	Steel Detailing	Lead	t	f	2023-06-06 22:32:12	0	\N	2023-06-06 22:32:12	2023-06-06 22:32:12	\N	\N	NE	\N	\N	\N	\N	\N	\N
1878	Corey Tompkins	Arrowhead Steel Fabricators	corey.tompkins@chiefind.com	\N	Steel Detailing	Lead	t	f	2023-06-06 22:40:57	0	\N	2023-06-06 22:40:57	2023-06-06 22:40:57	Standards Manager	\N	NE	\N	\N	\N	\N	\N	\N
1879	Patrick Green	Boh Bros Construction Co. LLC	pgreen@bohbros.com	504-821-2400	Steel Detailing	Lead	t	f	2023-06-06 23:33:09	0	\N	2023-06-06 23:33:09	2023-06-06 23:33:09	PM	New Orleans	LA	USA	\N	\N	\N	\N	504-821-2400
1880	Angela Nolan	Briese Iron Works Inc.	anolan@brieseiron.com	507-288-3499	Steel Detailing	Lead	t	f	2023-06-07 01:44:50	0	\N	2023-06-07 01:44:50	2023-06-07 01:44:50	Senior Estimator	Rochester	MN	USA	\N	\N	\N	\N	507-288-3499
1881	Jim Giles	BZI	jamesgiles@bzi.com	4356919381	Steel Detailing	Lead	t	f	2023-06-07 01:49:15	0	\N	2023-06-07 01:49:15	2023-06-07 01:49:15	Detailing Manager	Kanarraville	UT	USA	\N	\N	\N	\N	(888) 509-2280
1882	Stephen Capone	Capone Iron Corporation	s.capone@caponeiron.com	978-948-8000	Steel Detailing	Lead	t	f	2023-06-07 02:09:10	0	\N	2023-06-07 02:09:10	2023-06-07 02:09:10	President	Methuen Town	MA	USA	\N	\N	\N	\N	978-948-8000
1883	Canio Carlucci	Carlucci Welding & Fabrication	canio@carlucciwelding.com	\N	Steel Detailing	Lead	t	f	2023-06-07 02:24:42	0	\N	2023-06-07 02:24:42	2023-06-07 02:24:42	Principal	\N	CT	\N	\N	\N	\N	\N	\N
1884	Robert Kamau	Waiward Industrial	robert.kamau@waiward.com	780-469-1258	Steel Detailing	Lead	t	f	2023-06-08 23:17:31	0	\N	2023-06-08 23:17:31	2023-06-08 23:17:31	Senior Project Manager	EDrafting Manageronton	AL	CANADA	\N	\N	\N	\N	780-469-1258
1885	Gayle Holtz	NORTHERN WELDARC	gayle@northern-weldarc.com	7807200956	Steel Detailing	Lead	t	f	2023-06-08 23:26:03	0	\N	2023-06-08 23:26:03	2023-06-08 23:26:03	\N	Edmonton	Alberta	CANADA	\N	\N	\N	gayle@northern-weldarc.com	780.467.1522
1886	Omar El Kaakour	Linmark Steel	omar@linmarksteel.com	4039185825	Steel Detailing	Lead	t	f	2023-06-09 13:31:17	0	\N	2023-06-09 13:31:17	2023-06-09 13:31:17	\N	Calgary	Alberta	CANADA	\N	\N	\N	omar@linmarksteel.com	+1 403 875 4396
1887	Steve Grandfield	Prospect Steel a Division of Lexicon, Inc.	steveg@lexicon-inc.com	\N	Steel Detailing	Lead	t	f	2023-06-12 22:10:40	0	\N	2023-06-12 22:10:40	2023-06-12 22:10:40	Chief Operating Officer	Little Rock	AR	USA	\N	\N	\N	\N	501-490-4200
1888	Frank Hertel	Rens Welding & Fabricating Inc	frank@renswelding.com	\N	Steel Detailing	Lead	t	f	2023-06-12 22:15:18	0	\N	2023-06-12 22:15:18	2023-06-12 22:15:18	COO	Taunton	MA	USA	\N	\N	\N	\N	(508) 828-1702
1889	Robert Gennett	Schenectady Steel Company	rgennett@schenectadysteel.com	\N	Steel Detailing	Lead	t	f	2023-06-12 22:17:29	0	\N	2023-06-12 22:17:29	2023-06-12 22:17:29	\N	\N	NY	\N	\N	\N	\N	\N	\N
1890	Deb Sweigart	Shickel Corporation	\N	\N	Steel Detailing	Lead	t	f	2023-06-12 22:54:47	0	\N	2023-06-12 22:54:47	2023-06-12 22:54:47	\N	Bridgewater	VA	USA	\N	\N	\N	\N	540-828-2536
1891	Michelle Jenkins	Southern New Jersey Steel Co	m.jenkins@snjs.org	(856) 696-1612	Steel Detailing	Lead	t	f	2023-06-14 22:53:51	0	\N	2023-06-14 22:53:51	2023-06-14 22:53:51	MainWoman	\N	NJ	\N	\N	\N	\N	\N	(856) 696-1612 C:(610) 322-6038
1892	Curt Curey	Jorgensen Steel Machining and Fabrication	ccurey@jorgensen-usa.com	\N	Steel Detailing	Lead	t	f	2023-06-14 23:58:01	0	\N	2023-06-14 23:58:01	2023-06-14 23:58:01	\N	Tekonsha	MI	USA	\N	\N	\N	\N	(517) 767-4600
1893	Rodney Crowley	Stupp Bros	rdcrowley@stupp.com	Direct: 314-544-7522	Steel Detailing	Lead	t	f	2023-06-15 01:03:00	0	\N	2023-06-15 01:03:00	2023-06-15 01:03:00	VP Engineering	\N	MO	\N	\N	\N	\N	\N	Direct: 314-544-7522
1894	BJ ()	Stone Bridge Iron & Steel	bj@stonebridgeiron.com	(518) 695-3752	Steel Detailing	Lead	t	f	2023-06-15 01:13:12	0	\N	2023-06-15 01:13:12	2023-06-15 01:13:12	\N	\N	NY	\N	\N	\N	\N	\N	(518) 695-3752
1895	Fred Wilson	Industrial Steel LLC	fwilson@industrial-steel.com	321-267-2341	Steel Detailing	Lead	t	f	2023-06-15 13:05:57	0	\N	2023-06-15 13:05:57	2023-06-15 13:05:57	President & Owner	Mims	\N	USA	\N	\N	\N	fwilson@industrial-steel.com	321-267-2341
1896	Tom Graef	Martin's Steel Works	tom.graef@martinssteelworks.com	(707) 678-6120	Steel Detailing	Lead	t	f	2023-06-17 11:07:47	0	\N	2023-06-17 11:07:47	2023-06-17 11:07:47	GM	\N	CA	\N	\N	\N	\N	tom.graef@martinssteelworks.com	(707) 678-6120
1897	Daniel ()	Copper Mountain Construction	copper.mnt.construction@gmail.com	\N	Steel Detailing	Lead	t	f	2023-06-21 21:56:41	0	\N	2023-06-21 21:56:41	2023-06-21 21:56:41	\N	\N	MT	\N	\N	\N	\N	copper.mnt.construction@gmail.com	\N
1898	Tony Bagatourian	Rocky Point Iron Inc.	tony@rockypointiron.com	8186245648	Steel Detailing	Lead	t	f	2023-06-28 22:49:01	0	\N	2023-06-28 22:49:01	2023-06-28 22:49:01	\N	Riverside	CA	USA	\N	\N	\N	armen@rockypointiron.com	951-520-2640
1899	Gregg Kobe	XL Industrial Services Inc	\N	\N	Steel Detailing	Lead	t	f	2023-07-19 00:55:51	0	\N	2023-07-19 00:55:51	2023-07-19 00:55:51	\N	La Porte	IN	USA	\N	\N	\N	gkobe@xlindustrial.net	219-362-8005
1900	Jeremy Long	ISM INDUSTRIES	jlong@ismfab.com	4097697841 C:9405771602	Steel Detailing	Lead	t	f	2023-07-26 21:24:32	0	\N	2023-07-26 21:24:32	2023-07-26 21:24:32	MainMan	\N	TX	\N	\N	\N	\N	jlong@ismfab.com	4097697841 C:9405771602
1901	Mary-Jo Ellis	RIVERSIDE IRON	mjellis@riversideiw.com	3155354864	Steel Detailing	Lead	t	f	2023-08-11 13:41:52	0	\N	2023-08-11 13:41:52	2023-08-11 13:41:52	\N	Gouverneur	NY	USA	\N	\N	\N	mjellis@riversideiw.com	315-535-4864
1902	Jim Bell	Bell Bros	jim@bellbrossteel.com	(951)784-0903	Steel Detailing	Lead	t	f	2023-08-16 23:42:01	0	\N	2023-08-16 23:42:01	2023-08-16 23:42:01	President	\N	CA	\N	\N	\N	\N	jim@bellbrossteel.com	(951)784-0903
1903	David Ross Blurton	SIMMCO II, LLC	\N	\N	Steel Detailing	Lead	t	f	2023-08-17 22:32:16	0	\N	2023-08-17 22:32:16	2023-08-17 22:32:16	\N	Brownsville	TN	USA	\N	\N	\N	dblurtonjr@blurtongroup.com	7317722333
1904	Skyler Whan	Lowder Steel	swhan@lowdersteel.net	336-431-9000 x32	Steel Detailing	Lead	t	f	2023-08-23 22:04:07	0	\N	2023-08-23 22:04:07	2023-08-23 22:04:07	Chief Estimator	Archdale	\N	USA	\N	\N	\N	estimating@lowdersteel.net	336-431-9000 x32 C:336-451-1841
1905	Eric Hansen	Fisher Metal Products	fmpi@att.net	\N	Steel Detailing	Lead	t	f	2023-10-19 17:07:54	0	\N	2023-10-19 17:07:54	2023-10-19 17:07:54	\N	\N	CA	USA	\N	\N	\N	fmpi@att.net	(559) 732-4973
1906	Damon Johnson	Steelhead Metal & Fab, LLC	damonj@steelheadmetal.net	5039322546	Steel Detailing	Lead	t	f	2023-09-26 22:03:12	0	\N	2023-09-26 22:03:12	2023-09-26 22:03:12	\N	Salem	OR	USA	\N	\N	\N	\N	+1 503-763-0114
1907	Grant ()	Davison Iron Works	grant@davisoniron.com	(916)381-2121	Steel Detailing	Lead	t	f	2023-10-19 12:31:53	0	\N	2023-10-19 12:31:53	2023-10-19 12:31:53	MainMan	\N	CA	\N	\N	\N	\N	grant@davisoniron.com	(916)381-2121
1908	Jesus Momdragon	South Bay Steel Erectors	jesus.mondragon@southbaysteel.com	310-817-4173	Steel Detailing	Lead	t	f	2023-10-19 15:09:08	0	\N	2023-10-19 15:09:08	2023-10-19 15:09:08	PM	\N	CA	\N	\N	\N	\N	\N	310-817-4173
1909	Elba ()	JEM Steel	elba@jemiron.com	(714) 630-0499	Steel Detailing	Lead	t	f	2023-10-19 15:16:26	0	\N	2023-10-19 15:16:26	2023-10-19 15:16:26	PM	\N	CA	\N	\N	\N	\N	\N	(714) 630-0499
1910	Dave ()	Phillips Steel	dbrayton@phillipssteel.com	\N	Steel Detailing	Lead	t	f	2023-10-19 15:39:13	0	\N	2023-10-19 15:39:13	2023-10-19 15:39:13	Estimator	\N	CA	\N	\N	\N	\N	\N	\N
1911	Justin, Sean Moore	Steel Builders Inc (1973#)	\N	\N	Steel Detailing	Lead	t	f	2023-10-19 15:41:42	0	\N	2023-10-19 15:41:42	2023-10-19 15:41:42	Nice guy/Owner	Gardena	CA	USA	\N	\N	\N	sean@steelbuildersinc.com	(310)225-5793
1912	Tommy Tucker	Young's Iron Works Inc.	tommy@yiw.biz	(818)768-3877 x105(Thomas) x102(Frank)	Steel Detailing	Lead	t	f	2023-10-19 15:49:46	0	\N	2023-10-19 15:49:46	2023-10-19 15:49:46	President	\N	CA	\N	\N	\N	\N	\N	(818)768-3877 x105(Thomas) x102(Frank)
1913	REMO Steel	REMO Steel	\N	\N	Steel Detailing	Lead	t	f	2023-10-19 15:52:34	0	\N	2023-10-19 15:52:34	2023-10-19 15:52:34	\N	undefined	CA	USA	\N	\N	\N	\N	(714) 639-9380
1914	Jesse Leal	BAPKO Metals	jleal@bapko.com	(714) 639-9380	Steel Detailing	Lead	t	f	2023-10-19 15:57:18	0	\N	2023-10-19 15:57:18	2023-10-19 15:57:18	Detailing Manager	\N	CA	\N	\N	\N	\N	\N	(714) 639-9380
1915	JMI Steel	JMI Steel	\N	\N	Steel Detailing	Lead	t	f	2023-10-19 15:59:31	0	\N	2023-10-19 15:59:31	2023-10-19 15:59:31	\N	undefined	CA	USA	\N	\N	\N	\N	\N
1916	Gevorg Sargsyan	Structural Steel Fabrication & Ornamental Iron Work	info@cabdinc.com	C: (323)855-8276, O:(323)447-8335	Steel Detailing	Lead	t	f	2023-10-19 16:01:04	0	\N	2023-10-19 16:01:04	2023-10-19 16:01:04	Owner	\N	CA	\N	\N	\N	\N	info@cabdinc.com	C: (323)855-8276, O:(323)447-8335
1917	Steven Hwang	Reds Iron	steven@redsiron.com	(661)799-9615	Steel Detailing	Lead	t	f	2023-10-19 16:04:40	0	\N	2023-10-19 16:04:40	2023-10-19 16:04:40	Detailer	\N	CA	\N	\N	\N	\N	\N	(661)799-9615
1918	Henry Mora	Skyline Fabrication	h.mora@skylinefabrication.com	(310)763-0616, (310)651-0607	Steel Detailing	Lead	t	f	2023-10-19 16:08:05	0	\N	2023-10-19 16:08:05	2023-10-19 16:08:05	MainMan	\N	CA	\N	\N	\N	\N	c.gibeault@skylinefabrication.com	(310)763-0616, (310)651-0607
1919	John Oh	CK Steel	john@cksteel.com	O:(310)638-0855, C:(213)598-1210	Steel Detailing	Lead	t	f	2023-10-19 16:11:57	0	\N	2023-10-19 16:11:57	2023-10-19 16:11:57	PM	\N	CA	\N	\N	\N	\N	john@cksteel.com	O:(310)638-0855, C:(213)598-1210
1920	Mike Owens	Shoreline Constructors	mikeo@shorelinemetal.com	(805)642-9922	Steel Detailing	Lead	t	f	2023-10-19 16:36:24	0	\N	2023-10-19 16:36:24	2023-10-19 16:36:24	President	\N	CA	\N	\N	\N	\N	\N	(805)642-9922
1921	Arturo Alonso	Suburban Pipe & Steel	aalonso@flintsteelinc.com	C:559-750-5830, O:559-734-6547	Steel Detailing	Lead	t	f	2023-10-19 16:49:36	0	\N	2023-10-19 16:49:36	2023-10-19 16:49:36	Detailier	\N	CA	\N	\N	\N	\N	\N	C:559-750-5830, O:559-734-6547
1922	Jimmie Chapa	Aggressive Welding Services	\N	\N	Steel Detailing	Lead	t	f	2023-10-19 16:50:04	0	\N	2023-10-19 16:50:04	2023-10-19 16:50:04	Owner	Modesto	CA	USA	\N	\N	\N	AWSModesto@SBCGlobal.net	(209)491-2109
1923	Kevin Irish	California Steel Fabricators	\N	(209)566-0629, (209)648-5138	Steel Detailing	Lead	t	f	2023-10-19 16:54:11	0	\N	2023-10-19 16:54:11	2023-10-19 16:54:11	MainMan	\N	CA	\N	\N	\N	\N	\N	(209)566-0629, (209)648-5138
1924	Steve Bradford	Bradford Steel	bradfordsteelconstruction@sbcglobal.net	(559)564-1990, C:(559)280-2341	Steel Detailing	Lead	t	f	2023-10-19 16:54:33	0	\N	2023-10-19 16:54:33	2023-10-19 16:54:33	Owner	\N	CA	\N	\N	\N	\N	bradfordsteelconstruction@sbcglobal.net	(559)564-1990, C:(559)280-2341
1925	Dave Strouss	Strouss Brothers Construction	dave@stroussbrothers.com	(408)267-3222(408) 438-7792,408)438-7794	Steel Detailing	Lead	t	f	2023-10-19 17:08:54	0	\N	2023-10-19 17:08:54	2023-10-19 17:08:54	Owner	\N	CA	\N	\N	\N	\N	bill@stroussbrothers.com, dave@stroussbrothers.com	(408)267-3222(408) 438-7792,408)438-7794
1926	D.O. (no solicitation)	Roadway Steel & Fabrication	\N	\N	Steel Detailing	Lead	t	f	2023-10-19 17:12:16	0	\N	2023-10-19 17:12:16	2023-10-19 17:12:16	\N	El Dorado Hills	CA	USA	\N	\N	\N	\N	(408)295-
1927	Rick Mancias	Mancias Steel	rmancias@manciassteel.com	(408)295-5096	Steel Detailing	Lead	t	f	2023-10-19 17:14:31	0	\N	2023-10-19 17:14:31	2023-10-19 17:14:31	Owner	\N	CA	\N	\N	\N	\N	Rmancias@manciassteel.com	(408)295-5096
1928	Wayne ()	F&F Steel & Stairway	waynewolski@yahoo.com	408-279-6558	Steel Detailing	Lead	t	f	2023-10-19 17:17:28	0	\N	2023-10-19 17:17:28	2023-10-19 17:17:28	Owner	San Jose	CA	USA	\N	\N	\N	waynewolski@yahoo.com, yvette.fandfsteel@gmail.com	408-279-6558
1929	Aaron Newman	Newman Steel	aaron@newmansteel.com	(408)761-7339	Steel Detailing	Lead	t	f	2023-10-19 17:21:16	0	\N	2023-10-19 17:21:16	2023-10-19 17:21:16	VP	\N	CA	\N	\N	\N	\N	aaron@newmansteel.com	(408)761-7339
1930	Rick Freschet	Ironstone Metal Works	office@ironstonemetalworks.com	O:(650)594-0978, C:(650)207-4940	Steel Detailing	Lead	t	f	2023-10-19 17:29:32	0	\N	2023-10-19 17:29:32	2023-10-19 17:29:32	Owner	\N	CA	\N	\N	\N	\N	office@ironstonemetalworks.com	O:(650)594-0978, C:(650)207-4940
1931	ProjectManagement ()	West Cork Welding Inc	info@westcorkwelding.com	415-377-1948, 415-671-0994	Steel Detailing	Lead	t	f	2023-10-19 17:46:05	0	\N	2023-10-19 17:46:05	2023-10-19 17:46:05	Estimator	\N	CA	\N	\N	\N	\N	info@westcorkwelding.com	415-377-1948, 415-671-0994
1932	Kane Structural Steel	Kane Structural Steel	\N	\N	Steel Detailing	Lead	t	f	2023-10-19 17:48:20	0	\N	2023-10-19 17:48:20	2023-10-19 17:48:20	\N	\N	CA	USA	\N	\N	\N	\N	\N
1933	Kent ()	J.C. Metal Specialists	kent@jcmetals.com	(415)822-3878, (650)827-1618	Steel Detailing	Lead	t	f	2023-10-19 17:50:29	0	\N	2023-10-19 17:50:29	2023-10-19 17:50:29	PM	\N	CA	\N	\N	\N	\N	info@jcmetals.com, kent@jcmetals.com, edwin@jcmetals.com	(415)822-3878, (650)827-1618
1934	Jeff Kersten	Golden State Steel & Stairway	\N	(510)412-3399	Steel Detailing	Lead	t	f	2023-10-19 17:55:16	0	\N	2023-10-19 17:55:16	2023-10-19 17:55:16	Production Manager	\N	CA	\N	\N	\N	\N	\N	(510)412-3399
1935	Berj Kassab	G.K. Welding Inc	berj@gkwelding.com	(510)233-0133	Steel Detailing	Lead	t	f	2023-10-19 18:00:30	0	\N	2023-10-19 18:00:30	2023-10-19 18:00:30	PM	\N	CA	\N	\N	\N	\N	george.alajaji@gkwelding.com	(510)233-0133
1936	Aaron Moynihan	Tri Star Metals	aaron@tsmfab.com	(707)678-1140x104	Steel Detailing	Lead	t	f	2023-10-19 18:42:42	0	\N	2023-10-19 18:42:42	2023-10-19 18:42:42	Draftsmen	\N	CA	\N	\N	\N	\N	\N	(707)678-1140x104
1937	Scott Duncan	Viking Steel	s.duncan@vikingsteel.net	O:(916)379-0210 x107, C:(925)260-3802	Steel Detailing	Lead	t	f	2023-10-19 18:48:02	0	\N	2023-10-19 18:48:02	2023-10-19 18:48:02	President	\N	CA	\N	\N	\N	\N	\N	O:(916)379-0210 x107, C:(925)260-3802
1938	Jason Erickson	Baker-Rullman Manufacturing	jason@baker-rullman.com	(920) 261-8107	Steel Detailing	Lead	t	f	2023-10-20 12:26:25	0	\N	2023-10-20 12:26:25	2023-10-20 12:26:25	Sr PM	\N	WI	\N	\N	\N	\N	\N	(920) 261-8107
1939	Matthew Prodehl	Ralph H Simpson	mprodehl@ralphsimpsonco.com	O:(630)333-4587, C:(630)501-5817	Steel Detailing	Lead	t	f	2023-10-20 12:56:12	0	\N	2023-10-20 12:56:12	2023-10-20 12:56:12	PM	\N	IL	\N	\N	\N	\N	mprodehl@ralphsimpsonco.com	O:(630)333-4587, C:(630)501-5817
1940	Composite Steel Products Inc	Composite Steel Products Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-20 13:03:11	0	\N	2023-10-20 13:03:11	2023-10-20 13:03:11	\N	undefined	IL	USA	\N	\N	\N	\N	708-344-9010
1941	Dann Jochum	G2 Construction Group	\N	\N	Steel Detailing	Lead	t	f	2023-10-20 13:07:40	0	\N	2023-10-20 13:07:40	2023-10-20 13:07:40	\N	undefined	IL	USA	\N	\N	\N	\N	630-649-2485
1942	Aj Fadli ()	N.A.R. Unlimited Metal Fabrication, LLC	a.fadli@narsteel.com	615-601-5619	Steel Detailing	Lead	t	f	2023-10-20 13:41:49	0	\N	2023-10-20 13:41:49	2023-10-20 13:41:49	Vice President	Nashville	TN	USA	\N	\N	\N	a.fadli@narsteel.com	615-601-5619
1943	Kristin Purvis	Specialty Fabricating & Welding	kristin@specialtyfabricationinc.com	352-669-9353	Steel Detailing	Lead	t	f	2023-10-22 20:46:00	0	\N	2023-10-22 20:46:00	2023-10-22 20:46:00	\N	\N	FL	\N	\N	\N	\N	\N	352-669-9353
1944	Dalip Prasad	Whitemud Ironworks Limited	dprasad@wiworks.ca	780-465-5888	Steel Detailing	Lead	t	f	2023-10-22 20:51:28	0	\N	2023-10-22 20:51:28	2023-10-22 20:51:28	Senior Estimator	\N	\N	CANADA	\N	\N	\N	\N	780-465-5888
1945	Florida Fabrication Inc	Florida Fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-22 20:52:24	0	\N	2023-10-22 20:52:24	2023-10-22 20:52:24	\N	undefined	FL	USA	\N	\N	\N	\N	\N
1946	CATO Steel	CATO Steel	\N	\N	Steel Detailing	Lead	t	f	2023-10-22 20:54:17	0	\N	2023-10-22 20:54:17	2023-10-22 20:54:17	\N	undefined	FL	USA	\N	\N	\N	\N	\N
1947	Rob Cochrane	Ecosse Welding	rob@ecossewelding.com	403-237-9922	Steel Detailing	Lead	t	f	2023-10-23 13:57:44	0	\N	2023-10-23 13:57:44	2023-10-23 13:57:44	Director	Calgary	AL	CANADA	\N	\N	\N	rob@ecossewelding.com	403-237-9922
1948	Darryl	Whitemud Ironworks Limited	\N	\N	Steel Detailing	Lead	t	f	2023-10-23 14:02:59	0	\N	2023-10-23 14:02:59	2023-10-23 14:02:59	\N	undefined	undefined	CANADA	\N	\N	\N	headoffice@WIIronworks.ca	780-465-5888
1949	Denis Cathers	Niik Steel	denis@niiksteel.com	250-591-7400	Steel Detailing	Lead	t	f	2023-10-23 14:09:57	0	\N	2023-10-23 14:09:57	2023-10-23 14:09:57	Detailing Manager	\N	\N	CANADA	\N	\N	\N	info@niiksteel.com	250-591-7400
1950	Yasmin Afanador Ortiz	MacDougall Steel Erectors Inc.	rfq@mseinc.ca	9028552100	Steel Detailing	Lead	t	f	2023-10-23 14:16:31	0	\N	2023-10-23 14:16:31	2023-10-23 14:16:31	Estimating Coordinator	Charlottetown	Prince Edward Island	CANADA	\N	\N	\N	rfq@mseinc.ca	902-855-2100
1951	David Kurilko	Cleveland Construction Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-23 14:23:28	0	\N	2023-10-23 14:23:28	2023-10-23 14:23:28	\N	Naples	FL	USA	\N	\N	\N	\N	239-643-8000
1952	Ephraim Bennet	Patriot Erectors LLC	BennettE@PatriotErectors.com	\N	Steel Detailing	Lead	t	f	2023-10-23 14:25:14	0	\N	2023-10-23 14:25:14	2023-10-23 14:25:14	Detailing Manager	Dripping Springs	TX	USA	\N	\N	\N	mark@patrioterectors.com	(512) 858-9100
1953	Diego	K & K Irons works	\N	\N	Steel Detailing	Lead	t	f	2023-10-23 14:28:25	0	\N	2023-10-23 14:28:25	2023-10-23 14:28:25	\N	undefined	undefined	USA	\N	\N	\N	Dpenafiel@KKIronworks.com	(708) 924-0000 x 7521
1954	Jenna Shoemaker	Solid Form Fabrication	jenna@teamsolidform.com	503-435-1400	Steel Detailing	Lead	t	f	2023-10-24 12:26:25	0	\N	2023-10-24 12:26:25	2023-10-24 12:26:25	MainWoman	McMinnville	OR	USA	\N	\N	\N	info@teamsolidform.com,	503-435-1400
1955	Landon Kinion	Newberg Steel & Fabrication	landon@newbergsteel.com	503-538-1044	Steel Detailing	Lead	t	f	2023-10-24 12:33:27	0	\N	2023-10-24 12:33:27	2023-10-24 12:33:27	Project Manager	Newberg	OR	USA	\N	\N	\N	landon@newbergsteel.com	503-538-1044
1956	Hans Bauer	T-Plus Steel Fabricators	hans@tplussteel.com	5419280551	Steel Detailing	Lead	t	f	2023-10-24 12:36:22	0	\N	2023-10-24 12:36:22	2023-10-24 12:36:22	Project Manager	Millersburg	OR	USA	\N	\N	\N	brian@tplussteel.com	541-928-0551 x202
1957	Jake Peterson	Mid Valley Metal Works	jake@mvmw.com	503-371-7366	Steel Detailing	Lead	t	f	2023-10-24 12:38:31	0	\N	2023-10-24 12:38:31	2023-10-24 12:38:31	Project Manager	Salem	OR	USA	\N	\N	\N	\N	503-371-7366
1958	Ryan Allen	Greenberry Industrial	ryan.allen@greenberry.com	541-757-8458 x1407	Steel Detailing	Lead	t	f	2023-10-24 12:38:58	0	\N	2023-10-24 12:38:58	2023-10-24 12:38:58	MainMan	Corvallis	\N	USA	\N	\N	\N	Brent.Delahunt@greenberry.com	541-757-8458 x1401
1959	Gary Frayn	Schuff Steel	\N	\N	Steel Detailing	Lead	t	f	2023-10-24 12:42:21	0	\N	2023-10-24 12:42:21	2023-10-24 12:42:21	VP Business Development	Portland	OR	USA	\N	\N	\N	gary.frayn@schuff.com	503-743-7091
1960	Patrick Klossen	Advanced Tower Components	pklossen@advancedtowercomponents.com	503-540-0777	Steel Detailing	Lead	t	f	2023-10-24 12:43:02	0	\N	2023-10-24 12:43:02	2023-10-24 12:43:02	Project Manager	Salem	OR	USA	\N	\N	\N	SUPPORT@ADVANCEDTOWERCOMPONENTS.COM	503-540-0777
1961	Tom Dreyer	Madlyn Fab	Tom.Dreyer@madlynfab.com	\N	Steel Detailing	Lead	t	f	2023-10-24 12:44:43	0	\N	2023-10-24 12:44:43	2023-10-24 12:44:43	PM	Washougal	WA	USA	\N	\N	\N	\N	360-693-1019/206
1962	Chris Washburn	Valley Fab	chris@valleyfabcorp.com	971-239-4717	Steel Detailing	Lead	t	f	2023-10-24 12:52:14	0	\N	2023-10-24 12:52:14	2023-10-24 12:52:14	PM	Brooks	\N	USA	\N	\N	\N	\N	971-239-4717
1963	Pat Kiely	Red Dog Fabrication	patk@reddogfab.com	360-892-3647 x2002	Steel Detailing	Lead	t	f	2023-10-24 12:52:50	0	\N	2023-10-24 12:52:50	2023-10-24 12:52:50	Owner	Vancouver	WA	USA	\N	\N	\N	\N	360-892-3647 x2002
1964	Robin Howser	Howser Steel	robin@howsersteel.com	503-289-9328	Steel Detailing	Lead	t	f	2023-10-24 12:57:49	0	\N	2023-10-24 12:57:49	2023-10-24 12:57:49	Owner	Portland	OR	USA	\N	\N	\N	\N	503-289-9328
1965	Fawn Hubbard	A2 Fabrication	admin@a2fab.com	5037712000	Steel Detailing	Lead	t	f	2023-10-24 13:07:14	0	\N	2023-10-24 13:07:14	2023-10-24 13:07:14	Admin	Milwaukie	OR	USA	\N	\N	\N	admin@a2fab.com	503-771-2000
1966	Kevin Harper	Boykin Steel	kevin@boykinsteel.com	912-427-7751	Steel Detailing	Lead	t	f	2023-10-24 13:21:36	0	\N	2023-10-24 13:21:36	2023-10-24 13:21:36	MainMan	Jessup	GA	USA	\N	\N	\N	\N	912-427-7751
1967	Sable Taylor	Omega Steel	staylor@omegasteelinc.com	912-748-6668	Steel Detailing	Lead	t	f	2023-10-24 13:47:48	0	\N	2023-10-24 13:47:48	2023-10-24 13:47:48	PM	Bloomingdale	GA	USA	\N	\N	\N	\N	912-748-6668
1968	David Williamson	Williamson Welding	david@williamsonwelding.com	843-559-2555	Steel Detailing	Lead	t	f	2023-10-24 13:53:53	0	\N	2023-10-24 13:53:53	2023-10-24 13:53:53	\N	Johnsonville	SC	USA	\N	\N	\N	\N	O: 843-559-2555 C: 843-297-0328
1969	Paul Trawnik	Steel Details, Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-10-24 13:58:23	0	\N	2023-10-24 13:58:23	2023-10-24 13:58:23	CEO	Upland	CA	USA	\N	\N	\N	paul@steeldetailsinc.com	909-920-1910
1970	American Sheet Metal	American Sheet Metal	\N	\N	Steel Detailing	Lead	t	f	2023-10-24 13:59:42	0	\N	2023-10-24 13:59:42	2023-10-24 13:59:42	\N	Anaheim	CA	USA	\N	\N	\N	sales@asmsheetmetal.com	(714) 780-0155
1971	CBC Steel Buildings	CBC Steel Buildings	\N	\N	Steel Detailing	Lead	t	f	2023-10-24 14:00:33	0	\N	2023-10-24 14:00:33	2023-10-24 14:00:33	\N	Lathrop	CA	USA	\N	\N	\N	cbc.info@cbcsteelbuildings.com	209-983-0910
1972	J.C. Elliott	Accelerated Construction Metal Fabrication	\N	\N	Steel Detailing	Lead	t	f	2023-10-24 14:01:50	0	\N	2023-10-24 14:01:50	2023-10-24 14:01:50	\N	Turlock	CA	USA	\N	\N	\N	JCElliott@accelmetal.com	209.846.7998
1973	Jimmy Chapa	AGGRESSIVE WELDING SERVICES, INC	awsmodesto@sbcglobal.net	209-491-2109	Steel Detailing	Lead	t	f	2023-10-24 14:03:33	0	\N	2023-10-24 14:03:33	2023-10-24 14:03:33	\N	Modesto	CA	USA	\N	\N	\N	AWSModesto@SBCGlobal.net	209-491-2109
1974	Amanda Meyer	Palmetto Welding Fabrication Services	amanda@palmettoweldingandfabrication.com	843-518-7453 Michael: 940-902-3091	Steel Detailing	Lead	t	f	2023-10-24 14:04:30	0	\N	2023-10-24 14:04:30	2023-10-24 14:04:30	Wife	North Charleston	SC	USA	\N	\N	\N	\N	843-518-7453 Michael: 940-902-3091
1975	Nick	ANCO IRON & CONSTRUCTION INC	\N	\N	Steel Detailing	Lead	t	f	2023-10-24 14:05:08	0	\N	2023-10-24 14:05:08	2023-10-24 14:05:08	\N	South San Francisco	CA	USA	\N	\N	\N	Ncolina@ANCOIron.com	415.822.3931
1976	California Steel Fabrications	California Steel Fabrications	\N	\N	Steel Detailing	Lead	t	f	2023-10-24 14:07:00	0	\N	2023-10-24 14:07:00	2023-10-24 14:07:00	\N	Modesto	CA	USA	\N	\N	\N	\N	209-566-0629
1977	Benjamin Evans	Evans-Medlin Steel	benjamin@evans-medlin.com	803-917-9594	Steel Detailing	Lead	t	f	2023-10-24 15:52:08	0	\N	2023-10-24 15:52:08	2023-10-24 15:52:08	Owner	\N	SC	\N	\N	\N	\N	\N	803-917-9594
1978	Debbie Evans	Carolina Fab Inc	devans@carolinafabinc.com	704-860-3417	Steel Detailing	Lead	t	f	2023-10-24 16:03:57	0	\N	2023-10-24 16:03:57	2023-10-24 16:03:57	Mother	Mount Holly	NC	USA	\N	\N	\N	\N	704-860-3417
1979	Suzanna Brown	Phillips Iron Works	suzanna@phillipsiw.com	919-615-1570	Steel Detailing	Lead	t	f	2023-10-24 16:42:26	0	\N	2023-10-24 16:42:26	2023-10-24 16:42:26	Office Manager	Raleigh	\N	USA	\N	\N	\N	\N	919-615-1570
1980	Unifab Industries	Unifab Industries	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:55:33	0	\N	2023-10-25 11:55:33	2023-10-25 11:55:33	\N	undefined	CA	USA	\N	\N	\N	\N	408-945-9733
1981	Dorothy Cousins	Structural Steel Products Corp	info@thehalesgroup.net	919-553-3034	Steel Detailing	Lead	t	f	2023-10-24 16:46:57	0	\N	2023-10-24 16:46:57	2023-10-24 16:46:57	Receptionist	Clayton	NC	USA	\N	\N	\N	info@thehalesgroup.net	919-553-3034
1982	Nick Barrow	Griffin Steel & Supply	nbarrow@griffinsteel.com	919-735-3284	Steel Detailing	Lead	t	f	2023-10-24 16:51:32	0	\N	2023-10-24 16:51:32	2023-10-24 16:51:32	Project Manager	Goldsboro	\N	USA	\N	\N	\N	\N	919-735-3284
1983	John Swodeck	Sonoran Steelworks	\N	\N	Steel Detailing	Lead	t	f	2023-10-24 18:17:16	0	\N	2023-10-24 18:17:16	2023-10-24 18:17:16	Owner	Apache Junction	AZ	USA	\N	\N	\N	\N	(602) 391-5646
1984	DRYCO CONSTRUCTION, INC	DRYCO CONSTRUCTION, INC	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:38:23	0	\N	2023-10-25 11:38:23	2023-10-25 11:38:23	\N	Fremont	CA	USA	\N	\N	\N	info@DRYCO.com	800-378-2177
1985	Wayne	F&F Steel & Stairways	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:39:46	0	\N	2023-10-25 11:39:46	2023-10-25 11:39:46	Owner	San Jose	CA	USA	\N	\N	\N	FandFSteel@gmail.com	408-279-6558
1986	Eric Hansen	Fisher Metal Products, Inc	fmpi@att.net	559-732-4973	Steel Detailing	Lead	t	f	2023-10-25 11:40:56	0	\N	2023-10-25 11:40:56	2023-10-25 11:40:56	\N	Visalia	CA	USA	\N	\N	\N	\N	559-732-4973
1987	Art Phelps	Fitted by design inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:41:54	0	\N	2023-10-25 11:41:54	2023-10-25 11:41:54	\N	Oakdale	CA	USA	\N	\N	\N	FittedByDesign@Gmail.com	(209) 847-5770
1988	Flores Steel	Flores Steel	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:43:18	0	\N	2023-10-25 11:43:18	2023-10-25 11:43:18	\N	Hemet	CA	USA	\N	\N	\N	\N	951-929-0700
1989	Dylan Hodges	3 Sons Steel Inc	dylan@3sons-steel.com	252-823-3766	Steel Detailing	Lead	t	f	2023-10-25 11:45:39	0	\N	2023-10-25 11:45:39	2023-10-25 11:45:39	Son	Tarboro	NC	USA	\N	\N	\N	\N	252-823-3766
1990	Todd Harris	Harris Metal Works, Inc	harrismetalworks@sbcglobal.net	530.209.5279 , 530.209.2312	Steel Detailing	Lead	t	f	2023-10-25 11:49:24	0	\N	2023-10-25 11:49:24	2023-10-25 11:49:24	\N	\N	CA	\N	\N	\N	\N	\N	530.209.5279 , 530.209.2312
1991	JXR CONSTRUCTORS, INC	JXR CONSTRUCTORS, INC	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:50:03	0	\N	2023-10-25 11:50:03	2023-10-25 11:50:03	\N	San Diego	CA	USA	\N	\N	\N	info@jxrconstructors.com	858-874-1925
1992	Kelvin Shum	Kwan Wo Ironworks, Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:50:58	0	\N	2023-10-25 11:50:58	2023-10-25 11:50:58	Estimator	Hayward	CA	USA	\N	\N	\N	kelvins@kwanwo.com	(510) 487-9628
1993	Sonny Young	Morris Welding Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:51:34	0	\N	2023-10-25 11:51:34	2023-10-25 11:51:34	Estimator	Middletown	CA	USA	\N	\N	\N	\N	707-987-1114
1994	PHILLIPS STEEL COMPANY	PHILLIPS STEEL COMPANY	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:52:05	0	\N	2023-10-25 11:52:05	2023-10-25 11:52:05	\N	Long Beach	CA	USA	\N	\N	\N	\N	562-435-7571
1995	Eric	Republic Iron Works, Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:52:48	0	\N	2023-10-25 11:52:48	2023-10-25 11:52:48	Owner	Fontana	CA	USA	\N	\N	\N	Eric@RIWSteelFab.com	626 442-3360
1996	Jim Owens	SHORELINE CONSTRUCTORS, INC	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:53:36	0	\N	2023-10-25 11:53:36	2023-10-25 11:53:36	Estimating	San Buenaventura	CA	USA	\N	\N	\N	jim@shorelinemetal.com	805-642-9922
1997	STROUSS BROTHERS CONSTRUCTION INC.	STROUSS BROTHERS CONSTRUCTION INC.	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:53:59	0	\N	2023-10-25 11:53:59	2023-10-25 11:53:59	\N	Santa Clara	CA	USA	\N	\N	\N	Dave@StroussBrothers.com	408-267-3222
1998	Timber West Construction Ltd	Timber West Construction Ltd	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:54:18	0	\N	2023-10-25 11:54:18	2023-10-25 11:54:18	\N	undefined	CA	USA	\N	\N	\N	\N	916-786-6666
1999	Aaron	Tri Star Metals, INC	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 11:54:56	0	\N	2023-10-25 11:54:56	2023-10-25 11:54:56	\N	Dixon	CA	USA	\N	\N	\N	Aaron@TSMFab.com	707-678-1140
2000	Reese Rambo	Division Five, Inc.	rambor@divisionfiveinc.com	8437291103	Steel Detailing	Lead	t	f	2023-10-25 11:55:22	0	\N	2023-10-25 11:55:22	2023-10-25 11:55:22	Detailing Manager	Hollywood	SC	USA	\N	\N	\N	\N	843-889-1199
2001	Andy ()	Custom Steel Fabrication	stairandrail@gmail.com	206-723-1997	Steel Detailing	Lead	t	f	2023-10-25 12:12:56	0	\N	2023-10-25 12:12:56	2023-10-25 12:12:56	Project Manager	\N	NC	USA	\N	\N	\N	stairandrail@gmail.com	206-723-1997
2002	Jason Garrett	New Age Iron Works	jasongarrett@newageironworks.net	864-833-1392	Steel Detailing	Lead	t	f	2023-10-25 12:23:59	0	\N	2023-10-25 12:23:59	2023-10-25 12:23:59	Project Manager	Clinton	SC	USA	\N	\N	\N	\N	864-833-1392 C: 469-274-5322
2003	Vince Pedigo	Modern Welding Company	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 12:26:51	0	\N	2023-10-25 12:26:51	2023-10-25 12:26:51	Plant Manager	Orlando	FL	USA	\N	\N	\N	Vpedigo@ModWeldCo.com	407-843-1270
2004	Deo ()	DEO Weld & Fab	deocertifiedwelding@gmail.com	407-668-9116	Steel Detailing	Lead	t	f	2023-10-25 12:29:09	0	\N	2023-10-25 12:29:09	2023-10-25 12:29:09	Owner	Orlando	FL	USA	\N	\N	\N	DEOCertifiedWelding@Gmail.com	407-668-9116
2005	Rob ()	S & S Welding	rob@s-swelding.com	863-533-2888	Steel Detailing	Lead	t	f	2023-10-25 12:41:01	0	\N	2023-10-25 12:41:01	2023-10-25 12:41:01	Senior Project Manager	Bartow	FL	USA	\N	\N	\N	s-swelding.com	863-533-2888
2006	David Hirdes	P&A Welding	david@pandawelding.com	863-425-3198	Steel Detailing	Lead	t	f	2023-10-25 12:46:00	0	\N	2023-10-25 12:46:00	2023-10-25 12:46:00	\N	North Key Largo	\N	USA	\N	\N	\N	David@PandAWelding.com	863-425-3198 C: 863-899-5889
2007	David Barfoot	Dixie Tank Company	dbarfoot@dixietank.com	904-781-9500	Steel Detailing	Lead	t	f	2023-10-25 12:47:13	0	\N	2023-10-25 12:47:13	2023-10-25 12:47:13	Detailing Manager	Jacksonville	FL	USA	\N	\N	\N	\N	904-781-9500
2008	Colby Arney	GMF Steel Group	colby.arney@gmfsteel.com	863-577-0210	Steel Detailing	Lead	t	f	2023-10-25 12:47:24	0	\N	2023-10-25 12:47:24	2023-10-25 12:47:24	PM	Lakeland	\N	USA	\N	\N	\N	Procurement@GMFSteel.com	863-577-0210
2009	Pat	Atlanctic Central Enterprises	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 12:53:18	0	\N	2023-10-25 12:53:18	2023-10-25 12:53:18	Head Lady	Holly Hill	FL	USA	\N	\N	\N	ace-det@cfl.rr.com	386-255-6227
2010	Richard Daneault	L&D Steel	richard.daneault@ldsteelusa.com	727-538-9917 x239	Steel Detailing	Lead	t	f	2023-10-25 13:22:01	0	\N	2023-10-25 13:22:01	2023-10-25 13:22:01	Project Manager	Largo	FL	USA	\N	\N	\N	richard.daneault@ldsteelusa.com	727-538-9917 x239
2011	Jesse Rosenberg	Phoenix Iron Works	phoenixironworks19@gmail.com	717-333-0031	Steel Detailing	Lead	t	f	2023-10-25 13:26:38	0	\N	2023-10-25 13:26:38	2023-10-25 13:26:38	President	\N	\N	USA	\N	\N	\N	PhoenixIronWorks19@gmail.com	717-333-0031
2012	Ali	McKinado's Welding & Fabrication	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 13:31:41	0	\N	2023-10-25 13:31:41	2023-10-25 13:31:41	Owner	Port St. Lucie	FL	USA	\N	\N	\N	\N	772-985-9533
2013	Ryan Lodge	Capstone Constructors	ryan@capstonefl.biz	941-371-3321	Steel Detailing	Lead	t	f	2023-10-25 13:32:55	0	\N	2023-10-25 13:32:55	2023-10-25 13:32:55	Owner	\N	FL	USA	\N	\N	\N	trevor@capstonefl.biz	941-371-3321
2014	Donald Drotar	Composite Systems Inc	compositesystems@bellsouth.net	561-582-4396	Steel Detailing	Lead	t	f	2023-10-25 13:44:56	0	\N	2023-10-25 13:44:56	2023-10-25 13:44:56	\N	Lake Worth	FL	USA	\N	\N	\N	compositesystems@bellsouth.net	561-582-4396
2015	Barry ()	Raber Industries	raberinc@embarqmail.com	239-728-5527	Steel Detailing	Lead	t	f	2023-10-25 13:59:05	0	\N	2023-10-25 13:59:05	2023-10-25 13:59:05	Owner	Fort Myers	FL	USA	\N	\N	\N	RaberIncOffice@gmail.com	239-728-5527 C: 239-229-2957
2016	Allied Steel Buildings	Allied Steel Buildings	\N	\N	Steel Detailing	Lead	t	f	2023-10-25 13:59:44	0	\N	2023-10-25 13:59:44	2023-10-25 13:59:44	\N	Fort Lauderdale	FL	USA	\N	\N	\N	Splaza@AlliedBuilding.com	954-590-4955
2017	Jason Dittman	Ogden Brothers Construction	jason@ogdenbrothers.com	(239) 333-4321	Steel Detailing	Lead	t	f	2023-10-25 14:03:53	0	\N	2023-10-25 14:03:53	2023-10-25 14:03:53	PM	\N	FL	\N	\N	\N	\N	Jason@OgdenBrothers.com	(239) 333-4321
2018	Yoli Solis	Solis Iron Works	yoli@solismetals.com	305-264-1933 C: 786-366-4812	Steel Detailing	Lead	t	f	2023-10-25 14:12:54	0	\N	2023-10-25 14:12:54	2023-10-25 14:12:54	\N	Miami Gardens	FL	USA	\N	\N	\N	\N	305-264-1933 C: 786-366-4812
2019	Manuel Vidal	Metal Custom Work Corp	metalcustomworkcorp@gmail.com	786-942-3865	Steel Detailing	Lead	t	f	2023-10-25 14:15:19	0	\N	2023-10-25 14:15:19	2023-10-25 14:15:19	President	Miami Gardens	FL	USA	\N	\N	\N	MetalCustomWorkCorp@Gmail.com	786-942-3865
2020	Victor Scheide	Aaron's Builders	victor@aaronbuildersllc.com	305-794-5506	Steel Detailing	Lead	t	f	2023-10-25 14:26:38	0	\N	2023-10-25 14:26:38	2023-10-25 14:26:38	President	Miami	FL	USA	\N	\N	\N	victor@aaronbuildersllc.com	305-754-9135 C: 305-794-5506
2021	Raz Biton	CMS Steel	info@americacms.com	Raz: 954-663-5928	Steel Detailing	Lead	t	f	2023-10-25 14:26:54	0	\N	2023-10-25 14:26:54	2023-10-25 14:26:54	Son	Hallandale Beach	FL	USA	\N	\N	\N	\N	954-391-9462 C: 6786000852
2022	Curt Stroup	Agar Welding Service & Steel Supply	curtisstroup@agarwelding.com	717-532-1000	Steel Detailing	Lead	t	f	2023-10-26 16:56:31	0	\N	2023-10-26 16:56:31	2023-10-26 16:56:31	Detailing Manager	Harrisburg	PA	USA	\N	\N	\N	\N	717-532-1000
2023	Luc Leveille	Etobicoke Ironworks Ltd	luc.leveille@eiw.ca	\N	Steel Detailing	Lead	t	f	2023-10-26 18:08:48	0	\N	2023-10-26 18:08:48	2023-10-26 18:08:48	\N	\N	\N	CANADA	\N	\N	\N	\N	\N
2024	Jeff Parsons	Ideal Steel & Builders Supply	jparsons@idealsteel.com	8102311722	Steel Detailing	Lead	t	f	2023-10-26 18:18:27	0	\N	2023-10-26 18:18:27	2023-10-26 18:18:27	Chief Estimator	Detroit	MI	USA	\N	\N	\N	\N	3133598004 Jeff C:313.580.3605
2025	Mo Jhala	M&G Steel Ltd	mjhala@mgsteel.ca	905-469-6442	Steel Detailing	Lead	t	f	2023-10-27 11:21:27	0	\N	2023-10-27 11:21:27	2023-10-27 11:21:27	Structural Steel Estimator	\N	ON	CANADA	\N	\N	\N	\N	905-469-6442
2026	Jean Roberts	MAK Steel Services LLC	jeanr@maksteelservices.com	8444849552	Steel Detailing	Lead	t	f	2023-10-27 11:25:21	0	\N	2023-10-27 11:25:21	2023-10-27 11:25:21	Detailing Manager	Seymour	IN	USA	\N	\N	\N	\N	844-484-9552
2027	Shannon Wells	McSweeney Steel	\N	\N	Steel Detailing	Lead	t	f	2023-10-27 11:28:22	0	\N	2023-10-27 11:28:22	2023-10-27 11:28:22	\N	Tacoma	WA	USA	\N	\N	\N	\N	\N
2028	Duane Hartley	Midwest Steel Inc.	dhartley@midweststeel.com	\N	Steel Detailing	Lead	t	f	2023-10-27 11:38:39	0	\N	2023-10-27 11:38:39	2023-10-27 11:38:39	\N	Detroit	MI	USA	\N	\N	\N	\N	(313) 873-2220
2029	Roy Zeh	Porter Steel Inc.	\N	770-564-0837	Steel Detailing	Lead	t	f	2023-10-27 11:47:00	0	\N	2023-10-27 11:47:00	2023-10-27 11:47:00	\N	Lilburn	\N	USA	\N	\N	\N	\N	770-564-0837
2030	Sooraj Suresh Babu	Quad Steel Inc.	sooraj@quadsteel.ca	1 905-857-9404	Steel Detailing	Lead	t	f	2023-10-27 11:57:10	0	\N	2023-10-27 11:57:10	2023-10-27 11:57:10	PM	\N	\N	CANADA	\N	\N	\N	\N	1 905-857-9404
2031	Andrew Pierce	Silver Oak Contracting	apierce@silveroakinc.com	7709211550	Steel Detailing	Lead	t	f	2023-10-27 12:19:32	0	\N	2023-10-27 12:19:32	2023-10-27 12:19:32	PM	Winder	GA	USA	\N	\N	\N	\N	7709211550
2032	Chad Fritz	SteelFab Oregon	cfritz@steelfab-inc.com	(541) 752-0110	Steel Detailing	Lead	t	f	2023-10-27 12:25:25	0	\N	2023-10-27 12:25:25	2023-10-27 12:25:25	\N	Tangent	OR	\N	\N	\N	\N	\N	(541) 752-0110
2033	Joel Ramos-Ramirez	Crystal Steel Fabricators	\N	302.846.0613	Steel Detailing	Lead	t	f	2023-10-27 12:50:07	0	\N	2023-10-27 12:50:07	2023-10-27 12:50:07	Senior PM	\N	DE	\N	\N	\N	\N	\N	302.846.0613
2034	Ian Mincey	ESP Engineered Steel Product	imincey@engineeredsteel.com	336) 438-9140	Steel Detailing	Lead	t	f	2023-10-27 12:53:20	0	\N	2023-10-27 12:53:20	2023-10-27 12:53:20	Sales/PM	\N	NC	\N	\N	\N	\N	\N	336) 438-9140
2035	Wayne Gregory	Kirby Building Systems	wayne.gregory@kirbybuildingsystems.com	\N	Steel Detailing	Lead	t	f	2023-10-27 12:54:50	0	\N	2023-10-27 12:54:50	2023-10-27 12:54:50	Senior Project Engineer	Gallatin	TN	USA	\N	\N	\N	\N	\N
2036	Mark Liventsov	Prestige Iron Work	\N	(704) 785-0027	Steel Detailing	Lead	t	f	2023-10-27 13:05:14	0	\N	2023-10-27 13:05:14	2023-10-27 13:05:14	GM	\N	SC	\N	\N	\N	\N	info@prestigeironwork.com	(704) 785-0027
2037	()	Worth Steel Fabrication	sales@worthsteelfab.com	817-391-9800	Steel Detailing	Lead	t	f	2023-10-27 13:43:40	0	\N	2023-10-27 13:43:40	2023-10-27 13:43:40	\N	\N	TX	\N	\N	\N	\N	\N	817-391-9800
2038	Ronald Burgess	American Bridge Company	rburgess@americanbridge.net	\N	Steel Detailing	Lead	t	f	2023-10-27 13:51:03	0	\N	2023-10-27 13:51:03	2023-10-27 13:51:03	\N	\N	PA	\N	\N	\N	\N	\N	\N
2039	Vernon Young	W & W AFCO STEEL	wyoung@wwafcosteel.com	\N	Steel Detailing	Lead	t	f	2023-10-27 13:51:33	0	\N	2023-10-27 13:51:33	2023-10-27 13:51:33	Plant Manager	Montgomery	AL	USA	\N	\N	\N	\N	\N
2040	Dennis Bachman	UMC	dbachman222@gmail.com	\N	Steel Detailing	Lead	t	f	2023-10-27 13:54:37	0	\N	2023-10-27 13:54:37	2023-10-27 13:54:37	\N	\N	PA	\N	\N	\N	\N	\N	\N
2041	Pat Finley	Tamburri Associates	pfinley@tamburri.com	856-829-4000	Steel Detailing	Lead	t	f	2023-10-27 14:00:34	0	\N	2023-10-27 14:00:34	2023-10-27 14:00:34	Detailing Manager	\N	NJ	\N	\N	\N	\N	\N	856-829-4000
2042	Sem Caparelli	Suwannee Iron Works	scaparelli@siwfinc.com	\N	Steel Detailing	Lead	t	f	2023-10-27 14:02:48	0	\N	2023-10-27 14:02:48	2023-10-27 14:02:48	VP	\N	FL	\N	\N	\N	\N	\N	\N
2043	Eric Kaufman	ARC Steel Enterprises	eric.kaufman@arcsteelent.com	\N	Steel Detailing	Lead	t	f	2023-10-27 14:04:59	0	\N	2023-10-27 14:04:59	2023-10-27 14:04:59	\N	\N	SC	\N	\N	\N	\N	\N	\N
2044	Juan Aguayo	Structural Steel Manufacturing, Inc.	jc@sswincpr.com	\N	Steel Detailing	Lead	t	f	2023-10-27 15:17:46	0	\N	2023-10-27 15:17:46	2023-10-27 15:17:46	President	\N	\N	Puerto Rico	\N	\N	\N	\N	\N
2045	Brian Cansler	Bo-Mac Contractors	brian.cansler@bo-mac.com	O: 409-842-2125 C: 409-284-5394	Steel Detailing	Lead	t	f	2023-10-27 15:18:36	0	\N	2023-10-27 15:18:36	2023-10-27 15:18:36	Fabrication Manager	\N	TX	\N	\N	\N	\N	csimonson@bo-mac.com	O: 409-842-2125 C: 409-284-5394
2046	Joe Connor	SteelFab	jconnor@steelfab-inc.com	\N	Steel Detailing	Lead	t	f	2023-10-27 15:33:34	0	\N	2023-10-27 15:33:34	2023-10-27 15:33:34	Project Manager	Raleigh	NC	USA	\N	\N	\N	\N	\N
2047	EMILY ACUNA	STEEL BOSS INTERNATIONAL	emily@steel-boss.com	\N	Steel Detailing	Lead	t	f	2023-10-27 15:38:43	0	\N	2023-10-27 15:38:43	2023-10-27 15:38:43	\N	Mesquite	TX	USA	\N	\N	\N	\N	\N
2048	Cliff Iftimie	Commercial Fabricators, Inc.	cliffcomfab@yahoo.com	\N	Steel Detailing	Lead	t	f	2023-10-27 16:03:00	0	\N	2023-10-27 16:03:00	2023-10-27 16:03:00	\N	\N	IL	\N	\N	\N	\N	\N	\N
2049	Thaer Faraj	Owen Steel Company, Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-10-27 16:21:00	0	\N	2023-10-27 16:21:00	2023-10-27 16:21:00	Project Manager	New York	NY	USA	\N	\N	\N	\N	\N
2050	Derek Allen	Demmler Machinery	derek@demmlermachinery.com	\N	Steel Detailing	Lead	t	f	2023-10-27 16:25:56	0	\N	2023-10-27 16:25:56	2023-10-27 16:25:56	\N	undefined	PA	USA	\N	\N	\N	\N	\N
2051	Hugo Carbajal	Diligent Welding & Fabrication LLC	hugo@mydiligent.com	\N	Steel Detailing	Lead	t	f	2023-10-27 16:28:11	0	\N	2023-10-27 16:28:11	2023-10-27 16:28:11	\N	\N	FL	\N	\N	\N	\N	\N	\N
2052	Ron Stoffel	Division 5 LLC	rstoffel@division5inc.com	\N	Steel Detailing	Lead	t	f	2023-10-27 16:31:25	0	\N	2023-10-27 16:31:25	2023-10-27 16:31:25	President	undefined	NC	USA	\N	\N	\N	\N	\N
2053	David Lopez	DL Metal Design LLC	dlopez@dlmetaldesign.com	\N	Steel Detailing	Lead	t	f	2023-10-27 16:34:05	0	\N	2023-10-27 16:34:05	2023-10-27 16:34:05	President	\N	PA	\N	\N	\N	\N	\N	\N
2054	DAVID BENNERT	Dreicor, Inc.	dbennert@dreicor.com	\N	Steel Detailing	Lead	t	f	2023-10-27 16:38:29	0	\N	2023-10-27 16:38:29	2023-10-27 16:38:29	Business and Project Development Manager	Hendersonville	NC	USA	\N	\N	\N	\N	\N
2055	()	Dynamic Fabrication, INC.	brian@dynamicfabrication.net	270-274-5810	Steel Detailing	Lead	t	f	2023-10-27 16:41:09	0	\N	2023-10-27 16:41:09	2023-10-27 16:41:09	\N	Beaver Dam	KY	USA	\N	\N	\N	brian@dynamicfabrication.net	270-274-5810
2056	Dan McMahon	MS Iron Works	danm@msiron.com	\N	Steel Detailing	Lead	t	f	2023-10-27 16:59:27	0	\N	2023-10-27 16:59:27	2023-10-27 16:59:27	\N	\N	NY	\N	\N	\N	\N	\N	\N
2057	Robert Ackerman	King George Welding, Inc	ackeyweld@hotmail.com	\N	Steel Detailing	Lead	t	f	2023-10-27 18:06:29	0	\N	2023-10-27 18:06:29	2023-10-27 18:06:29	\N	\N	VA	\N	\N	\N	\N	\N	\N
2058	Aine Kelly	Kelly Iron Works	aine@kellyiron.com	\N	Steel Detailing	Lead	t	f	2023-10-27 18:08:56	0	\N	2023-10-27 18:08:56	2023-10-27 18:08:56	Purchasing Manager	\N	PA	\N	\N	\N	\N	\N	\N
2059	Gary Wicks	JCT Metals Inc	gary@jctmetals.com	\N	Steel Detailing	Lead	t	f	2023-10-27 18:21:10	0	\N	2023-10-27 18:21:10	2023-10-27 18:21:10	President	\N	\N	CANADA	\N	\N	\N	\N	\N
2060	Rich Robbins	Jackson Industrial Construction	rrobbins@jicompany.com	517-524-8589	Steel Detailing	Lead	t	f	2023-10-27 18:33:27	0	\N	2023-10-27 18:33:27	2023-10-27 18:33:27	PM	Concord	MI	USA	\N	\N	\N	\N	517-524-8589
2061	James Wilson	IWL Steel Fabricators LP	james.wilson@iwlsteel.com	1 306-242-4077	Steel Detailing	Lead	t	f	2023-10-27 18:39:54	0	\N	2023-10-27 18:39:54	2023-10-27 18:39:54	PM	Saskatoon	SK	CANADA	\N	\N	\N	\N	306-242-4077
2062	Tom Dreyer	Madlyn Metal Fab	\N	360-693-1019 x206	Steel Detailing	Lead	t	f	2023-10-27 22:06:10	0	\N	2023-10-27 22:06:10	2023-10-27 22:06:10	Project Manager	Washougal	WA	USA	\N	\N	\N	\N	360-693-1019 x206
2063	Keith Youngren	Integrity Steel Supply, LLC	kyoung6296@aol.com	\N	Steel Detailing	Lead	t	f	2023-10-28 09:32:31	0	\N	2023-10-28 09:32:31	2023-10-28 09:32:31	\N	\N	MN	\N	\N	\N	\N	\N	\N
2064	Cherisse Goodrich	Fineline Steel	cgoodrich@finelinesteel.com	(801) 803-6232	Steel Detailing	Lead	t	f	2023-10-28 10:06:07	0	\N	2023-10-28 10:06:07	2023-10-28 10:06:07	Secretary	\N	UT	\N	\N	\N	\N	\N	(801) 803-6232
2065	John Ford	Alliance Steel Building Systems	jford@allianceokc.com	800-624-1579	Steel Detailing	Lead	t	f	2023-10-28 11:10:05	0	\N	2023-10-28 11:10:05	2023-10-28 11:10:05	Outside Detailing Manager	Oklahoma City	OK	USA	\N	\N	\N	\N	800-624-1579
2066	Cyril McWeeney	Canam Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2023-10-28 11:22:58	0	\N	2023-10-28 11:22:58	2023-10-28 11:22:58	Drafting Supervisor	\N	MA	USA	\N	\N	\N	\N	833-888-0545
2067	Nicholas Slyter	Carr Construction	bids@carrconstruction.us	503-235-3514	Steel Detailing	Lead	t	f	2023-10-28 11:25:29	0	\N	2023-10-28 11:25:29	2023-10-28 11:25:29	Project Manager	Portland	OR	USA	\N	\N	\N	\N	503-235-3514
2068	Dustin Vuletich	Mikes Metal Works	dvuletich@mikesmetalworks.net	619-440-8804	Steel Detailing	Lead	t	f	2023-10-28 12:55:46	0	\N	2023-10-28 12:55:46	2023-10-28 12:55:46	Detailing Manager	San Diego	CA	USA	\N	\N	\N	\N	619-440-8804
2069	Adam Williams	NIX Structural Division	awilliams@nixmetals.com	812-874-2422 x1046	Steel Detailing	Lead	t	f	2023-10-28 13:04:39	0	\N	2023-10-28 13:04:39	2023-10-28 13:04:39	Detailing Manager	Evansville	IN	USA	\N	\N	\N	\N	812-874-2422 x1046
2070	Alvin Santiago	Northeast Structural Steel	asantiago@nestructuralsteel.com	914-699-9900	Steel Detailing	Lead	t	f	2023-10-28 13:07:22	0	\N	2023-10-28 13:07:22	2023-10-28 13:07:22	Detailing Manager	Pelham	NY	USA	\N	\N	\N	\N	914-699-9900
2071	Abilash Reddy Pyreddy	Olson Steel	Apyreddy@olsonsteel.com	\N	Steel Detailing	Lead	t	f	2023-10-28 13:10:06	0	\N	2023-10-28 13:10:06	2023-10-28 13:10:06	Assistant Detailing Manager & BIM Coordinator	San Leandro	CA	USA	\N	\N	\N	\N	(510) 567-2200
2072	Mark Etheridge	Ranburne Steel Fabrication	\N	\N	Steel Detailing	Lead	t	f	2023-10-28 13:19:04	0	\N	2023-10-28 13:19:04	2023-10-28 13:19:04	Detailing Manager	Sevierville	TN	USA	\N	\N	\N	\N	\N
2073	Jay Chaykowski	Saskarc Inc	\N	306-483-5055	Steel Detailing	Lead	t	f	2023-10-28 13:20:40	0	\N	2023-10-28 13:20:40	2023-10-28 13:20:40	Engineering and Detailing Manager	\N	\N	CANADA	\N	\N	\N	\N	306-483-5055
2074	Karthik Raj	Square D Vircon, Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-28 13:50:12	0	\N	2023-10-28 13:50:12	2023-10-28 13:50:12	Detailing Manager	\N	\N	CANADA	\N	\N	\N	\N	\N
2075	Kurt Barone	The Berlin Steel Construction Company	kbarone@berlinsteel.com	860) 828-3531	Steel Detailing	Lead	t	f	2023-10-28 13:53:11	0	\N	2023-10-28 13:53:11	2023-10-28 13:53:11	Detailing Office Manager	\N	\N	USA	\N	\N	\N	\N	(443) 749-5500
2076	Mark Nelson	W&W / AFCO Steel	Mnelson@WWAFCOSteel.com	\N	Steel Detailing	Lead	t	f	2023-10-28 14:02:10	0	\N	2023-10-28 14:02:10	2023-10-28 14:02:10	Project Manager, Estimator, Struc & Misc Detailing	Irvine	CA	USA	\N	\N	\N	\N	949-859-7182
2077	Greg Glover	W&W / AFCO Steel	Gglover@WWAFCOSteel.com	\N	Steel Detailing	Lead	t	f	2023-10-28 14:03:34	0	\N	2023-10-28 14:03:34	2023-10-28 14:03:34	Detailing Manager	Little Rock	AR	USA	\N	\N	\N	\N	\N
2078	Albert Marskamp	Walters Group	albertm@waltersinc.com	905-388-7111 x147 C:9055128178	Steel Detailing	Lead	t	f	2023-10-28 14:05:29	0	\N	2023-10-28 14:05:29	2023-10-28 14:05:29	VP Engineering & Detailing	Hamilton	ON	CANADA	\N	\N	\N	\N	905-388-7111x147 C:9055128178
2079	Ken Holbrook	Diamond Iron Works	\N	978-794-4640	Steel Detailing	Lead	t	f	2023-10-28 15:11:33	0	\N	2023-10-28 15:11:33	2023-10-28 15:11:33	Detailing Manager	\N	NH	USA	\N	\N	\N	\N	978-794-4640
2080	Phillip Haworth	Ordell Construcion	\N	541-747-8734	Steel Detailing	Lead	t	f	2023-10-28 15:24:09	0	\N	2023-10-28 15:24:09	2023-10-28 15:24:09	Steel Division Manager	Eugene	\N	USA	\N	\N	\N	\N	541-747-8734
2081	Lori Bambacigno	Bambacigno Steel	lbambacigno@bambacigno.com	(209) 524-9681	Steel Detailing	Lead	t	f	2023-10-28 15:31:37	0	\N	2023-10-28 15:31:37	2023-10-28 15:31:37	Owner	\N	CA	\N	\N	\N	\N	\N	(209) 524-9681
2082	Brian Thompson	KMA Steel	\N	641-954-5111	Steel Detailing	Lead	t	f	2023-10-30 10:01:08	0	\N	2023-10-30 10:01:08	2023-10-30 10:01:08	Co-Owner	Albia	IA	USA	\N	\N	\N	\N	641-954-5111
2083	Mason Campbell	Raw Steel Fabrication	\N	902-625-1784	Steel Detailing	Lead	t	f	2023-10-30 10:08:00	0	\N	2023-10-30 10:08:00	2023-10-30 10:08:00	Project Manager	\N	\N	CANADA	\N	\N	\N	\N	902-625-1784
2084	Steve Owens	W & W Steel / AFCO	\N	\N	Steel Detailing	Lead	t	f	2023-10-30 10:17:24	0	\N	2023-10-30 10:17:24	2023-10-30 10:17:24	Drafting Manager	Bokchito	OK	USA	\N	\N	\N	\N	405) 235-3621
2085	Jeff Graham	McFabco Graham Steel Fabrication	\N	206-621-7487	Steel Detailing	Lead	t	f	2023-10-30 10:18:57	0	\N	2023-10-30 10:18:57	2023-10-30 10:18:57	President	Seattle	WA	USA	\N	\N	\N	\N	206-621-7487
2086	Andrea Gomez Gastelum	WeSteel Builders	\N	\N	Steel Detailing	Lead	t	f	2023-10-30 10:21:51	0	\N	2023-10-30 10:21:51	2023-10-30 10:21:51	Project Manager	San Marcos	CA	USA	\N	\N	\N	\N	(858) 524-4353
2087	Brad Miller	Concept Steel, Inc	\N	704-874-0414	Steel Detailing	Lead	t	f	2023-10-30 10:57:46	0	\N	2023-10-30 10:57:46	2023-10-30 10:57:46	Estimator	Gastonia	NC	USA	\N	\N	\N	\N	704-874-0414
2088	Kevin Thibodeau	Steeltech Building Products, Inc	\N	860-290-8930	Steel Detailing	Lead	t	f	2023-10-30 10:59:48	0	\N	2023-10-30 10:59:48	2023-10-30 10:59:48	Structural Steel Project Manager	\N	CT	USA	\N	\N	\N	\N	860-290-8930
2089	Daniel Kasica	The Berlin Steel Construction Company	\N	\N	Steel Detailing	Lead	t	f	2023-10-30 11:07:13	0	\N	2023-10-30 11:07:13	2023-10-30 11:07:13	Project Manager	\N	CT	USA	\N	\N	\N	\N	\N
2090	Ian Laplante	Level Steel, Inc	\N	613-443-2693	Steel Detailing	Lead	t	f	2023-10-30 11:08:32	0	\N	2023-10-30 11:08:32	2023-10-30 11:08:32	General Manager	\N	\N	CANADA	\N	\N	\N	\N	613-443-2693
2091	Neal Oconnor	Northeast Steel Structures LLC	\N	401-667-5953	Steel Detailing	Lead	t	f	2023-10-30 11:11:08	0	\N	2023-10-30 11:11:08	2023-10-30 11:11:08	Project Manager	Providence	RI	USA	\N	\N	\N	\N	401-667-5953
2092	Randy Davis	The Herrick Corporation	\N	209-956-4751	Steel Detailing	Lead	t	f	2023-10-30 11:12:23	0	\N	2023-10-30 11:12:23	2023-10-30 11:12:23	\N	Stockton	CA	USA	\N	\N	\N	\N	209-956-4751
2093	Michael Allbright	Turner Industries Group	mallbright@turner-industries.com	\N	Steel Detailing	Lead	t	f	2023-10-30 11:23:33	0	\N	2023-10-30 11:23:33	2023-10-30 11:23:33	Project Manager / Detailing Manager	Decatur	AL	USA	\N	\N	\N	\N	256-584-0004
2094	Angel Guzman	S&S Steel Fabrication, Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-30 11:28:07	0	\N	2023-10-30 11:28:07	2023-10-30 11:28:07	Project Manager	Hurricane	UT	USA	\N	\N	\N	\N	\N
2095	Juan Holguin	Mid-State Metals	jholguin@msmetalsllc.com	\N	Steel Detailing	Lead	t	f	2023-10-30 11:41:43	0	\N	2023-10-30 11:41:43	2023-10-30 11:41:43	Project Manager	Orlando	FL	USA	\N	\N	\N	\N	407-295-3864
2096	Roque Acosta	RK Steel	roque.acosta@rksteel.com	303-355-9696	Steel Detailing	Lead	t	f	2023-10-30 11:47:39	0	\N	2023-10-30 11:47:39	2023-10-30 11:47:39	Project Manager	\N	CO	USA	\N	\N	\N	\N	303-355-9696
2097	Quentin Bolstad	Supreme Steel	quentin.bolstad@supremesteel.com	604-524-4421	Steel Detailing	Lead	t	f	2023-10-30 11:54:19	0	\N	2023-10-30 11:54:19	2023-10-30 11:54:19	\N	Spruce Grove	AL	CANADA	\N	\N	\N	\N	604-524-4421
2098	Ron Gregg	Precision Industrial Manufacturing	\N	\N	Steel Detailing	Lead	t	f	2023-10-30 12:07:31	0	\N	2023-10-30 12:07:31	2023-10-30 12:07:31	PM / Estimator	Portland	OR	USA	\N	\N	\N	\N	\N
2099	Martin Williams	Lantec Fabricating	\N	604-857-9038	Steel Detailing	Lead	t	f	2023-10-30 12:14:25	0	\N	2023-10-30 12:14:25	2023-10-30 12:14:25	General Manager	\N	\N	CANADA	\N	\N	\N	\N	604-857-9038
2100	Mark Hubrich	Adams Steel Service / Wakuegan Steel	markh@adamssteelservice.com	815-385-9100	Steel Detailing	Lead	t	f	2023-10-30 12:15:52	0	\N	2023-10-30 12:15:52	2023-10-30 12:15:52	Steel Detailer	\N	IL	\N	\N	\N	\N	\N	815-385-9100
2101	Thomas Christopher	JB Steel	\N	\N	Steel Detailing	Lead	t	f	2023-10-30 12:17:18	0	\N	2023-10-30 12:17:18	2023-10-30 12:17:18	Project Manager	Medford	OR	USA	\N	\N	\N	\N	\N
2102	Tony Trionfo	B&A Structural Steel	ttrionfo@grilloco.com	586-948-2220	Steel Detailing	Lead	t	f	2023-10-30 12:19:25	0	\N	2023-10-30 12:19:25	2023-10-30 12:19:25	MainMan	Roseville	MI	USA	\N	\N	\N	\N	586-948-2220
2103	Nick Burley	Tital Steel Fabricators	\N	no phone number	Steel Detailing	Lead	t	f	2023-10-30 12:22:21	0	\N	2023-10-30 12:22:21	2023-10-30 12:22:21	Project Manager	El Cajon	\N	USA	\N	\N	\N	\N	no phone number
2104	Fred Shelton	Midwest Steel Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-30 12:50:35	0	\N	2023-10-30 12:50:35	2023-10-30 12:50:35	Project Manager / Sales	Shepherdsville	KY	USA	\N	\N	\N	\N	\N
2105	Joel Hamilton	CVU Steel	\N	780-298-0879	Steel Detailing	Lead	t	f	2023-10-30 12:56:09	0	\N	2023-10-30 12:56:09	2023-10-30 12:56:09	Estimator	Alberta	\N	CANADA	\N	\N	\N	\N	780-298-0879
2106	Blake Schluter	J. Benton Construction	\N	\N	Steel Detailing	Lead	t	f	2023-10-30 13:03:40	0	\N	2023-10-30 13:03:40	2023-10-30 13:03:40	Project Manager	\N	\N	USA	\N	\N	\N	\N	\N
2107	Jordan Elmer	JB Steel	info@jbsteel.net	\N	Steel Detailing	Lead	t	f	2023-10-30 13:33:30	0	\N	2023-10-30 13:33:30	2023-10-30 13:33:30	Project Manager	\N	AZ	USA	\N	\N	\N	\N	(520) 748-8062
2108	Denver Buxton	Mission Steel	denver@missionsteel.com	909-389-0088	Steel Detailing	Lead	t	f	2023-10-30 13:52:53	0	\N	2023-10-30 13:52:53	2023-10-30 13:52:53	Structural Steel Estimator	Redlands	CA	USA	\N	\N	\N	\N	909-389-0088
2109	Bronson Loatman	Borrelli Steel Fabricators	bronson@borrellisteel.com	856-690-8850	Steel Detailing	Lead	t	f	2023-10-30 14:00:39	0	\N	2023-10-30 14:00:39	2023-10-30 14:00:39	Senior Estimator	Vineland	NJ	USA	\N	\N	\N	\N	856-690-8850
2110	Desiree	Ferguson Fabrication, LLC	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 12:59:44	0	\N	2023-10-31 12:59:44	2023-10-31 12:59:44	\N	Merlin	OR	USA	\N	\N	\N	\N	541-471-9220
2111	Johnny Lorusso	VM IRON WORKS	johnny@vmironwork.com	C:772-323-7632	Steel Detailing	Lead	t	f	2023-10-30 20:03:22	0	\N	2023-10-30 20:03:22	2023-10-30 20:03:22	CEO	Palm City	\N	USA	\N	\N	\N	natasha@vmironwork.com	772-781-0318 Natasha C: 772.404.9924
2112	Jon Green	Hanover Iron Works	jgreen@hanoveriron.com	717-632-5624	Steel Detailing	Lead	t	f	2023-10-31 10:20:39	0	\N	2023-10-31 10:20:39	2023-10-31 10:20:39	Project Manager	Hanover	\N	USA	\N	\N	\N	\N	717-632-5624
2113	Mark	Mac Welding & Fabrication Inc	mark@macwelding.com	\N	Steel Detailing	Lead	t	f	2023-10-31 11:25:05	0	\N	2023-10-31 11:25:05	2023-10-31 11:25:05	\N	McMinnville	OR	USA	\N	\N	\N	sales@macwelding.com,	503-474-2043
2114	True Line Steel Inc	True Line Steel Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 11:29:09	0	\N	2023-10-31 11:29:09	2023-10-31 11:29:09	\N	Redmond	OR	USA	\N	\N	\N	\N	541-548-7465
2115	Bay Cities Fabricators	Bay Cities Fabricators	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 11:31:10	0	\N	2023-10-31 11:31:10	2023-10-31 11:31:10	\N	White City	OR	USA	\N	\N	\N	\N	541-826-1466
2116	Sieckmann Metal Fab Inc	Sieckmann Metal Fab Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 11:44:04	0	\N	2023-10-31 11:44:04	2023-10-31 11:44:04	\N	Eagle Crest	OR	USA	\N	\N	\N	\N	503-637-3802
2117	Joel	Eastside Steel Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 11:55:04	0	\N	2023-10-31 11:55:04	2023-10-31 11:55:04	\N	Portland	OR	USA	\N	\N	\N	\N	503-760-6787
2118	Steve Williams	Mohawk Metal Company	Swilliams@MohawkMetal.com	\N	Steel Detailing	Lead	t	f	2023-10-31 12:11:00	0	\N	2023-10-31 12:11:00	2023-10-31 12:11:00	Estimator	Eugene	OR	USA	\N	\N	\N	\N	541-744-3838
2119	Kodi	Rock Hill Steelworks	KodiWJones0000@gmail.com	\N	Steel Detailing	Lead	t	f	2023-10-31 12:15:06	0	\N	2023-10-31 12:15:06	2023-10-31 12:15:06	\N	Albany	OR	USA	\N	\N	\N	\N	541-401-7916
2120	Howling Dog Fabrication	Howling Dog Fabrication	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 12:17:19	0	\N	2023-10-31 12:17:19	2023-10-31 12:17:19	\N	Grants Pass	OR	USA	\N	\N	\N	\N	541-601-1191
2121	Gratemaster	Gratemaster	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 12:23:57	0	\N	2023-10-31 12:23:57	2023-10-31 12:23:57	\N	North Plains	OR	USA	\N	\N	\N	Sales@gratemaster.com	503-647-2050
2122	Bryson	Built By Steele	Bryson@BuiltBySteele.com	\N	Steel Detailing	Lead	t	f	2023-10-31 12:26:26	0	\N	2023-10-31 12:26:26	2023-10-31 12:26:26	\N	Roseburg	OR	USA	\N	\N	\N	\N	541-733-6304
2123	John Cummins	Emerald Steel Fabricators Inc	john@emeraldsteel.com	\N	Steel Detailing	Lead	t	f	2023-10-31 12:32:49	0	\N	2023-10-31 12:32:49	2023-10-31 12:32:49	Detailer	\N	OR	USA	\N	\N	\N	john@emeraldsteel.com	541-688-1940
2124	Oregon Metal Fabrication	Oregon Metal Fabrication	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 12:40:23	0	\N	2023-10-31 12:40:23	2023-10-31 12:40:23	\N	Sandy	OR	USA	\N	\N	\N	Trevor.T@Oregonmetalfab.com	503-482-0533
2125	Bend Steel Supply & Fabrication	Bend Steel Supply & Fabrication	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 12:42:03	0	\N	2023-10-31 12:42:03	2023-10-31 12:42:03	\N	Bend	OR	USA	\N	\N	\N	sales@empiretruckworks.com	541-383-3113
2126	Oregon Pacific Metal Fab	Oregon Pacific Metal Fab	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 12:43:45	0	\N	2023-10-31 12:43:45	2023-10-31 12:43:45	\N	Mulino	OR	USA	\N	\N	\N	\N	503-632-5253
2127	All Metals Fabrication & Machine Corporation.	All Metals Fabrication & Machine Corporation.	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 12:50:13	0	\N	2023-10-31 12:50:13	2023-10-31 12:50:13	\N	Astoria	OR	USA	\N	\N	\N	\N	503-468-0500
2128	Liberty Metal Fabricators Inc	Liberty Metal Fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 12:52:22	0	\N	2023-10-31 12:52:22	2023-10-31 12:52:22	\N	Portland	OR	USA	\N	\N	\N	\N	503-254-7346
2129	Evans Metal Fabricators Inc	Evans Metal Fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 12:55:47	0	\N	2023-10-31 12:55:47	2023-10-31 12:55:47	\N	Portland	OR	USA	\N	\N	\N	\N	503-228-0194
2130	S & P Steel Fab	S & P Steel Fab	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 12:57:49	0	\N	2023-10-31 12:57:49	2023-10-31 12:57:49	\N	Grants Pass	OR	USA	\N	\N	\N	\N	541-479-5651
2131	Andrea	Cascade Steel Rolling Mills	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:13:44	0	\N	2023-10-31 13:13:44	2023-10-31 13:13:44	\N	McMinnville	OR	USA	\N	\N	\N	\N	503-472-4181
2132	Medford Fabrication C S C Inc	Medford Fabrication C S C Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:15:07	0	\N	2023-10-31 13:15:07	2023-10-31 13:15:07	\N	Medford	OR	USA	\N	\N	\N	\N	541-779-1970
2133	Mattheisen Fabrication	Mattheisen Fabrication	\N	5416641850	Steel Detailing	Lead	t	f	2023-10-31 13:19:05	0	\N	2023-10-31 13:19:05	2023-10-31 13:19:05	\N	Central Point	OR	USA	\N	\N	\N	\N	541-821-2526
2134	KO Custom Fab	KO Custom Fab	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:21:18	0	\N	2023-10-31 13:21:18	2023-10-31 13:21:18	\N	\N	OR	USA	\N	\N	\N	sales@kocustomfab.com	(503) 572-9701
2135	Canna Goodwin	Pro Weld, Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:22:51	0	\N	2023-10-31 13:22:51	2023-10-31 13:22:51	\N	White City	OR	USA	\N	\N	\N	\N	541-826-1404
2136	Justin	Bend Metal Fabrication	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:24:34	0	\N	2023-10-31 13:24:34	2023-10-31 13:24:34	\N	Springfield	OR	USA	\N	\N	\N	\N	541-325-8543
2137	Ben Quach	Q B Fabrication & Welding	ben@qbfabrication.com	\N	Steel Detailing	Lead	t	f	2023-10-31 13:33:05	0	\N	2023-10-31 13:33:05	2023-10-31 13:33:05	CEO	Clatskanie	OR	USA	\N	\N	\N	\N	503-788-1363
2138	BBC Steel Corporation	BBC Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:37:05	0	\N	2023-10-31 13:37:05	2023-10-31 13:37:05	\N	Canby	OR	USA	\N	\N	\N	\N	503-263-6343
2139	Aarons Metal	Aarons Metal	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:38:25	0	\N	2023-10-31 13:38:25	2023-10-31 13:38:25	\N	Salem	OR	USA	\N	\N	\N	\N	503-585-4864
2140	Jay	Jay's Custom Fabrication	jayscustom@frontier.com	\N	Steel Detailing	Lead	t	f	2023-10-31 13:40:07	0	\N	2023-10-31 13:40:07	2023-10-31 13:40:07	\N	Newberg	OR	USA	\N	\N	\N	\N	503-538-9767
2141	Steel Fabrication Inc	Steel Fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:42:00	0	\N	2023-10-31 13:42:00	2023-10-31 13:42:00	\N	Estacada	OR	USA	\N	\N	\N	\N	\N
2142	Jim	Double F Welding & Fabrication LLC	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:43:49	0	\N	2023-10-31 13:43:49	2023-10-31 13:43:49	\N	Wheeler	OR	USA	\N	\N	\N	\N	541-350-7703
2143	Tim O Connor	Enterprise Fabricators Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:45:47	0	\N	2023-10-31 13:45:47	2023-10-31 13:45:47	\N	Milwaukie	OR	USA	\N	\N	\N	\N	503-654-8776
2144	Vince	Imperial Steel Craft Inc	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:47:42	0	\N	2023-10-31 13:47:42	2023-10-31 13:47:42	GM	Hillsboro	OR	USA	\N	\N	\N	imperialsteelcraftinc@hotmail.com	(503) 649-7709
2145	Brian	West Coast Steel Fabricators	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:49:50	0	\N	2023-10-31 13:49:50	2023-10-31 13:49:50	GM	Eugene	OR	USA	\N	\N	\N	\N	541-689-5851
2146	Phillip Read	C K & Company of Oregon Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 13:54:45	0	\N	2023-10-31 13:54:45	2023-10-31 13:54:45	PM	Salem	OR	USA	\N	\N	\N	pread@ckcompany.biz	503-792-3045
2147	Doug Ward	Royal Oak Metal Craft Inc	doug@royaloakinc.com	503-222-2977	Steel Detailing	Lead	t	f	2023-10-31 15:36:06	0	\N	2023-10-31 15:36:06	2023-10-31 15:36:06	Owner	Portland	OR	USA	\N	\N	\N	\N	503-222-2977
2148	Redmond Welding and Contracting	Redmond Welding and Contracting	\N	\N	Steel Detailing	Lead	t	f	2023-10-31 15:38:03	0	\N	2023-10-31 15:38:03	2023-10-31 15:38:03	\N	Redmond	OR	USA	\N	\N	\N	office@redmondwelding.com	541 504 9353
2149	Conner Thompson	BRIDGE BROTHERS INC	cthompson@bridgebrothersinc.com	\N	Steel Detailing	Lead	t	f	2023-11-07 22:34:14	0	\N	2023-11-07 22:34:14	2023-11-07 22:34:14	\N	\N	SC	USA	\N	\N	\N	\N	615.691.1188
2150	Jose Bernal	MARKLE MANUFACTURING COMPANY	j.bernal@marklemfg.com	\N	Steel Detailing	Lead	t	f	2024-03-20 22:34:19	0	\N	2024-03-20 22:34:19	2024-03-20 22:34:19	Project Manager	San Antonio	TX	USA	\N	\N	\N	j.bernal@marklemfg.com	(210) 655-7130
2151	Kevin Jones	Structural Systems Inc.	\N	\N	Steel Detailing	Lead	t	f	2024-03-27 15:56:29	0	\N	2024-03-27 15:56:29	2024-03-27 15:56:29	\N	Nitro	WV	USA	\N	\N	\N	eric@stsystemsinc.com	304-204-4766
2152	Francis Jones	Selco Manufacturing Corp	fjones@selcomfg.com	\N	Steel Detailing	Lead	t	f	2024-04-02 00:15:39	0	\N	2024-04-02 00:15:39	2024-04-02 00:15:39	Detailing Manager	Caldwell	NJ	USA	\N	\N	\N	fjones@selcomfg.com	(973) 244-1177
2153	Adam Patrick	ARP Welding	adam@arpwelding.com	(203) 344-7528	Steel Detailing	Lead	t	f	2024-04-04 10:03:23	0	\N	2024-04-04 10:03:23	2024-04-04 10:03:23	Owner	\N	CT	\N	\N	\N	\N	adam@arpwelding.com	(203) 344-7528
2154	Matt Broome	Contractors Metalworks	matt@contractorsmetalworks.com	713-856-6600	Steel Detailing	Lead	t	f	2024-04-30 23:06:59	0	\N	2024-04-30 23:06:59	2024-04-30 23:06:59	Estimator	\N	TX	\N	\N	\N	\N	matt@contractorsmetalworks.com	713-856-6600
2155	Jesse Leal	SoCal Detailing, Inc.	socaldetailer@live.com	\N	Steel Detailing	Lead	t	f	2024-05-21 11:37:57	0	\N	2024-05-21 11:37:57	2024-05-21 11:37:57	\N	Roslyn	WA	USA	\N	\N	\N	\N	5623185463
2156	Satish Kumar	AZIZI Developments L.L.C	satish.kumar@azizidevelopments.com	9715294595	Steel Detailing	Lead	t	f	2024-05-23 15:34:19	0	\N	2024-05-23 15:34:19	2024-05-23 15:34:19	PROCUREMENT COORDINATOR	Al Khawaneej	DXB	UAE	\N	\N	\N	satish.kumar@azizidevelopments.com	+971 52 945 9570
2157	Randy Smith	Seguin Fabricators	randy@seguinfab.com	\N	Steel Detailing	Lead	t	f	2024-06-24 17:45:39	0	\N	2024-06-24 17:45:39	2024-06-24 17:45:39	TopDog	\N	TX	\N	\N	\N	\N	\N	\N
2158	Davide Circelli	Circelli Steel LTD	dav@circellisteel.com	1 519-685-6644	Steel Detailing	Lead	t	f	2024-07-04 12:02:32	0	\N	2024-07-04 12:02:32	2024-07-04 12:02:32	Owner	\N	\N	CANADA	\N	\N	\N	info@circellisteel.com	1 519-685-6644
2159	Tom	Arsenal steel	ironman@arsenalsteel.com	\N	Steel Detailing	Lead	t	f	2024-08-29 12:04:39	0	\N	2024-08-29 12:04:39	2024-08-29 12:04:39	\N	Chicago	IL	USA	\N	\N	\N	ironman@arsenalsteel.com	(847) 451-1705
2160	Jeremy Barnett	VSF Corporation	jbarnett@vsfcorporation.com	205-672-8728 x303 C: 256-861-6579	Steel Detailing	Lead	t	f	2024-09-19 21:24:35	0	\N	2024-09-19 21:24:35	2024-09-19 21:24:35	PM	\N	AL	\N	\N	\N	\N	jbarnett@VSFCorporation.com	205-672-8728 x303 C: 256-861-6579
2161	Randy Pond	Excel Steel Fabrication	randy@excelsteelfab.com	801-709-5962 RandyC: 801-368-5229	Steel Detailing	Lead	t	f	2024-10-28 15:35:12	0	\N	2024-10-28 15:35:12	2024-10-28 15:35:12	PM	\N	UT	\N	\N	\N	\N	\N	801-709-5962 RandyC: 801-368-5229
2162	Stefan ()	Ivey League Fabrication	stefan@iveyleaguefab.com	385-219-6251	Steel Detailing	Lead	t	f	2024-11-01 17:10:57	0	\N	2024-11-01 17:10:57	2024-11-01 17:10:57	\N	\N	UT	\N	\N	\N	\N	Spencer@iveyleaguefab.com	385-219-6251
2163	Eduardo Montes	Rays Stairs Steel Company	eduardomontes28@gmail.com	\N	Steel Detailing	Lead	t	f	2024-11-18 18:27:00	0	\N	2024-11-18 18:27:00	2024-11-18 18:27:00	Owner	\N	GA	\N	\N	\N	\N	office@raysstairsinc.com	\N
2164	Elancheliyan	SB ENGINEERS CONSULTING & CONTRACTING	cheli@sbecc.in	\N	Steel Detailing	Lead	t	f	2025-01-22 18:57:50	0	\N	2025-01-22 18:57:50	2025-01-22 18:57:50	\N	AIGhoubrah	Muscat	OMAN	\N	\N	\N	\N	\N
2165	Justin McFarlane	West Michigan Structural Services	justin@westmichiganstructural.com	6162686708	Steel Detailing	Lead	t	f	2025-03-11 13:39:01	0	\N	2025-03-11 13:39:01	2025-03-11 13:39:01	PM	\N	MI	USA	\N	\N	\N	\N	616) 268-6708
2166	Ken Barclay	Barclays Mechanical of Utah	ken@barclaymechanical.com	4358355084	Steel Detailing	Lead	t	f	2025-03-11 21:38:22	0	\N	2025-03-11 21:38:22	2025-03-11 21:38:22	MainMan	Manti	UT	USA	\N	\N	\N	Ken@barclaymechanical.com	O: 435-835-5084 C: 435-760-7694
2167	Christine Todd	Zyko Steel Inc.	zyko.steel@outlook.com	\N	Steel Detailing	Lead	t	f	2025-03-26 12:02:40	0	\N	2025-03-26 12:02:40	2025-03-26 12:02:40	\N	Rosemead	CA	USA	\N	\N	\N	\N	(626) 655-9880
2168	Luis Linares	Alliance Steel	luisl@alliancesteelfab.com	(253) 538-7935	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	WA	\N	\N	\N	\N	\N	(253) 538-7935
2169	Dusty Taylor	Ferrill Fisher Inc.	Dustin.Taylor@ferrillfisher.com	7655161990	Steel Detailing	Lead	t	f	2025-04-08 12:10:13	0	\N	2025-04-08 12:10:13	2025-04-08 12:10:13	Estimator	Bloomington	IN	USA	\N	\N	\N	info@ferrillfisher.com	+1 812-935-9000
2170	Tom Leopold	Quality Welding and Fab., LLC	t.leopold@qualityweldingandfab.com	\N	Steel Detailing	Lead	t	f	2025-04-15 11:52:24	0	\N	2025-04-15 11:52:24	2025-04-15 11:52:24	Contract Specialist	Elida	OH	USA	\N	\N	\N	info@qualityweldingandfab.com	419-225-6208
2171	Donald Stephens	Master Steel, L.L.C.	dstephens@master-steel.net	843-784-7173 ClaytonC: 920.216.6787	Steel Detailing	Lead	t	f	2025-04-18 12:32:26	0	\N	2025-04-18 12:32:26	2025-04-18 12:32:26	BigBoss	Hardeeville	SC	USA	\N	\N	\N	\N	843-784-7173 ClaytonC: 920.216.6787
2172	Dheenadhayalan K	ASSENT STEEL INDUSTRIES L.L.C	dheenadhayalan.k@assentsteel.com	\N	Steel Detailing	Lead	t	f	2025-04-23 12:05:14	0	\N	2025-04-23 12:05:14	2025-04-23 12:05:14	Quantity Surveyor	Al Awir	DXB	UAE	\N	\N	\N	\N	+971 - 4 - 2471200
2173	Nick Barnim	Eastwood Manufacturing Inc	nbarnim@eastwood88.com	\N	Steel Detailing	Lead	t	f	2025-04-29 15:54:48	0	\N	2025-04-29 15:54:48	2025-04-29 15:54:48	Business Development Manager	Brockville	Ontario	CANADA	\N	\N	\N	\N	5198772687
2174	Jessie G. Abubo	Construction Contractors Corporation	jessie@steelccc.com	3235338088	Steel Detailing	Lead	t	f	2025-05-02 11:33:50	0	\N	2025-05-02 11:33:50	2025-05-02 11:33:50	\N	Pico Rivera	CA	USA	\N	\N	\N	\N	5629481199
2175	Nick Barrett	Thirteen RF, Inc	nbarrett@thirteenrf.com	\N	Steel Detailing	Lead	t	f	2025-05-08 19:55:46	0	\N	2025-05-08 19:55:46	2025-05-08 19:55:46	GM	\N	IL	\N	\N	\N	\N	info@thirteenrf.com	\N
2176	Rusty Stutts	PRIORITY STEEL INDUSTRIAL CONTRACTING	rustystutts@prioritysteelindustrial.com	\N	Steel Detailing	Lead	t	f	2025-05-22 16:53:46	0	\N	2025-05-22 16:53:46	2025-05-22 16:53:46	Project Manager-Master Rigger/Owner	Lawrenceburg	IN	USA	\N	\N	\N	\N	937-626-4361
2177	Dianne Lefler	R & D Welding	dianne@rdwstructural.com	\N	Steel Detailing	Lead	t	f	2025-05-24 15:33:14	0	\N	2025-05-24 15:33:14	2025-05-24 15:33:14	\N	Reno	NV	USA	\N	\N	\N	\N	775.432.2246
2178	Walter McKeever	Sonne Steel	valter52@twc.com	5028196012	Steel Detailing	Lead	t	f	2025-05-29 21:01:06	0	\N	2025-05-29 21:01:06	2025-05-29 21:01:06	Estimator	Smithfield	KY	USA	\N	\N	\N	valter52@twc.com	502-222-0099
2179	Tim McClintock	12-D Construction	tymcclintock@yahoo.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	Shelbina	MO	USA	\N	\N	\N	\N	573-515-0300
2180	Lenerd ()	3 D Steel	lenerd.3d@gmail.com	801-972-1236	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	UT	\N	\N	\N	\N	\N	801-972-1236
2181	Gerard Woudenberg	A&H Custom Machine	gwoudenberg@ahcustom.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Business Development	\N	\N	CANADA	\N	\N	\N	\N	\N
2182	Nick Romero	A & R Iron Works	\N	(610) 497-8770	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP	\N	PA	\N	\N	\N	\N	\N	(610) 497-8770
2183	Jon Orman	AAM	j.orman@aametalworks.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	NC	\N	\N	\N	\N	\N	\N
2184	Kent ()	Advanced Steel Building Systems	kent@advancedsteelbuildings.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan/Architect	\N	UT	\N	\N	\N	\N	\N	\N
2185	Carlos Gutierrez	AIDA Steel Fabricators	sales@aidafab.com	281-987-3133	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP	\N	TX	\N	\N	\N	\N	\N	281-987-3133
2186	Derek Compton	Alessandra Misc Metal Works	derek@alessandramisc.com	(973) 786-6805	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP	\N	NJ	\N	\N	\N	\N	\N	(973) 786-6805
2187	Keaton Beard	Anthem Steel Group	keatonb@anthemsg.com	801-381-5975	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	UT	\N	\N	\N	\N	\N	801-381-5975
2188	Dean Thom	Arctech Welding + Machining	dean.thom@arctech-welding.com	1 250-785-5151	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Part Owner	\N	\N	CANADA	\N	\N	\N	\N	1 250-785-5151
2189	Dave Golden	ASC Profiles	davegolden2424@icloud.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	CA	\N	\N	\N	\N	\N	\N
2190	Ian Wengerd	AspiredX LLC	ian@aspiredx.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	President	\N	OH	\N	\N	\N	\N	\N	\N
2191	Kimberly Prater	Atchley Steel Company, Inc.	kim@atchleysteel.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Owner	\N	AL	\N	\N	\N	\N	\N	\N
2192	David ()	Atlantic Central Enterprises	ace-det@cfl.rr.com	3862556227	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Drafter	Holly Hill	FL	USA	\N	\N	\N	\N	386-255-6227
2193	Jason Cartwright	ATS Industrial	jasonc@ats1st.com	361) 881-9100	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Steel Division Project Manager	\N	TX	\N	\N	\N	\N	\N	\N
2194	Becky Martinez	Beltran Bros Steel Fabrication	info@beltranbros.com	281-987-2331	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	TX	\N	\N	\N	\N	\N	281-987-2331
2195	Brian Machado	Benson Steel	bmachado@bensonsteel.com	1 905-857-0684	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Estimator	\N	\N	CANADA	\N	\N	\N	\N	1 905-857-0684
2196	Rodney Harris	Bigbee Steel	rharris@bigbee.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	AL	\N	\N	\N	\N	\N	\N
2197	Mike Gobbato	Blue Star Welding	mikeg@bluestarweldingllc.com	360.398.7647 Mikes Cell: 360-201-2583	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	WA	\N	\N	\N	\N	\N	360.398.7647 Mikes Cell: 360-201-2583
2198	Brent Harlow	Boyce Iron and Steel	harbred6051@yahoo.com	512-443-5151	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Detailing Manager	\N	TX	\N	\N	\N	\N	\N	512-443-5151
2199	Taft O'Quin	Bridge Crane Specialists	toquin@bridgecrane.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP Business Development	\N	OK	\N	\N	\N	\N	\N	\N
2200	Jim Bowman	C & C IRON INC	bowman-jim@comcast.net	2197692511	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	Merrillville	IN	USA	\N	\N	\N	\N	2197692511
2201	Matthew Even	Capital Machine	meven@capitalmachine.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	GA	\N	\N	\N	\N	\N	\N
2202	Justin Abou-Abdou	Carleton Iron works	justin@carletoniron.com	Ph:613-690-8387	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	\N	CANADA	\N	\N	\N	\N	Ph:613-690-8387
2203	Robert Stewart	Cayo Steelworks Ltd.	lstewart@cayosteelworks.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	FL	\N	\N	\N	\N	\N	\N
2204	Nick Dietrich	Central Welding & Iron Works Group	nick.dietrich@centralwelding.ca	705-474-0350 x 228	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	\N	CANADA	\N	\N	\N	\N	705-474-0350 x 228
2205	Michael Garcia	Cikis Steel	michael@cikissteel.net	281-689-6655 C: 936-718-9321	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Owner	\N	TX	\N	\N	\N	\N	\N	281-689-6655 C: 936-718-9321
2206	Peter Frantz	Cimolai-HY	peter.frantz@cimolaiusa.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	NY	\N	\N	\N	\N	\N	\N
2207	Christopher Bowen	Cives Steel Company, SW Div	cbowen@cives.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	GM	\N	AZ	\N	\N	\N	\N	\N	\N
2208	Rob Wright	Collins Steel	rwright@collinssteel.com	780-440-1414	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	President	\N	\N	CANADA	\N	\N	\N	\N	\N
2209	Scott Collins	Collins Structural Consulting	scollins@collinsstructural.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Principal Engineer	\N	NC	\N	\N	\N	\N	\N	\N
2210	Matthew Duthie	Commercial Contracting Corporation	matthew.duthie@cccnetwork.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Estimator Steel Fabrication Division	\N	MI	\N	\N	\N	\N	\N	\N
2211	Jose Rios	Comsa Steel Inc	joserios@comsasteel.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	\N
2212	Phillip ()	CSS America	pcai@csqsteel.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	HI	\N	\N	\N	\N	\N	\N
2213	Cezary Sosidko	CUSTOM WELDING INC.	cezarys@customwelding.us	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	President	\N	NJ	\N	\N	\N	\N	\N	\N
2214	()	D.R. Steel	dvaldez@drsteelga.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Owner	\N	GA	\N	\N	\N	\N	\N	\N
2215	David Feliciano	D&E Ironworks	david@deironworks.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Lead Fabricator	\N	NJ	\N	\N	\N	\N	\N	\N
2216	Richard Hine	D&H Steel Construction Ltd	richard.hine@dhsteel.co.nz	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	GM	\N	\N	New Zealand	\N	\N	\N	\N	\N
2217	Geni Brooks	Division 5	gbrooks@divisionfiveinc.com	843-889-1199 C: 843-729-1103	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	Hollywood	SC	USA	\N	\N	\N	\N	843-889-1199 ReeseC: 843-729-1103
2218	Brandon Lizana	Down South Fabrication	brandon.lizana@downsouthcr.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Production Manager	\N	TX	\N	\N	\N	\N	\N	\N
2219	Estimators ()	D-SOL Welding Services	estimating@dsolweldingservices.com	817-454-0137	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Estimating Dept	\N	TX	\N	\N	\N	\N	\N	817-454-0137
2220	Nick Barnim	Eastwood Manufacturing	nbarnim@eastwood88.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	BDM	\N	CA	\N	\N	\N	\N	\N	\N
2221	Martha Sanchez	Eiffel Steel	martha@eiffelsd.com	619-478-7028	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	CA	\N	\N	\N	\N	\N	619-478-7028
2222	Barton Decker	El Dorado Steel	barton@eldoradosteel.com	8174093060	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	TX	\N	\N	\N	\N	\N	\N
2223	Cammie ()	Elevated Steel	cammie@elevatedsteel.com	(770) 334-3821	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainWoman	\N	GA	\N	\N	\N	\N	\N	(770) 334-3821
2224	Dilberto Carpio	Empire City Iron Works	dcarpio@eciw.com	718-361-0100Cell 646-242-6449	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Sr PM	\N	NY	\N	\N	\N	\N	\N	718-361-0100Cell 646-242-6449
2225	Nathan Whitehead	Evolve Steel	nwhitehead@kelleysteel.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	TX	\N	\N	\N	\N	\N	\N
2226	Walt Atchley	Excel Steel	excel@excelsteelcorp.biz	214-350-0639	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	214-350-0639
2227	Shaune Turpin	EZ Steel	shaune.turpin@ezsteel.ca	780-980-2001	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	GM	\N	\N	CANADA	\N	\N	\N	\N	\N
2228	Daniel ()	Falcon Steel Fabricators	daniel@falconsteelfab.com	281-227-6556	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	281-227-6556
2229	Mel Figueroa	Figueroa Iron Works	melfiw@sbcglobal.net	626-442-3360 MelC:909-714-6220	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	President	\N	CA	\N	\N	\N	\N	\N	626-442-3360 MelC:909-714-6220
2230	Steve Morgan	Fischbeck Welding	stevem@fischbeckwelding.com	830-625-3249	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP Development	\N	TX	\N	\N	\N	\N	\N	830-625-3249
2231	Mike Wilson	Fortress Steel Services	mike@fortresssteel-de.com	302-292-3065	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	MD	\N	\N	\N	\N	\N	302-292-3065
2232	Neil ()	Fritz Structural Steel	neil@fritzsteel.com	256-635-6252	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	AL	\N	\N	\N	\N	\N	256-635-6252
2233	Shaun Twigg	George Third & Son	shaun@gthird.com	1 604-639-1708	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	\N	CANADA	\N	\N	\N	\N	1 604-639-1708
2234	Brett Glassey	Glassey Steel Works	brett@glasseysteelworks.com	O: 801-878-7624 C: 801-656-9839	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Owner	\N	UT	\N	\N	\N	\N	\N	O: 801-878-7624 C: 801-656-9839
2235	Eric ()	GLOBAL METAL WORKS & ERECTORS INC	eric@globalmwe.com	253.572.5363	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	WA	\N	\N	\N	\N	\N	253.572.5363
2236	Johan ()	Glotzen Holding	aacowboy@dc.rr.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	CA	\N	\N	\N	\N	\N	\N
2237	Kevin Clarke	Grogan-Hazel Steel	kclarke@ghsteel.net	713-466-7501	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	TX	\N	\N	\N	\N	\N	713-466-7501
2238	Dustin Spiers	Gulf Island	dspiers@gulfisland.com	713-714-6100	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	TX	\N	\N	\N	\N	\N	713-714-6100
2239	Jeremy ()	Henderson Fab	jeremyh@hendersonfab.com	(770) 922-1678	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP	\N	GA	\N	\N	\N	\N	\N	(770) 922-1678
2240	Travis Rex	Houser Fabrication	travis@houserfabrication.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Estimator	Madisonville	TX	USA	\N	\N	\N	office@houserfabrication.com	936-349-0185
2241	Jennifer Espinoza	Irontek	jennifer@irontektx.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	\N
2242	Riley Drennen	J.A.McMahon	riley@jamcmahon.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	OH	\N	\N	\N	\N	\N	\N
2243	Will Talton	Jackson Steel Inc	will@jacksonsteelinc.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	NC	\N	\N	\N	\N	\N	\N
2244	Benjamin Moser	Jay Steel, LLC	ben4steel@jaysteel.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	APM	\N	NH	\N	\N	\N	\N	\N	\N
2245	Scott Davis	JBC Steel Products	sdavis@jbssteel.com	214-340-1510	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	TX	\N	\N	\N	\N	\N	214-340-1510
2246	()	JC Steel LLC	juangarci7889@icloud.com	817-936-4818	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	817-936-4818
2247	Lyn ()	Jestex Inc	\N	713-921-7187	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Drafting Manager	\N	TX	\N	\N	\N	\N	\N	713-921-7187
2248	Michael Kline	Junior Steel	mkline@juniorsteel.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	CA	\N	\N	\N	\N	\N	\N
2249	Eric Gurney	JWC Steel	egurney@jwcsteel.com	860-296-5517	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	CT	\N	\N	\N	\N	\N	860-296-5517
2250	Viji Kuruvilla	Lexicon, Inc.	vijik@lexicon-inc.com	Viji C: 501-517-1594	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	AR	\N	\N	\N	\N	\N	Viji C: 501-517-1594
2251	Ed Varias	LMB Steel Structures	\N	979-693-6766	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Director of Engineering	\N	TX	\N	\N	\N	\N	\N	979-693-6766
2252	Chris Luckey	LNC Fabrication	chrisl@lncfab.com	409-769-0403	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Estimating	\N	TX	\N	\N	\N	\N	\N	409-769-0403
2253	John Bornemann	LWI MetalWorks	\N	(802) 888-2394	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	GM	\N	VT	\N	\N	\N	\N	\N	(802) 888-2394
2254	Carmine Marcelli	Marcelli Steel	marcellisteel@gmail.com	(203) 917-3942	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Owner	\N	CT	\N	\N	\N	\N	\N	(203) 917-3942
2255	Cindi Kuehn	Marcelli Steel & Metal Works	kuehnc@worthconstruction.com	203.797.8788	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	CT	\N	\N	\N	\N	\N	203.797.8788
2256	John ()	Martin Steel & Iron	johnh@martinsteelandironinc.com	O: 801-280-1254 C: 801-558-9556	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Owner	\N	UT	\N	\N	\N	\N	\N	O: 801-280-1254 C: 801-558-9556
2257	Luis Medrano	Mastercraft Metal Works	lmmastercraft@yahoo.com	210-815-2310	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	210-815-2310
2258	Karen Olson	McKinney Steel	kolson@mckinneysteel.com	(847)746-3344	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Secretary	\N	IL	\N	\N	\N	\N	\N	(847)746-3344
2259	Richard Bass	Metal Tech of Murfreesboro, Inc	richard.bass@metaltechnc.com	252.398.4041 ext. 290	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Shop Manager	\N	NC	\N	\N	\N	\N	\N	252.398.4041 ext. 290
2260	John Ready	Mid-Park Highway	jready@mid-park.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Operations Manager	\N	KY	\N	\N	\N	\N	\N	\N
2261	Macy Archer	Milestone Metals	marcher@milestonemetals.com	281-448-9151	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Estimator	\N	TX	\N	\N	\N	\N	\N	281-448-9151
2262	Steven Kipp	Miller Industries LLC	skipp@millc.com	(810) 373-0322	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	MI	\N	\N	\N	\N	\N	(810) 373-0322
2263	Scott ()	Miscellaneous Specialties	miscspec@sbcglobal.net	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	Tomball	TX	USA	\N	\N	\N	\N	281-351-1177
2264	Brian Jones	MMW Fabrication	bjones@mmwfabrication.com	817-284-4978	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	President	\N	TX	\N	\N	\N	\N	\N	817-284-4978
2265	Antonio Quintana	Monolith Steel Company	antonio@momolithsteel.us	661-809-3800	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	CA	\N	\N	\N	\N	\N	\N
2266	Robert McFate	Morkin & Sowards	jmcfate@morkinsowards.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	President	\N	MI	\N	\N	\N	\N	\N	\N
2267	Scott Sullivan	Muhlhauser Steel Inc	scotts@msisteel.com	909) 877-2792	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	GM	\N	CA	\N	\N	\N	\N	\N	\N
2268	Craig Rainbolt	NAFCO	crainbolt@nafcofab.com	205-591-5554 ex113	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Proposals Manager	\N	AL	\N	\N	\N	\N	\N	205-591-5554 ex113
2269	John Stein	Nasir & Associates	jstieb@nasir-associates.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	COO/MainMan	\N	MD	\N	\N	\N	\N	\N	\N
2270	Brian Green	NORTH COAST ERECTORS	bgreen@ncerectors.com	360-298-8018	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	WA	\N	\N	\N	\N	\N	360-298-8018
2271	Billy North	North Fabrication	sales@northfabrication.com	512-520-9080	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	512-520-9080
2272	Pedro ()	OBA Steel Fabricators	obafabricating@hotmail.com	469-544-7466	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	TX	\N	\N	\N	\N	\N	469-544-7466
2273	Adrian Lopez	P&P Steel Fab	adrian@ppsteelfab.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Owner	\N	TX	\N	\N	\N	\N	\N	\N
2274	Newt Huffman	Pantera Ventures	newt@pantera-ventures.com	817-886-8880	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP	\N	TX	\N	\N	\N	\N	\N	817-886-8880
2275	Rebecca Hughes	Patriot Trinity	hughesr@patrioterectors.com	O: 512)894-9057 C: (737)226-2692	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Detailing Manager	\N	TX	\N	\N	\N	\N	\N	O: 512)894-9057 C: (737)226-2692
2276	Bennett Honigfort	Penn Services	bennetth@pennservicesllc.com	Cell: 314-437-9942	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	MO	\N	\N	\N	\N	\N	Cell: 314-437-9942
2277	James Varner	Plyler Fabrication	jvarner@plylerbuilds.com	Jvarner@plylerbuilds.com	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainManPM	\N	TX	\N	\N	\N	\N	\N	(903) 893-6393
2278	Fallyn Bugaj	Postel Group	fallyn@postelgroup.com	C: 409-692-9436 O: 281-227-2200 x271	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Detailing Manager	\N	TX	\N	\N	\N	\N	\N	C: 409-692-9436 O: 281-227-2200 x271
2279	Jason Bahamonde	Precision Build (Florida Structural Steel)	jbahamonde@precisionbuild.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP of Fabrication	\N	FL	\N	\N	\N	\N	\N	\N
2280	Amelia ()	Precision Structural Iron	orders@psiutahsteel.com	385-685-0044	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainWoman	\N	UT	\N	\N	\N	\N	\N	385-685-0044
2281	Brad Hisky	Process Equipment & Controls	bhisky@pecnow.com	C: 706-870-8510	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	GA	\N	\N	\N	\N	\N	C: 706-870-8510
2282	Roberta Russo	Promein Steel LLC	roberta.russo@promeinsteel.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	CT	\N	\N	\N	\N	\N	\N
2283	Steve Grandfield	Prospect Steel, a Division of Lexicon, Inc.	steveg@lexicon-inc.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	COO	\N	AR	\N	\N	\N	\N	\N	\N
2284	Tom Leopold	Quality Welding and Fab	t.leopold@qualityweldingandfab.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	OH	\N	\N	\N	\N	\N	\N
2285	Kelly Ragsdale	Ragsdale Steel	kelly@ragsdalesteel.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	President	\N	MO	\N	\N	\N	\N	\N	\N
2286	David Kopecky	Ranger Steel, Inc.	dave@rangeris.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Executive Director	Maysville	KY	USA	\N	\N	\N	gabriel@rangeris.com	6065840818
2287	()	RCM Steel	info@rcmsteel.net	713-566-1745	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	713-566-1745
2288	Nathan Casper	Rightway Steel	nathan@rightway-steel.com	Nath: 801.792.5694 Zecha : 801-970-3899	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Sr PM	\N	UT	\N	\N	\N	\N	\N	Nath: 801.792.5694 Zecha : 801-970-3899
2289	Tracy ()	Rimk Industries Inc	tracy@rimkind.ca	1 403-236-8777	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	\N	CANADA	\N	\N	\N	\N	\N
2290	Roy Vara	Robert S Henry Custom Metal Buildings	sales@robertshenry.com	713-227-0105	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	713-227-0105
2291	Chris Steiglich	S & S Steel Contrcution	csteglich@sssteelfab.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	UT	\N	\N	\N	\N	\N	\N
2292	Martin ()	Salazar Fab	martin@salazarfab.com	713-492-0253	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	713-492-0253
2293	Lloyd Huyett	Scenic Ridge Company	lhuyett@scenicridge.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	PA	\N	\N	\N	\N	\N	\N
2294	Brandon ()	Silo Steel	brandon@silosteel.com	(918) 742-4600	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	GM	\N	OK	\N	\N	\N	\N	\N	918-933-7672
2295	Jamie Howland	Silver Hawk Fabrication	jhowland@hoffmanninc.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Steel Fabrication Manager	\N	IA	\N	\N	\N	\N	\N	\N
2296	Stephanie McGuire	Sisson Steel, Inc	steph@sissonsteel.com	812-354-8701 ext 22	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	IN	\N	\N	\N	\N	\N	812-354-8701 ext 22
2297	Brian Cabral	SL Chasse Welding & Fabricating, Inc.	brianc@slchassesteelfab.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	NH	\N	\N	\N	\N	\N	\N
2298	Brandon Spreen	SMS Superior Metal	bspreen@smsmetalco.com	830-388-7644	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	TX	\N	\N	\N	\N	\N	830-388-7644
2299	()	Southern Son's Fabrication and Welding	justin@ssfabwelding.com	512-585-9425	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	512-585-9425
2300	Ted Dominguez	Southern Tech Fab	ted@southerntechfab.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	President	\N	TX	\N	\N	\N	\N	\N	\N
2301	Carlos Socarras	Southern Welding Industrial Services	csocarras@southernwelding.com	469-517-0410	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP Operations	\N	TX	\N	\N	\N	\N	\N	469-517-0410
2302	Brent Clark	Southwest Steel Fabrication	bclark@swsteelfab.com	913-422-5500	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	President	\N	MO	\N	\N	\N	\N	\N	913-422-5500
2303	Michael ()	Stapleton Steel Services, Inc	michael@stapletonsteelservices.com	281-353-8844	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	281-353-8844
2304	Josh Gervais	Steel 2000 Inc.	josh@steel2000inc.com	O(705)855-0803, C(705)618-0321	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	\N	CANADA	\N	\N	\N	\N	O(705)855-0803, C(705)618-0321
2305	Rand Matter	Steel Fab Inc - WA	rand@steel-fab.com	360-435-5564	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP Operations	\N	WA	\N	\N	\N	\N	\N	360-435-5564
2306	Cody Multer	Steel Fab Texas Miscellaneous Iron	cmulter@texas-iron.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Quality Manager	\N	TX	\N	\N	\N	\N	\N	\N
2307	Damon Johnson	Steelhead Metal & Fabrication	\N	503-763-0114	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	Salem	OR	USA	\N	\N	\N	\N	503-763-0114
2308	Jeremy Harrell	Steel Pro	jeremy@steelproms.com	(662) 456-3004	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	MS	\N	\N	\N	\N	\N	\N
2309	Kris ()	Structural Metals of Kansas	\N	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Owner	\N	KS	\N	\N	\N	\N	\N	\N
2310	Eric Lemoine	Sturo Metal	elemoine@sturometal.com	14188332107	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	\N	CANADA	\N	\N	\N	\N	14188332107
2311	Mark Talbot	Superior Rigging	m.talbot@superiorrigging.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	GA	\N	\N	\N	\N	\N	\N
2312	Joshua Stidham	Texas Star Fabrication & Equipment Inc	texasstarfab@aol.com	(903) 469-3383	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP	\N	TX	\N	\N	\N	\N	\N	\N
2313	Nick Rodriguez	Texas Steel Buildings	nick@texassteel.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	\N
2314	Terence Schaeffer	Tex Fab	tschaeffer@texfab.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Sales & Estimating Manager	\N	TX	\N	\N	\N	\N	\N	\N
2315	Robbie Faulkner	The L.C. Whitford Co., Inc.	rfaulkner@lcwhitford.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	NY	\N	\N	\N	\N	\N	\N
2316	Scott Cote	The TroubleShooters	scote@tshooters.net	713-695-9195	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Owner	\N	TX	\N	\N	\N	\N	\N	713-695-9195
2317	John Eastberg	Transco Industries, Inc.	\N	503-256-1955 x218	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	Portland	\N	USA	\N	\N	\N	\N	503-256-1955 x218
2318	Rick Brown	Transco Northwest Inc.	rbrown@transconw.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	President	\N	WA	\N	\N	\N	\N	\N	\N
2319	Andras Kenedi	TRESMAN STEEL LTD.	akenedi@tresmansteel.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP	\N	\N	CANADA	\N	\N	\N	\N	\N
2320	Lee McGehee	Tri-Fab Steel, Industrial	trifabcutshop@mindspring.com	205-252-6100	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	AL	\N	\N	\N	\N	\N	205-252-6100
2321	MIke Mullen	Triumph Fabrication	mike.mullen@triumphfab.com	210-219-4178	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Sales	\N	TX	\N	\N	\N	\N	\N	210-219-4178
2322	Gary ()	TroCoFab	\N	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PE	\N	MO	\N	\N	\N	\N	\N	\N
2323	Cody Cargile	TSGC, INC., INDUSTRIAL FABRICATORS OF CORPUS CHRISTI	codycargile@indfabcc.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP	\N	TX	\N	\N	\N	\N	\N	\N
2324	Jeffrey Godin	United Steel, Inc.	jgodin@unitedsteel.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	VP Estimating	\N	CT	\N	\N	\N	\N	\N	\N
2325	Charlie ()	Upright Iron Works Inc	charlie@uprightiron.com	219.922.1994	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	IN	\N	\N	\N	\N	\N	219.922.1994
2326	Nate Nelson	Utah Pacific Bridge & Steel	nate@utahpacificbridge.com	801-785-3557	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	UT	\N	\N	\N	\N	\N	801-785-3557
2327	Fred Meade	Utah Steel	fred.meade@utahsteel.com	435) 656-9567 ex 0820	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Detailing Manager	\N	UT	\N	\N	\N	\N	\N	435) 656-9567 ex 0820
2328	Robert Hickman	V & S Capital Steel	robert.hickman@vscapitalsteel.com	609-882-6983 C:267-987-8638	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	GM	\N	NJ	\N	\N	\N	\N	\N	609-882-6983 C:267-987-8638
2329	Stan	Valley Steel LLC	sstanton@valleysteelco.com	7022281510	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	Las Vegas	NV	USA	\N	\N	\N	\N	702-228-1510
2330	Reggie Davis	Variable Steel Unlimited	rdavis@variablesteel.com	678-368-6474	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	GA	\N	\N	\N	\N	\N	678-368-6474
2331	Nick ()	Vestal Steel	nick@vestalsteel.com	210-651-4333	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	210-651-4333
2332	Jessica ()	Vestal Steel Specialties, Inc	jessica@vestalsteel.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	\N	\N	TX	\N	\N	\N	\N	\N	\N
2333	Ryan Bas	Victoria Steel	ryan.b@victoriasteel.net	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Owner	\N	\N	CANADA	\N	\N	\N	\N	\N
2334	Judd Heredos	Wabash Steel Company	judd.heredos@wabashsteel.biz	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Director	\N	IN	\N	\N	\N	\N	\N	\N
2335	Justin Sawyer	Warren Fabricating & Machining Corp.	jcsatv@outlook.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	National Sales Manager	\N	OH	\N	\N	\N	\N	\N	\N
2336	Jill VanDeel	Warrenton Steel	jillvandeel@warrentonsteel.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	GM	Warrenton	MO	USA	\N	\N	\N	\N	636-456-8400
2337	Eric Welsh	Washington Iron Works, CA	ewelsh@washingtoniron.com	310) 327-8660	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Detailing Manager	\N	CA	\N	\N	\N	\N	\N	310) 327-8660
2338	John Townsend	Weitz Supply Chain, LLC	john.townsend@weitz.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Project Manager - Steel	\N	IA	\N	\N	\N	\N	\N	\N
2339	Jaime Montelongo	Wembley Metal Buildings	jmontelongo@wembleymb.com	\N	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Engineering Manager	\N	TX	\N	\N	\N	\N	\N	\N
2340	Michael Thoeny	Wesbridge Steelworks LTD	miket@wesbridge.com	1 604-946-8618	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	Detailing Manager	\N	\N	CANADA	\N	\N	\N	\N	1 604-946-8618
2341	Fernando Rabago	White's Steel Inc.	frabago@whitessteel.com	(760) 347-3401	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	PM	\N	CA	\N	\N	\N	\N	\N	\N
2342	Ben Hedrick	White Hawk Fabrication	b.hedrick@whitehawkinc.com	770) 425-5200	Steel Detailing	Lead	t	f	2025-06-21 12:27:15	0	\N	2025-06-21 12:27:15	2025-06-21 12:27:15	MainMan	\N	GA	\N	\N	\N	\N	\N	\N
2343	Patrick Porter	Thorough Built, LLC	pporter@thoroughbuiltllc.com	2566879312	Steel Detailing	Lead	t	f	2025-07-08 12:20:31	0	\N	2025-07-08 12:20:31	2025-07-08 12:20:31	\N	Chattanooga	TN	USA	\N	\N	\N	sales@thoroughbuiltllc.com	4238259353
2344	Tina Hakanen	Industrial Steel South	SouthDocs@industrial-steel.com	\N	Steel Detailing	Lead	t	f	2025-07-10 11:24:39	0	\N	2025-07-10 11:24:39	2025-07-10 11:24:39	DOCUMENT CONTROL SPECIALIST	Titusville	FL	USA	\N	\N	\N	\N	3212672341
2345	Bryan Clark	Bohemian Iron	bryan.bohemianiron@gmail.com	\N	Steel Detailing	Lead	t	f	2025-07-25 18:13:57	0	\N	2025-07-25 18:13:57	2025-07-25 18:13:57	\N	Longwood	FL	USA	\N	\N	\N	bryan@bohemianiron.net	4073231452
2346	Shridatt Prashad	RISA Management Corp.	shridatt@risacorp.com	\N	Steel Detailing	Lead	t	f	2025-08-01 12:06:03	0	\N	2025-08-01 12:06:03	2025-08-01 12:06:03	\N	Massapequa	NY	USA	\N	\N	\N	Shridatt@RisaCorp.com	7183612606
2347	Zack Sprouse	Kankakee Valley Steel	Zsprouse@kvsteel.net	\N	Steel Detailing	Lead	t	f	2025-08-06 20:37:33	0	\N	2025-08-06 20:37:33	2025-08-06 20:37:33	Project Manager	Wheatfield	IN	USA	\N	\N	\N	Zsprouse@kvsteel.net	(219) 828-4011
2348	Cynthia Kuehn	WORTH CONSTRUCTION CO., INC.	\N	\N	Steel Detailing	Lead	t	f	2025-08-08 10:40:33	0	\N	2025-08-08 10:40:33	2025-08-08 10:40:33	Vice President, Construction	Bethlehem Village	CT	USA	\N	\N	\N	\N	(203) 797-8788
2349	Eduardo Montes	GRUPO MONTES LLC	eduardo.montes@grupomontesllc.com	2211588987	Steel Detailing	Lead	t	f	2025-08-08 13:37:36	0	\N	2025-08-08 13:37:36	2025-08-08 13:37:36	Owner	Atlanta	GA	USA	\N	\N	\N	\N	2211588987
2350	Francisco Muro	Silver Oak Homes Inc.	\N	\N	Steel Detailing	Lead	t	f	2025-08-18 19:27:42	0	\N	2025-08-18 19:27:42	2025-08-18 19:27:42	\N	Winder	GA	USA	\N	\N	\N	\N	7709211550
2351	Wikum Gamage	D&M Steel INC.	wgamage@d-msteel.com	\N	Steel Detailing	Lead	t	f	2025-09-24 10:03:24	0	\N	2025-09-24 10:03:24	2025-09-24 10:03:24	\N	Los Angeles	CA	USA	\N	\N	\N	\N	(818) 896 2070
2352	Macade Jensen	R&M Engineering Consultants, LLC	macadej@rmstructural.com	\N	Steel Detailing	Lead	t	f	2025-10-16 10:14:25	0	\N	2025-10-16 10:14:25	2025-10-16 10:14:25	Sr. Project Engineer	Price	UT	USA	\N	\N	\N	macadej@rmstructural.com	801-263-3419
2353	Lisa Schanken	East Coast IronWorks LLC.	Lisa@eastcoastironmd.com	\N	Steel Detailing	Lead	t	f	2025-10-24 19:55:17	0	\N	2025-10-24 19:55:17	2025-10-24 19:55:17	\N	Owings	MD	USA	\N	\N	\N	\N	4438502005
2354	Steve Lyle	A2 Metals, LLC (dba A2 Fabrication)	steve@a2fab.com	\N	Steel Detailing	Lead	t	f	2025-11-20 09:43:24	0	\N	2025-11-20 09:43:24	2025-11-20 09:43:24	Project Manager	Milwaukie	OR	USA	\N	\N	\N	steve@a2fab.com	503.771.2000
2355	Chad Bludau	Bludau Fabrication	chad@bludaufab.com	3617984339	Steel Detailing	Lead	t	f	2026-01-08 09:58:35	0	\N	2026-01-08 09:58:35	2026-01-08 09:58:35	General Manager	Hallettsville	TX	USA	\N	\N	\N	\N	3613332042
2356	Venkateswara Rao	MAKSIM INFOTECH PVT LTD	gvrao@maksiminfotech.com	9849226760	Steel Detailing	Lead	t	f	2026-01-24 19:27:27	0	\N	2026-01-24 19:27:27	2026-01-24 19:27:27	Business & Delivery Manager	\N	DE	USA	\N	\N	\N	\N	9849226760
2357	Ringal Arulrajaa	Mekark Structures India Pvt Ltd	ringalarul.c@mekark.com	7825854806	Steel Detailing	Lead	t	f	2026-03-26 15:41:50	0	\N	2026-03-26 15:41:50	2026-03-26 15:41:50	\N	Chennai	TN	India	\N	\N	\N	admin@mekark.com	9790924754
2358	Mark Collis	Bevyhouse	collis@Bevyhouse.com	8056333111	Steel Detailing	Lead	t	f	2026-03-26 17:04:27	0	\N	2026-03-26 17:04:27	2026-03-26 17:04:27	\N	Ojai	CA	USA	\N	\N	\N	\N	8056333111
2359	Eric Bidigare	Rohmann Iron works	\N	\N	Steel Detailing	Lead	t	f	2026-04-02 19:20:17	0	\N	2026-04-02 19:20:17	2026-04-02 19:20:17	Project Manager	\N	MI	USA	\N	\N	\N	\N	0
2360	John Martel	All American Welding	johnm.aaw@gmail.com	\N	Steel Detailing	Lead	t	f	2026-04-07 15:40:52	0	\N	2026-04-07 15:40:52	2026-04-07 15:40:52	\N	West Palm Beach	FL	USA	\N	\N	\N	\N	5616531177
2361	a	a	\N	\N	Steel Detailing	Lead	t	f	2026-04-08 15:32:50	0	\N	2026-04-08 15:32:50	2026-04-08 15:32:50	\N	South Creek	WA	USA	\N	\N	\N	\N	9790924754
2362	Rick Campbell	OSKAM Welding & Machine LTD	richard@oskamwelding.com	2267933380	Steel Detailing	Lead	t	f	2026-04-09 19:54:30	0	\N	2026-04-09 19:54:30	2026-04-09 19:54:30	Estimator and Project Manager	\N	Ontario	CANADA	\N	\N	\N	\N	+1 519-822-8333
2363	Kameswaran Ravinthiran	William Hare India Pvt. Ltd	Kameswaran.Ravinthiran@hare.com	\N	Steel Detailing	Lead	t	f	2026-04-13 15:59:41	0	\N	2026-04-13 15:59:41	2026-04-13 15:59:41	Section Lead Commercial	Chennai	T N	India	\N	\N	\N	\N	044-40045100
2364	Enrique Soto	BAS Engineering	Esoto@bassteel.com	\N	Steel Detailing	Lead	t	f	2026-05-11 12:31:41	0	\N	2026-05-11 12:31:41	2026-05-11 12:31:41	Operations Manager	Rancho Cucamonga	CA	USA	\N	\N	\N	\N	9094842575
2365	Megan Brodfuehrer	ATM Steel	meganb@atmphx.com	\N	Steel Detailing	Lead	t	f	2026-05-14 12:56:32	0	\N	2026-05-14 12:56:32	2026-05-14 12:56:32	Project Manager	Phoenix	AZ	USA	\N	\N	\N	\N	(623) 582-3900
2366	Clip Class	LMC Industrial Contractors	\N	\N	Steel Detailing	Lead	t	f	2026-05-18 16:05:03	0	\N	2026-05-18 16:05:03	2026-05-18 16:05:03	Director of Engineering	Dansville	NY	USA	\N	\N	\N	\N	(585) 820-3706
2367	Andrew Sims	Empire Welding & Construction inc.	Andrew@empiretx.net	\N	Steel Detailing	Lead	t	f	2026-06-04 12:08:36	0	\N	2026-06-04 12:08:36	2026-06-04 12:08:36	Vice President	Weatherford	TX	USA	\N	\N	\N	\N	682-327-8317
2368	Gary Stokell	CADD Alta Drafting and Design Inc.	gstokell@caddalta.com	\N	Steel Detailing	Lead	t	f	2026-06-05 13:21:57	0	\N	2026-06-05 13:21:57	2026-06-05 13:21:57	Business Development &  Estimating	\N	Alberta	CANADA	\N	\N	\N	\N	(780) 570-3758
2369	Jason Hayes	Hayes Manufacturing Company	\N	\N	Steel Detailing	Lead	t	f	2026-06-12 17:12:59	0	\N	2026-06-12 17:12:59	2026-06-12 17:12:59	CEO	Pineville	LA	USA	\N	\N	\N	\N	3184870100
2370	Enoch Watt	EJ STEELFAB LLC	Sales@ejsteelfab.com	\N	Steel Detailing	Lead	t	f	2026-06-18 18:25:30	0	\N	2026-06-18 18:25:30	2026-06-18 18:25:30	\N	Sinking Spring	PA	USA	\N	\N	\N	\N	219-713-1402
2371	Amariah Britton	O'Connor	\N	\N	Steel Detailing	Lead	t	f	2026-07-01 13:03:16	0	\N	2026-07-01 13:03:16	2026-07-01 13:03:16	PreConstruction Assistant	Pinehurst	NC	USA	\N	\N	\N	\N	910.695.6824
2372	Christian Dominguez	A-FAB Industries LLC	cdominguez@afabindustries.com	\N	Steel Detailing	Lead	t	f	2026-07-01 13:09:28	0	\N	2026-07-01 13:09:28	2026-07-01 13:09:28	Office Manager	Fort Worth	TX	USA	\N	\N	\N	\N	(817) 337-4776
2373	Devin Gerland	Jackrabbit	dgerland@jackrabbitmig.com	\N	Steel Detailing	Lead	t	f	2026-07-01 13:20:24	0	\N	2026-07-01 13:20:24	2026-07-01 13:20:24	Vp of Operations	Bryan	TX	USA	\N	\N	\N	\N	979.446.0073
2374	Mike Hansen	Hilo Erectors,TRL Enterprises LLC	mhansen@hiloerectors.com	\N	Steel Detailing	Lead	t	f	2026-07-27 11:15:08	0	\N	2026-07-27 11:15:08	2026-07-27 11:15:08	Detailing Manager	Yuba City	CA	USA	\N	\N	\N	\N	530.751.0354
2375	Cody Cargile	Industrial fabricators of corpus christi	codycargile@indfabcc.com	\N	Steel Detailing	Lead	t	f	2026-07-28 17:06:22	0	\N	2026-07-28 17:06:22	2026-07-28 17:06:22	\N	Corpus Christi	TX	USA	\N	\N	\N	\N	0
2376	Rajesh Kittusamy	TEKS Engineering	Rajesh.k@teksengineering.com.au	\N	Steel Detailing	Lead	t	f	2026-07-28 18:26:42	0	\N	2026-07-28 18:26:42	2026-07-28 18:26:42	Project Manager	Adelaide,	SA	AUSTRALIA	\N	\N	\N	\N	0435 727 657
2377	ABDUL RAHMAN ZIA	Brick City Metals	\N	\N	Steel Detailing	Lead	t	f	2026-08-01 11:02:39	0	\N	2026-08-01 11:02:39	2026-08-01 11:02:39	Project Engineer	Ocala	FL	USA	\N	\N	\N	\N	352-873-2554
2378	Roni	KR Welding Inc.,	krw.roni@gmail.com	8188134031	Steel Detailing	Lead	t	f	2026-08-17 22:57:37	0	\N	2026-08-17 22:57:37	2026-08-17 22:57:37	\N	Los Angeles	CA	USA	\N	\N	\N	\N	8188134031
2379	Mr.Imre Szombathy	Cody Builders Supply, Inc	\N	\N	Steel Detailing	Lead	t	f	2021-02-05 07:55:53	0	\N	2021-02-05 07:55:53	2021-02-05 07:55:53	\N	Austin	Texas	USA	\N	\N	\N	\N	(512) 339-9834
2380	Mr.Peter / Mr.Alan	BEN ASH IRON WORKS Inc.	\N	\N	Steel Detailing	Lead	t	f	2021-02-05 10:48:18	0	\N	2021-02-05 10:48:18	2021-02-05 10:48:18	\N	Compton	CA	USA	\N	\N	\N	\N	+1 310-635-0170
2381	Mr.Evan	A & B FABRICATORS, INC.	\N	\N	Steel Detailing	Lead	t	f	2021-02-05 11:23:57	0	\N	2021-02-05 11:23:57	2021-02-05 11:23:57	\N	Auburn	Washington	USA	\N	\N	\N	\N	+1 206-763-2600
2382	MELINDA	BINZEL INDUSTRIES, LLC.	\N	\N	Steel Detailing	Lead	t	f	2021-02-06 07:00:27	0	\N	2021-02-06 07:00:27	2021-02-06 07:00:27	\N	Lockport	IL	USA	\N	\N	\N	\N	815 726 6281
2383	ANAND	STRUZON TECHNOLOGIES INC	\N	\N	Steel Detailing	Lead	t	f	2021-02-06 11:21:17	0	\N	2021-02-06 11:21:17	2021-02-06 11:21:17	\N	New York	New York	USA	\N	\N	\N	\N	+1 404 902 6781
2384	Mr.Alex	Northern Weldarc Ltd.	\N	\N	Steel Detailing	Lead	t	f	2021-02-06 11:45:40	0	\N	2021-02-06 11:45:40	2021-02-06 11:45:40	\N	Airdrie	Alberta	CANADA	\N	\N	\N	\N	+1 780-467-1522
2385	MELINDA	LOCKPORT STEEL, LLC.	\N	\N	Steel Detailing	Lead	t	f	2021-02-08 10:36:57	0	\N	2021-02-08 10:36:57	2021-02-08 10:36:57	\N	Lockport	IL	USA	\N	\N	\N	\N	815 726 6281
2386	Gregg Kobe	XL INDUSTRIAL SERVICES ,INC	\N	\N	Steel Detailing	Lead	t	f	2021-02-08 10:50:54	0	\N	2021-02-08 10:50:54	2021-02-08 10:50:54	\N	La Porte	IN	USA	\N	\N	\N	\N	219-362-8005 X430
2387	EVAN	A & B FABRICATORS, INC.	\N	\N	Steel Detailing	Lead	t	f	2021-02-09 06:02:58	0	\N	2021-02-09 06:02:58	2021-02-09 06:02:58	\N	Auburn	Washington	USA	\N	\N	\N	\N	206-763-2600
2388	SCOTT	S & P FABRICATION SERVICES	\N	\N	Steel Detailing	Lead	t	f	2021-02-19 11:28:17	0	\N	2021-02-19 11:28:17	2021-02-19 11:28:17	\N	Anaheim	CA	USA	\N	\N	\N	\N	\N
2389	GRAEME WEYLAND	Gem City Steel Supply Inc	\N	\N	Steel Detailing	Lead	t	f	2021-02-23 07:13:47	0	\N	2021-02-23 07:13:47	2021-02-23 07:13:47	\N	Marietta	GA	USA	\N	\N	\N	\N	770 422 0637
2390	Mr.Omar El Kaakour	Premsteel Fabricators Inc	\N	\N	Steel Detailing	Lead	t	f	2021-03-18 13:23:03	0	\N	2021-03-18 13:23:03	2021-03-18 13:23:03	\N	Calgary	Alberta	CANADA	\N	\N	\N	\N	403-720-6907
2391	TJ	STEEL TECH FABRICATORS INC	\N	\N	Steel Detailing	Lead	t	f	2021-09-27 14:36:43	0	\N	2021-09-27 14:36:43	2021-09-27 14:36:43	\N	Rochester	New York	USA	\N	\N	\N	\N	585-323-2660
2392	Jesse Beardon	KDM Steelworks, Inc.	\N	\N	Steel Detailing	Lead	t	f	2021-10-27 07:50:36	0	\N	2021-10-27 07:50:36	2021-10-27 07:50:36	\N	Loveland	CO	USA	\N	\N	\N	\N	+1 7209755110
2393	Chris Targos	Bridgeport Steel Sales, Inc.	\N	\N	Steel Detailing	Lead	t	f	2021-11-02 13:45:31	0	\N	2021-11-02 13:45:31	2021-11-02 13:45:31	\N	Chicago	IL	USA	\N	\N	\N	\N	(312)326-4800
2394	Wendy Garcia	JC STEEL FABRICATORS, INC.	\N	\N	Steel Detailing	Lead	t	f	2021-11-30 10:35:21	0	\N	2021-11-30 10:35:21	2021-11-30 10:35:21	\N	Henderson	Nevada	USA	\N	\N	\N	\N	\N
2395	Madelynn Gallman	CSD Services	\N	\N	Steel Detailing	Lead	t	f	2022-03-23 07:56:12	0	\N	2022-03-23 07:56:12	2022-03-23 07:56:12	\N	Friendswood	Texas	USA	\N	\N	\N	\N	281-992-0888
2396	Lindley Everton	Erection & Welding Contractors, LLC	\N	\N	Steel Detailing	Lead	t	f	2022-04-04 06:58:46	0	\N	2022-04-04 06:58:46	2022-04-04 06:58:46	\N	Berlin	CT	USA	\N	\N	\N	\N	(860) 828-9353 ext. 116
2397	Tony Bagatourian	Rocky Point Iron Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-04-30 08:30:04	0	\N	2022-04-30 08:30:04	2022-04-30 08:30:04	\N	Riverside	CA	USA	\N	\N	\N	\N	818-624-5648
2398	TJ	STEEL TECH FABRICATORS INC,	\N	\N	Steel Detailing	Lead	t	f	2022-06-17 10:29:20	0	\N	2022-06-17 10:29:20	2022-06-17 10:29:20	\N	Rochester	New York	USA	\N	\N	\N	\N	585-323-2660
2399	JINNA MARTIN	MIKE OWEN FABRICATION, INC.	\N	\N	Steel Detailing	Lead	t	f	2022-08-23 05:16:50	0	\N	2022-08-23 05:16:50	2022-08-23 05:16:50	\N	Bakersfield	CA	USA	\N	\N	\N	\N	6613871703
2400	Kristi Schlitt	BK WELDING, INC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-28 08:58:33	0	\N	2022-09-28 08:58:33	2022-09-28 08:58:33	\N	Loveland	CO	USA	\N	\N	\N	\N	970-685-4435
2401	Danny Moynihan	STURDI IRON, INC.	\N	\N	Steel Detailing	Lead	t	f	2022-09-29 14:45:55	0	\N	2022-09-29 14:45:55	2022-09-29 14:45:55	\N	Frankfort	IL	USA	\N	\N	\N	\N	708-679-1174
2402	Greg Schlickman	STEEL FABRICATING, INC.	\N	\N	Steel Detailing	Lead	t	f	2022-10-10 13:53:37	0	\N	2022-10-10 13:53:37	2022-10-10 13:53:37	\N	Rockford	IL	USA	\N	\N	\N	\N	(815) 977-5355
2403	Peter Doctors, P.E.	Delta Welding and Fabrication	\N	\N	Steel Detailing	Lead	t	f	2022-10-19 12:17:44	0	\N	2022-10-19 12:17:44	2022-10-19 12:17:44	\N	Goleta	CA	USA	\N	\N	\N	\N	805-450-0737
2404	Jim Bell	Bell Bros. Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-11-21 08:10:19	0	\N	2022-11-21 08:10:19	2022-11-21 08:10:19	\N	Riverside	CA	USA	\N	\N	\N	\N	951.784.0903
2405	Steve Pace	Miller's Fab & Weld Corp.	\N	\N	Steel Detailing	Lead	t	f	2022-11-25 08:30:41	0	\N	2022-11-25 08:30:41	2022-11-25 08:30:41	\N	Riverside	CA	USA	\N	\N	\N	\N	+1 951-359-3100
2406	Luiza Reynolds	Reynolds Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2022-12-06 08:19:31	0	\N	2022-12-06 08:19:31	2022-12-06 08:19:31	\N	Williamsport	Pennsylvania	USA	\N	\N	\N	\N	570 323-4663
2407	Nelson Madruga	Unlimited Welding Inc	\N	\N	Steel Detailing	Lead	t	f	2022-12-17 07:35:11	0	\N	2022-12-17 07:35:11	2022-12-17 07:35:11	\N	Winter Springs	FL	USA	\N	\N	\N	\N	407-327-3333
2408	Erwin Valdriz	J&D Fabrication & Repair	\N	\N	Steel Detailing	Lead	t	f	2022-12-29 11:46:12	0	\N	2022-12-29 11:46:12	2022-12-29 11:46:12	\N	Santa Maria	CA	USA	\N	\N	\N	\N	(805) 928-9674
2409	Erik Lowe	Vector Custom Fabricating	\N	\N	Steel Detailing	Lead	t	f	2023-01-11 04:58:27	0	\N	2023-01-11 04:58:27	2023-01-11 04:58:27	\N	Chicago	IL	USA	\N	\N	\N	\N	+1 312-421-5161
2410	Ron Gossman	Mckinney Steel & Sales, Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-01-27 14:43:11	0	\N	2023-01-27 14:43:11	2023-01-27 14:43:11	\N	Zion	IL	USA	\N	\N	\N	\N	P: 847-746-3344
2411	Matt Brown	Trinity Steel Corporation	\N	\N	Steel Detailing	Lead	t	f	2023-02-20 05:02:58	0	\N	2023-02-20 05:02:58	2023-02-20 05:02:58	\N	Santa Paula	CA	USA	\N	\N	\N	\N	(805) 648-3486
2412	Kaylah Williams	Whitley Steel Co.,Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-02-20 05:07:59	0	\N	2023-02-20 05:07:59	2023-02-20 05:07:59	\N	Jacksonville	FL	USA	\N	\N	\N	\N	904-289-7471
2413	Nicole Hogan	New Jersey Boom & Erectors, Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-03-28 08:39:23	0	\N	2023-03-28 08:39:23	2023-03-28 08:39:23	\N	Mount Pocono	Pennsylvania	USA	\N	\N	\N	\N	(570)-620-1546
2414	Bronny Samardzija	Gremp Steel Co.	\N	\N	Steel Detailing	Lead	t	f	2023-03-29 05:57:26	0	\N	2023-03-29 05:57:26	2023-03-29 05:57:26	\N	Posen	IL	USA	\N	\N	\N	\N	708-489-1000
2415	Robert Singh	All Pro Fabricators & Erectors, Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-03-31 14:11:50	0	\N	2023-03-31 14:11:50	2023-03-31 14:11:50	\N	Davie	FL	USA	\N	\N	\N	\N	(954) 797-7300
2416	Charlotte Myall	DISCOVERY ENGINE	\N	\N	Steel Detailing	Lead	t	f	2023-03-31 15:12:38	0	\N	2023-03-31 15:12:38	2023-03-31 15:12:38	\N	Eton	Ontario	CANADA	\N	\N	\N	\N	+1 437-772-4340
2417	JASEN EATON	DIXIE METAL PRODUCTS, INC.	\N	\N	Steel Detailing	Lead	t	f	2023-05-27 06:21:34	0	\N	2023-05-27 06:21:34	2023-05-27 06:21:34	\N	Ocala	FL	USA	\N	\N	\N	\N	(352) 873-2554
2418	Omar El Kaakour	LINMARK STEEL INC.	\N	\N	Steel Detailing	Lead	t	f	2023-06-14 12:01:31	0	\N	2023-06-14 12:01:31	2023-06-14 12:01:31	\N	Rocky View County	Alberta	CANADA	\N	\N	\N	\N	(587) 572 4425
2419	Travis Nishi	Fresno Fab Tech, Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-06-15 14:46:14	0	\N	2023-06-15 14:46:14	2023-06-15 14:46:14	\N	Sanger	CA	USA	\N	\N	\N	\N	+1 559-875-9800
2420	Daniel Walton	Copper Mountain Construction LLC	\N	\N	Steel Detailing	Lead	t	f	2023-06-23 08:43:51	0	\N	2023-06-23 08:43:51	2023-06-23 08:43:51	\N	Sparks	Nevada	USA	\N	\N	\N	\N	775.636.0420
2421	Danny Hernandez	Martin's Steel Works Inc	\N	\N	Steel Detailing	Lead	t	f	2023-07-03 10:22:53	0	\N	2023-07-03 10:22:53	2023-07-03 10:22:53	\N	Vacaville	CA	USA	\N	\N	\N	\N	(707) 678-6120
2422	Alex Davidson	Parsons Steel Builders, Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-07-03 11:16:33	0	\N	2023-07-03 11:16:33	2023-07-03 11:16:33	Detailing Manager	Tucson	AZ	USA	\N	\N	\N	\N	520-887-6207
2423	Jeremy Long	ISM Industries, Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-07-28 14:23:21	0	\N	2023-07-28 14:23:21	2023-07-28 14:23:21	Project Management	Vidor	Texas	USA	\N	\N	\N	\N	(409) 769-7841
2424	Galen Fowler	Bridge Brothers, Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-08-21 07:03:07	0	\N	2023-08-21 07:03:07	2023-08-21 07:03:07	\N	Pickens	South Carolina	USA	\N	\N	\N	\N	866.258.3401
2425	Jose Reyes	Hunt Steel	\N	\N	Steel Detailing	Lead	t	f	2023-08-21 07:13:46	0	\N	2023-08-21 07:13:46	2023-08-21 07:13:46	Project Administrator	Las Vegas	Nevada	USA	\N	\N	\N	\N	702.912.4868
2426	John Robinson	Lightning Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-09-15 10:55:52	0	\N	2023-09-15 10:55:52	2023-09-15 10:55:52	President	Zephyrhills	FL	USA	\N	\N	\N	\N	(813)973-3032
2427	Ehab Girgis	G Plus Engineering Inc.	\N	\N	Steel Detailing	Lead	t	f	2023-09-25 06:32:55	0	\N	2023-09-25 06:32:55	2023-09-25 06:32:55	President	Calgary	Alberta	CANADA	\N	\N	\N	\N	(403) 617-4801
2428	Mary-Jo Ellis	Riverside Iron, LLC	\N	\N	Steel Detailing	Lead	t	f	2023-12-28 04:52:43	0	\N	2023-12-28 04:52:43	2023-12-28 04:52:43	Estimator & Project Manager	Gouverneur	New York	USA	\N	\N	\N	\N	315-535-4864
2429	Roy Gibson	Madlyn Metal Fab LLC	\N	\N	Steel Detailing	Lead	t	f	2024-04-04 10:13:45	0	\N	2024-04-04 10:13:45	2024-04-04 10:13:45	\N	Washougal	Washington	USA	\N	\N	\N	\N	360-693-1019
2430	David Rushing	Precision Iron Fabrication, LLC	\N	\N	Steel Detailing	Lead	t	f	2024-04-24 09:25:20	0	\N	2024-04-24 09:25:20	2024-04-24 09:25:20	\N	Royse City	Texas	USA	\N	\N	\N	\N	(972) 636-7581
2431	Adam R. Patrick	ARP Welding LLC	\N	\N	Steel Detailing	Lead	t	f	2024-06-05 05:27:58	0	\N	2024-06-05 05:27:58	2024-06-05 05:27:58	\N	Ansonia	CT	USA	\N	\N	\N	\N	203-522-7352
2432	Mr.Bryan Bennett,	SSC Metal Fabrication, Inc.	\N	\N	Steel Detailing	Lead	t	f	2024-06-07 13:43:15	0	\N	2024-06-07 13:43:15	2024-06-07 13:43:15	President	Riviera Beach	FL	USA	\N	\N	\N	\N	561-318-7096
2433	Mr.Mike Maier	Suncoast Industries of Florida	\N	\N	Steel Detailing	Lead	t	f	2024-06-11 07:23:06	0	\N	2024-06-11 07:23:06	2024-06-11 07:23:06	Purchasing	Fort Myers	FL	USA	\N	\N	\N	\N	239 243 5975
2434	Anthony Green	Pioneer Welding & Fabrication, Inc	\N	\N	Steel Detailing	Lead	t	f	2024-06-21 07:55:53	0	\N	2024-06-21 07:55:53	2024-06-21 07:55:53	Project Manager	Apopka	FL	USA	\N	\N	\N	\N	+1 407-880-4997
2435	Corri Wainwright	Seguin Fabricators, Ltd	\N	\N	Steel Detailing	Lead	t	f	2024-06-25 11:03:01	0	\N	2024-06-25 11:03:01	2024-06-25 11:03:01	Project Manager	Seguin	Texas	USA	\N	\N	\N	\N	830-379-4129
2436	Michael Adolf	Steelhead Metal & Fab, LLC.	\N	\N	Steel Detailing	Lead	t	f	2024-06-29 05:57:10	0	\N	2024-06-29 05:57:10	2024-06-29 05:57:10	Project Manager	Salem	Oregon	USA	\N	\N	\N	\N	503-763-0114
2437	Andrew Hutchinson	Selco Manufacturing Corp.	\N	\N	Steel Detailing	Lead	t	f	2024-07-03 06:55:50	0	\N	2024-07-03 06:55:50	2024-07-03 06:55:50	Project Manager	Caldwell	New Jersey	USA	\N	\N	\N	\N	973 244 1177
2438	Nyle L. Fisher, Jr., P.E	Structural Systems Inc.,	\N	\N	Steel Detailing	Lead	t	f	2024-07-12 13:08:42	0	\N	2024-07-12 13:08:42	2024-07-12 13:08:42	\N	Nitro	West Virginia	USA	\N	\N	\N	\N	304 204 4766
2439	Jesse Leal	SoCal Detailing, Inc.	\N	\N	Steel Detailing	Lead	t	f	2024-07-23 06:27:04	0	\N	2024-07-23 06:27:04	2024-07-23 06:27:04	\N	Whittier	CA	USA	\N	\N	\N	\N	(562)318-5463
2440	David Carlson	All Pro Fabrication & Welding, LLC.	\N	\N	Steel Detailing	Lead	t	f	2024-07-30 06:53:40	0	\N	2024-07-30 06:53:40	2024-07-30 06:53:40	\N	Lexington	North Carolina	USA	\N	\N	\N	\N	336-880-7575
2441	Jesse Beardon	KDM Steelworks, Inc.	\N	\N	Steel Detailing	Lead	t	f	2024-08-20 08:58:13	0	\N	2024-08-20 08:58:13	2024-08-20 08:58:13	\N	Loveland	CO	USA	\N	\N	\N	\N	+1 7209755110
2442	Fawn Hubbard	A2 Fabrication	\N	\N	Steel Detailing	Lead	t	f	2024-09-24 14:47:07	0	\N	2024-09-24 14:47:07	2024-09-24 14:47:07	Office Manager	Milwaukie	Oregon	USA	\N	\N	\N	\N	503 771-2000
2443	Tommy Jackson	Fab Weld Steel, LLC	\N	\N	Steel Detailing	Lead	t	f	2024-09-27 10:25:56	0	\N	2024-09-27 10:25:56	2024-09-27 10:25:56	Project Manager	Abanda	AL	USA	\N	\N	\N	\N	205-688-4654
2444	Stefan Ivey	Ivey League Fabrication LLC	\N	\N	Steel Detailing	Lead	t	f	2024-11-07 05:34:23	0	\N	2024-11-07 05:34:23	2024-11-07 05:34:23	Project Manager	Spanish Fork	Utah	USA	\N	\N	\N	\N	3853269143
2445	Brittany Sanderson	Porter Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2024-11-15 13:43:38	0	\N	2024-11-15 13:43:38	2024-11-15 13:43:38	Senior Project Manager	Lilburn	GA	USA	\N	\N	\N	\N	770 564-0837
2446	Mr.Elancheliyan	SB ENGINEERS CONSULTING & CONTRACTING	\N	\N	Steel Detailing	Lead	t	f	2025-01-06 11:45:19	0	\N	2025-01-06 11:45:19	2025-01-06 11:45:19	\N	AIGhoubrah	Muscat	OMAN	\N	\N	\N	\N	+968 9112 1077
2447	Jesse Leal	BAPKO METAL INC	\N	\N	Steel Detailing	Lead	t	f	2025-01-22 07:27:45	0	\N	2025-01-22 07:27:45	2025-01-22 07:27:45	Detailing Manager	Orange	CA	USA	\N	\N	\N	\N	714-338-6897
2448	Jennifer Dameron	West Michigan Structural Services L.L.C.	\N	\N	Steel Detailing	Lead	t	f	2025-03-11 07:58:19	0	\N	2025-03-11 07:58:19	2025-03-11 07:58:19	Owner	Muskegon	Michigan	USA	\N	\N	\N	\N	616-268-6708
2449	Joe Millette	Concord Iron Works, Inc.	\N	\N	Steel Detailing	Lead	t	f	2025-03-26 04:55:35	0	\N	2025-03-26 04:55:35	2025-03-26 04:55:35	PM	Pittsburg	CA	USA	\N	\N	\N	\N	(925) 526-8135
2450	Will Mac	Kwan Wo Ironworks, Inc.	\N	\N	Steel Detailing	Lead	t	f	2025-03-28 04:29:55	0	\N	2025-03-28 04:29:55	2025-03-28 04:29:55	Project Engineer	Hayward	CA	USA	\N	\N	\N	\N	415-527-6243
2451	Eduardo Montes Armas	Grupo Montes LLC	\N	\N	Steel Detailing	Lead	t	f	2025-04-05 05:31:46	0	\N	2025-04-05 05:31:46	2025-04-05 05:31:46	\N	Lilburn	GA	USA	\N	\N	\N	\N	(678) 993-4033
2452	Rajesh Kittusamy	TEKS Engineering Australia	\N	\N	Steel Detailing	Lead	t	f	2025-05-05 11:37:46	0	\N	2025-05-05 11:37:46	2025-05-05 11:37:46	Project Coordinator	Burton	SA	Australia	\N	\N	\N	\N	0435 727657
2453	Dixie Southern Industrial, Inc	Dixie Southern Industrial, Inc	\N	\N	Steel Detailing	Lead	t	f	2025-05-09 05:51:06	0	\N	2025-05-09 05:51:06	2025-05-09 05:51:06	\N	Polk City	FL	USA	\N	\N	\N	\N	863-984-1900
2454	Dusty Taylor	Ferrill-Fisher Inc.,	\N	\N	Steel Detailing	Lead	t	f	2025-05-28 09:06:55	0	\N	2025-05-28 09:06:55	2025-05-28 09:06:55	Estimator	Bloomington	IN	USA	\N	\N	\N	\N	765-516-1990
2455	Steve Hartzell	Capitol Iron Works, Inc	\N	\N	Steel Detailing	Lead	t	f	2025-06-19 13:29:56	0	\N	2025-06-19 13:29:56	2025-06-19 13:29:56	President	Sacramento	CA	USA	\N	\N	\N	\N	(916) 381-1554
2456	Fred Willson III	Industrial Steel South LLC	\N	\N	Steel Detailing	Lead	t	f	2025-07-11 08:21:33	0	\N	2025-07-11 08:21:33	2025-07-11 08:21:33	President	Rockledge	FL	USA	\N	\N	\N	\N	321-302-2502
2457	Kenneth H Johns	Thorough Built, LLC.	\N	\N	Steel Detailing	Lead	t	f	2025-07-17 06:10:53	0	\N	2025-07-17 06:10:53	2025-07-17 06:10:53	Project Manager	Chattanooga	Tennessee	USA	\N	\N	\N	\N	803.605.5363
2458	Joe Kitchen	BUILDING ZONE INDUSTRIES	\N	\N	Steel Detailing	Lead	t	f	2025-07-23 07:34:20	0	\N	2025-07-23 07:34:20	2025-07-23 07:34:20	Detailing Coordinator	Kanarraville	Utah	USA	\N	\N	\N	\N	8885092280
2459	Gary Raymond	Worth Construction Co., Inc.	\N	\N	Steel Detailing	Lead	t	f	2025-08-28 13:48:34	0	\N	2025-08-28 13:48:34	2025-08-28 13:48:34	Vice President, Operations	Bethlehem Village	CT	USA	\N	\N	\N	\N	(203) 797-8788
2460	Michael Swofford	Warrenton Steel	\N	\N	Steel Detailing	Lead	t	f	2025-08-30 12:57:24	0	\N	2025-08-30 12:57:24	2025-08-30 12:57:24	\N	Warrenton	Missouri	USA	\N	\N	\N	\N	636-456-8400
2461	Michael Heins	STALEY STEEL LLC,	\N	\N	Steel Detailing	Lead	t	f	2025-09-11 13:30:14	0	\N	2025-09-11 13:30:14	2025-09-11 13:30:14	Executive Vice President	Pilot Point	Texas	USA	\N	\N	\N	\N	(940) 686-6000
2462	Javier Orejuela	Mid-State Metals LLC	\N	\N	Steel Detailing	Lead	t	f	2025-10-06 13:14:49	0	\N	2025-10-06 13:14:49	2025-10-06 13:14:49	Project Manager	Orlando	FL	USA	\N	\N	\N	\N	407-295-3864
2463	Joshua Vondielingen	MAK Steel Services, LLC	\N	\N	Steel Detailing	Lead	t	f	2025-10-25 05:15:30	0	\N	2025-10-25 05:15:30	2025-10-25 05:15:30	Project Manager	Seymour	IN	USA	\N	\N	\N	\N	812-530-6085
2464	Lisa Schanken	East Coast Iron Works LLC	\N	\N	Steel Detailing	Lead	t	f	2025-11-07 08:28:48	0	\N	2025-11-07 08:28:48	2025-11-07 08:28:48	\N	Owings	Maryland	USA	\N	\N	\N	\N	443-850-2005
2465	Michael Heins	STALEY STEEL LLC,	\N	\N	Steel Detailing	Lead	t	f	2025-12-12 08:26:23	0	\N	2025-12-12 08:26:23	2025-12-12 08:26:23	Executive Vice President	Pilot Point	Texas	USA	\N	\N	\N	\N	(940) 686-6000
2466	Ken Barclay	Barclay Mechanical Services of Utah, Inc.	\N	\N	Steel Detailing	Lead	t	f	2026-01-14 06:48:40	0	\N	2026-01-14 06:48:40	2026-01-14 06:48:40	Vice President	Manti	Utah	USA	\N	\N	\N	\N	435-760-7694
2467	Chad Bludau	Bludau Fabrication Inc	\N	\N	Steel Detailing	Lead	t	f	2026-01-30 13:58:32	0	\N	2026-01-30 13:58:32	2026-01-30 13:58:32	General Manager	Hallettsville	Texas	USA	\N	\N	\N	\N	361-217-8287
2468	Chris Highfield	Ranger Steel, Inc.	\N	\N	Steel Detailing	Lead	t	f	2026-02-04 04:47:16	0	\N	2026-02-04 04:47:16	2026-02-04 04:47:16	\N	Maysville	KY	USA	\N	\N	\N	\N	(606) 564-9521
2469	Eric Raz	Waukegan Steel, LLC	\N	\N	Steel Detailing	Lead	t	f	2026-02-14 11:50:51	0	\N	2026-02-14 11:50:51	2026-02-14 11:50:51	Manager of Engineering	Waukegan	IL	USA	\N	\N	\N	\N	847.662.2810
2470	Leandra Clarke	Atlantic Central Enterprises, Inc.	\N	\N	Steel Detailing	Lead	t	f	2026-02-19 13:10:37	0	\N	2026-02-19 13:10:37	2026-02-19 13:10:37	Estimator	Holly Hill	FL	USA	\N	\N	\N	\N	386-255-6227
2471	Alex Parsons	Fabricated Products of Tampa, Inc.	\N	\N	Steel Detailing	Lead	t	f	2026-02-19 13:17:59	0	\N	2026-02-19 13:17:59	2026-02-19 13:17:59	Project Manager	Tampa	FL	USA	\N	\N	\N	\N	813-247-6024
2472	Galen Miller	Quality Welding and Fab., LLC	\N	\N	Steel Detailing	Lead	t	f	2026-03-06 05:46:06	0	\N	2026-03-06 05:46:06	2026-03-06 05:46:06	Project Manager	Elida	Ohio	USA	\N	\N	\N	\N	(419) 225-6208
2473	Dianne Lefler	R & D Welding	\N	\N	Steel Detailing	Lead	t	f	2026-03-10 12:14:46	0	\N	2026-03-10 12:14:46	2026-03-10 12:14:46	Office Manage	Reno	Nevada	USA	\N	\N	\N	\N	775.432.2246
2474	Andrew Pierce	Silver Oak Contracting Inc.	\N	\N	Steel Detailing	Lead	t	f	2026-04-14 07:16:53	0	\N	2026-04-14 07:16:53	2026-04-14 07:16:53	Lead Estimator	Winder	GA	USA	\N	\N	\N	\N	+1 770-921-1550
2475	Brandon Baylor	Miscellaneous Specialties, Inc	\N	\N	Steel Detailing	Lead	t	f	2026-05-22 10:03:45	0	\N	2026-05-22 10:03:45	2026-05-22 10:03:45	\N	Spring	Texas	USA	\N	\N	\N	\N	(281) 351-1177
2476	Monty Magner	Irwin Steel LLC	\N	\N	Steel Detailing	Lead	t	f	2026-06-02 06:26:28	0	\N	2026-06-02 06:26:28	2026-06-02 06:26:28	\N	Justin	Texas	USA	\N	\N	\N	\N	+1 817-636-2508
2477	Kathy Horack	The Gateway Co. of Missouri LLC	\N	\N	Steel Detailing	Lead	t	f	2026-06-05 07:53:05	0	\N	2026-06-05 07:53:05	2026-06-05 07:53:05	\N	Berkeley	Missouri	USA	\N	\N	\N	\N	314-524-7440
2478	Travis Rex	Houser Fabrication	\N	\N	Steel Detailing	Lead	t	f	2026-06-26 07:17:33	0	\N	2026-06-26 07:17:33	2026-06-26 07:17:33	\N	Madisonville	Texas	USA	\N	\N	\N	\N	936-349-0185
2479	Jason Hayes	Hayes Manufacturing Company	\N	\N	Steel Detailing	Lead	t	f	2026-07-28 11:47:20	0	\N	2026-07-28 11:47:20	2026-07-28 11:47:20	CEO	Pineville	LA	USA	\N	\N	\N	\N	3184870100
2480	Rhonda Newhall	Dixie Metal Products, INC	\N	\N	Steel Detailing	Lead	t	f	2026-08-03 06:06:38	0	\N	2026-08-03 06:06:38	2026-08-03 06:06:38	\N	Ocala	FL	USA	\N	\N	\N	\N	(352) 873-2554
2481	Editha De Guzman	VALLEY STEEL, LLC	\N	\N	Steel Detailing	Lead	t	f	2026-08-05 07:58:11	0	\N	2026-08-05 07:58:11	2026-08-05 07:58:11	Project Engineer	Las Vegas	Nevada	USA	\N	\N	\N	\N	702-228-1510
2482	Caden Romero	True Fab Inc.	\N	\N	Steel Detailing	Lead	t	f	2026-08-06 06:45:57	0	\N	2026-08-06 06:45:57	2026-08-06 06:45:57	\N	Freeport	Texas	USA	\N	\N	\N	\N	979-233-5550
2483	Joshua Zinsmeyer	Zinsmeyer Structural Steel	\N	\N	Steel Detailing	Lead	t	f	2026-08-11 04:22:19	0	\N	2026-08-11 04:22:19	2026-08-11 04:22:19	\N	Castroville	Texas	USA	\N	\N	\N	\N	830-985-3498
2484	Jonathan Cruz	Steel-Plus LLC	\N	\N	Steel Detailing	Lead	t	f	2026-08-20 03:46:40	0	\N	2026-08-20 03:46:40	2026-08-20 03:46:40	\N	Ider	AL	USA	\N	\N	\N	\N	256-657-7320
2485	Roni Eskandari	KR Welding Inc	\N	\N	Steel Detailing	Lead	t	f	2026-08-20 05:34:39	0	\N	2026-08-20 05:34:39	2026-08-20 05:34:39	\N	Los Angeles	CA	USA	\N	\N	\N	\N	8188134031
2486	Prasad Damodharan	ASSENT STEEL INDUSTRIES L.L.C	\N	\N	Steel Detailing	Lead	t	f	2026-09-01 13:50:45	0	\N	2026-09-01 13:50:45	2026-09-01 13:50:45	Senior Quantity Surveyor	Adak	AK	USA	\N	\N	\N	\N	Tel (+971) 4 247 1200
2487	Kelvin Dancel	Steel Structures Inc	\N	\N	Steel Detailing	Lead	t	t	2026-10-16 17:53:12.337357	0	\N	2026-09-10 07:55:17	2026-10-16 17:53:12.337381	\N	Madera	CA	USA	\N	\N	\N	\N	702-736-7033
\.


--
-- Data for Name: followups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.followups (id, client_id, title, type, scheduled_at, priority, status, is_positive_result, notes, location, meeting_link, reminder_sent, created_at, updated_at, completed_at) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, title, message, type, client_id, followup_id, is_read, created_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, name, password, role, avatar, created_at) FROM stdin;
1	abarna.s	Abarna S	abarna@2026	Steel Detailing Executive	\N	2026-10-12 11:44:01.26997
2	girish.j	Girish J	girish@2026	Steel Detailing Executive	\N	2026-10-12 11:44:01.270582
3	admin	Admin	admin@123	System Administrator	\N	2026-10-12 11:44:01.271
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 1, false);


--
-- Name: activity_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activity_logs_id_seq', 4, true);


--
-- Name: client_notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_notes_id_seq', 1, false);


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 2487, true);


--
-- Name: followups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.followups_id_seq', 1, false);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- Name: app_meta app_meta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_meta
    ADD CONSTRAINT app_meta_pkey PRIMARY KEY (key);


--
-- Name: client_notes client_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_notes
    ADD CONSTRAINT client_notes_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: followups followups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followups
    ADD CONSTRAINT followups_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ix_accounts_account_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_accounts_account_name ON public.accounts USING btree (account_name);


--
-- Name: ix_accounts_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_accounts_client_id ON public.accounts USING btree (client_id);


--
-- Name: ix_accounts_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_accounts_company ON public.accounts USING btree (company);


--
-- Name: ix_accounts_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_accounts_id ON public.accounts USING btree (id);


--
-- Name: ix_accounts_project_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_accounts_project_name ON public.accounts USING btree (project_name);


--
-- Name: ix_accounts_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_accounts_status ON public.accounts USING btree (status);


--
-- Name: ix_activity_logs_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_activity_logs_action ON public.activity_logs USING btree (action);


--
-- Name: ix_activity_logs_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_activity_logs_created_at ON public.activity_logs USING btree (created_at);


--
-- Name: ix_activity_logs_entity_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_activity_logs_entity_type ON public.activity_logs USING btree (entity_type);


--
-- Name: ix_activity_logs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_activity_logs_id ON public.activity_logs USING btree (id);


--
-- Name: ix_client_notes_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_client_notes_client_id ON public.client_notes USING btree (client_id);


--
-- Name: ix_client_notes_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_client_notes_created_at ON public.client_notes USING btree (created_at);


--
-- Name: ix_client_notes_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_client_notes_id ON public.client_notes USING btree (id);


--
-- Name: ix_clients_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_clients_company ON public.clients USING btree (company);


--
-- Name: ix_clients_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_clients_id ON public.clients USING btree (id);


--
-- Name: ix_clients_is_lead; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_clients_is_lead ON public.clients USING btree (is_lead);


--
-- Name: ix_clients_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_clients_name ON public.clients USING btree (name);


--
-- Name: ix_clients_positive_approach; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_clients_positive_approach ON public.clients USING btree (positive_approach);


--
-- Name: ix_clients_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_clients_status ON public.clients USING btree (status);


--
-- Name: ix_followups_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_followups_client_id ON public.followups USING btree (client_id);


--
-- Name: ix_followups_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_followups_id ON public.followups USING btree (id);


--
-- Name: ix_followups_scheduled_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_followups_scheduled_at ON public.followups USING btree (scheduled_at);


--
-- Name: ix_followups_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_followups_status ON public.followups USING btree (status);


--
-- Name: ix_followups_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_followups_type ON public.followups USING btree (type);


--
-- Name: ix_notifications_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_notifications_id ON public.notifications USING btree (id);


--
-- Name: ix_notifications_is_read; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_notifications_is_read ON public.notifications USING btree (is_read);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: ix_users_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_users_username ON public.users USING btree (username);


--
-- Name: accounts accounts_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE SET NULL;


--
-- Name: client_notes client_notes_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_notes
    ADD CONSTRAINT client_notes_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- Name: followups followups_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followups
    ADD CONSTRAINT followups_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE SET NULL;


--
-- Name: notifications notifications_followup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_followup_id_fkey FOREIGN KEY (followup_id) REFERENCES public.followups(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict POtQrLuKWbesVLipxX9KkyiMlQRmWxYISxq9mbn0PIpeBd0DRzEmrJyW4KAcdK0

