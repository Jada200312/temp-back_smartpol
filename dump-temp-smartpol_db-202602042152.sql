--
-- PostgreSQL database dump
--

\restrict 2Hy5KEcCZ3i8D3gRbnWYVIAJi6dLN0gejx2Fj1EE9KsSQcpdnIR3wHtStvEi3HV

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-02-04 21:52:39

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
-- TOC entry 219 (class 1259 OID 18007)
-- Name: candidate_leader; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidate_leader (
    candidate_id integer NOT NULL,
    leader_id integer NOT NULL
);


ALTER TABLE public.candidate_leader OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 18012)
-- Name: candidate_voter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidate_voter (
    id integer NOT NULL,
    voter_id integer NOT NULL,
    candidate_id integer NOT NULL,
    leader_id integer,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.candidate_voter OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 18020)
-- Name: candidate_voter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.candidate_voter_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.candidate_voter_id_seq OWNER TO postgres;

--
-- TOC entry 5205 (class 0 OID 0)
-- Dependencies: 221
-- Name: candidate_voter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.candidate_voter_id_seq OWNED BY public.candidate_voter.id;


--
-- TOC entry 222 (class 1259 OID 18021)
-- Name: candidates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidates (
    id integer NOT NULL,
    name character varying NOT NULL,
    party character varying NOT NULL,
    number integer NOT NULL,
    corporation_id integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "userId" integer
);


ALTER TABLE public.candidates OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 18035)
-- Name: candidates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.candidates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.candidates_id_seq OWNER TO postgres;

--
-- TOC entry 5206 (class 0 OID 0)
-- Dependencies: 223
-- Name: candidates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.candidates_id_seq OWNED BY public.candidates.id;


--
-- TOC entry 224 (class 1259 OID 18036)
-- Name: corporations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.corporations (
    id integer NOT NULL,
    name character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.corporations OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 18047)
-- Name: corporations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.corporations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.corporations_id_seq OWNER TO postgres;

--
-- TOC entry 5207 (class 0 OID 0)
-- Dependencies: 225
-- Name: corporations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.corporations_id_seq OWNED BY public.corporations.id;


--
-- TOC entry 226 (class 1259 OID 18048)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    id integer NOT NULL,
    name character varying NOT NULL,
    code character varying,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 18059)
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.departments_id_seq OWNER TO postgres;

--
-- TOC entry 5208 (class 0 OID 0)
-- Dependencies: 227
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departments_id_seq OWNED BY public.departments.id;


--
-- TOC entry 228 (class 1259 OID 18060)
-- Name: leaders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leaders (
    id integer NOT NULL,
    name character varying NOT NULL,
    document character varying NOT NULL,
    municipality character varying NOT NULL,
    phone character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "userId" integer
);


ALTER TABLE public.leaders OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 18074)
-- Name: leaders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.leaders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leaders_id_seq OWNER TO postgres;

--
-- TOC entry 5209 (class 0 OID 0)
-- Dependencies: 229
-- Name: leaders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.leaders_id_seq OWNED BY public.leaders.id;


--
-- TOC entry 230 (class 1259 OID 18075)
-- Name: municipalities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.municipalities (
    id integer NOT NULL,
    name character varying NOT NULL,
    code character varying,
    "departmentId" integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.municipalities OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 18087)
-- Name: municipalities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.municipalities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.municipalities_id_seq OWNER TO postgres;

--
-- TOC entry 5210 (class 0 OID 0)
-- Dependencies: 231
-- Name: municipalities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.municipalities_id_seq OWNED BY public.municipalities.id;


--
-- TOC entry 232 (class 1259 OID 18088)
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    resource character varying(100) NOT NULL,
    action character varying(50) NOT NULL,
    description character varying(500),
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 18098)
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO postgres;

--
-- TOC entry 5211 (class 0 OID 0)
-- Dependencies: 233
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- TOC entry 234 (class 1259 OID 18099)
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    "roleId" integer NOT NULL,
    "permissionId" integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 18105)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(500),
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 18114)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5212 (class 0 OID 0)
-- Dependencies: 236
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 237 (class 1259 OID 18115)
-- Name: user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_permissions (
    "userId" integer NOT NULL,
    "permissionId" integer NOT NULL,
    granted boolean DEFAULT true,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_permissions OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 18123)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "roleId" integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 18135)
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
-- TOC entry 5213 (class 0 OID 0)
-- Dependencies: 239
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 240 (class 1259 OID 18136)
-- Name: voters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.voters (
    id integer NOT NULL,
    "firstName" character varying NOT NULL,
    "lastName" character varying NOT NULL,
    identification character varying NOT NULL,
    gender character varying,
    "bloodType" character varying,
    "birthDate" date,
    phone character varying,
    neighborhood character varying,
    email character varying,
    occupation character varying,
    "politicalStatus" character varying,
    address character varying,
    "departmentId" integer,
    "municipalityId" integer,
    "votingBoothId" integer,
    "votingTableId" character varying,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.voters OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 18147)
-- Name: voters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.voters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.voters_id_seq OWNER TO postgres;

--
-- TOC entry 5214 (class 0 OID 0)
-- Dependencies: 241
-- Name: voters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.voters_id_seq OWNED BY public.voters.id;


--
-- TOC entry 242 (class 1259 OID 18148)
-- Name: voting_booths; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.voting_booths (
    id integer CONSTRAINT voting_booths_new_id_not_null NOT NULL,
    name character varying(255) CONSTRAINT voting_booths_new_name_not_null NOT NULL,
    code character varying(255),
    "municipalityId" integer,
    mesas integer,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT voting_booths_new_mesas_nonneg CHECK (((mesas IS NULL) OR (mesas >= 0)))
);


ALTER TABLE public.voting_booths OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 18158)
-- Name: voting_booths_new_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.voting_booths_new_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.voting_booths_new_id_seq OWNER TO postgres;

--
-- TOC entry 5215 (class 0 OID 0)
-- Dependencies: 243
-- Name: voting_booths_new_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.voting_booths_new_id_seq OWNED BY public.voting_booths.id;


--
-- TOC entry 4918 (class 2604 OID 18159)
-- Name: candidate_voter id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_voter ALTER COLUMN id SET DEFAULT nextval('public.candidate_voter_id_seq'::regclass);


--
-- TOC entry 4921 (class 2604 OID 18160)
-- Name: candidates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates ALTER COLUMN id SET DEFAULT nextval('public.candidates_id_seq'::regclass);


--
-- TOC entry 4924 (class 2604 OID 18161)
-- Name: corporations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.corporations ALTER COLUMN id SET DEFAULT nextval('public.corporations_id_seq'::regclass);


--
-- TOC entry 4927 (class 2604 OID 18162)
-- Name: departments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_id_seq'::regclass);


--
-- TOC entry 4930 (class 2604 OID 18163)
-- Name: leaders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leaders ALTER COLUMN id SET DEFAULT nextval('public.leaders_id_seq'::regclass);


--
-- TOC entry 4933 (class 2604 OID 18164)
-- Name: municipalities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipalities ALTER COLUMN id SET DEFAULT nextval('public.municipalities_id_seq'::regclass);


--
-- TOC entry 4936 (class 2604 OID 18165)
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- TOC entry 4939 (class 2604 OID 18166)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4945 (class 2604 OID 18167)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4948 (class 2604 OID 18168)
-- Name: voters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voters ALTER COLUMN id SET DEFAULT nextval('public.voters_id_seq'::regclass);


--
-- TOC entry 4951 (class 2604 OID 18169)
-- Name: voting_booths id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voting_booths ALTER COLUMN id SET DEFAULT nextval('public.voting_booths_new_id_seq'::regclass);


--
-- TOC entry 5175 (class 0 OID 18007)
-- Dependencies: 219
-- Data for Name: candidate_leader; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.candidate_leader VALUES (7, 1);
INSERT INTO public.candidate_leader VALUES (6, 2);
INSERT INTO public.candidate_leader VALUES (7, 2);
INSERT INTO public.candidate_leader VALUES (3, 2);
INSERT INTO public.candidate_leader VALUES (6, 3);
INSERT INTO public.candidate_leader VALUES (7, 3);
INSERT INTO public.candidate_leader VALUES (3, 3);
INSERT INTO public.candidate_leader VALUES (6, 4);
INSERT INTO public.candidate_leader VALUES (7, 4);
INSERT INTO public.candidate_leader VALUES (3, 4);
INSERT INTO public.candidate_leader VALUES (6, 5);
INSERT INTO public.candidate_leader VALUES (7, 5);
INSERT INTO public.candidate_leader VALUES (3, 5);
INSERT INTO public.candidate_leader VALUES (6, 6);
INSERT INTO public.candidate_leader VALUES (7, 6);
INSERT INTO public.candidate_leader VALUES (3, 6);
INSERT INTO public.candidate_leader VALUES (6, 7);
INSERT INTO public.candidate_leader VALUES (7, 7);
INSERT INTO public.candidate_leader VALUES (1, 7);
INSERT INTO public.candidate_leader VALUES (6, 8);
INSERT INTO public.candidate_leader VALUES (7, 8);
INSERT INTO public.candidate_leader VALUES (1, 8);
INSERT INTO public.candidate_leader VALUES (6, 9);
INSERT INTO public.candidate_leader VALUES (7, 9);
INSERT INTO public.candidate_leader VALUES (1, 9);
INSERT INTO public.candidate_leader VALUES (6, 10);
INSERT INTO public.candidate_leader VALUES (7, 10);
INSERT INTO public.candidate_leader VALUES (4, 10);
INSERT INTO public.candidate_leader VALUES (6, 11);
INSERT INTO public.candidate_leader VALUES (7, 11);
INSERT INTO public.candidate_leader VALUES (4, 11);
INSERT INTO public.candidate_leader VALUES (6, 12);
INSERT INTO public.candidate_leader VALUES (7, 12);
INSERT INTO public.candidate_leader VALUES (1, 12);
INSERT INTO public.candidate_leader VALUES (6, 13);
INSERT INTO public.candidate_leader VALUES (7, 13);
INSERT INTO public.candidate_leader VALUES (4, 13);
INSERT INTO public.candidate_leader VALUES (6, 14);
INSERT INTO public.candidate_leader VALUES (7, 14);
INSERT INTO public.candidate_leader VALUES (2, 14);
INSERT INTO public.candidate_leader VALUES (6, 15);
INSERT INTO public.candidate_leader VALUES (7, 15);
INSERT INTO public.candidate_leader VALUES (2, 15);
INSERT INTO public.candidate_leader VALUES (6, 16);
INSERT INTO public.candidate_leader VALUES (7, 16);
INSERT INTO public.candidate_leader VALUES (4, 16);
INSERT INTO public.candidate_leader VALUES (6, 17);
INSERT INTO public.candidate_leader VALUES (7, 17);
INSERT INTO public.candidate_leader VALUES (4, 17);
INSERT INTO public.candidate_leader VALUES (6, 18);
INSERT INTO public.candidate_leader VALUES (7, 18);
INSERT INTO public.candidate_leader VALUES (3, 18);
INSERT INTO public.candidate_leader VALUES (6, 19);
INSERT INTO public.candidate_leader VALUES (7, 19);
INSERT INTO public.candidate_leader VALUES (4, 19);
INSERT INTO public.candidate_leader VALUES (6, 20);
INSERT INTO public.candidate_leader VALUES (7, 20);
INSERT INTO public.candidate_leader VALUES (4, 20);
INSERT INTO public.candidate_leader VALUES (6, 21);
INSERT INTO public.candidate_leader VALUES (7, 21);
INSERT INTO public.candidate_leader VALUES (3, 21);
INSERT INTO public.candidate_leader VALUES (6, 22);
INSERT INTO public.candidate_leader VALUES (7, 22);
INSERT INTO public.candidate_leader VALUES (1, 22);
INSERT INTO public.candidate_leader VALUES (6, 23);
INSERT INTO public.candidate_leader VALUES (7, 23);
INSERT INTO public.candidate_leader VALUES (1, 23);
INSERT INTO public.candidate_leader VALUES (6, 24);
INSERT INTO public.candidate_leader VALUES (7, 24);
INSERT INTO public.candidate_leader VALUES (1, 24);
INSERT INTO public.candidate_leader VALUES (7, 25);
INSERT INTO public.candidate_leader VALUES (7, 26);
INSERT INTO public.candidate_leader VALUES (4, 26);
INSERT INTO public.candidate_leader VALUES (7, 27);
INSERT INTO public.candidate_leader VALUES (7, 28);
INSERT INTO public.candidate_leader VALUES (3, 28);
INSERT INTO public.candidate_leader VALUES (7, 29);
INSERT INTO public.candidate_leader VALUES (3, 29);
INSERT INTO public.candidate_leader VALUES (6, 30);
INSERT INTO public.candidate_leader VALUES (7, 30);
INSERT INTO public.candidate_leader VALUES (1, 30);
INSERT INTO public.candidate_leader VALUES (6, 31);
INSERT INTO public.candidate_leader VALUES (7, 31);
INSERT INTO public.candidate_leader VALUES (1, 31);
INSERT INTO public.candidate_leader VALUES (6, 32);
INSERT INTO public.candidate_leader VALUES (7, 32);
INSERT INTO public.candidate_leader VALUES (1, 32);
INSERT INTO public.candidate_leader VALUES (6, 33);
INSERT INTO public.candidate_leader VALUES (7, 33);
INSERT INTO public.candidate_leader VALUES (1, 33);
INSERT INTO public.candidate_leader VALUES (6, 34);
INSERT INTO public.candidate_leader VALUES (7, 34);
INSERT INTO public.candidate_leader VALUES (1, 34);
INSERT INTO public.candidate_leader VALUES (6, 1);


--
-- TOC entry 5176 (class 0 OID 18012)
-- Dependencies: 220
-- Data for Name: candidate_voter; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.candidate_voter VALUES (3, 35, 6, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (4, 35, 7, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (5, 35, 1, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (6, 36, 7, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (7, 36, 6, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (8, 36, 1, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (9, 37, 7, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (10, 37, 6, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (11, 38, 1, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (12, 38, 7, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (13, 38, 6, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (14, 39, 6, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (15, 39, 1, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (16, 40, 6, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (17, 40, 1, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (18, 41, 6, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (19, 41, 1, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (20, 41, 7, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (21, 42, 6, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (22, 42, 1, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (23, 42, 7, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (24, 46, 6, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (25, 46, 7, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (26, 46, 1, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (27, 47, 7, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (28, 47, 6, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (29, 47, 1, 7, '2026-01-31 22:12:02.217267', '2026-01-31 22:12:02.217267');
INSERT INTO public.candidate_voter VALUES (30, 48, 7, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (31, 48, 6, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (32, 48, 1, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (33, 49, 7, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (34, 49, 6, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (35, 49, 1, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (36, 50, 7, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (37, 50, 6, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (38, 50, 1, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (39, 51, 6, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (40, 51, 7, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (41, 51, 1, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (42, 162, 7, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (43, 162, 1, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (44, 163, 6, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (45, 163, 1, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (46, 163, 7, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (47, 164, 6, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (48, 164, 7, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (49, 164, 1, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (50, 165, 6, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (51, 165, 7, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (52, 165, 1, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (53, 166, 6, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (54, 166, 7, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (55, 166, 1, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (56, 167, 6, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (57, 167, 1, 7, '2026-01-31 22:19:45.554065', '2026-01-31 22:19:45.554065');
INSERT INTO public.candidate_voter VALUES (58, 168, 7, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (59, 168, 6, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (60, 168, 1, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (61, 169, 7, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (62, 169, 6, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (63, 169, 1, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (64, 170, 7, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (65, 170, 6, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (66, 170, 1, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (67, 171, 7, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (68, 171, 6, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (69, 171, 1, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (70, 175, 7, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (71, 175, 6, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (72, 175, 1, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (73, 177, 7, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (74, 177, 6, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (75, 177, 1, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (76, 179, 7, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (77, 179, 6, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (78, 179, 1, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (79, 181, 7, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (80, 181, 6, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (81, 181, 1, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (82, 182, 7, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (83, 182, 6, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (84, 182, 1, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (85, 183, 7, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (86, 183, 6, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (87, 183, 1, 7, '2026-01-31 22:35:53.228521', '2026-01-31 22:35:53.228521');
INSERT INTO public.candidate_voter VALUES (88, 184, 7, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (89, 184, 6, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (90, 184, 1, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (91, 185, 7, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (92, 185, 6, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (93, 185, 1, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (94, 186, 7, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (95, 186, 6, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (96, 186, 1, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (97, 187, 7, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (98, 187, 6, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (99, 187, 1, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (100, 188, 7, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (101, 188, 6, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (102, 188, 1, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (103, 189, 7, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (104, 189, 6, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (105, 189, 1, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (106, 190, 7, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (107, 190, 6, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (108, 190, 1, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (109, 198, 7, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (110, 198, 6, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (111, 198, 1, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (112, 199, 7, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (113, 199, 6, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (114, 199, 1, 7, '2026-01-31 22:40:22.704606', '2026-01-31 22:40:22.704606');
INSERT INTO public.candidate_voter VALUES (115, 69, 7, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (116, 69, 6, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (117, 69, 1, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (118, 77, 7, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (119, 77, 6, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (120, 77, 1, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (121, 81, 7, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (122, 81, 6, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (123, 81, 1, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (124, 82, 7, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (125, 82, 6, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (126, 82, 1, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (127, 83, 7, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (128, 83, 6, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (129, 83, 1, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (130, 85, 7, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (131, 85, 6, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (132, 85, 1, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (133, 88, 7, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (134, 88, 6, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (135, 88, 1, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (136, 91, 7, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (137, 91, 6, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (138, 91, 1, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (139, 96, 7, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (140, 96, 6, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (141, 96, 1, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (142, 108, 7, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (143, 108, 6, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (144, 108, 1, 32, '2026-01-31 22:44:40.560519', '2026-01-31 22:44:40.560519');
INSERT INTO public.candidate_voter VALUES (148, 113, 7, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (149, 113, 6, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (150, 113, 1, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (151, 110, 7, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (152, 110, 6, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (153, 110, 1, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (154, 111, 7, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (155, 111, 6, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (156, 111, 1, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (157, 109, 7, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (158, 109, 6, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (159, 109, 1, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (160, 112, 7, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (161, 112, 6, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (162, 112, 1, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (163, 114, 7, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (164, 114, 6, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (165, 114, 1, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (166, 115, 7, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (167, 115, 6, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (168, 115, 1, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (169, 118, 7, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (170, 118, 6, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (171, 118, 1, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (172, 119, 7, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (173, 119, 6, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (174, 119, 1, 32, '2026-01-31 22:46:05.720916', '2026-01-31 22:46:05.720916');
INSERT INTO public.candidate_voter VALUES (175, 120, 7, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (176, 120, 6, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (177, 120, 1, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (178, 121, 7, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (179, 121, 6, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (180, 121, 1, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (181, 123, 7, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (182, 123, 6, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (183, 123, 1, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (184, 126, 7, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (185, 126, 6, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (186, 126, 1, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (187, 127, 7, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (188, 127, 6, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (189, 127, 1, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (190, 128, 7, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (191, 128, 6, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (192, 128, 1, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (193, 129, 7, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (194, 129, 6, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (195, 129, 1, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (196, 136, 7, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (197, 136, 6, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (198, 136, 1, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (199, 137, 7, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (200, 137, 6, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (201, 137, 1, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (202, 122, 7, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (203, 122, 6, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (204, 122, 1, 32, '2026-01-31 22:59:25.572637', '2026-01-31 22:59:25.572637');
INSERT INTO public.candidate_voter VALUES (205, 140, 7, 32, '2026-01-31 23:03:07.006307', '2026-01-31 23:03:07.006307');
INSERT INTO public.candidate_voter VALUES (206, 140, 6, 32, '2026-01-31 23:03:07.006307', '2026-01-31 23:03:07.006307');
INSERT INTO public.candidate_voter VALUES (207, 140, 1, 32, '2026-01-31 23:03:07.006307', '2026-01-31 23:03:07.006307');
INSERT INTO public.candidate_voter VALUES (208, 141, 6, 32, '2026-01-31 23:03:07.006307', '2026-01-31 23:03:07.006307');
INSERT INTO public.candidate_voter VALUES (209, 141, 1, 32, '2026-01-31 23:03:07.006307', '2026-01-31 23:03:07.006307');
INSERT INTO public.candidate_voter VALUES (210, 144, 7, 32, '2026-01-31 23:03:07.006307', '2026-01-31 23:03:07.006307');
INSERT INTO public.candidate_voter VALUES (211, 144, 6, 32, '2026-01-31 23:03:07.006307', '2026-01-31 23:03:07.006307');
INSERT INTO public.candidate_voter VALUES (212, 144, 1, 32, '2026-01-31 23:03:07.006307', '2026-01-31 23:03:07.006307');
INSERT INTO public.candidate_voter VALUES (213, 145, 7, 32, '2026-01-31 23:03:07.006307', '2026-01-31 23:03:07.006307');
INSERT INTO public.candidate_voter VALUES (214, 145, 6, 32, '2026-01-31 23:03:07.006307', '2026-01-31 23:03:07.006307');
INSERT INTO public.candidate_voter VALUES (215, 145, 1, 32, '2026-01-31 23:03:07.006307', '2026-01-31 23:03:07.006307');
INSERT INTO public.candidate_voter VALUES (216, 78, 7, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (217, 78, 6, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (218, 78, 1, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (219, 80, 7, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (220, 80, 6, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (221, 80, 1, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (222, 84, 7, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (223, 84, 6, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (224, 84, 1, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (225, 86, 7, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (226, 86, 6, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (227, 86, 1, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (228, 87, 7, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (229, 87, 6, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (230, 87, 1, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (231, 89, 7, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (232, 89, 6, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (233, 89, 1, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (234, 90, 7, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (235, 90, 6, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (236, 90, 1, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (237, 92, 7, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (238, 92, 6, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (239, 92, 1, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (240, 93, 7, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (241, 93, 6, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (242, 93, 1, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (243, 97, 7, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (244, 97, 6, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (245, 97, 1, 34, '2026-01-31 23:10:15.550473', '2026-01-31 23:10:15.550473');
INSERT INTO public.candidate_voter VALUES (246, 98, 7, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (247, 98, 6, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (248, 98, 1, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (249, 99, 7, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (250, 99, 6, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (251, 99, 1, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (252, 100, 7, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (253, 100, 6, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (254, 100, 1, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (255, 101, 7, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (256, 101, 6, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (257, 101, 1, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (258, 103, 7, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (259, 103, 6, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (260, 103, 1, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (261, 104, 6, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (262, 104, 7, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (263, 105, 7, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (264, 105, 6, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (265, 105, 1, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (266, 106, 7, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (267, 106, 6, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (268, 106, 1, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (269, 107, 7, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (270, 107, 6, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (271, 107, 1, 34, '2026-01-31 23:13:43.674652', '2026-01-31 23:13:43.674652');
INSERT INTO public.candidate_voter VALUES (298, 52, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (299, 52, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (300, 52, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (301, 53, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (302, 53, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (303, 53, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (304, 54, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (305, 54, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (306, 54, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (307, 55, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (308, 55, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (309, 55, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (310, 56, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (311, 56, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (312, 56, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (313, 57, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (314, 57, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (315, 57, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (316, 58, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (317, 58, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (318, 58, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (319, 59, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (320, 59, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (321, 59, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (322, 60, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (323, 60, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (324, 61, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (325, 61, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (326, 62, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (327, 62, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (328, 62, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (329, 63, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (330, 63, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (331, 63, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (332, 64, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (333, 64, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (334, 64, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (335, 65, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (336, 65, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (337, 65, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (338, 66, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (339, 66, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (340, 66, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (344, 68, 7, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (345, 68, 6, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (346, 68, 3, 18, '2026-01-31 23:38:05.743318', '2026-01-31 23:38:05.743318');
INSERT INTO public.candidate_voter VALUES (350, 67, 6, 32, '2026-01-31 23:55:02.723432', '2026-01-31 23:55:02.723432');
INSERT INTO public.candidate_voter VALUES (351, 67, 7, 32, '2026-01-31 23:55:02.723432', '2026-01-31 23:55:02.723432');
INSERT INTO public.candidate_voter VALUES (352, 67, 1, 32, '2026-01-31 23:55:02.723432', '2026-01-31 23:55:02.723432');
INSERT INTO public.candidate_voter VALUES (367, 204, 6, 7, '2026-02-02 13:41:14.211855', '2026-02-02 13:41:14.211855');
INSERT INTO public.candidate_voter VALUES (368, 204, 7, 7, '2026-02-02 13:41:14.214191', '2026-02-02 13:41:14.214191');
INSERT INTO public.candidate_voter VALUES (369, 204, 1, 7, '2026-02-02 13:41:14.215219', '2026-02-02 13:41:14.215219');
INSERT INTO public.candidate_voter VALUES (370, 205, 6, 15, '2026-02-02 16:16:08.656042', '2026-02-02 16:16:08.656042');
INSERT INTO public.candidate_voter VALUES (371, 205, 7, 15, '2026-02-02 16:16:08.659669', '2026-02-02 16:16:08.659669');
INSERT INTO public.candidate_voter VALUES (372, 205, 2, 15, '2026-02-02 16:16:08.660985', '2026-02-02 16:16:08.660985');
INSERT INTO public.candidate_voter VALUES (373, 206, 6, 15, '2026-02-02 16:18:16.749427', '2026-02-02 16:18:16.749427');
INSERT INTO public.candidate_voter VALUES (374, 206, 7, 15, '2026-02-02 16:18:16.750907', '2026-02-02 16:18:16.750907');
INSERT INTO public.candidate_voter VALUES (375, 206, 2, 15, '2026-02-02 16:18:16.751775', '2026-02-02 16:18:16.751775');
INSERT INTO public.candidate_voter VALUES (376, 207, 6, 15, '2026-02-02 16:21:10.76646', '2026-02-02 16:21:10.76646');
INSERT INTO public.candidate_voter VALUES (377, 207, 7, 15, '2026-02-02 16:21:10.768681', '2026-02-02 16:21:10.768681');
INSERT INTO public.candidate_voter VALUES (378, 207, 2, 15, '2026-02-02 16:21:10.769542', '2026-02-02 16:21:10.769542');
INSERT INTO public.candidate_voter VALUES (379, 208, 6, 15, '2026-02-02 16:22:26.606328', '2026-02-02 16:22:26.606328');
INSERT INTO public.candidate_voter VALUES (380, 208, 2, 15, '2026-02-02 16:22:26.607895', '2026-02-02 16:22:26.607895');
INSERT INTO public.candidate_voter VALUES (381, 208, 7, 15, '2026-02-02 16:22:26.608994', '2026-02-02 16:22:26.608994');
INSERT INTO public.candidate_voter VALUES (382, 209, 6, 15, '2026-02-02 16:23:50.786066', '2026-02-02 16:23:50.786066');
INSERT INTO public.candidate_voter VALUES (383, 209, 7, 15, '2026-02-02 16:23:50.787599', '2026-02-02 16:23:50.787599');
INSERT INTO public.candidate_voter VALUES (384, 209, 2, 15, '2026-02-02 16:23:50.788438', '2026-02-02 16:23:50.788438');
INSERT INTO public.candidate_voter VALUES (385, 210, 6, 15, '2026-02-02 16:25:05.947312', '2026-02-02 16:25:05.947312');
INSERT INTO public.candidate_voter VALUES (386, 210, 7, 15, '2026-02-02 16:25:05.95131', '2026-02-02 16:25:05.95131');
INSERT INTO public.candidate_voter VALUES (387, 210, 2, 15, '2026-02-02 16:25:05.953184', '2026-02-02 16:25:05.953184');
INSERT INTO public.candidate_voter VALUES (388, 211, 6, 15, '2026-02-02 16:26:31.413164', '2026-02-02 16:26:31.413164');
INSERT INTO public.candidate_voter VALUES (389, 211, 7, 15, '2026-02-02 16:26:31.414454', '2026-02-02 16:26:31.414454');
INSERT INTO public.candidate_voter VALUES (390, 211, 2, 15, '2026-02-02 16:26:31.415518', '2026-02-02 16:26:31.415518');
INSERT INTO public.candidate_voter VALUES (391, 212, 6, 15, '2026-02-02 16:27:46.160786', '2026-02-02 16:27:46.160786');
INSERT INTO public.candidate_voter VALUES (392, 212, 7, 15, '2026-02-02 16:27:46.162505', '2026-02-02 16:27:46.162505');
INSERT INTO public.candidate_voter VALUES (393, 212, 2, 15, '2026-02-02 16:27:46.164199', '2026-02-02 16:27:46.164199');
INSERT INTO public.candidate_voter VALUES (394, 213, 6, 15, '2026-02-02 16:28:55.776525', '2026-02-02 16:28:55.776525');
INSERT INTO public.candidate_voter VALUES (395, 213, 7, 15, '2026-02-02 16:28:55.778266', '2026-02-02 16:28:55.778266');
INSERT INTO public.candidate_voter VALUES (396, 213, 2, 15, '2026-02-02 16:28:55.779484', '2026-02-02 16:28:55.779484');
INSERT INTO public.candidate_voter VALUES (397, 214, 6, 15, '2026-02-02 16:33:46.036287', '2026-02-02 16:33:46.036287');
INSERT INTO public.candidate_voter VALUES (398, 214, 7, 15, '2026-02-02 16:33:46.039577', '2026-02-02 16:33:46.039577');
INSERT INTO public.candidate_voter VALUES (399, 214, 2, 15, '2026-02-02 16:33:46.041334', '2026-02-02 16:33:46.041334');
INSERT INTO public.candidate_voter VALUES (400, 215, 6, 15, '2026-02-02 16:35:02.733225', '2026-02-02 16:35:02.733225');
INSERT INTO public.candidate_voter VALUES (401, 215, 7, 15, '2026-02-02 16:35:02.737038', '2026-02-02 16:35:02.737038');
INSERT INTO public.candidate_voter VALUES (402, 215, 2, 15, '2026-02-02 16:35:02.738409', '2026-02-02 16:35:02.738409');
INSERT INTO public.candidate_voter VALUES (403, 216, 6, 15, '2026-02-02 16:37:15.13329', '2026-02-02 16:37:15.13329');
INSERT INTO public.candidate_voter VALUES (404, 216, 7, 15, '2026-02-02 16:37:15.135093', '2026-02-02 16:37:15.135093');
INSERT INTO public.candidate_voter VALUES (405, 216, 2, 15, '2026-02-02 16:37:15.135917', '2026-02-02 16:37:15.135917');
INSERT INTO public.candidate_voter VALUES (406, 217, 6, 15, '2026-02-02 16:38:21.902989', '2026-02-02 16:38:21.902989');
INSERT INTO public.candidate_voter VALUES (407, 217, 7, 15, '2026-02-02 16:38:21.90513', '2026-02-02 16:38:21.90513');
INSERT INTO public.candidate_voter VALUES (408, 217, 2, 15, '2026-02-02 16:38:21.906459', '2026-02-02 16:38:21.906459');
INSERT INTO public.candidate_voter VALUES (409, 218, 6, 15, '2026-02-02 16:39:21.797296', '2026-02-02 16:39:21.797296');
INSERT INTO public.candidate_voter VALUES (410, 218, 7, 15, '2026-02-02 16:39:21.798739', '2026-02-02 16:39:21.798739');
INSERT INTO public.candidate_voter VALUES (411, 218, 2, 15, '2026-02-02 16:39:21.799682', '2026-02-02 16:39:21.799682');
INSERT INTO public.candidate_voter VALUES (412, 219, 6, 15, '2026-02-02 16:40:19.11501', '2026-02-02 16:40:19.11501');
INSERT INTO public.candidate_voter VALUES (413, 219, 7, 15, '2026-02-02 16:40:19.118055', '2026-02-02 16:40:19.118055');
INSERT INTO public.candidate_voter VALUES (414, 219, 2, 15, '2026-02-02 16:40:19.120979', '2026-02-02 16:40:19.120979');
INSERT INTO public.candidate_voter VALUES (415, 220, 6, 15, '2026-02-02 16:43:52.348498', '2026-02-02 16:43:52.348498');
INSERT INTO public.candidate_voter VALUES (416, 220, 7, 15, '2026-02-02 16:43:52.350111', '2026-02-02 16:43:52.350111');
INSERT INTO public.candidate_voter VALUES (417, 220, 2, 15, '2026-02-02 16:43:52.351064', '2026-02-02 16:43:52.351064');
INSERT INTO public.candidate_voter VALUES (418, 221, 6, 15, '2026-02-02 16:44:57.57632', '2026-02-02 16:44:57.57632');
INSERT INTO public.candidate_voter VALUES (419, 221, 7, 15, '2026-02-02 16:44:57.577687', '2026-02-02 16:44:57.577687');
INSERT INTO public.candidate_voter VALUES (420, 221, 2, 15, '2026-02-02 16:44:57.578467', '2026-02-02 16:44:57.578467');
INSERT INTO public.candidate_voter VALUES (421, 222, 6, 15, '2026-02-02 16:47:16.018', '2026-02-02 16:47:16.018');
INSERT INTO public.candidate_voter VALUES (422, 222, 7, 15, '2026-02-02 16:47:16.019773', '2026-02-02 16:47:16.019773');
INSERT INTO public.candidate_voter VALUES (423, 222, 2, 15, '2026-02-02 16:47:16.020742', '2026-02-02 16:47:16.020742');
INSERT INTO public.candidate_voter VALUES (424, 223, 6, 15, '2026-02-02 16:48:21.655754', '2026-02-02 16:48:21.655754');
INSERT INTO public.candidate_voter VALUES (425, 223, 7, 15, '2026-02-02 16:48:21.657244', '2026-02-02 16:48:21.657244');
INSERT INTO public.candidate_voter VALUES (426, 223, 2, 15, '2026-02-02 16:48:21.658065', '2026-02-02 16:48:21.658065');
INSERT INTO public.candidate_voter VALUES (427, 224, 6, 15, '2026-02-02 16:49:13.371753', '2026-02-02 16:49:13.371753');
INSERT INTO public.candidate_voter VALUES (428, 224, 7, 15, '2026-02-02 16:49:13.3733', '2026-02-02 16:49:13.3733');
INSERT INTO public.candidate_voter VALUES (429, 224, 2, 15, '2026-02-02 16:49:13.374295', '2026-02-02 16:49:13.374295');
INSERT INTO public.candidate_voter VALUES (430, 225, 6, 15, '2026-02-02 16:54:29.273146', '2026-02-02 16:54:29.273146');
INSERT INTO public.candidate_voter VALUES (431, 225, 7, 15, '2026-02-02 16:54:29.275284', '2026-02-02 16:54:29.275284');
INSERT INTO public.candidate_voter VALUES (432, 225, 2, 15, '2026-02-02 16:54:29.276419', '2026-02-02 16:54:29.276419');
INSERT INTO public.candidate_voter VALUES (433, 226, 6, 15, '2026-02-02 16:55:37.98556', '2026-02-02 16:55:37.98556');
INSERT INTO public.candidate_voter VALUES (434, 226, 7, 15, '2026-02-02 16:55:37.988709', '2026-02-02 16:55:37.988709');
INSERT INTO public.candidate_voter VALUES (435, 226, 2, 15, '2026-02-02 16:55:37.989886', '2026-02-02 16:55:37.989886');
INSERT INTO public.candidate_voter VALUES (436, 227, 6, 15, '2026-02-02 16:57:01.647314', '2026-02-02 16:57:01.647314');
INSERT INTO public.candidate_voter VALUES (437, 227, 7, 15, '2026-02-02 16:57:01.649238', '2026-02-02 16:57:01.649238');
INSERT INTO public.candidate_voter VALUES (438, 227, 2, 15, '2026-02-02 16:57:01.650623', '2026-02-02 16:57:01.650623');
INSERT INTO public.candidate_voter VALUES (439, 228, 6, 15, '2026-02-02 16:58:19.268992', '2026-02-02 16:58:19.268992');
INSERT INTO public.candidate_voter VALUES (440, 228, 7, 15, '2026-02-02 16:58:19.317285', '2026-02-02 16:58:19.317285');
INSERT INTO public.candidate_voter VALUES (441, 228, 2, 15, '2026-02-02 16:58:19.319464', '2026-02-02 16:58:19.319464');
INSERT INTO public.candidate_voter VALUES (442, 229, 6, 15, '2026-02-02 16:59:20.911113', '2026-02-02 16:59:20.911113');
INSERT INTO public.candidate_voter VALUES (443, 229, 7, 15, '2026-02-02 16:59:20.912609', '2026-02-02 16:59:20.912609');
INSERT INTO public.candidate_voter VALUES (444, 229, 2, 15, '2026-02-02 16:59:20.913461', '2026-02-02 16:59:20.913461');
INSERT INTO public.candidate_voter VALUES (445, 230, 6, 15, '2026-02-02 17:00:39.326582', '2026-02-02 17:00:39.326582');
INSERT INTO public.candidate_voter VALUES (446, 230, 7, 15, '2026-02-02 17:00:39.330595', '2026-02-02 17:00:39.330595');
INSERT INTO public.candidate_voter VALUES (447, 230, 2, 15, '2026-02-02 17:00:39.331585', '2026-02-02 17:00:39.331585');
INSERT INTO public.candidate_voter VALUES (448, 231, 6, 15, '2026-02-02 17:01:51.129532', '2026-02-02 17:01:51.129532');
INSERT INTO public.candidate_voter VALUES (449, 231, 7, 15, '2026-02-02 17:01:51.130899', '2026-02-02 17:01:51.130899');
INSERT INTO public.candidate_voter VALUES (450, 231, 2, 15, '2026-02-02 17:01:51.131781', '2026-02-02 17:01:51.131781');
INSERT INTO public.candidate_voter VALUES (451, 232, 6, 15, '2026-02-02 17:03:45.919406', '2026-02-02 17:03:45.919406');
INSERT INTO public.candidate_voter VALUES (452, 232, 7, 15, '2026-02-02 17:03:45.92129', '2026-02-02 17:03:45.92129');
INSERT INTO public.candidate_voter VALUES (453, 232, 2, 15, '2026-02-02 17:03:45.922068', '2026-02-02 17:03:45.922068');
INSERT INTO public.candidate_voter VALUES (454, 233, 6, 15, '2026-02-02 17:05:09.490333', '2026-02-02 17:05:09.490333');
INSERT INTO public.candidate_voter VALUES (455, 233, 7, 15, '2026-02-02 17:05:09.493034', '2026-02-02 17:05:09.493034');
INSERT INTO public.candidate_voter VALUES (456, 233, 2, 15, '2026-02-02 17:05:09.494175', '2026-02-02 17:05:09.494175');
INSERT INTO public.candidate_voter VALUES (457, 234, 6, 15, '2026-02-02 17:07:05.007262', '2026-02-02 17:07:05.007262');
INSERT INTO public.candidate_voter VALUES (458, 234, 7, 15, '2026-02-02 17:07:05.008736', '2026-02-02 17:07:05.008736');
INSERT INTO public.candidate_voter VALUES (459, 234, 2, 15, '2026-02-02 17:07:05.009874', '2026-02-02 17:07:05.009874');
INSERT INTO public.candidate_voter VALUES (460, 235, 6, 15, '2026-02-02 17:08:12.161599', '2026-02-02 17:08:12.161599');
INSERT INTO public.candidate_voter VALUES (461, 235, 7, 15, '2026-02-02 17:08:12.163028', '2026-02-02 17:08:12.163028');
INSERT INTO public.candidate_voter VALUES (462, 235, 2, 15, '2026-02-02 17:08:12.163874', '2026-02-02 17:08:12.163874');
INSERT INTO public.candidate_voter VALUES (463, 236, 6, 15, '2026-02-02 17:09:15.603987', '2026-02-02 17:09:15.603987');
INSERT INTO public.candidate_voter VALUES (464, 236, 7, 15, '2026-02-02 17:09:15.607388', '2026-02-02 17:09:15.607388');
INSERT INTO public.candidate_voter VALUES (465, 236, 2, 15, '2026-02-02 17:09:15.608312', '2026-02-02 17:09:15.608312');
INSERT INTO public.candidate_voter VALUES (466, 237, 6, 15, '2026-02-02 17:10:16.297437', '2026-02-02 17:10:16.297437');
INSERT INTO public.candidate_voter VALUES (467, 237, 7, 15, '2026-02-02 17:10:16.299429', '2026-02-02 17:10:16.299429');
INSERT INTO public.candidate_voter VALUES (468, 237, 2, 15, '2026-02-02 17:10:16.300725', '2026-02-02 17:10:16.300725');
INSERT INTO public.candidate_voter VALUES (469, 238, 6, 15, '2026-02-02 17:14:04.325161', '2026-02-02 17:14:04.325161');
INSERT INTO public.candidate_voter VALUES (470, 238, 7, 15, '2026-02-02 17:14:04.326834', '2026-02-02 17:14:04.326834');
INSERT INTO public.candidate_voter VALUES (471, 238, 2, 15, '2026-02-02 17:14:04.327759', '2026-02-02 17:14:04.327759');
INSERT INTO public.candidate_voter VALUES (472, 239, 6, 15, '2026-02-02 17:15:03.607731', '2026-02-02 17:15:03.607731');
INSERT INTO public.candidate_voter VALUES (473, 239, 7, 15, '2026-02-02 17:15:03.609387', '2026-02-02 17:15:03.609387');
INSERT INTO public.candidate_voter VALUES (474, 239, 2, 15, '2026-02-02 17:15:03.61038', '2026-02-02 17:15:03.61038');
INSERT INTO public.candidate_voter VALUES (475, 240, 6, 15, '2026-02-02 17:16:00.236908', '2026-02-02 17:16:00.236908');
INSERT INTO public.candidate_voter VALUES (476, 240, 7, 15, '2026-02-02 17:16:00.238754', '2026-02-02 17:16:00.238754');
INSERT INTO public.candidate_voter VALUES (477, 240, 2, 15, '2026-02-02 17:16:00.239687', '2026-02-02 17:16:00.239687');
INSERT INTO public.candidate_voter VALUES (478, 241, 6, 15, '2026-02-02 17:17:02.958494', '2026-02-02 17:17:02.958494');
INSERT INTO public.candidate_voter VALUES (479, 241, 7, 15, '2026-02-02 17:17:02.960196', '2026-02-02 17:17:02.960196');
INSERT INTO public.candidate_voter VALUES (480, 241, 2, 15, '2026-02-02 17:17:02.962304', '2026-02-02 17:17:02.962304');
INSERT INTO public.candidate_voter VALUES (481, 242, 6, 15, '2026-02-02 17:17:59.968255', '2026-02-02 17:17:59.968255');
INSERT INTO public.candidate_voter VALUES (482, 242, 7, 15, '2026-02-02 17:17:59.969455', '2026-02-02 17:17:59.969455');
INSERT INTO public.candidate_voter VALUES (483, 242, 2, 15, '2026-02-02 17:17:59.970263', '2026-02-02 17:17:59.970263');
INSERT INTO public.candidate_voter VALUES (484, 243, 6, 15, '2026-02-02 17:18:50.169496', '2026-02-02 17:18:50.169496');
INSERT INTO public.candidate_voter VALUES (485, 243, 7, 15, '2026-02-02 17:18:50.170866', '2026-02-02 17:18:50.170866');
INSERT INTO public.candidate_voter VALUES (486, 243, 2, 15, '2026-02-02 17:18:50.171693', '2026-02-02 17:18:50.171693');
INSERT INTO public.candidate_voter VALUES (487, 244, 6, 15, '2026-02-02 17:19:48.485992', '2026-02-02 17:19:48.485992');
INSERT INTO public.candidate_voter VALUES (488, 244, 7, 15, '2026-02-02 17:19:48.487398', '2026-02-02 17:19:48.487398');
INSERT INTO public.candidate_voter VALUES (489, 244, 2, 15, '2026-02-02 17:19:48.488212', '2026-02-02 17:19:48.488212');
INSERT INTO public.candidate_voter VALUES (490, 245, 6, 15, '2026-02-02 17:20:53.578932', '2026-02-02 17:20:53.578932');
INSERT INTO public.candidate_voter VALUES (491, 245, 7, 15, '2026-02-02 17:20:53.580524', '2026-02-02 17:20:53.580524');
INSERT INTO public.candidate_voter VALUES (492, 245, 2, 15, '2026-02-02 17:20:53.581443', '2026-02-02 17:20:53.581443');
INSERT INTO public.candidate_voter VALUES (493, 246, 6, 15, '2026-02-02 17:21:49.831155', '2026-02-02 17:21:49.831155');
INSERT INTO public.candidate_voter VALUES (494, 246, 7, 15, '2026-02-02 17:21:49.832604', '2026-02-02 17:21:49.832604');
INSERT INTO public.candidate_voter VALUES (495, 246, 2, 15, '2026-02-02 17:21:49.833639', '2026-02-02 17:21:49.833639');
INSERT INTO public.candidate_voter VALUES (496, 247, 6, 15, '2026-02-02 17:24:57.941909', '2026-02-02 17:24:57.941909');
INSERT INTO public.candidate_voter VALUES (497, 247, 7, 15, '2026-02-02 17:24:57.943352', '2026-02-02 17:24:57.943352');
INSERT INTO public.candidate_voter VALUES (498, 247, 2, 15, '2026-02-02 17:24:57.944363', '2026-02-02 17:24:57.944363');
INSERT INTO public.candidate_voter VALUES (499, 248, 6, 15, '2026-02-02 17:27:35.434216', '2026-02-02 17:27:35.434216');
INSERT INTO public.candidate_voter VALUES (500, 248, 7, 15, '2026-02-02 17:27:35.436118', '2026-02-02 17:27:35.436118');
INSERT INTO public.candidate_voter VALUES (501, 248, 2, 15, '2026-02-02 17:27:35.436973', '2026-02-02 17:27:35.436973');
INSERT INTO public.candidate_voter VALUES (502, 249, 6, 15, '2026-02-02 17:29:23.672428', '2026-02-02 17:29:23.672428');
INSERT INTO public.candidate_voter VALUES (503, 249, 7, 15, '2026-02-02 17:29:23.674745', '2026-02-02 17:29:23.674745');
INSERT INTO public.candidate_voter VALUES (504, 249, 2, 15, '2026-02-02 17:29:23.67573', '2026-02-02 17:29:23.67573');
INSERT INTO public.candidate_voter VALUES (505, 250, 6, 15, '2026-02-02 17:30:25.933206', '2026-02-02 17:30:25.933206');
INSERT INTO public.candidate_voter VALUES (506, 250, 7, 15, '2026-02-02 17:30:25.934911', '2026-02-02 17:30:25.934911');
INSERT INTO public.candidate_voter VALUES (507, 250, 2, 15, '2026-02-02 17:30:25.935701', '2026-02-02 17:30:25.935701');
INSERT INTO public.candidate_voter VALUES (508, 251, 6, 15, '2026-02-02 17:32:45.926631', '2026-02-02 17:32:45.926631');
INSERT INTO public.candidate_voter VALUES (509, 251, 7, 15, '2026-02-02 17:32:45.928638', '2026-02-02 17:32:45.928638');
INSERT INTO public.candidate_voter VALUES (510, 251, 2, 15, '2026-02-02 17:32:45.929581', '2026-02-02 17:32:45.929581');
INSERT INTO public.candidate_voter VALUES (511, 252, 6, 15, '2026-02-02 17:33:52.193882', '2026-02-02 17:33:52.193882');
INSERT INTO public.candidate_voter VALUES (512, 252, 7, 15, '2026-02-02 17:33:52.196421', '2026-02-02 17:33:52.196421');
INSERT INTO public.candidate_voter VALUES (513, 252, 2, 15, '2026-02-02 17:33:52.197588', '2026-02-02 17:33:52.197588');
INSERT INTO public.candidate_voter VALUES (514, 253, 6, 15, '2026-02-02 17:35:08.250208', '2026-02-02 17:35:08.250208');
INSERT INTO public.candidate_voter VALUES (515, 253, 7, 15, '2026-02-02 17:35:08.252394', '2026-02-02 17:35:08.252394');
INSERT INTO public.candidate_voter VALUES (516, 253, 2, 15, '2026-02-02 17:35:08.253383', '2026-02-02 17:35:08.253383');
INSERT INTO public.candidate_voter VALUES (517, 254, 6, 15, '2026-02-02 17:36:02.42581', '2026-02-02 17:36:02.42581');
INSERT INTO public.candidate_voter VALUES (518, 254, 7, 15, '2026-02-02 17:36:02.428356', '2026-02-02 17:36:02.428356');
INSERT INTO public.candidate_voter VALUES (519, 254, 2, 15, '2026-02-02 17:36:02.429497', '2026-02-02 17:36:02.429497');
INSERT INTO public.candidate_voter VALUES (520, 255, 6, 15, '2026-02-02 17:37:05.391089', '2026-02-02 17:37:05.391089');
INSERT INTO public.candidate_voter VALUES (521, 255, 7, 15, '2026-02-02 17:37:05.392628', '2026-02-02 17:37:05.392628');
INSERT INTO public.candidate_voter VALUES (522, 255, 2, 15, '2026-02-02 17:37:05.393567', '2026-02-02 17:37:05.393567');
INSERT INTO public.candidate_voter VALUES (523, 256, 6, 15, '2026-02-02 17:42:52.426403', '2026-02-02 17:42:52.426403');
INSERT INTO public.candidate_voter VALUES (524, 256, 7, 15, '2026-02-02 17:42:52.428132', '2026-02-02 17:42:52.428132');
INSERT INTO public.candidate_voter VALUES (525, 256, 2, 15, '2026-02-02 17:42:52.429121', '2026-02-02 17:42:52.429121');
INSERT INTO public.candidate_voter VALUES (526, 257, 6, 15, '2026-02-02 17:45:54.390468', '2026-02-02 17:45:54.390468');
INSERT INTO public.candidate_voter VALUES (527, 257, 7, 15, '2026-02-02 17:45:54.392239', '2026-02-02 17:45:54.392239');
INSERT INTO public.candidate_voter VALUES (528, 257, 2, 15, '2026-02-02 17:45:54.39316', '2026-02-02 17:45:54.39316');
INSERT INTO public.candidate_voter VALUES (529, 258, 6, 15, '2026-02-02 17:46:55.218029', '2026-02-02 17:46:55.218029');
INSERT INTO public.candidate_voter VALUES (530, 258, 7, 15, '2026-02-02 17:46:55.21974', '2026-02-02 17:46:55.21974');
INSERT INTO public.candidate_voter VALUES (531, 258, 2, 15, '2026-02-02 17:46:55.221986', '2026-02-02 17:46:55.221986');
INSERT INTO public.candidate_voter VALUES (532, 259, 6, 15, '2026-02-02 17:47:57.374584', '2026-02-02 17:47:57.374584');
INSERT INTO public.candidate_voter VALUES (533, 259, 7, 15, '2026-02-02 17:47:57.376079', '2026-02-02 17:47:57.376079');
INSERT INTO public.candidate_voter VALUES (534, 259, 2, 15, '2026-02-02 17:47:57.379198', '2026-02-02 17:47:57.379198');
INSERT INTO public.candidate_voter VALUES (535, 260, 6, 15, '2026-02-02 17:49:03.328435', '2026-02-02 17:49:03.328435');
INSERT INTO public.candidate_voter VALUES (536, 260, 7, 15, '2026-02-02 17:49:03.332054', '2026-02-02 17:49:03.332054');
INSERT INTO public.candidate_voter VALUES (537, 260, 2, 15, '2026-02-02 17:49:03.417211', '2026-02-02 17:49:03.417211');
INSERT INTO public.candidate_voter VALUES (538, 261, 6, 15, '2026-02-02 18:13:06.345821', '2026-02-02 18:13:06.345821');
INSERT INTO public.candidate_voter VALUES (539, 261, 7, 15, '2026-02-02 18:13:06.348111', '2026-02-02 18:13:06.348111');
INSERT INTO public.candidate_voter VALUES (540, 261, 2, 15, '2026-02-02 18:13:06.349064', '2026-02-02 18:13:06.349064');
INSERT INTO public.candidate_voter VALUES (541, 262, 6, 15, '2026-02-02 18:40:08.261274', '2026-02-02 18:40:08.261274');
INSERT INTO public.candidate_voter VALUES (542, 262, 7, 15, '2026-02-02 18:40:08.263276', '2026-02-02 18:40:08.263276');
INSERT INTO public.candidate_voter VALUES (543, 262, 2, 15, '2026-02-02 18:40:08.264363', '2026-02-02 18:40:08.264363');
INSERT INTO public.candidate_voter VALUES (544, 263, 6, 15, '2026-02-02 18:42:45.269242', '2026-02-02 18:42:45.269242');
INSERT INTO public.candidate_voter VALUES (545, 263, 7, 15, '2026-02-02 18:42:45.270745', '2026-02-02 18:42:45.270745');
INSERT INTO public.candidate_voter VALUES (546, 263, 2, 15, '2026-02-02 18:42:45.271609', '2026-02-02 18:42:45.271609');
INSERT INTO public.candidate_voter VALUES (547, 264, 6, 15, '2026-02-02 18:44:24.084508', '2026-02-02 18:44:24.084508');
INSERT INTO public.candidate_voter VALUES (548, 264, 7, 15, '2026-02-02 18:44:24.086077', '2026-02-02 18:44:24.086077');
INSERT INTO public.candidate_voter VALUES (549, 264, 2, 15, '2026-02-02 18:44:24.087218', '2026-02-02 18:44:24.087218');
INSERT INTO public.candidate_voter VALUES (550, 265, 6, 15, '2026-02-02 18:47:05.546476', '2026-02-02 18:47:05.546476');
INSERT INTO public.candidate_voter VALUES (551, 265, 7, 15, '2026-02-02 18:47:05.54943', '2026-02-02 18:47:05.54943');
INSERT INTO public.candidate_voter VALUES (552, 265, 2, 15, '2026-02-02 18:47:05.55049', '2026-02-02 18:47:05.55049');
INSERT INTO public.candidate_voter VALUES (553, 266, 6, 15, '2026-02-02 18:48:11.903476', '2026-02-02 18:48:11.903476');
INSERT INTO public.candidate_voter VALUES (554, 266, 7, 15, '2026-02-02 18:48:11.90509', '2026-02-02 18:48:11.90509');
INSERT INTO public.candidate_voter VALUES (555, 266, 2, 15, '2026-02-02 18:48:11.905984', '2026-02-02 18:48:11.905984');
INSERT INTO public.candidate_voter VALUES (556, 267, 6, 15, '2026-02-02 18:49:13.751815', '2026-02-02 18:49:13.751815');
INSERT INTO public.candidate_voter VALUES (557, 267, 7, 15, '2026-02-02 18:49:13.754932', '2026-02-02 18:49:13.754932');
INSERT INTO public.candidate_voter VALUES (558, 267, 2, 15, '2026-02-02 18:49:13.756383', '2026-02-02 18:49:13.756383');
INSERT INTO public.candidate_voter VALUES (559, 268, 6, 15, '2026-02-02 18:50:18.057002', '2026-02-02 18:50:18.057002');
INSERT INTO public.candidate_voter VALUES (560, 268, 7, 15, '2026-02-02 18:50:18.059573', '2026-02-02 18:50:18.059573');
INSERT INTO public.candidate_voter VALUES (561, 268, 2, 15, '2026-02-02 18:50:18.060521', '2026-02-02 18:50:18.060521');
INSERT INTO public.candidate_voter VALUES (562, 269, 6, 15, '2026-02-02 18:51:26.259367', '2026-02-02 18:51:26.259367');
INSERT INTO public.candidate_voter VALUES (563, 269, 7, 15, '2026-02-02 18:51:26.261048', '2026-02-02 18:51:26.261048');
INSERT INTO public.candidate_voter VALUES (564, 269, 2, 15, '2026-02-02 18:51:26.262158', '2026-02-02 18:51:26.262158');
INSERT INTO public.candidate_voter VALUES (565, 270, 6, 15, '2026-02-02 18:52:41.65356', '2026-02-02 18:52:41.65356');
INSERT INTO public.candidate_voter VALUES (566, 270, 7, 15, '2026-02-02 18:52:41.655265', '2026-02-02 18:52:41.655265');
INSERT INTO public.candidate_voter VALUES (567, 270, 2, 15, '2026-02-02 18:52:41.656258', '2026-02-02 18:52:41.656258');
INSERT INTO public.candidate_voter VALUES (568, 271, 6, 15, '2026-02-02 18:53:39.629723', '2026-02-02 18:53:39.629723');
INSERT INTO public.candidate_voter VALUES (569, 271, 7, 15, '2026-02-02 18:53:39.631406', '2026-02-02 18:53:39.631406');
INSERT INTO public.candidate_voter VALUES (570, 271, 2, 15, '2026-02-02 18:53:39.632922', '2026-02-02 18:53:39.632922');
INSERT INTO public.candidate_voter VALUES (571, 272, 6, 15, '2026-02-02 18:54:59.7183', '2026-02-02 18:54:59.7183');
INSERT INTO public.candidate_voter VALUES (572, 272, 7, 15, '2026-02-02 18:54:59.719697', '2026-02-02 18:54:59.719697');
INSERT INTO public.candidate_voter VALUES (573, 272, 2, 15, '2026-02-02 18:54:59.720481', '2026-02-02 18:54:59.720481');
INSERT INTO public.candidate_voter VALUES (574, 273, 6, 15, '2026-02-02 18:57:35.695441', '2026-02-02 18:57:35.695441');
INSERT INTO public.candidate_voter VALUES (575, 273, 7, 15, '2026-02-02 18:57:35.697228', '2026-02-02 18:57:35.697228');
INSERT INTO public.candidate_voter VALUES (576, 273, 2, 15, '2026-02-02 18:57:35.698094', '2026-02-02 18:57:35.698094');
INSERT INTO public.candidate_voter VALUES (577, 274, 6, 15, '2026-02-02 18:58:34.391987', '2026-02-02 18:58:34.391987');
INSERT INTO public.candidate_voter VALUES (578, 274, 7, 15, '2026-02-02 18:58:34.394655', '2026-02-02 18:58:34.394655');
INSERT INTO public.candidate_voter VALUES (579, 274, 2, 15, '2026-02-02 18:58:34.395778', '2026-02-02 18:58:34.395778');
INSERT INTO public.candidate_voter VALUES (580, 275, 6, 15, '2026-02-02 18:59:35.224225', '2026-02-02 18:59:35.224225');
INSERT INTO public.candidate_voter VALUES (581, 275, 7, 15, '2026-02-02 18:59:35.226099', '2026-02-02 18:59:35.226099');
INSERT INTO public.candidate_voter VALUES (582, 275, 2, 15, '2026-02-02 18:59:35.226887', '2026-02-02 18:59:35.226887');
INSERT INTO public.candidate_voter VALUES (583, 276, 6, 15, '2026-02-02 19:00:30.935905', '2026-02-02 19:00:30.935905');
INSERT INTO public.candidate_voter VALUES (584, 276, 7, 15, '2026-02-02 19:00:30.939276', '2026-02-02 19:00:30.939276');
INSERT INTO public.candidate_voter VALUES (585, 276, 2, 15, '2026-02-02 19:00:30.940223', '2026-02-02 19:00:30.940223');
INSERT INTO public.candidate_voter VALUES (586, 277, 6, 15, '2026-02-02 19:01:38.712825', '2026-02-02 19:01:38.712825');
INSERT INTO public.candidate_voter VALUES (587, 277, 7, 15, '2026-02-02 19:01:38.714584', '2026-02-02 19:01:38.714584');
INSERT INTO public.candidate_voter VALUES (588, 277, 2, 15, '2026-02-02 19:01:38.715983', '2026-02-02 19:01:38.715983');
INSERT INTO public.candidate_voter VALUES (589, 278, 6, 15, '2026-02-02 19:02:56.533878', '2026-02-02 19:02:56.533878');
INSERT INTO public.candidate_voter VALUES (590, 278, 7, 15, '2026-02-02 19:02:56.535339', '2026-02-02 19:02:56.535339');
INSERT INTO public.candidate_voter VALUES (591, 278, 2, 15, '2026-02-02 19:02:56.536401', '2026-02-02 19:02:56.536401');
INSERT INTO public.candidate_voter VALUES (592, 279, 6, 15, '2026-02-02 19:03:57.672859', '2026-02-02 19:03:57.672859');
INSERT INTO public.candidate_voter VALUES (593, 279, 7, 15, '2026-02-02 19:03:57.674673', '2026-02-02 19:03:57.674673');
INSERT INTO public.candidate_voter VALUES (594, 279, 2, 15, '2026-02-02 19:03:57.675767', '2026-02-02 19:03:57.675767');
INSERT INTO public.candidate_voter VALUES (595, 280, 6, 15, '2026-02-02 19:05:03.233799', '2026-02-02 19:05:03.233799');
INSERT INTO public.candidate_voter VALUES (596, 280, 7, 15, '2026-02-02 19:05:03.236378', '2026-02-02 19:05:03.236378');
INSERT INTO public.candidate_voter VALUES (597, 280, 2, 15, '2026-02-02 19:05:03.238651', '2026-02-02 19:05:03.238651');
INSERT INTO public.candidate_voter VALUES (598, 281, 6, 15, '2026-02-02 19:06:08.357795', '2026-02-02 19:06:08.357795');
INSERT INTO public.candidate_voter VALUES (599, 281, 7, 15, '2026-02-02 19:06:08.41848', '2026-02-02 19:06:08.41848');
INSERT INTO public.candidate_voter VALUES (600, 281, 2, 15, '2026-02-02 19:06:08.419906', '2026-02-02 19:06:08.419906');
INSERT INTO public.candidate_voter VALUES (601, 282, 6, 15, '2026-02-02 19:07:18.927628', '2026-02-02 19:07:18.927628');
INSERT INTO public.candidate_voter VALUES (602, 282, 7, 15, '2026-02-02 19:07:18.930467', '2026-02-02 19:07:18.930467');
INSERT INTO public.candidate_voter VALUES (603, 282, 2, 15, '2026-02-02 19:07:18.93151', '2026-02-02 19:07:18.93151');
INSERT INTO public.candidate_voter VALUES (604, 283, 6, 15, '2026-02-02 19:08:28.934799', '2026-02-02 19:08:28.934799');
INSERT INTO public.candidate_voter VALUES (605, 283, 7, 15, '2026-02-02 19:08:28.938991', '2026-02-02 19:08:28.938991');
INSERT INTO public.candidate_voter VALUES (606, 283, 2, 15, '2026-02-02 19:08:28.941082', '2026-02-02 19:08:28.941082');
INSERT INTO public.candidate_voter VALUES (607, 284, 6, 15, '2026-02-02 19:10:47.481483', '2026-02-02 19:10:47.481483');
INSERT INTO public.candidate_voter VALUES (608, 284, 7, 15, '2026-02-02 19:10:47.483425', '2026-02-02 19:10:47.483425');
INSERT INTO public.candidate_voter VALUES (609, 284, 2, 15, '2026-02-02 19:10:47.518819', '2026-02-02 19:10:47.518819');
INSERT INTO public.candidate_voter VALUES (610, 285, 6, 15, '2026-02-02 19:11:48.620762', '2026-02-02 19:11:48.620762');
INSERT INTO public.candidate_voter VALUES (611, 285, 7, 15, '2026-02-02 19:11:48.622519', '2026-02-02 19:11:48.622519');
INSERT INTO public.candidate_voter VALUES (612, 285, 2, 15, '2026-02-02 19:11:48.623468', '2026-02-02 19:11:48.623468');
INSERT INTO public.candidate_voter VALUES (613, 286, 6, 15, '2026-02-02 19:15:02.455575', '2026-02-02 19:15:02.455575');
INSERT INTO public.candidate_voter VALUES (614, 286, 7, 15, '2026-02-02 19:15:02.459069', '2026-02-02 19:15:02.459069');
INSERT INTO public.candidate_voter VALUES (615, 286, 2, 15, '2026-02-02 19:15:02.4602', '2026-02-02 19:15:02.4602');
INSERT INTO public.candidate_voter VALUES (616, 287, 6, 15, '2026-02-02 19:16:03.077618', '2026-02-02 19:16:03.077618');
INSERT INTO public.candidate_voter VALUES (617, 287, 7, 15, '2026-02-02 19:16:03.08049', '2026-02-02 19:16:03.08049');
INSERT INTO public.candidate_voter VALUES (618, 287, 2, 15, '2026-02-02 19:16:03.081653', '2026-02-02 19:16:03.081653');
INSERT INTO public.candidate_voter VALUES (619, 288, 6, 33, '2026-02-02 19:19:57.299479', '2026-02-02 19:19:57.299479');
INSERT INTO public.candidate_voter VALUES (620, 288, 7, 33, '2026-02-02 19:19:57.301184', '2026-02-02 19:19:57.301184');
INSERT INTO public.candidate_voter VALUES (621, 288, 1, 33, '2026-02-02 19:19:57.302276', '2026-02-02 19:19:57.302276');
INSERT INTO public.candidate_voter VALUES (622, 289, 6, 15, '2026-02-02 19:24:30.974883', '2026-02-02 19:24:30.974883');
INSERT INTO public.candidate_voter VALUES (623, 289, 7, 15, '2026-02-02 19:24:30.97678', '2026-02-02 19:24:30.97678');
INSERT INTO public.candidate_voter VALUES (624, 289, 2, 15, '2026-02-02 19:24:30.977733', '2026-02-02 19:24:30.977733');
INSERT INTO public.candidate_voter VALUES (625, 290, 6, 33, '2026-02-02 19:24:42.867084', '2026-02-02 19:24:42.867084');
INSERT INTO public.candidate_voter VALUES (626, 290, 7, 33, '2026-02-02 19:24:42.868639', '2026-02-02 19:24:42.868639');
INSERT INTO public.candidate_voter VALUES (627, 290, 1, 33, '2026-02-02 19:24:42.869398', '2026-02-02 19:24:42.869398');
INSERT INTO public.candidate_voter VALUES (628, 291, 6, 15, '2026-02-02 19:25:30.581226', '2026-02-02 19:25:30.581226');
INSERT INTO public.candidate_voter VALUES (629, 291, 7, 15, '2026-02-02 19:25:30.584081', '2026-02-02 19:25:30.584081');
INSERT INTO public.candidate_voter VALUES (630, 291, 2, 15, '2026-02-02 19:25:30.584908', '2026-02-02 19:25:30.584908');
INSERT INTO public.candidate_voter VALUES (631, 292, 6, 15, '2026-02-02 19:28:18.817747', '2026-02-02 19:28:18.817747');
INSERT INTO public.candidate_voter VALUES (632, 292, 7, 15, '2026-02-02 19:28:18.819486', '2026-02-02 19:28:18.819486');
INSERT INTO public.candidate_voter VALUES (633, 292, 2, 15, '2026-02-02 19:28:18.820975', '2026-02-02 19:28:18.820975');
INSERT INTO public.candidate_voter VALUES (634, 293, 6, 15, '2026-02-02 19:29:55.356006', '2026-02-02 19:29:55.356006');
INSERT INTO public.candidate_voter VALUES (635, 293, 7, 15, '2026-02-02 19:29:55.358138', '2026-02-02 19:29:55.358138');
INSERT INTO public.candidate_voter VALUES (636, 293, 2, 15, '2026-02-02 19:29:55.359024', '2026-02-02 19:29:55.359024');
INSERT INTO public.candidate_voter VALUES (637, 294, 6, 15, '2026-02-02 19:31:09.210507', '2026-02-02 19:31:09.210507');
INSERT INTO public.candidate_voter VALUES (638, 294, 7, 15, '2026-02-02 19:31:09.21256', '2026-02-02 19:31:09.21256');
INSERT INTO public.candidate_voter VALUES (639, 294, 2, 15, '2026-02-02 19:31:09.214251', '2026-02-02 19:31:09.214251');
INSERT INTO public.candidate_voter VALUES (640, 295, 6, 15, '2026-02-02 19:32:30.6205', '2026-02-02 19:32:30.6205');
INSERT INTO public.candidate_voter VALUES (641, 295, 7, 15, '2026-02-02 19:32:30.622118', '2026-02-02 19:32:30.622118');
INSERT INTO public.candidate_voter VALUES (642, 295, 2, 15, '2026-02-02 19:32:30.622996', '2026-02-02 19:32:30.622996');
INSERT INTO public.candidate_voter VALUES (643, 296, 6, 15, '2026-02-02 19:33:17.926943', '2026-02-02 19:33:17.926943');
INSERT INTO public.candidate_voter VALUES (644, 296, 7, 15, '2026-02-02 19:33:17.928571', '2026-02-02 19:33:17.928571');
INSERT INTO public.candidate_voter VALUES (645, 296, 2, 15, '2026-02-02 19:33:17.929438', '2026-02-02 19:33:17.929438');
INSERT INTO public.candidate_voter VALUES (646, 297, 6, 15, '2026-02-02 19:34:23.605714', '2026-02-02 19:34:23.605714');
INSERT INTO public.candidate_voter VALUES (647, 297, 7, 15, '2026-02-02 19:34:23.607642', '2026-02-02 19:34:23.607642');
INSERT INTO public.candidate_voter VALUES (648, 297, 2, 15, '2026-02-02 19:34:23.608655', '2026-02-02 19:34:23.608655');
INSERT INTO public.candidate_voter VALUES (649, 298, 6, 15, '2026-02-02 19:37:10.373642', '2026-02-02 19:37:10.373642');
INSERT INTO public.candidate_voter VALUES (650, 298, 7, 15, '2026-02-02 19:37:10.375494', '2026-02-02 19:37:10.375494');
INSERT INTO public.candidate_voter VALUES (651, 298, 2, 15, '2026-02-02 19:37:10.376348', '2026-02-02 19:37:10.376348');


--
-- TOC entry 5178 (class 0 OID 18021)
-- Dependencies: 222
-- Data for Name: candidates; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.candidates VALUES (1, 'NELLO ZABARAIN', 'Partido Verde', 16, 1, '2026-01-28 04:26:36.336075', '2026-01-28 04:26:36.336075', 6);
INSERT INTO public.candidates VALUES (2, 'JOSE MACEA', 'Partido Verde', 15, 1, '2026-01-28 04:27:58.902113', '2026-01-28 04:27:58.902113', 7);
INSERT INTO public.candidates VALUES (3, 'ALVARO MONEDERO', 'Partido Liberal', 15, 1, '2026-01-28 04:28:35.221904', '2026-01-28 04:28:35.221904', 8);
INSERT INTO public.candidates VALUES (4, 'VIVIANA BLELL', 'Partido Conservador', 21, 1, '2026-01-28 04:29:06.873564', '2026-01-28 04:29:06.873564', 9);
INSERT INTO public.candidates VALUES (5, 'MARIA PAZ GAVIRIA', 'Partido Liberal', 100, 1, '2026-01-28 04:29:49.423045', '2026-01-28 04:29:49.423045', 10);
INSERT INTO public.candidates VALUES (6, 'LUIS RAMIRO RICARDO', 'Partido Asomontemeria', 501, 3, '2026-01-28 04:31:36.083613', '2026-01-28 04:31:36.083613', 11);
INSERT INTO public.candidates VALUES (7, 'ALEJANDRO DE LA OSSA', 'Partido La Fuerza', 101, 2, '2026-01-28 04:32:45.854608', '2026-01-28 04:32:45.854608', 12);


--
-- TOC entry 5180 (class 0 OID 18036)
-- Dependencies: 224
-- Data for Name: corporations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.corporations VALUES (1, 'Senado', '2026-01-28 04:22:29.090278', '2026-01-28 04:22:29.090278');
INSERT INTO public.corporations VALUES (2, 'Camara', '2026-01-28 04:24:13.140847', '2026-01-28 04:24:13.140847');
INSERT INTO public.corporations VALUES (3, 'CITREP', '2026-01-28 04:24:35.160278', '2026-01-28 04:24:35.160278');


--
-- TOC entry 5182 (class 0 OID 18048)
-- Dependencies: 226
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.departments VALUES (1, 'Amazonas', '91', '2026-01-31 18:13:47.698945', '2026-01-31 18:13:47.698945');
INSERT INTO public.departments VALUES (2, 'Antioquia', '05', '2026-01-31 18:13:47.730253', '2026-01-31 18:13:47.730253');
INSERT INTO public.departments VALUES (3, 'Arauca', '81', '2026-01-31 18:13:47.74006', '2026-01-31 18:13:47.74006');
INSERT INTO public.departments VALUES (7, 'Caldas', '17', '2026-01-31 18:13:47.783057', '2026-01-31 18:13:47.783057');
INSERT INTO public.departments VALUES (9, 'Casanare', '85', '2026-01-31 18:13:47.800643', '2026-01-31 18:13:47.800643');
INSERT INTO public.departments VALUES (10, 'Cauca', '19', '2026-01-31 18:13:47.810871', '2026-01-31 18:13:47.810871');
INSERT INTO public.departments VALUES (11, 'Cesar', '20', '2026-01-31 18:13:47.819379', '2026-01-31 18:13:47.819379');
INSERT INTO public.departments VALUES (14, 'Cundinamarca', '25', '2026-01-31 18:13:47.834614', '2026-01-31 18:13:47.834614');
INSERT INTO public.departments VALUES (16, 'Guaviare', '95', '2026-01-31 18:13:47.845819', '2026-01-31 18:13:47.845819');
INSERT INTO public.departments VALUES (17, 'Huila', '41', '2026-01-31 18:13:47.855599', '2026-01-31 18:13:47.855599');
INSERT INTO public.departments VALUES (18, 'La Guajira', '44', '2026-01-31 18:13:47.860954', '2026-01-31 18:13:47.860954');
INSERT INTO public.departments VALUES (19, 'Magdalena', '47', '2026-01-31 18:13:47.873781', '2026-01-31 18:13:47.873781');
INSERT INTO public.departments VALUES (20, 'Meta', '50', '2026-01-31 18:13:47.878722', '2026-01-31 18:13:47.878722');
INSERT INTO public.departments VALUES (21, 'Nari??????o', '52', '2026-01-31 18:13:47.88518', '2026-01-31 18:13:47.88518');
INSERT INTO public.departments VALUES (22, 'Norte de Santander', '54', '2026-01-31 18:13:47.890545', '2026-01-31 18:13:47.890545');
INSERT INTO public.departments VALUES (23, 'Putumayo', '86', '2026-01-31 18:13:47.893999', '2026-01-31 18:13:47.893999');
INSERT INTO public.departments VALUES (25, 'Risaralda', '66', '2026-01-31 18:13:47.905608', '2026-01-31 18:13:47.905608');
INSERT INTO public.departments VALUES (27, 'Santander', '68', '2026-01-31 18:13:47.91355', '2026-01-31 18:13:47.91355');
INSERT INTO public.departments VALUES (28, 'Sucre', '70', '2026-01-31 18:13:47.921752', '2026-01-31 18:13:47.921752');
INSERT INTO public.departments VALUES (29, 'Tolima', '73', '2026-01-31 18:13:47.924999', '2026-01-31 18:13:47.924999');
INSERT INTO public.departments VALUES (31, 'Vichada', '99', '2026-01-31 18:13:47.941556', '2026-01-31 18:13:47.941556');
INSERT INTO public.departments VALUES (32, 'Valle del Cauca', '76', '2026-01-31 18:13:47.947607', '2026-01-31 18:13:47.947607');
INSERT INTO public.departments VALUES (4, 'Atl?????ntico', '08', '2026-01-31 18:13:47.748231', '2026-01-31 18:13:47.748231');
INSERT INTO public.departments VALUES (5, 'Bol?????var', '13', '2026-01-31 18:13:47.75709', '2026-01-31 18:13:47.75709');
INSERT INTO public.departments VALUES (6, 'Boyac?????', '15', '2026-01-31 18:13:47.774615', '2026-01-31 18:13:47.774615');
INSERT INTO public.departments VALUES (8, 'Caquet?????', '18', '2026-01-31 18:13:47.79111', '2026-01-31 18:13:47.79111');
INSERT INTO public.departments VALUES (12, 'Choc??????', '27', '2026-01-31 18:13:47.824743', '2026-01-31 18:13:47.824743');
INSERT INTO public.departments VALUES (13, 'C??????rdoba', '23', '2026-01-31 18:13:47.828533', '2026-01-31 18:13:47.828533');
INSERT INTO public.departments VALUES (15, 'Guain?????a', '94', '2026-01-31 18:13:47.841654', '2026-01-31 18:13:47.841654');
INSERT INTO public.departments VALUES (24, 'Quind?????o', '63', '2026-01-31 18:13:47.898047', '2026-01-31 18:13:47.898047');
INSERT INTO public.departments VALUES (26, 'San Andr?????s y Providencia', '88', '2026-01-31 18:13:47.910148', '2026-01-31 18:13:47.910148');
INSERT INTO public.departments VALUES (30, 'Vaup?????s', '97', '2026-01-31 18:13:47.928892', '2026-01-31 18:13:47.928892');


--
-- TOC entry 5184 (class 0 OID 18060)
-- Dependencies: 228
-- Data for Name: leaders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.leaders VALUES (1, 'HELMAR MENDOZA', '1888116', 'OVEJAS', '3103814496', '2026-01-28 04:39:16.692673', '2026-01-28 04:39:16.692673', 13);
INSERT INTO public.leaders VALUES (2, 'RAMIRO TAPIA', '1101815743', 'OVEJAS', '3104185836', '2026-01-28 04:39:16.710243', '2026-01-28 04:39:16.710243', 14);
INSERT INTO public.leaders VALUES (3, 'FERNEY BENITEZ', '1101814600', 'OVEJAS', '3123175442', '2026-01-28 04:39:16.71602', '2026-01-28 04:39:16.71602', 15);
INSERT INTO public.leaders VALUES (4, 'JONATAN BETIN', '1101819246', 'OVEJAS', '3215501919', '2026-01-28 04:39:16.723497', '2026-01-28 04:39:16.723497', 16);
INSERT INTO public.leaders VALUES (5, 'ELSON ARANATES ACOSTA RIVERO', '1888032', 'OVEJAS', '3242186015', '2026-01-28 04:39:16.731537', '2026-01-28 04:39:16.731537', 17);
INSERT INTO public.leaders VALUES (6, 'BERTONIS DE LA ROSA', '1888127', 'OVEJAS', '3016510045', '2026-01-28 04:39:16.739769', '2026-01-28 04:39:16.739769', 18);
INSERT INTO public.leaders VALUES (7, 'JOSE RAMIRO PULGAR ALVAREZ', '1888090', 'OVEJAS', '3004603704', '2026-01-28 04:39:16.745463', '2026-01-28 04:39:16.745463', 19);
INSERT INTO public.leaders VALUES (8, 'GILBERTO CARLOS MANJARRES MEZA', '1102803329', 'OVEJAS', '3008111845', '2026-01-28 04:39:16.749773', '2026-01-28 04:39:16.749773', 20);
INSERT INTO public.leaders VALUES (9, 'ISMAEL CARLOS SIERRA TORRES', '1888121', 'OVEJAS', '3202979251', '2026-01-28 04:39:16.755299', '2026-01-28 04:39:16.755299', 21);
INSERT INTO public.leaders VALUES (10, 'NESTOR ENRIQUE GARCIA ARRIETA', '1102801828', 'OVEJAS', '3116739295', '2026-01-28 04:39:16.761024', '2026-01-28 04:39:16.761024', 22);
INSERT INTO public.leaders VALUES (11, 'ALVARO ENRIQUE VITOLA TERAN', '1887727', 'OVEJAS', '3103613152', '2026-01-28 04:39:16.767492', '2026-01-28 04:39:16.767492', 23);
INSERT INTO public.leaders VALUES (12, 'PABLO ANTONIO CENTENO CORTEZ', '92128741', 'OVEJAS', '3005261321', '2026-01-28 04:39:16.77297', '2026-01-28 04:39:16.77297', 24);
INSERT INTO public.leaders VALUES (13, 'ANIBAL JOSE GONZALEZ GARRIDO', '1888015', 'OVEJAS', '3007970434', '2026-01-28 04:39:16.779317', '2026-01-28 04:39:16.779317', 25);
INSERT INTO public.leaders VALUES (14, 'ALEX ANGULO RIVERO', '1102148601', 'OVEJAS', '3145063528', '2026-01-28 04:39:16.785057', '2026-01-28 04:39:16.785057', 26);
INSERT INTO public.leaders VALUES (15, 'JOAQUIN ANTONIO GONZALEZ GALVIS', '1887901', 'OVEJAS', '3103905217', '2026-01-28 04:39:16.790823', '2026-01-28 04:39:16.790823', 27);
INSERT INTO public.leaders VALUES (16, 'BETSABE SEGUNDO BLANCO BENITEZ', '1887681', 'OVEJAS', '3024188532', '2026-01-28 04:39:16.796287', '2026-01-28 04:39:16.796287', 28);
INSERT INTO public.leaders VALUES (17, 'OSCAR ANIBAL NARVAEZ OVIEDO', '1101812419', 'OVEJAS', '3105488048', '2026-01-28 04:39:16.80209', '2026-01-28 04:39:16.80209', 29);
INSERT INTO public.leaders VALUES (18, 'HARLINTON GARCIA BARRETO', '1887822', 'OVEJAS', '3126363991', '2026-01-28 04:39:16.807224', '2026-01-28 04:39:16.807224', 30);
INSERT INTO public.leaders VALUES (19, 'CARLOS ROBERTO ARAQUE GAMBOA', '1101814403', 'OVEJAS', '3043973417', '2026-01-28 04:39:16.814241', '2026-01-28 04:39:16.814241', 31);
INSERT INTO public.leaders VALUES (20, 'JORGE LUIS HERRERA MENDOZA', '3921096', 'OVEJAS', '3148833300', '2026-01-28 04:39:16.821513', '2026-01-28 04:39:16.821513', 32);
INSERT INTO public.leaders VALUES (21, 'JOSE NOVOA TRUJILLO', '8722160', 'OVEJAS', '3016753661', '2026-01-28 04:39:16.827363', '2026-01-28 04:39:16.827363', 33);
INSERT INTO public.leaders VALUES (22, 'FREDY ANTONIO JARABA CAUSADO', '1888042', 'OVEJAS', '3145034999', '2026-01-28 04:39:16.832087', '2026-01-28 04:39:16.832087', 34);
INSERT INTO public.leaders VALUES (23, 'JOSE RICARDO RODRIGUEZ', '92499068', 'OVEJAS', '3046442171', '2026-01-28 04:39:16.836681', '2026-01-28 04:39:16.836681', 35);
INSERT INTO public.leaders VALUES (24, 'RAFAEL FRANCISCO MEDINA OSORIO', '9307740', 'OVEJAS', '3015921941', '2026-01-28 04:39:16.84082', '2026-01-28 04:39:16.84082', 36);
INSERT INTO public.leaders VALUES (25, 'SILVANO VERGARA DIAZ', '3959494', 'SAN MARCOS', '3116516862', '2026-01-28 04:39:16.845965', '2026-01-28 04:39:16.845965', 37);
INSERT INTO public.leaders VALUES (26, 'VLADIMIR ZURITA', '1085926581', 'SAN MARCOS', '3104921217', '2026-01-28 04:39:16.850541', '2026-01-28 04:39:16.850541', 38);
INSERT INTO public.leaders VALUES (27, 'JAIRO JOSE HERNANDEZ SAENZ', '1018502694', 'SAN MARCOS', '3147784204', '2026-01-28 04:39:16.857204', '2026-01-28 04:39:16.857204', 39);
INSERT INTO public.leaders VALUES (28, 'JESUS DIAZ', '1876110', 'BUENAVISTA', '3217998340', '2026-01-28 04:39:16.86243', '2026-01-28 04:39:16.86243', 40);
INSERT INTO public.leaders VALUES (29, 'JAIRO CARA??O', '7200886', 'SINCE', '3007010517', '2026-01-28 04:39:16.869025', '2026-01-28 04:39:16.869025', 41);
INSERT INTO public.leaders VALUES (30, 'PIEDAD PEREZ PELUFFO', '6489186', 'OVEJAS', '3145263542', '2026-01-28 04:39:16.873184', '2026-01-28 04:39:16.873184', 42);
INSERT INTO public.leaders VALUES (31, 'LUIS GIL PUENTES', '1887915', 'OVEJAS', '3207387189', '2026-01-28 04:39:16.878478', '2026-01-28 04:39:16.878478', 43);
INSERT INTO public.leaders VALUES (32, 'LINA MARIA PELUFFO RAMIREZ', '1101814341', 'OVEJAS', '3215436859', '2026-01-28 04:39:16.88283', '2026-01-28 04:39:16.88283', 44);
INSERT INTO public.leaders VALUES (33, 'JUAN MERCADO', '1888182', 'OVEJAS', '3145263542', '2026-01-28 04:39:16.886703', '2026-01-28 04:39:16.886703', 45);
INSERT INTO public.leaders VALUES (34, 'HOLMAN MERI??O', '7227100', 'OVEJAS', '3206600577', '2026-01-28 04:39:16.891635', '2026-01-28 04:39:16.891635', 46);


--
-- TOC entry 5186 (class 0 OID 18075)
-- Dependencies: 230
-- Data for Name: municipalities; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.municipalities VALUES (1, 'LETICIA', NULL, 1, '2026-01-31 18:27:04.977093', '2026-01-31 18:27:04.977093');
INSERT INTO public.municipalities VALUES (2, 'PUERTO NARI?????O', NULL, 1, '2026-01-31 18:27:05.004898', '2026-01-31 18:27:05.004898');
INSERT INTO public.municipalities VALUES (3, 'EL ENCANTO', NULL, 1, '2026-01-31 18:27:05.011839', '2026-01-31 18:27:05.011839');
INSERT INTO public.municipalities VALUES (4, 'LA CHORRERA', NULL, 1, '2026-01-31 18:27:05.019769', '2026-01-31 18:27:05.019769');
INSERT INTO public.municipalities VALUES (5, 'LA PEDRERA', NULL, 1, '2026-01-31 18:27:05.028643', '2026-01-31 18:27:05.028643');
INSERT INTO public.municipalities VALUES (6, 'LA VICTORIA', NULL, 1, '2026-01-31 18:27:05.039062', '2026-01-31 18:27:05.039062');
INSERT INTO public.municipalities VALUES (7, 'MIRITI PARANA', NULL, 1, '2026-01-31 18:27:05.04539', '2026-01-31 18:27:05.04539');
INSERT INTO public.municipalities VALUES (8, 'PUERTO SANTANDER', NULL, 1, '2026-01-31 18:27:05.052717', '2026-01-31 18:27:05.052717');
INSERT INTO public.municipalities VALUES (9, 'TARAPACA', NULL, 1, '2026-01-31 18:27:05.061147', '2026-01-31 18:27:05.061147');
INSERT INTO public.municipalities VALUES (10, 'PUERTO ALEGRIA', NULL, 1, '2026-01-31 18:27:05.071259', '2026-01-31 18:27:05.071259');
INSERT INTO public.municipalities VALUES (11, 'PUERTO ARICA', NULL, 1, '2026-01-31 18:27:05.075985', '2026-01-31 18:27:05.075985');
INSERT INTO public.municipalities VALUES (12, 'MEDELLIN', NULL, 2, '2026-01-31 18:32:22.783826', '2026-01-31 18:32:22.783826');
INSERT INTO public.municipalities VALUES (13, 'ABEJORRAL', NULL, 2, '2026-01-31 18:32:22.798611', '2026-01-31 18:32:22.798611');
INSERT INTO public.municipalities VALUES (14, 'ABRIAQUI', NULL, 2, '2026-01-31 18:32:22.804437', '2026-01-31 18:32:22.804437');
INSERT INTO public.municipalities VALUES (15, 'ALEJANDRIA', NULL, 2, '2026-01-31 18:32:22.810578', '2026-01-31 18:32:22.810578');
INSERT INTO public.municipalities VALUES (16, 'AMAGA', NULL, 2, '2026-01-31 18:32:22.817355', '2026-01-31 18:32:22.817355');
INSERT INTO public.municipalities VALUES (17, 'AMALFI', NULL, 2, '2026-01-31 18:32:22.823233', '2026-01-31 18:32:22.823233');
INSERT INTO public.municipalities VALUES (18, 'ANDES', NULL, 2, '2026-01-31 18:32:22.832177', '2026-01-31 18:32:22.832177');
INSERT INTO public.municipalities VALUES (19, 'ANGELOPOLIS', NULL, 2, '2026-01-31 18:32:22.836865', '2026-01-31 18:32:22.836865');
INSERT INTO public.municipalities VALUES (20, 'ANGOSTURA', NULL, 2, '2026-01-31 18:32:22.843422', '2026-01-31 18:32:22.843422');
INSERT INTO public.municipalities VALUES (21, 'ANORI', NULL, 2, '2026-01-31 18:32:22.852299', '2026-01-31 18:32:22.852299');
INSERT INTO public.municipalities VALUES (22, 'ANTIOQUIA', NULL, 2, '2026-01-31 18:32:22.857324', '2026-01-31 18:32:22.857324');
INSERT INTO public.municipalities VALUES (23, 'ANZA', NULL, 2, '2026-01-31 18:32:22.864181', '2026-01-31 18:32:22.864181');
INSERT INTO public.municipalities VALUES (24, 'APARTADO', NULL, 2, '2026-01-31 18:32:22.868623', '2026-01-31 18:32:22.868623');
INSERT INTO public.municipalities VALUES (25, 'ARBOLETES', NULL, 2, '2026-01-31 18:32:22.873145', '2026-01-31 18:32:22.873145');
INSERT INTO public.municipalities VALUES (26, 'ARGELIA', NULL, 2, '2026-01-31 18:32:22.879773', '2026-01-31 18:32:22.879773');
INSERT INTO public.municipalities VALUES (27, 'ARMENIA', NULL, 2, '2026-01-31 18:32:22.884282', '2026-01-31 18:32:22.884282');
INSERT INTO public.municipalities VALUES (28, 'BARBOSA', NULL, 2, '2026-01-31 18:32:22.888771', '2026-01-31 18:32:22.888771');
INSERT INTO public.municipalities VALUES (29, 'BELMIRA', NULL, 2, '2026-01-31 18:32:22.896605', '2026-01-31 18:32:22.896605');
INSERT INTO public.municipalities VALUES (30, 'BELLO', NULL, 2, '2026-01-31 18:32:22.901198', '2026-01-31 18:32:22.901198');
INSERT INTO public.municipalities VALUES (31, 'BETANIA', NULL, 2, '2026-01-31 18:32:22.905824', '2026-01-31 18:32:22.905824');
INSERT INTO public.municipalities VALUES (32, 'BETULIA', NULL, 2, '2026-01-31 18:32:22.913299', '2026-01-31 18:32:22.913299');
INSERT INTO public.municipalities VALUES (33, 'BOLIVAR', NULL, 2, '2026-01-31 18:32:22.918765', '2026-01-31 18:32:22.918765');
INSERT INTO public.municipalities VALUES (34, 'BURITICA', NULL, 2, '2026-01-31 18:32:22.923303', '2026-01-31 18:32:22.923303');
INSERT INTO public.municipalities VALUES (35, 'BRICE?????O', NULL, 2, '2026-01-31 18:32:22.930453', '2026-01-31 18:32:22.930453');
INSERT INTO public.municipalities VALUES (36, 'CACERES', NULL, 2, '2026-01-31 18:32:22.934566', '2026-01-31 18:32:22.934566');
INSERT INTO public.municipalities VALUES (37, 'CAICEDO', NULL, 2, '2026-01-31 18:32:22.939188', '2026-01-31 18:32:22.939188');
INSERT INTO public.municipalities VALUES (38, 'CALDAS', NULL, 2, '2026-01-31 18:32:22.946629', '2026-01-31 18:32:22.946629');
INSERT INTO public.municipalities VALUES (39, 'CAMPAMENTO', NULL, 2, '2026-01-31 18:32:22.950886', '2026-01-31 18:32:22.950886');
INSERT INTO public.municipalities VALUES (40, 'CA?????ASGORDAS', NULL, 2, '2026-01-31 18:32:22.955312', '2026-01-31 18:32:22.955312');
INSERT INTO public.municipalities VALUES (41, 'CARACOLI', NULL, 2, '2026-01-31 18:32:22.960686', '2026-01-31 18:32:22.960686');
INSERT INTO public.municipalities VALUES (42, 'CARAMANTA', NULL, 2, '2026-01-31 18:32:22.96614', '2026-01-31 18:32:22.96614');
INSERT INTO public.municipalities VALUES (43, 'CAREPA', NULL, 2, '2026-01-31 18:32:22.970234', '2026-01-31 18:32:22.970234');
INSERT INTO public.municipalities VALUES (44, 'CARMEN DE VIBORAL', NULL, 2, '2026-01-31 18:32:22.974075', '2026-01-31 18:32:22.974075');
INSERT INTO public.municipalities VALUES (45, 'CAROLINA', NULL, 2, '2026-01-31 18:32:22.981111', '2026-01-31 18:32:22.981111');
INSERT INTO public.municipalities VALUES (46, 'CAUCASIA', NULL, 2, '2026-01-31 18:32:22.985053', '2026-01-31 18:32:22.985053');
INSERT INTO public.municipalities VALUES (47, 'CISNEROS', NULL, 2, '2026-01-31 18:32:22.988991', '2026-01-31 18:32:22.988991');
INSERT INTO public.municipalities VALUES (48, 'COCORNA', NULL, 2, '2026-01-31 18:32:22.994877', '2026-01-31 18:32:22.994877');
INSERT INTO public.municipalities VALUES (49, 'CONCEPCION', NULL, 2, '2026-01-31 18:32:22.999227', '2026-01-31 18:32:22.999227');
INSERT INTO public.municipalities VALUES (50, 'CONCORDIA', NULL, 2, '2026-01-31 18:32:23.004111', '2026-01-31 18:32:23.004111');
INSERT INTO public.municipalities VALUES (51, 'COPACABANA', NULL, 2, '2026-01-31 18:32:23.014013', '2026-01-31 18:32:23.014013');
INSERT INTO public.municipalities VALUES (52, 'CHIGORODO', NULL, 2, '2026-01-31 18:32:23.01855', '2026-01-31 18:32:23.01855');
INSERT INTO public.municipalities VALUES (53, 'DABEIBA', NULL, 2, '2026-01-31 18:32:23.023129', '2026-01-31 18:32:23.023129');
INSERT INTO public.municipalities VALUES (54, 'DON MATIAS', NULL, 2, '2026-01-31 18:32:23.029915', '2026-01-31 18:32:23.029915');
INSERT INTO public.municipalities VALUES (55, 'EBEJICO', NULL, 2, '2026-01-31 18:32:23.034442', '2026-01-31 18:32:23.034442');
INSERT INTO public.municipalities VALUES (56, 'EL BAGRE', NULL, 2, '2026-01-31 18:32:23.038852', '2026-01-31 18:32:23.038852');
INSERT INTO public.municipalities VALUES (57, 'ENTRERRIOS', NULL, 2, '2026-01-31 18:32:23.04378', '2026-01-31 18:32:23.04378');
INSERT INTO public.municipalities VALUES (58, 'ENVIGADO', NULL, 2, '2026-01-31 18:32:23.049755', '2026-01-31 18:32:23.049755');
INSERT INTO public.municipalities VALUES (59, 'FREDONIA', NULL, 2, '2026-01-31 18:32:23.054315', '2026-01-31 18:32:23.054315');
INSERT INTO public.municipalities VALUES (60, 'FRONTINO', NULL, 2, '2026-01-31 18:32:23.059223', '2026-01-31 18:32:23.059223');
INSERT INTO public.municipalities VALUES (61, 'GIRALDO', NULL, 2, '2026-01-31 18:32:23.063891', '2026-01-31 18:32:23.063891');
INSERT INTO public.municipalities VALUES (62, 'GIRARDOTA', NULL, 2, '2026-01-31 18:32:23.071984', '2026-01-31 18:32:23.071984');
INSERT INTO public.municipalities VALUES (63, 'GOMEZ PLATA', NULL, 2, '2026-01-31 18:32:23.077138', '2026-01-31 18:32:23.077138');
INSERT INTO public.municipalities VALUES (64, 'GRANADA', NULL, 2, '2026-01-31 18:32:23.083318', '2026-01-31 18:32:23.083318');
INSERT INTO public.municipalities VALUES (65, 'GUADALUPE', NULL, 2, '2026-01-31 18:32:23.08754', '2026-01-31 18:32:23.08754');
INSERT INTO public.municipalities VALUES (66, 'GUARNE', NULL, 2, '2026-01-31 18:32:23.092594', '2026-01-31 18:32:23.092594');
INSERT INTO public.municipalities VALUES (67, 'GUATAPE', NULL, 2, '2026-01-31 18:32:23.098703', '2026-01-31 18:32:23.098703');
INSERT INTO public.municipalities VALUES (68, 'HELICONIA', NULL, 2, '2026-01-31 18:32:23.102996', '2026-01-31 18:32:23.102996');
INSERT INTO public.municipalities VALUES (69, 'HISPANIA', NULL, 2, '2026-01-31 18:32:23.106858', '2026-01-31 18:32:23.106858');
INSERT INTO public.municipalities VALUES (70, 'ITAGUI', NULL, 2, '2026-01-31 18:32:23.114508', '2026-01-31 18:32:23.114508');
INSERT INTO public.municipalities VALUES (71, 'ITUANGO', NULL, 2, '2026-01-31 18:32:23.119157', '2026-01-31 18:32:23.119157');
INSERT INTO public.municipalities VALUES (72, 'JARDIN', NULL, 2, '2026-01-31 18:32:23.122868', '2026-01-31 18:32:23.122868');
INSERT INTO public.municipalities VALUES (73, 'JERICO', NULL, 2, '2026-01-31 18:32:23.128466', '2026-01-31 18:32:23.128466');
INSERT INTO public.municipalities VALUES (74, 'LA CEJA', NULL, 2, '2026-01-31 18:32:23.13454', '2026-01-31 18:32:23.13454');
INSERT INTO public.municipalities VALUES (75, 'LA ESTRELLA', NULL, 2, '2026-01-31 18:32:23.138884', '2026-01-31 18:32:23.138884');
INSERT INTO public.municipalities VALUES (76, 'PUERTO NARE-LA MAGDALENA', NULL, 2, '2026-01-31 18:32:23.143543', '2026-01-31 18:32:23.143543');
INSERT INTO public.municipalities VALUES (77, 'LA UNION', NULL, 2, '2026-01-31 18:32:23.15001', '2026-01-31 18:32:23.15001');
INSERT INTO public.municipalities VALUES (78, 'LA PINTADA', NULL, 2, '2026-01-31 18:32:23.153844', '2026-01-31 18:32:23.153844');
INSERT INTO public.municipalities VALUES (79, 'LIBORINA', NULL, 2, '2026-01-31 18:32:23.157772', '2026-01-31 18:32:23.157772');
INSERT INTO public.municipalities VALUES (80, 'MACEO', NULL, 2, '2026-01-31 18:32:23.164817', '2026-01-31 18:32:23.164817');
INSERT INTO public.municipalities VALUES (81, 'MARINILLA', NULL, 2, '2026-01-31 18:32:23.168983', '2026-01-31 18:32:23.168983');
INSERT INTO public.municipalities VALUES (82, 'MONTEBELLO', NULL, 2, '2026-01-31 18:32:23.173565', '2026-01-31 18:32:23.173565');
INSERT INTO public.municipalities VALUES (83, 'MURINDO', NULL, 2, '2026-01-31 18:32:23.180191', '2026-01-31 18:32:23.180191');
INSERT INTO public.municipalities VALUES (84, 'MUTATA', NULL, 2, '2026-01-31 18:32:23.184314', '2026-01-31 18:32:23.184314');
INSERT INTO public.municipalities VALUES (85, 'NARI?????O', NULL, 2, '2026-01-31 18:32:23.187914', '2026-01-31 18:32:23.187914');
INSERT INTO public.municipalities VALUES (86, 'NECHI', NULL, 2, '2026-01-31 18:32:23.192213', '2026-01-31 18:32:23.192213');
INSERT INTO public.municipalities VALUES (87, 'NECOCLI', NULL, 2, '2026-01-31 18:32:23.198385', '2026-01-31 18:32:23.198385');
INSERT INTO public.municipalities VALUES (88, 'OLAYA', NULL, 2, '2026-01-31 18:32:23.202404', '2026-01-31 18:32:23.202404');
INSERT INTO public.municipalities VALUES (89, 'PE?????OL', NULL, 2, '2026-01-31 18:32:23.206395', '2026-01-31 18:32:23.206395');
INSERT INTO public.municipalities VALUES (90, 'PEQUE', NULL, 2, '2026-01-31 18:32:23.212794', '2026-01-31 18:32:23.212794');
INSERT INTO public.municipalities VALUES (91, 'PUEBLORRICO', NULL, 2, '2026-01-31 18:32:23.216798', '2026-01-31 18:32:23.216798');
INSERT INTO public.municipalities VALUES (92, 'PUERTO BERRIO', NULL, 2, '2026-01-31 18:32:23.221032', '2026-01-31 18:32:23.221032');
INSERT INTO public.municipalities VALUES (93, 'PUERTO TRIUNFO', NULL, 2, '2026-01-31 18:32:23.228843', '2026-01-31 18:32:23.228843');
INSERT INTO public.municipalities VALUES (94, 'REMEDIOS', NULL, 2, '2026-01-31 18:32:23.233555', '2026-01-31 18:32:23.233555');
INSERT INTO public.municipalities VALUES (95, 'RETIRO', NULL, 2, '2026-01-31 18:32:23.237013', '2026-01-31 18:32:23.237013');
INSERT INTO public.municipalities VALUES (96, 'RIONEGRO', NULL, 2, '2026-01-31 18:32:23.241855', '2026-01-31 18:32:23.241855');
INSERT INTO public.municipalities VALUES (98, 'SABANETA', NULL, 2, '2026-01-31 18:32:23.252166', '2026-01-31 18:32:23.252166');
INSERT INTO public.municipalities VALUES (99, 'SALGAR', NULL, 2, '2026-01-31 18:32:23.25608', '2026-01-31 18:32:23.25608');
INSERT INTO public.municipalities VALUES (100, 'SAN ANDRES', NULL, 2, '2026-01-31 18:32:23.262107', '2026-01-31 18:32:23.262107');
INSERT INTO public.municipalities VALUES (101, 'SAN CARLOS', NULL, 2, '2026-01-31 18:32:23.266435', '2026-01-31 18:32:23.266435');
INSERT INTO public.municipalities VALUES (102, 'SAN FRANCISCO', NULL, 2, '2026-01-31 18:32:23.269926', '2026-01-31 18:32:23.269926');
INSERT INTO public.municipalities VALUES (103, 'SAN JERONIMO', NULL, 2, '2026-01-31 18:32:23.273574', '2026-01-31 18:32:23.273574');
INSERT INTO public.municipalities VALUES (104, 'SAN JOSE DE LA MONTA?????A', NULL, 2, '2026-01-31 18:32:23.278461', '2026-01-31 18:32:23.278461');
INSERT INTO public.municipalities VALUES (105, 'SAN JUAN DE URABA', NULL, 2, '2026-01-31 18:32:23.283735', '2026-01-31 18:32:23.283735');
INSERT INTO public.municipalities VALUES (106, 'SAN LUIS', NULL, 2, '2026-01-31 18:32:23.287501', '2026-01-31 18:32:23.287501');
INSERT INTO public.municipalities VALUES (107, 'SAN PEDRO', NULL, 2, '2026-01-31 18:32:23.291599', '2026-01-31 18:32:23.291599');
INSERT INTO public.municipalities VALUES (108, 'SAN PEDRO DE URABA', NULL, 2, '2026-01-31 18:32:23.296402', '2026-01-31 18:32:23.296402');
INSERT INTO public.municipalities VALUES (109, 'SAN RAFAEL', NULL, 2, '2026-01-31 18:32:23.300662', '2026-01-31 18:32:23.300662');
INSERT INTO public.municipalities VALUES (110, 'SAN ROQUE', NULL, 2, '2026-01-31 18:32:23.305017', '2026-01-31 18:32:23.305017');
INSERT INTO public.municipalities VALUES (111, 'SAN VICENTE', NULL, 2, '2026-01-31 18:32:23.311936', '2026-01-31 18:32:23.311936');
INSERT INTO public.municipalities VALUES (112, 'SANTA BARBARA', NULL, 2, '2026-01-31 18:32:23.318944', '2026-01-31 18:32:23.318944');
INSERT INTO public.municipalities VALUES (113, 'SANTA ROSA DE OSOS', NULL, 2, '2026-01-31 18:32:23.322907', '2026-01-31 18:32:23.322907');
INSERT INTO public.municipalities VALUES (114, 'SANTO DOMINGO', NULL, 2, '2026-01-31 18:32:23.329928', '2026-01-31 18:32:23.329928');
INSERT INTO public.municipalities VALUES (115, 'SANTUARIO', NULL, 2, '2026-01-31 18:32:23.334461', '2026-01-31 18:32:23.334461');
INSERT INTO public.municipalities VALUES (116, 'SEGOVIA', NULL, 2, '2026-01-31 18:32:23.33937', '2026-01-31 18:32:23.33937');
INSERT INTO public.municipalities VALUES (117, 'SONSON', NULL, 2, '2026-01-31 18:32:23.347625', '2026-01-31 18:32:23.347625');
INSERT INTO public.municipalities VALUES (118, 'SOPETRAN', NULL, 2, '2026-01-31 18:32:23.351853', '2026-01-31 18:32:23.351853');
INSERT INTO public.municipalities VALUES (119, 'TAMESIS', NULL, 2, '2026-01-31 18:32:23.356189', '2026-01-31 18:32:23.356189');
INSERT INTO public.municipalities VALUES (120, 'TARAZA', NULL, 2, '2026-01-31 18:32:23.368092', '2026-01-31 18:32:23.368092');
INSERT INTO public.municipalities VALUES (121, 'TARSO', NULL, 2, '2026-01-31 18:32:23.372375', '2026-01-31 18:32:23.372375');
INSERT INTO public.municipalities VALUES (122, 'TITIRIBI', NULL, 2, '2026-01-31 18:32:23.380126', '2026-01-31 18:32:23.380126');
INSERT INTO public.municipalities VALUES (123, 'TOLEDO', NULL, 2, '2026-01-31 18:32:23.385929', '2026-01-31 18:32:23.385929');
INSERT INTO public.municipalities VALUES (124, 'TURBO', NULL, 2, '2026-01-31 18:32:23.390028', '2026-01-31 18:32:23.390028');
INSERT INTO public.municipalities VALUES (125, 'URAMITA', NULL, 2, '2026-01-31 18:32:23.396519', '2026-01-31 18:32:23.396519');
INSERT INTO public.municipalities VALUES (126, 'URRAO', NULL, 2, '2026-01-31 18:32:23.40237', '2026-01-31 18:32:23.40237');
INSERT INTO public.municipalities VALUES (127, 'VALDIVIA', NULL, 2, '2026-01-31 18:32:23.406476', '2026-01-31 18:32:23.406476');
INSERT INTO public.municipalities VALUES (128, 'VALPARAISO', NULL, 2, '2026-01-31 18:32:23.412623', '2026-01-31 18:32:23.412623');
INSERT INTO public.municipalities VALUES (129, 'VEGACHI', NULL, 2, '2026-01-31 18:32:23.416839', '2026-01-31 18:32:23.416839');
INSERT INTO public.municipalities VALUES (130, 'VIGIA DEL FUERTE', NULL, 2, '2026-01-31 18:32:23.420962', '2026-01-31 18:32:23.420962');
INSERT INTO public.municipalities VALUES (131, 'VENECIA', NULL, 2, '2026-01-31 18:32:23.425424', '2026-01-31 18:32:23.425424');
INSERT INTO public.municipalities VALUES (132, 'YALI', NULL, 2, '2026-01-31 18:32:23.43173', '2026-01-31 18:32:23.43173');
INSERT INTO public.municipalities VALUES (133, 'YARUMAL', NULL, 2, '2026-01-31 18:32:23.435646', '2026-01-31 18:32:23.435646');
INSERT INTO public.municipalities VALUES (134, 'YOLOMBO', NULL, 2, '2026-01-31 18:32:23.439715', '2026-01-31 18:32:23.439715');
INSERT INTO public.municipalities VALUES (135, 'YONDO-CASABE', NULL, 2, '2026-01-31 18:32:23.446138', '2026-01-31 18:32:23.446138');
INSERT INTO public.municipalities VALUES (136, 'ZARAGOZA', NULL, 2, '2026-01-31 18:32:23.450214', '2026-01-31 18:32:23.450214');
INSERT INTO public.municipalities VALUES (137, 'ARAUCA', NULL, 3, '2026-01-31 18:36:30.310908', '2026-01-31 18:36:30.310908');
INSERT INTO public.municipalities VALUES (138, 'TAME', NULL, 3, '2026-01-31 18:36:30.328593', '2026-01-31 18:36:30.328593');
INSERT INTO public.municipalities VALUES (139, 'ARAUQUITA', NULL, 3, '2026-01-31 18:36:30.333737', '2026-01-31 18:36:30.333737');
INSERT INTO public.municipalities VALUES (140, 'CRAVO NORTE', NULL, 3, '2026-01-31 18:36:30.34025', '2026-01-31 18:36:30.34025');
INSERT INTO public.municipalities VALUES (141, 'FORTUL', NULL, 3, '2026-01-31 18:36:30.344639', '2026-01-31 18:36:30.344639');
INSERT INTO public.municipalities VALUES (142, 'PUERTO RONDON', NULL, 3, '2026-01-31 18:36:30.349183', '2026-01-31 18:36:30.349183');
INSERT INTO public.municipalities VALUES (143, 'SARAVENA', NULL, 3, '2026-01-31 18:36:30.353161', '2026-01-31 18:36:30.353161');
INSERT INTO public.municipalities VALUES (144, 'BARRANQUILLA', NULL, 4, '2026-01-31 18:37:52.898909', '2026-01-31 18:37:52.898909');
INSERT INTO public.municipalities VALUES (145, 'BARANOA', NULL, 4, '2026-01-31 18:37:52.927491', '2026-01-31 18:37:52.927491');
INSERT INTO public.municipalities VALUES (146, 'CAMPO DE LA CRUZ', NULL, 4, '2026-01-31 18:37:52.946997', '2026-01-31 18:37:52.946997');
INSERT INTO public.municipalities VALUES (147, 'CANDELARIA', NULL, 4, '2026-01-31 18:37:52.963811', '2026-01-31 18:37:52.963811');
INSERT INTO public.municipalities VALUES (148, 'GALAPA', NULL, 4, '2026-01-31 18:37:52.980557', '2026-01-31 18:37:52.980557');
INSERT INTO public.municipalities VALUES (149, 'JUAN DE ACOSTA', NULL, 4, '2026-01-31 18:37:52.99694', '2026-01-31 18:37:52.99694');
INSERT INTO public.municipalities VALUES (150, 'LURUACO', NULL, 4, '2026-01-31 18:37:53.014284', '2026-01-31 18:37:53.014284');
INSERT INTO public.municipalities VALUES (151, 'MALAMBO', NULL, 4, '2026-01-31 18:37:53.033018', '2026-01-31 18:37:53.033018');
INSERT INTO public.municipalities VALUES (152, 'MANATI', NULL, 4, '2026-01-31 18:37:53.050646', '2026-01-31 18:37:53.050646');
INSERT INTO public.municipalities VALUES (153, 'PALMAR DE VARELA', NULL, 4, '2026-01-31 18:37:53.067611', '2026-01-31 18:37:53.067611');
INSERT INTO public.municipalities VALUES (154, 'PIOJO', NULL, 4, '2026-01-31 18:37:53.084374', '2026-01-31 18:37:53.084374');
INSERT INTO public.municipalities VALUES (155, 'POLONUEVO', NULL, 4, '2026-01-31 18:37:53.100471', '2026-01-31 18:37:53.100471');
INSERT INTO public.municipalities VALUES (156, 'PONEDERA', NULL, 4, '2026-01-31 18:37:53.118517', '2026-01-31 18:37:53.118517');
INSERT INTO public.municipalities VALUES (157, 'PUERTO COLOMBIA', NULL, 4, '2026-01-31 18:37:53.136057', '2026-01-31 18:37:53.136057');
INSERT INTO public.municipalities VALUES (158, 'REPELON', NULL, 4, '2026-01-31 18:37:53.154479', '2026-01-31 18:37:53.154479');
INSERT INTO public.municipalities VALUES (159, 'SABANAGRANDE', NULL, 4, '2026-01-31 18:37:53.180333', '2026-01-31 18:37:53.180333');
INSERT INTO public.municipalities VALUES (162, 'SABANALARGA', NULL, 2, '2026-01-31 18:41:27.851947', '2026-01-31 18:41:27.851947');
INSERT INTO public.municipalities VALUES (164, 'SABANALARGA', NULL, 4, '2026-01-31 18:42:23.734387', '2026-01-31 18:42:23.734387');
INSERT INTO public.municipalities VALUES (165, 'SANTA LUCIA', NULL, 4, '2026-01-31 18:42:23.753597', '2026-01-31 18:42:23.753597');
INSERT INTO public.municipalities VALUES (166, 'SANTO TOMAS', NULL, 4, '2026-01-31 18:42:23.758559', '2026-01-31 18:42:23.758559');
INSERT INTO public.municipalities VALUES (167, 'SOLEDAD', NULL, 4, '2026-01-31 18:42:23.764535', '2026-01-31 18:42:23.764535');
INSERT INTO public.municipalities VALUES (168, 'SUAN', NULL, 4, '2026-01-31 18:42:23.76993', '2026-01-31 18:42:23.76993');
INSERT INTO public.municipalities VALUES (169, 'TUBARA', NULL, 4, '2026-01-31 18:42:23.773937', '2026-01-31 18:42:23.773937');
INSERT INTO public.municipalities VALUES (170, 'USIACURI', NULL, 4, '2026-01-31 18:42:23.777834', '2026-01-31 18:42:23.777834');
INSERT INTO public.municipalities VALUES (217, 'Almeida', NULL, 6, '2026-01-31 18:49:14.805899', '2026-01-31 18:49:14.805899');
INSERT INTO public.municipalities VALUES (218, 'Aquitania', NULL, 6, '2026-01-31 18:49:14.830196', '2026-01-31 18:49:14.830196');
INSERT INTO public.municipalities VALUES (219, 'Arcabuco', NULL, 6, '2026-01-31 18:49:14.835605', '2026-01-31 18:49:14.835605');
INSERT INTO public.municipalities VALUES (220, 'Bel?????n', NULL, 6, '2026-01-31 18:49:14.841371', '2026-01-31 18:49:14.841371');
INSERT INTO public.municipalities VALUES (221, 'Berbeo', NULL, 6, '2026-01-31 18:49:14.845432', '2026-01-31 18:49:14.845432');
INSERT INTO public.municipalities VALUES (222, 'Bet?????itiva', NULL, 6, '2026-01-31 18:49:14.849625', '2026-01-31 18:49:14.849625');
INSERT INTO public.municipalities VALUES (223, 'Boavita', NULL, 6, '2026-01-31 18:49:14.856758', '2026-01-31 18:49:14.856758');
INSERT INTO public.municipalities VALUES (224, 'Boyac?????', NULL, 6, '2026-01-31 18:49:14.860247', '2026-01-31 18:49:14.860247');
INSERT INTO public.municipalities VALUES (225, 'Brice??????o', NULL, 6, '2026-01-31 18:49:14.864408', '2026-01-31 18:49:14.864408');
INSERT INTO public.municipalities VALUES (226, 'Buenavista', NULL, 6, '2026-01-31 18:49:14.870269', '2026-01-31 18:49:14.870269');
INSERT INTO public.municipalities VALUES (227, 'Busbanz?????', NULL, 6, '2026-01-31 18:49:14.874032', '2026-01-31 18:49:14.874032');
INSERT INTO public.municipalities VALUES (228, 'Caldas', NULL, 6, '2026-01-31 18:49:14.877422', '2026-01-31 18:49:14.877422');
INSERT INTO public.municipalities VALUES (229, 'Campohermoso', NULL, 6, '2026-01-31 18:49:14.880647', '2026-01-31 18:49:14.880647');
INSERT INTO public.municipalities VALUES (230, 'Cerinza', NULL, 6, '2026-01-31 18:49:14.884743', '2026-01-31 18:49:14.884743');
INSERT INTO public.municipalities VALUES (231, 'Chinavita', NULL, 6, '2026-01-31 18:49:14.889451', '2026-01-31 18:49:14.889451');
INSERT INTO public.municipalities VALUES (232, 'Chiquinquir?????', NULL, 6, '2026-01-31 18:49:14.893116', '2026-01-31 18:49:14.893116');
INSERT INTO public.municipalities VALUES (233, 'Ch?????quiza', NULL, 6, '2026-01-31 18:49:14.896308', '2026-01-31 18:49:14.896308');
INSERT INTO public.municipalities VALUES (234, 'Chiscas', NULL, 6, '2026-01-31 18:49:14.899509', '2026-01-31 18:49:14.899509');
INSERT INTO public.municipalities VALUES (235, 'Chita', NULL, 6, '2026-01-31 18:49:14.90381', '2026-01-31 18:49:14.90381');
INSERT INTO public.municipalities VALUES (236, 'Chitaraque', NULL, 6, '2026-01-31 18:49:14.907083', '2026-01-31 18:49:14.907083');
INSERT INTO public.municipalities VALUES (237, 'Chivat?????', NULL, 6, '2026-01-31 18:49:14.910588', '2026-01-31 18:49:14.910588');
INSERT INTO public.municipalities VALUES (238, 'Chivor', NULL, 6, '2026-01-31 18:49:14.913882', '2026-01-31 18:49:14.913882');
INSERT INTO public.municipalities VALUES (239, 'Ci?????nega', NULL, 6, '2026-01-31 18:49:14.917922', '2026-01-31 18:49:14.917922');
INSERT INTO public.municipalities VALUES (240, 'C??????mbita', NULL, 6, '2026-01-31 18:49:14.921517', '2026-01-31 18:49:14.921517');
INSERT INTO public.municipalities VALUES (241, 'Coper', NULL, 6, '2026-01-31 18:49:14.924706', '2026-01-31 18:49:14.924706');
INSERT INTO public.municipalities VALUES (242, 'Corrales', NULL, 6, '2026-01-31 18:49:14.927898', '2026-01-31 18:49:14.927898');
INSERT INTO public.municipalities VALUES (243, 'Covarach?????a', NULL, 6, '2026-01-31 18:49:14.931203', '2026-01-31 18:49:14.931203');
INSERT INTO public.municipalities VALUES (244, 'Cubar?????', NULL, 6, '2026-01-31 18:49:14.935321', '2026-01-31 18:49:14.935321');
INSERT INTO public.municipalities VALUES (245, 'Cucaita', NULL, 6, '2026-01-31 18:49:14.940053', '2026-01-31 18:49:14.940053');
INSERT INTO public.municipalities VALUES (246, 'Cu?????tiva', NULL, 6, '2026-01-31 18:49:14.943562', '2026-01-31 18:49:14.943562');
INSERT INTO public.municipalities VALUES (247, 'Duitama', NULL, 6, '2026-01-31 18:49:14.947108', '2026-01-31 18:49:14.947108');
INSERT INTO public.municipalities VALUES (248, 'El Cocuy', NULL, 6, '2026-01-31 18:49:14.951503', '2026-01-31 18:49:14.951503');
INSERT INTO public.municipalities VALUES (249, 'El Espino', NULL, 6, '2026-01-31 18:49:14.955908', '2026-01-31 18:49:14.955908');
INSERT INTO public.municipalities VALUES (250, 'Firavitoba', NULL, 6, '2026-01-31 18:49:14.959855', '2026-01-31 18:49:14.959855');
INSERT INTO public.municipalities VALUES (251, 'Floresta', NULL, 6, '2026-01-31 18:49:14.963188', '2026-01-31 18:49:14.963188');
INSERT INTO public.municipalities VALUES (252, 'Gachantiv?????', NULL, 6, '2026-01-31 18:49:14.966479', '2026-01-31 18:49:14.966479');
INSERT INTO public.municipalities VALUES (253, 'G?????meza', NULL, 6, '2026-01-31 18:49:14.970492', '2026-01-31 18:49:14.970492');
INSERT INTO public.municipalities VALUES (172, 'ALTOS DEL ROSARIO', '13030', 5, '2026-01-31 18:45:41.947948', '2026-01-31 18:45:41.947948');
INSERT INTO public.municipalities VALUES (173, 'ARENAL', '13042', 5, '2026-01-31 18:45:41.953699', '2026-01-31 18:45:41.953699');
INSERT INTO public.municipalities VALUES (175, 'ARROYO HONDO', '13062', 5, '2026-01-31 18:45:41.96412', '2026-01-31 18:45:41.96412');
INSERT INTO public.municipalities VALUES (176, 'BARRANCO DE LOBA', '13074', 5, '2026-01-31 18:45:41.968983', '2026-01-31 18:45:41.968983');
INSERT INTO public.municipalities VALUES (177, 'CALAMAR', '13140', 5, '2026-01-31 18:45:41.974294', '2026-01-31 18:45:41.974294');
INSERT INTO public.municipalities VALUES (178, 'CANTAGALLO', '13160', 5, '2026-01-31 18:45:41.978249', '2026-01-31 18:45:41.978249');
INSERT INTO public.municipalities VALUES (179, 'CARTAGENA', '13001', 5, '2026-01-31 18:45:41.982522', '2026-01-31 18:45:41.982522');
INSERT INTO public.municipalities VALUES (180, 'CICUCO', '13188', 5, '2026-01-31 18:45:41.988026', '2026-01-31 18:45:41.988026');
INSERT INTO public.municipalities VALUES (182, 'CORDOBA', '13212', 5, '2026-01-31 18:45:41.996881', '2026-01-31 18:45:41.996881');
INSERT INTO public.municipalities VALUES (183, 'EL CARMEN DE BOLIVAR', '13244', 5, '2026-01-31 18:45:42.000178', '2026-01-31 18:45:42.000178');
INSERT INTO public.municipalities VALUES (184, 'EL GUAMO', '13248', 5, '2026-01-31 18:45:42.003526', '2026-01-31 18:45:42.003526');
INSERT INTO public.municipalities VALUES (185, 'EL PE?????ON', '13268', 5, '2026-01-31 18:45:42.007647', '2026-01-31 18:45:42.007647');
INSERT INTO public.municipalities VALUES (186, 'HATILLO DE LOBA', '13300', 5, '2026-01-31 18:45:42.011505', '2026-01-31 18:45:42.011505');
INSERT INTO public.municipalities VALUES (187, 'MAGANGUE', '13430', 5, '2026-01-31 18:45:42.014895', '2026-01-31 18:45:42.014895');
INSERT INTO public.municipalities VALUES (188, 'MAHATES', '13433', 5, '2026-01-31 18:45:42.018279', '2026-01-31 18:45:42.018279');
INSERT INTO public.municipalities VALUES (189, 'MARGARITA', '13440', 5, '2026-01-31 18:45:42.022305', '2026-01-31 18:45:42.022305');
INSERT INTO public.municipalities VALUES (191, 'MOMPOS', '13468', 5, '2026-01-31 18:45:42.030437', '2026-01-31 18:45:42.030437');
INSERT INTO public.municipalities VALUES (192, 'MONTECRISTO', '13458', 5, '2026-01-31 18:45:42.033783', '2026-01-31 18:45:42.033783');
INSERT INTO public.municipalities VALUES (193, 'MORALES', '13473', 5, '2026-01-31 18:45:42.037217', '2026-01-31 18:45:42.037217');
INSERT INTO public.municipalities VALUES (194, 'NOROSI', '13490', 5, '2026-01-31 18:45:42.041566', '2026-01-31 18:45:42.041566');
INSERT INTO public.municipalities VALUES (195, 'PINILLOS', '13549', 5, '2026-01-31 18:45:42.044793', '2026-01-31 18:45:42.044793');
INSERT INTO public.municipalities VALUES (196, 'REGIDOR', '13580', 5, '2026-01-31 18:45:42.04802', '2026-01-31 18:45:42.04802');
INSERT INTO public.municipalities VALUES (198, 'SAN CRISTOBAL', '13620', 5, '2026-01-31 18:45:42.054666', '2026-01-31 18:45:42.054666');
INSERT INTO public.municipalities VALUES (199, 'SAN ESTANISLAO', '13647', 5, '2026-01-31 18:45:42.059227', '2026-01-31 18:45:42.059227');
INSERT INTO public.municipalities VALUES (200, 'SAN FERNANDO', '13650', 5, '2026-01-31 18:45:42.062586', '2026-01-31 18:45:42.062586');
INSERT INTO public.municipalities VALUES (201, 'SAN JACINTO', '13654', 5, '2026-01-31 18:45:42.065775', '2026-01-31 18:45:42.065775');
INSERT INTO public.municipalities VALUES (203, 'SAN JUAN NEPOMUCENO', '13657', 5, '2026-01-31 18:45:42.073414', '2026-01-31 18:45:42.073414');
INSERT INTO public.municipalities VALUES (204, 'SAN MARTIN DE LOBA', '13667', 5, '2026-01-31 18:45:42.078077', '2026-01-31 18:45:42.078077');
INSERT INTO public.municipalities VALUES (205, 'SAN PABLO', '13670', 5, '2026-01-31 18:45:42.081269', '2026-01-31 18:45:42.081269');
INSERT INTO public.municipalities VALUES (206, 'SANTA CATALINA', '13673', 5, '2026-01-31 18:45:42.084482', '2026-01-31 18:45:42.084482');
INSERT INTO public.municipalities VALUES (207, 'SANTA ROSA', '13683', 5, '2026-01-31 18:45:42.087663', '2026-01-31 18:45:42.087663');
INSERT INTO public.municipalities VALUES (208, 'SANTA ROSA DEL SUR', '13688', 5, '2026-01-31 18:45:42.092103', '2026-01-31 18:45:42.092103');
INSERT INTO public.municipalities VALUES (209, 'SIMITI', '13744', 5, '2026-01-31 18:45:42.095373', '2026-01-31 18:45:42.095373');
INSERT INTO public.municipalities VALUES (210, 'SOPLAVIENTO', '13760', 5, '2026-01-31 18:45:42.098766', '2026-01-31 18:45:42.098766');
INSERT INTO public.municipalities VALUES (212, 'TIQUISIO (PTO. RICO)', '13810', 5, '2026-01-31 18:45:42.106332', '2026-01-31 18:45:42.106332');
INSERT INTO public.municipalities VALUES (213, 'TURBACO', '13836', 5, '2026-01-31 18:45:42.110031', '2026-01-31 18:45:42.110031');
INSERT INTO public.municipalities VALUES (214, 'TURBANA', '13838', 5, '2026-01-31 18:45:42.113453', '2026-01-31 18:45:42.113453');
INSERT INTO public.municipalities VALUES (215, 'VILLANUEVA', '13873', 5, '2026-01-31 18:45:42.116738', '2026-01-31 18:45:42.116738');
INSERT INTO public.municipalities VALUES (216, 'ZAMBRANO', '13894', 5, '2026-01-31 18:45:42.119921', '2026-01-31 18:45:42.119921');
INSERT INTO public.municipalities VALUES (254, 'Garagoa', NULL, 6, '2026-01-31 18:49:14.97374', '2026-01-31 18:49:14.97374');
INSERT INTO public.municipalities VALUES (255, 'Guacamayas', NULL, 6, '2026-01-31 18:49:14.976941', '2026-01-31 18:49:14.976941');
INSERT INTO public.municipalities VALUES (256, 'Guateque', NULL, 6, '2026-01-31 18:49:14.98025', '2026-01-31 18:49:14.98025');
INSERT INTO public.municipalities VALUES (257, 'Guayat?????', NULL, 6, '2026-01-31 18:49:14.984296', '2026-01-31 18:49:14.984296');
INSERT INTO public.municipalities VALUES (258, 'G??????ic?????n', NULL, 6, '2026-01-31 18:49:14.989692', '2026-01-31 18:49:14.989692');
INSERT INTO public.municipalities VALUES (259, 'Iza', NULL, 6, '2026-01-31 18:49:14.992871', '2026-01-31 18:49:14.992871');
INSERT INTO public.municipalities VALUES (260, 'Jenesano', NULL, 6, '2026-01-31 18:49:14.996033', '2026-01-31 18:49:14.996033');
INSERT INTO public.municipalities VALUES (261, 'Jeric??????', NULL, 6, '2026-01-31 18:49:14.99917', '2026-01-31 18:49:14.99917');
INSERT INTO public.municipalities VALUES (262, 'Labranzagrande', NULL, 6, '2026-01-31 18:49:15.003684', '2026-01-31 18:49:15.003684');
INSERT INTO public.municipalities VALUES (263, 'La Capilla', NULL, 6, '2026-01-31 18:49:15.007301', '2026-01-31 18:49:15.007301');
INSERT INTO public.municipalities VALUES (264, 'La Uvita', NULL, 6, '2026-01-31 18:49:15.010964', '2026-01-31 18:49:15.010964');
INSERT INTO public.municipalities VALUES (265, 'La Victoria', NULL, 6, '2026-01-31 18:49:15.014411', '2026-01-31 18:49:15.014411');
INSERT INTO public.municipalities VALUES (266, 'Villa de Leyva', NULL, 6, '2026-01-31 18:49:15.018923', '2026-01-31 18:49:15.018923');
INSERT INTO public.municipalities VALUES (267, 'Macanal', NULL, 6, '2026-01-31 18:49:15.022638', '2026-01-31 18:49:15.022638');
INSERT INTO public.municipalities VALUES (268, 'Marip?????', NULL, 6, '2026-01-31 18:49:15.026336', '2026-01-31 18:49:15.026336');
INSERT INTO public.municipalities VALUES (269, 'Miraflores', NULL, 6, '2026-01-31 18:49:15.030078', '2026-01-31 18:49:15.030078');
INSERT INTO public.municipalities VALUES (270, 'Mongua', NULL, 6, '2026-01-31 18:49:15.033395', '2026-01-31 18:49:15.033395');
INSERT INTO public.municipalities VALUES (271, 'Mongu?????', NULL, 6, '2026-01-31 18:49:15.038579', '2026-01-31 18:49:15.038579');
INSERT INTO public.municipalities VALUES (272, 'Moniquir?????', NULL, 6, '2026-01-31 18:49:15.041757', '2026-01-31 18:49:15.041757');
INSERT INTO public.municipalities VALUES (273, 'Motavita', NULL, 6, '2026-01-31 18:49:15.044881', '2026-01-31 18:49:15.044881');
INSERT INTO public.municipalities VALUES (274, 'Muzo', NULL, 6, '2026-01-31 18:49:15.048028', '2026-01-31 18:49:15.048028');
INSERT INTO public.municipalities VALUES (275, 'Nobsa', NULL, 6, '2026-01-31 18:49:15.052072', '2026-01-31 18:49:15.052072');
INSERT INTO public.municipalities VALUES (276, 'Nuevo Col??????n', NULL, 6, '2026-01-31 18:49:15.055356', '2026-01-31 18:49:15.055356');
INSERT INTO public.municipalities VALUES (277, 'Oicat?????', NULL, 6, '2026-01-31 18:49:15.058608', '2026-01-31 18:49:15.058608');
INSERT INTO public.municipalities VALUES (278, 'Otanche', NULL, 6, '2026-01-31 18:49:15.062336', '2026-01-31 18:49:15.062336');
INSERT INTO public.municipalities VALUES (279, 'Pachavita', NULL, 6, '2026-01-31 18:49:15.066373', '2026-01-31 18:49:15.066373');
INSERT INTO public.municipalities VALUES (280, 'P?????ez', NULL, 6, '2026-01-31 18:49:15.070563', '2026-01-31 18:49:15.070563');
INSERT INTO public.municipalities VALUES (281, 'Paipa', NULL, 6, '2026-01-31 18:49:15.073725', '2026-01-31 18:49:15.073725');
INSERT INTO public.municipalities VALUES (282, 'Pajarito', NULL, 6, '2026-01-31 18:49:15.076852', '2026-01-31 18:49:15.076852');
INSERT INTO public.municipalities VALUES (283, 'Panqueba', NULL, 6, '2026-01-31 18:49:15.079964', '2026-01-31 18:49:15.079964');
INSERT INTO public.municipalities VALUES (284, 'Pauna', NULL, 6, '2026-01-31 18:49:15.083317', '2026-01-31 18:49:15.083317');
INSERT INTO public.municipalities VALUES (285, 'Paya', NULL, 6, '2026-01-31 18:49:15.088565', '2026-01-31 18:49:15.088565');
INSERT INTO public.municipalities VALUES (286, 'Paz de R?????o', NULL, 6, '2026-01-31 18:49:15.092187', '2026-01-31 18:49:15.092187');
INSERT INTO public.municipalities VALUES (287, 'Pesca', NULL, 6, '2026-01-31 18:49:15.095746', '2026-01-31 18:49:15.095746');
INSERT INTO public.municipalities VALUES (288, 'Pisba', NULL, 6, '2026-01-31 18:49:15.09937', '2026-01-31 18:49:15.09937');
INSERT INTO public.municipalities VALUES (289, 'Puerto Boyac?????', NULL, 6, '2026-01-31 18:49:15.108754', '2026-01-31 18:49:15.108754');
INSERT INTO public.municipalities VALUES (290, 'Qu?????pama', NULL, 6, '2026-01-31 18:49:15.112693', '2026-01-31 18:49:15.112693');
INSERT INTO public.municipalities VALUES (291, 'Ramiriqu?????', NULL, 6, '2026-01-31 18:49:15.11678', '2026-01-31 18:49:15.11678');
INSERT INTO public.municipalities VALUES (292, 'R?????quira', NULL, 6, '2026-01-31 18:49:15.122733', '2026-01-31 18:49:15.122733');
INSERT INTO public.municipalities VALUES (293, 'Rond??????n', NULL, 6, '2026-01-31 18:49:15.126384', '2026-01-31 18:49:15.126384');
INSERT INTO public.municipalities VALUES (294, 'Saboy?????', NULL, 6, '2026-01-31 18:49:15.129762', '2026-01-31 18:49:15.129762');
INSERT INTO public.municipalities VALUES (295, 'S?????chica', NULL, 6, '2026-01-31 18:49:15.135434', '2026-01-31 18:49:15.135434');
INSERT INTO public.municipalities VALUES (296, 'Samac?????', NULL, 6, '2026-01-31 18:49:15.139737', '2026-01-31 18:49:15.139737');
INSERT INTO public.municipalities VALUES (297, 'San Eduardo', NULL, 6, '2026-01-31 18:49:15.142907', '2026-01-31 18:49:15.142907');
INSERT INTO public.municipalities VALUES (298, 'San Jos????? de Pare', NULL, 6, '2026-01-31 18:49:15.146043', '2026-01-31 18:49:15.146043');
INSERT INTO public.municipalities VALUES (299, 'San Luis de Gaceno', NULL, 6, '2026-01-31 18:49:15.149145', '2026-01-31 18:49:15.149145');
INSERT INTO public.municipalities VALUES (300, 'San Mateo', NULL, 6, '2026-01-31 18:49:15.153943', '2026-01-31 18:49:15.153943');
INSERT INTO public.municipalities VALUES (301, 'San Miguel de Sema', NULL, 6, '2026-01-31 18:49:15.157501', '2026-01-31 18:49:15.157501');
INSERT INTO public.municipalities VALUES (302, 'San Pablo de Borbur', NULL, 6, '2026-01-31 18:49:15.160718', '2026-01-31 18:49:15.160718');
INSERT INTO public.municipalities VALUES (303, 'Santana', NULL, 6, '2026-01-31 18:49:15.163857', '2026-01-31 18:49:15.163857');
INSERT INTO public.municipalities VALUES (304, 'Santa Mar?????a', NULL, 6, '2026-01-31 18:49:15.167319', '2026-01-31 18:49:15.167319');
INSERT INTO public.municipalities VALUES (305, 'Santa Rosa de Viterbo', NULL, 6, '2026-01-31 18:49:15.171123', '2026-01-31 18:49:15.171123');
INSERT INTO public.municipalities VALUES (306, 'Santa Sof?????a', NULL, 6, '2026-01-31 18:49:15.174539', '2026-01-31 18:49:15.174539');
INSERT INTO public.municipalities VALUES (307, 'Sativanorte', NULL, 6, '2026-01-31 18:49:15.177682', '2026-01-31 18:49:15.177682');
INSERT INTO public.municipalities VALUES (308, 'Sativasur', NULL, 6, '2026-01-31 18:49:15.180808', '2026-01-31 18:49:15.180808');
INSERT INTO public.municipalities VALUES (309, 'Siachoque', NULL, 6, '2026-01-31 18:49:15.184344', '2026-01-31 18:49:15.184344');
INSERT INTO public.municipalities VALUES (310, 'Soat?????', NULL, 6, '2026-01-31 18:49:15.189104', '2026-01-31 18:49:15.189104');
INSERT INTO public.municipalities VALUES (311, 'Socot?????', NULL, 6, '2026-01-31 18:49:15.192317', '2026-01-31 18:49:15.192317');
INSERT INTO public.municipalities VALUES (312, 'Socha', NULL, 6, '2026-01-31 18:49:15.19552', '2026-01-31 18:49:15.19552');
INSERT INTO public.municipalities VALUES (313, 'Sogamoso', NULL, 6, '2026-01-31 18:49:15.199185', '2026-01-31 18:49:15.199185');
INSERT INTO public.municipalities VALUES (314, 'Somondoco', NULL, 6, '2026-01-31 18:49:15.203318', '2026-01-31 18:49:15.203318');
INSERT INTO public.municipalities VALUES (315, 'Sora', NULL, 6, '2026-01-31 18:49:15.206501', '2026-01-31 18:49:15.206501');
INSERT INTO public.municipalities VALUES (316, 'Sorac?????', NULL, 6, '2026-01-31 18:49:15.209686', '2026-01-31 18:49:15.209686');
INSERT INTO public.municipalities VALUES (317, 'Sotaquir?????', NULL, 6, '2026-01-31 18:49:15.212811', '2026-01-31 18:49:15.212811');
INSERT INTO public.municipalities VALUES (318, 'Susac??????n', NULL, 6, '2026-01-31 18:49:15.216314', '2026-01-31 18:49:15.216314');
INSERT INTO public.municipalities VALUES (319, 'Sutamarch?????n', NULL, 6, '2026-01-31 18:49:15.221048', '2026-01-31 18:49:15.221048');
INSERT INTO public.municipalities VALUES (320, 'Sutatenza', NULL, 6, '2026-01-31 18:49:15.224803', '2026-01-31 18:49:15.224803');
INSERT INTO public.municipalities VALUES (321, 'Tasco', NULL, 6, '2026-01-31 18:49:15.228069', '2026-01-31 18:49:15.228069');
INSERT INTO public.municipalities VALUES (322, 'Tenza', NULL, 6, '2026-01-31 18:49:15.231524', '2026-01-31 18:49:15.231524');
INSERT INTO public.municipalities VALUES (323, 'Tiban?????', NULL, 6, '2026-01-31 18:49:15.236302', '2026-01-31 18:49:15.236302');
INSERT INTO public.municipalities VALUES (324, 'Tibasosa', NULL, 6, '2026-01-31 18:49:15.239628', '2026-01-31 18:49:15.239628');
INSERT INTO public.municipalities VALUES (325, 'Tinjac?????', NULL, 6, '2026-01-31 18:49:15.242881', '2026-01-31 18:49:15.242881');
INSERT INTO public.municipalities VALUES (326, 'Tipacoque', NULL, 6, '2026-01-31 18:49:15.246529', '2026-01-31 18:49:15.246529');
INSERT INTO public.municipalities VALUES (327, 'Toca', NULL, 6, '2026-01-31 18:49:15.250533', '2026-01-31 18:49:15.250533');
INSERT INTO public.municipalities VALUES (328, 'Tog???????????', NULL, 6, '2026-01-31 18:49:15.254693', '2026-01-31 18:49:15.254693');
INSERT INTO public.municipalities VALUES (329, 'T??????paga', NULL, 6, '2026-01-31 18:49:15.258585', '2026-01-31 18:49:15.258585');
INSERT INTO public.municipalities VALUES (330, 'Tota', NULL, 6, '2026-01-31 18:49:15.262251', '2026-01-31 18:49:15.262251');
INSERT INTO public.municipalities VALUES (331, 'Tunja', NULL, 6, '2026-01-31 18:49:15.265594', '2026-01-31 18:49:15.265594');
INSERT INTO public.municipalities VALUES (332, 'Tunungu?????', NULL, 6, '2026-01-31 18:49:15.269687', '2026-01-31 18:49:15.269687');
INSERT INTO public.municipalities VALUES (333, 'Turmequ?????', NULL, 6, '2026-01-31 18:49:15.272822', '2026-01-31 18:49:15.272822');
INSERT INTO public.municipalities VALUES (334, 'Tuta', NULL, 6, '2026-01-31 18:49:15.275951', '2026-01-31 18:49:15.275951');
INSERT INTO public.municipalities VALUES (335, 'Tutaz?????', NULL, 6, '2026-01-31 18:49:15.279074', '2026-01-31 18:49:15.279074');
INSERT INTO public.municipalities VALUES (336, '?????mbita', NULL, 6, '2026-01-31 18:49:15.282333', '2026-01-31 18:49:15.282333');
INSERT INTO public.municipalities VALUES (337, 'Ventaquemada', NULL, 6, '2026-01-31 18:49:15.287218', '2026-01-31 18:49:15.287218');
INSERT INTO public.municipalities VALUES (338, 'Viracach?????', NULL, 6, '2026-01-31 18:49:15.290537', '2026-01-31 18:49:15.290537');
INSERT INTO public.municipalities VALUES (339, 'Zetaquira', NULL, 6, '2026-01-31 18:49:15.293623', '2026-01-31 18:49:15.293623');
INSERT INTO public.municipalities VALUES (340, 'Manizales', NULL, 7, '2026-01-31 18:51:05.271521', '2026-01-31 18:51:05.271521');
INSERT INTO public.municipalities VALUES (341, 'Aguadas', NULL, 7, '2026-01-31 18:51:05.299833', '2026-01-31 18:51:05.299833');
INSERT INTO public.municipalities VALUES (342, 'Anserma', NULL, 7, '2026-01-31 18:51:05.304374', '2026-01-31 18:51:05.304374');
INSERT INTO public.municipalities VALUES (343, 'Aranzazu', NULL, 7, '2026-01-31 18:51:05.308933', '2026-01-31 18:51:05.308933');
INSERT INTO public.municipalities VALUES (344, 'Belalc?????zar', NULL, 7, '2026-01-31 18:51:05.315838', '2026-01-31 18:51:05.315838');
INSERT INTO public.municipalities VALUES (345, 'Chinchin?????', NULL, 7, '2026-01-31 18:51:05.320761', '2026-01-31 18:51:05.320761');
INSERT INTO public.municipalities VALUES (346, 'Filadelfia', NULL, 7, '2026-01-31 18:51:05.324425', '2026-01-31 18:51:05.324425');
INSERT INTO public.municipalities VALUES (347, 'La Dorada', NULL, 7, '2026-01-31 18:51:05.328661', '2026-01-31 18:51:05.328661');
INSERT INTO public.municipalities VALUES (348, 'La Merced', NULL, 7, '2026-01-31 18:51:05.333339', '2026-01-31 18:51:05.333339');
INSERT INTO public.municipalities VALUES (349, 'Manzanares', NULL, 7, '2026-01-31 18:51:05.338791', '2026-01-31 18:51:05.338791');
INSERT INTO public.municipalities VALUES (350, 'Marmato', NULL, 7, '2026-01-31 18:51:05.343047', '2026-01-31 18:51:05.343047');
INSERT INTO public.municipalities VALUES (351, 'Marquetalia', NULL, 7, '2026-01-31 18:51:05.349349', '2026-01-31 18:51:05.349349');
INSERT INTO public.municipalities VALUES (352, 'Marulanda', NULL, 7, '2026-01-31 18:51:05.352607', '2026-01-31 18:51:05.352607');
INSERT INTO public.municipalities VALUES (353, 'Neira', NULL, 7, '2026-01-31 18:51:05.356073', '2026-01-31 18:51:05.356073');
INSERT INTO public.municipalities VALUES (354, 'Norcasia', NULL, 7, '2026-01-31 18:51:05.359504', '2026-01-31 18:51:05.359504');
INSERT INTO public.municipalities VALUES (355, 'P?????cora', NULL, 7, '2026-01-31 18:51:05.363962', '2026-01-31 18:51:05.363962');
INSERT INTO public.municipalities VALUES (356, 'Palestina', NULL, 7, '2026-01-31 18:51:05.36722', '2026-01-31 18:51:05.36722');
INSERT INTO public.municipalities VALUES (357, 'Pensilvania', NULL, 7, '2026-01-31 18:51:05.370472', '2026-01-31 18:51:05.370472');
INSERT INTO public.municipalities VALUES (358, 'Riosucio', NULL, 7, '2026-01-31 18:51:05.37365', '2026-01-31 18:51:05.37365');
INSERT INTO public.municipalities VALUES (359, 'Risaralda', NULL, 7, '2026-01-31 18:51:05.376827', '2026-01-31 18:51:05.376827');
INSERT INTO public.municipalities VALUES (360, 'Salamina', NULL, 7, '2026-01-31 18:51:05.380943', '2026-01-31 18:51:05.380943');
INSERT INTO public.municipalities VALUES (361, 'Saman?????', NULL, 7, '2026-01-31 18:51:05.384245', '2026-01-31 18:51:05.384245');
INSERT INTO public.municipalities VALUES (362, 'San Jos?????', NULL, 7, '2026-01-31 18:51:05.387416', '2026-01-31 18:51:05.387416');
INSERT INTO public.municipalities VALUES (363, 'Sup?????a', NULL, 7, '2026-01-31 18:51:05.390597', '2026-01-31 18:51:05.390597');
INSERT INTO public.municipalities VALUES (364, 'Victoria', NULL, 7, '2026-01-31 18:51:05.393759', '2026-01-31 18:51:05.393759');
INSERT INTO public.municipalities VALUES (365, 'Villamar?????a', NULL, 7, '2026-01-31 18:51:05.398635', '2026-01-31 18:51:05.398635');
INSERT INTO public.municipalities VALUES (366, 'Viterbo', NULL, 7, '2026-01-31 18:51:05.401881', '2026-01-31 18:51:05.401881');
INSERT INTO public.municipalities VALUES (367, 'Florencia', NULL, 8, '2026-01-31 18:52:30.342294', '2026-01-31 18:52:30.342294');
INSERT INTO public.municipalities VALUES (368, 'Albania', NULL, 8, '2026-01-31 18:52:30.373629', '2026-01-31 18:52:30.373629');
INSERT INTO public.municipalities VALUES (369, 'Cartagena del Chair?????', NULL, 8, '2026-01-31 18:52:30.378743', '2026-01-31 18:52:30.378743');
INSERT INTO public.municipalities VALUES (370, 'Bel?????n de los Andaqu?????es', NULL, 8, '2026-01-31 18:52:30.384815', '2026-01-31 18:52:30.384815');
INSERT INTO public.municipalities VALUES (371, 'El Doncello', NULL, 8, '2026-01-31 18:52:30.388876', '2026-01-31 18:52:30.388876');
INSERT INTO public.municipalities VALUES (372, 'El Paujil', NULL, 8, '2026-01-31 18:52:30.392905', '2026-01-31 18:52:30.392905');
INSERT INTO public.municipalities VALUES (373, 'La Monta??????ita', NULL, 8, '2026-01-31 18:52:30.397934', '2026-01-31 18:52:30.397934');
INSERT INTO public.municipalities VALUES (374, 'Puerto Rico', NULL, 8, '2026-01-31 18:52:30.402366', '2026-01-31 18:52:30.402366');
INSERT INTO public.municipalities VALUES (375, 'San Vicente del Cagu?????n', NULL, 8, '2026-01-31 18:52:30.407009', '2026-01-31 18:52:30.407009');
INSERT INTO public.municipalities VALUES (376, 'Curillo', NULL, 8, '2026-01-31 18:52:30.41186', '2026-01-31 18:52:30.41186');
INSERT INTO public.municipalities VALUES (377, 'Mil?????n', NULL, 8, '2026-01-31 18:52:30.416981', '2026-01-31 18:52:30.416981');
INSERT INTO public.municipalities VALUES (378, 'Morelia', NULL, 8, '2026-01-31 18:52:30.420336', '2026-01-31 18:52:30.420336');
INSERT INTO public.municipalities VALUES (379, 'San Jos????? del Fragua', NULL, 8, '2026-01-31 18:52:30.423635', '2026-01-31 18:52:30.423635');
INSERT INTO public.municipalities VALUES (380, 'Solano', NULL, 8, '2026-01-31 18:52:30.427135', '2026-01-31 18:52:30.427135');
INSERT INTO public.municipalities VALUES (381, 'Solita', NULL, 8, '2026-01-31 18:52:30.43276', '2026-01-31 18:52:30.43276');
INSERT INTO public.municipalities VALUES (382, 'Valpara?????so', NULL, 8, '2026-01-31 18:52:30.436708', '2026-01-31 18:52:30.436708');
INSERT INTO public.municipalities VALUES (383, 'Yopal', NULL, 9, '2026-01-31 18:53:03.376782', '2026-01-31 18:53:03.376782');
INSERT INTO public.municipalities VALUES (384, 'Aguazul', NULL, 9, '2026-01-31 18:53:03.402394', '2026-01-31 18:53:03.402394');
INSERT INTO public.municipalities VALUES (385, 'Ch?????meza', NULL, 9, '2026-01-31 18:53:03.407307', '2026-01-31 18:53:03.407307');
INSERT INTO public.municipalities VALUES (386, 'Hato Corozal', NULL, 9, '2026-01-31 18:53:03.412072', '2026-01-31 18:53:03.412072');
INSERT INTO public.municipalities VALUES (387, 'La Salina', NULL, 9, '2026-01-31 18:53:03.417929', '2026-01-31 18:53:03.417929');
INSERT INTO public.municipalities VALUES (388, 'Man?????', NULL, 9, '2026-01-31 18:53:03.422317', '2026-01-31 18:53:03.422317');
INSERT INTO public.municipalities VALUES (389, 'Monterrey', NULL, 9, '2026-01-31 18:53:03.42597', '2026-01-31 18:53:03.42597');
INSERT INTO public.municipalities VALUES (390, 'Nunch?????a', NULL, 9, '2026-01-31 18:53:03.429307', '2026-01-31 18:53:03.429307');
INSERT INTO public.municipalities VALUES (391, 'Orocu?????', NULL, 9, '2026-01-31 18:53:03.434421', '2026-01-31 18:53:03.434421');
INSERT INTO public.municipalities VALUES (392, 'Paz de Ariporo', NULL, 9, '2026-01-31 18:53:03.439396', '2026-01-31 18:53:03.439396');
INSERT INTO public.municipalities VALUES (393, 'Pore', NULL, 9, '2026-01-31 18:53:03.443178', '2026-01-31 18:53:03.443178');
INSERT INTO public.municipalities VALUES (394, 'Recetor', NULL, 9, '2026-01-31 18:53:03.446376', '2026-01-31 18:53:03.446376');
INSERT INTO public.municipalities VALUES (395, 'Sabanalarga', NULL, 9, '2026-01-31 18:53:03.451378', '2026-01-31 18:53:03.451378');
INSERT INTO public.municipalities VALUES (396, 'S?????cama', NULL, 9, '2026-01-31 18:53:03.456131', '2026-01-31 18:53:03.456131');
INSERT INTO public.municipalities VALUES (397, 'San Luis de Palenque', NULL, 9, '2026-01-31 18:53:03.459378', '2026-01-31 18:53:03.459378');
INSERT INTO public.municipalities VALUES (398, 'T?????mara', NULL, 9, '2026-01-31 18:53:03.462532', '2026-01-31 18:53:03.462532');
INSERT INTO public.municipalities VALUES (399, 'Tauramena', NULL, 9, '2026-01-31 18:53:03.467469', '2026-01-31 18:53:03.467469');
INSERT INTO public.municipalities VALUES (400, 'Trinidad', NULL, 9, '2026-01-31 18:53:03.471023', '2026-01-31 18:53:03.471023');
INSERT INTO public.municipalities VALUES (401, 'Villanueva', NULL, 9, '2026-01-31 18:53:03.474414', '2026-01-31 18:53:03.474414');
INSERT INTO public.municipalities VALUES (402, 'Popay?????n', NULL, 10, '2026-01-31 18:54:49.282651', '2026-01-31 18:54:49.282651');
INSERT INTO public.municipalities VALUES (403, 'Almaguer', NULL, 10, '2026-01-31 18:54:49.307413', '2026-01-31 18:54:49.307413');
INSERT INTO public.municipalities VALUES (404, 'Argelia', NULL, 10, '2026-01-31 18:54:49.313056', '2026-01-31 18:54:49.313056');
INSERT INTO public.municipalities VALUES (405, 'Balboa', NULL, 10, '2026-01-31 18:54:49.318166', '2026-01-31 18:54:49.318166');
INSERT INTO public.municipalities VALUES (406, 'Bol?????var', NULL, 10, '2026-01-31 18:54:49.323058', '2026-01-31 18:54:49.323058');
INSERT INTO public.municipalities VALUES (407, 'Buenos Aires', NULL, 10, '2026-01-31 18:54:49.32745', '2026-01-31 18:54:49.32745');
INSERT INTO public.municipalities VALUES (408, 'Cajib?????o', NULL, 10, '2026-01-31 18:54:49.333054', '2026-01-31 18:54:49.333054');
INSERT INTO public.municipalities VALUES (409, 'Caldono', NULL, 10, '2026-01-31 18:54:49.337742', '2026-01-31 18:54:49.337742');
INSERT INTO public.municipalities VALUES (410, 'Caloto', NULL, 10, '2026-01-31 18:54:49.341787', '2026-01-31 18:54:49.341787');
INSERT INTO public.municipalities VALUES (411, 'Corinto', NULL, 10, '2026-01-31 18:54:49.348181', '2026-01-31 18:54:49.348181');
INSERT INTO public.municipalities VALUES (412, 'El Tambo', NULL, 10, '2026-01-31 18:54:49.352863', '2026-01-31 18:54:49.352863');
INSERT INTO public.municipalities VALUES (413, 'Florencia', NULL, 10, '2026-01-31 18:54:49.356537', '2026-01-31 18:54:49.356537');
INSERT INTO public.municipalities VALUES (414, 'Guapi', NULL, 10, '2026-01-31 18:54:49.360281', '2026-01-31 18:54:49.360281');
INSERT INTO public.municipalities VALUES (415, 'Guachen?????', NULL, 10, '2026-01-31 18:54:49.364791', '2026-01-31 18:54:49.364791');
INSERT INTO public.municipalities VALUES (416, 'Inz?????', NULL, 10, '2026-01-31 18:54:49.36834', '2026-01-31 18:54:49.36834');
INSERT INTO public.municipalities VALUES (417, 'Jambal??????', NULL, 10, '2026-01-31 18:54:49.371537', '2026-01-31 18:54:49.371537');
INSERT INTO public.municipalities VALUES (418, 'La Sierra', NULL, 10, '2026-01-31 18:54:49.374737', '2026-01-31 18:54:49.374737');
INSERT INTO public.municipalities VALUES (419, 'La Vega', NULL, 10, '2026-01-31 18:54:49.377879', '2026-01-31 18:54:49.377879');
INSERT INTO public.municipalities VALUES (420, 'L??????pez de Micay', NULL, 10, '2026-01-31 18:54:49.384352', '2026-01-31 18:54:49.384352');
INSERT INTO public.municipalities VALUES (421, 'Mercaderes', NULL, 10, '2026-01-31 18:54:49.387705', '2026-01-31 18:54:49.387705');
INSERT INTO public.municipalities VALUES (422, 'Miranda', NULL, 10, '2026-01-31 18:54:49.391018', '2026-01-31 18:54:49.391018');
INSERT INTO public.municipalities VALUES (423, 'Morales', NULL, 10, '2026-01-31 18:54:49.394471', '2026-01-31 18:54:49.394471');
INSERT INTO public.municipalities VALUES (424, 'Padilla', NULL, 10, '2026-01-31 18:54:49.39865', '2026-01-31 18:54:49.39865');
INSERT INTO public.municipalities VALUES (425, 'P?????ez (Belalc?????zar)', NULL, 10, '2026-01-31 18:54:49.40225', '2026-01-31 18:54:49.40225');
INSERT INTO public.municipalities VALUES (426, 'Pat?????a (El Bordo)', NULL, 10, '2026-01-31 18:54:49.405771', '2026-01-31 18:54:49.405771');
INSERT INTO public.municipalities VALUES (427, 'Piamonte', NULL, 10, '2026-01-31 18:54:49.409368', '2026-01-31 18:54:49.409368');
INSERT INTO public.municipalities VALUES (428, 'Piendam??????', NULL, 10, '2026-01-31 18:54:49.413207', '2026-01-31 18:54:49.413207');
INSERT INTO public.municipalities VALUES (429, 'Puerto Tejada', NULL, 10, '2026-01-31 18:54:49.416596', '2026-01-31 18:54:49.416596');
INSERT INTO public.municipalities VALUES (430, 'Purac????? (Coconuco)', NULL, 10, '2026-01-31 18:54:49.419787', '2026-01-31 18:54:49.419787');
INSERT INTO public.municipalities VALUES (431, 'Rosas', NULL, 10, '2026-01-31 18:54:49.422949', '2026-01-31 18:54:49.422949');
INSERT INTO public.municipalities VALUES (432, 'San Sebasti?????n', NULL, 10, '2026-01-31 18:54:49.426049', '2026-01-31 18:54:49.426049');
INSERT INTO public.municipalities VALUES (433, 'Santander de Quilichao', NULL, 10, '2026-01-31 18:54:49.430936', '2026-01-31 18:54:49.430936');
INSERT INTO public.municipalities VALUES (434, 'Santa Rosa', NULL, 10, '2026-01-31 18:54:49.434351', '2026-01-31 18:54:49.434351');
INSERT INTO public.municipalities VALUES (435, 'Silvia', NULL, 10, '2026-01-31 18:54:49.437438', '2026-01-31 18:54:49.437438');
INSERT INTO public.municipalities VALUES (436, 'Sotar????? (Paispamba)', NULL, 10, '2026-01-31 18:54:49.440502', '2026-01-31 18:54:49.440502');
INSERT INTO public.municipalities VALUES (437, 'Sucre', NULL, 10, '2026-01-31 18:54:49.44357', '2026-01-31 18:54:49.44357');
INSERT INTO public.municipalities VALUES (438, 'Su?????rez', NULL, 10, '2026-01-31 18:54:49.447826', '2026-01-31 18:54:49.447826');
INSERT INTO public.municipalities VALUES (439, 'Timb?????o', NULL, 10, '2026-01-31 18:54:49.451227', '2026-01-31 18:54:49.451227');
INSERT INTO public.municipalities VALUES (440, 'Timbiqu?????', NULL, 10, '2026-01-31 18:54:49.454713', '2026-01-31 18:54:49.454713');
INSERT INTO public.municipalities VALUES (441, 'Torib?????o', NULL, 10, '2026-01-31 18:54:49.457852', '2026-01-31 18:54:49.457852');
INSERT INTO public.municipalities VALUES (442, 'Totor??????', NULL, 10, '2026-01-31 18:54:49.461318', '2026-01-31 18:54:49.461318');
INSERT INTO public.municipalities VALUES (443, 'Villa Rica', NULL, 10, '2026-01-31 18:54:49.465364', '2026-01-31 18:54:49.465364');
INSERT INTO public.municipalities VALUES (444, 'Valledupar', NULL, 11, '2026-01-31 18:56:15.180835', '2026-01-31 18:56:15.180835');
INSERT INTO public.municipalities VALUES (445, 'Aguachica', NULL, 11, '2026-01-31 18:56:15.206063', '2026-01-31 18:56:15.206063');
INSERT INTO public.municipalities VALUES (446, 'Agust?????n Codazzi', NULL, 11, '2026-01-31 18:56:15.210905', '2026-01-31 18:56:15.210905');
INSERT INTO public.municipalities VALUES (447, 'Astrea', NULL, 11, '2026-01-31 18:56:15.216982', '2026-01-31 18:56:15.216982');
INSERT INTO public.municipalities VALUES (448, 'Becerril', NULL, 11, '2026-01-31 18:56:15.221378', '2026-01-31 18:56:15.221378');
INSERT INTO public.municipalities VALUES (449, 'Bosconia', NULL, 11, '2026-01-31 18:56:15.225649', '2026-01-31 18:56:15.225649');
INSERT INTO public.municipalities VALUES (450, 'Curuman?????', NULL, 11, '2026-01-31 18:56:15.23001', '2026-01-31 18:56:15.23001');
INSERT INTO public.municipalities VALUES (451, 'Chimichagua', NULL, 11, '2026-01-31 18:56:15.234178', '2026-01-31 18:56:15.234178');
INSERT INTO public.municipalities VALUES (452, 'Chiriguan?????', NULL, 11, '2026-01-31 18:56:15.238608', '2026-01-31 18:56:15.238608');
INSERT INTO public.municipalities VALUES (453, 'El Copey', NULL, 11, '2026-01-31 18:56:15.243682', '2026-01-31 18:56:15.243682');
INSERT INTO public.municipalities VALUES (454, 'El Paso', NULL, 11, '2026-01-31 18:56:15.248516', '2026-01-31 18:56:15.248516');
INSERT INTO public.municipalities VALUES (455, 'Gamarra', NULL, 11, '2026-01-31 18:56:15.253902', '2026-01-31 18:56:15.253902');
INSERT INTO public.municipalities VALUES (456, 'Gonz?????lez', NULL, 11, '2026-01-31 18:56:15.25735', '2026-01-31 18:56:15.25735');
INSERT INTO public.municipalities VALUES (457, 'La Gloria', NULL, 11, '2026-01-31 18:56:15.260586', '2026-01-31 18:56:15.260586');
INSERT INTO public.municipalities VALUES (458, 'La Jagua de Ibirico', NULL, 11, '2026-01-31 18:56:15.26495', '2026-01-31 18:56:15.26495');
INSERT INTO public.municipalities VALUES (459, 'Manaure Balc??????n del Cesar', NULL, 11, '2026-01-31 18:56:15.268426', '2026-01-31 18:56:15.268426');
INSERT INTO public.municipalities VALUES (460, 'Pailitas', NULL, 11, '2026-01-31 18:56:15.271864', '2026-01-31 18:56:15.271864');
INSERT INTO public.municipalities VALUES (461, 'Pelaya', NULL, 11, '2026-01-31 18:56:15.275375', '2026-01-31 18:56:15.275375');
INSERT INTO public.municipalities VALUES (462, 'Pueblo Bello', NULL, 11, '2026-01-31 18:56:15.280098', '2026-01-31 18:56:15.280098');
INSERT INTO public.municipalities VALUES (463, 'R?????o de Oro', NULL, 11, '2026-01-31 18:56:15.284478', '2026-01-31 18:56:15.284478');
INSERT INTO public.municipalities VALUES (464, 'San Alberto', NULL, 11, '2026-01-31 18:56:15.287909', '2026-01-31 18:56:15.287909');
INSERT INTO public.municipalities VALUES (465, 'La Paz', NULL, 11, '2026-01-31 18:56:15.29203', '2026-01-31 18:56:15.29203');
INSERT INTO public.municipalities VALUES (466, 'San Diego', NULL, 11, '2026-01-31 18:56:15.295548', '2026-01-31 18:56:15.295548');
INSERT INTO public.municipalities VALUES (467, 'San Mart?????n', NULL, 11, '2026-01-31 18:56:15.301112', '2026-01-31 18:56:15.301112');
INSERT INTO public.municipalities VALUES (468, 'Tamalameque', NULL, 11, '2026-01-31 18:56:15.304913', '2026-01-31 18:56:15.304913');
INSERT INTO public.municipalities VALUES (469, 'Quibd??????', NULL, 12, '2026-01-31 18:57:21.929464', '2026-01-31 18:57:21.929464');
INSERT INTO public.municipalities VALUES (470, 'Atrato (Yuto)', NULL, 12, '2026-01-31 18:57:21.956425', '2026-01-31 18:57:21.956425');
INSERT INTO public.municipalities VALUES (471, 'Acand?????', NULL, 12, '2026-01-31 18:57:21.961481', '2026-01-31 18:57:21.961481');
INSERT INTO public.municipalities VALUES (472, 'Alto Baud?????? (Pie de Pat??????)', NULL, 12, '2026-01-31 18:57:21.967549', '2026-01-31 18:57:21.967549');
INSERT INTO public.municipalities VALUES (473, 'Bagad??????', NULL, 12, '2026-01-31 18:57:21.971562', '2026-01-31 18:57:21.971562');
INSERT INTO public.municipalities VALUES (474, 'Bah?????a Solano (Mutis)', NULL, 12, '2026-01-31 18:57:21.975802', '2026-01-31 18:57:21.975802');
INSERT INTO public.municipalities VALUES (475, 'Bajo Baud?????? (Pizarro)', NULL, 12, '2026-01-31 18:57:21.979308', '2026-01-31 18:57:21.979308');
INSERT INTO public.municipalities VALUES (476, 'Bojay????? (Bellavista)', NULL, 12, '2026-01-31 18:57:21.983896', '2026-01-31 18:57:21.983896');
INSERT INTO public.municipalities VALUES (477, 'Medio Atrato (Bet?????)', NULL, 12, '2026-01-31 18:57:21.988216', '2026-01-31 18:57:21.988216');
INSERT INTO public.municipalities VALUES (478, 'Condoto', NULL, 12, '2026-01-31 18:57:21.993133', '2026-01-31 18:57:21.993133');
INSERT INTO public.municipalities VALUES (479, 'C?????rtegui', NULL, 12, '2026-01-31 18:57:21.997768', '2026-01-31 18:57:21.997768');
INSERT INTO public.municipalities VALUES (480, 'Carmen del Dari?????n', NULL, 12, '2026-01-31 18:57:22.00854', '2026-01-31 18:57:22.00854');
INSERT INTO public.municipalities VALUES (481, 'El Carmen de Atrato', NULL, 12, '2026-01-31 18:57:22.014033', '2026-01-31 18:57:22.014033');
INSERT INTO public.municipalities VALUES (482, 'El Cant??????n del San Pablo (Managr??????)', NULL, 12, '2026-01-31 18:57:22.02071', '2026-01-31 18:57:22.02071');
INSERT INTO public.municipalities VALUES (483, 'Istmina', NULL, 12, '2026-01-31 18:57:22.024889', '2026-01-31 18:57:22.024889');
INSERT INTO public.municipalities VALUES (484, 'Jurad??????', NULL, 12, '2026-01-31 18:57:22.02882', '2026-01-31 18:57:22.02882');
INSERT INTO public.municipalities VALUES (485, 'Llor??????', NULL, 12, '2026-01-31 18:57:22.033367', '2026-01-31 18:57:22.033367');
INSERT INTO public.municipalities VALUES (486, 'Medio Baud?????? (Puerto Meluk)', NULL, 12, '2026-01-31 18:57:22.040066', '2026-01-31 18:57:22.040066');
INSERT INTO public.municipalities VALUES (487, 'Medio San Juan', NULL, 12, '2026-01-31 18:57:22.044345', '2026-01-31 18:57:22.044345');
INSERT INTO public.municipalities VALUES (488, 'N??????vita', NULL, 12, '2026-01-31 18:57:22.048535', '2026-01-31 18:57:22.048535');
INSERT INTO public.municipalities VALUES (489, 'Nuqu?????', NULL, 12, '2026-01-31 18:57:22.056649', '2026-01-31 18:57:22.056649');
INSERT INTO public.municipalities VALUES (490, 'R?????o Ir??????', NULL, 12, '2026-01-31 18:57:22.062855', '2026-01-31 18:57:22.062855');
INSERT INTO public.municipalities VALUES (491, 'Riosucio', NULL, 12, '2026-01-31 18:57:22.067701', '2026-01-31 18:57:22.067701');
INSERT INTO public.municipalities VALUES (492, 'R?????o Quito (Paimad??????)', NULL, 12, '2026-01-31 18:57:22.073691', '2026-01-31 18:57:22.073691');
INSERT INTO public.municipalities VALUES (493, 'San Jos????? del Palmar', NULL, 12, '2026-01-31 18:57:22.077607', '2026-01-31 18:57:22.077607');
INSERT INTO public.municipalities VALUES (494, 'El Litoral del San Juan', NULL, 12, '2026-01-31 18:57:22.081654', '2026-01-31 18:57:22.081654');
INSERT INTO public.municipalities VALUES (495, 'Sip?????', NULL, 12, '2026-01-31 18:57:22.085837', '2026-01-31 18:57:22.085837');
INSERT INTO public.municipalities VALUES (496, 'Tad??????', NULL, 12, '2026-01-31 18:57:22.089879', '2026-01-31 18:57:22.089879');
INSERT INTO public.municipalities VALUES (497, 'Ungu?????a', NULL, 12, '2026-01-31 18:57:22.093684', '2026-01-31 18:57:22.093684');
INSERT INTO public.municipalities VALUES (498, 'Uni??????n Panamericana (Las ?????nimas)', NULL, 12, '2026-01-31 18:57:22.097539', '2026-01-31 18:57:22.097539');
INSERT INTO public.municipalities VALUES (499, 'Nuevo Bel?????n de Bajir?????', NULL, 12, '2026-01-31 18:57:22.103145', '2026-01-31 18:57:22.103145');
INSERT INTO public.municipalities VALUES (500, 'Monter?????a', NULL, 13, '2026-01-31 18:58:42.501799', '2026-01-31 18:58:42.501799');
INSERT INTO public.municipalities VALUES (501, 'Ayapel', NULL, 13, '2026-01-31 18:58:42.539683', '2026-01-31 18:58:42.539683');
INSERT INTO public.municipalities VALUES (502, 'Buenavista', NULL, 13, '2026-01-31 18:58:42.545487', '2026-01-31 18:58:42.545487');
INSERT INTO public.municipalities VALUES (503, 'Canalete', NULL, 13, '2026-01-31 18:58:42.549993', '2026-01-31 18:58:42.549993');
INSERT INTO public.municipalities VALUES (504, 'Ceret?????', NULL, 13, '2026-01-31 18:58:42.559365', '2026-01-31 18:58:42.559365');
INSERT INTO public.municipalities VALUES (505, 'Ci?????naga de Oro', NULL, 13, '2026-01-31 18:58:42.564057', '2026-01-31 18:58:42.564057');
INSERT INTO public.municipalities VALUES (506, 'Cotorra (Bongo)', NULL, 13, '2026-01-31 18:58:42.56789', '2026-01-31 18:58:42.56789');
INSERT INTO public.municipalities VALUES (507, 'Chim?????', NULL, 13, '2026-01-31 18:58:42.573103', '2026-01-31 18:58:42.573103');
INSERT INTO public.municipalities VALUES (508, 'Chin??????', NULL, 13, '2026-01-31 18:58:42.578675', '2026-01-31 18:58:42.578675');
INSERT INTO public.municipalities VALUES (509, 'La Apartada (Frontera)', NULL, 13, '2026-01-31 18:58:42.584512', '2026-01-31 18:58:42.584512');
INSERT INTO public.municipalities VALUES (510, 'Lorica', NULL, 13, '2026-01-31 18:58:42.589736', '2026-01-31 18:58:42.589736');
INSERT INTO public.municipalities VALUES (511, 'Los C??????rdobas', NULL, 13, '2026-01-31 18:58:42.593881', '2026-01-31 18:58:42.593881');
INSERT INTO public.municipalities VALUES (512, 'Momil', NULL, 13, '2026-01-31 18:58:42.597276', '2026-01-31 18:58:42.597276');
INSERT INTO public.municipalities VALUES (513, 'Montel?????bano', NULL, 13, '2026-01-31 18:58:42.60081', '2026-01-31 18:58:42.60081');
INSERT INTO public.municipalities VALUES (514, 'Mo??????itos', NULL, 13, '2026-01-31 18:58:42.604757', '2026-01-31 18:58:42.604757');
INSERT INTO public.municipalities VALUES (515, 'Planeta Rica', NULL, 13, '2026-01-31 18:58:42.609427', '2026-01-31 18:58:42.609427');
INSERT INTO public.municipalities VALUES (516, 'Pueblo Nuevo', NULL, 13, '2026-01-31 18:58:42.612613', '2026-01-31 18:58:42.612613');
INSERT INTO public.municipalities VALUES (517, 'Puerto Libertador', NULL, 13, '2026-01-31 18:58:42.61576', '2026-01-31 18:58:42.61576');
INSERT INTO public.municipalities VALUES (518, 'Puerto Escondido', NULL, 13, '2026-01-31 18:58:42.618893', '2026-01-31 18:58:42.618893');
INSERT INTO public.municipalities VALUES (519, 'Pur?????sima', NULL, 13, '2026-01-31 18:58:42.623741', '2026-01-31 18:58:42.623741');
INSERT INTO public.municipalities VALUES (520, 'Sahag??????n', NULL, 13, '2026-01-31 18:58:42.627121', '2026-01-31 18:58:42.627121');
INSERT INTO public.municipalities VALUES (521, 'San Andr?????s de Sotavento', NULL, 13, '2026-01-31 18:58:42.630407', '2026-01-31 18:58:42.630407');
INSERT INTO public.municipalities VALUES (522, 'San Antero', NULL, 13, '2026-01-31 18:58:42.633514', '2026-01-31 18:58:42.633514');
INSERT INTO public.municipalities VALUES (523, 'San Bernardo del Viento', NULL, 13, '2026-01-31 18:58:42.636674', '2026-01-31 18:58:42.636674');
INSERT INTO public.municipalities VALUES (524, 'San Carlos', NULL, 13, '2026-01-31 18:58:42.642125', '2026-01-31 18:58:42.642125');
INSERT INTO public.municipalities VALUES (525, 'San Jos????? de Ur?????', NULL, 13, '2026-01-31 18:58:42.645327', '2026-01-31 18:58:42.645327');
INSERT INTO public.municipalities VALUES (526, 'San Pelayo', NULL, 13, '2026-01-31 18:58:42.648418', '2026-01-31 18:58:42.648418');
INSERT INTO public.municipalities VALUES (527, 'Tierralta', NULL, 13, '2026-01-31 18:58:42.651455', '2026-01-31 18:58:42.651455');
INSERT INTO public.municipalities VALUES (528, 'Tuch?????n', NULL, 13, '2026-01-31 18:58:42.655642', '2026-01-31 18:58:42.655642');
INSERT INTO public.municipalities VALUES (529, 'Valencia', NULL, 13, '2026-01-31 18:58:42.660207', '2026-01-31 18:58:42.660207');
INSERT INTO public.municipalities VALUES (530, 'Agua de Dios', NULL, 14, '2026-01-31 19:00:11.262672', '2026-01-31 19:00:11.262672');
INSERT INTO public.municipalities VALUES (531, 'Alb?????n', NULL, 14, '2026-01-31 19:00:11.291135', '2026-01-31 19:00:11.291135');
INSERT INTO public.municipalities VALUES (532, 'Anapoima', NULL, 14, '2026-01-31 19:00:11.296015', '2026-01-31 19:00:11.296015');
INSERT INTO public.municipalities VALUES (533, 'Anolaima', NULL, 14, '2026-01-31 19:00:11.300429', '2026-01-31 19:00:11.300429');
INSERT INTO public.municipalities VALUES (534, 'Arbel?????ez', NULL, 14, '2026-01-31 19:00:11.306137', '2026-01-31 19:00:11.306137');
INSERT INTO public.municipalities VALUES (535, 'Beltr?????n', NULL, 14, '2026-01-31 19:00:11.31025', '2026-01-31 19:00:11.31025');
INSERT INTO public.municipalities VALUES (536, 'Bituima', NULL, 14, '2026-01-31 19:00:11.314155', '2026-01-31 19:00:11.314155');
INSERT INTO public.municipalities VALUES (537, 'Bojac?????', NULL, 14, '2026-01-31 19:00:11.317498', '2026-01-31 19:00:11.317498');
INSERT INTO public.municipalities VALUES (538, 'Cabrera', NULL, 14, '2026-01-31 19:00:11.323329', '2026-01-31 19:00:11.323329');
INSERT INTO public.municipalities VALUES (539, 'Cachipay', NULL, 14, '2026-01-31 19:00:11.328689', '2026-01-31 19:00:11.328689');
INSERT INTO public.municipalities VALUES (540, 'Cajic?????', NULL, 14, '2026-01-31 19:00:11.332904', '2026-01-31 19:00:11.332904');
INSERT INTO public.municipalities VALUES (541, 'Caparrap?????', NULL, 14, '2026-01-31 19:00:11.341756', '2026-01-31 19:00:11.341756');
INSERT INTO public.municipalities VALUES (542, 'C?????queza', NULL, 14, '2026-01-31 19:00:11.345799', '2026-01-31 19:00:11.345799');
INSERT INTO public.municipalities VALUES (543, 'Carmen de Carupa', NULL, 14, '2026-01-31 19:00:11.350166', '2026-01-31 19:00:11.350166');
INSERT INTO public.municipalities VALUES (544, 'Cogua', NULL, 14, '2026-01-31 19:00:11.355369', '2026-01-31 19:00:11.355369');
INSERT INTO public.municipalities VALUES (545, 'Cota', NULL, 14, '2026-01-31 19:00:11.359097', '2026-01-31 19:00:11.359097');
INSERT INTO public.municipalities VALUES (546, 'Cucunub?????', NULL, 14, '2026-01-31 19:00:11.36288', '2026-01-31 19:00:11.36288');
INSERT INTO public.municipalities VALUES (547, 'Chaguan?????', NULL, 14, '2026-01-31 19:00:11.366073', '2026-01-31 19:00:11.366073');
INSERT INTO public.municipalities VALUES (548, 'Ch?????a', NULL, 14, '2026-01-31 19:00:11.370865', '2026-01-31 19:00:11.370865');
INSERT INTO public.municipalities VALUES (549, 'Chipaque', NULL, 14, '2026-01-31 19:00:11.374736', '2026-01-31 19:00:11.374736');
INSERT INTO public.municipalities VALUES (550, 'Choach?????', NULL, 14, '2026-01-31 19:00:11.38024', '2026-01-31 19:00:11.38024');
INSERT INTO public.municipalities VALUES (551, 'Chocont?????', NULL, 14, '2026-01-31 19:00:11.383789', '2026-01-31 19:00:11.383789');
INSERT INTO public.municipalities VALUES (552, 'El Colegio', NULL, 14, '2026-01-31 19:00:11.389814', '2026-01-31 19:00:11.389814');
INSERT INTO public.municipalities VALUES (553, 'El Pe????????????n', NULL, 14, '2026-01-31 19:00:11.393141', '2026-01-31 19:00:11.393141');
INSERT INTO public.municipalities VALUES (554, 'El Rosal', NULL, 14, '2026-01-31 19:00:11.396824', '2026-01-31 19:00:11.396824');
INSERT INTO public.municipalities VALUES (555, 'Facatativ?????', NULL, 14, '2026-01-31 19:00:11.400265', '2026-01-31 19:00:11.400265');
INSERT INTO public.municipalities VALUES (556, 'F??????meque', NULL, 14, '2026-01-31 19:00:11.405201', '2026-01-31 19:00:11.405201');
INSERT INTO public.municipalities VALUES (557, 'Fosca', NULL, 14, '2026-01-31 19:00:11.408708', '2026-01-31 19:00:11.408708');
INSERT INTO public.municipalities VALUES (558, 'Funza', NULL, 14, '2026-01-31 19:00:11.412286', '2026-01-31 19:00:11.412286');
INSERT INTO public.municipalities VALUES (559, 'F??????quene', NULL, 14, '2026-01-31 19:00:11.415732', '2026-01-31 19:00:11.415732');
INSERT INTO public.municipalities VALUES (560, 'Fusagasug?????', NULL, 14, '2026-01-31 19:00:11.420636', '2026-01-31 19:00:11.420636');
INSERT INTO public.municipalities VALUES (561, 'Gachal?????', NULL, 14, '2026-01-31 19:00:11.424329', '2026-01-31 19:00:11.424329');
INSERT INTO public.municipalities VALUES (562, 'Gachancip?????', NULL, 14, '2026-01-31 19:00:11.427729', '2026-01-31 19:00:11.427729');
INSERT INTO public.municipalities VALUES (563, 'Gachet?????', NULL, 14, '2026-01-31 19:00:11.43157', '2026-01-31 19:00:11.43157');
INSERT INTO public.municipalities VALUES (564, 'Gama', NULL, 14, '2026-01-31 19:00:11.434982', '2026-01-31 19:00:11.434982');
INSERT INTO public.municipalities VALUES (565, 'Girardot', NULL, 14, '2026-01-31 19:00:11.440515', '2026-01-31 19:00:11.440515');
INSERT INTO public.municipalities VALUES (566, 'Guachet?????', NULL, 14, '2026-01-31 19:00:11.444134', '2026-01-31 19:00:11.444134');
INSERT INTO public.municipalities VALUES (567, 'Guaduas', NULL, 14, '2026-01-31 19:00:11.447848', '2026-01-31 19:00:11.447848');
INSERT INTO public.municipalities VALUES (568, 'Guasca', NULL, 14, '2026-01-31 19:00:11.45241', '2026-01-31 19:00:11.45241');
INSERT INTO public.municipalities VALUES (569, 'Guataqu?????', NULL, 14, '2026-01-31 19:00:11.456887', '2026-01-31 19:00:11.456887');
INSERT INTO public.municipalities VALUES (570, 'Guatavita', NULL, 14, '2026-01-31 19:00:11.46092', '2026-01-31 19:00:11.46092');
INSERT INTO public.municipalities VALUES (571, 'Guayabal de S?????quima', NULL, 14, '2026-01-31 19:00:11.464466', '2026-01-31 19:00:11.464466');
INSERT INTO public.municipalities VALUES (572, 'Guayabetal', NULL, 14, '2026-01-31 19:00:11.46908', '2026-01-31 19:00:11.46908');
INSERT INTO public.municipalities VALUES (573, 'Guti?????rrez', NULL, 14, '2026-01-31 19:00:11.475733', '2026-01-31 19:00:11.475733');
INSERT INTO public.municipalities VALUES (574, 'Granada', NULL, 14, '2026-01-31 19:00:11.481422', '2026-01-31 19:00:11.481422');
INSERT INTO public.municipalities VALUES (575, 'Jerusal?????n', NULL, 14, '2026-01-31 19:00:11.490573', '2026-01-31 19:00:11.490573');
INSERT INTO public.municipalities VALUES (576, 'Jun?????n', NULL, 14, '2026-01-31 19:00:11.494827', '2026-01-31 19:00:11.494827');
INSERT INTO public.municipalities VALUES (577, 'La Calera', NULL, 14, '2026-01-31 19:00:11.498306', '2026-01-31 19:00:11.498306');
INSERT INTO public.municipalities VALUES (578, 'La Mesa', NULL, 14, '2026-01-31 19:00:11.503682', '2026-01-31 19:00:11.503682');
INSERT INTO public.municipalities VALUES (579, 'La Palma', NULL, 14, '2026-01-31 19:00:11.508708', '2026-01-31 19:00:11.508708');
INSERT INTO public.municipalities VALUES (580, 'La Pe??????a', NULL, 14, '2026-01-31 19:00:11.511901', '2026-01-31 19:00:11.511901');
INSERT INTO public.municipalities VALUES (581, 'La Vega', NULL, 14, '2026-01-31 19:00:11.515935', '2026-01-31 19:00:11.515935');
INSERT INTO public.municipalities VALUES (582, 'Lenguazaque', NULL, 14, '2026-01-31 19:00:11.519988', '2026-01-31 19:00:11.519988');
INSERT INTO public.municipalities VALUES (583, 'Machet?????', NULL, 14, '2026-01-31 19:00:11.526055', '2026-01-31 19:00:11.526055');
INSERT INTO public.municipalities VALUES (584, 'Madrid', NULL, 14, '2026-01-31 19:00:11.530577', '2026-01-31 19:00:11.530577');
INSERT INTO public.municipalities VALUES (585, 'Manta', NULL, 14, '2026-01-31 19:00:11.534249', '2026-01-31 19:00:11.534249');
INSERT INTO public.municipalities VALUES (586, 'Medina', NULL, 14, '2026-01-31 19:00:11.540687', '2026-01-31 19:00:11.540687');
INSERT INTO public.municipalities VALUES (587, 'Mosquera', NULL, 14, '2026-01-31 19:00:11.5463', '2026-01-31 19:00:11.5463');
INSERT INTO public.municipalities VALUES (588, 'Nari??????o', NULL, 14, '2026-01-31 19:00:11.551869', '2026-01-31 19:00:11.551869');
INSERT INTO public.municipalities VALUES (589, 'Nemoc??????n', NULL, 14, '2026-01-31 19:00:11.556408', '2026-01-31 19:00:11.556408');
INSERT INTO public.municipalities VALUES (590, 'Nilo', NULL, 14, '2026-01-31 19:00:11.565162', '2026-01-31 19:00:11.565162');
INSERT INTO public.municipalities VALUES (591, 'Nimaima', NULL, 14, '2026-01-31 19:00:11.580479', '2026-01-31 19:00:11.580479');
INSERT INTO public.municipalities VALUES (592, 'Nocaima', NULL, 14, '2026-01-31 19:00:11.597612', '2026-01-31 19:00:11.597612');
INSERT INTO public.municipalities VALUES (593, 'Pacho', NULL, 14, '2026-01-31 19:00:11.616674', '2026-01-31 19:00:11.616674');
INSERT INTO public.municipalities VALUES (594, 'Paime', NULL, 14, '2026-01-31 19:00:11.624029', '2026-01-31 19:00:11.624029');
INSERT INTO public.municipalities VALUES (595, 'Pandi', NULL, 14, '2026-01-31 19:00:11.648794', '2026-01-31 19:00:11.648794');
INSERT INTO public.municipalities VALUES (596, 'Paratebueno', NULL, 14, '2026-01-31 19:00:11.662928', '2026-01-31 19:00:11.662928');
INSERT INTO public.municipalities VALUES (597, 'Pasca', NULL, 14, '2026-01-31 19:00:11.667157', '2026-01-31 19:00:11.667157');
INSERT INTO public.municipalities VALUES (598, 'Puerto Salgar', NULL, 14, '2026-01-31 19:00:11.672852', '2026-01-31 19:00:11.672852');
INSERT INTO public.municipalities VALUES (599, 'Pul?????', NULL, 14, '2026-01-31 19:00:11.680863', '2026-01-31 19:00:11.680863');
INSERT INTO public.municipalities VALUES (600, 'Quebradanegra', NULL, 14, '2026-01-31 19:00:11.686377', '2026-01-31 19:00:11.686377');
INSERT INTO public.municipalities VALUES (601, 'Quetame', NULL, 14, '2026-01-31 19:00:11.695987', '2026-01-31 19:00:11.695987');
INSERT INTO public.municipalities VALUES (602, 'Quipile', NULL, 14, '2026-01-31 19:00:11.702462', '2026-01-31 19:00:11.702462');
INSERT INTO public.municipalities VALUES (603, 'Apulo', NULL, 14, '2026-01-31 19:00:11.708174', '2026-01-31 19:00:11.708174');
INSERT INTO public.municipalities VALUES (604, 'Ricaurte', NULL, 14, '2026-01-31 19:00:11.712507', '2026-01-31 19:00:11.712507');
INSERT INTO public.municipalities VALUES (605, 'San Antonio del Tequendama', NULL, 14, '2026-01-31 19:00:11.721155', '2026-01-31 19:00:11.721155');
INSERT INTO public.municipalities VALUES (606, 'San Bernardo', NULL, 14, '2026-01-31 19:00:11.725456', '2026-01-31 19:00:11.725456');
INSERT INTO public.municipalities VALUES (607, 'San Cayetano', NULL, 14, '2026-01-31 19:00:11.734177', '2026-01-31 19:00:11.734177');
INSERT INTO public.municipalities VALUES (608, 'San Francisco', NULL, 14, '2026-01-31 19:00:11.739069', '2026-01-31 19:00:11.739069');
INSERT INTO public.municipalities VALUES (609, 'San Juan de Rioseco', NULL, 14, '2026-01-31 19:00:11.74359', '2026-01-31 19:00:11.74359');
INSERT INTO public.municipalities VALUES (610, 'Sasaima', NULL, 14, '2026-01-31 19:00:11.749793', '2026-01-31 19:00:11.749793');
INSERT INTO public.municipalities VALUES (611, 'Sesquil?????', NULL, 14, '2026-01-31 19:00:11.758016', '2026-01-31 19:00:11.758016');
INSERT INTO public.municipalities VALUES (612, 'Sibat?????', NULL, 14, '2026-01-31 19:00:11.764577', '2026-01-31 19:00:11.764577');
INSERT INTO public.municipalities VALUES (613, 'Silvania', NULL, 14, '2026-01-31 19:00:11.771876', '2026-01-31 19:00:11.771876');
INSERT INTO public.municipalities VALUES (614, 'Simijaca', NULL, 14, '2026-01-31 19:00:11.776343', '2026-01-31 19:00:11.776343');
INSERT INTO public.municipalities VALUES (615, 'Soacha', NULL, 14, '2026-01-31 19:00:11.78316', '2026-01-31 19:00:11.78316');
INSERT INTO public.municipalities VALUES (616, 'Sop??????', NULL, 14, '2026-01-31 19:00:11.795556', '2026-01-31 19:00:11.795556');
INSERT INTO public.municipalities VALUES (617, 'Subachoque', NULL, 14, '2026-01-31 19:00:11.800471', '2026-01-31 19:00:11.800471');
INSERT INTO public.municipalities VALUES (618, 'Suesca', NULL, 14, '2026-01-31 19:00:11.80989', '2026-01-31 19:00:11.80989');
INSERT INTO public.municipalities VALUES (619, 'Supat?????', NULL, 14, '2026-01-31 19:00:11.822238', '2026-01-31 19:00:11.822238');
INSERT INTO public.municipalities VALUES (620, 'Susa', NULL, 14, '2026-01-31 19:00:11.828283', '2026-01-31 19:00:11.828283');
INSERT INTO public.municipalities VALUES (621, 'Sutatausa', NULL, 14, '2026-01-31 19:00:11.832998', '2026-01-31 19:00:11.832998');
INSERT INTO public.municipalities VALUES (622, 'Tabio', NULL, 14, '2026-01-31 19:00:11.840776', '2026-01-31 19:00:11.840776');
INSERT INTO public.municipalities VALUES (623, 'Tausa', NULL, 14, '2026-01-31 19:00:11.844564', '2026-01-31 19:00:11.844564');
INSERT INTO public.municipalities VALUES (624, 'Tena', NULL, 14, '2026-01-31 19:00:11.847872', '2026-01-31 19:00:11.847872');
INSERT INTO public.municipalities VALUES (625, 'Tenjo', NULL, 14, '2026-01-31 19:00:11.850918', '2026-01-31 19:00:11.850918');
INSERT INTO public.municipalities VALUES (626, 'Tibacuy', NULL, 14, '2026-01-31 19:00:11.857894', '2026-01-31 19:00:11.857894');
INSERT INTO public.municipalities VALUES (627, 'Tibirita', NULL, 14, '2026-01-31 19:00:11.861332', '2026-01-31 19:00:11.861332');
INSERT INTO public.municipalities VALUES (628, 'Tocaima', NULL, 14, '2026-01-31 19:00:11.864417', '2026-01-31 19:00:11.864417');
INSERT INTO public.municipalities VALUES (629, 'Tocancip?????', NULL, 14, '2026-01-31 19:00:11.867436', '2026-01-31 19:00:11.867436');
INSERT INTO public.municipalities VALUES (630, 'Topaip?????', NULL, 14, '2026-01-31 19:00:11.874531', '2026-01-31 19:00:11.874531');
INSERT INTO public.municipalities VALUES (631, 'Ubal?????', NULL, 14, '2026-01-31 19:00:11.879969', '2026-01-31 19:00:11.879969');
INSERT INTO public.municipalities VALUES (632, 'Ubaque', NULL, 14, '2026-01-31 19:00:11.88905', '2026-01-31 19:00:11.88905');
INSERT INTO public.municipalities VALUES (633, 'Ubat?????', NULL, 14, '2026-01-31 19:00:11.894931', '2026-01-31 19:00:11.894931');
INSERT INTO public.municipalities VALUES (634, 'Une', NULL, 14, '2026-01-31 19:00:11.898412', '2026-01-31 19:00:11.898412');
INSERT INTO public.municipalities VALUES (635, '?????tica', NULL, 14, '2026-01-31 19:00:11.903055', '2026-01-31 19:00:11.903055');
INSERT INTO public.municipalities VALUES (636, 'Venecia', NULL, 14, '2026-01-31 19:00:11.909454', '2026-01-31 19:00:11.909454');
INSERT INTO public.municipalities VALUES (637, 'Vergara', NULL, 14, '2026-01-31 19:00:11.913304', '2026-01-31 19:00:11.913304');
INSERT INTO public.municipalities VALUES (638, 'Vian?????', NULL, 14, '2026-01-31 19:00:11.916694', '2026-01-31 19:00:11.916694');
INSERT INTO public.municipalities VALUES (639, 'Villag??????mez', NULL, 14, '2026-01-31 19:00:11.922933', '2026-01-31 19:00:11.922933');
INSERT INTO public.municipalities VALUES (640, 'Villapinz??????n', NULL, 14, '2026-01-31 19:00:11.926871', '2026-01-31 19:00:11.926871');
INSERT INTO public.municipalities VALUES (641, 'Villeta', NULL, 14, '2026-01-31 19:00:11.930603', '2026-01-31 19:00:11.930603');
INSERT INTO public.municipalities VALUES (642, 'Viot?????', NULL, 14, '2026-01-31 19:00:11.934145', '2026-01-31 19:00:11.934145');
INSERT INTO public.municipalities VALUES (643, 'Yacop?????', NULL, 14, '2026-01-31 19:00:11.988721', '2026-01-31 19:00:11.988721');
INSERT INTO public.municipalities VALUES (644, 'Zipac??????n', NULL, 14, '2026-01-31 19:00:11.993003', '2026-01-31 19:00:11.993003');
INSERT INTO public.municipalities VALUES (645, 'Zipaquir?????', NULL, 14, '2026-01-31 19:00:11.996388', '2026-01-31 19:00:11.996388');
INSERT INTO public.municipalities VALUES (646, 'In?????rida', NULL, 15, '2026-01-31 19:01:41.052811', '2026-01-31 19:01:41.052811');
INSERT INTO public.municipalities VALUES (647, 'Barrancominas', NULL, 15, '2026-01-31 19:01:41.078418', '2026-01-31 19:01:41.078418');
INSERT INTO public.municipalities VALUES (648, 'Cacahual', NULL, 15, '2026-01-31 19:01:41.085126', '2026-01-31 19:01:41.085126');
INSERT INTO public.municipalities VALUES (649, 'La Guadalupe', NULL, 15, '2026-01-31 19:01:41.089925', '2026-01-31 19:01:41.089925');
INSERT INTO public.municipalities VALUES (650, 'Morichal (Morichal Nuevo)', NULL, 15, '2026-01-31 19:01:41.095944', '2026-01-31 19:01:41.095944');
INSERT INTO public.municipalities VALUES (651, 'Pana Pana (Campo Alegre)', NULL, 15, '2026-01-31 19:01:41.10099', '2026-01-31 19:01:41.10099');
INSERT INTO public.municipalities VALUES (652, 'Puerto Colombia', NULL, 15, '2026-01-31 19:01:41.105013', '2026-01-31 19:01:41.105013');
INSERT INTO public.municipalities VALUES (653, 'San Felipe', NULL, 15, '2026-01-31 19:01:41.108415', '2026-01-31 19:01:41.108415');
INSERT INTO public.municipalities VALUES (654, 'San Jos????? del Guaviare', NULL, 16, '2026-01-31 19:03:03.951822', '2026-01-31 19:03:03.951822');
INSERT INTO public.municipalities VALUES (655, 'Calamar', NULL, 16, '2026-01-31 19:03:03.980277', '2026-01-31 19:03:03.980277');
INSERT INTO public.municipalities VALUES (656, 'El Retorno', NULL, 16, '2026-01-31 19:03:03.989224', '2026-01-31 19:03:03.989224');
INSERT INTO public.municipalities VALUES (657, 'Miraflores', NULL, 16, '2026-01-31 19:03:03.996985', '2026-01-31 19:03:03.996985');
INSERT INTO public.municipalities VALUES (658, 'Neiva', NULL, 17, '2026-01-31 19:04:05.437204', '2026-01-31 19:04:05.437204');
INSERT INTO public.municipalities VALUES (659, 'Acevedo', NULL, 17, '2026-01-31 19:04:05.463721', '2026-01-31 19:04:05.463721');
INSERT INTO public.municipalities VALUES (660, 'Agrado', NULL, 17, '2026-01-31 19:04:05.469246', '2026-01-31 19:04:05.469246');
INSERT INTO public.municipalities VALUES (661, 'Aipe', NULL, 17, '2026-01-31 19:04:05.474004', '2026-01-31 19:04:05.474004');
INSERT INTO public.municipalities VALUES (662, 'Algeciras', NULL, 17, '2026-01-31 19:04:05.480119', '2026-01-31 19:04:05.480119');
INSERT INTO public.municipalities VALUES (663, 'Altamira', NULL, 17, '2026-01-31 19:04:05.485194', '2026-01-31 19:04:05.485194');
INSERT INTO public.municipalities VALUES (664, 'Baraya', NULL, 17, '2026-01-31 19:04:05.489043', '2026-01-31 19:04:05.489043');
INSERT INTO public.municipalities VALUES (665, 'Campoalegre', NULL, 17, '2026-01-31 19:04:05.493981', '2026-01-31 19:04:05.493981');
INSERT INTO public.municipalities VALUES (666, 'Tesalia (Carnicer?????as)', NULL, 17, '2026-01-31 19:04:05.499094', '2026-01-31 19:04:05.499094');
INSERT INTO public.municipalities VALUES (667, 'Colombia', NULL, 17, '2026-01-31 19:04:05.504916', '2026-01-31 19:04:05.504916');
INSERT INTO public.municipalities VALUES (668, 'El?????as', NULL, 17, '2026-01-31 19:04:05.509085', '2026-01-31 19:04:05.509085');
INSERT INTO public.municipalities VALUES (669, 'Garz??????n', NULL, 17, '2026-01-31 19:04:05.514074', '2026-01-31 19:04:05.514074');
INSERT INTO public.municipalities VALUES (670, 'Gigante', NULL, 17, '2026-01-31 19:04:05.517936', '2026-01-31 19:04:05.517936');
INSERT INTO public.municipalities VALUES (671, 'Guadalupe', NULL, 17, '2026-01-31 19:04:05.521749', '2026-01-31 19:04:05.521749');
INSERT INTO public.municipalities VALUES (672, 'Hobo', NULL, 17, '2026-01-31 19:04:05.526836', '2026-01-31 19:04:05.526836');
INSERT INTO public.municipalities VALUES (673, 'Isnos', NULL, 17, '2026-01-31 19:04:05.532176', '2026-01-31 19:04:05.532176');
INSERT INTO public.municipalities VALUES (674, '?????quira', NULL, 17, '2026-01-31 19:04:05.536001', '2026-01-31 19:04:05.536001');
INSERT INTO public.municipalities VALUES (675, 'La Argentina (Plata Vieja)', NULL, 17, '2026-01-31 19:04:05.539735', '2026-01-31 19:04:05.539735');
INSERT INTO public.municipalities VALUES (676, 'La Plata', NULL, 17, '2026-01-31 19:04:05.544317', '2026-01-31 19:04:05.544317');
INSERT INTO public.municipalities VALUES (677, 'N?????taga', NULL, 17, '2026-01-31 19:04:05.548039', '2026-01-31 19:04:05.548039');
INSERT INTO public.municipalities VALUES (678, 'Oporapa', NULL, 17, '2026-01-31 19:04:05.551972', '2026-01-31 19:04:05.551972');
INSERT INTO public.municipalities VALUES (679, 'Paicol', NULL, 17, '2026-01-31 19:04:05.555865', '2026-01-31 19:04:05.555865');
INSERT INTO public.municipalities VALUES (680, 'Palermo', NULL, 17, '2026-01-31 19:04:05.561873', '2026-01-31 19:04:05.561873');
INSERT INTO public.municipalities VALUES (681, 'Palestina', NULL, 17, '2026-01-31 19:04:05.565642', '2026-01-31 19:04:05.565642');
INSERT INTO public.municipalities VALUES (682, 'Pital', NULL, 17, '2026-01-31 19:04:05.569541', '2026-01-31 19:04:05.569541');
INSERT INTO public.municipalities VALUES (683, 'Pitalito', NULL, 17, '2026-01-31 19:04:05.573488', '2026-01-31 19:04:05.573488');
INSERT INTO public.municipalities VALUES (684, 'Rivera', NULL, 17, '2026-01-31 19:04:05.580626', '2026-01-31 19:04:05.580626');
INSERT INTO public.municipalities VALUES (685, 'Saladoblanco', NULL, 17, '2026-01-31 19:04:05.584518', '2026-01-31 19:04:05.584518');
INSERT INTO public.municipalities VALUES (686, 'San Agust?????n', NULL, 17, '2026-01-31 19:04:05.588026', '2026-01-31 19:04:05.588026');
INSERT INTO public.municipalities VALUES (687, 'Santa Mar?????a', NULL, 17, '2026-01-31 19:04:05.591901', '2026-01-31 19:04:05.591901');
INSERT INTO public.municipalities VALUES (688, 'Suaza', NULL, 17, '2026-01-31 19:04:05.598151', '2026-01-31 19:04:05.598151');
INSERT INTO public.municipalities VALUES (689, 'Tarqui', NULL, 17, '2026-01-31 19:04:05.601838', '2026-01-31 19:04:05.601838');
INSERT INTO public.municipalities VALUES (690, 'Tello', NULL, 17, '2026-01-31 19:04:05.607393', '2026-01-31 19:04:05.607393');
INSERT INTO public.municipalities VALUES (691, 'Teruel', NULL, 17, '2026-01-31 19:04:05.613326', '2026-01-31 19:04:05.613326');
INSERT INTO public.municipalities VALUES (692, 'Timan?????', NULL, 17, '2026-01-31 19:04:05.616885', '2026-01-31 19:04:05.616885');
INSERT INTO public.municipalities VALUES (693, 'Villavieja', NULL, 17, '2026-01-31 19:04:05.620745', '2026-01-31 19:04:05.620745');
INSERT INTO public.municipalities VALUES (694, 'Yaguar?????', NULL, 17, '2026-01-31 19:04:05.624447', '2026-01-31 19:04:05.624447');
INSERT INTO public.municipalities VALUES (695, 'Riohacha', NULL, 18, '2026-01-31 19:05:40.032306', '2026-01-31 19:05:40.032306');
INSERT INTO public.municipalities VALUES (696, 'Albania', NULL, 18, '2026-01-31 19:05:40.060768', '2026-01-31 19:05:40.060768');
INSERT INTO public.municipalities VALUES (697, 'Barrancas', NULL, 18, '2026-01-31 19:05:40.066037', '2026-01-31 19:05:40.066037');
INSERT INTO public.municipalities VALUES (698, 'Dibulla', NULL, 18, '2026-01-31 19:05:40.079268', '2026-01-31 19:05:40.079268');
INSERT INTO public.municipalities VALUES (699, 'El Molino', NULL, 18, '2026-01-31 19:05:40.090244', '2026-01-31 19:05:40.090244');
INSERT INTO public.municipalities VALUES (700, 'Fonseca', NULL, 18, '2026-01-31 19:05:40.095414', '2026-01-31 19:05:40.095414');
INSERT INTO public.municipalities VALUES (701, 'Distracci??????n', NULL, 18, '2026-01-31 19:05:40.101527', '2026-01-31 19:05:40.101527');
INSERT INTO public.municipalities VALUES (702, 'Hatonuevo', NULL, 18, '2026-01-31 19:05:40.109062', '2026-01-31 19:05:40.109062');
INSERT INTO public.municipalities VALUES (703, 'Maicao', NULL, 18, '2026-01-31 19:05:40.115616', '2026-01-31 19:05:40.115616');
INSERT INTO public.municipalities VALUES (704, 'Manaure', NULL, 18, '2026-01-31 19:05:40.128051', '2026-01-31 19:05:40.128051');
INSERT INTO public.municipalities VALUES (705, 'La Jagua del Pilar', NULL, 18, '2026-01-31 19:05:40.13468', '2026-01-31 19:05:40.13468');
INSERT INTO public.municipalities VALUES (706, 'San Juan del Cesar', NULL, 18, '2026-01-31 19:05:40.141703', '2026-01-31 19:05:40.141703');
INSERT INTO public.municipalities VALUES (707, 'Uribia', NULL, 18, '2026-01-31 19:05:40.145298', '2026-01-31 19:05:40.145298');
INSERT INTO public.municipalities VALUES (708, 'Urumita', NULL, 18, '2026-01-31 19:05:40.149695', '2026-01-31 19:05:40.149695');
INSERT INTO public.municipalities VALUES (709, 'Villanueva', NULL, 18, '2026-01-31 19:05:40.15747', '2026-01-31 19:05:40.15747');
INSERT INTO public.municipalities VALUES (710, 'Santa Marta', NULL, 19, '2026-01-31 19:06:39.580735', '2026-01-31 19:06:39.580735');
INSERT INTO public.municipalities VALUES (711, 'Algarrobo', NULL, 19, '2026-01-31 19:06:39.605234', '2026-01-31 19:06:39.605234');
INSERT INTO public.municipalities VALUES (712, 'Aracataca', NULL, 19, '2026-01-31 19:06:39.610203', '2026-01-31 19:06:39.610203');
INSERT INTO public.municipalities VALUES (713, 'Ariguan????? (El Dif?????cil)', NULL, 19, '2026-01-31 19:06:39.616873', '2026-01-31 19:06:39.616873');
INSERT INTO public.municipalities VALUES (714, 'Cerro de San Antonio', NULL, 19, '2026-01-31 19:06:39.621031', '2026-01-31 19:06:39.621031');
INSERT INTO public.municipalities VALUES (715, 'Chivolo', NULL, 19, '2026-01-31 19:06:39.625249', '2026-01-31 19:06:39.625249');
INSERT INTO public.municipalities VALUES (716, 'Ci?????naga', NULL, 19, '2026-01-31 19:06:39.629986', '2026-01-31 19:06:39.629986');
INSERT INTO public.municipalities VALUES (717, 'Concordia', NULL, 19, '2026-01-31 19:06:39.633666', '2026-01-31 19:06:39.633666');
INSERT INTO public.municipalities VALUES (718, 'El Banco', NULL, 19, '2026-01-31 19:06:39.637703', '2026-01-31 19:06:39.637703');
INSERT INTO public.municipalities VALUES (719, 'El Pi????????????n', NULL, 19, '2026-01-31 19:06:39.643782', '2026-01-31 19:06:39.643782');
INSERT INTO public.municipalities VALUES (720, 'El Ret?????n', NULL, 19, '2026-01-31 19:06:39.648687', '2026-01-31 19:06:39.648687');
INSERT INTO public.municipalities VALUES (721, 'Fundaci??????n', NULL, 19, '2026-01-31 19:06:39.652155', '2026-01-31 19:06:39.652155');
INSERT INTO public.municipalities VALUES (722, 'Guamal', NULL, 19, '2026-01-31 19:06:39.655644', '2026-01-31 19:06:39.655644');
INSERT INTO public.municipalities VALUES (723, 'Nueva Granada', NULL, 19, '2026-01-31 19:06:39.661993', '2026-01-31 19:06:39.661993');
INSERT INTO public.municipalities VALUES (724, 'Pedraza', NULL, 19, '2026-01-31 19:06:39.666447', '2026-01-31 19:06:39.666447');
INSERT INTO public.municipalities VALUES (725, 'Piji??????o del Carmen', NULL, 19, '2026-01-31 19:06:39.669848', '2026-01-31 19:06:39.669848');
INSERT INTO public.municipalities VALUES (726, 'Pivijay', NULL, 19, '2026-01-31 19:06:39.67293', '2026-01-31 19:06:39.67293');
INSERT INTO public.municipalities VALUES (727, 'Plato', NULL, 19, '2026-01-31 19:06:39.676348', '2026-01-31 19:06:39.676348');
INSERT INTO public.municipalities VALUES (728, 'Puebloviejo', NULL, 19, '2026-01-31 19:06:39.682353', '2026-01-31 19:06:39.682353');
INSERT INTO public.municipalities VALUES (729, 'Remolino', NULL, 19, '2026-01-31 19:06:39.685983', '2026-01-31 19:06:39.685983');
INSERT INTO public.municipalities VALUES (730, 'Sabanas de San ?????ngel', NULL, 19, '2026-01-31 19:06:39.690237', '2026-01-31 19:06:39.690237');
INSERT INTO public.municipalities VALUES (731, 'Salamina', NULL, 19, '2026-01-31 19:06:39.694043', '2026-01-31 19:06:39.694043');
INSERT INTO public.municipalities VALUES (732, 'San Sebasti?????n de Buenavista', NULL, 19, '2026-01-31 19:06:39.699351', '2026-01-31 19:06:39.699351');
INSERT INTO public.municipalities VALUES (733, 'San Zen??????n', NULL, 19, '2026-01-31 19:06:39.702372', '2026-01-31 19:06:39.702372');
INSERT INTO public.municipalities VALUES (734, 'Santa Ana', NULL, 19, '2026-01-31 19:06:39.705529', '2026-01-31 19:06:39.705529');
INSERT INTO public.municipalities VALUES (735, 'Santa B?????rbara de Pinto', NULL, 19, '2026-01-31 19:06:39.710777', '2026-01-31 19:06:39.710777');
INSERT INTO public.municipalities VALUES (736, 'Sitionuevo', NULL, 19, '2026-01-31 19:06:39.715397', '2026-01-31 19:06:39.715397');
INSERT INTO public.municipalities VALUES (737, 'Tenerife', NULL, 19, '2026-01-31 19:06:39.718534', '2026-01-31 19:06:39.718534');
INSERT INTO public.municipalities VALUES (738, 'Zapay?????n', NULL, 19, '2026-01-31 19:06:39.721546', '2026-01-31 19:06:39.721546');
INSERT INTO public.municipalities VALUES (739, 'Zona Bananera (Sevilla)', NULL, 19, '2026-01-31 19:06:39.724552', '2026-01-31 19:06:39.724552');
INSERT INTO public.municipalities VALUES (740, 'Villavicencio', NULL, 20, '2026-01-31 19:08:47.470822', '2026-01-31 19:08:47.470822');
INSERT INTO public.municipalities VALUES (741, 'Acac?????as', NULL, 20, '2026-01-31 19:08:47.48547', '2026-01-31 19:08:47.48547');
INSERT INTO public.municipalities VALUES (742, 'Barranca de Up?????a', NULL, 20, '2026-01-31 19:08:47.49151', '2026-01-31 19:08:47.49151');
INSERT INTO public.municipalities VALUES (743, 'Cabuyaro', NULL, 20, '2026-01-31 19:08:47.498457', '2026-01-31 19:08:47.498457');
INSERT INTO public.municipalities VALUES (744, 'Castilla La Nueva', NULL, 20, '2026-01-31 19:08:47.502787', '2026-01-31 19:08:47.502787');
INSERT INTO public.municipalities VALUES (745, 'Cubarral', NULL, 20, '2026-01-31 19:08:47.508166', '2026-01-31 19:08:47.508166');
INSERT INTO public.municipalities VALUES (746, 'Cumaral', NULL, 20, '2026-01-31 19:08:47.512614', '2026-01-31 19:08:47.512614');
INSERT INTO public.municipalities VALUES (747, 'El Calvario', NULL, 20, '2026-01-31 19:08:47.516543', '2026-01-31 19:08:47.516543');
INSERT INTO public.municipalities VALUES (748, 'El Castillo', NULL, 20, '2026-01-31 19:08:47.521761', '2026-01-31 19:08:47.521761');
INSERT INTO public.municipalities VALUES (749, 'El Dorado', NULL, 20, '2026-01-31 19:08:47.528746', '2026-01-31 19:08:47.528746');
INSERT INTO public.municipalities VALUES (750, 'Fuente de Oro', NULL, 20, '2026-01-31 19:08:47.532985', '2026-01-31 19:08:47.532985');
INSERT INTO public.municipalities VALUES (751, 'Granada', NULL, 20, '2026-01-31 19:08:47.53659', '2026-01-31 19:08:47.53659');
INSERT INTO public.municipalities VALUES (752, 'Guamal', NULL, 20, '2026-01-31 19:08:47.541229', '2026-01-31 19:08:47.541229');
INSERT INTO public.municipalities VALUES (753, 'La Macarena', NULL, 20, '2026-01-31 19:08:47.544984', '2026-01-31 19:08:47.544984');
INSERT INTO public.municipalities VALUES (754, 'Lejan?????as', NULL, 20, '2026-01-31 19:08:47.54874', '2026-01-31 19:08:47.54874');
INSERT INTO public.municipalities VALUES (755, 'Mapirip?????n', NULL, 20, '2026-01-31 19:08:47.552379', '2026-01-31 19:08:47.552379');
INSERT INTO public.municipalities VALUES (756, 'Mesetas', NULL, 20, '2026-01-31 19:08:47.556743', '2026-01-31 19:08:47.556743');
INSERT INTO public.municipalities VALUES (757, 'Puerto Concordia', NULL, 20, '2026-01-31 19:08:47.563076', '2026-01-31 19:08:47.563076');
INSERT INTO public.municipalities VALUES (758, 'Puerto Gait?????n', NULL, 20, '2026-01-31 19:08:47.566972', '2026-01-31 19:08:47.566972');
INSERT INTO public.municipalities VALUES (759, 'Puerto Lleras', NULL, 20, '2026-01-31 19:08:47.570643', '2026-01-31 19:08:47.570643');
INSERT INTO public.municipalities VALUES (760, 'Puerto L??????pez', NULL, 20, '2026-01-31 19:08:47.576363', '2026-01-31 19:08:47.576363');
INSERT INTO public.municipalities VALUES (761, 'Puerto Rico', NULL, 20, '2026-01-31 19:08:47.580026', '2026-01-31 19:08:47.580026');
INSERT INTO public.municipalities VALUES (762, 'Restrepo', NULL, 20, '2026-01-31 19:08:47.585711', '2026-01-31 19:08:47.585711');
INSERT INTO public.municipalities VALUES (763, 'San Carlos de Guaroa', NULL, 20, '2026-01-31 19:08:47.590105', '2026-01-31 19:08:47.590105');
INSERT INTO public.municipalities VALUES (764, 'San Juan de Arama', NULL, 20, '2026-01-31 19:08:47.593625', '2026-01-31 19:08:47.593625');
INSERT INTO public.municipalities VALUES (765, 'San Juanito', NULL, 20, '2026-01-31 19:08:47.597226', '2026-01-31 19:08:47.597226');
INSERT INTO public.municipalities VALUES (766, 'San Mart?????n de los Llanos', NULL, 20, '2026-01-31 19:08:47.600704', '2026-01-31 19:08:47.600704');
INSERT INTO public.municipalities VALUES (767, 'Uribe', NULL, 20, '2026-01-31 19:08:47.603806', '2026-01-31 19:08:47.603806');
INSERT INTO public.municipalities VALUES (768, 'Vista Hermosa', NULL, 20, '2026-01-31 19:08:47.612395', '2026-01-31 19:08:47.612395');
INSERT INTO public.municipalities VALUES (769, 'Alb?????n (San Jos?????)', NULL, 21, '2026-01-31 19:14:25.140479', '2026-01-31 19:14:25.140479');
INSERT INTO public.municipalities VALUES (770, 'Aldana', NULL, 21, '2026-01-31 19:14:25.171293', '2026-01-31 19:14:25.171293');
INSERT INTO public.municipalities VALUES (771, 'Ancuya', NULL, 21, '2026-01-31 19:14:25.179499', '2026-01-31 19:14:25.179499');
INSERT INTO public.municipalities VALUES (772, 'Arboleda (Berruecos)', NULL, 21, '2026-01-31 19:14:25.185871', '2026-01-31 19:14:25.185871');
INSERT INTO public.municipalities VALUES (773, 'Barbacoas', NULL, 21, '2026-01-31 19:14:25.190141', '2026-01-31 19:14:25.190141');
INSERT INTO public.municipalities VALUES (774, 'Bel?????n', NULL, 21, '2026-01-31 19:14:25.195265', '2026-01-31 19:14:25.195265');
INSERT INTO public.municipalities VALUES (775, 'Buesaco', NULL, 21, '2026-01-31 19:14:25.204049', '2026-01-31 19:14:25.204049');
INSERT INTO public.municipalities VALUES (776, 'Chachagui', NULL, 21, '2026-01-31 19:14:25.208202', '2026-01-31 19:14:25.208202');
INSERT INTO public.municipalities VALUES (777, 'Col??????n (G?????nova)', NULL, 21, '2026-01-31 19:14:25.216635', '2026-01-31 19:14:25.216635');
INSERT INTO public.municipalities VALUES (778, 'Consac?????', NULL, 21, '2026-01-31 19:14:25.225962', '2026-01-31 19:14:25.225962');
INSERT INTO public.municipalities VALUES (779, 'Contadero', NULL, 21, '2026-01-31 19:14:25.231746', '2026-01-31 19:14:25.231746');
INSERT INTO public.municipalities VALUES (780, 'C??????rdoba', NULL, 21, '2026-01-31 19:14:25.236904', '2026-01-31 19:14:25.236904');
INSERT INTO public.municipalities VALUES (781, 'Cuaspud (Carlosama)', NULL, 21, '2026-01-31 19:14:25.240859', '2026-01-31 19:14:25.240859');
INSERT INTO public.municipalities VALUES (782, 'Cumbal', NULL, 21, '2026-01-31 19:14:25.247367', '2026-01-31 19:14:25.247367');
INSERT INTO public.municipalities VALUES (783, 'Cumbitara', NULL, 21, '2026-01-31 19:14:25.25437', '2026-01-31 19:14:25.25437');
INSERT INTO public.municipalities VALUES (784, 'El Charco', NULL, 21, '2026-01-31 19:14:25.258249', '2026-01-31 19:14:25.258249');
INSERT INTO public.municipalities VALUES (785, 'El Pe??????ol', NULL, 21, '2026-01-31 19:14:25.262333', '2026-01-31 19:14:25.262333');
INSERT INTO public.municipalities VALUES (786, 'El Rosario', NULL, 21, '2026-01-31 19:14:25.27238', '2026-01-31 19:14:25.27238');
INSERT INTO public.municipalities VALUES (787, 'El Tabl??????n', NULL, 21, '2026-01-31 19:14:25.276505', '2026-01-31 19:14:25.276505');
INSERT INTO public.municipalities VALUES (788, 'El Tambo', NULL, 21, '2026-01-31 19:14:25.282924', '2026-01-31 19:14:25.282924');
INSERT INTO public.municipalities VALUES (789, 'Francisco Pizarro (Salahonda)', NULL, 21, '2026-01-31 19:14:25.289933', '2026-01-31 19:14:25.289933');
INSERT INTO public.municipalities VALUES (790, 'Funes', NULL, 21, '2026-01-31 19:14:25.293713', '2026-01-31 19:14:25.293713');
INSERT INTO public.municipalities VALUES (791, 'Guachucal', NULL, 21, '2026-01-31 19:14:25.298855', '2026-01-31 19:14:25.298855');
INSERT INTO public.municipalities VALUES (792, 'Guaitarilla', NULL, 21, '2026-01-31 19:14:25.303218', '2026-01-31 19:14:25.303218');
INSERT INTO public.municipalities VALUES (793, 'Gualmatan', NULL, 21, '2026-01-31 19:14:25.307302', '2026-01-31 19:14:25.307302');
INSERT INTO public.municipalities VALUES (794, 'Iles', NULL, 21, '2026-01-31 19:14:25.310897', '2026-01-31 19:14:25.310897');
INSERT INTO public.municipalities VALUES (795, 'Imues', NULL, 21, '2026-01-31 19:14:25.316675', '2026-01-31 19:14:25.316675');
INSERT INTO public.municipalities VALUES (796, 'Ipiales', NULL, 21, '2026-01-31 19:14:25.321895', '2026-01-31 19:14:25.321895');
INSERT INTO public.municipalities VALUES (797, 'La Cruz', NULL, 21, '2026-01-31 19:14:25.325695', '2026-01-31 19:14:25.325695');
INSERT INTO public.municipalities VALUES (798, 'La Florida', NULL, 21, '2026-01-31 19:14:25.340311', '2026-01-31 19:14:25.340311');
INSERT INTO public.municipalities VALUES (799, 'La Llanada', NULL, 21, '2026-01-31 19:14:25.345529', '2026-01-31 19:14:25.345529');
INSERT INTO public.municipalities VALUES (800, 'La Tola', NULL, 21, '2026-01-31 19:14:25.354023', '2026-01-31 19:14:25.354023');
INSERT INTO public.municipalities VALUES (801, 'La Uni??????n', NULL, 21, '2026-01-31 19:14:25.358193', '2026-01-31 19:14:25.358193');
INSERT INTO public.municipalities VALUES (802, 'Leiva', NULL, 21, '2026-01-31 19:14:25.364061', '2026-01-31 19:14:25.364061');
INSERT INTO public.municipalities VALUES (803, 'Linares', NULL, 21, '2026-01-31 19:14:25.368715', '2026-01-31 19:14:25.368715');
INSERT INTO public.municipalities VALUES (804, 'Los Andes (Sotomayor)', NULL, 21, '2026-01-31 19:14:25.374746', '2026-01-31 19:14:25.374746');
INSERT INTO public.municipalities VALUES (805, 'Mag??????i (Pay?????n)', NULL, 21, '2026-01-31 19:14:25.379351', '2026-01-31 19:14:25.379351');
INSERT INTO public.municipalities VALUES (806, 'Mallama (Piedrancha)', NULL, 21, '2026-01-31 19:14:25.398453', '2026-01-31 19:14:25.398453');
INSERT INTO public.municipalities VALUES (807, 'Mosquera', NULL, 21, '2026-01-31 19:14:25.40233', '2026-01-31 19:14:25.40233');
INSERT INTO public.municipalities VALUES (808, 'Nari??????o', NULL, 21, '2026-01-31 19:14:25.407568', '2026-01-31 19:14:25.407568');
INSERT INTO public.municipalities VALUES (809, 'Olaya Herrera', NULL, 21, '2026-01-31 19:14:25.419275', '2026-01-31 19:14:25.419275');
INSERT INTO public.municipalities VALUES (810, 'Ospina', NULL, 21, '2026-01-31 19:14:25.424864', '2026-01-31 19:14:25.424864');
INSERT INTO public.municipalities VALUES (811, 'Pasto', NULL, 21, '2026-01-31 19:14:25.434041', '2026-01-31 19:14:25.434041');
INSERT INTO public.municipalities VALUES (812, 'Policarpa', NULL, 21, '2026-01-31 19:14:25.441092', '2026-01-31 19:14:25.441092');
INSERT INTO public.municipalities VALUES (813, 'Potos?????', NULL, 21, '2026-01-31 19:14:25.447508', '2026-01-31 19:14:25.447508');
INSERT INTO public.municipalities VALUES (814, 'Providencia', NULL, 21, '2026-01-31 19:14:25.456853', '2026-01-31 19:14:25.456853');
INSERT INTO public.municipalities VALUES (815, 'Puerres', NULL, 21, '2026-01-31 19:14:25.461699', '2026-01-31 19:14:25.461699');
INSERT INTO public.municipalities VALUES (816, 'Pupiales', NULL, 21, '2026-01-31 19:14:25.469755', '2026-01-31 19:14:25.469755');
INSERT INTO public.municipalities VALUES (817, 'Ricaurte', NULL, 21, '2026-01-31 19:14:25.475968', '2026-01-31 19:14:25.475968');
INSERT INTO public.municipalities VALUES (818, 'Roberto Pay?????n (San Jos?????)', NULL, 21, '2026-01-31 19:14:25.482096', '2026-01-31 19:14:25.482096');
INSERT INTO public.municipalities VALUES (819, 'Samaniego', NULL, 21, '2026-01-31 19:14:25.487862', '2026-01-31 19:14:25.487862');
INSERT INTO public.municipalities VALUES (820, 'Sandona', NULL, 21, '2026-01-31 19:14:25.491686', '2026-01-31 19:14:25.491686');
INSERT INTO public.municipalities VALUES (821, 'San Bernardo', NULL, 21, '2026-01-31 19:14:25.495437', '2026-01-31 19:14:25.495437');
INSERT INTO public.municipalities VALUES (822, 'San Lorenzo', NULL, 21, '2026-01-31 19:14:25.505276', '2026-01-31 19:14:25.505276');
INSERT INTO public.municipalities VALUES (823, 'San Pablo', NULL, 21, '2026-01-31 19:14:25.508767', '2026-01-31 19:14:25.508767');
INSERT INTO public.municipalities VALUES (824, 'San Pedro de Cartago', NULL, 21, '2026-01-31 19:14:25.516193', '2026-01-31 19:14:25.516193');
INSERT INTO public.municipalities VALUES (825, 'Santa B?????rbara (Iscuand?????)', NULL, 21, '2026-01-31 19:14:25.521483', '2026-01-31 19:14:25.521483');
INSERT INTO public.municipalities VALUES (826, 'Santacruz (Guachav?????s)', NULL, 21, '2026-01-31 19:14:25.524955', '2026-01-31 19:14:25.524955');
INSERT INTO public.municipalities VALUES (827, 'Sapuy?????s', NULL, 21, '2026-01-31 19:14:25.528577', '2026-01-31 19:14:25.528577');
INSERT INTO public.municipalities VALUES (828, 'Taminango', NULL, 21, '2026-01-31 19:14:25.535185', '2026-01-31 19:14:25.535185');
INSERT INTO public.municipalities VALUES (829, 'Tangua', NULL, 21, '2026-01-31 19:14:25.54108', '2026-01-31 19:14:25.54108');
INSERT INTO public.municipalities VALUES (830, 'Tumaco', NULL, 21, '2026-01-31 19:14:25.544674', '2026-01-31 19:14:25.544674');
INSERT INTO public.municipalities VALUES (831, 'Tuquerres', NULL, 21, '2026-01-31 19:14:25.551881', '2026-01-31 19:14:25.551881');
INSERT INTO public.municipalities VALUES (832, 'Yacuanquer', NULL, 21, '2026-01-31 19:14:25.556298', '2026-01-31 19:14:25.556298');
INSERT INTO public.municipalities VALUES (833, 'Abrego', NULL, 22, '2026-01-31 19:15:27.082598', '2026-01-31 19:15:27.082598');
INSERT INTO public.municipalities VALUES (834, 'Arboledas', NULL, 22, '2026-01-31 19:15:27.10864', '2026-01-31 19:15:27.10864');
INSERT INTO public.municipalities VALUES (835, 'Bochalema', NULL, 22, '2026-01-31 19:15:27.113062', '2026-01-31 19:15:27.113062');
INSERT INTO public.municipalities VALUES (836, 'Bucarasica', NULL, 22, '2026-01-31 19:15:27.117136', '2026-01-31 19:15:27.117136');
INSERT INTO public.municipalities VALUES (837, 'C?????cota', NULL, 22, '2026-01-31 19:15:27.122274', '2026-01-31 19:15:27.122274');
INSERT INTO public.municipalities VALUES (838, 'C?????chira', NULL, 22, '2026-01-31 19:15:27.126276', '2026-01-31 19:15:27.126276');
INSERT INTO public.municipalities VALUES (839, 'Chin?????cota', NULL, 22, '2026-01-31 19:15:27.129785', '2026-01-31 19:15:27.129785');
INSERT INTO public.municipalities VALUES (840, 'Chitaga', NULL, 22, '2026-01-31 19:15:27.133116', '2026-01-31 19:15:27.133116');
INSERT INTO public.municipalities VALUES (841, 'Convenci??????n', NULL, 22, '2026-01-31 19:15:27.137901', '2026-01-31 19:15:27.137901');
INSERT INTO public.municipalities VALUES (842, 'C??????cuta', NULL, 22, '2026-01-31 19:15:27.143883', '2026-01-31 19:15:27.143883');
INSERT INTO public.municipalities VALUES (843, 'Cucutilla', NULL, 22, '2026-01-31 19:15:27.147503', '2026-01-31 19:15:27.147503');
INSERT INTO public.municipalities VALUES (844, 'Durania', NULL, 22, '2026-01-31 19:15:27.150694', '2026-01-31 19:15:27.150694');
INSERT INTO public.municipalities VALUES (845, 'El Carmen', NULL, 22, '2026-01-31 19:15:27.154897', '2026-01-31 19:15:27.154897');
INSERT INTO public.municipalities VALUES (846, 'El Tarra', NULL, 22, '2026-01-31 19:15:27.158313', '2026-01-31 19:15:27.158313');
INSERT INTO public.municipalities VALUES (847, 'El Zulia', NULL, 22, '2026-01-31 19:15:27.161454', '2026-01-31 19:15:27.161454');
INSERT INTO public.municipalities VALUES (848, 'Gramalote', NULL, 22, '2026-01-31 19:15:27.164574', '2026-01-31 19:15:27.164574');
INSERT INTO public.municipalities VALUES (849, 'Hacari', NULL, 22, '2026-01-31 19:15:27.167724', '2026-01-31 19:15:27.167724');
INSERT INTO public.municipalities VALUES (850, 'Herran', NULL, 22, '2026-01-31 19:15:27.172477', '2026-01-31 19:15:27.172477');
INSERT INTO public.municipalities VALUES (851, 'Labateca', NULL, 22, '2026-01-31 19:15:27.175783', '2026-01-31 19:15:27.175783');
INSERT INTO public.municipalities VALUES (852, 'La Esperanza', NULL, 22, '2026-01-31 19:15:27.178876', '2026-01-31 19:15:27.178876');
INSERT INTO public.municipalities VALUES (853, 'La Playa', NULL, 22, '2026-01-31 19:15:27.182129', '2026-01-31 19:15:27.182129');
INSERT INTO public.municipalities VALUES (854, 'Los Patios', NULL, 22, '2026-01-31 19:15:27.185237', '2026-01-31 19:15:27.185237');
INSERT INTO public.municipalities VALUES (855, 'Lourdes', NULL, 22, '2026-01-31 19:15:27.190508', '2026-01-31 19:15:27.190508');
INSERT INTO public.municipalities VALUES (856, 'Mutiscua', NULL, 22, '2026-01-31 19:15:27.193716', '2026-01-31 19:15:27.193716');
INSERT INTO public.municipalities VALUES (857, 'Oca??????a', NULL, 22, '2026-01-31 19:15:27.197009', '2026-01-31 19:15:27.197009');
INSERT INTO public.municipalities VALUES (858, 'Pamplona', NULL, 22, '2026-01-31 19:15:27.200127', '2026-01-31 19:15:27.200127');
INSERT INTO public.municipalities VALUES (859, 'Pamplonita', NULL, 22, '2026-01-31 19:15:27.20467', '2026-01-31 19:15:27.20467');
INSERT INTO public.municipalities VALUES (860, 'Puerto Santander', NULL, 22, '2026-01-31 19:15:27.207997', '2026-01-31 19:15:27.207997');
INSERT INTO public.municipalities VALUES (861, 'Ragonvalia', NULL, 22, '2026-01-31 19:15:27.211087', '2026-01-31 19:15:27.211087');
INSERT INTO public.municipalities VALUES (862, 'Salazar', NULL, 22, '2026-01-31 19:15:27.214214', '2026-01-31 19:15:27.214214');
INSERT INTO public.municipalities VALUES (863, 'San Calixto', NULL, 22, '2026-01-31 19:15:27.217358', '2026-01-31 19:15:27.217358');
INSERT INTO public.municipalities VALUES (864, 'San Cayetano', NULL, 22, '2026-01-31 19:15:27.222934', '2026-01-31 19:15:27.222934');
INSERT INTO public.municipalities VALUES (865, 'Santiago', NULL, 22, '2026-01-31 19:15:27.226834', '2026-01-31 19:15:27.226834');
INSERT INTO public.municipalities VALUES (866, 'Sardinata', NULL, 22, '2026-01-31 19:15:27.230377', '2026-01-31 19:15:27.230377');
INSERT INTO public.municipalities VALUES (867, 'Silos', NULL, 22, '2026-01-31 19:15:27.233899', '2026-01-31 19:15:27.233899');
INSERT INTO public.municipalities VALUES (868, 'Teorama', NULL, 22, '2026-01-31 19:15:27.239845', '2026-01-31 19:15:27.239845');
INSERT INTO public.municipalities VALUES (869, 'Tib??????', NULL, 22, '2026-01-31 19:15:27.243704', '2026-01-31 19:15:27.243704');
INSERT INTO public.municipalities VALUES (870, 'Toledo', NULL, 22, '2026-01-31 19:15:27.247355', '2026-01-31 19:15:27.247355');
INSERT INTO public.municipalities VALUES (871, 'Villa Caro', NULL, 22, '2026-01-31 19:15:27.251033', '2026-01-31 19:15:27.251033');
INSERT INTO public.municipalities VALUES (872, 'Villa del Rosario', NULL, 22, '2026-01-31 19:15:27.256023', '2026-01-31 19:15:27.256023');
INSERT INTO public.municipalities VALUES (873, 'Col??????n', NULL, 23, '2026-01-31 20:11:03.709773', '2026-01-31 20:11:03.709773');
INSERT INTO public.municipalities VALUES (874, 'Mocoa', NULL, 23, '2026-01-31 20:11:03.739231', '2026-01-31 20:11:03.739231');
INSERT INTO public.municipalities VALUES (875, 'Orito', NULL, 23, '2026-01-31 20:11:03.744059', '2026-01-31 20:11:03.744059');
INSERT INTO public.municipalities VALUES (876, 'Puerto As?????s', NULL, 23, '2026-01-31 20:11:03.750059', '2026-01-31 20:11:03.750059');
INSERT INTO public.municipalities VALUES (877, 'Puerto Caicedo', NULL, 23, '2026-01-31 20:11:03.75473', '2026-01-31 20:11:03.75473');
INSERT INTO public.municipalities VALUES (878, 'Puerto Guzm?????n', NULL, 23, '2026-01-31 20:11:03.758549', '2026-01-31 20:11:03.758549');
INSERT INTO public.municipalities VALUES (879, 'Puerto Leguizamo', NULL, 23, '2026-01-31 20:11:03.762252', '2026-01-31 20:11:03.762252');
INSERT INTO public.municipalities VALUES (880, 'San Francisco', NULL, 23, '2026-01-31 20:11:03.769629', '2026-01-31 20:11:03.769629');
INSERT INTO public.municipalities VALUES (881, 'San Miguel (La Dorada)', NULL, 23, '2026-01-31 20:11:03.774043', '2026-01-31 20:11:03.774043');
INSERT INTO public.municipalities VALUES (882, 'Santiago', NULL, 23, '2026-01-31 20:11:03.779005', '2026-01-31 20:11:03.779005');
INSERT INTO public.municipalities VALUES (883, 'Sibundoy', NULL, 23, '2026-01-31 20:11:03.786093', '2026-01-31 20:11:03.786093');
INSERT INTO public.municipalities VALUES (884, 'Valle del Guamuez (La Hormiga)', NULL, 23, '2026-01-31 20:11:03.793742', '2026-01-31 20:11:03.793742');
INSERT INTO public.municipalities VALUES (885, 'Villagarz??????n', NULL, 23, '2026-01-31 20:11:03.798373', '2026-01-31 20:11:03.798373');
INSERT INTO public.municipalities VALUES (886, 'Armenia', NULL, 24, '2026-01-31 20:11:37.374844', '2026-01-31 20:11:37.374844');
INSERT INTO public.municipalities VALUES (887, 'Buenavista', NULL, 24, '2026-01-31 20:11:37.400069', '2026-01-31 20:11:37.400069');
INSERT INTO public.municipalities VALUES (888, 'Calarc?????', NULL, 24, '2026-01-31 20:11:37.404757', '2026-01-31 20:11:37.404757');
INSERT INTO public.municipalities VALUES (889, 'Circasia', NULL, 24, '2026-01-31 20:11:37.409131', '2026-01-31 20:11:37.409131');
INSERT INTO public.municipalities VALUES (890, 'C??????rdoba', NULL, 24, '2026-01-31 20:11:37.413184', '2026-01-31 20:11:37.413184');
INSERT INTO public.municipalities VALUES (891, 'Filandia', NULL, 24, '2026-01-31 20:11:37.418575', '2026-01-31 20:11:37.418575');
INSERT INTO public.municipalities VALUES (892, 'G?????nova', NULL, 24, '2026-01-31 20:11:37.42221', '2026-01-31 20:11:37.42221');
INSERT INTO public.municipalities VALUES (893, 'La Tebaida', NULL, 24, '2026-01-31 20:11:37.425519', '2026-01-31 20:11:37.425519');
INSERT INTO public.municipalities VALUES (894, 'Montenegro', NULL, 24, '2026-01-31 20:11:37.429496', '2026-01-31 20:11:37.429496');
INSERT INTO public.municipalities VALUES (895, 'Pijao', NULL, 24, '2026-01-31 20:11:37.436113', '2026-01-31 20:11:37.436113');
INSERT INTO public.municipalities VALUES (896, 'Quimbaya', NULL, 24, '2026-01-31 20:11:37.439869', '2026-01-31 20:11:37.439869');
INSERT INTO public.municipalities VALUES (897, 'Salento', NULL, 24, '2026-01-31 20:11:37.443143', '2026-01-31 20:11:37.443143');
INSERT INTO public.municipalities VALUES (898, 'Ap?????a', NULL, 25, '2026-01-31 20:12:24.212808', '2026-01-31 20:12:24.212808');
INSERT INTO public.municipalities VALUES (899, 'Balboa', NULL, 25, '2026-01-31 20:12:24.234237', '2026-01-31 20:12:24.234237');
INSERT INTO public.municipalities VALUES (900, 'Bel?????n de Umbr?????a', NULL, 25, '2026-01-31 20:12:24.241485', '2026-01-31 20:12:24.241485');
INSERT INTO public.municipalities VALUES (901, 'Dosquebradas', NULL, 25, '2026-01-31 20:12:24.245723', '2026-01-31 20:12:24.245723');
INSERT INTO public.municipalities VALUES (902, 'Gu?????tica', NULL, 25, '2026-01-31 20:12:24.249657', '2026-01-31 20:12:24.249657');
INSERT INTO public.municipalities VALUES (903, 'La Celia', NULL, 25, '2026-01-31 20:12:24.257277', '2026-01-31 20:12:24.257277');
INSERT INTO public.municipalities VALUES (904, 'La Virginia', NULL, 25, '2026-01-31 20:12:24.261289', '2026-01-31 20:12:24.261289');
INSERT INTO public.municipalities VALUES (905, 'Marsella', NULL, 25, '2026-01-31 20:12:24.265335', '2026-01-31 20:12:24.265335');
INSERT INTO public.municipalities VALUES (906, 'Mistrat??????', NULL, 25, '2026-01-31 20:12:24.271821', '2026-01-31 20:12:24.271821');
INSERT INTO public.municipalities VALUES (907, 'Pereira', NULL, 25, '2026-01-31 20:12:24.28045', '2026-01-31 20:12:24.28045');
INSERT INTO public.municipalities VALUES (908, 'Pueblo Rico', NULL, 25, '2026-01-31 20:12:24.284715', '2026-01-31 20:12:24.284715');
INSERT INTO public.municipalities VALUES (909, 'Quinch?????a', NULL, 25, '2026-01-31 20:12:24.294434', '2026-01-31 20:12:24.294434');
INSERT INTO public.municipalities VALUES (910, 'Santa Rosa de Cabal', NULL, 25, '2026-01-31 20:12:24.298054', '2026-01-31 20:12:24.298054');
INSERT INTO public.municipalities VALUES (911, 'Santuario', NULL, 25, '2026-01-31 20:12:24.302022', '2026-01-31 20:12:24.302022');
INSERT INTO public.municipalities VALUES (912, 'San Andr?????s', NULL, 26, '2026-01-31 20:13:36.302259', '2026-01-31 20:13:36.302259');
INSERT INTO public.municipalities VALUES (913, 'Providencia', NULL, 26, '2026-01-31 20:13:36.327131', '2026-01-31 20:13:36.327131');
INSERT INTO public.municipalities VALUES (914, 'Aguada', NULL, 27, '2026-01-31 20:14:23.640744', '2026-01-31 20:14:23.640744');
INSERT INTO public.municipalities VALUES (915, 'Albania', NULL, 27, '2026-01-31 20:14:23.65337', '2026-01-31 20:14:23.65337');
INSERT INTO public.municipalities VALUES (916, 'Aratoca', NULL, 27, '2026-01-31 20:14:23.658284', '2026-01-31 20:14:23.658284');
INSERT INTO public.municipalities VALUES (917, 'Barbosa', NULL, 27, '2026-01-31 20:14:23.662645', '2026-01-31 20:14:23.662645');
INSERT INTO public.municipalities VALUES (918, 'Barichara', NULL, 27, '2026-01-31 20:14:23.666645', '2026-01-31 20:14:23.666645');
INSERT INTO public.municipalities VALUES (919, 'Barrancabermeja', NULL, 27, '2026-01-31 20:14:23.670972', '2026-01-31 20:14:23.670972');
INSERT INTO public.municipalities VALUES (920, 'Betulia', NULL, 27, '2026-01-31 20:14:23.676514', '2026-01-31 20:14:23.676514');
INSERT INTO public.municipalities VALUES (921, 'Bol?????var', NULL, 27, '2026-01-31 20:14:23.680055', '2026-01-31 20:14:23.680055');
INSERT INTO public.municipalities VALUES (922, 'Bucaramanga', NULL, 27, '2026-01-31 20:14:23.684181', '2026-01-31 20:14:23.684181');
INSERT INTO public.municipalities VALUES (923, 'Cabrera', NULL, 27, '2026-01-31 20:14:23.690095', '2026-01-31 20:14:23.690095');
INSERT INTO public.municipalities VALUES (924, 'California', NULL, 27, '2026-01-31 20:14:23.693983', '2026-01-31 20:14:23.693983');
INSERT INTO public.municipalities VALUES (925, 'Capitanejo', NULL, 27, '2026-01-31 20:14:23.697338', '2026-01-31 20:14:23.697338');
INSERT INTO public.municipalities VALUES (926, 'Carcas?????', NULL, 27, '2026-01-31 20:14:23.700588', '2026-01-31 20:14:23.700588');
INSERT INTO public.municipalities VALUES (927, 'Cepita', NULL, 27, '2026-01-31 20:14:23.704297', '2026-01-31 20:14:23.704297');
INSERT INTO public.municipalities VALUES (928, 'Cerrito', NULL, 27, '2026-01-31 20:14:23.708538', '2026-01-31 20:14:23.708538');
INSERT INTO public.municipalities VALUES (929, 'Charta', NULL, 27, '2026-01-31 20:14:23.711877', '2026-01-31 20:14:23.711877');
INSERT INTO public.municipalities VALUES (930, 'Charala', NULL, 27, '2026-01-31 20:14:23.715223', '2026-01-31 20:14:23.715223');
INSERT INTO public.municipalities VALUES (931, 'Chima', NULL, 27, '2026-01-31 20:14:23.718957', '2026-01-31 20:14:23.718957');
INSERT INTO public.municipalities VALUES (932, 'Chipata', NULL, 27, '2026-01-31 20:14:23.733053', '2026-01-31 20:14:23.733053');
INSERT INTO public.municipalities VALUES (933, 'Cimitarra', NULL, 27, '2026-01-31 20:14:23.736648', '2026-01-31 20:14:23.736648');
INSERT INTO public.municipalities VALUES (934, 'Concepci??????n', NULL, 27, '2026-01-31 20:14:23.741591', '2026-01-31 20:14:23.741591');
INSERT INTO public.municipalities VALUES (935, 'Confines', NULL, 27, '2026-01-31 20:14:23.745395', '2026-01-31 20:14:23.745395');
INSERT INTO public.municipalities VALUES (936, 'Contrataci??????n', NULL, 27, '2026-01-31 20:14:23.7517', '2026-01-31 20:14:23.7517');
INSERT INTO public.municipalities VALUES (937, 'Coromoro', NULL, 27, '2026-01-31 20:14:23.75681', '2026-01-31 20:14:23.75681');
INSERT INTO public.municipalities VALUES (938, 'Curit?????', NULL, 27, '2026-01-31 20:14:23.760694', '2026-01-31 20:14:23.760694');
INSERT INTO public.municipalities VALUES (939, 'El Carmen', NULL, 27, '2026-01-31 20:14:23.765588', '2026-01-31 20:14:23.765588');
INSERT INTO public.municipalities VALUES (940, 'El Guacamayo', NULL, 27, '2026-01-31 20:14:23.769405', '2026-01-31 20:14:23.769405');
INSERT INTO public.municipalities VALUES (941, 'El Pe????????????n', NULL, 27, '2026-01-31 20:14:23.807138', '2026-01-31 20:14:23.807138');
INSERT INTO public.municipalities VALUES (942, 'El Play??????n', NULL, 27, '2026-01-31 20:14:23.811117', '2026-01-31 20:14:23.811117');
INSERT INTO public.municipalities VALUES (943, 'Encino', NULL, 27, '2026-01-31 20:14:23.81472', '2026-01-31 20:14:23.81472');
INSERT INTO public.municipalities VALUES (944, 'Enciso', NULL, 27, '2026-01-31 20:14:23.818627', '2026-01-31 20:14:23.818627');
INSERT INTO public.municipalities VALUES (945, 'Flori?????n', NULL, 27, '2026-01-31 20:14:23.823141', '2026-01-31 20:14:23.823141');
INSERT INTO public.municipalities VALUES (946, 'Floridablanca', NULL, 27, '2026-01-31 20:14:23.82763', '2026-01-31 20:14:23.82763');
INSERT INTO public.municipalities VALUES (947, 'Gal?????n', NULL, 27, '2026-01-31 20:14:23.831813', '2026-01-31 20:14:23.831813');
INSERT INTO public.municipalities VALUES (948, 'Gambita', NULL, 27, '2026-01-31 20:14:23.835535', '2026-01-31 20:14:23.835535');
INSERT INTO public.municipalities VALUES (949, 'Gir??????n', NULL, 27, '2026-01-31 20:14:23.839841', '2026-01-31 20:14:23.839841');
INSERT INTO public.municipalities VALUES (950, 'Guaca', NULL, 27, '2026-01-31 20:14:23.843273', '2026-01-31 20:14:23.843273');
INSERT INTO public.municipalities VALUES (951, 'Guadalupe', NULL, 27, '2026-01-31 20:14:23.847271', '2026-01-31 20:14:23.847271');
INSERT INTO public.municipalities VALUES (952, 'Guapota', NULL, 27, '2026-01-31 20:14:23.851689', '2026-01-31 20:14:23.851689');
INSERT INTO public.municipalities VALUES (953, 'Guavata', NULL, 27, '2026-01-31 20:14:23.855949', '2026-01-31 20:14:23.855949');
INSERT INTO public.municipalities VALUES (954, 'Guepsa', NULL, 27, '2026-01-31 20:14:23.860064', '2026-01-31 20:14:23.860064');
INSERT INTO public.municipalities VALUES (955, 'Hato', NULL, 27, '2026-01-31 20:14:23.863498', '2026-01-31 20:14:23.863498');
INSERT INTO public.municipalities VALUES (956, 'Jes??????s Mar?????a', NULL, 27, '2026-01-31 20:14:23.867136', '2026-01-31 20:14:23.867136');
INSERT INTO public.municipalities VALUES (957, 'Jord?????n', NULL, 27, '2026-01-31 20:14:23.870677', '2026-01-31 20:14:23.870677');
INSERT INTO public.municipalities VALUES (958, 'La Belleza', NULL, 27, '2026-01-31 20:14:23.87786', '2026-01-31 20:14:23.87786');
INSERT INTO public.municipalities VALUES (959, 'La Paz', NULL, 27, '2026-01-31 20:14:23.881413', '2026-01-31 20:14:23.881413');
INSERT INTO public.municipalities VALUES (960, 'Land?????zuri', NULL, 27, '2026-01-31 20:14:23.884923', '2026-01-31 20:14:23.884923');
INSERT INTO public.municipalities VALUES (961, 'Lebrija', NULL, 27, '2026-01-31 20:14:23.889561', '2026-01-31 20:14:23.889561');
INSERT INTO public.municipalities VALUES (962, 'Los Santos', NULL, 27, '2026-01-31 20:14:23.893222', '2026-01-31 20:14:23.893222');
INSERT INTO public.municipalities VALUES (963, 'Macaravita', NULL, 27, '2026-01-31 20:14:23.896758', '2026-01-31 20:14:23.896758');
INSERT INTO public.municipalities VALUES (964, 'M?????laga', NULL, 27, '2026-01-31 20:14:23.900534', '2026-01-31 20:14:23.900534');
INSERT INTO public.municipalities VALUES (965, 'Matanza', NULL, 27, '2026-01-31 20:14:23.904301', '2026-01-31 20:14:23.904301');
INSERT INTO public.municipalities VALUES (966, 'Mogotes', NULL, 27, '2026-01-31 20:14:23.910398', '2026-01-31 20:14:23.910398');
INSERT INTO public.municipalities VALUES (967, 'Molagavita', NULL, 27, '2026-01-31 20:14:23.913801', '2026-01-31 20:14:23.913801');
INSERT INTO public.municipalities VALUES (968, 'Ocamonte', NULL, 27, '2026-01-31 20:14:23.917404', '2026-01-31 20:14:23.917404');
INSERT INTO public.municipalities VALUES (969, 'Oiba', NULL, 27, '2026-01-31 20:14:23.920845', '2026-01-31 20:14:23.920845');
INSERT INTO public.municipalities VALUES (970, 'Onzaga', NULL, 27, '2026-01-31 20:14:23.925944', '2026-01-31 20:14:23.925944');
INSERT INTO public.municipalities VALUES (971, 'Palmar', NULL, 27, '2026-01-31 20:14:23.929411', '2026-01-31 20:14:23.929411');
INSERT INTO public.municipalities VALUES (972, 'Palmas del Socorro', NULL, 27, '2026-01-31 20:14:23.933011', '2026-01-31 20:14:23.933011');
INSERT INTO public.municipalities VALUES (973, 'P?????ramo', NULL, 27, '2026-01-31 20:14:23.936483', '2026-01-31 20:14:23.936483');
INSERT INTO public.municipalities VALUES (974, 'Piedecuesta', NULL, 27, '2026-01-31 20:14:23.941253', '2026-01-31 20:14:23.941253');
INSERT INTO public.municipalities VALUES (975, 'Pinchote', NULL, 27, '2026-01-31 20:14:23.944605', '2026-01-31 20:14:23.944605');
INSERT INTO public.municipalities VALUES (976, 'Puente Nacional', NULL, 27, '2026-01-31 20:14:23.948408', '2026-01-31 20:14:23.948408');
INSERT INTO public.municipalities VALUES (977, 'Puerto Parra', NULL, 27, '2026-01-31 20:14:23.951808', '2026-01-31 20:14:23.951808');
INSERT INTO public.municipalities VALUES (978, 'Puerto Wilches', NULL, 27, '2026-01-31 20:14:23.955945', '2026-01-31 20:14:23.955945');
INSERT INTO public.municipalities VALUES (979, 'Rionegro', NULL, 27, '2026-01-31 20:14:23.960634', '2026-01-31 20:14:23.960634');
INSERT INTO public.municipalities VALUES (980, 'Sabana de Torres', NULL, 27, '2026-01-31 20:14:23.964043', '2026-01-31 20:14:23.964043');
INSERT INTO public.municipalities VALUES (981, 'San Andr?????s', NULL, 27, '2026-01-31 20:14:23.967518', '2026-01-31 20:14:23.967518');
INSERT INTO public.municipalities VALUES (982, 'San Benito', NULL, 27, '2026-01-31 20:14:23.97161', '2026-01-31 20:14:23.97161');
INSERT INTO public.municipalities VALUES (983, 'San Gil', NULL, 27, '2026-01-31 20:14:23.976945', '2026-01-31 20:14:23.976945');
INSERT INTO public.municipalities VALUES (984, 'San Joaqu?????n', NULL, 27, '2026-01-31 20:14:23.980647', '2026-01-31 20:14:23.980647');
INSERT INTO public.municipalities VALUES (985, 'San Jos????? de Miranda', NULL, 27, '2026-01-31 20:14:23.984164', '2026-01-31 20:14:23.984164');
INSERT INTO public.municipalities VALUES (986, 'San Miguel', NULL, 27, '2026-01-31 20:14:23.987632', '2026-01-31 20:14:23.987632');
INSERT INTO public.municipalities VALUES (987, 'San Vicente de Chucur?????', NULL, 27, '2026-01-31 20:14:23.992405', '2026-01-31 20:14:23.992405');
INSERT INTO public.municipalities VALUES (988, 'Santa B?????rbara', NULL, 27, '2026-01-31 20:14:23.997437', '2026-01-31 20:14:23.997437');
INSERT INTO public.municipalities VALUES (989, 'Santa Helena del Op??????n', NULL, 27, '2026-01-31 20:14:24.000988', '2026-01-31 20:14:24.000988');
INSERT INTO public.municipalities VALUES (990, 'Simacota', NULL, 27, '2026-01-31 20:14:24.00531', '2026-01-31 20:14:24.00531');
INSERT INTO public.municipalities VALUES (991, 'Socorro', NULL, 27, '2026-01-31 20:14:24.009186', '2026-01-31 20:14:24.009186');
INSERT INTO public.municipalities VALUES (992, 'Suita', NULL, 27, '2026-01-31 20:14:24.012598', '2026-01-31 20:14:24.012598');
INSERT INTO public.municipalities VALUES (993, 'Sucre', NULL, 27, '2026-01-31 20:14:24.015939', '2026-01-31 20:14:24.015939');
INSERT INTO public.municipalities VALUES (994, 'Surat?????', NULL, 27, '2026-01-31 20:14:24.019129', '2026-01-31 20:14:24.019129');
INSERT INTO public.municipalities VALUES (995, 'Tona', NULL, 27, '2026-01-31 20:14:24.024237', '2026-01-31 20:14:24.024237');
INSERT INTO public.municipalities VALUES (996, 'Valle de San Jos?????', NULL, 27, '2026-01-31 20:14:24.027791', '2026-01-31 20:14:24.027791');
INSERT INTO public.municipalities VALUES (997, 'Vetas', NULL, 27, '2026-01-31 20:14:24.031105', '2026-01-31 20:14:24.031105');
INSERT INTO public.municipalities VALUES (998, 'V?????lez', NULL, 27, '2026-01-31 20:14:24.034279', '2026-01-31 20:14:24.034279');
INSERT INTO public.municipalities VALUES (999, 'Villanueva', NULL, 27, '2026-01-31 20:14:24.037548', '2026-01-31 20:14:24.037548');
INSERT INTO public.municipalities VALUES (1000, 'Zapatoca', NULL, 27, '2026-01-31 20:14:24.041923', '2026-01-31 20:14:24.041923');
INSERT INTO public.municipalities VALUES (1027, 'Alpujarra', NULL, 29, '2026-01-31 20:15:56.195389', '2026-01-31 20:15:56.195389');
INSERT INTO public.municipalities VALUES (1028, 'Alvarado', NULL, 29, '2026-01-31 20:15:56.223635', '2026-01-31 20:15:56.223635');
INSERT INTO public.municipalities VALUES (1029, 'Ambalema', NULL, 29, '2026-01-31 20:15:56.231179', '2026-01-31 20:15:56.231179');
INSERT INTO public.municipalities VALUES (1030, 'Anzo?????tegui', NULL, 29, '2026-01-31 20:15:56.243737', '2026-01-31 20:15:56.243737');
INSERT INTO public.municipalities VALUES (1031, 'Armero (Guayabal)', NULL, 29, '2026-01-31 20:15:56.259494', '2026-01-31 20:15:56.259494');
INSERT INTO public.municipalities VALUES (1032, 'Ataco', NULL, 29, '2026-01-31 20:15:56.278087', '2026-01-31 20:15:56.278087');
INSERT INTO public.municipalities VALUES (1033, 'Cajamarca', NULL, 29, '2026-01-31 20:15:56.292455', '2026-01-31 20:15:56.292455');
INSERT INTO public.municipalities VALUES (1034, 'Carmen de Apical?????', NULL, 29, '2026-01-31 20:15:56.309136', '2026-01-31 20:15:56.309136');
INSERT INTO public.municipalities VALUES (1035, 'Casabianca', NULL, 29, '2026-01-31 20:15:56.326392', '2026-01-31 20:15:56.326392');
INSERT INTO public.municipalities VALUES (1036, 'Chaparral', NULL, 29, '2026-01-31 20:15:56.336615', '2026-01-31 20:15:56.336615');
INSERT INTO public.municipalities VALUES (1037, 'Coello', NULL, 29, '2026-01-31 20:15:56.34188', '2026-01-31 20:15:56.34188');
INSERT INTO public.municipalities VALUES (1038, 'Coyaima', NULL, 29, '2026-01-31 20:15:56.347154', '2026-01-31 20:15:56.347154');
INSERT INTO public.municipalities VALUES (1039, 'Cunday', NULL, 29, '2026-01-31 20:15:56.35668', '2026-01-31 20:15:56.35668');
INSERT INTO public.municipalities VALUES (1040, 'Dolores', NULL, 29, '2026-01-31 20:15:56.361173', '2026-01-31 20:15:56.361173');
INSERT INTO public.municipalities VALUES (1041, 'Espinal', NULL, 29, '2026-01-31 20:15:56.365217', '2026-01-31 20:15:56.365217');
INSERT INTO public.municipalities VALUES (1042, 'Fal?????n', NULL, 29, '2026-01-31 20:15:56.377717', '2026-01-31 20:15:56.377717');
INSERT INTO public.municipalities VALUES (1043, 'Flandes', NULL, 29, '2026-01-31 20:15:56.384635', '2026-01-31 20:15:56.384635');
INSERT INTO public.municipalities VALUES (1044, 'Fresno', NULL, 29, '2026-01-31 20:15:56.396663', '2026-01-31 20:15:56.396663');
INSERT INTO public.municipalities VALUES (1045, 'Guamo', NULL, 29, '2026-01-31 20:15:56.409153', '2026-01-31 20:15:56.409153');
INSERT INTO public.municipalities VALUES (1046, 'Herveo', NULL, 29, '2026-01-31 20:15:56.419551', '2026-01-31 20:15:56.419551');
INSERT INTO public.municipalities VALUES (1047, 'Honda', NULL, 29, '2026-01-31 20:15:56.453751', '2026-01-31 20:15:56.453751');
INSERT INTO public.municipalities VALUES (1048, 'Ibagu?????', NULL, 29, '2026-01-31 20:15:56.464271', '2026-01-31 20:15:56.464271');
INSERT INTO public.municipalities VALUES (1049, 'Icononzo', NULL, 29, '2026-01-31 20:15:56.521472', '2026-01-31 20:15:56.521472');
INSERT INTO public.municipalities VALUES (1050, 'L?????rida', NULL, 29, '2026-01-31 20:15:56.553231', '2026-01-31 20:15:56.553231');
INSERT INTO public.municipalities VALUES (1051, 'L?????bano', NULL, 29, '2026-01-31 20:15:56.604339', '2026-01-31 20:15:56.604339');
INSERT INTO public.municipalities VALUES (1052, 'Mariquita', NULL, 29, '2026-01-31 20:15:56.645532', '2026-01-31 20:15:56.645532');
INSERT INTO public.municipalities VALUES (1053, 'Melgar', NULL, 29, '2026-01-31 20:15:56.707476', '2026-01-31 20:15:56.707476');
INSERT INTO public.municipalities VALUES (1054, 'Murillo', NULL, 29, '2026-01-31 20:15:56.756971', '2026-01-31 20:15:56.756971');
INSERT INTO public.municipalities VALUES (1055, 'Natagaima', NULL, 29, '2026-01-31 20:15:56.820112', '2026-01-31 20:15:56.820112');
INSERT INTO public.municipalities VALUES (1056, 'Ortega', NULL, 29, '2026-01-31 20:15:56.855604', '2026-01-31 20:15:56.855604');
INSERT INTO public.municipalities VALUES (1057, 'Palocabildo', NULL, 29, '2026-01-31 20:15:56.887475', '2026-01-31 20:15:56.887475');
INSERT INTO public.municipalities VALUES (1058, 'Piedras', NULL, 29, '2026-01-31 20:15:56.908096', '2026-01-31 20:15:56.908096');
INSERT INTO public.municipalities VALUES (1059, 'Planadas', NULL, 29, '2026-01-31 20:15:56.924188', '2026-01-31 20:15:56.924188');
INSERT INTO public.municipalities VALUES (1060, 'Prado', NULL, 29, '2026-01-31 20:15:56.941475', '2026-01-31 20:15:56.941475');
INSERT INTO public.municipalities VALUES (1061, 'Purificaci??????n', NULL, 29, '2026-01-31 20:15:56.956798', '2026-01-31 20:15:56.956798');
INSERT INTO public.municipalities VALUES (1062, 'Rioblanco', NULL, 29, '2026-01-31 20:15:56.980334', '2026-01-31 20:15:56.980334');
INSERT INTO public.municipalities VALUES (1063, 'Roncesvalles', NULL, 29, '2026-01-31 20:15:57.021872', '2026-01-31 20:15:57.021872');
INSERT INTO public.municipalities VALUES (1064, 'Rovira', NULL, 29, '2026-01-31 20:15:57.035303', '2026-01-31 20:15:57.035303');
INSERT INTO public.municipalities VALUES (1065, 'Salda??????a', NULL, 29, '2026-01-31 20:15:57.058642', '2026-01-31 20:15:57.058642');
INSERT INTO public.municipalities VALUES (1066, 'San Antonio', NULL, 29, '2026-01-31 20:15:57.086935', '2026-01-31 20:15:57.086935');
INSERT INTO public.municipalities VALUES (1067, 'San Luis', NULL, 29, '2026-01-31 20:15:57.103991', '2026-01-31 20:15:57.103991');
INSERT INTO public.municipalities VALUES (1068, 'Santa Isabel', NULL, 29, '2026-01-31 20:15:57.124252', '2026-01-31 20:15:57.124252');
INSERT INTO public.municipalities VALUES (1069, 'Su?????rez', NULL, 29, '2026-01-31 20:15:57.140942', '2026-01-31 20:15:57.140942');
INSERT INTO public.municipalities VALUES (1070, 'Valle de San Juan', NULL, 29, '2026-01-31 20:15:57.156969', '2026-01-31 20:15:57.156969');
INSERT INTO public.municipalities VALUES (1071, 'Venadillo', NULL, 29, '2026-01-31 20:15:57.176194', '2026-01-31 20:15:57.176194');
INSERT INTO public.municipalities VALUES (1072, 'Villahermosa', NULL, 29, '2026-01-31 20:15:57.190938', '2026-01-31 20:15:57.190938');
INSERT INTO public.municipalities VALUES (1073, 'Villarrica', NULL, 29, '2026-01-31 20:15:57.209077', '2026-01-31 20:15:57.209077');
INSERT INTO public.municipalities VALUES (1074, 'Alcal?????', NULL, 32, '2026-01-31 20:16:35.019611', '2026-01-31 20:16:35.019611');
INSERT INTO public.municipalities VALUES (1075, 'Andaluc?????a', NULL, 32, '2026-01-31 20:16:35.045962', '2026-01-31 20:16:35.045962');
INSERT INTO public.municipalities VALUES (1076, 'Ansermanutevo', NULL, 32, '2026-01-31 20:16:35.051699', '2026-01-31 20:16:35.051699');
INSERT INTO public.municipalities VALUES (1077, 'Argelia', NULL, 32, '2026-01-31 20:16:35.056477', '2026-01-31 20:16:35.056477');
INSERT INTO public.municipalities VALUES (1078, 'Bol?????var', NULL, 32, '2026-01-31 20:16:35.060978', '2026-01-31 20:16:35.060978');
INSERT INTO public.municipalities VALUES (1079, 'Buenaventura', NULL, 32, '2026-01-31 20:16:35.068807', '2026-01-31 20:16:35.068807');
INSERT INTO public.municipalities VALUES (1080, 'Buga', NULL, 32, '2026-01-31 20:16:35.072978', '2026-01-31 20:16:35.072978');
INSERT INTO public.municipalities VALUES (1081, 'Bugalagrande', NULL, 32, '2026-01-31 20:16:35.076907', '2026-01-31 20:16:35.076907');
INSERT INTO public.municipalities VALUES (1082, 'Caicedonia', NULL, 32, '2026-01-31 20:16:35.085448', '2026-01-31 20:16:35.085448');
INSERT INTO public.municipalities VALUES (1083, 'Cali', NULL, 32, '2026-01-31 20:16:35.090884', '2026-01-31 20:16:35.090884');
INSERT INTO public.municipalities VALUES (1084, 'Calima (Dari?????n)', NULL, 32, '2026-01-31 20:16:35.095441', '2026-01-31 20:16:35.095441');
INSERT INTO public.municipalities VALUES (1085, 'Candelaria', NULL, 32, '2026-01-31 20:16:35.10062', '2026-01-31 20:16:35.10062');
INSERT INTO public.municipalities VALUES (1086, 'Cartago', NULL, 32, '2026-01-31 20:16:35.104259', '2026-01-31 20:16:35.104259');
INSERT INTO public.municipalities VALUES (1087, 'Dagua', NULL, 32, '2026-01-31 20:16:35.109083', '2026-01-31 20:16:35.109083');
INSERT INTO public.municipalities VALUES (1088, 'El ?????guila', NULL, 32, '2026-01-31 20:16:35.114683', '2026-01-31 20:16:35.114683');
INSERT INTO public.municipalities VALUES (1089, 'El Cairo', NULL, 32, '2026-01-31 20:16:35.120635', '2026-01-31 20:16:35.120635');
INSERT INTO public.municipalities VALUES (1090, 'El Cerrito', NULL, 32, '2026-01-31 20:16:35.124811', '2026-01-31 20:16:35.124811');
INSERT INTO public.municipalities VALUES (1091, 'El Dovio', NULL, 32, '2026-01-31 20:16:35.129693', '2026-01-31 20:16:35.129693');
INSERT INTO public.municipalities VALUES (1092, 'Florida', NULL, 32, '2026-01-31 20:16:35.133702', '2026-01-31 20:16:35.133702');
INSERT INTO public.municipalities VALUES (1093, 'Ginebra', NULL, 32, '2026-01-31 20:16:35.137413', '2026-01-31 20:16:35.137413');
INSERT INTO public.municipalities VALUES (1094, 'Guacari', NULL, 32, '2026-01-31 20:16:35.141383', '2026-01-31 20:16:35.141383');
INSERT INTO public.municipalities VALUES (1095, 'Jamund?????', NULL, 32, '2026-01-31 20:16:35.145349', '2026-01-31 20:16:35.145349');
INSERT INTO public.municipalities VALUES (1096, 'La Cumbre', NULL, 32, '2026-01-31 20:16:35.152743', '2026-01-31 20:16:35.152743');
INSERT INTO public.municipalities VALUES (1097, 'La Uni??????n', NULL, 32, '2026-01-31 20:16:35.156391', '2026-01-31 20:16:35.156391');
INSERT INTO public.municipalities VALUES (1098, 'La Victoria', NULL, 32, '2026-01-31 20:16:35.159906', '2026-01-31 20:16:35.159906');
INSERT INTO public.municipalities VALUES (1099, 'Obando', NULL, 32, '2026-01-31 20:16:35.166602', '2026-01-31 20:16:35.166602');
INSERT INTO public.municipalities VALUES (1100, 'Palmira', NULL, 32, '2026-01-31 20:16:35.170108', '2026-01-31 20:16:35.170108');
INSERT INTO public.municipalities VALUES (1101, 'Pradera', NULL, 32, '2026-01-31 20:16:35.173403', '2026-01-31 20:16:35.173403');
INSERT INTO public.municipalities VALUES (1102, 'Restrepo', NULL, 32, '2026-01-31 20:16:35.176611', '2026-01-31 20:16:35.176611');
INSERT INTO public.municipalities VALUES (1103, 'Riofr?????o', NULL, 32, '2026-01-31 20:16:35.182158', '2026-01-31 20:16:35.182158');
INSERT INTO public.municipalities VALUES (1104, 'Roldanillo', NULL, 32, '2026-01-31 20:16:35.185684', '2026-01-31 20:16:35.185684');
INSERT INTO public.municipalities VALUES (1105, 'San Pedro', NULL, 32, '2026-01-31 20:16:35.189052', '2026-01-31 20:16:35.189052');
INSERT INTO public.municipalities VALUES (1106, 'Sevilla', NULL, 32, '2026-01-31 20:16:35.192718', '2026-01-31 20:16:35.192718');
INSERT INTO public.municipalities VALUES (1107, 'Toro', NULL, 32, '2026-01-31 20:16:35.198096', '2026-01-31 20:16:35.198096');
INSERT INTO public.municipalities VALUES (1108, 'Trujillo', NULL, 32, '2026-01-31 20:16:35.201681', '2026-01-31 20:16:35.201681');
INSERT INTO public.municipalities VALUES (1109, 'Tulu?????', NULL, 32, '2026-01-31 20:16:35.20495', '2026-01-31 20:16:35.20495');
INSERT INTO public.municipalities VALUES (1110, 'Ulloa', NULL, 32, '2026-01-31 20:16:35.208394', '2026-01-31 20:16:35.208394');
INSERT INTO public.municipalities VALUES (1111, 'Versalles', NULL, 32, '2026-01-31 20:16:35.21451', '2026-01-31 20:16:35.21451');
INSERT INTO public.municipalities VALUES (1112, 'Vijes', NULL, 32, '2026-01-31 20:16:35.218104', '2026-01-31 20:16:35.218104');
INSERT INTO public.municipalities VALUES (1113, 'Yotoco', NULL, 32, '2026-01-31 20:16:35.222009', '2026-01-31 20:16:35.222009');
INSERT INTO public.municipalities VALUES (1114, 'Yumbo', NULL, 32, '2026-01-31 20:16:35.22571', '2026-01-31 20:16:35.22571');
INSERT INTO public.municipalities VALUES (1115, 'Zarzal', NULL, 32, '2026-01-31 20:16:35.231991', '2026-01-31 20:16:35.231991');
INSERT INTO public.municipalities VALUES (1116, 'Buenos Aires (Pacoa)', NULL, 30, '2026-01-31 20:18:29.795673', '2026-01-31 20:18:29.795673');
INSERT INTO public.municipalities VALUES (1002, 'Caimito', '70124', 28, '2026-01-31 20:15:12.747912', '2026-01-31 20:15:12.747912');
INSERT INTO public.municipalities VALUES (1003, 'Chal?????n', '70230', 28, '2026-01-31 20:15:12.752698', '2026-01-31 20:15:12.752698');
INSERT INTO public.municipalities VALUES (1004, 'Coloso (Ricaurte)', '70204', 28, '2026-01-31 20:15:12.758409', '2026-01-31 20:15:12.758409');
INSERT INTO public.municipalities VALUES (1005, 'Corozal', '70215', 28, '2026-01-31 20:15:12.763983', '2026-01-31 20:15:12.763983');
INSERT INTO public.municipalities VALUES (1006, 'Cove??????as', '70221', 28, '2026-01-31 20:15:12.768512', '2026-01-31 20:15:12.768512');
INSERT INTO public.municipalities VALUES (1008, 'Galeras (Nueva Granada)', '70235', 28, '2026-01-31 20:15:12.77997', '2026-01-31 20:15:12.77997');
INSERT INTO public.municipalities VALUES (1009, 'Guaranda', '70265', 28, '2026-01-31 20:15:12.784563', '2026-01-31 20:15:12.784563');
INSERT INTO public.municipalities VALUES (1010, 'La Uni??????n', '70400', 28, '2026-01-31 20:15:12.790293', '2026-01-31 20:15:12.790293');
INSERT INTO public.municipalities VALUES (1011, 'Los Palmitos', '70418', 28, '2026-01-31 20:15:12.797824', '2026-01-31 20:15:12.797824');
INSERT INTO public.municipalities VALUES (1012, 'Majagual', '70429', 28, '2026-01-31 20:15:12.801826', '2026-01-31 20:15:12.801826');
INSERT INTO public.municipalities VALUES (1013, 'Morroa', '70473', 28, '2026-01-31 20:15:12.805245', '2026-01-31 20:15:12.805245');
INSERT INTO public.municipalities VALUES (1014, 'Ovejas', '70508', 28, '2026-01-31 20:15:12.81055', '2026-01-31 20:15:12.81055');
INSERT INTO public.municipalities VALUES (1015, 'Palmito', '70523', 28, '2026-01-31 20:15:12.814883', '2026-01-31 20:15:12.814883');
INSERT INTO public.municipalities VALUES (1017, 'San Benito Abad', '70678', 28, '2026-01-31 20:15:12.82165', '2026-01-31 20:15:12.82165');
INSERT INTO public.municipalities VALUES (1018, 'San Juan de Betulia (Betulia)', '70702', 28, '2026-01-31 20:15:12.826189', '2026-01-31 20:15:12.826189');
INSERT INTO public.municipalities VALUES (1019, 'San Marcos', '70708', 28, '2026-01-31 20:15:12.830063', '2026-01-31 20:15:12.830063');
INSERT INTO public.municipalities VALUES (1020, 'San Onofre', '70713', 28, '2026-01-31 20:15:12.833129', '2026-01-31 20:15:12.833129');
INSERT INTO public.municipalities VALUES (1021, 'San Pedro', '70717', 28, '2026-01-31 20:15:12.83655', '2026-01-31 20:15:12.83655');
INSERT INTO public.municipalities VALUES (1022, 'Sinc?????', '70742', 28, '2026-01-31 20:15:12.839841', '2026-01-31 20:15:12.839841');
INSERT INTO public.municipalities VALUES (1024, 'Sucre', '70771', 28, '2026-01-31 20:15:12.850048', '2026-01-31 20:15:12.850048');
INSERT INTO public.municipalities VALUES (1025, 'Tol??????', '70820', 28, '2026-01-31 20:15:12.853613', '2026-01-31 20:15:12.853613');
INSERT INTO public.municipalities VALUES (1026, 'Toluviejo', '70823', 28, '2026-01-31 20:15:12.859514', '2026-01-31 20:15:12.859514');
INSERT INTO public.municipalities VALUES (1117, 'Caruru', NULL, 30, '2026-01-31 20:18:29.821118', '2026-01-31 20:18:29.821118');
INSERT INTO public.municipalities VALUES (1118, 'Mit??????', NULL, 30, '2026-01-31 20:18:29.82583', '2026-01-31 20:18:29.82583');
INSERT INTO public.municipalities VALUES (1119, 'Morichal (Papunagua)', NULL, 30, '2026-01-31 20:18:29.830603', '2026-01-31 20:18:29.830603');
INSERT INTO public.municipalities VALUES (1120, 'Taraira', NULL, 30, '2026-01-31 20:18:29.835532', '2026-01-31 20:18:29.835532');
INSERT INTO public.municipalities VALUES (1121, 'Yavarate', NULL, 30, '2026-01-31 20:18:29.841194', '2026-01-31 20:18:29.841194');
INSERT INTO public.municipalities VALUES (1122, 'Cumaribo', NULL, 31, '2026-01-31 20:19:26.210709', '2026-01-31 20:19:26.210709');
INSERT INTO public.municipalities VALUES (1123, 'La Primavera', NULL, 31, '2026-01-31 20:19:26.22444', '2026-01-31 20:19:26.22444');
INSERT INTO public.municipalities VALUES (1124, 'Puerto Carre??????o', NULL, 31, '2026-01-31 20:19:26.228536', '2026-01-31 20:19:26.228536');
INSERT INTO public.municipalities VALUES (1125, 'Santa Rosal?????a', NULL, 31, '2026-01-31 20:19:26.234189', '2026-01-31 20:19:26.234189');
INSERT INTO public.municipalities VALUES (1001, 'Buenavista', '70110', 28, '2026-01-31 20:15:12.721574', '2026-01-31 20:15:12.721574');
INSERT INTO public.municipalities VALUES (1007, 'El Roble', '70233', 28, '2026-01-31 20:15:12.77301', '2026-01-31 20:15:12.77301');
INSERT INTO public.municipalities VALUES (1016, 'Sampu?????s', '70670', 28, '2026-01-31 20:15:12.818342', '2026-01-31 20:15:12.818342');
INSERT INTO public.municipalities VALUES (1023, 'Sincelejo', '70001', 28, '2026-01-31 20:15:12.846129', '2026-01-31 20:15:12.846129');
INSERT INTO public.municipalities VALUES (171, 'ACHI', '13006', 5, '2026-01-31 18:45:41.922351', '2026-01-31 18:45:41.922351');
INSERT INTO public.municipalities VALUES (174, 'ARJONA', '13052', 5, '2026-01-31 18:45:41.959408', '2026-01-31 18:45:41.959408');
INSERT INTO public.municipalities VALUES (181, 'CLEMENCIA', '13222', 5, '2026-01-31 18:45:41.993516', '2026-01-31 18:45:41.993516');
INSERT INTO public.municipalities VALUES (190, 'MARIA LA BAJA', '13442', 5, '2026-01-31 18:45:42.026956', '2026-01-31 18:45:42.026956');
INSERT INTO public.municipalities VALUES (197, 'RIOVIEJO', '13600', 5, '2026-01-31 18:45:42.051243', '2026-01-31 18:45:42.051243');
INSERT INTO public.municipalities VALUES (202, 'SAN JACINTO DEL CAUCA', '13655', 5, '2026-01-31 18:45:42.069295', '2026-01-31 18:45:42.069295');
INSERT INTO public.municipalities VALUES (211, 'TALAIGUA NUEVO', '13780', 5, '2026-01-31 18:45:42.102144', '2026-01-31 18:45:42.102144');


--
-- TOC entry 5188 (class 0 OID 18088)
-- Dependencies: 232
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.permissions VALUES (1, 'candidates:create', 'candidates', 'create', 'Crear candidatos', '2026-02-03 20:27:30.636976');
INSERT INTO public.permissions VALUES (2, 'candidates:read', 'candidates', 'read', 'Ver candidatos', '2026-02-03 20:27:30.636976');
INSERT INTO public.permissions VALUES (3, 'candidates:update', 'candidates', 'update', 'Editar candidatos', '2026-02-03 20:27:30.636976');
INSERT INTO public.permissions VALUES (4, 'candidates:delete', 'candidates', 'delete', 'Eliminar candidatos', '2026-02-03 20:27:30.636976');
INSERT INTO public.permissions VALUES (5, 'leaders:create', 'leaders', 'create', 'Crear l????deres', '2026-02-03 20:27:30.656638');
INSERT INTO public.permissions VALUES (6, 'leaders:read', 'leaders', 'read', 'Ver l????deres', '2026-02-03 20:27:30.656638');
INSERT INTO public.permissions VALUES (7, 'leaders:update', 'leaders', 'update', 'Editar l????deres', '2026-02-03 20:27:30.656638');
INSERT INTO public.permissions VALUES (8, 'leaders:delete', 'leaders', 'delete', 'Eliminar l????deres', '2026-02-03 20:27:30.656638');
INSERT INTO public.permissions VALUES (9, 'voters:create', 'voters', 'create', 'Crear votantes', '2026-02-03 20:27:30.658685');
INSERT INTO public.permissions VALUES (10, 'voters:read', 'voters', 'read', 'Ver votantes', '2026-02-03 20:27:30.658685');
INSERT INTO public.permissions VALUES (11, 'voters:update', 'voters', 'update', 'Editar votantes', '2026-02-03 20:27:30.658685');
INSERT INTO public.permissions VALUES (12, 'voters:delete', 'voters', 'delete', 'Eliminar votantes', '2026-02-03 20:27:30.658685');
INSERT INTO public.permissions VALUES (13, 'departments:read', 'departments', 'read', 'Ver departamentos', '2026-02-03 20:27:30.66503');
INSERT INTO public.permissions VALUES (14, 'departments:create', 'departments', 'create', 'Crear departamentos', '2026-02-03 20:27:30.66503');
INSERT INTO public.permissions VALUES (15, 'departments:update', 'departments', 'update', 'Editar departamentos', '2026-02-03 20:27:30.66503');
INSERT INTO public.permissions VALUES (16, 'departments:delete', 'departments', 'delete', 'Eliminar departamentos', '2026-02-03 20:27:30.66503');
INSERT INTO public.permissions VALUES (17, 'municipalities:read', 'municipalities', 'read', 'Ver municipios', '2026-02-03 20:27:30.667564');
INSERT INTO public.permissions VALUES (18, 'municipalities:create', 'municipalities', 'create', 'Crear municipios', '2026-02-03 20:27:30.667564');
INSERT INTO public.permissions VALUES (19, 'municipalities:update', 'municipalities', 'update', 'Editar municipios', '2026-02-03 20:27:30.667564');
INSERT INTO public.permissions VALUES (20, 'municipalities:delete', 'municipalities', 'delete', 'Eliminar municipios', '2026-02-03 20:27:30.667564');
INSERT INTO public.permissions VALUES (21, 'corporations:read', 'corporations', 'read', 'Ver corporaciones', '2026-02-03 20:27:30.693991');
INSERT INTO public.permissions VALUES (22, 'corporations:create', 'corporations', 'create', 'Crear corporaciones', '2026-02-03 20:27:30.693991');
INSERT INTO public.permissions VALUES (23, 'corporations:update', 'corporations', 'update', 'Editar corporaciones', '2026-02-03 20:27:30.693991');
INSERT INTO public.permissions VALUES (24, 'corporations:delete', 'corporations', 'delete', 'Eliminar corporaciones', '2026-02-03 20:27:30.693991');
INSERT INTO public.permissions VALUES (25, 'voting-booths:read', 'voting-booths', 'read', 'Ver puestos de votaci????n', '2026-02-03 20:27:30.714958');
INSERT INTO public.permissions VALUES (26, 'voting-booths:create', 'voting-booths', 'create', 'Crear puestos de votaci????n', '2026-02-03 20:27:30.714958');
INSERT INTO public.permissions VALUES (27, 'voting-booths:update', 'voting-booths', 'update', 'Editar puestos de votaci????n', '2026-02-03 20:27:30.714958');
INSERT INTO public.permissions VALUES (28, 'voting-booths:delete', 'voting-booths', 'delete', 'Eliminar puestos de votaci????n', '2026-02-03 20:27:30.714958');
INSERT INTO public.permissions VALUES (29, 'voting-tables:read', 'voting-tables', 'read', 'Ver mesas de votaci????n', '2026-02-03 20:27:30.744056');
INSERT INTO public.permissions VALUES (30, 'voting-tables:create', 'voting-tables', 'create', 'Crear mesas de votaci????n', '2026-02-03 20:27:30.744056');
INSERT INTO public.permissions VALUES (31, 'voting-tables:update', 'voting-tables', 'update', 'Editar mesas de votaci????n', '2026-02-03 20:27:30.744056');
INSERT INTO public.permissions VALUES (32, 'voting-tables:delete', 'voting-tables', 'delete', 'Eliminar mesas de votaci????n', '2026-02-03 20:27:30.744056');
INSERT INTO public.permissions VALUES (33, 'reports:read', 'reports', 'read', 'Ver reportes', '2026-02-03 20:27:30.770531');
INSERT INTO public.permissions VALUES (34, 'users:read', 'users', 'read', 'Ver usuarios', '2026-02-03 20:27:30.778296');
INSERT INTO public.permissions VALUES (35, 'users:create', 'users', 'create', 'Crear usuarios', '2026-02-03 20:27:30.778296');
INSERT INTO public.permissions VALUES (36, 'users:update', 'users', 'update', 'Editar usuarios', '2026-02-03 20:27:30.778296');
INSERT INTO public.permissions VALUES (37, 'users:delete', 'users', 'delete', 'Eliminar usuarios', '2026-02-03 20:27:30.778296');
INSERT INTO public.permissions VALUES (38, 'roles:read', 'roles', 'read', 'Ver roles', '2026-02-03 20:27:30.784572');
INSERT INTO public.permissions VALUES (39, 'roles:create', 'roles', 'create', 'Crear roles', '2026-02-03 20:27:30.784572');
INSERT INTO public.permissions VALUES (40, 'roles:update', 'roles', 'update', 'Editar roles', '2026-02-03 20:27:30.784572');
INSERT INTO public.permissions VALUES (41, 'roles:delete', 'roles', 'delete', 'Eliminar roles', '2026-02-03 20:27:30.784572');
INSERT INTO public.permissions VALUES (42, 'permissions:read', 'permissions', 'read', 'Ver permisos', '2026-02-03 20:27:30.784572');
INSERT INTO public.permissions VALUES (43, 'permissions:manage', 'permissions', 'manage', 'Gestionar permisos', '2026-02-03 20:27:30.784572');


--
-- TOC entry 5190 (class 0 OID 18099)
-- Dependencies: 234
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.role_permissions VALUES (1, 1, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 2, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 3, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 5, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 6, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 7, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 9, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 10, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 11, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 12, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 13, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 14, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 15, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 16, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 17, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 18, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 19, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 20, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 21, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 22, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 23, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 24, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 25, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 26, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 27, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 28, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 29, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 30, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 31, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 32, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 33, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 34, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 35, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 36, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 37, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 38, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 39, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 40, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 41, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 42, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (1, 43, '2026-02-03 20:27:48.345842');
INSERT INTO public.role_permissions VALUES (2, 1, '2026-02-03 20:27:48.355735');
INSERT INTO public.role_permissions VALUES (2, 2, '2026-02-03 20:27:48.355735');
INSERT INTO public.role_permissions VALUES (2, 3, '2026-02-03 20:27:48.355735');
INSERT INTO public.role_permissions VALUES (2, 6, '2026-02-03 20:27:48.355735');
INSERT INTO public.role_permissions VALUES (2, 7, '2026-02-03 20:27:48.355735');
INSERT INTO public.role_permissions VALUES (2, 13, '2026-02-03 20:27:48.355735');
INSERT INTO public.role_permissions VALUES (2, 17, '2026-02-03 20:27:48.355735');
INSERT INTO public.role_permissions VALUES (2, 21, '2026-02-03 20:27:48.355735');
INSERT INTO public.role_permissions VALUES (2, 25, '2026-02-03 20:27:48.355735');
INSERT INTO public.role_permissions VALUES (2, 29, '2026-02-03 20:27:48.355735');
INSERT INTO public.role_permissions VALUES (3, 10, '2026-02-03 20:27:48.358011');
INSERT INTO public.role_permissions VALUES (3, 13, '2026-02-03 20:27:48.358011');
INSERT INTO public.role_permissions VALUES (3, 17, '2026-02-03 20:27:48.358011');
INSERT INTO public.role_permissions VALUES (3, 21, '2026-02-03 20:27:48.358011');
INSERT INTO public.role_permissions VALUES (3, 25, '2026-02-03 20:27:48.358011');
INSERT INTO public.role_permissions VALUES (3, 29, '2026-02-03 20:27:48.358011');
INSERT INTO public.role_permissions VALUES (3, 33, '2026-02-03 20:27:48.358011');
INSERT INTO public.role_permissions VALUES (4, 10, '2026-02-03 20:27:48.359332');
INSERT INTO public.role_permissions VALUES (4, 13, '2026-02-03 20:27:48.359332');
INSERT INTO public.role_permissions VALUES (4, 17, '2026-02-03 20:27:48.359332');
INSERT INTO public.role_permissions VALUES (4, 21, '2026-02-03 20:27:48.359332');
INSERT INTO public.role_permissions VALUES (4, 25, '2026-02-03 20:27:48.359332');
INSERT INTO public.role_permissions VALUES (4, 33, '2026-02-03 20:27:48.359332');
INSERT INTO public.role_permissions VALUES (5, 2, '2026-02-03 21:54:49.641189');
INSERT INTO public.role_permissions VALUES (5, 6, '2026-02-03 21:54:49.641189');
INSERT INTO public.role_permissions VALUES (5, 9, '2026-02-03 21:54:49.641189');
INSERT INTO public.role_permissions VALUES (5, 10, '2026-02-03 21:54:49.641189');
INSERT INTO public.role_permissions VALUES (5, 11, '2026-02-03 21:54:49.641189');
INSERT INTO public.role_permissions VALUES (5, 12, '2026-02-03 21:54:49.641189');
INSERT INTO public.role_permissions VALUES (5, 13, '2026-02-03 21:54:49.641189');
INSERT INTO public.role_permissions VALUES (5, 17, '2026-02-03 21:54:49.641189');
INSERT INTO public.role_permissions VALUES (5, 21, '2026-02-03 21:54:49.641189');
INSERT INTO public.role_permissions VALUES (5, 25, '2026-02-03 21:54:49.641189');
INSERT INTO public.role_permissions VALUES (5, 29, '2026-02-03 21:54:49.641189');
INSERT INTO public.role_permissions VALUES (4, 29, '2026-02-03 20:27:48.359332');
INSERT INTO public.role_permissions VALUES (2, 10, '2026-02-04 00:24:27.224975');
INSERT INTO public.role_permissions VALUES (2, 9, '2026-02-04 00:24:30.681069');
INSERT INTO public.role_permissions VALUES (2, 12, '2026-02-04 00:24:31.156646');
INSERT INTO public.role_permissions VALUES (2, 11, '2026-02-04 00:24:31.580918');
INSERT INTO public.role_permissions VALUES (2, 5, '2026-02-04 01:20:32.29412');
INSERT INTO public.role_permissions VALUES (1, 4, '2026-02-04 02:25:09.885651');
INSERT INTO public.role_permissions VALUES (1, 8, '2026-02-04 02:25:12.009488');
INSERT INTO public.role_permissions VALUES (2, 35, '2026-02-04 14:17:35.466701');
INSERT INTO public.role_permissions VALUES (2, 34, '2026-02-04 14:17:36.462164');
INSERT INTO public.role_permissions VALUES (2, 36, '2026-02-04 14:17:37.349344');
INSERT INTO public.role_permissions VALUES (2, 37, '2026-02-04 14:17:38.043739');
INSERT INTO public.role_permissions VALUES (3, 2, '2026-02-04 18:40:05.561103');
INSERT INTO public.role_permissions VALUES (3, 6, '2026-02-04 18:40:11.091406');
INSERT INTO public.role_permissions VALUES (3, 5, '2026-02-04 18:40:17.581081');
INSERT INTO public.role_permissions VALUES (3, 35, '2026-02-04 18:40:22.277518');
INSERT INTO public.role_permissions VALUES (3, 34, '2026-02-04 19:06:51.336311');
INSERT INTO public.role_permissions VALUES (2, 4, '2026-02-04 19:09:46.771641');
INSERT INTO public.role_permissions VALUES (2, 8, '2026-02-04 19:09:50.836309');
INSERT INTO public.role_permissions VALUES (3, 9, '2026-02-04 19:55:46.513962');
INSERT INTO public.role_permissions VALUES (4, 9, '2026-02-04 19:58:47.474845');
INSERT INTO public.role_permissions VALUES (4, 34, '2026-02-04 20:00:43.803327');
INSERT INTO public.role_permissions VALUES (2, 33, '2026-02-04 20:13:38.905934');


--
-- TOC entry 5191 (class 0 OID 18105)
-- Dependencies: 235
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles VALUES (1, 'Superadmin', 'Administrador del sistema con acceso total', '2026-02-03 19:16:33.663622', '2026-02-03 19:16:33.663622');
INSERT INTO public.roles VALUES (3, 'Candidato', 'Candidato electoral', '2026-02-03 19:16:33.663622', '2026-02-03 19:16:33.663622');
INSERT INTO public.roles VALUES (5, 'Digitador', 'Encargado de digitalizar datos', '2026-02-03 19:16:33.663622', '2026-02-03 19:16:33.663622');
INSERT INTO public.roles VALUES (4, 'L??der', 'L????der de votaci????n', '2026-02-03 19:16:33.663622', '2026-02-03 19:16:33.663622');
INSERT INTO public.roles VALUES (2, 'Admin de campa??a', 'Administrador de campa????a electoral', '2026-02-03 19:16:33.663622', '2026-02-03 19:16:33.663622');


--
-- TOC entry 5193 (class 0 OID 18115)
-- Dependencies: 237
-- Data for Name: user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5194 (class 0 OID 18123)
-- Dependencies: 238
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (6, 'nello-zabarain@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:22:42.131589', '2026-02-04 14:27:22.019409', 3);
INSERT INTO public.users VALUES (7, 'jose-macea@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:22:42.131589', '2026-02-04 14:27:22.025201', 3);
INSERT INTO public.users VALUES (8, 'alvaro-monedero@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:22:42.131589', '2026-02-04 14:27:22.049801', 3);
INSERT INTO public.users VALUES (9, 'viviana-blell@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:22:42.131589', '2026-02-04 14:27:22.128911', 3);
INSERT INTO public.users VALUES (10, 'maria-paz-gaviria@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:22:42.131589', '2026-02-04 14:27:22.135719', 3);
INSERT INTO public.users VALUES (11, 'luis-ramiro-ricardo@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:22:42.131589', '2026-02-04 14:27:22.141934', 3);
INSERT INTO public.users VALUES (3, 'digitador1@digital.com', '$2b$10$sF37bnRtFpOEZts8SztiJOR55mOUO/8OqNMMRNXsixaghG/vDOnDm', '2026-01-28 21:24:06.5636', '2026-02-04 14:30:52.230009', 5);
INSERT INTO public.users VALUES (4, 'digitador2@digital.com', '$2b$10$W3UYE.8mpDJtQ8Gzy/YoWOlqqs13eghTq7veILpg6Eo/ZFuL1BWGG', '2026-01-28 21:24:19.996363', '2026-02-04 14:30:52.341649', 5);
INSERT INTO public.users VALUES (5, 'digitador3@digital.com', '$2b$10$tQifMlHv7XKV1qZKqnK3k..a510KJGMdt2PKN26dZEnl0gnRKJRUy', '2026-01-28 21:24:31.61434', '2026-02-04 14:30:52.441108', 5);
INSERT INTO public.users VALUES (21, 'ismael-carlos-sierra-torres@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.367714', 4);
INSERT INTO public.users VALUES (22, 'nestor-enrique-garcia-arrieta@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.372046', 4);
INSERT INTO public.users VALUES (23, 'alvaro-enrique-vitola-teran@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.376021', 4);
INSERT INTO public.users VALUES (24, 'pablo-antonio-centeno-cortez@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.384489', 4);
INSERT INTO public.users VALUES (25, 'anibal-jose-gonzalez-garrido@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.388779', 4);
INSERT INTO public.users VALUES (26, 'alex-angulo-rivero@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.392955', 4);
INSERT INTO public.users VALUES (27, 'joaquin-antonio-gonzalez-contreras@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.399258', 4);
INSERT INTO public.users VALUES (28, 'betsabe-segundo-blanco-benitez@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.403241', 4);
INSERT INTO public.users VALUES (29, 'oscar-anibal-narvaez-oviedo@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.406845', 4);
INSERT INTO public.users VALUES (30, 'harlinton-garcia-barreto@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.411711', 4);
INSERT INTO public.users VALUES (31, 'carlos-roberto-araque-gamboa@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.418778', 4);
INSERT INTO public.users VALUES (32, 'jorge-luis-herrera-mendoza@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.422271', 4);
INSERT INTO public.users VALUES (33, 'jose-novoa-trujillo@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.426669', 4);
INSERT INTO public.users VALUES (34, 'fredy-antonio-jaraba-causado@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.432639', 4);
INSERT INTO public.users VALUES (35, 'jose-ricardo-rodriguez@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.437012', 4);
INSERT INTO public.users VALUES (36, 'rafael-francisco-medina-osorio@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.440447', 4);
INSERT INTO public.users VALUES (37, 'silvano-vergara-diaz@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.445529', 4);
INSERT INTO public.users VALUES (38, 'vladimir-zurita@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.452659', 4);
INSERT INTO public.users VALUES (39, 'jairo-jose-hernandez-saenz@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.456157', 4);
INSERT INTO public.users VALUES (40, 'jesus-diaz@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.46004', 4);
INSERT INTO public.users VALUES (41, 'jairo-carano@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.468271', 4);
INSERT INTO public.users VALUES (42, 'piedad-perez-peluffo@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.472307', 4);
INSERT INTO public.users VALUES (43, 'luis-gil-puentes@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.475893', 4);
INSERT INTO public.users VALUES (44, 'lina-maria-peluffo-ramirez@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.482039', 4);
INSERT INTO public.users VALUES (45, 'juan-mercado@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.488765', 4);
INSERT INTO public.users VALUES (46, 'holman-merino@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.49426', 4);
INSERT INTO public.users VALUES (47, 'admin@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 20:16:56.894276', '2026-02-04 14:27:22.501004', 1);
INSERT INTO public.users VALUES (18, 'bertonis-de-la-rosa@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.150197', 4);
INSERT INTO public.users VALUES (12, 'alejandro-de-la-ossa@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:22:42.131589', '2026-02-04 14:27:22.257584', 3);
INSERT INTO public.users VALUES (13, 'helmar-mendoza@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.325317', 4);
INSERT INTO public.users VALUES (14, 'ramiro-tapia@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.331814', 4);
INSERT INTO public.users VALUES (15, 'ferney-benitez@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.336988', 4);
INSERT INTO public.users VALUES (16, 'jonatan-betin@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.34184', 4);
INSERT INTO public.users VALUES (17, 'elson-aranates-acosta-rivero@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.352964', 4);
INSERT INTO public.users VALUES (19, 'jose-ramiro-pulgar-alvarez@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.356427', 4);
INSERT INTO public.users VALUES (20, 'gilberto-carlos-manjarres-meza@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 19:29:46.101326', '2026-02-04 14:27:22.360027', 4);
INSERT INTO public.users VALUES (48, 'admincamp@smartpol.com', '$2b$10$tyCziezWy3f3Zh/Ju6mMleYdY6LPsM0kR3QWBxE740bEQR746s.Vm', '2026-02-03 20:16:56.894276', '2026-02-04 14:27:22.505793', 2);


--
-- TOC entry 5196 (class 0 OID 18136)
-- Dependencies: 240
-- Data for Name: voters; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.voters VALUES (34, 'LUIS ALEJANDRO', 'CABALLERO RIVERO', '1047471139', 'M', 'B+', '1994-06-17', '3107124535', 'LA CONCEPCION', 'ALEXER.17@HOTMAIL.COM', 'ADMIN', 'Active', 'FLOR DEL MONTE', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (86, 'HORACION ANTONIO ', 'ORTEGA MIRANDA', '1100624970', 'M', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL3@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (198, 'ADANIES ', 'DIAZ FONSECA', '1007899608', 'M', 'A+', '2000-12-12', '3215403435', 'AVENIDA ZAMORA', 'ADDIAZ@GIMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (199, 'CANDELARIA MARIA ', 'ZABALA ALVAREZ', '65891331', 'M', 'A+', '2000-12-12', '3215403435', 'AVENIDA ZAMORA', 'CMZABALA@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (36, 'MARIA ESPERANZA ', 'MULETT TAPIA', '33283513', 'F', 'A+', '1957-08-12', '3137898118', 'LAS FLORES', 'MMULETT@GMAIL.COM', 'Trabajadora Social', 'Active', 'LAS FLORES', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (37, 'JUAN SEBASTIAN', 'RICARDO MULETT', '1101814434', 'M', 'A+', '1996-05-24', '3045876501', 'LAS FLORES', 'JRICARDO@HOTMAIL.COM', 'Ingeniero', 'Active', 'LAS FLORES', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (38, 'JUANA MARIA', 'GONZALEZ BARRIOS', '1101813013', 'F', 'O+', '2002-01-08', '3107214535', '4 DE JUNIO', 'JMGONZALEZ@GMAIL.COM', 'ESTUDIANTE', 'Active', '4 DE JUNIO', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (39, 'ORLANDA DE LAS MERCEDES', 'BARRIOS RIVERA', '42300040', 'F', 'AB+', '1950-11-18', '3015762148', '4 DE JUNIO', 'OMBARRIOS@GMAIL.COM', 'AMA DE CASA', 'Active', '4 DE JUNIO', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (40, 'NESTOR CARLOS ', 'TORRES RIVERO', '18881409', 'M', 'A+', '2000-12-12', '3015201456', '4 DE JUNIO', 'NCTORRES@GMAIL.COM', 'COMERCIANTE', 'Active', '4 DE JUNIO', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (35, 'HUGO JOSE', 'GARCIA CARDENAS', '18876424', 'M', 'O+', '2000-12-12', '3215403435', 'LAS FLORES', 'HGARCIA@HOTMAIL.COM', 'Ingeniero', 'Active', 'LAS FLORES', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (41, 'JOSE DE LA CRUZ ', 'BARRETO VILORIA', '9039200', 'M', 'A+', '2000-12-12', '3215403435', '4 DE JUNIO', 'JCBARRETO@GMAIL.COM', 'COMERCIANTE', 'Active', '4 DE JUNIO', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (42, 'ARCELIO JOSE ', 'CARDENAS VILORIA', '8920047', 'M', 'A+', '2000-12-12', '3215403435', 'VENEZUELA', 'AJCARDENAS@GMAIL.COM', 'AGRICULTOR', 'Active', 'VENEZUELA', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (46, 'LAUREN MARGARITA', 'RICARDO ROMERO', '1102795743', 'F', 'A+', '2000-12-12', '3167476843', 'LA NARI?????O', 'LMRICARDO@GMAIL.COM', 'ESTUDIANTE', 'Active', 'LA NARI?????O', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (47, 'HUGO ANDRES', 'GARCIA MULETT', '1101815359', 'M', 'A+', '2000-12-12', '3217812978', 'LA NARI?????O', 'HAGARCIA@GMAIL.COM', 'Ingeniero', 'Active', 'LA NARI?????O', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (48, 'GRACIELA DEL CARMEN ', 'ROMERO ORTEGA', '33282966', 'F', 'A+', '2000-12-12', '3116743514', 'CORAZON DE JESUS', 'GCROMERO@GMAIL.COM', 'AMA DE CASA', 'Active', 'CORAZON DE JESUS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (49, 'YESICA CAROLINA', ' GONZALEZ MEZA', '1101818971', 'F', 'A+', '2000-12-12', '3145717705', 'CORAZON DE JESUS', 'YCGONZALEZ@GMAIL.COM', 'ESTUDIANTE', 'Active', 'CORAZON DE JESUS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (50, 'JAIRO ENRIQUE ', 'GONZALEZ RIVERO', '15239162', 'M', 'A+', '2000-12-12', '3215403435', 'CORAZON DE JESUS', 'JEGONZALEZ@GMAIL.COM', 'ADMIN', 'Active', 'CORAZON DE JESUS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (51, 'GISETH ROCIO ', 'RIVERO SARMIENTO', '1005513734', 'F', 'A+', '2000-12-12', '3215403435', 'LAS FLORES', 'GRRIVERO@GMAIL.COM', 'ADMIN', 'Active', 'LAS FLORES', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (52, 'JOSE GREGORIO ', 'MU?????OZ ALVIS', '1101818337', 'M', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'JGMUNOZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (53, 'GLEDIS ', 'MARTINEZ MADRID', '64891208', 'F', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'GMADRID@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (54, 'JUAN CARLOS ', 'PEREZ MENDOZA', '18882496', 'M', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'JCPEREZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (55, 'OMAR SEGUNDO ', 'PAREDES TORRES', '18879171', 'M', 'A+', '1994-12-12', '3215403435', 'OVEJAS', 'OSPAREDES@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (56, 'ANTONIO JOSE ', 'BENITEZ BOHOQUEZ', '18879394', 'M', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'AJBENITEZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (57, 'JUAN CARLOS ', 'RIVERA RODRIGUEZ', '18879185', 'M', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'JCRIVERA@HOTMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (58, 'EULOGELIO ANTONIO', ' RIVERA GUERRA', '9306943', 'M', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'ENRIVERA@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (59, 'NURIS DEL CARMEN ', 'RODRIGUEZ BETTIN', '42201056', 'F', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'NCRODRIGUEZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (60, 'GUIDO MANUEL', ' RODRIGUEZ MERCADO', '18877566', 'M', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'GMRODRIGUEZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (61, 'RAFAEL AUGUSTO ', 'VERA RIVERO', '18880714', 'M', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'RAVERA@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (62, 'MARIO ALFONSO ', 'MONTERROZA BELTRAN', '1101819003', 'M', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'MAMONTERROZA@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (63, 'DENIS DEL SOCORRO ', 'CHAMORRO MADERA', '64893733', 'F', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'DSCHAMORRO@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (64, 'CARMELO JOSE ', 'BARRETO MADERA', '18879786', 'M', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'CJBARRETO@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (65, 'JESUS MANUEL ', 'QUIROZ MORENO', '1101819994', 'M', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'JMQUIROZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (66, 'EDGAR DAVID ', 'ARIAS FLOREZ', '92071245', 'M', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'EARIAS@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (67, 'ANA BELISA', ' GONZALEZ ARRIETA', '1066178715', 'F', 'O+', '2000-01-10', '3145646455', 'DON GABRIEL', 'AG@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (68, 'ANA ELVIRA ', 'POMARES MARTINEZ', '64891695', 'F', 'A+', '2000-12-12', '3215403435', 'OVEJAS', 'AEPOMARES@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (69, 'ALEX ENRIQUE', ' PI?????ERES PACHECO', '18882100', 'M', 'O+', '2000-01-12', '3245646455', 'SALITRAL', 'AP@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (77, 'ALEX ENRIQUE', ' PELUFFO RAMIREZ', '1101813250', 'M', 'O+', '2000-01-01', '3145646455', 'SALITRAL', 'APELUFFO@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (78, 'MARIO RAFAEL ', 'RODRIGUEZ MIRANDA', '18879289', 'M', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (80, 'MARIA DE LAS MERCEDES ', 'MIRANDA BARRETO', '23024856', 'F', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL1@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (81, 'DIANA MARCELA', ' PELUFFO RAMIREZ', '1102149075', 'F', 'O+', '2000-01-10', '3145646455', 'SALITRAL', 'APAAAAAAA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (82, 'DANIEL SEGUNDO ', 'VARGAS MARQUE', '18878846', 'M', 'O+', '2000-01-10', '3145646455', 'SALITRAL', 'APAAAAAAAC@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (83, 'EDER ENRIQUE ', 'VARGAS MARQUEZ', '18879345', 'M', 'O+', '2000-01-10', '3145646455', 'SALITRAL', 'VARGASM@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (84, 'ALCI RAFAEL ', 'ORTEGA PRIETO ', '18880357', 'M', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL2@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (85, 'ANTONIO JOSE ', 'GARCIA NU?????EZ', '9112267', 'M', 'O+', '2000-01-10', '3145646455', 'SALITRAL', 'GARCIA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (262, 'Jeferson ', 'Gonz?????lez Zabala', '1102148559', 'M', NULL, NULL, NULL, 'OVEJAS', 'JGONZALEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:40:07.854018', '2026-02-02 18:40:07.854018');
INSERT INTO public.voters VALUES (87, 'YENFER DAVID ', 'FERNANDEZ RODRIGUEZ', '1103111770', 'M', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL4@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (88, 'ELKIN RAFAEL ', 'PELUFFO RAMIREZ', '18882682', 'M', 'O+', '2000-01-10', '3145646455', 'SALITRAL', 'PELUFFO@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (89, 'DILIA ROSA ', 'RODRIGUEZ MIRANDA', '1101813956', 'M', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL5@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (90, 'LUIS GABRIEL ', 'NARVAEZ BARBOZA', '1002072375', 'M', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL6@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (91, 'MARELIS SENITH ', 'ARRIETA VERGARA', '1052083086', 'F', 'O+', '2000-01-10', '3145646455', 'SALITRAL', 'ARRIETA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (92, 'JOHANNA PATRICIA', ' VASQUEZ RODRIGUEZ', '1101816469', 'F', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL7@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (93, 'JAIRO ALFONSO', ' VASQUEZ RODRIGUEZ', '1101818795', 'M', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL8@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (96, 'COSME RAFAEL ', 'PELUFFO MARQUEZ', '73566131', 'M', 'O+', '2000-01-10', '3145646455', 'SALITRAL', 'ACPELUFFO@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (97, 'SANDRA PATRICIA ', 'PEREZ MEDINA', '1050277263', 'F', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL9@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (98, 'HOLMAN ENRIQUE ', 'MERI?????O ARAUJO', '72271001', 'M', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL10@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (99, 'JORGE LUIS ', 'PIANETA CHAMORRO', '18876518', 'M', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL11@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (100, 'ANUAR SEGUNDO ', 'TAPIAS BARRIOS', '18881276', 'M', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL12@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (101, 'EUNICE MARIA ', 'TAPIA NAVARRO', '64894221', 'F', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL13@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (103, 'ADANA SOFIA ', 'LOPEZ MALDONADO', '1101812485', 'F', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL14@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (104, 'SAYOHA SOFIA', ' LOPEZ MALDONADO', '1100306627', 'F', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL15@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (105, 'JORGE ANDRES ', 'MALDONADO HENAO', '1101815088', 'M', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL16@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (106, 'SANDRID YOHANA ', 'RODRIGUEZ MIRANDA', '1101814447', 'F', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL17@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (107, 'MILENA PATRICIA ', 'MALDONADO JIMENEZ', '32909153', 'M', 'A+', '2000-12-12', '3215403435', 'DON GABRIEL', 'DONGABRIEL18@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (108, 'ELIZABETH MARGOS ', ' RAMIREZ GARCIA ', '64450715', 'F', 'O+', '2000-01-10', '3145646455', 'SALITRAL', 'RAMIREZ@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (113, 'JOSE MIGUEL ', 'LOPEZ RODRIGUEZ', '18878550', 'M', 'O+', '2000-01-10', '3145646455', 'DON GABRIEL', 'LOPEZ@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (110, 'DEICY LUZ ', 'PELUFFO RAMIREZ', '1101812394', 'F', 'O+', '2000-01-10', '3145646455', 'SALITRAL', 'APELUFFORAMIREZ@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (111, 'ALEXANDER MANUEL ', 'CARDENAS PEREZ', '1066180470', 'M', 'O+', '2000-01-10', '3145646455', 'DON GABRIEL', 'CARDENAS@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (109, 'LUIS ARMANDO ', 'PELUFFO RAMIREZ', '1101818456', 'M', 'O+', '2000-01-10', '3145646455', 'SALITRAL', 'PELUFFORAMIREZ@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (112, 'JESUS MANUEL', ' VASQUEZ MANJARREZ', '1005488270', 'M', 'O+', '2000-01-10', '3145646455', 'DON GABRIEL', 'VASQUEZ@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (114, 'KETTY ENITH ', 'MALDONADO JIMENEZ', '64891900', 'F', 'O+', '2000-01-10', '3145646455', 'DON GABRIEL', 'MALDOADO@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (115, 'JUAN JOSE ', 'LOPEZ MALDONADO', '1101813749', 'M', 'O+', '2000-01-10', '3145646455', 'DON GABRIEL', 'APLOPEZ@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (118, 'LILIBETH ', ' LOPEZ MALDONADO', '1101816619', 'F', 'O+', '2000-01-10', '3145646455', 'DON GABRIEL', 'APLOPEZA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (119, 'CRISTIAN JESUS ', 'GONZALEZ COGOLLO', '1003066291', 'M', 'O+', '2000-01-10', '3146592131', 'DON GABRIEL', 'APGONZALEZ@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (120, 'RICARDO JOSE ', 'JIMENEZ MENDOZA', '1148439681', 'M', 'O+', '2000-01-10', '3146592131', 'DON GABRIEL', 'APJIMENEZ@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (121, 'DANIEL ANTONIO ', 'VELILLA MANJARRES', '73551553', 'M', 'O+', '2000-01-10', '3146592131', 'DON GABRIEL', 'APVELILLA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (123, 'LUIS ALBERTO ', 'VASQUEZ RODRIGUEZ', '1101812246', 'M', 'O+', '2025-01-10', '3146592131', 'DON GABRIEL', 'APVASQUEZ@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (126, 'CAMILA ANDREA ', 'VELILLA LOPEZ', '1102148384', 'F', 'O+', '2000-01-10', '3146592131', 'DON GABRIEL', 'APVELILLAA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (127, 'DUVAN DAVID ', 'VASQUEZ RODRIGUEZ', '1101819655', 'M', 'O+', '2000-01-10', '3146592131', 'DON GABRIEL', 'APVASQUEZZ@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (128, 'MANUEL ANTONIO ', 'CARDENAS RODRIGUEZ', '3921085', 'M', 'O+', '2000-01-10', '3146592131', 'DON GABRIEL', 'APCARDENAS@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (129, 'ALIS MARINA ', 'PEREZ SUAREZ', '25911181', 'F', 'O+', '2000-01-10', '3042444668', 'DON GABRIEL', 'APPEREZ@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (136, 'JOSE DE JESUS ', 'GONZALEZ JIMENEZ', '15031922', 'M', 'O+', '2000-01-10', '3146592131', 'DON GABRIEL', 'APGONZALEZZ@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (137, 'ARGEMIRO RAFAEL ', 'RIVERA HERRERA', '3921187', 'M', 'O+', '2000-01-10', '3146592131', 'DON GABRIEL', 'APRIVERA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (140, 'LUZ MARINA ', 'CARDENAS OVIEDO', '1101812566', 'F', 'O+', '2000-01-10', '3146592131', 'DON GABRIEL', 'APCARDENASS@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (141, 'RAFAEL ANTONIO', ' MONTERROZA RICARDO', '1101812423', 'M', 'O+', '2000-01-10', '3146592131', 'DON GABRIEL', 'APMONTERROZA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (144, 'KELLY JOHANA ', 'LOPEZ MALDONADO', '64894712', 'F', 'O+', '2000-01-10', '3146592131', 'DON GABRIEL', 'APLOPEZZ@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (145, 'LINA MARIA ', 'PELUFFO RAMIREZ', '1101814341', 'F', 'O+', '2000-01-10', '3146592131', 'DON GABRIEL', 'APPELUFFO@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (146, 'CECILIA MERCEDES', 'TOSCANO MEZA', '1101813613', 'F', 'O+', '2000-01-10', '3147053505', 'LA PRADERA', 'APTOSCANO@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (147, 'GLENIS MARGARITA', 'JARABA PE?????A', '22786662', 'F', 'O+', '2000-01-10', '3146592131', 'LAS FLORES', 'APJARABA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (148, 'ELIDA DEL SOCORRO', 'PE?????A BLANCO', '23020265', 'F', 'O+', '2000-01-10', '3146592131', 'LAS FLORES', 'APPENA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (150, 'GABRIEL EDUARDO', 'CARDENAS ATENCIO', '18011630', 'M', 'O+', '2026-01-10', '3146592131', 'ACUABOL', 'APCARDENAAS@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (151, 'VANESSA PAOLA', 'RICARDO RICARDO', '1143466682', 'F', 'O+', '2000-01-10', '3012452772', 'VILLA PAZ', 'APRICARDOA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (152, 'MARIA CLAUDIA', 'ACOSTA HUERTAS', '1005488813', 'F', 'O+', '2000-01-10', '3224718880', 'VILLA PAZ', 'APACOATA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (153, 'MARIA DE LAS MERCEDES', 'MENDOZA ACOSTA', '64892182', 'F', 'O+', '2000-01-10', '3137006705', 'VILLA PAZ', 'APMENDOZA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (154, 'LILIA ELVIRA', 'ATENCIA AVILA', '64892454', 'F', 'O+', '2000-01-10', '3022482106', 'CIUDADELA', 'APAATENCIAA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (155, 'FABIAN DAVID', 'BUELVAS ATENCIA', '1101817299', 'M', 'O+', '2000-01-10', '3008522210', 'CIUDADELA', 'AP@UELVASGMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (156, 'YISETH PAOLA', 'MERCADO RICARDO', '1101812707', 'F', 'O+', '2000-01-10', '3234741503', 'VILLA PAZ', 'APMERCADO@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (157, 'JESUS DAVID', 'BUELVAS ATENCIA', '1005488310', 'M', 'O+', '2000-01-10', '3146592131', 'CIUDADELA', 'APBBUELVAS@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (158, 'GILBERTO ANTONIO', 'BUELVASBOLA?????O', '18876024', 'M', 'O+', '2000-01-10', '3146592131', 'CIUDADELA', 'APUELVAS@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (159, 'RODRIGO ANTONIO', 'BUSTAMANTE ACOSTA', '18877478', 'M', 'O+', '2000-01-10', '3146592131', 'ALMAGRA', 'APBUSTAMANTE@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (160, 'CANDELARIA DEL CARMEN', 'BELTRAN CAEZ', '33207380', 'F', 'O+', '2000-01-10', '3147341925', 'ALMAGRA', 'APENLTR@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (161, 'WILLIAM ANTONIO', 'ACOSTA', '18878426', 'M', 'O+', '2000-01-10', '3232993648', 'ALMAGRA', 'APACOSTA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (162, 'OSVALDO RAFAEL ', 'MARTINEZ CHAMORRO', '18879302', 'M', 'A+', '2000-12-12', '3215403435', 'LAS FLORES', 'ORMARTINEZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (163, 'HERLINDA MARIA ', 'CHAMORRO BARRETO', '23023501', 'F', 'A+', '2000-12-12', '3215403435', 'LAS FLORES', 'HMCHAMORRO@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (164, 'OSMAN MIGUEL ', 'BARRETO OLIVERA', '18882338', 'M', 'A+', '2000-12-12', '3215403435', 'LA REPRESA', 'HMBARRETO@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (165, 'MIGUEL ANTONIO', 'BARRETO PEREZ', '92070124', 'M', 'A+', '2000-12-12', '3215403435', 'LA REPRESA', 'MABARRETO@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (166, 'AMPARO MARIA ', 'BARRETO ROCHA', '1005488975', 'F', 'A+', '2000-12-12', '3215403435', 'LA REPRESA', 'AMBARRETO@HOTMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (167, 'MISLEIDI MARIA', 'GARCIA MEDINA', '1005489264', 'F', 'A+', '2000-12-12', '3215403435', 'LA REPRESA', 'MMGARCIA@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (168, 'LEONARDO DEL CARMEN ', 'BARRETO ROCHA', '1005488382', 'M', 'A+', '2000-12-12', '3215403435', 'LA REPRESA', 'LCBARRETO@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (169, 'MISAEL RODRIGO ', 'MENDOZA BUELVAS', '18877745', 'M', 'A+', '2000-12-12', '3215403435', 'LA REPRESA', 'MRMENDOZA@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (170, 'DONALDO JAVIER ', 'BARRETO OLIVERA', '73432140', 'M', 'A+', '2000-12-12', '3215403435', 'LA REPRESA', 'DJBARRETO@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (171, 'FARIDES MARIA ', 'OLIVERA DE BARRETO', '22898800', 'F', 'A+', '2000-12-12', '3215403435', 'LA REPRESA', 'FMOLIVERA@HOTMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (174, 'JUAN DAVID', 'ACOSTA HUERTAS', '1101813827', 'M', 'O+', '2000-01-10', '3146592131', 'ALMAGRA', 'APACOSTAA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (175, 'DEIVIS ANTONIO ', 'CONTRERA BARRETO', '1007139117', 'M', 'A+', '2000-12-12', '3215403435', 'LA REPRESA', 'DACONTRERA@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (176, 'MARGELIS DEL CARMEN', 'HUERTAS DIAZ', '64895270', 'F', 'O+', '2000-01-10', '3146592131', 'ALMAGRA', 'APHUETAS@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (177, 'CARMEN ELENA ', 'BOHORQUEZ BLANCO', '1192732436', 'M', 'A+', '2000-12-12', '3215403435', 'LA REPRESA', 'CEBOHORQUEZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (178, 'JEIDIS PATRICIA', 'TOVAR BLANCO', '1077085082', 'F', 'O+', '2000-01-10', '3207343160', 'SAN MARTIN', 'APTOVAR@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (179, 'PABLO ENRIQUE ', 'RIVERO ALFARO', '18875432', 'M', 'A+', '2000-12-12', '3215403435', 'LAS FLORES', 'PERIVERO@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (180, 'GLENIS MARGOTH', 'VERGARA', '64893502', 'F', 'O+', '2000-01-10', '3146592131', 'SAN JOSE', 'APVERGARA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (181, 'GEOMARIS ESTER ', 'MARTINEZ CHAMORRO', '23023707', 'M', 'A+', '2000-12-12', '3215403435', 'LAS FLORES', 'GEMARTINEZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (182, 'LEIVIS JAIR ', 'RIVERO SARMIENTO', '64895670', 'M', 'A+', '2000-12-12', '3215403435', 'LAS FLORES', 'LJRIVERO@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (183, 'PABLO JOSE ', 'RIVERO MARTINEZ', '1101815125', 'M', 'A+', '2000-12-12', '3215403435', 'LAS FLORES', 'PJRIVERO@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (184, 'ANA LUZ ', 'RIVERO MARTINEZ', '1101815103', 'F', 'A+', '2000-12-12', '3215403435', 'LAS FLORES', 'ALRIVERO@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (185, 'OSCAR OSVALDO ', 'OLIVERA SEVILLA', '1101818846', 'M', 'A+', '2000-12-12', '3215403435', 'FLOR DEL MONTE', 'OOOLIVERA@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (186, 'ANA CAROLINA ', 'GONZALEZ ANDRADE', '1007183806', 'M', 'A+', '2000-12-12', '3215403435', 'AVENIDA ZAMORA', 'ACGONZALEZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (187, 'OLGA PATRICIA ', 'ANDRADE PONCE', '64893399', 'M', 'A+', '2000-12-12', '3215403435', 'SAN JOSE', 'APANDRADE@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (188, 'JUAN SEBASTIAN ', 'BURGOS QUIROZ', '1103496776', 'M', 'A+', '2000-12-12', '3215403435', 'AVENIDA ZAMORA', 'JSBURGOS@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (189, 'MARIA CAROLINA ', 'FONTAVO FONTALVO', '1079916016', 'M', 'A+', '2000-12-12', '3215403435', 'SAN JOSE', 'MCFONTALVO@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (190, 'ANDRES MANUEL ', 'DIAZ FONSECA', '1051657899', 'M', 'A+', '2000-12-12', '3215403435', 'AVENIDA ZAMORA', 'AMDIAZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (122, 'VANESSA DEL CARMEN', ' DE LA ROSA CARDENAS', '64702683', 'F', 'O+', '2000-01-10', '3146592131', 'DON GABRIEL', 'APDELAROSA@GMAIL.COM', 'EST', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-01 18:02:29.463402', '2026-02-01 18:02:29.463402');
INSERT INTO public.voters VALUES (259, 'Luz Marina ', 'Salgado Romero', '64894003', 'F', NULL, NULL, NULL, 'EL COSO', 'LMSALGADO@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:47:56.969031', '2026-02-02 17:47:56.969031');
INSERT INTO public.voters VALUES (204, 'EDUARDO ANTONIO', 'GARCIA GARCIA', '72007579', 'M', NULL, '2000-01-01', '3102065840', 'SAN ANTONIO', 'correo@dominio.com', 'Independiente', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 13:36:45.518079', '2026-02-02 13:41:14.003265');
INSERT INTO public.voters VALUES (205, 'ALVARO JOSE ', 'FLOREZ POMARES', '8920095', 'M', 'A+', '2000-12-12', NULL, 'BOCACANOA', 'AJFLOREZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:16:08.027106', '2026-02-02 16:16:08.027106');
INSERT INTO public.voters VALUES (206, 'LUZ DELLIS ', 'FERNANDEZ RIVERO', '1101817422', 'F', 'A+', '2000-12-12', NULL, 'BOCACANOA', 'LDFERNANDEZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:18:16.345141', '2026-02-02 16:18:16.345141');
INSERT INTO public.voters VALUES (207, 'SIRLI JUDITH ', 'NAVARRO RORRES', '45647493', 'F', 'A+', NULL, NULL, 'PLAZA DE LA CRUZ', 'SJNAVARRO@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:21:10.422523', '2026-02-02 16:21:10.422523');
INSERT INTO public.voters VALUES (208, 'ALEJANDRO ENRIQUE ', 'MARQUEZ PATERNINA', '18878183', 'M', 'A+', NULL, NULL, 'PLAZA DE LA CRUZ', 'AEMARQUEZ@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:22:26.303565', '2026-02-02 16:22:26.303565');
INSERT INTO public.voters VALUES (209, 'JOSUE DAVID ', 'VERGARA ARROYO', '1101815536', 'M', NULL, NULL, NULL, 'PLAZA DE LA CRUZ', 'JDVERGARA@GMAIL.COM', 'ADMIN', 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:23:48.919868', '2026-02-02 16:23:48.919868');
INSERT INTO public.voters VALUES (210, 'KEILA BERENICE ', 'MARTINEZ MARQUEZ', '1073243962', 'F', NULL, NULL, NULL, 'PLAZA DE LA CRUZ', 'KBMARTINEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:25:05.642801', '2026-02-02 16:25:05.642801');
INSERT INTO public.voters VALUES (227, 'JOSE VICENTE ', 'PALACIO MERCADO', '18775947', 'M', NULL, NULL, NULL, 'LAS BABILLAS', 'JVPALACIO@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:57:01.419329', '2026-02-02 16:57:01.419329');
INSERT INTO public.voters VALUES (228, 'ALVARO ALEJANDRO ', 'GALVIS GARCIA', '80177993', 'M', NULL, NULL, NULL, 'SINCELEJO', 'AAGALVIS@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:58:18.752633', '2026-02-02 16:58:18.752633');
INSERT INTO public.voters VALUES (229, 'NESTOR GUILLERMO', ' MU?????OZ ARROYO', '3918363', 'M', NULL, NULL, NULL, 'LAS BABILLAS', 'NGMU?????OZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:59:20.599565', '2026-02-02 16:59:20.599565');
INSERT INTO public.voters VALUES (230, 'HUGO RAFAEL ', 'BENITEZ MENDOZA', '18876204', 'M', NULL, NULL, NULL, 'LA MARIA', 'HRBENITEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:00:38.848899', '2026-02-02 17:00:38.848899');
INSERT INTO public.voters VALUES (231, 'ORLANDO MANUEL', ' MARTINEZ MENDOZA', '18876049', 'M', NULL, NULL, NULL, 'SANTAFE', 'OMMARTINEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:01:50.74457', '2026-02-02 17:01:50.74457');
INSERT INTO public.voters VALUES (232, 'YANELIS TATIANA ', 'ROBLES MENDOZA', '1101814857', 'F', NULL, NULL, NULL, 'SANTAFE', 'YTROBLES@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:03:45.516177', '2026-02-02 17:03:45.516177');
INSERT INTO public.voters VALUES (233, 'MELISSA LINEY ', 'MARTINEZ BALDOVINO', '1192732424', 'F', NULL, NULL, NULL, 'SANTAFE', 'MLMARTINEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:05:08.97913', '2026-02-02 17:05:08.97913');
INSERT INTO public.voters VALUES (234, 'GERALDINE ', 'ROBLES MENDOZA', '1101814388', 'F', NULL, NULL, NULL, 'SANTAFE', 'GEROBLES@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:07:04.814731', '2026-02-02 17:07:04.814731');
INSERT INTO public.voters VALUES (235, 'ALVARO JOSE ', 'MARTINEZ MENDOZA', '18880190', 'M', NULL, NULL, NULL, 'SANTAFE', 'AJMARTINEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:08:11.717113', '2026-02-02 17:08:11.717113');
INSERT INTO public.voters VALUES (237, 'MISAEL SEGUNDO ', 'MARTINEZ MENDOZA', '18879941', 'M', NULL, NULL, NULL, 'SANTAFE', 'MSMARTINEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:10:15.910289', '2026-02-02 17:10:15.910289');
INSERT INTO public.voters VALUES (238, 'FLORELIA ', 'ALFARO CARO', '64894328', 'F', NULL, NULL, NULL, 'LA PE?????A', 'FLALFARO@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:14:03.928869', '2026-02-02 17:14:03.928869');
INSERT INTO public.voters VALUES (239, 'STEFANNY LUCIA ', 'PADILLA LOPEZ', '1193077206', 'M', NULL, NULL, NULL, 'LA PE?????A', 'SLPADILLA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:15:03.202152', '2026-02-02 17:15:03.202152');
INSERT INTO public.voters VALUES (240, 'CARMEN SOFIA', ' GARCIA CONTRERAS', '23183837', 'F', NULL, NULL, NULL, 'LA PE?????A', 'CSGARCIA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:15:59.811088', '2026-02-02 17:15:59.811088');
INSERT INTO public.voters VALUES (241, 'NAYIBIS ', 'OLIVERA CARDENAS', '64895440', 'F', NULL, NULL, NULL, 'LA PE?????A', 'NAOLIVERA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:17:02.527177', '2026-02-02 17:17:02.527177');
INSERT INTO public.voters VALUES (242, 'EDILBERTO RAFAEL ', 'GONZALEZ ALTAMAR', '19611898', 'M', NULL, NULL, NULL, 'LA PE?????A', 'ERGONZALEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:17:59.636384', '2026-02-02 17:17:59.636384');
INSERT INTO public.voters VALUES (243, 'LUIS MIGUEL ', 'MERCADO MU?????OZ', '18881258', 'M', NULL, NULL, NULL, 'LA PE?????A', 'LMMERCADO@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:18:49.815886', '2026-02-02 17:18:49.815886');
INSERT INTO public.voters VALUES (244, 'REINALDO DE JESUS ', 'URUETA CHAMORRO', '1101820828', 'M', NULL, NULL, NULL, 'OVEJAS', 'RJURUETA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:19:47.981512', '2026-02-02 17:19:47.981512');
INSERT INTO public.voters VALUES (245, 'MARIA FERNANDA ', 'MENDOZA OLIVERA', '1103214751', 'F', NULL, NULL, NULL, 'OVEJAS', 'MFMENDOZA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:20:53.313176', '2026-02-02 17:20:53.313176');
INSERT INTO public.voters VALUES (246, 'GABRIEL ENRIQUE  ', 'MANJARRES PARRA', '3921141', 'M', NULL, NULL, NULL, 'OVEJAS', 'GEMANJARREZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:21:49.587862', '2026-02-02 17:21:49.587862');
INSERT INTO public.voters VALUES (247, 'JORGE LUIS ', 'LOPEZ ECHAVEZ', '18882054', 'M', NULL, NULL, NULL, 'LA PRADERA', 'JLLOPEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:24:57.635984', '2026-02-02 17:24:57.635984');
INSERT INTO public.voters VALUES (248, 'LUIS ENRIQUE ', 'BENITEZ TRONCOSO', '18876108', 'M', NULL, NULL, NULL, 'EL PALMAR', 'LEBENITEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:27:35.024232', '2026-02-02 17:27:35.024232');
INSERT INTO public.voters VALUES (249, 'PATRICIA ELENA ', 'TORRES CONDE', '1101815471', 'F', NULL, NULL, NULL, 'EL PALMAR', 'PETORRES@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:29:23.262681', '2026-02-02 17:29:23.262681');
INSERT INTO public.voters VALUES (250, 'YARLEIDIS ISABEL ', 'RODRIGUEZ GONZALEZ', '64895381', 'F', NULL, NULL, NULL, '21 DE FEBRERO', 'YIRODRIGUEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:30:25.622926', '2026-02-02 17:30:25.622926');
INSERT INTO public.voters VALUES (251, 'WILLIAM DE JESUS ', 'TOVAR BLANCO', '18878715', 'M', NULL, NULL, NULL, '21 DE FEBRERO', 'WJTOVAR@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:32:45.401693', '2026-02-02 17:32:45.401693');
INSERT INTO public.voters VALUES (252, 'JESUALDO ', 'TOVAR RODRIGUEZ', '1101814040', 'M', NULL, NULL, NULL, '21 DE FEBRERO', 'JETOVAR@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:33:51.652736', '2026-02-02 17:33:51.652736');
INSERT INTO public.voters VALUES (253, 'WILLIAM DE JESUS ', 'TOVAR RODRIGUEZ', '1101812598', 'F', NULL, NULL, NULL, '21 DE FEBRERO', 'WJTOCAR@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:35:08.046523', '2026-02-02 17:35:08.046523');
INSERT INTO public.voters VALUES (254, 'NAYERLIS ', 'TOVAR RODRIGUEZ', '1010154237', 'F', NULL, NULL, NULL, '21 DE FEBRERO', 'NATOVAR@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:36:02.119222', '2026-02-02 17:36:02.119222');
INSERT INTO public.voters VALUES (255, 'LISNEY SOFIA ', 'FUNEZ OLIVERA', '1005489129', 'F', NULL, NULL, NULL, 'VILLA PAZ', 'LSFUNEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:37:04.986785', '2026-02-02 17:37:04.986785');
INSERT INTO public.voters VALUES (256, 'Ramona Isabel ', 'Yepez Beltr?????n', '64890325', 'F', NULL, NULL, NULL, 'EL COSO', 'RIYEPEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:42:52.052304', '2026-02-02 17:42:52.052304');
INSERT INTO public.voters VALUES (257, 'Miriam del Carmen ', 'Castillo Yepez', '64892681', 'F', NULL, NULL, NULL, 'EL COSO', 'MCCASTILLO@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:45:53.984146', '2026-02-02 17:45:53.984146');
INSERT INTO public.voters VALUES (258, 'Juan Carlos ', 'Castillo Yepez', '18879531', 'M', NULL, NULL, NULL, 'EL COSO', 'JCCASTILLO@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:46:54.811187', '2026-02-02 17:46:54.811187');
INSERT INTO public.voters VALUES (260, 'Deyci Janeth', ' Castillo Yepez', '1101812808', 'F', NULL, NULL, NULL, 'EL COSO', 'DJCASTILLO@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:49:02.91981', '2026-02-02 17:49:02.91981');
INSERT INTO public.voters VALUES (261, ' Betty Rocio ', 'Castillo Yepez', '1101815897', 'F', NULL, NULL, NULL, 'EL COSO', 'BRCASTILLO@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:13:06.063071', '2026-02-02 18:13:06.063071');
INSERT INTO public.voters VALUES (263, 'Yulenis Margarita ', 'Ortiz Guerra', '1101821059', 'F', NULL, NULL, NULL, 'OVEJAS', 'YMORTIZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:42:44.747052', '2026-02-02 18:42:44.747052');
INSERT INTO public.voters VALUES (236, 'JOSE DAVID ', 'MARTINEZ BALDOVINO', '1005488076', 'M', NULL, NULL, NULL, 'SANTAFE', 'JDMARTINEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 17:09:14.463091', '2026-02-02 17:09:14.463091');
INSERT INTO public.voters VALUES (264, 'Deimer De Jesus ', 'Guerra Zabala', '1101816346', 'M', NULL, NULL, NULL, 'OVEJAS', 'DJGUERRA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:44:23.777226', '2026-02-02 18:44:23.777226');
INSERT INTO public.voters VALUES (265, 'Leonel David ', 'Guerra Zabala', '1101815348', 'M', NULL, NULL, NULL, 'OVEJAS', 'LDGUERRA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:47:05.041383', '2026-02-02 18:47:05.041383');
INSERT INTO public.voters VALUES (266, 'Silvia Mileth ', 'Zabala Pe??????ate', '64893865', 'F', NULL, NULL, NULL, 'OVEJAS', 'SMZABALA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:48:11.526415', '2026-02-02 18:48:11.526415');
INSERT INTO public.voters VALUES (267, 'Jeimy ', 'Zabala Pe??????ate', '1101813033', 'F', NULL, NULL, NULL, 'OVEJAS', 'JEZABALA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:49:13.447375', '2026-02-02 18:49:13.447375');
INSERT INTO public.voters VALUES (268, 'Guillermo Segundo ', 'De avila Paternina', '92153759', 'M', NULL, NULL, NULL, 'OVEJAS', 'GSDEAVILA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:50:17.652122', '2026-02-02 18:50:17.652122');
INSERT INTO public.voters VALUES (269, 'Acenet Maria ', 'Caraballo Guerra', '64893630', 'F', NULL, NULL, '3113823390', 'OVEJAS', 'AMCABARALLO@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:51:25.848267', '2026-02-02 18:51:25.848267');
INSERT INTO public.voters VALUES (270, 'Damis De Jesus ', 'Zabala Pe??????ate', ' 18879798', 'M', NULL, NULL, '3113823390', 'OVEJAS', 'DJZABALA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:52:41.218168', '2026-02-02 18:52:41.218168');
INSERT INTO public.voters VALUES (271, 'Lili Tatiana ', 'Zabala Pe??????ate', '64891579', 'F', NULL, NULL, '3006347652', 'OVEJAS', 'LTZABALA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:53:39.367512', '2026-02-02 18:53:39.367512');
INSERT INTO public.voters VALUES (272, 'Armando Rafael ', 'S?????nchez Buelvas', '18876523', 'M', NULL, NULL, '3006347652', 'OVEJAS', 'ARSANCHEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:54:59.151351', '2026-02-02 18:54:59.151351');
INSERT INTO public.voters VALUES (273, 'Erica Johana ', 'Paternina Mendoza', '64895373', 'F', NULL, NULL, NULL, 'LAS BABILLAS', 'EJPATERNINA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:57:35.479321', '2026-02-02 18:57:35.479321');
INSERT INTO public.voters VALUES (274, 'Lina Marcela ', 'S?????nchez Paternina', '1005488509', 'F', NULL, NULL, NULL, 'LAS BABILLAS', 'LMSANCHEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:58:34.088269', '2026-02-02 18:58:34.088269');
INSERT INTO public.voters VALUES (275, 'Iv?????n Jose ', 'Herazo Luna', '18879940', 'M', NULL, NULL, NULL, 'LAS BABILLAS', 'IJHERAZO@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 18:59:34.913172', '2026-02-02 18:59:34.913172');
INSERT INTO public.voters VALUES (276, 'Wendi Loraine ', 'S?????nchez Paternina', '1005488979', 'M', NULL, NULL, NULL, 'LAS BABILLAS', 'WLSANCHEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:00:30.524677', '2026-02-02 19:00:30.524677');
INSERT INTO public.voters VALUES (277, 'Amerley De Jesus ', 'Zabala pe??????ate', '64892438', 'M', NULL, NULL, NULL, 'OVEJAS', 'AJZABALA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:01:38.31493', '2026-02-02 19:01:38.31493');
INSERT INTO public.voters VALUES (278, 'Emerson ', 'Arrieta Zabala', '1005487995', 'M', NULL, NULL, '3017375558', 'OVEJAS', 'EMARRIETA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:02:56.237776', '2026-02-02 19:02:56.237776');
INSERT INTO public.voters VALUES (280, 'Luis Carlos ', 'Zabala Luna', '3918450', 'M', NULL, NULL, '3205120142', 'OVEJAS', 'LCZABALA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:05:03.006115', '2026-02-02 19:05:03.006115');
INSERT INTO public.voters VALUES (281, 'Luz Elayne ', 'Gonz?????lez Marquez', '1005488603', 'F', NULL, NULL, '3017375558', 'OVEJAS', 'LEGONZALEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:06:07.926845', '2026-02-02 19:06:07.926845');
INSERT INTO public.voters VALUES (282, 'Antonio Jos????? ', 'Montes Jimenez', '18878433', 'M', NULL, NULL, '3248179462', 'OVEJAS', 'AJMONTES@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:07:18.433283', '2026-02-02 19:07:18.433283');
INSERT INTO public.voters VALUES (283, 'Vicente Jos????? ', 'Jimenez Mesa', '18876121', 'M', NULL, NULL, '3241288015', 'LA PE?????A', 'VJJIMENEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:08:28.538286', '2026-02-02 19:08:28.538286');
INSERT INTO public.voters VALUES (284, 'Mario Rafael ', 'Arrieta Zabala', '3860516', 'M', NULL, NULL, '3147727908', 'LA PE?????A', 'MRARRIETA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:10:46.98875', '2026-02-02 19:10:46.98875');
INSERT INTO public.voters VALUES (285, 'Luis Alberto ', 'Jimenez Montez', '18876300', 'M', NULL, NULL, '3502673768', 'LA PE?????A', 'LAJIMENEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:11:48.125713', '2026-02-02 19:11:48.125713');
INSERT INTO public.voters VALUES (286, 'Francisco Jos????? ', 'Martinez Vargas', '18880550', 'M', NULL, NULL, NULL, 'OVEJAS', 'FJMARTIENEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:15:02.067662', '2026-02-02 19:15:02.067662');
INSERT INTO public.voters VALUES (287, 'Ana Maria ', 'Munzon Osorio', '64894156', 'F', NULL, NULL, NULL, 'OVEJAS', 'AMMUNZON@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:16:02.664531', '2026-02-02 19:16:02.664531');
INSERT INTO public.voters VALUES (289, 'Antonio Jos????? ', 'Martinez Munzon', '1005488432', 'M', NULL, NULL, NULL, 'OVEJAS', 'AJMARTINEZM@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:24:30.567166', '2026-02-02 19:24:30.567166');
INSERT INTO public.voters VALUES (291, 'Maricela ', 'Vargas Mendoza', '64892304', 'F', NULL, NULL, NULL, 'OVEJAS', 'MAVARGAS@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:25:30.064467', '2026-02-02 19:25:30.064467');
INSERT INTO public.voters VALUES (292, 'Francisco Tomas ', 'Martinez Corrales', '18876384', 'M', NULL, NULL, NULL, 'OVEJAS', 'FMARTINEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:28:18.410152', '2026-02-02 19:28:18.410152');
INSERT INTO public.voters VALUES (293, 'Tomas Alfonso ', 'Martinez Vargas', '1101812045', 'M', NULL, NULL, NULL, 'OVEJAS', 'TAMARTINEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:29:55.11628', '2026-02-02 19:29:55.11628');
INSERT INTO public.voters VALUES (294, 'Carlos Farid ', 'Martinez Martinez', '1101813242', 'M', NULL, NULL, NULL, 'OVEJAS', 'CFMARTINEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:31:08.81135', '2026-02-02 19:31:08.81135');
INSERT INTO public.voters VALUES (295, 'Glenis Del Rosario ', 'Martinez Vargas', '64720753', 'F', NULL, NULL, NULL, 'OVEJAS', 'GRMARTINEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:32:30.324993', '2026-02-02 19:32:30.324993');
INSERT INTO public.voters VALUES (296, 'Javier Segundo', ' C?????rdenas Solis', '1005604858', 'M', NULL, NULL, NULL, NULL, 'JSCARDENAS@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:33:17.530789', '2026-02-02 19:33:17.530789');
INSERT INTO public.voters VALUES (298, 'Madys Del Rosario ', 'Olivera Salgado', '64893147', 'F', NULL, NULL, NULL, 'OVEJAS', 'MROLIVERA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:37:09.81741', '2026-02-02 19:37:09.81741');
INSERT INTO public.voters VALUES (211, 'VICTOR ALFONSO ', 'HERAZO LUNA', '18882678', 'M', NULL, NULL, NULL, 'LAS BABILLAS', 'VAHERAZO@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:26:30.440364', '2026-02-02 16:26:30.440364');
INSERT INTO public.voters VALUES (212, 'JUAN CARLOS ', 'MARTINEZ FERIA', '18880386', 'M', NULL, NULL, NULL, 'LAS BABILLAS', 'JCMARTINEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:27:45.957496', '2026-02-02 16:27:45.957496');
INSERT INTO public.voters VALUES (213, 'YAIR JOSE ', 'SANCHEZ MEJIA', '1103216168', 'M', NULL, NULL, NULL, 'LAS BABILLAS', 'YJSANCHEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:28:55.022704', '2026-02-02 16:28:55.022704');
INSERT INTO public.voters VALUES (214, 'ALFREDIS DE JESUS ', 'SANCHEZ FERIA', '3842764', 'M', NULL, NULL, NULL, 'LAS BABILLAS', 'AJSANCHEZ@HOTMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:33:45.81929', '2026-02-02 16:33:45.81929');
INSERT INTO public.voters VALUES (215, 'EUCLIDES ', 'VILLALOBOS URUETA', '6817160', 'M', NULL, NULL, NULL, 'LAS BABILLAS', 'EUVILLALOBOS@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:35:02.227139', '2026-02-02 16:35:02.227139');
INSERT INTO public.voters VALUES (216, 'NIDIAN ELENA ', 'DIAZ OLIVERA', '1101445253', 'F', NULL, NULL, NULL, 'LAS BABILLAS', 'NEDIAZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:37:14.737762', '2026-02-02 16:37:14.737762');
INSERT INTO public.voters VALUES (217, 'OLGA PATRICIA ', 'PATERNINA MENDOZA', '1002344296', 'F', NULL, NULL, NULL, 'LAS BABILLAS', 'OGPATERNINA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:38:21.602157', '2026-02-02 16:38:21.602157');
INSERT INTO public.voters VALUES (218, 'MARIA DEL PILAR ', 'MARTINEZ FERIA', '32822424', 'F', NULL, NULL, NULL, 'LAS BABILLAS', 'MPMARTINEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:39:21.18963', '2026-02-02 16:39:21.18963');
INSERT INTO public.voters VALUES (219, 'LEONARDO ALFONSO ', 'SANCHEZ LUNA', '1101816962', 'M', NULL, NULL, NULL, 'LAS BABILLAS', 'LASANCHEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:40:18.823474', '2026-02-02 16:40:18.823474');
INSERT INTO public.voters VALUES (220, 'CANDELARIA YULIETH ', 'SANCHEZ LUNA', '1090499772', 'F', NULL, NULL, NULL, 'LAS BABILLAS', 'CYSANCHEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:43:51.941704', '2026-02-02 16:43:51.941704');
INSERT INTO public.voters VALUES (221, 'KATIS SAIS ', 'ALBIS ALVIS', '1101816561', 'F', NULL, NULL, NULL, 'OVEJAS', 'KSALBIS@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:44:57.264532', '2026-02-02 16:44:57.264532');
INSERT INTO public.voters VALUES (222, 'LEITER ALFONSO ', 'ACOSTA ORTIZ', '1028260001', 'M', NULL, NULL, NULL, 'LAS BABILLAS', 'LAACOSTA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:47:15.817701', '2026-02-02 16:47:15.817701');
INSERT INTO public.voters VALUES (223, 'ADRIAN JOSE ', 'ALBIS ALVIS', '1101817688', 'M', NULL, NULL, NULL, 'LAS BABILLAS', 'AJALBIS@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:48:21.258823', '2026-02-02 16:48:21.258823');
INSERT INTO public.voters VALUES (224, 'DEIMER JOSE ', 'ALBIS ALVIS', '1005489568', 'M', NULL, NULL, NULL, NULL, 'DJALBIS@GMAIL.COM', NULL, 'Active', NULL, 28, 1014, NULL, NULL, '2026-02-02 16:49:13.038539', '2026-02-02 16:49:13.038539');
INSERT INTO public.voters VALUES (225, 'LEONEL ALEJANDRO ', 'SANCHEZ LUNA', '1101819605', 'M', NULL, NULL, NULL, 'LAS BABILLAS', 'LESANCHEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:54:28.965236', '2026-02-02 16:54:28.965236');
INSERT INTO public.voters VALUES (226, 'YERLIS EDITH ', 'ALBIS ALVIS', '1192727236', 'F', NULL, NULL, NULL, 'LAS BABILLAS', 'YEALBIS@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 16:55:37.720397', '2026-02-02 16:55:37.720397');
INSERT INTO public.voters VALUES (279, 'Luis Manuel ', 'Arrieta Cardenas', '18878278', 'M', NULL, NULL, '3126694971', 'OVEJAS', 'LMARRIETA@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:03:57.365532', '2026-02-02 19:03:57.365532');
INSERT INTO public.voters VALUES (288, 'JUAN ALCIDES', 'MERCADO ROBLES', '18881829', 'M', NULL, NULL, NULL, 'DON GABRIEL', 'MERCADOJ@HOTMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:19:57.07911', '2026-02-02 19:19:57.07911');
INSERT INTO public.voters VALUES (290, 'JUAN ALCIDES', 'MERCADO LOPEZ', '943315', 'M', NULL, NULL, NULL, 'DON GABRIEL', 'MERCADOJU@HOTMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:24:42.54233', '2026-02-02 19:24:42.54233');
INSERT INTO public.voters VALUES (297, 'Alexander Rafael ', 'Martinez Vargas', '18882497', 'M', NULL, NULL, NULL, 'OVEJAS', 'ARMARTIENEZ@GMAIL.COM', NULL, 'Active', 'OVEJAS', 28, 1014, NULL, NULL, '2026-02-02 19:34:23.017703', '2026-02-02 19:34:23.017703');


--
-- TOC entry 5198 (class 0 OID 18148)
-- Dependencies: 242
-- Data for Name: voting_booths; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.voting_booths VALUES (654, 'PUESTO CABECERA MUNICIPAL', NULL, 1001, 31, '2026-02-03 01:26:01.600495', '2026-02-03 01:26:01.600495');
INSERT INTO public.voting_booths VALUES (655, 'LAS CHICHAS', NULL, 1001, 2, '2026-02-03 01:26:01.600495', '2026-02-03 01:26:01.600495');
INSERT INTO public.voting_booths VALUES (656, 'COSTA RICA', NULL, 1001, 1, '2026-02-03 01:26:01.600495', '2026-02-03 01:26:01.600495');
INSERT INTO public.voting_booths VALUES (657, 'PUESTO CABECERA MUNICIPAL', NULL, 1002, 16, '2026-02-03 01:31:00.159364', '2026-02-03 01:31:00.159364');
INSERT INTO public.voting_booths VALUES (658, 'ALFEREZ', NULL, 1002, 1, '2026-02-03 01:31:00.159364', '2026-02-03 01:31:00.159364');
INSERT INTO public.voting_booths VALUES (659, 'CEDE?????O', NULL, 1002, 1, '2026-02-03 01:31:00.159364', '2026-02-03 01:31:00.159364');
INSERT INTO public.voting_booths VALUES (660, 'EL MAMON', NULL, 1002, 2, '2026-02-03 01:31:00.159364', '2026-02-03 01:31:00.159364');
INSERT INTO public.voting_booths VALUES (661, 'LA MEJIA', NULL, 1002, 3, '2026-02-03 01:31:00.159364', '2026-02-03 01:31:00.159364');
INSERT INTO public.voting_booths VALUES (662, 'LOS CAYITOS', NULL, 1002, 3, '2026-02-03 01:31:00.159364', '2026-02-03 01:31:00.159364');
INSERT INTO public.voting_booths VALUES (663, 'NUEVA ESTACION', NULL, 1002, 2, '2026-02-03 01:31:00.159364', '2026-02-03 01:31:00.159364');
INSERT INTO public.voting_booths VALUES (664, 'NUEVA ESTRELLA', NULL, 1002, 3, '2026-02-03 01:31:00.159364', '2026-02-03 01:31:00.159364');
INSERT INTO public.voting_booths VALUES (665, 'SIETE PALMAS', NULL, 1002, 3, '2026-02-03 01:31:00.159364', '2026-02-03 01:31:00.159364');
INSERT INTO public.voting_booths VALUES (666, 'BARRO BLANCO', NULL, 1002, 1, '2026-02-03 01:31:00.159364', '2026-02-03 01:31:00.159364');
INSERT INTO public.voting_booths VALUES (667, 'CANDELARIA', NULL, 1002, 1, '2026-02-03 01:31:00.159364', '2026-02-03 01:31:00.159364');
INSERT INTO public.voting_booths VALUES (668, 'PUEBLO BUHO', NULL, 1002, 1, '2026-02-03 01:31:00.159364', '2026-02-03 01:31:00.159364');
INSERT INTO public.voting_booths VALUES (669, 'LAS PAVITAS', NULL, 1002, 1, '2026-02-03 01:31:00.159364', '2026-02-03 01:31:00.159364');
INSERT INTO public.voting_booths VALUES (670, 'PUESTO CABECERA MUNICIPAL', NULL, 1003, 14, '2026-02-03 01:32:12.091728', '2026-02-03 01:32:12.091728');
INSERT INTO public.voting_booths VALUES (671, 'LA CEIBA', NULL, 1003, 2, '2026-02-03 01:32:12.091728', '2026-02-03 01:32:12.091728');
INSERT INTO public.voting_booths VALUES (672, 'JONEY', NULL, 1003, 1, '2026-02-03 01:32:12.091728', '2026-02-03 01:32:12.091728');
INSERT INTO public.voting_booths VALUES (673, 'VEREDA DESBARRANCADO', NULL, 1003, 1, '2026-02-03 01:32:12.091728', '2026-02-03 01:32:12.091728');
INSERT INTO public.voting_booths VALUES (674, 'CEIBA', NULL, 1004, 1, '2026-02-03 01:33:14.955294', '2026-02-03 01:33:14.955294');
INSERT INTO public.voting_booths VALUES (675, 'PUESTO CABECERA MUNICIPAL', NULL, 1004, 20, '2026-02-03 01:34:09.128838', '2026-02-03 01:34:09.128838');
INSERT INTO public.voting_booths VALUES (676, 'CHINULITO', NULL, 1004, 3, '2026-02-03 01:34:09.128838', '2026-02-03 01:34:09.128838');
INSERT INTO public.voting_booths VALUES (677, 'EL BAJO DE DON JUAN', NULL, 1004, 2, '2026-02-03 01:34:09.128838', '2026-02-03 01:34:09.128838');
INSERT INTO public.voting_booths VALUES (678, 'EL CERRO', NULL, 1004, 1, '2026-02-03 01:34:09.128838', '2026-02-03 01:34:09.128838');
INSERT INTO public.voting_booths VALUES (679, 'SAN ANTONIO', NULL, 1004, 1, '2026-02-03 01:34:09.128838', '2026-02-03 01:34:09.128838');
INSERT INTO public.voting_booths VALUES (680, 'IE FRANCISCO JOSE DE CALDAS SD PRINCIPAL', NULL, 1005, 16, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (681, 'SEDE TRES DE MARZO', NULL, 1005, 15, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (682, 'ESC. NORMAL NAL. SUPERIOR', NULL, 1005, 27, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (683, 'INST. EDUC. GABRIEL GARCIA MARQUEZ', NULL, 1005, 15, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (684, 'SEDE SOR MARIA ANGELICA', NULL, 1005, 11, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (685, 'SEDE IGNACIO MU?????OZ JARABA', NULL, 1005, 9, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (686, 'INST. EDUCATIVA CARMELO PERCY VERGARA', NULL, 1005, 17, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (687, 'SEDE PRIMERA DE VALPARAISO', NULL, 1005, 14, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (688, 'CANTAGALLO', NULL, 1005, 3, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (689, 'CHAPINERO', NULL, 1005, 4, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (690, 'DON ALONSO', NULL, 1005, 3, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (691, 'EL MAMON', NULL, 1005, 8, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (692, 'HATO NUEVO', NULL, 1005, 3, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (693, 'LAS LLANADAS', NULL, 1005, 5, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (694, 'LAS PE?????AS', NULL, 1005, 3, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (695, 'LAS TINAS', NULL, 1005, 2, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (696, 'PILETA', NULL, 1005, 4, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (697, 'EL RINCON DE LAS FLORES', NULL, 1005, 2, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (698, 'LAS BRUJAS', NULL, 1005, 1, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (699, 'CALLE NUEVA', NULL, 1005, 1, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (700, 'VILLA NUEVA', NULL, 1005, 1, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (701, 'MILAN', NULL, 1005, 1, '2026-02-03 01:35:23.90813', '2026-02-03 01:35:23.90813');
INSERT INTO public.voting_booths VALUES (702, 'PUESTO CABECERA MUNICIPAL', NULL, 1006, 32, '2026-02-03 01:36:21.244273', '2026-02-03 01:36:21.244273');
INSERT INTO public.voting_booths VALUES (703, 'BOCA DE LA CIENAGA', NULL, 1006, 3, '2026-02-03 01:36:21.244273', '2026-02-03 01:36:21.244273');
INSERT INTO public.voting_booths VALUES (704, 'EL REPARO', NULL, 1006, 2, '2026-02-03 01:36:21.244273', '2026-02-03 01:36:21.244273');
INSERT INTO public.voting_booths VALUES (705, 'GUAYABAL', NULL, 1006, 8, '2026-02-03 01:36:21.244273', '2026-02-03 01:36:21.244273');
INSERT INTO public.voting_booths VALUES (706, 'TORRENTE INDIGENA', NULL, 1006, 2, '2026-02-03 01:36:21.244273', '2026-02-03 01:36:21.244273');
INSERT INTO public.voting_booths VALUES (707, 'PUESTO CABECERA MUNICIPAL', NULL, 1007, 15, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (708, 'CALLEJON', NULL, 1007, 1, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (709, 'CAYO DE PALMA', NULL, 1007, 2, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (710, 'CORNETA', NULL, 1007, 3, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (711, 'GRILLO ALEGRE', NULL, 1007, 1, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (712, 'LAS TABLITAS', NULL, 1007, 2, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (713, 'PATILLAL', NULL, 1007, 1, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (714, 'EL SITIO', NULL, 1007, 4, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (715, 'PALMITAL', NULL, 1007, 1, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (716, 'SAN FRANCISCO', NULL, 1007, 3, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (717, 'VILLAVICENCIO (PALMA GIPATA)', NULL, 1007, 1, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (718, 'TIERRA SANTA', NULL, 1007, 1, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (719, 'SANTA ROSA', NULL, 1007, 1, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (720, 'RANCHO DE LA CRUZ', NULL, 1007, 1, '2026-02-03 01:37:59.472364', '2026-02-03 01:37:59.472364');
INSERT INTO public.voting_booths VALUES (721, 'PUESTO CABECERA MUNICIPAL', NULL, 1008, 43, '2026-02-03 01:39:18.54253', '2026-02-03 01:39:18.54253');
INSERT INTO public.voting_booths VALUES (722, 'BARAYA', NULL, 1008, 3, '2026-02-03 01:39:18.54253', '2026-02-03 01:39:18.54253');
INSERT INTO public.voting_booths VALUES (723, 'JUNIN', NULL, 1008, 2, '2026-02-03 01:39:18.54253', '2026-02-03 01:39:18.54253');
INSERT INTO public.voting_booths VALUES (724, 'PUERTO FRANCO', NULL, 1008, 4, '2026-02-03 01:39:18.54253', '2026-02-03 01:39:18.54253');
INSERT INTO public.voting_booths VALUES (725, 'SAN ANDRES DE PALOMO', NULL, 1008, 4, '2026-02-03 01:39:18.54253', '2026-02-03 01:39:18.54253');
INSERT INTO public.voting_booths VALUES (726, 'SAN JOSE DE RIVERA', NULL, 1008, 2, '2026-02-03 01:39:18.54253', '2026-02-03 01:39:18.54253');
INSERT INTO public.voting_booths VALUES (727, 'PUEBLO NUEVO', NULL, 1008, 1, '2026-02-03 01:39:18.54253', '2026-02-03 01:39:18.54253');
INSERT INTO public.voting_booths VALUES (728, 'ABRE EL OJO', NULL, 1008, 1, '2026-02-03 01:39:18.54253', '2026-02-03 01:39:18.54253');
INSERT INTO public.voting_booths VALUES (729, 'PUESTO CABECERA MUNICIPAL', NULL, 1009, 28, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (730, 'CONCORDIA', NULL, 1009, 1, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (731, 'DIAZ GRANADOS', NULL, 1009, 2, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (732, 'GAVALDA', NULL, 1009, 3, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (733, 'LA CEJA', NULL, 1009, 1, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (734, 'LAS PAVAS', NULL, 1009, 2, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (735, 'NUEVA ESPERANZA', NULL, 1009, 3, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (736, 'PALMARITICO', NULL, 1009, 3, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (737, 'PUERTO LOPEZ', NULL, 1009, 4, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (738, 'QUEBRADASECA UNIDA', NULL, 1009, 2, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (739, 'TIERRA SANTA', NULL, 1009, 2, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (740, 'PUERTO AZUL', NULL, 1009, 1, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (741, 'SAN MATIAS', NULL, 1009, 1, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (742, 'EL HUMO', NULL, 1009, 1, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (743, 'SAN RAFAEL', NULL, 1009, 0, '2026-02-03 01:40:18.726033', '2026-02-03 01:40:18.726033');
INSERT INTO public.voting_booths VALUES (744, 'PUESTO CABECERA MUNICIPAL', NULL, 1010, 23, '2026-02-03 01:41:12.891175', '2026-02-03 01:41:12.891175');
INSERT INTO public.voting_booths VALUES (745, 'CAYO DELGADO', NULL, 1010, 2, '2026-02-03 01:41:12.891175', '2026-02-03 01:41:12.891175');
INSERT INTO public.voting_booths VALUES (746, 'LA CONCEPCION', NULL, 1010, 1, '2026-02-03 01:41:12.891175', '2026-02-03 01:41:12.891175');
INSERT INTO public.voting_booths VALUES (747, 'LAS PALMITAS', NULL, 1010, 3, '2026-02-03 01:41:12.891175', '2026-02-03 01:41:12.891175');
INSERT INTO public.voting_booths VALUES (748, 'PAJARITO', NULL, 1010, 3, '2026-02-03 01:41:12.891175', '2026-02-03 01:41:12.891175');
INSERT INTO public.voting_booths VALUES (749, 'SABANETA', NULL, 1010, 3, '2026-02-03 01:41:12.891175', '2026-02-03 01:41:12.891175');
INSERT INTO public.voting_booths VALUES (750, 'VILLA FATIMA', NULL, 1010, 1, '2026-02-03 01:41:12.891175', '2026-02-03 01:41:12.891175');
INSERT INTO public.voting_booths VALUES (751, 'PUESTO CABECERA MUNICIPAL', NULL, 1011, 35, '2026-02-03 01:42:24.771295', '2026-02-03 01:42:24.771295');
INSERT INTO public.voting_booths VALUES (752, 'EL COLEY', NULL, 1011, 3, '2026-02-03 01:42:24.771295', '2026-02-03 01:42:24.771295');
INSERT INTO public.voting_booths VALUES (753, 'EL PI?????AL', NULL, 1011, 5, '2026-02-03 01:42:24.771295', '2026-02-03 01:42:24.771295');
INSERT INTO public.voting_booths VALUES (754, 'PALMAS DE VINO', NULL, 1011, 4, '2026-02-03 01:42:24.771295', '2026-02-03 01:42:24.771295');
INSERT INTO public.voting_booths VALUES (755, 'SABANAS DE BELTRAN', NULL, 1011, 6, '2026-02-03 01:42:24.771295', '2026-02-03 01:42:24.771295');
INSERT INTO public.voting_booths VALUES (756, 'SABANAS DE PEDRO', NULL, 1011, 5, '2026-02-03 01:42:24.771295', '2026-02-03 01:42:24.771295');
INSERT INTO public.voting_booths VALUES (757, 'JESUS MARIA DE PALMITOS', NULL, 1011, 2, '2026-02-03 01:42:24.771295', '2026-02-03 01:42:24.771295');
INSERT INTO public.voting_booths VALUES (758, 'NARANJAL', NULL, 1011, 1, '2026-02-03 01:42:24.771295', '2026-02-03 01:42:24.771295');
INSERT INTO public.voting_booths VALUES (759, 'BIRMANIA', NULL, 1011, 2, '2026-02-03 01:42:24.771295', '2026-02-03 01:42:24.771295');
INSERT INTO public.voting_booths VALUES (760, 'HATILLO', NULL, 1011, 2, '2026-02-03 01:42:24.771295', '2026-02-03 01:42:24.771295');
INSERT INTO public.voting_booths VALUES (761, 'PUESTO CABECERA MUNICIPAL', NULL, 1012, 33, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (762, 'BOCA DE LAS MUJERES', NULL, 1012, 2, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (763, 'EL COCO', NULL, 1012, 2, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (764, 'EL COROZAL', NULL, 1012, 2, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (765, 'EL CIEGO', NULL, 1012, 1, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (766, 'EL PALOMAR', NULL, 1012, 3, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (767, 'EL NARANJO', NULL, 1012, 4, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (768, 'EDUARDO SANTOS', NULL, 1012, 3, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (769, 'LA SIERPITA', NULL, 1012, 5, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (770, 'LAS PALMITAS', NULL, 1012, 4, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (771, 'LOS PATOS', NULL, 1012, 2, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (772, 'MIRA FLOREZ', NULL, 1012, 3, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (773, 'LAS MARTHAS', NULL, 1012, 2, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (774, 'LAS CANDELARIAS', NULL, 1012, 3, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (775, 'LAS TRES BOCAS', NULL, 1012, 2, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (776, 'LEON BLANCO', NULL, 1012, 1, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (777, 'PALMARITO', NULL, 1012, 2, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (778, 'PIZA', NULL, 1012, 5, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (779, 'PUEBLONUEVO', NULL, 1012, 4, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (780, 'SAN MIGUEL', NULL, 1012, 1, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (781, 'SAN ROQUE', NULL, 1012, 6, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (782, 'SANTANDER', NULL, 1012, 3, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (783, 'SINCELEJITO', NULL, 1012, 2, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (784, 'TOMALA', NULL, 1012, 3, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (785, 'TOTUMAL', NULL, 1012, 1, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (786, 'ZAPATA', NULL, 1012, 4, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (787, 'EL TAMACO', NULL, 1012, 1, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (788, 'EL BRILLANTE', NULL, 1012, 1, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (789, 'SITIO NUEVO EL PANDO', NULL, 1012, 1, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (790, 'COCO SOLO', NULL, 1012, 1, '2026-02-03 01:43:17.834591', '2026-02-03 01:43:17.834591');
INSERT INTO public.voting_booths VALUES (791, 'PUESTO CABECERA MUNICIPAL', NULL, 1013, 34, '2026-02-03 01:44:03.744127', '2026-02-03 01:44:03.744127');
INSERT INTO public.voting_booths VALUES (792, 'BREMEN', NULL, 1013, 4, '2026-02-03 01:44:03.744127', '2026-02-03 01:44:03.744127');
INSERT INTO public.voting_booths VALUES (793, 'BRISAS DEL MAR', NULL, 1013, 2, '2026-02-03 01:44:03.744127', '2026-02-03 01:44:03.744127');
INSERT INTO public.voting_booths VALUES (794, 'CAMBIMBA', NULL, 1013, 1, '2026-02-03 01:44:03.744127', '2026-02-03 01:44:03.744127');
INSERT INTO public.voting_booths VALUES (795, 'EL RINCON', NULL, 1013, 1, '2026-02-03 01:44:03.744127', '2026-02-03 01:44:03.744127');
INSERT INTO public.voting_booths VALUES (796, 'EL YESO', NULL, 1013, 2, '2026-02-03 01:44:03.744127', '2026-02-03 01:44:03.744127');
INSERT INTO public.voting_booths VALUES (797, 'LAS FLORES', NULL, 1013, 2, '2026-02-03 01:44:03.744127', '2026-02-03 01:44:03.744127');
INSERT INTO public.voting_booths VALUES (798, 'PICHILIN', NULL, 1013, 1, '2026-02-03 01:44:03.744127', '2026-02-03 01:44:03.744127');
INSERT INTO public.voting_booths VALUES (799, 'SABANAS DE CALI', NULL, 1013, 3, '2026-02-03 01:44:03.744127', '2026-02-03 01:44:03.744127');
INSERT INTO public.voting_booths VALUES (800, 'SABANETA', NULL, 1013, 1, '2026-02-03 01:44:03.744127', '2026-02-03 01:44:03.744127');
INSERT INTO public.voting_booths VALUES (801, 'TUMBATORO', NULL, 1013, 1, '2026-02-03 01:44:03.744127', '2026-02-03 01:44:03.744127');
INSERT INTO public.voting_booths VALUES (802, 'EL TOLIMA', NULL, 1013, 1, '2026-02-03 01:44:03.744127', '2026-02-03 01:44:03.744127');
INSERT INTO public.voting_booths VALUES (803, 'PUESTO CABECERA MUNICIPAL', NULL, 1014, 42, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (804, 'ALMAGRA', NULL, 1014, 3, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (805, 'CANUTAL', NULL, 1014, 4, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (806, 'CANUTALITO', NULL, 1014, 3, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (807, 'CHENGUE', NULL, 1014, 1, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (808, 'DON GABRIEL', NULL, 1014, 3, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (809, 'EL FLORAL', NULL, 1014, 1, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (810, 'FLOR DEL MONTE', NULL, 1014, 5, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (811, 'LA PE?????A', NULL, 1014, 5, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (812, 'PIJIGUAY', NULL, 1014, 2, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (813, 'SAN RAFAEL', NULL, 1014, 4, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (814, 'SALITRAL', NULL, 1014, 2, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (815, 'SAN FRANCISCO', NULL, 1014, 1, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (816, 'EL PALMAR', NULL, 1014, 2, '2026-02-03 01:44:56.903398', '2026-02-03 01:44:56.903398');
INSERT INTO public.voting_booths VALUES (817, 'PUESTO CABECERA MUNICIPAL', NULL, 1015, 22, '2026-02-03 01:45:45.870152', '2026-02-03 01:45:45.870152');
INSERT INTO public.voting_booths VALUES (818, 'ALGODONCILLO', NULL, 1015, 3, '2026-02-03 01:45:45.870152', '2026-02-03 01:45:45.870152');
INSERT INTO public.voting_booths VALUES (819, 'EL MARTILLO', NULL, 1015, 3, '2026-02-03 01:45:45.870152', '2026-02-03 01:45:45.870152');
INSERT INTO public.voting_booths VALUES (820, 'GUAIMARAL', NULL, 1015, 2, '2026-02-03 01:45:45.870152', '2026-02-03 01:45:45.870152');
INSERT INTO public.voting_booths VALUES (821, 'GUAIMI', NULL, 1015, 4, '2026-02-03 01:45:45.870152', '2026-02-03 01:45:45.870152');
INSERT INTO public.voting_booths VALUES (822, 'PUEBLECITO', NULL, 1015, 3, '2026-02-03 01:45:45.870152', '2026-02-03 01:45:45.870152');
INSERT INTO public.voting_booths VALUES (823, 'PUEBLO NUEVO', NULL, 1015, 2, '2026-02-03 01:45:45.870152', '2026-02-03 01:45:45.870152');
INSERT INTO public.voting_booths VALUES (824, 'LOS CASTILLOS', NULL, 1015, 1, '2026-02-03 01:45:45.870152', '2026-02-03 01:45:45.870152');
INSERT INTO public.voting_booths VALUES (825, 'LA GRANJA', NULL, 1015, 1, '2026-02-03 01:45:45.870152', '2026-02-03 01:45:45.870152');
INSERT INTO public.voting_booths VALUES (826, 'CENTRO AZUL', NULL, 1015, 1, '2026-02-03 01:45:45.870152', '2026-02-03 01:45:45.870152');
INSERT INTO public.voting_booths VALUES (827, 'IE MILLAN VARGAS- SD LUIS G. PORTACIO', NULL, 1016, 17, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (828, 'IE MILLAN VARGAS', NULL, 1016, 17, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (829, 'IE MARISCAL SUCRE', NULL, 1016, 18, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (830, 'IE MARISCAL SUCRE- SD PERONILLA', NULL, 1016, 10, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (831, 'ACHIOTE', NULL, 1016, 4, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (832, 'BOSSA NAVARRO', NULL, 1016, 4, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (833, 'CEJA DEL MANGO', NULL, 1016, 2, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (834, 'EL CAMPO', NULL, 1016, 2, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (835, 'ESCOBAR ABAJO', NULL, 1016, 4, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (836, 'ESCOBAR ARRIBA', NULL, 1016, 5, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (837, 'HUERTAS CHICAS', NULL, 1016, 4, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (838, 'LOS PEREZ', NULL, 1016, 1, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (839, 'LA NEGRA', NULL, 1016, 3, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (840, 'LOMA DE PIEDRA', NULL, 1016, 2, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (841, 'MATA DE CA?????A', NULL, 1016, 4, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (842, 'MATEO PEREZ', NULL, 1016, 3, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (843, 'PALITO', NULL, 1016, 2, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (844, 'PIEDRAS BLANCAS', NULL, 1016, 4, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (845, 'SABANALARGA', NULL, 1016, 3, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (846, 'SAN LUIS', NULL, 1016, 5, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (847, 'SILOE', NULL, 1016, 2, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (848, 'SEGOVIA', NULL, 1016, 3, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (849, 'VILLA NUEVA', NULL, 1016, 2, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (850, 'LA LUCHA Y EL CACAO', NULL, 1016, 1, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (851, 'LA ISLA SAN FRANCISCO', NULL, 1016, 1, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (852, 'COSTA DE ORO', NULL, 1016, 1, '2026-02-03 01:46:44.091073', '2026-02-03 01:46:44.091073');
INSERT INTO public.voting_booths VALUES (853, 'PUESTO CABECERA MUNICIPAL', NULL, 1017, 21, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (854, 'CIENEGA NUEVA', NULL, 1017, 1, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (855, 'CIZPATACA', NULL, 1017, 2, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (856, 'CUIVA', NULL, 1017, 2, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (857, 'DO?????A ANA', NULL, 1017, 2, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (858, 'EL LIMON', NULL, 1017, 2, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (859, 'GUAYABAL (SAN MATIAS)', NULL, 1017, 2, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (860, 'EL CAUCHAL', NULL, 1017, 2, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (861, 'JEGUA', NULL, 1017, 3, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (862, 'LA CEIBA', NULL, 1017, 2, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (863, 'LAS CHISPAS', NULL, 1017, 3, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (864, 'LA VENTURA', NULL, 1017, 4, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (865, 'LAS DELICIAS', NULL, 1017, 3, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (866, 'LOS ANGELES (CORRAL VIEJO)', NULL, 1017, 2, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (867, 'PUNTA NUEVA', NULL, 1017, 1, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (868, 'PUNTA DE BLANCO', NULL, 1017, 3, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (869, 'RABON', NULL, 1017, 2, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (870, 'SAN ISIDRO', NULL, 1017, 2, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (871, 'CENTRO EDUCATIVO SAN ROQUE', NULL, 1017, 3, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (872, 'CORREGIMIENTO SANTIAGO APOSTOL', NULL, 1017, 10, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (873, 'VILLA NUEVA', NULL, 1017, 2, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (874, 'LA MOLINA', NULL, 1017, 1, '2026-02-03 01:47:31.428331', '2026-02-03 01:47:31.428331');
INSERT INTO public.voting_booths VALUES (875, 'PUESTO CABECERA MUNICIPAL', NULL, 1018, 24, '2026-02-03 01:48:28.924434', '2026-02-03 01:48:28.924434');
INSERT INTO public.voting_booths VALUES (876, 'ALBANIA', NULL, 1018, 8, '2026-02-03 01:48:28.924434', '2026-02-03 01:48:28.924434');
INSERT INTO public.voting_booths VALUES (877, 'HATO VIEJO', NULL, 1018, 2, '2026-02-03 01:48:28.924434', '2026-02-03 01:48:28.924434');
INSERT INTO public.voting_booths VALUES (878, 'SABANETA', NULL, 1018, 2, '2026-02-03 01:48:28.924434', '2026-02-03 01:48:28.924434');
INSERT INTO public.voting_booths VALUES (879, 'VILLA LOPEZ', NULL, 1018, 2, '2026-02-03 01:48:28.924434', '2026-02-03 01:48:28.924434');
INSERT INTO public.voting_booths VALUES (880, 'LOMA ALTA', NULL, 1018, 2, '2026-02-03 01:48:28.924434', '2026-02-03 01:48:28.924434');
INSERT INTO public.voting_booths VALUES (881, 'SANTO TOMAS', NULL, 1018, 1, '2026-02-03 01:48:28.924434', '2026-02-03 01:48:28.924434');
INSERT INTO public.voting_booths VALUES (882, 'ESCUELA SAN MARQUITOS', NULL, 1019, 25, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (883, 'COLISEO CUBIERTO', NULL, 1019, 10, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (884, 'INST. EDUC. GIMNASIO SAN JORGE', NULL, 1019, 9, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (885, 'COL. BACHILLERATO SAN MARCOS', NULL, 1019, 25, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (886, 'ESCUELA SAN JOSE', NULL, 1019, 22, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (887, 'ESCUELA JHON F. KENNEDY', NULL, 1019, 17, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (888, 'BELEN', NULL, 1019, 7, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (889, 'BUENAVISTA', NULL, 1019, 5, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (890, 'CA?????O PRIETO', NULL, 1019, 2, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (891, 'CUENCA', NULL, 1019, 4, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (892, 'EL LIMON', NULL, 1019, 6, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (893, 'EL PITAL', NULL, 1019, 3, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (894, 'EL TABLON', NULL, 1019, 3, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (895, 'NEIVA', NULL, 1019, 3, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (896, 'LA QUEBRADA O QUEBRADA VIEJA', NULL, 1019, 2, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (897, 'LAS FLORES', NULL, 1019, 7, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (898, 'SANTA INES', NULL, 1019, 3, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (899, 'CAYO DE LA CRUZ', NULL, 1019, 2, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (900, 'VEREDA EL LLANO', NULL, 1019, 1, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (901, 'VEREDA EL TORNO', NULL, 1019, 1, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (902, 'VEREDA BOCA PUERTA', NULL, 1019, 1, '2026-02-03 01:49:19.517007', '2026-02-03 01:49:19.517007');
INSERT INTO public.voting_booths VALUES (903, 'ESC. ANTONIO NARI?????O', NULL, 1020, 10, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (904, 'CDI CAMPO DE LAS FLORES', NULL, 1020, 10, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (905, 'IE SAGRADO CORAZON DE JESUS', NULL, 1020, 17, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (906, 'ESC. MADRE BERNARDA', NULL, 1020, 10, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (907, 'COLEGIO MANUEL ANGEL ANACHURY', NULL, 1020, 8, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (908, 'ESCUELA SAN JOSE', NULL, 1020, 12, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (909, 'AGUACATE', NULL, 1020, 2, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (910, 'AGUAS NEGRAS', NULL, 1020, 4, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (911, 'BARRANCA', NULL, 1020, 3, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (912, 'BERLIN', NULL, 1020, 2, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (913, 'BERRUGAS', NULL, 1020, 10, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (914, 'BOCACERRADA', NULL, 1020, 2, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (915, 'BUENOS AIRES', NULL, 1020, 1, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (916, 'EL CHICHO', NULL, 1020, 2, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (917, 'EL CERRO DE DOS CASAS', NULL, 1020, 3, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (918, 'HIGUERON', NULL, 1020, 2, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (919, 'LABARCE', NULL, 1020, 4, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (920, 'LAS BRISAS', NULL, 1020, 2, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (921, 'LIBERTAD', NULL, 1020, 9, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (922, 'PALMIRA', NULL, 1020, 3, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (923, 'PAJONAL', NULL, 1020, 5, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (924, 'PAJONALITO', NULL, 1020, 1, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (925, 'PALACIO', NULL, 1020, 2, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (926, 'EL PUEBLITO', NULL, 1020, 2, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (927, 'PALO ALTO', NULL, 1020, 11, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (928, 'PLAMPAREJO', NULL, 1020, 3, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (929, 'RINCON', NULL, 1020, 7, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (930, 'SABANAS DE MUCACAL', NULL, 1020, 4, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (931, 'SAN ANTONIO', NULL, 1020, 5, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (932, 'SABANETICA', NULL, 1020, 1, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (933, 'BOLITO', NULL, 1020, 1, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (934, 'ALTO DE JULIO', NULL, 1020, 1, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (935, 'CHICHIMAN', NULL, 1020, 1, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (936, 'LA LUCHA', NULL, 1020, 1, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (937, 'EL BONGO', NULL, 1020, 1, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (938, 'VISTA HERMOSA', NULL, 1020, 1, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (939, 'PALITO NORTE', NULL, 1020, 1, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (940, 'CACIQUE', NULL, 1020, 1, '2026-02-03 01:51:13.183337', '2026-02-03 01:51:13.183337');
INSERT INTO public.voting_booths VALUES (941, 'PUESTO CABECERA MUNICIPAL', NULL, 1021, 49, '2026-02-03 01:52:04.615581', '2026-02-03 01:52:04.615581');
INSERT INTO public.voting_booths VALUES (942, 'NUMANCIA', NULL, 1021, 1, '2026-02-03 01:52:04.615581', '2026-02-03 01:52:04.615581');
INSERT INTO public.voting_booths VALUES (943, 'ROVIRA', NULL, 1021, 3, '2026-02-03 01:52:04.615581', '2026-02-03 01:52:04.615581');
INSERT INTO public.voting_booths VALUES (944, 'SAN MATEO', NULL, 1021, 4, '2026-02-03 01:52:04.615581', '2026-02-03 01:52:04.615581');
INSERT INTO public.voting_booths VALUES (945, 'IE PEDRO ESPINOSA', NULL, 1022, 12, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (946, 'I.E. ANTONIO SANTOS', NULL, 1022, 17, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (947, 'SN JUAN BAUTISTA LA SALLE', NULL, 1022, 22, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (948, 'POLIDEPORTIVO LUIS GABRIEL M', NULL, 1022, 18, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (949, 'BAZAN', NULL, 1022, 1, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (950, 'COCOROTE', NULL, 1022, 2, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (951, 'GALAPAGO', NULL, 1022, 1, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (952, 'GRANADA', NULL, 1022, 8, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (953, 'LA VIVIENDA (ARBOLEDA)', NULL, 1022, 2, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (954, 'LOS LIMONES', NULL, 1022, 1, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (955, 'MORALITO', NULL, 1022, 1, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (956, 'PERENDENGUE', NULL, 1022, 1, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (957, 'VALENCIA', NULL, 1022, 3, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (958, 'VELEZ', NULL, 1022, 2, '2026-02-03 01:52:57.333521', '2026-02-03 01:52:57.333521');
INSERT INTO public.voting_booths VALUES (959, 'IE DULCE NOMBRE DE JESUS', NULL, 1023, 26, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (960, 'IE NORMAL SUPERIOR DE SINCELEJO', NULL, 1023, 32, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (961, 'I.E. JUANITA GARCIA MANJARRES', NULL, 1023, 31, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (962, 'INSTITUCION EDUCATIVA ANTONIO PRIETO', NULL, 1023, 20, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (963, 'IE NUESTRA SE?????ORA DEL CARMEN', NULL, 1023, 23, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (964, 'INST.EDC.20 DE ENERO', NULL, 1023, 28, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (965, 'INSTITUCION EDUCATIVA MADRE AMALIA', NULL, 1023, 34, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (966, 'IE ANTONIO LENIS', NULL, 1023, 49, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (967, 'IE SAN JOSE C I P', NULL, 1023, 22, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (968, 'IE SAN VICENTE DE PAUL', NULL, 1023, 1, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (969, 'IE JOSE IGNACIO LOPEZ', NULL, 1023, 13, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (970, 'IE FRANCISCO DE PAULA SANTANDER', NULL, 1023, 18, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (971, 'CENTRO EDUCATIVO REGIONAL DE SUCRE CERS', NULL, 1023, 11, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (972, 'CTRO DE DESAR. INFANTIL CDI DO?????A ANGELA', NULL, 1023, 20, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (973, 'IE ANTONIO NARI?????O SEDE JUANITA', NULL, 1023, 15, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (974, 'IE CUARTA EL SALVADOR', NULL, 1023, 22, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (975, 'IE ALTOS DE LA SABANA', NULL, 1023, 9, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (976, 'COL. NTRA STA DE FATIMA', NULL, 1023, 28, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (977, 'IE SANTA ROSA DE LIMA', NULL, 1023, 35, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (978, 'IE PARA POBLACIONES ESPECIALES', NULL, 1023, 22, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (979, 'INSTITUCION EDUCATIVA SIMON ARAUJO', NULL, 1023, 52, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (980, 'INSTITUCION EDUCATIVA NUEVA ESPERANZA', NULL, 1023, 40, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (981, 'IE SAN JOSE', NULL, 1023, 33, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (982, 'CDI LOS SABANERITOS', NULL, 1023, 1, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (1096, 'EL RUBIO', NULL, 172, 1, '2026-02-03 02:05:38.616573', '2026-02-03 02:05:38.616573');
INSERT INTO public.voting_booths VALUES (983, 'IE SIMON ARAUJO SEDE EL PROGRESO', NULL, 1023, 2, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (984, 'IE CONCENTRACION SIMON ARAUJITO', NULL, 1023, 18, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (985, 'CARCEL NACIONAL LA VEGA', NULL, 1023, 1, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (986, 'EL CINCO', NULL, 1023, 1, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (987, 'CASTA?????EDA', NULL, 1023, 4, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (988, 'CHOCHO', NULL, 1023, 15, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (989, 'LAS PALMAS', NULL, 1023, 4, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (990, 'LA ARENA', NULL, 1023, 5, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (991, 'LA CHIVERA', NULL, 1023, 1, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (992, 'LA PE?????ATA', NULL, 1023, 4, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (993, 'LAS MAJAGUAS', NULL, 1023, 1, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (994, 'SAN RAFAEL (EL ZANJON)', NULL, 1023, 1, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (995, 'CRUZ DEL BEQUE', NULL, 1023, 3, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (996, 'EL CERRITO', NULL, 1023, 4, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (997, 'LAGUNA FLOR', NULL, 1023, 2, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (998, 'LAS HUERTAS', NULL, 1023, 2, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (999, 'SAN ANTONIO', NULL, 1023, 4, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (1000, 'BUENAVISTA', NULL, 1023, 3, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (1001, 'LA GALLERA', NULL, 1023, 7, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (1002, 'VILLA ROSITA', NULL, 1023, 1, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (1003, 'SAN JACINTO (MOCHA)', NULL, 1023, 2, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (1004, 'SABANAS DEL POTRERO', NULL, 1023, 4, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (1005, 'VILLA DE SAN MARTIN', NULL, 1023, 3, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (1006, 'BABILONIA', NULL, 1023, 3, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (1007, 'BUENAVISTICA', NULL, 1023, 1, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (1008, 'CERRO DEL NARANJO', NULL, 1023, 1, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (1009, 'SAN NICOLAS', NULL, 1023, 2, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (1010, 'BUENOS AIRES', NULL, 1023, 2, '2026-02-03 01:54:16.737636', '2026-02-03 01:54:16.737636');
INSERT INTO public.voting_booths VALUES (1011, 'PUESTO CABECERA MUNICIPAL', NULL, 1024, 20, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1012, 'ARBOLEDA', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1013, 'BAJOGRANDE', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1014, 'BAJO PUREZA', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1015, 'CALZON BLANCO', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1016, 'CAMAJON', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1017, 'CAMPO ALEGRE', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1018, 'CHAPARRAL', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1019, 'CORDOBA', NULL, 1024, 4, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1020, 'EL CONGRESO', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1021, 'HATO NUEVO', NULL, 1024, 3, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1022, 'ISLA DEL COCO', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1023, 'ISLA GRANDE', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1024, 'LA GUARIPA', NULL, 1024, 3, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1025, 'LA PALMA', NULL, 1024, 3, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1026, 'LA REDONDA', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1027, 'LA SOLERA', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1028, 'LA VENTURA', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1029, 'MACHETON', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1030, 'MALAMBO', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1031, 'MONTERIA', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1032, 'MUZANGA', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1033, 'NARANJAL', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1034, 'NARI?????O', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1035, 'OREJERO', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1036, 'PAMPANILLA', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1037, 'QUITASUE?????O', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1038, 'SAN LUIS', NULL, 1024, 3, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1039, 'SAN CAYETANO', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1040, 'SAN JOSE', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1041, 'SAN MATEO', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1042, 'SAN RAFAEL', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1043, 'TRAVESIA', NULL, 1024, 2, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1044, 'FUNDACION', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1045, 'CACAGUAL', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1046, 'PUEBLO NUEVO', NULL, 1024, 1, '2026-02-03 01:56:01.791155', '2026-02-03 01:56:01.791155');
INSERT INTO public.voting_booths VALUES (1047, 'I.E. SANTA TERESITA', NULL, 1025, 13, '2026-02-03 01:57:09.926826', '2026-02-03 01:57:09.926826');
INSERT INTO public.voting_booths VALUES (1048, 'I.E. LUIS PATRON ROSANO', NULL, 1025, 20, '2026-02-03 01:57:09.926826', '2026-02-03 01:57:09.926826');
INSERT INTO public.voting_booths VALUES (1049, 'CENTRO DE DESARROLLO INFANTIL', NULL, 1025, 16, '2026-02-03 01:57:09.926826', '2026-02-03 01:57:09.926826');
INSERT INTO public.voting_booths VALUES (1050, 'INST. EDUCATIVA SD FATIMA EL PROGRESO', NULL, 1025, 19, '2026-02-03 01:57:09.926826', '2026-02-03 01:57:09.926826');
INSERT INTO public.voting_booths VALUES (1051, 'NUEVA ERA', NULL, 1025, 2, '2026-02-03 01:57:09.926826', '2026-02-03 01:57:09.926826');
INSERT INTO public.voting_booths VALUES (1052, 'PITA ABAJO', NULL, 1025, 4, '2026-02-03 01:57:09.926826', '2026-02-03 01:57:09.926826');
INSERT INTO public.voting_booths VALUES (1053, 'PITA EN MEDIO', NULL, 1025, 3, '2026-02-03 01:57:09.926826', '2026-02-03 01:57:09.926826');
INSERT INTO public.voting_booths VALUES (1054, 'PUERTO VIEJO', NULL, 1025, 4, '2026-02-03 01:57:09.926826', '2026-02-03 01:57:09.926826');
INSERT INTO public.voting_booths VALUES (1055, 'SANTA LUCIA', NULL, 1025, 3, '2026-02-03 01:57:09.926826', '2026-02-03 01:57:09.926826');
INSERT INTO public.voting_booths VALUES (1056, 'PALO BLANCO', NULL, 1025, 1, '2026-02-03 01:57:09.926826', '2026-02-03 01:57:09.926826');
INSERT INTO public.voting_booths VALUES (1057, 'EL FRANCES', NULL, 1025, 2, '2026-02-03 01:57:09.926826', '2026-02-03 01:57:09.926826');
INSERT INTO public.voting_booths VALUES (1058, 'PUESTO CABECERA MUNICIPAL', NULL, 1026, 23, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1059, 'CARACOL', NULL, 1026, 4, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1060, 'CIENAGUITA', NULL, 1026, 1, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1061, 'EL CA?????ITO', NULL, 1026, 3, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1062, 'GUALON', NULL, 1026, 4, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1063, 'LA UNION', NULL, 1026, 3, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1064, 'LA SIRIA', NULL, 1026, 2, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1065, 'LA PICHE', NULL, 1026, 2, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1066, 'LAS PIEDRAS', NULL, 1026, 3, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1067, 'LOS ALTOS', NULL, 1026, 1, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1068, 'MACAJAN', NULL, 1026, 9, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1069, 'PALMIRA', NULL, 1026, 5, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1070, 'VARSOVIA', NULL, 1026, 8, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1071, 'MANICA', NULL, 1026, 1, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1072, 'LA ESPERANZA', NULL, 1026, 1, '2026-02-03 01:58:18.402698', '2026-02-03 01:58:18.402698');
INSERT INTO public.voting_booths VALUES (1073, 'PUESTO CABECERA MUNICIPAL', NULL, 171, 18, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1074, 'BOYACA', NULL, 171, 2, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1075, 'BUENAVISTA', NULL, 171, 2, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1076, 'BUENOS AIRES', NULL, 171, 1, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1077, 'CENTRO ALEGRE', NULL, 171, 2, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1078, 'EL ALGARROBO', NULL, 171, 1, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1079, 'EL GALLEGO', NULL, 171, 2, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1080, 'GUACAMAYO', NULL, 171, 4, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1081, 'GUAMO', NULL, 171, 2, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1082, 'LOS NISPEROS', NULL, 171, 2, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1083, 'NUEVA ESPERANZA', NULL, 171, 2, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1084, 'PALENQUILLO', NULL, 171, 1, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1085, 'PAYANDE', NULL, 171, 2, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1086, 'PLAYA ALTA', NULL, 171, 6, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1087, 'PUERTO VENECIA', NULL, 171, 2, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1088, 'PUERTO ISABEL', NULL, 171, 2, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1089, 'PROVIDENCIA', NULL, 171, 2, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1090, 'RIONEGRO', NULL, 171, 3, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1091, 'SANTA LUCIA', NULL, 171, 2, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1092, 'TACUYALTA', NULL, 171, 2, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1093, 'TRES CRUCES', NULL, 171, 3, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1094, 'CORREGIMIENTO EL PARAISO', NULL, 171, 1, '2026-02-03 02:02:32.202515', '2026-02-03 02:02:32.202515');
INSERT INTO public.voting_booths VALUES (1095, 'PUESTO CABECERA MUNICIPAL', NULL, 172, 17, '2026-02-03 02:05:38.616573', '2026-02-03 02:05:38.616573');
INSERT INTO public.voting_booths VALUES (1097, 'LA PACHA', NULL, 172, 6, '2026-02-03 02:05:38.616573', '2026-02-03 02:05:38.616573');
INSERT INTO public.voting_booths VALUES (1098, 'SAN ISIDRO', NULL, 172, 2, '2026-02-03 02:05:38.616573', '2026-02-03 02:05:38.616573');
INSERT INTO public.voting_booths VALUES (1099, 'SANTA LUCIA', NULL, 172, 1, '2026-02-03 02:05:38.616573', '2026-02-03 02:05:38.616573');
INSERT INTO public.voting_booths VALUES (1100, 'PUESTO CABECERA MUNICIPAL', NULL, 173, 16, '2026-02-03 02:06:31.314672', '2026-02-03 02:06:31.314672');
INSERT INTO public.voting_booths VALUES (1101, 'BUENAVISTA', NULL, 173, 2, '2026-02-03 02:06:31.314672', '2026-02-03 02:06:31.314672');
INSERT INTO public.voting_booths VALUES (1102, 'CARNIZALA', NULL, 173, 2, '2026-02-03 02:06:31.314672', '2026-02-03 02:06:31.314672');
INSERT INTO public.voting_booths VALUES (1103, 'SAN RAFAEL', NULL, 173, 2, '2026-02-03 02:06:31.314672', '2026-02-03 02:06:31.314672');
INSERT INTO public.voting_booths VALUES (1104, 'SANTO DOMINGO', NULL, 173, 1, '2026-02-03 02:06:31.314672', '2026-02-03 02:06:31.314672');
INSERT INTO public.voting_booths VALUES (1105, 'SAN AGUSTIN', NULL, 173, 1, '2026-02-03 02:06:31.314672', '2026-02-03 02:06:31.314672');
INSERT INTO public.voting_booths VALUES (1106, 'SABANA BAJA', NULL, 173, 1, '2026-02-03 02:06:31.314672', '2026-02-03 02:06:31.314672');
INSERT INTO public.voting_booths VALUES (1107, 'ESC. REPUBLICA DE COLOMBIA', NULL, 174, 19, '2026-02-03 02:07:25.359598', '2026-02-03 02:07:25.359598');
INSERT INTO public.voting_booths VALUES (1108, 'COL BENJAMIN HERRERA', NULL, 174, 26, '2026-02-03 02:07:25.359598', '2026-02-03 02:07:25.359598');
INSERT INTO public.voting_booths VALUES (1109, 'CENTRO DE ALTO RENDIMIENTO', NULL, 174, 22, '2026-02-03 02:07:25.359598', '2026-02-03 02:07:25.359598');
INSERT INTO public.voting_booths VALUES (1110, 'INST EDUC MARIA MICHELSEN DE LOPEZ', NULL, 174, 4, '2026-02-03 02:07:25.359598', '2026-02-03 02:07:25.359598');
INSERT INTO public.voting_booths VALUES (1111, 'INST.EDUC.CATALINA HERRERA', NULL, 174, 25, '2026-02-03 02:07:25.359598', '2026-02-03 02:07:25.359598');
INSERT INTO public.voting_booths VALUES (1112, 'ESC MIX ANGELA DORADO', NULL, 174, 22, '2026-02-03 02:07:25.359598', '2026-02-03 02:07:25.359598');
INSERT INTO public.voting_booths VALUES (1113, 'ESC FRANCISCO DE PAULA SANTANDER', NULL, 174, 24, '2026-02-03 02:07:25.359598', '2026-02-03 02:07:25.359598');
INSERT INTO public.voting_booths VALUES (1114, 'IE DOMINGO TARRA GUARDO SD MANUELA BELTR', NULL, 174, 2, '2026-02-03 02:07:25.359598', '2026-02-03 02:07:25.359598');
INSERT INTO public.voting_booths VALUES (1115, 'COLEGIO INDUSTRIAL DON BOSCO', NULL, 174, 9, '2026-02-03 02:07:25.359598', '2026-02-03 02:07:25.359598');
INSERT INTO public.voting_booths VALUES (1116, 'PUERTO BADEL (CA?????O SALADO)', NULL, 174, 4, '2026-02-03 02:07:25.359598', '2026-02-03 02:07:25.359598');
INSERT INTO public.voting_booths VALUES (1117, 'GAMBOTE', NULL, 174, 5, '2026-02-03 02:07:25.359598', '2026-02-03 02:07:25.359598');
INSERT INTO public.voting_booths VALUES (1118, 'ROCHA', NULL, 174, 8, '2026-02-03 02:07:25.359598', '2026-02-03 02:07:25.359598');
INSERT INTO public.voting_booths VALUES (1119, 'SINCERIN', NULL, 174, 10, '2026-02-03 02:07:25.359598', '2026-02-03 02:07:25.359598');
INSERT INTO public.voting_booths VALUES (1120, 'PUESTO CABECERA MUNICIPAL', NULL, 175, 21, '2026-02-03 02:08:08.245057', '2026-02-03 02:08:08.245057');
INSERT INTO public.voting_booths VALUES (1121, 'MACHADO', NULL, 175, 3, '2026-02-03 02:08:08.245057', '2026-02-03 02:08:08.245057');
INSERT INTO public.voting_booths VALUES (1122, 'MONROY', NULL, 175, 2, '2026-02-03 02:08:08.245057', '2026-02-03 02:08:08.245057');
INSERT INTO public.voting_booths VALUES (1123, 'PILON', NULL, 175, 2, '2026-02-03 02:08:08.245057', '2026-02-03 02:08:08.245057');
INSERT INTO public.voting_booths VALUES (1124, 'SATO', NULL, 175, 3, '2026-02-03 02:08:08.245057', '2026-02-03 02:08:08.245057');
INSERT INTO public.voting_booths VALUES (1125, 'SAN FRANCISCO', NULL, 175, 2, '2026-02-03 02:08:08.245057', '2026-02-03 02:08:08.245057');
INSERT INTO public.voting_booths VALUES (1126, 'PUESTO CABECERA MUNICIPAL', NULL, 176, 23, '2026-02-03 02:08:47.200508', '2026-02-03 02:08:47.200508');
INSERT INTO public.voting_booths VALUES (1127, 'LOS CERRITOS', NULL, 176, 4, '2026-02-03 02:08:47.200508', '2026-02-03 02:08:47.200508');
INSERT INTO public.voting_booths VALUES (1128, 'RIONUEVO', NULL, 176, 2, '2026-02-03 02:08:47.200508', '2026-02-03 02:08:47.200508');
INSERT INTO public.voting_booths VALUES (1129, 'SAN ANTONIO', NULL, 176, 5, '2026-02-03 02:08:47.200508', '2026-02-03 02:08:47.200508');
INSERT INTO public.voting_booths VALUES (1130, 'LAS MINAS DE SANTA CRUZ', NULL, 176, 3, '2026-02-03 02:08:47.200508', '2026-02-03 02:08:47.200508');
INSERT INTO public.voting_booths VALUES (1131, 'LAS DELICIAS', NULL, 176, 2, '2026-02-03 02:08:47.200508', '2026-02-03 02:08:47.200508');
INSERT INTO public.voting_booths VALUES (1132, 'PUEBLITO MEJIA', NULL, 176, 2, '2026-02-03 02:08:47.200508', '2026-02-03 02:08:47.200508');
INSERT INTO public.voting_booths VALUES (1133, 'PUESTO CABECERA MUNICIPAL', NULL, 177, 39, '2026-02-03 02:09:19.748434', '2026-02-03 02:09:19.748434');
INSERT INTO public.voting_booths VALUES (1134, 'BARRANCA NUEVA', NULL, 177, 5, '2026-02-03 02:09:19.748434', '2026-02-03 02:09:19.748434');
INSERT INTO public.voting_booths VALUES (1135, 'BARRANCA VIEJA', NULL, 177, 5, '2026-02-03 02:09:19.748434', '2026-02-03 02:09:19.748434');
INSERT INTO public.voting_booths VALUES (1136, 'HATO VIEJO', NULL, 177, 12, '2026-02-03 02:09:19.748434', '2026-02-03 02:09:19.748434');
INSERT INTO public.voting_booths VALUES (1137, 'SAN PEDRITO', NULL, 177, 1, '2026-02-03 02:09:19.748434', '2026-02-03 02:09:19.748434');
INSERT INTO public.voting_booths VALUES (1138, 'YUCAL', NULL, 177, 4, '2026-02-03 02:09:19.748434', '2026-02-03 02:09:19.748434');
INSERT INTO public.voting_booths VALUES (1139, 'PUESTO CABECERA MUNICIPAL', NULL, 178, 18, '2026-02-03 02:10:01.108259', '2026-02-03 02:10:01.108259');
INSERT INTO public.voting_booths VALUES (1140, 'BRISAS DE BOLIVAR', NULL, 178, 4, '2026-02-03 02:10:01.108259', '2026-02-03 02:10:01.108259');
INSERT INTO public.voting_booths VALUES (1141, 'LAVICTORIA', NULL, 178, 1, '2026-02-03 02:10:01.108259', '2026-02-03 02:10:01.108259');
INSERT INTO public.voting_booths VALUES (1142, 'SAN LORENZO', NULL, 178, 3, '2026-02-03 02:10:01.108259', '2026-02-03 02:10:01.108259');
INSERT INTO public.voting_booths VALUES (1143, 'CENTRO COMERCIAL BOCAGRANDE', NULL, 179, 24, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1144, 'UNIV. TECNOLG. DE BOLIVAR - MA', NULL, 179, 37, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1145, 'LUDOTECA PARQUE CENTENARIO', NULL, 179, 5, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1146, 'COL. EUCAR?????STICO DE SANTA TERESA', NULL, 179, 18, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1147, 'CENTRO COMERCIAL PLAZA BOCAGRANDE', NULL, 179, 25, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1148, 'COLEGIO DE LA ESPERANZA', NULL, 179, 26, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1149, 'COLEGIO NAVAL DE CRESPO', NULL, 179, 35, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1150, 'COLEGIO EL CARMELO', NULL, 179, 14, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1151, 'COLEGIO BERVELLY HILLS', NULL, 179, 16, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1152, 'COLEGIO LICEO BOLIVAR', NULL, 179, 27, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1153, 'IE STA MARIA SEDE SAGRADO CORAZON', NULL, 179, 32, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1154, 'I.E.CORAZON DE MARIA', NULL, 179, 23, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1155, 'IE CORAZON DE MARIA S S J CLAV', NULL, 179, 15, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1156, 'I.E SANTA MARIA SD MARCO FIDEL SUAREZ', NULL, 179, 16, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1157, 'COLISEO CUBIERTO BERNARDO CARABALLO', NULL, 179, 35, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1158, 'COLEGIO JOSE DE LA VEGA', NULL, 179, 39, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1159, 'IE HER. ANTONIO RAMOS DE LA SALLE', NULL, 179, 14, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1160, 'INST. ED. ANA MARIA VELEZ DE TRUJILLO', NULL, 179, 22, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1161, 'CORP UNIVERSITARIA RAFAEL NU?????EZ TORICES', NULL, 179, 1, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1162, 'C.ECON. PIEDRA DE BOL UNIV. C/GENA', NULL, 179, 34, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1163, 'COLEGIO COMFENALCO SEDE CEDESARROLLO', NULL, 179, 29, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1164, 'INST. ED. MADRE LAURA', NULL, 179, 18, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1165, 'SENA 4 VIENTOS', NULL, 179, 14, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1166, 'I E CASD MANUELA BELTRAN', NULL, 179, 8, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1167, 'IE NUEVO BOSQUE', NULL, 179, 47, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1168, 'COL ALBERTO ELIAS FERNANDEZ', NULL, 179, 34, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1169, 'I.E NUEVO BOSQUE SEDE JOSE MARIA CORDOBA', NULL, 179, 25, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1170, 'INST. ED. FERNANDO DE LA VEGA', NULL, 179, 12, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1171, 'E. NORMAL SUPERIOR DE CARTAGENA D INDIAS', NULL, 179, 17, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1172, 'UNIVERSIDAD DEL SINU SEDE PLAZA COLON', NULL, 179, 10, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1173, 'IE SAN JUAN DE DAMASCO', NULL, 179, 37, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1174, 'IE OLGA GONZALEZ ARRAUT', NULL, 179, 30, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1175, 'IE MANUELA BELTRAN - SED HIJOS', NULL, 179, 16, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1176, 'SEMINARIO CARTAGENA', NULL, 179, 12, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1177, 'UNIVERSIDAD ANTONIO NARI?????O', NULL, 179, 15, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1178, 'COLEGIO LATINOAMERICANO', NULL, 179, 3, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1179, 'FUNDACION COLEGIO OCTAVIANA DEL C VIVES', NULL, 179, 1, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1180, 'UNIV DE CARTAGENA CLAUSTRO SAN AGUSTIN', NULL, 179, 33, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1181, 'COL SALESIANOS SAN PEDRO CLAVE', NULL, 179, 19, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1182, 'IE ANTONIA SANTOS', NULL, 179, 34, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1183, 'UNIV. DE CARTAGENA CLAUSTRO LA MERCED', NULL, 179, 4, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1184, 'FUNDACION UNIVERSITARIA LOS LIBERTADORES', NULL, 179, 16, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1185, 'INST UNIVERSITARIA MAYOR DE CARTAGENA', NULL, 179, 30, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1186, 'INST UNI BELLAS ARTES Y CIENCIAS DE BOL.', NULL, 179, 16, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1187, 'ESCUELAS PROFESIONALES SALESIANAS', NULL, 179, 15, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1188, 'IE FE Y ALEGRIA LAS GAVIOTAS', NULL, 179, 46, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1189, 'IE LAS GAVIOTAS SEDE MOISES GO', NULL, 179, 17, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1190, 'I.E. LAS GAVIOTAS SEDE EL NI?????O JESUS', NULL, 179, 19, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1191, 'CENTRO DE ENSE?????ANZA HIJOS DE BOLIVAR', NULL, 179, 19, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1192, 'IE FOCO ROJO', NULL, 179, 38, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1193, 'COLEGIO ALMIRANTE COLON S. OLAYA', NULL, 179, 27, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1194, 'I.E. PLAYAS DE ACAPULCO', NULL, 179, 20, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1195, 'IE. NUESTRA SE?????ORA PERPETUO SOCORRO', NULL, 179, 21, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1196, 'IE REPUBLICA DEL LIBANO', NULL, 179, 1, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1197, 'IE SAN FELIPE NERIS', NULL, 179, 1, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1198, 'IE FRANCISCO DE PAULA SANTANDE', NULL, 179, 31, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1199, 'IE MARIA REINA', NULL, 179, 22, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1200, 'ESCUELA CIUDAD DE TUNJA', NULL, 179, 30, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1201, 'I.E. CORAZON DE MARIA - LAZARO MARTINEZ', NULL, 179, 10, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1202, 'I.E. ANTONIO NARI?????O', NULL, 179, 20, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1203, 'I.E. PEDRO ROMERO', NULL, 179, 15, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1204, 'IE OMAIRA SANCHEZ', NULL, 179, 6, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1205, 'CDI CIENAGA DE LA VIRGEN', NULL, 179, 1, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1206, 'IE CAMILO TORRES', NULL, 179, 49, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1207, 'CENTRO COLOMBIATON GUSTAVO PULECIO', NULL, 179, 36, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1208, 'IE LA LIBERTAD', NULL, 179, 31, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1209, 'IE NUESTRO ESFUERZO', NULL, 179, 21, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1210, 'IE CLEMENTE MANUEL ZABALA', NULL, 179, 11, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1211, 'IE JORGE GARCIA USTA', NULL, 179, 16, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1212, 'ESCUELA GABRIELA SAN MARTIN', NULL, 179, 46, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1213, 'COL FE Y ALEGRIA LAS AMERICAS', NULL, 179, 35, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1214, 'CENTRO CULTURAL LAS PALMERAS', NULL, 179, 22, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1215, 'IE DE FREDONIA', NULL, 179, 20, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1216, 'COLEGIO DIOS ES AMOR CDA', NULL, 179, 1, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1217, 'IE TECNICA VILLA ESTRELLA', NULL, 179, 1, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1218, 'IE FULGENCIO LEQUERICA VELEZ', NULL, 179, 22, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1219, 'NUESTRA SE?????ORA DEL CARMEN', NULL, 179, 27, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1220, 'IE FULGENCIO LEQUERICA VELEZ- ECUADOR', NULL, 179, 19, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1221, 'FUND. UNIV. COLOMBO INTERNACIONAL', NULL, 179, 20, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1222, 'COLEGIO INEM', NULL, 179, 37, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1223, 'CENT RECREACIONAL NAPOLEON PEREA', NULL, 179, 28, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1224, 'IE JOSE M RODRIGUEZ S ISABEL LA CATOLICA', NULL, 179, 23, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1225, 'IE JOSE MANUEL R-JARDIN INF CARACOLES', NULL, 179, 10, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1226, 'IE 20 DE JULIO', NULL, 179, 35, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1227, 'IE BERTHA GEDEON DE BALADI', NULL, 179, 29, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1228, 'COLEGIO ALMIRANTE COLON  VISTA HERMOSA', NULL, 179, 21, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1229, 'IE SALIM BECHARA SEDE ALBORNOZ', NULL, 179, 5, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1230, 'IE LUIS CARLOS LOPEZ', NULL, 179, 35, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1231, 'IE TERNERA', NULL, 179, 28, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1232, 'IE SOLEDAD ACOSTA DE SAMPER', NULL, 179, 12, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1233, 'UNIVERSIDAD SAN BUENAVENTURA', NULL, 179, 38, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1234, 'COLEGIO BIFFI', NULL, 179, 10, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1235, 'CENTRO COMERCIAL PARQUE HEREDIA', NULL, 179, 2, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1236, 'COL FE Y ALEGRIA EL PROGRESO', NULL, 179, 30, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1237, 'IE SAN FRANCISCO ASIS - HIJO DE LOS AGRI', NULL, 179, 28, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1238, 'IE SAN LUCAS', NULL, 179, 11, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1239, 'IE POLICARPA SALAVARRIETA', NULL, 179, 6, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1240, 'IE MERCEDES ABREGO', NULL, 179, 55, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1241, 'COL SUE?????OS Y OPORTUNIDADES JES', NULL, 179, 31, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1242, 'IE MERCEDES ABREGO SEDE MEDELLIN', NULL, 179, 26, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1243, 'I.E. CIUDADELA 2000', NULL, 179, 15, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1244, 'I.E. SALVADOR MANDELA', NULL, 179, 22, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1245, 'I.E. ROSEDAL', NULL, 179, 17, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1246, 'IE JHON F KENNEDY', NULL, 179, 41, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1247, 'INST FEMENINO PROMOCION SOCIAL', NULL, 179, 41, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1248, 'I.E. NUESTRA SE?????ORA DE LA CONSOLATA', NULL, 179, 17, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1249, 'I.E. JUAN JOSE NIETO', NULL, 179, 22, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1250, 'COLEGIO COMFAMILIAR', NULL, 179, 34, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1251, 'ESC ANA MARIA PEREZ OTERO', NULL, 179, 38, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1252, 'IE PROM SOCIAL DE C/GENA SD LA CONSOLATA', NULL, 179, 8, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1253, 'IE AMBIENTALISTA CARTAGENA DE INDIAS', NULL, 179, 30, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1254, 'IE SEDE EMILIANO ALCALA ROMERO', NULL, 179, 6, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1255, 'I E REPUBLICA DE ARGENTINA', NULL, 179, 5, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1256, 'CENTRO COMERCIAL LA GRAN MANZANA', NULL, 179, 2, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1257, 'CARCEL DISTRITAL DE TERNERA', NULL, 179, 2, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1258, 'SANTA CRUZ DEL ISLOTE', NULL, 179, 2, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1259, 'BARU', NULL, 179, 8, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1260, 'BOCACHICA', NULL, 179, 19, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1261, 'CA?????O DE LORO', NULL, 179, 7, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1262, 'ISLA FUERTE', NULL, 179, 3, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1263, 'ISLAS DEL ROSARIO', NULL, 179, 2, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1264, 'SANTA ANA', NULL, 179, 13, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1265, 'TIERRABOMBA', NULL, 179, 9, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1266, 'I.E NUEVA ESPERANZA ARROYO GRANDE', NULL, 179, 6, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1267, 'ARROYO DE PIEDRA', NULL, 179, 7, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1268, 'BAYUNCA', NULL, 179, 28, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1269, 'LA BOQUILLA', NULL, 179, 27, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1270, 'PONTEZUELA', NULL, 179, 6, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1271, 'PUNTA CANOA', NULL, 179, 3, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1272, 'PASACABALLOS', NULL, 179, 33, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1273, 'PASACABALLOS - MEMBRILLAL', NULL, 179, 4, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1274, 'LA BOQUILLA 2', NULL, 179, 6, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1275, 'LA BOQUILLA 3', NULL, 179, 7, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1276, 'BAYUNCA 2 (SEDE LAS LATAS)', NULL, 179, 7, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1277, 'PASACABALLOS 2', NULL, 179, 1, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1278, 'TIERRABOMBA 2 PUNTA ARENA', NULL, 179, 1, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1279, 'ARROYO DE PIEDRA 2 ARROYO DE LAS CANOAS', NULL, 179, 1, '2026-02-03 02:11:05.179926', '2026-02-03 02:11:05.179926');
INSERT INTO public.voting_booths VALUES (1280, 'PUESTO CABECERA MUNICIPAL', NULL, 180, 26, '2026-02-03 02:11:44.09053', '2026-02-03 02:11:44.09053');
INSERT INTO public.voting_booths VALUES (1281, 'CAMPO SERENO', NULL, 180, 1, '2026-02-03 02:11:44.09053', '2026-02-03 02:11:44.09053');
INSERT INTO public.voting_booths VALUES (1282, 'LA PE?????A', NULL, 180, 4, '2026-02-03 02:11:44.09053', '2026-02-03 02:11:44.09053');
INSERT INTO public.voting_booths VALUES (1283, 'PUEBLO NUEVO', NULL, 180, 1, '2026-02-03 02:11:44.09053', '2026-02-03 02:11:44.09053');
INSERT INTO public.voting_booths VALUES (1284, 'SAN FRANCISCO DE LOBA', NULL, 180, 6, '2026-02-03 02:11:44.09053', '2026-02-03 02:11:44.09053');
INSERT INTO public.voting_booths VALUES (1285, 'SAN JAVIER', NULL, 180, 1, '2026-02-03 02:11:44.09053', '2026-02-03 02:11:44.09053');
INSERT INTO public.voting_booths VALUES (1286, 'PUESTO CABECERA MUNICIPAL', NULL, 181, 36, '2026-02-03 02:12:19.860887', '2026-02-03 02:12:19.860887');
INSERT INTO public.voting_booths VALUES (1287, 'EL PE?????IQUE', NULL, 181, 2, '2026-02-03 02:12:19.860887', '2026-02-03 02:12:19.860887');
INSERT INTO public.voting_booths VALUES (1288, 'LAS CARAS', NULL, 181, 3, '2026-02-03 02:12:19.860887', '2026-02-03 02:12:19.860887');
INSERT INTO public.voting_booths VALUES (1289, 'PUESTO CABECERA MUNICIPAL', NULL, 182, 16, '2026-02-03 02:12:54.751197', '2026-02-03 02:12:54.751197');
INSERT INTO public.voting_booths VALUES (1290, 'GUAIMARAL', NULL, 182, 4, '2026-02-03 02:12:54.751197', '2026-02-03 02:12:54.751197');
INSERT INTO public.voting_booths VALUES (1291, 'SAN ANDRES', NULL, 182, 7, '2026-02-03 02:12:54.751197', '2026-02-03 02:12:54.751197');
INSERT INTO public.voting_booths VALUES (1292, 'SINCELEJITO', NULL, 182, 3, '2026-02-03 02:12:54.751197', '2026-02-03 02:12:54.751197');
INSERT INTO public.voting_booths VALUES (1293, 'TACAMOCHO', NULL, 182, 6, '2026-02-03 02:12:54.751197', '2026-02-03 02:12:54.751197');
INSERT INTO public.voting_booths VALUES (1294, 'MARTIN ALONZO', NULL, 182, 5, '2026-02-03 02:12:54.751197', '2026-02-03 02:12:54.751197');
INSERT INTO public.voting_booths VALUES (1295, 'PUEBLO NUEVO', NULL, 182, 3, '2026-02-03 02:12:54.751197', '2026-02-03 02:12:54.751197');
INSERT INTO public.voting_booths VALUES (1296, 'SANTA LUCIA', NULL, 182, 2, '2026-02-03 02:12:54.751197', '2026-02-03 02:12:54.751197');
INSERT INTO public.voting_booths VALUES (1297, 'TACAMOCHITO', NULL, 182, 2, '2026-02-03 02:12:54.751197', '2026-02-03 02:12:54.751197');
INSERT INTO public.voting_booths VALUES (1298, 'VEREDA LA SIERRA', NULL, 182, 1, '2026-02-03 02:12:54.751197', '2026-02-03 02:12:54.751197');
INSERT INTO public.voting_booths VALUES (1299, 'IE AGROEMP JULIO CESAR TURBAY', NULL, 183, 17, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1300, 'IE ESPIRITU SANTO', NULL, 183, 17, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1301, 'IE GABRIEL GARCIA TABOADA', NULL, 183, 16, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1302, 'IE TEC AGROEMP GABRIELA MISTRAL', NULL, 183, 13, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1303, 'IE TEC AGRO GIOVANNI CRISTINI SEDE JFK', NULL, 183, 15, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1304, 'IE MARIA INMACULADA', NULL, 183, 19, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1305, 'IE MANUEL EDMUNDO MENDOZA', NULL, 183, 29, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1306, 'IE TEC IND JUAN FEDERICO HOLLMAN', NULL, 183, 31, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1307, 'BAJO GRANDE', NULL, 183, 2, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1308, 'CARACOLI', NULL, 183, 5, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1309, 'CENTRO ALEGRE', NULL, 183, 1, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1310, 'EL HOBO', NULL, 183, 4, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1311, 'EL SALADO', NULL, 183, 4, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1312, 'GUAMANGA', NULL, 183, 3, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1313, 'HATO NUEVO', NULL, 183, 1, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1314, 'JESUS DEL MONTE', NULL, 183, 1, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1315, 'CANZONA', NULL, 183, 3, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1316, 'LA SIERRA', NULL, 183, 1, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1317, 'MACAYEPO', NULL, 183, 4, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1318, 'LAZARO', NULL, 183, 2, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1319, 'ARENAS', NULL, 183, 1, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1320, 'RAIZAL SANTA LUCIA', NULL, 183, 2, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1321, 'SAN CARLOS', NULL, 183, 2, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1322, 'SAN ISIDRO', NULL, 183, 4, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1323, 'SANTO DOMINGO DE MEZA', NULL, 183, 2, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1324, 'VERDUM', NULL, 183, 2, '2026-02-03 02:13:39.60481', '2026-02-03 02:13:39.60481');
INSERT INTO public.voting_booths VALUES (1325, 'PUESTO CABECERA MUNICIPAL', NULL, 184, 14, '2026-02-03 02:14:26.831236', '2026-02-03 02:14:26.831236');
INSERT INTO public.voting_booths VALUES (1326, 'LA ENEA', NULL, 184, 2, '2026-02-03 02:14:26.831236', '2026-02-03 02:14:26.831236');
INSERT INTO public.voting_booths VALUES (1327, 'LATA', NULL, 184, 2, '2026-02-03 02:14:26.831236', '2026-02-03 02:14:26.831236');
INSERT INTO public.voting_booths VALUES (1328, 'NERVITI', NULL, 184, 4, '2026-02-03 02:14:26.831236', '2026-02-03 02:14:26.831236');
INSERT INTO public.voting_booths VALUES (1329, 'ROBLES', NULL, 184, 5, '2026-02-03 02:14:26.831236', '2026-02-03 02:14:26.831236');
INSERT INTO public.voting_booths VALUES (1330, 'TASAJERA', NULL, 184, 1, '2026-02-03 02:14:26.831236', '2026-02-03 02:14:26.831236');
INSERT INTO public.voting_booths VALUES (1331, 'PUESTO CABECERA MUNICIPAL', NULL, 185, 10, '2026-02-03 02:15:05.712959', '2026-02-03 02:15:05.712959');
INSERT INTO public.voting_booths VALUES (1332, 'BUENOS AIRES', NULL, 185, 2, '2026-02-03 02:15:05.712959', '2026-02-03 02:15:05.712959');
INSERT INTO public.voting_booths VALUES (1333, 'CASTA?????AL', NULL, 185, 2, '2026-02-03 02:15:05.712959', '2026-02-03 02:15:05.712959');
INSERT INTO public.voting_booths VALUES (1334, 'CHAPETONA', NULL, 185, 3, '2026-02-03 02:15:05.712959', '2026-02-03 02:15:05.712959');
INSERT INTO public.voting_booths VALUES (1335, 'LA HUMAREDA', NULL, 185, 2, '2026-02-03 02:15:05.712959', '2026-02-03 02:15:05.712959');
INSERT INTO public.voting_booths VALUES (1336, 'EL JAPON', NULL, 185, 1, '2026-02-03 02:15:05.712959', '2026-02-03 02:15:05.712959');
INSERT INTO public.voting_booths VALUES (1337, 'PE?????ONCITO', NULL, 185, 4, '2026-02-03 02:15:05.712959', '2026-02-03 02:15:05.712959');
INSERT INTO public.voting_booths VALUES (1338, 'PUESTO CABECERA MUNICIPAL', NULL, 186, 13, '2026-02-03 02:15:49.931385', '2026-02-03 02:15:49.931385');
INSERT INTO public.voting_booths VALUES (1339, 'CERRO DE LAS AGUADAS', NULL, 186, 1, '2026-02-03 02:15:49.931385', '2026-02-03 02:15:49.931385');
INSERT INTO public.voting_booths VALUES (1340, 'EL POZON', NULL, 186, 2, '2026-02-03 02:15:49.931385', '2026-02-03 02:15:49.931385');
INSERT INTO public.voting_booths VALUES (1341, 'JUANA SANCHEZ', NULL, 186, 4, '2026-02-03 02:15:49.931385', '2026-02-03 02:15:49.931385');
INSERT INTO public.voting_booths VALUES (1342, 'LA RIBONA', NULL, 186, 4, '2026-02-03 02:15:49.931385', '2026-02-03 02:15:49.931385');
INSERT INTO public.voting_booths VALUES (1343, 'LA VICTORIA', NULL, 186, 8, '2026-02-03 02:15:49.931385', '2026-02-03 02:15:49.931385');
INSERT INTO public.voting_booths VALUES (1344, 'LAS BRISAS', NULL, 186, 2, '2026-02-03 02:15:49.931385', '2026-02-03 02:15:49.931385');
INSERT INTO public.voting_booths VALUES (1345, 'PUEBLO NUEVO', NULL, 186, 2, '2026-02-03 02:15:49.931385', '2026-02-03 02:15:49.931385');
INSERT INTO public.voting_booths VALUES (1346, 'SAN MIGUEL', NULL, 186, 6, '2026-02-03 02:15:49.931385', '2026-02-03 02:15:49.931385');
INSERT INTO public.voting_booths VALUES (1347, 'COLEGIO COMUNAL VERSALLES SD SUR', NULL, 187, 15, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1348, 'COLEGIO DPTAL YATI', NULL, 187, 12, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1349, 'I.E.COMUNAL VERSALLES SEDE PAL', NULL, 187, 22, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1350, 'I.E.COM. VERSALLES S.ILUSION', NULL, 187, 8, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1351, 'I.E. LICEO MODERNO DE LA CANDELARIA', NULL, 187, 13, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1352, 'INST.EDUC.SAN JOSE N.1', NULL, 187, 18, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1353, 'COLISEO CUBIERTO DE ALTO R.', NULL, 187, 36, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1354, 'LICEO JOAQUIN FDO. VELEZ', NULL, 187, 21, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1355, 'ESC. OFICIAL CAMILO TORRES', NULL, 187, 9, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1356, 'I.E. SAN JOSE No. 2', NULL, 187, 28, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1357, 'IE LICEO MODERNO', NULL, 187, 8, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1358, 'CARCEL', NULL, 187, 1, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1359, 'BARBOSA', NULL, 187, 5, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1360, 'BARRANCA DE YUCA', NULL, 187, 9, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1361, 'BETANIA', NULL, 187, 2, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1362, 'BOCAS DE SAN ANTONIO', NULL, 187, 2, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1363, 'CASCAJAL', NULL, 187, 13, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1364, 'CEIBAL', NULL, 187, 4, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1365, 'COYONGAL', NULL, 187, 3, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1366, 'EL CUATRO', NULL, 187, 4, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1367, 'GUAZO', NULL, 187, 2, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1368, 'HENEQUEN', NULL, 187, 7, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1369, 'EMAUS', NULL, 187, 2, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1370, 'ISLA GRANDE', NULL, 187, 4, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1371, 'JUAN ARIAS', NULL, 187, 5, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1372, 'LA PASCUALA', NULL, 187, 7, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1373, 'LAS BRISAS', NULL, 187, 3, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1374, 'MADRID', NULL, 187, 4, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1375, 'PANSEGUITA', NULL, 187, 3, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1376, 'PALMARITO', NULL, 187, 2, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1377, 'PI?????ALITO', NULL, 187, 5, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1378, 'PLAYA DE LAS FLORES', NULL, 187, 1, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1379, 'PUERTO KENNEDY', NULL, 187, 2, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1380, 'PUNTA DE CARTAGENA', NULL, 187, 2, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1381, 'EL RETIRO', NULL, 187, 5, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1382, 'PUERTO NARI?????O', NULL, 187, 2, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1383, 'ROMA', NULL, 187, 1, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1384, 'SAN ANTO?????ITO', NULL, 187, 1, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1385, 'SAN JOSE DE LAS MARTAS', NULL, 187, 2, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1386, 'SAN RAFAEL DE CORTINA', NULL, 187, 4, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1387, 'SAN SEBASTIAN DE BUENAVISTA', NULL, 187, 3, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1388, 'SANTA COITA', NULL, 187, 1, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1389, 'SANTA FE', NULL, 187, 6, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1390, 'SANTA LUCIA', NULL, 187, 4, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1391, 'SANTA MONICA', NULL, 187, 1, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1392, 'SANTA PABLA', NULL, 187, 2, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1393, 'SITIONUEVO', NULL, 187, 4, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1394, 'TACALOA', NULL, 187, 3, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1395, 'TACASALUMA', NULL, 187, 4, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1396, 'TRES PUNTAS', NULL, 187, 1, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1397, 'TOLU', NULL, 187, 2, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1398, 'LA VENTURA', NULL, 187, 5, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1399, 'SABANETA', NULL, 187, 1, '2026-02-03 02:16:38.416', '2026-02-03 02:16:38.416');
INSERT INTO public.voting_booths VALUES (1400, 'IE CAMILO TORRES SD NUESTRA SE?????ORA DEL C', NULL, 188, 17, '2026-02-03 02:17:16.786245', '2026-02-03 02:17:16.786245');
INSERT INTO public.voting_booths VALUES (1401, 'IE CAMILO TORRES SD SAGRADO CORAZON DE J', NULL, 188, 17, '2026-02-03 02:17:16.786245', '2026-02-03 02:17:16.786245');
INSERT INTO public.voting_booths VALUES (1402, 'EVITAR', NULL, 188, 5, '2026-02-03 02:17:16.786245', '2026-02-03 02:17:16.786245');
INSERT INTO public.voting_booths VALUES (1403, 'GAMERO', NULL, 188, 4, '2026-02-03 02:17:16.786245', '2026-02-03 02:17:16.786245');
INSERT INTO public.voting_booths VALUES (1404, 'MALAGANA', NULL, 188, 16, '2026-02-03 02:17:16.786245', '2026-02-03 02:17:16.786245');
INSERT INTO public.voting_booths VALUES (1405, 'MANDINGA', NULL, 188, 2, '2026-02-03 02:17:16.786245', '2026-02-03 02:17:16.786245');
INSERT INTO public.voting_booths VALUES (1406, 'SAN BASILIO DEL PALENQUE', NULL, 188, 8, '2026-02-03 02:17:16.786245', '2026-02-03 02:17:16.786245');
INSERT INTO public.voting_booths VALUES (1407, 'SAN JOAQUIN', NULL, 188, 3, '2026-02-03 02:17:16.786245', '2026-02-03 02:17:16.786245');
INSERT INTO public.voting_booths VALUES (1408, 'I.E.DE MARGARITA - SEDE MARIA BERNARDA', NULL, 189, 8, '2026-02-03 02:19:48.871708', '2026-02-03 02:19:48.871708');
INSERT INTO public.voting_booths VALUES (1409, 'BOTON DE LEIVA', NULL, 189, 2, '2026-02-03 02:19:48.871708', '2026-02-03 02:19:48.871708');
INSERT INTO public.voting_booths VALUES (1410, 'CAUSADO', NULL, 189, 2, '2026-02-03 02:19:48.871708', '2026-02-03 02:19:48.871708');
INSERT INTO public.voting_booths VALUES (1411, 'CANTERA', NULL, 189, 2, '2026-02-03 02:19:48.871708', '2026-02-03 02:19:48.871708');
INSERT INTO public.voting_booths VALUES (1412, 'CA?????O MONO', NULL, 189, 1, '2026-02-03 02:19:48.871708', '2026-02-03 02:19:48.871708');
INSERT INTO public.voting_booths VALUES (1413, 'COROCITO', NULL, 189, 2, '2026-02-03 02:19:48.871708', '2026-02-03 02:19:48.871708');
INSERT INTO public.voting_booths VALUES (1414, 'CHILLOA', NULL, 189, 3, '2026-02-03 02:19:48.871708', '2026-02-03 02:19:48.871708');
INSERT INTO public.voting_booths VALUES (1415, 'DO?????A JUANA', NULL, 189, 3, '2026-02-03 02:19:48.871708', '2026-02-03 02:19:48.871708');
INSERT INTO public.voting_booths VALUES (1416, 'GUATACA SUR', NULL, 189, 4, '2026-02-03 02:19:48.871708', '2026-02-03 02:19:48.871708');
INSERT INTO public.voting_booths VALUES (1417, 'LA MONTA?????A', NULL, 189, 2, '2026-02-03 02:19:48.871708', '2026-02-03 02:19:48.871708');
INSERT INTO public.voting_booths VALUES (1418, 'MAMONCITO', NULL, 189, 5, '2026-02-03 02:19:48.871708', '2026-02-03 02:19:48.871708');
INSERT INTO public.voting_booths VALUES (1419, 'SAN JOSE', NULL, 189, 2, '2026-02-03 02:19:48.871708', '2026-02-03 02:19:48.871708');
INSERT INTO public.voting_booths VALUES (1420, 'SANDOVAL', NULL, 189, 2, '2026-02-03 02:19:48.871708', '2026-02-03 02:19:48.871708');
INSERT INTO public.voting_booths VALUES (1421, 'I.E.T.A . D. D.R SEDE LAS DELI', NULL, 190, 12, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1422, 'I.E. RAFAEL URIBE URIBE SEDE 4', NULL, 190, 11, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1423, 'CENTRO DE INTEGRACION CIUDADANA CIC', NULL, 190, 10, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1424, 'I.E. RAFAEL URIBE URIBE SEDE 1', NULL, 190, 19, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1425, 'I.E TEC ACUICOLA SAN FRANCSICO', NULL, 190, 13, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1426, 'IETAE SAN FRANCISCO ASIS SD PTO SANT.', NULL, 190, 2, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1427, 'INSTITUCI?????N EDUCATIVA SAN LUIS BELTRAN', NULL, 190, 2, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1428, 'CORREA', NULL, 190, 3, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1429, 'ARROYO GRANDE', NULL, 190, 3, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1430, 'COL?????', NULL, 190, 2, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1431, 'EL NISPERO', NULL, 190, 5, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1432, 'FLAMENCO', NULL, 190, 3, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1433, 'LOS BELLOS', NULL, 190, 5, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1434, 'MAMPUJAN', NULL, 190, 3, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1435, 'MATUYA', NULL, 190, 7, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1436, 'NUEVA FLORIDA', NULL, 190, 7, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1437, '?????ANGUMA', NULL, 190, 3, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1438, 'RETIRO NUEVO', NULL, 190, 6, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1439, 'SAN JOSE DEL PLAYON', NULL, 190, 10, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1440, 'SAN PABLO', NULL, 190, 14, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1441, 'PUEBLO NUEVO', NULL, 190, 1, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1442, 'SAN PABLO 2 PRIMERO DE JULIO', NULL, 190, 4, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1443, 'EL SENA', NULL, 190, 2, '2026-02-03 02:20:43.482699', '2026-02-03 02:20:43.482699');
INSERT INTO public.voting_booths VALUES (1444, 'IE TEC COL NAL PINILLOS SD M AUXILIADORA', NULL, 191, 16, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1445, 'IE TEC AGRO T. NAJERA SD A HEREDIA', NULL, 191, 18, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1446, 'IE TEC COL NAL PINILLOS', NULL, 191, 18, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1447, 'COL STA CRUZ DE MOMPOS', NULL, 191, 16, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1448, 'CALDERA', NULL, 191, 3, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1449, 'ANCON', NULL, 191, 2, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1450, 'CANDELARIA', NULL, 191, 4, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1451, 'EL CARMEN DE CICUCO', NULL, 191, 2, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1452, 'EL ROSARIO', NULL, 191, 1, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1453, 'BOMBA', NULL, 191, 1, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1454, 'GUAIMARAL', NULL, 191, 3, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1455, 'GUATACA', NULL, 191, 6, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1456, 'LA LOBATA', NULL, 191, 3, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1457, 'LA RINCONADA', NULL, 191, 7, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1458, 'LA JAGUA', NULL, 191, 1, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1459, 'LA TRAVESIA', NULL, 191, 2, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1460, 'LAS BOQUILLAS', NULL, 191, 5, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1461, 'LOMA DE SIMON', NULL, 191, 3, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1462, 'LOS PI?????ONES', NULL, 191, 2, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1463, 'PUEBLO NUEVO', NULL, 191, 1, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1464, 'SAN IGNACIO', NULL, 191, 2, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1465, 'SAN LUIS', NULL, 191, 1, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1466, 'SAN NICOLAS', NULL, 191, 2, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1467, 'SANTA CRUZ', NULL, 191, 4, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1468, 'SANTA ELENA', NULL, 191, 1, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1469, 'SANTA ROSA', NULL, 191, 2, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1470, 'SANTA TERESITA', NULL, 191, 5, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1471, 'VILLANUEVA', NULL, 191, 1, '2026-02-03 02:21:32.1191', '2026-02-03 02:21:32.1191');
INSERT INTO public.voting_booths VALUES (1472, 'PUESTO CABECERA MUNICIPAL', NULL, 192, 17, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1473, 'ALTO CARIBONA', NULL, 192, 1, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1474, 'BETANIA', NULL, 192, 2, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1475, 'CAMPO ALEGRE', NULL, 192, 1, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1476, 'EL PARAISO', NULL, 192, 2, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1477, 'EL DORADO', NULL, 192, 1, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1478, 'PLATANAL', NULL, 192, 1, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1479, 'PUEBLO LINDO', NULL, 192, 2, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1480, 'PUERTO ESPA?????A', NULL, 192, 1, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1481, 'REGENERACION', NULL, 192, 3, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1482, 'SAN AGUSTIN', NULL, 192, 2, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1483, 'SAN MATEO', NULL, 192, 1, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1484, 'TABURETERA', NULL, 192, 1, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1485, 'VILLA ESPERANZA', NULL, 192, 1, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1486, 'VILLA URIBE', NULL, 192, 2, '2026-02-03 02:22:16.955491', '2026-02-03 02:22:16.955491');
INSERT INTO public.voting_booths VALUES (1487, 'CDI UN MUNDO DE AMOR', NULL, 193, 22, '2026-02-03 02:22:44.62589', '2026-02-03 02:22:44.62589');
INSERT INTO public.voting_booths VALUES (1488, 'BOCA DE LA HONDA', NULL, 193, 2, '2026-02-03 02:22:44.62589', '2026-02-03 02:22:44.62589');
INSERT INTO public.voting_booths VALUES (1489, 'BODEGA CENTRAL', NULL, 193, 3, '2026-02-03 02:22:44.62589', '2026-02-03 02:22:44.62589');
INSERT INTO public.voting_booths VALUES (1490, 'EL DIQUE', NULL, 193, 3, '2026-02-03 02:22:44.62589', '2026-02-03 02:22:44.62589');
INSERT INTO public.voting_booths VALUES (1491, 'CORCOBADO', NULL, 193, 2, '2026-02-03 02:22:44.62589', '2026-02-03 02:22:44.62589');
INSERT INTO public.voting_booths VALUES (1492, 'LA PALMA', NULL, 193, 2, '2026-02-03 02:22:44.62589', '2026-02-03 02:22:44.62589');
INSERT INTO public.voting_booths VALUES (1493, 'LA ESMERALDA', NULL, 193, 2, '2026-02-03 02:22:44.62589', '2026-02-03 02:22:44.62589');
INSERT INTO public.voting_booths VALUES (1494, 'LAS PAILAS', NULL, 193, 2, '2026-02-03 02:22:44.62589', '2026-02-03 02:22:44.62589');
INSERT INTO public.voting_booths VALUES (1495, 'MICOAHUMADO', NULL, 193, 4, '2026-02-03 02:22:44.62589', '2026-02-03 02:22:44.62589');
INSERT INTO public.voting_booths VALUES (1496, 'MINA GALLO', NULL, 193, 2, '2026-02-03 02:22:44.62589', '2026-02-03 02:22:44.62589');
INSERT INTO public.voting_booths VALUES (1497, 'PAREDES DE ORORIA', NULL, 193, 1, '2026-02-03 02:22:44.62589', '2026-02-03 02:22:44.62589');
INSERT INTO public.voting_booths VALUES (1498, 'PUESTO CABECERA MUNICIPAL', NULL, 194, 9, '2026-02-03 02:24:36.139757', '2026-02-03 02:24:36.139757');
INSERT INTO public.voting_booths VALUES (1499, 'BUENA SE?????A', NULL, 194, 3, '2026-02-03 02:24:36.139757', '2026-02-03 02:24:36.139757');
INSERT INTO public.voting_booths VALUES (1500, 'IE NOROSI SEDE EL BEBEDERO', NULL, 194, 1, '2026-02-03 02:24:36.139757', '2026-02-03 02:24:36.139757');
INSERT INTO public.voting_booths VALUES (1501, 'IE NOROSI SEDE LAS NIEVES', NULL, 194, 1, '2026-02-03 02:24:36.139757', '2026-02-03 02:24:36.139757');
INSERT INTO public.voting_booths VALUES (1502, 'CASA DE BARRO', NULL, 194, 1, '2026-02-03 02:24:36.139757', '2026-02-03 02:24:36.139757');
INSERT INTO public.voting_booths VALUES (1503, 'OLIVARES', NULL, 194, 1, '2026-02-03 02:24:36.139757', '2026-02-03 02:24:36.139757');
INSERT INTO public.voting_booths VALUES (1504, 'SANTA ELENA', NULL, 194, 2, '2026-02-03 02:24:36.139757', '2026-02-03 02:24:36.139757');
INSERT INTO public.voting_booths VALUES (1505, 'MINA BRISA', NULL, 194, 2, '2026-02-03 02:24:36.139757', '2026-02-03 02:24:36.139757');
INSERT INTO public.voting_booths VALUES (1506, 'MINA ESTRELLA', NULL, 194, 1, '2026-02-03 02:24:36.139757', '2026-02-03 02:24:36.139757');
INSERT INTO public.voting_booths VALUES (1507, 'VILLA ARIZA', NULL, 194, 1, '2026-02-03 02:24:36.139757', '2026-02-03 02:24:36.139757');
INSERT INTO public.voting_booths VALUES (1508, 'PUESTO CABECERA MUNICIPAL', NULL, 195, 15, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1509, 'ARMENIA', NULL, 195, 6, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1510, 'BUENOS AIRES', NULL, 195, 1, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1511, 'EL LIBANO', NULL, 195, 1, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1512, 'LA RUFINA', NULL, 195, 1, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1513, 'LA UNION', NULL, 195, 1, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1514, 'LAS CONCHITAS', NULL, 195, 4, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1515, 'LAS FLORES', NULL, 195, 3, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1516, 'LA UNION (CABECERA)', NULL, 195, 2, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1517, 'LA VICTORIA', NULL, 195, 2, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1518, 'MANTEQUERA', NULL, 195, 3, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1519, 'NICARAGUA', NULL, 195, 2, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1520, 'PALENQUITO', NULL, 195, 7, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1521, 'INSTITUCION EDUCATIVA DE PALOMINO', NULL, 195, 4, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1522, 'PUERTO LOPEZ', NULL, 195, 5, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1523, 'PUERTO NUEVO', NULL, 195, 1, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1524, 'PUERTO BELLO', NULL, 195, 1, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1525, 'SANTA COA', NULL, 195, 2, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1526, 'SAN FRANCISCO', NULL, 195, 1, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1527, 'SANTA ELENA (EL ESTOPAL)', NULL, 195, 1, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1528, 'SANTA ROSA', NULL, 195, 2, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1529, 'TAPOA', NULL, 195, 2, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1530, 'VIDA TRANQUILA', NULL, 195, 1, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1531, 'LOS LIMONES', NULL, 195, 2, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1532, 'MONTECELIO', NULL, 195, 1, '2026-02-03 02:25:29.672036', '2026-02-03 02:25:29.672036');
INSERT INTO public.voting_booths VALUES (1533, 'PUESTO CABECERA MUNICIPAL', NULL, 196, 11, '2026-02-03 02:26:08.869602', '2026-02-03 02:26:08.869602');
INSERT INTO public.voting_booths VALUES (1534, 'EL PI?????AL', NULL, 196, 1, '2026-02-03 02:26:08.869602', '2026-02-03 02:26:08.869602');
INSERT INTO public.voting_booths VALUES (1535, 'LOS CAIMANES', NULL, 196, 1, '2026-02-03 02:26:08.869602', '2026-02-03 02:26:08.869602');
INSERT INTO public.voting_booths VALUES (1536, 'SAN ANTONIO', NULL, 196, 2, '2026-02-03 02:26:08.869602', '2026-02-03 02:26:08.869602');
INSERT INTO public.voting_booths VALUES (1537, 'SAN CAYETANO', NULL, 196, 2, '2026-02-03 02:26:08.869602', '2026-02-03 02:26:08.869602');
INSERT INTO public.voting_booths VALUES (1538, 'SANTA TERESA', NULL, 196, 3, '2026-02-03 02:26:08.869602', '2026-02-03 02:26:08.869602');
INSERT INTO public.voting_booths VALUES (1539, 'PUESTO CABECERA MUNICIPAL', NULL, 197, 16, '2026-02-03 02:26:41.044067', '2026-02-03 02:26:41.044067');
INSERT INTO public.voting_booths VALUES (1540, 'CAMPO ALEGRE', NULL, 197, 1, '2026-02-03 02:26:41.044067', '2026-02-03 02:26:41.044067');
INSERT INTO public.voting_booths VALUES (1541, 'COBADILLO', NULL, 197, 2, '2026-02-03 02:26:41.044067', '2026-02-03 02:26:41.044067');
INSERT INTO public.voting_booths VALUES (1542, 'CAIMITAL', NULL, 197, 2, '2026-02-03 02:26:41.044067', '2026-02-03 02:26:41.044067');
INSERT INTO public.voting_booths VALUES (1543, 'HATILLO', NULL, 197, 1, '2026-02-03 02:26:41.044067', '2026-02-03 02:26:41.044067');
INSERT INTO public.voting_booths VALUES (1544, 'BLANCAS PALOMAS', NULL, 197, 1, '2026-02-03 02:26:41.044067', '2026-02-03 02:26:41.044067');
INSERT INTO public.voting_booths VALUES (1545, 'MACEDONIA', NULL, 197, 2, '2026-02-03 02:26:41.044067', '2026-02-03 02:26:41.044067');
INSERT INTO public.voting_booths VALUES (1546, 'INSTITUCION EDUC SAN CRISTOBAL SEDE - 01', NULL, 198, 20, '2026-02-03 02:28:16.310866', '2026-02-03 02:28:16.310866');
INSERT INTO public.voting_booths VALUES (1547, 'HIGUERETAL', NULL, 198, 5, '2026-02-03 02:28:16.310866', '2026-02-03 02:28:16.310866');
INSERT INTO public.voting_booths VALUES (1548, 'INSTITUCION EDUC MAURICIO NELSON VISBAL', NULL, 199, 37, '2026-02-03 02:29:03.952083', '2026-02-03 02:29:03.952083');
INSERT INTO public.voting_booths VALUES (1549, 'LAS PIEDRAS', NULL, 199, 14, '2026-02-03 02:29:03.952083', '2026-02-03 02:29:03.952083');
INSERT INTO public.voting_booths VALUES (1550, 'PUESTO CABECERA MUNICIPAL', NULL, 200, 8, '2026-02-03 02:29:43.534874', '2026-02-03 02:29:43.534874');
INSERT INTO public.voting_booths VALUES (1551, 'GUASIMAL', NULL, 200, 3, '2026-02-03 02:29:43.534874', '2026-02-03 02:29:43.534874');
INSERT INTO public.voting_booths VALUES (1552, 'EL PALMAR', NULL, 200, 2, '2026-02-03 02:29:43.534874', '2026-02-03 02:29:43.534874');
INSERT INTO public.voting_booths VALUES (1553, 'EL GATO', NULL, 200, 1, '2026-02-03 02:29:43.534874', '2026-02-03 02:29:43.534874');
INSERT INTO public.voting_booths VALUES (1554, 'CENTRO DE VIDA', NULL, 200, 3, '2026-02-03 02:29:43.534874', '2026-02-03 02:29:43.534874');
INSERT INTO public.voting_booths VALUES (1555, 'JOLON', NULL, 200, 1, '2026-02-03 02:29:43.534874', '2026-02-03 02:29:43.534874');
INSERT INTO public.voting_booths VALUES (1556, 'PORVENIR', NULL, 200, 1, '2026-02-03 02:29:43.534874', '2026-02-03 02:29:43.534874');
INSERT INTO public.voting_booths VALUES (1557, 'PUNTA DE HORNOS', NULL, 200, 3, '2026-02-03 02:29:43.534874', '2026-02-03 02:29:43.534874');
INSERT INTO public.voting_booths VALUES (1558, 'SANTA ROSA', NULL, 200, 6, '2026-02-03 02:29:43.534874', '2026-02-03 02:29:43.534874');
INSERT INTO public.voting_booths VALUES (1559, 'EL CONTADERO', NULL, 200, 2, '2026-02-03 02:29:43.534874', '2026-02-03 02:29:43.534874');
INSERT INTO public.voting_booths VALUES (1560, 'LA GUADUA', NULL, 200, 2, '2026-02-03 02:29:43.534874', '2026-02-03 02:29:43.534874');
INSERT INTO public.voting_booths VALUES (1561, 'LAS CUEVAS', NULL, 200, 3, '2026-02-03 02:29:43.534874', '2026-02-03 02:29:43.534874');
INSERT INTO public.voting_booths VALUES (1562, 'PAMPANILLO', NULL, 200, 1, '2026-02-03 02:29:43.534874', '2026-02-03 02:29:43.534874');
INSERT INTO public.voting_booths VALUES (1563, 'I.E. PIO XII', NULL, 201, 18, '2026-02-03 02:30:45.510805', '2026-02-03 02:30:45.510805');
INSERT INTO public.voting_booths VALUES (1564, 'I.E. LEON XIII - SEDE SANTA LUCIA', NULL, 201, 12, '2026-02-03 02:30:45.510805', '2026-02-03 02:30:45.510805');
INSERT INTO public.voting_booths VALUES (1565, 'I.E. PIO XII - SD RAFAEL NU?????EZ', NULL, 201, 16, '2026-02-03 02:30:45.510805', '2026-02-03 02:30:45.510805');
INSERT INTO public.voting_booths VALUES (1566, 'I.E. LEON XIII - SEDE LA ANUCIACION', NULL, 201, 18, '2026-02-03 02:30:45.510805', '2026-02-03 02:30:45.510805');
INSERT INTO public.voting_booths VALUES (1567, 'ARENAS', NULL, 201, 1, '2026-02-03 02:30:45.510805', '2026-02-03 02:30:45.510805');
INSERT INTO public.voting_booths VALUES (1568, 'BAJO GRANDE', NULL, 201, 1, '2026-02-03 02:30:45.510805', '2026-02-03 02:30:45.510805');
INSERT INTO public.voting_booths VALUES (1569, 'EL PARAISO', NULL, 201, 2, '2026-02-03 02:30:45.510805', '2026-02-03 02:30:45.510805');
INSERT INTO public.voting_booths VALUES (1570, 'LAS CHARQUITAS', NULL, 201, 1, '2026-02-03 02:30:45.510805', '2026-02-03 02:30:45.510805');
INSERT INTO public.voting_booths VALUES (1571, 'LAS PALMAS', NULL, 201, 1, '2026-02-03 02:30:45.510805', '2026-02-03 02:30:45.510805');
INSERT INTO public.voting_booths VALUES (1572, 'LAS MERCEDES', NULL, 201, 1, '2026-02-03 02:30:45.510805', '2026-02-03 02:30:45.510805');
INSERT INTO public.voting_booths VALUES (1573, 'SAN CRISTOBAL', NULL, 201, 1, '2026-02-03 02:30:45.510805', '2026-02-03 02:30:45.510805');
INSERT INTO public.voting_booths VALUES (1574, 'PUESTO CABECERA MUNICIPAL', NULL, 202, 11, '2026-02-03 02:31:15.877308', '2026-02-03 02:31:15.877308');
INSERT INTO public.voting_booths VALUES (1575, 'ASTILLEROS', NULL, 202, 2, '2026-02-03 02:31:15.877308', '2026-02-03 02:31:15.877308');
INSERT INTO public.voting_booths VALUES (1576, 'BERMUDEZ', NULL, 202, 2, '2026-02-03 02:31:15.877308', '2026-02-03 02:31:15.877308');
INSERT INTO public.voting_booths VALUES (1577, 'CAIMITAL', NULL, 202, 1, '2026-02-03 02:31:15.877308', '2026-02-03 02:31:15.877308');
INSERT INTO public.voting_booths VALUES (1578, 'GALINDO', NULL, 202, 2, '2026-02-03 02:31:15.877308', '2026-02-03 02:31:15.877308');
INSERT INTO public.voting_booths VALUES (1579, 'LA RAYA', NULL, 202, 2, '2026-02-03 02:31:15.877308', '2026-02-03 02:31:15.877308');
INSERT INTO public.voting_booths VALUES (1580, 'TENCHE', NULL, 202, 4, '2026-02-03 02:31:15.877308', '2026-02-03 02:31:15.877308');
INSERT INTO public.voting_booths VALUES (1581, 'MEJICO', NULL, 202, 2, '2026-02-03 02:31:15.877308', '2026-02-03 02:31:15.877308');
INSERT INTO public.voting_booths VALUES (1582, 'IE NORMAL SUP MONTES DE MARIA SD EL PROG', NULL, 203, 22, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1583, 'INS.ED.DIOGENES ARRIETA ARRIB', NULL, 203, 10, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1584, 'INS.ED.NOR.SUP.M.DE MARIA PRI', NULL, 203, 13, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1585, 'INS.ED.LA FLORESTA SAN JOSE', NULL, 203, 11, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1586, 'IE TECNICA AGROPECUARIA RODOLFO BARRIOS', NULL, 203, 14, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1587, 'IE TECNICA EN SISTEMAS LA FLORESTA SD P', NULL, 203, 12, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1588, 'CORRALITO', NULL, 203, 1, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1589, 'SAN PEDRO CONSOLADO', NULL, 203, 4, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1590, 'LA HAYA', NULL, 203, 1, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1591, 'SAN JOSE DEL PE?????ON', NULL, 203, 1, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1592, 'SAN AGUSTIN', NULL, 203, 2, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1593, 'SAN CAYETANO', NULL, 203, 7, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1594, 'SAN CAYETANO BACHILLERATO', NULL, 203, 7, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1595, 'SAN CAYETANO - ARROYO HONDO', NULL, 203, 1, '2026-02-03 02:31:56.807375', '2026-02-03 02:31:56.807375');
INSERT INTO public.voting_booths VALUES (1596, 'PUESTO CABECERA MUNICIPAL', NULL, 204, 25, '2026-02-03 02:32:38.18979', '2026-02-03 02:32:38.18979');
INSERT INTO public.voting_booths VALUES (1597, 'CHIMI', NULL, 204, 6, '2026-02-03 02:32:38.18979', '2026-02-03 02:32:38.18979');
INSERT INTO public.voting_booths VALUES (1598, 'EL VARAL', NULL, 204, 1, '2026-02-03 02:32:38.18979', '2026-02-03 02:32:38.18979');
INSERT INTO public.voting_booths VALUES (1599, 'JOBO', NULL, 204, 1, '2026-02-03 02:32:38.18979', '2026-02-03 02:32:38.18979');
INSERT INTO public.voting_booths VALUES (1600, 'PAPAYAL', NULL, 204, 3, '2026-02-03 02:32:38.18979', '2026-02-03 02:32:38.18979');
INSERT INTO public.voting_booths VALUES (1601, 'PLAYITAS', NULL, 204, 3, '2026-02-03 02:32:38.18979', '2026-02-03 02:32:38.18979');
INSERT INTO public.voting_booths VALUES (1602, 'PUEBLO NVO CERRO DE JULIO', NULL, 204, 2, '2026-02-03 02:32:38.18979', '2026-02-03 02:32:38.18979');
INSERT INTO public.voting_booths VALUES (1603, 'PUESTO CABECERA MUNICIPAL', NULL, 205, 56, '2026-02-03 02:33:16.824957', '2026-02-03 02:33:16.824957');
INSERT INTO public.voting_booths VALUES (1604, 'CANALETAL', NULL, 205, 2, '2026-02-03 02:33:16.824957', '2026-02-03 02:33:16.824957');
INSERT INTO public.voting_booths VALUES (1605, 'VALLECITO', NULL, 205, 1, '2026-02-03 02:33:16.824957', '2026-02-03 02:33:16.824957');
INSERT INTO public.voting_booths VALUES (1606, 'AGUASUCIA', NULL, 205, 1, '2026-02-03 02:33:16.824957', '2026-02-03 02:33:16.824957');
INSERT INTO public.voting_booths VALUES (1607, 'EL CARMEN', NULL, 205, 1, '2026-02-03 02:33:16.824957', '2026-02-03 02:33:16.824957');
INSERT INTO public.voting_booths VALUES (1608, 'CA?????ABRAVAL', NULL, 205, 1, '2026-02-03 02:33:16.824957', '2026-02-03 02:33:16.824957');
INSERT INTO public.voting_booths VALUES (1609, 'EL SOCORRO', NULL, 205, 1, '2026-02-03 02:33:16.824957', '2026-02-03 02:33:16.824957');
INSERT INTO public.voting_booths VALUES (1610, 'LA VIRGENCITA', NULL, 205, 1, '2026-02-03 02:33:16.824957', '2026-02-03 02:33:16.824957');
INSERT INTO public.voting_booths VALUES (1611, 'POZO AZUL', NULL, 205, 2, '2026-02-03 02:33:16.824957', '2026-02-03 02:33:16.824957');
INSERT INTO public.voting_booths VALUES (1612, 'CERRO AZUL', NULL, 205, 1, '2026-02-03 02:33:16.824957', '2026-02-03 02:33:16.824957');
INSERT INTO public.voting_booths VALUES (1613, 'SANTO DOMINGO', NULL, 205, 2, '2026-02-03 02:33:16.824957', '2026-02-03 02:33:16.824957');
INSERT INTO public.voting_booths VALUES (1614, 'VILLANUEVA', NULL, 205, 1, '2026-02-03 02:33:16.824957', '2026-02-03 02:33:16.824957');
INSERT INTO public.voting_booths VALUES (1615, 'PUESTO CABECERA MUNICIPAL', NULL, 206, 24, '2026-02-03 02:33:48.560186', '2026-02-03 02:33:48.560186');
INSERT INTO public.voting_booths VALUES (1616, 'PUEBLO NUEVO', NULL, 206, 3, '2026-02-03 02:33:48.560186', '2026-02-03 02:33:48.560186');
INSERT INTO public.voting_booths VALUES (1617, 'COLORADO', NULL, 206, 3, '2026-02-03 02:33:48.560186', '2026-02-03 02:33:48.560186');
INSERT INTO public.voting_booths VALUES (1618, 'GALERAZAMBA', NULL, 206, 4, '2026-02-03 02:33:48.560186', '2026-02-03 02:33:48.560186');
INSERT INTO public.voting_booths VALUES (1619, 'JOBO', NULL, 206, 1, '2026-02-03 02:33:48.560186', '2026-02-03 02:33:48.560186');
INSERT INTO public.voting_booths VALUES (1620, 'LOMA DE ARENA', NULL, 206, 11, '2026-02-03 02:33:48.560186', '2026-02-03 02:33:48.560186');
INSERT INTO public.voting_booths VALUES (1621, 'PUESTO CABECERA MUNICIPAL', NULL, 207, 53, '2026-02-03 02:34:44.320946', '2026-02-03 02:34:44.320946');
INSERT INTO public.voting_booths VALUES (1622, 'MINA PEPO', NULL, 208, 1, '2026-02-03 02:36:22.096471', '2026-02-03 02:36:22.096471');
INSERT INTO public.voting_booths VALUES (1623, 'MINA FORTUNA', NULL, 208, 1, '2026-02-03 02:36:22.096471', '2026-02-03 02:36:22.096471');
INSERT INTO public.voting_booths VALUES (1624, 'PUESTO CABECERA MUNICIPAL', NULL, 208, 61, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1625, 'BUENAVISTA', NULL, 208, 3, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1626, 'SAN FRANCISCO', NULL, 208, 1, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1627, 'FATIMA', NULL, 208, 2, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1628, 'LA MARIZOSA', NULL, 208, 1, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1629, 'LOS ARRAYANES', NULL, 208, 1, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1630, 'LOS CANELOS', NULL, 208, 5, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1631, 'SAN ISIDRO', NULL, 208, 1, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1632, 'SAN JUAN DE RIOGRANDE', NULL, 208, 1, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1633, 'SAN JOSE', NULL, 208, 1, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1634, 'SAN PEDRO FRIO', NULL, 208, 2, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1635, 'SAN LUCAS', NULL, 208, 2, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1636, 'SANTA ISABEL', NULL, 208, 1, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1637, 'VILLA FLOR', NULL, 208, 2, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1638, 'VEREDA SAN LUQUITAS', NULL, 208, 1, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1639, 'VEREDA SAN BENITO', NULL, 208, 3, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1640, 'LOS GUAYACANES', NULL, 208, 1, '2026-02-03 02:37:08.294014', '2026-02-03 02:37:08.294014');
INSERT INTO public.voting_booths VALUES (1641, 'PUESTO CABECERA MUNICIPAL', NULL, 209, 20, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1642, 'ANIMAS ALTAS', NULL, 209, 4, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1643, 'SINAI', NULL, 209, 2, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1644, 'CAMPO PALLARES', NULL, 209, 1, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1645, 'EL DIAMANTE', NULL, 209, 1, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1646, 'EL PARAISO', NULL, 209, 1, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1647, 'EL GARZAL', NULL, 209, 2, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1648, 'LAS BRISAS', NULL, 209, 2, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1649, 'ORORIA', NULL, 209, 1, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1650, 'MONTERREY', NULL, 209, 4, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1651, 'SAN BLAS', NULL, 209, 3, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1652, 'SAN JOAQUIN', NULL, 209, 2, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1653, 'SAN LUIS', NULL, 209, 3, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1654, 'SANTA LUCIA', NULL, 209, 1, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1655, 'VERACRUZ (CERRO DE BURGOS)', NULL, 209, 3, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1656, 'SABANA', NULL, 209, 2, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1657, 'IETAC EUTIMIO GUTIERREZ MANJON', NULL, 209, 0, '2026-02-03 02:37:53.313999', '2026-02-03 02:37:53.313999');
INSERT INTO public.voting_booths VALUES (1658, 'NUEVO LIBANO', NULL, 210, 28, '2026-02-03 02:38:50.550581', '2026-02-03 02:38:50.550581');
INSERT INTO public.voting_booths VALUES (1659, 'PUESTO CABECERA MUNICIPAL', NULL, 211, 18, '2026-02-03 02:39:40.761032', '2026-02-03 02:39:40.761032');
INSERT INTO public.voting_booths VALUES (1660, 'CA?????O HONDO', NULL, 211, 1, '2026-02-03 02:39:40.761032', '2026-02-03 02:39:40.761032');
INSERT INTO public.voting_booths VALUES (1661, 'EL PORVENIR', NULL, 211, 2, '2026-02-03 02:39:40.761032', '2026-02-03 02:39:40.761032');
INSERT INTO public.voting_booths VALUES (1662, 'EL VESUBIO', NULL, 211, 4, '2026-02-03 02:39:40.761032', '2026-02-03 02:39:40.761032');
INSERT INTO public.voting_booths VALUES (1663, 'LAS MARIAS', NULL, 211, 1, '2026-02-03 02:39:40.761032', '2026-02-03 02:39:40.761032');
INSERT INTO public.voting_booths VALUES (1664, 'LOS MANGOS', NULL, 211, 1, '2026-02-03 02:39:40.761032', '2026-02-03 02:39:40.761032');
INSERT INTO public.voting_booths VALUES (1665, 'PATICO', NULL, 211, 4, '2026-02-03 02:39:40.761032', '2026-02-03 02:39:40.761032');
INSERT INTO public.voting_booths VALUES (1666, 'PE?????ON DE DURAN', NULL, 211, 2, '2026-02-03 02:39:40.761032', '2026-02-03 02:39:40.761032');
INSERT INTO public.voting_booths VALUES (1667, 'SAN MARTIN (LA LADERA DE TALA', NULL, 211, 1, '2026-02-03 02:39:40.761032', '2026-02-03 02:39:40.761032');
INSERT INTO public.voting_booths VALUES (1668, 'TUPE', NULL, 211, 1, '2026-02-03 02:39:40.761032', '2026-02-03 02:39:40.761032');
INSERT INTO public.voting_booths VALUES (1669, 'TALAIGUA VIEJO', NULL, 211, 3, '2026-02-03 02:39:40.761032', '2026-02-03 02:39:40.761032');
INSERT INTO public.voting_booths VALUES (1670, 'INSTITUCION EDUCATIVA DE PUERTO RICO', NULL, 212, 23, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1671, 'AGUAS NEGRAS', NULL, 212, 1, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1672, 'BOCAS DE SOLIS', NULL, 212, 1, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1673, 'BOLOMBOLO', NULL, 212, 1, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1674, 'INSTITUCION EDUCATIVA DE COLORADO', NULL, 212, 3, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1675, 'DOS BOCAS', NULL, 212, 2, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1676, 'EL SUDAN', NULL, 212, 5, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1677, 'LA VENTURA', NULL, 212, 3, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1678, 'MINA SECA', NULL, 212, 3, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1679, 'PALMA ESTERAL', NULL, 212, 1, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1680, 'PUERTO COCA', NULL, 212, 2, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1681, 'QUEBRADA DEL MEDIO', NULL, 212, 2, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1682, 'SABANAS DEL FIRME', NULL, 212, 1, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1683, 'TIQUISIO NUEVO', NULL, 212, 5, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1684, 'INST EDUC DE MINA SECA SEDE LOS PLANOS', NULL, 212, 1, '2026-02-03 02:40:20.129356', '2026-02-03 02:40:20.129356');
INSERT INTO public.voting_booths VALUES (1685, 'INST EDC CRISANTO LUQUE', NULL, 213, 39, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1686, 'SENA REGIONAL BOLIVAR', NULL, 213, 17, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1687, 'INST EDUC ALFONSO LOPEZ PUMARE', NULL, 213, 15, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1688, 'INST EDUC LA BUENA ESPERANZA', NULL, 213, 20, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1689, 'I.E. QUERIDOS AMIGOS', NULL, 213, 5, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1690, 'INST EDUC CUARTA POZA DE MANGA', NULL, 213, 35, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1691, 'INST EDUC 4 P. DE MANGA - HILD', NULL, 213, 11, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1692, 'INST EDUC FELIPE SANTIAGO ESCO', NULL, 213, 19, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1693, 'INST EDUC F SANTIAGO - MARIA A', NULL, 213, 9, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1694, 'INST EDUC CRISANTO LUQUE SEDE', NULL, 213, 7, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1695, 'IE 4TA POZA DE MANGA SD N SRA DE SOCORRO', NULL, 213, 14, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1696, 'CENTRO DE VIDA', NULL, 213, 16, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1697, 'CARCEL DE TURBACO', NULL, 213, 1, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1698, 'CA?????AVERAL', NULL, 213, 9, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1699, 'I E AGUAS PRIETAS', NULL, 213, 1, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1700, 'CHIQUITO', NULL, 213, 1, '2026-02-03 02:41:03.338595', '2026-02-03 02:41:03.338595');
INSERT INTO public.voting_booths VALUES (1701, 'IE MARCO FIDEL SUAREZ', NULL, 214, 21, '2026-02-03 02:41:38.167902', '2026-02-03 02:41:38.167902');
INSERT INTO public.voting_booths VALUES (1702, 'IE INETI SEDE NUESTRA SE?????ORA DEL CARMEN', NULL, 214, 24, '2026-02-03 02:41:38.167902', '2026-02-03 02:41:38.167902');
INSERT INTO public.voting_booths VALUES (1703, 'BALLESTAS', NULL, 214, 6, '2026-02-03 02:41:38.167902', '2026-02-03 02:41:38.167902');
INSERT INTO public.voting_booths VALUES (1704, 'COVADO - PUEBLO NUEVO', NULL, 214, 2, '2026-02-03 02:41:38.167902', '2026-02-03 02:41:38.167902');
INSERT INTO public.voting_booths VALUES (1705, 'VEREDA EL CHORRO Y LA LEGUA', NULL, 214, 1, '2026-02-03 02:41:38.167902', '2026-02-03 02:41:38.167902');
INSERT INTO public.voting_booths VALUES (1706, 'PUESTO CABECERA MUNICIPAL', NULL, 215, 49, '2026-02-03 02:42:10.162069', '2026-02-03 02:42:10.162069');
INSERT INTO public.voting_booths VALUES (1707, 'CIPACOA', NULL, 215, 5, '2026-02-03 02:42:10.162069', '2026-02-03 02:42:10.162069');
INSERT INTO public.voting_booths VALUES (1708, 'ALGARROBO', NULL, 215, 1, '2026-02-03 02:42:10.162069', '2026-02-03 02:42:10.162069');
INSERT INTO public.voting_booths VALUES (1709, 'PUESTO CABECERA MUNICIPAL', NULL, 216, 30, '2026-02-03 02:42:49.031788', '2026-02-03 02:42:49.031788');
INSERT INTO public.voting_booths VALUES (1710, 'JESUS DEL RIO', NULL, 216, 1, '2026-02-03 02:42:49.031788', '2026-02-03 02:42:49.031788');
INSERT INTO public.voting_booths VALUES (1711, 'VEREDA CAPACA', NULL, 216, 1, '2026-02-03 02:42:49.031788', '2026-02-03 02:42:49.031788');


--
-- TOC entry 5216 (class 0 OID 0)
-- Dependencies: 221
-- Name: candidate_voter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.candidate_voter_id_seq', 692, true);


--
-- TOC entry 5217 (class 0 OID 0)
-- Dependencies: 223
-- Name: candidates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.candidates_id_seq', 15, true);


--
-- TOC entry 5218 (class 0 OID 0)
-- Dependencies: 225
-- Name: corporations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.corporations_id_seq', 3, true);


--
-- TOC entry 5219 (class 0 OID 0)
-- Dependencies: 227
-- Name: departments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departments_id_seq', 32, true);


--
-- TOC entry 5220 (class 0 OID 0)
-- Dependencies: 229
-- Name: leaders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leaders_id_seq', 41, true);


--
-- TOC entry 5221 (class 0 OID 0)
-- Dependencies: 231
-- Name: municipalities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.municipalities_id_seq', 1125, true);


--
-- TOC entry 5222 (class 0 OID 0)
-- Dependencies: 233
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 43, true);


--
-- TOC entry 5223 (class 0 OID 0)
-- Dependencies: 236
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 6, false);


--
-- TOC entry 5224 (class 0 OID 0)
-- Dependencies: 239
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 73, true);


--
-- TOC entry 5225 (class 0 OID 0)
-- Dependencies: 241
-- Name: voters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.voters_id_seq', 316, true);


--
-- TOC entry 5226 (class 0 OID 0)
-- Dependencies: 243
-- Name: voting_booths_new_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.voting_booths_new_id_seq', 1711, true);


--
-- TOC entry 4962 (class 2606 OID 18171)
-- Name: candidates PK_140681296bf033ab1eb95288abb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates
    ADD CONSTRAINT "PK_140681296bf033ab1eb95288abb" PRIMARY KEY (id);


--
-- TOC entry 4958 (class 2606 OID 18173)
-- Name: candidate_leader PK_1b5a712e603b2b11a24334eb313; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_leader
    ADD CONSTRAINT "PK_1b5a712e603b2b11a24334eb313" PRIMARY KEY (candidate_id, leader_id);


--
-- TOC entry 4967 (class 2606 OID 18175)
-- Name: corporations PK_3a8cb4ffa196174e92ccc299b00; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.corporations
    ADD CONSTRAINT "PK_3a8cb4ffa196174e92ccc299b00" PRIMARY KEY (id);


--
-- TOC entry 4973 (class 2606 OID 18177)
-- Name: leaders PK_6035d2826e63f39b50a34901d36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leaders
    ADD CONSTRAINT "PK_6035d2826e63f39b50a34901d36" PRIMARY KEY (id);


--
-- TOC entry 4969 (class 2606 OID 18179)
-- Name: departments PK_839517a681a86bb84cbcc6a1e9d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT "PK_839517a681a86bb84cbcc6a1e9d" PRIMARY KEY (id);


--
-- TOC entry 4978 (class 2606 OID 18181)
-- Name: municipalities PK_9c4573349577306f221dda4d924; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipalities
    ADD CONSTRAINT "PK_9c4573349577306f221dda4d924" PRIMARY KEY (id);


--
-- TOC entry 4996 (class 2606 OID 18183)
-- Name: users PK_a3ffb1c0c8416b9fc6f907b7433; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_a3ffb1c0c8416b9fc6f907b7433" PRIMARY KEY (id);


--
-- TOC entry 5001 (class 2606 OID 18185)
-- Name: voters PK_a58842a42a7c48bc3efebb0a305; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voters
    ADD CONSTRAINT "PK_a58842a42a7c48bc3efebb0a305" PRIMARY KEY (id);


--
-- TOC entry 5003 (class 2606 OID 18187)
-- Name: voters UQ_52c4af0d6cf51230fecc86d98b5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voters
    ADD CONSTRAINT "UQ_52c4af0d6cf51230fecc86d98b5" UNIQUE (email);


--
-- TOC entry 4971 (class 2606 OID 18189)
-- Name: departments UQ_8681da666ad9699d568b3e91064; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT "UQ_8681da666ad9699d568b3e91064" UNIQUE (name);


--
-- TOC entry 4998 (class 2606 OID 18191)
-- Name: users UQ_97672ac88f789774dd47f7c8be3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3" UNIQUE (email);


--
-- TOC entry 5005 (class 2606 OID 18193)
-- Name: voters UQ_b60147b13092c49fd5842e4609b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voters
    ADD CONSTRAINT "UQ_b60147b13092c49fd5842e4609b" UNIQUE (identification);


--
-- TOC entry 4960 (class 2606 OID 18195)
-- Name: candidate_voter candidate_voter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_voter
    ADD CONSTRAINT candidate_voter_pkey PRIMARY KEY (id);


--
-- TOC entry 4964 (class 2606 OID 18197)
-- Name: candidates candidates_userId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates
    ADD CONSTRAINT "candidates_userId_key" UNIQUE ("userId");


--
-- TOC entry 4976 (class 2606 OID 18199)
-- Name: leaders leaders_userId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leaders
    ADD CONSTRAINT "leaders_userId_key" UNIQUE ("userId");


--
-- TOC entry 4982 (class 2606 OID 18201)
-- Name: permissions permissions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_key UNIQUE (name);


--
-- TOC entry 4984 (class 2606 OID 18203)
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4986 (class 2606 OID 18205)
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY ("roleId", "permissionId");


--
-- TOC entry 4988 (class 2606 OID 18207)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 4990 (class 2606 OID 18209)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4994 (class 2606 OID 18211)
-- Name: user_permissions user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_pkey PRIMARY KEY ("userId", "permissionId");


--
-- TOC entry 5010 (class 2606 OID 18213)
-- Name: voting_booths voting_booths_new_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voting_booths
    ADD CONSTRAINT voting_booths_new_pkey PRIMARY KEY (id);


--
-- TOC entry 4955 (class 1259 OID 18214)
-- Name: IDX_cd03501660a4954bba82eb55e6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cd03501660a4954bba82eb55e6" ON public.candidate_leader USING btree (candidate_id);


--
-- TOC entry 4956 (class 1259 OID 18215)
-- Name: IDX_ff3ddf58756b5724b617d6a27d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ff3ddf58756b5724b617d6a27d" ON public.candidate_leader USING btree (leader_id);


--
-- TOC entry 4965 (class 1259 OID 18216)
-- Name: idx_candidates_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_candidates_userid ON public.candidates USING btree ("userId");


--
-- TOC entry 4974 (class 1259 OID 18217)
-- Name: idx_leaders_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_leaders_userid ON public.leaders USING btree ("userId");


--
-- TOC entry 4979 (class 1259 OID 18218)
-- Name: idx_permissions_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_permissions_action ON public.permissions USING btree (action);


--
-- TOC entry 4980 (class 1259 OID 18219)
-- Name: idx_permissions_resource; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_permissions_resource ON public.permissions USING btree (resource);


--
-- TOC entry 4991 (class 1259 OID 18220)
-- Name: idx_user_permissions_granted; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_permissions_granted ON public.user_permissions USING btree (granted);


--
-- TOC entry 4992 (class 1259 OID 18221)
-- Name: idx_user_permissions_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_permissions_userid ON public.user_permissions USING btree ("userId");


--
-- TOC entry 4999 (class 1259 OID 18222)
-- Name: idx_users_roleid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_roleid ON public.users USING btree ("roleId");


--
-- TOC entry 5006 (class 1259 OID 18223)
-- Name: idx_voters_votingboothid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_voters_votingboothid ON public.voters USING btree ("votingBoothId");


--
-- TOC entry 5007 (class 1259 OID 18224)
-- Name: idx_voters_votingtableid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_voters_votingtableid ON public.voters USING btree ("votingTableId");


--
-- TOC entry 5008 (class 1259 OID 18225)
-- Name: idx_voting_booths_new_municipalityid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_voting_booths_new_municipalityid ON public.voting_booths USING btree ("municipalityId");


--
-- TOC entry 5025 (class 2606 OID 18226)
-- Name: voters FK_4f7e43334f6d907237609fc062f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voters
    ADD CONSTRAINT "FK_4f7e43334f6d907237609fc062f" FOREIGN KEY ("departmentId") REFERENCES public.departments(id);


--
-- TOC entry 5026 (class 2606 OID 18231)
-- Name: voters FK_585091563505572820a2a44bef4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voters
    ADD CONSTRAINT "FK_585091563505572820a2a44bef4" FOREIGN KEY ("municipalityId") REFERENCES public.municipalities(id);


--
-- TOC entry 5019 (class 2606 OID 18236)
-- Name: municipalities FK_b9cb05d16adb0fb3176107342e2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipalities
    ADD CONSTRAINT "FK_b9cb05d16adb0fb3176107342e2" FOREIGN KEY ("departmentId") REFERENCES public.departments(id) ON DELETE CASCADE;


--
-- TOC entry 5016 (class 2606 OID 18241)
-- Name: candidates FK_c670ed8fec7225af7a131981b5f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates
    ADD CONSTRAINT "FK_c670ed8fec7225af7a131981b5f" FOREIGN KEY (corporation_id) REFERENCES public.corporations(id);


--
-- TOC entry 5011 (class 2606 OID 18246)
-- Name: candidate_leader FK_cd03501660a4954bba82eb55e66; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_leader
    ADD CONSTRAINT "FK_cd03501660a4954bba82eb55e66" FOREIGN KEY (candidate_id) REFERENCES public.candidates(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5012 (class 2606 OID 18251)
-- Name: candidate_leader FK_ff3ddf58756b5724b617d6a27d4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_leader
    ADD CONSTRAINT "FK_ff3ddf58756b5724b617d6a27d4" FOREIGN KEY (leader_id) REFERENCES public.leaders(id);


--
-- TOC entry 5013 (class 2606 OID 18256)
-- Name: candidate_voter candidate_voter_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_voter
    ADD CONSTRAINT candidate_voter_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(id);


--
-- TOC entry 5014 (class 2606 OID 18261)
-- Name: candidate_voter candidate_voter_leader_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_voter
    ADD CONSTRAINT candidate_voter_leader_id_fkey FOREIGN KEY (leader_id) REFERENCES public.leaders(id);


--
-- TOC entry 5015 (class 2606 OID 18266)
-- Name: candidate_voter candidate_voter_voter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_voter
    ADD CONSTRAINT candidate_voter_voter_id_fkey FOREIGN KEY (voter_id) REFERENCES public.voters(id);


--
-- TOC entry 5017 (class 2606 OID 18271)
-- Name: candidates fk_candidates_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates
    ADD CONSTRAINT fk_candidates_userid FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 5018 (class 2606 OID 18276)
-- Name: leaders fk_leaders_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leaders
    ADD CONSTRAINT fk_leaders_userid FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 5024 (class 2606 OID 18281)
-- Name: users fk_users_roleid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_roleid FOREIGN KEY ("roleId") REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 5020 (class 2606 OID 18286)
-- Name: role_permissions role_permissions_permissionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT "role_permissions_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- TOC entry 5021 (class 2606 OID 18291)
-- Name: role_permissions role_permissions_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT "role_permissions_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 5022 (class 2606 OID 18296)
-- Name: user_permissions user_permissions_permissionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT "user_permissions_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- TOC entry 5023 (class 2606 OID 18301)
-- Name: user_permissions user_permissions_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT "user_permissions_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5027 (class 2606 OID 18306)
-- Name: voting_booths voting_booths_new_municipalityid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.voting_booths
    ADD CONSTRAINT voting_booths_new_municipalityid_fkey FOREIGN KEY ("municipalityId") REFERENCES public.municipalities(id) ON DELETE CASCADE;


-- Completed on 2026-02-04 21:52:39

--
-- PostgreSQL database dump complete
--

\unrestrict 2Hy5KEcCZ3i8D3gRbnWYVIAJi6dLN0gejx2Fj1EE9KsSQcpdnIR3wHtStvEi3HV

