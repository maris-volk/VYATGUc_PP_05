--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2026-03-19 17:59:56

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 231 (class 1259 OID 67173)
-- Name: app_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_user (
    user_id character varying(20) NOT NULL,
    login character varying(50) NOT NULL,
    password_hash character varying(100) NOT NULL,
    role_id character varying(20) NOT NULL
);


ALTER TABLE public.app_user OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 67027)
-- Name: counterparty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.counterparty (
    id character varying(20) NOT NULL,
    name character varying(200) NOT NULL,
    inn character varying(12),
    addres character varying(200),
    phone character varying(20),
    salesman boolean DEFAULT false NOT NULL,
    buyer boolean DEFAULT false NOT NULL
);


ALTER TABLE public.counterparty OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 67034)
-- Name: material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material (
    material_id character varying(20) NOT NULL,
    material_name character varying(200) NOT NULL,
    unit_id character varying(20) NOT NULL,
    price_per_unit numeric(10,2) NOT NULL,
    CONSTRAINT material_price_per_unit_check CHECK ((price_per_unit > (0)::numeric))
);


ALTER TABLE public.material OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 67130)
-- Name: material_receipt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material_receipt (
    receipt_id character varying(20) NOT NULL,
    supplier_id character varying(20) NOT NULL,
    material_id character varying(20) NOT NULL,
    quantity numeric(10,3) NOT NULL,
    receipt_date date NOT NULL,
    CONSTRAINT material_receipt_quantity_check CHECK ((quantity > (0)::numeric))
);


ALTER TABLE public.material_receipt OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 67146)
-- Name: material_stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material_stock (
    stock_id character varying(20) NOT NULL,
    material_id character varying(20) NOT NULL,
    quantity numeric(10,3) NOT NULL,
    CONSTRAINT material_stock_quantity_check CHECK ((quantity >= (0)::numeric))
);


ALTER TABLE public.material_stock OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 67083)
-- Name: order_; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_ (
    order_id character varying(20) NOT NULL,
    customer_id character varying(20) NOT NULL,
    order_date date NOT NULL,
    total_amount numeric(10,2)
);


ALTER TABLE public.order_ OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 67093)
-- Name: order_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_product (
    order_product_id character varying(20) NOT NULL,
    order_id character varying(20) NOT NULL,
    product_id character varying(20) NOT NULL,
    quantity numeric(10,3) NOT NULL,
    CONSTRAINT order_product_quantity_check CHECK ((quantity > (0)::numeric))
);


ALTER TABLE public.order_product OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 67045)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    product_id character varying(20) NOT NULL,
    product_name character varying(200) NOT NULL,
    unit_id character varying(20) NOT NULL,
    cost_price numeric(10,2),
    selling_price numeric(10,2) NOT NULL,
    CONSTRAINT product_selling_price_check CHECK ((selling_price > (0)::numeric))
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 67157)
-- Name: product_stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_stock (
    stock_id character varying(20) NOT NULL,
    product_id character varying(20) NOT NULL,
    quantity numeric(10,3) NOT NULL,
    CONSTRAINT product_stock_quantity_check CHECK ((quantity >= (0)::numeric))
);


ALTER TABLE public.product_stock OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 67109)
-- Name: production; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.production (
    production_id character varying(20) NOT NULL,
    production_date date NOT NULL
);


ALTER TABLE public.production OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 67114)
-- Name: production_output; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.production_output (
    output_id character varying(20) NOT NULL,
    production_id character varying(20) NOT NULL,
    product_id character varying(20) NOT NULL,
    quantity numeric(10,3) NOT NULL,
    CONSTRAINT production_output_quantity_check CHECK ((quantity > (0)::numeric))
);


ALTER TABLE public.production_output OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 67168)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    role_id character varying(20) NOT NULL,
    role_name character varying(50) NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 67067)
-- Name: spec_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spec_material (
    spec_material_id character varying(20) NOT NULL,
    spec_id character varying(20) NOT NULL,
    material_id character varying(20) NOT NULL,
    quantity numeric(10,3) NOT NULL,
    CONSTRAINT spec_material_quantity_check CHECK ((quantity > (0)::numeric))
);


ALTER TABLE public.spec_material OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 67056)
-- Name: specification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specification (
    spec_id character varying(20) NOT NULL,
    product_id character varying(20) NOT NULL,
    product_quantity numeric(10,3) NOT NULL,
    CONSTRAINT specification_product_quantity_check CHECK ((product_quantity > (0)::numeric))
);


ALTER TABLE public.specification OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 67022)
-- Name: unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unit (
    unit_id character varying(20) NOT NULL,
    unit_name character varying(50) NOT NULL
);


ALTER TABLE public.unit OWNER TO postgres;

--
-- TOC entry 4984 (class 0 OID 67173)
-- Dependencies: 231
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4971 (class 0 OID 67027)
-- Dependencies: 218
-- Data for Name: counterparty; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.counterparty (id, name, inn, addres, phone, salesman, buyer) VALUES ('000000001', 'ООО "Поставка"', '', 'г.Пятигорск', '+79198634592', true, true);
INSERT INTO public.counterparty (id, name, inn, addres, phone, salesman, buyer) VALUES ('000000002', 'ООО "Кинотеатр Квант"', '26320045123', 'г. Железноводск, ул. Мира, 123', '+79884581555', true, false);
INSERT INTO public.counterparty (id, name, inn, addres, phone, salesman, buyer) VALUES ('000000008', 'ООО "Новый JDTO"', '26320045111', 'г. Железноводсу', '+79884581555', true, false);
INSERT INTO public.counterparty (id, name, inn, addres, phone, salesman, buyer) VALUES ('000000003', 'ООО "Ромашка"', '4140784214', 'г. Омск, ул. Строителей, 294', '+79882584546', false, true);
INSERT INTO public.counterparty (id, name, inn, addres, phone, salesman, buyer) VALUES ('000000009', 'ООО "Ипподром"', '5874045632', 'г. Уфа, ул. Набережная,  37', '+79627486389', true, true);
INSERT INTO public.counterparty (id, name, inn, addres, phone, salesman, buyer) VALUES ('000000010', 'ООО "Ассоль"', '2629011278', 'г. Калуга, ул. Пушкина, 94', '+79184572398', false, true);


--
-- TOC entry 4972 (class 0 OID 67034)
-- Dependencies: 219
-- Data for Name: material; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.material (material_id, material_name, unit_id, price_per_unit) VALUES ('НФ-00000004', 'Молоко нормализованное', 'кг', 34.00);
INSERT INTO public.material (material_id, material_name, unit_id, price_per_unit) VALUES ('НФ-00000005', 'Закваска сметанная', 'кг', 45.00);


--
-- TOC entry 4980 (class 0 OID 67130)
-- Dependencies: 227
-- Data for Name: material_receipt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4981 (class 0 OID 67146)
-- Dependencies: 228
-- Data for Name: material_stock; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4976 (class 0 OID 67083)
-- Dependencies: 223
-- Data for Name: order_; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_ (order_id, customer_id, order_date, total_amount) VALUES ('3', '000000010', '2025-06-10', NULL);
INSERT INTO public.order_ (order_id, customer_id, order_date, total_amount) VALUES ('2', '000000010', '2025-06-06', 2488.00);


--
-- TOC entry 4977 (class 0 OID 67093)
-- Dependencies: 224
-- Data for Name: order_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_product (order_product_id, order_id, product_id, quantity) VALUES ('OP001', '3', 'НФ-00000006', 5.000);
INSERT INTO public.order_product (order_product_id, order_id, product_id, quantity) VALUES ('OP002', '2', 'PRD001', 12.000);
INSERT INTO public.order_product (order_product_id, order_id, product_id, quantity) VALUES ('OP003', '2', 'PRD002', 9.000);
INSERT INTO public.order_product (order_product_id, order_id, product_id, quantity) VALUES ('OP004', '2', 'PRD003', 10.000);


--
-- TOC entry 4973 (class 0 OID 67045)
-- Dependencies: 220
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product (product_id, product_name, unit_id, cost_price, selling_price) VALUES ('НФ-00000006', 'Сметана классическая 15% 540г.', 'шт', NULL, 89.00);
INSERT INTO public.product (product_id, product_name, unit_id, cost_price, selling_price) VALUES ('PRD-001', 'Кефир 2,5% 900г.', 'шт', NULL, 80.00);
INSERT INTO public.product (product_id, product_name, unit_id, cost_price, selling_price) VALUES ('PRD-002', 'Кефир 3,2% 900г.', 'шт', NULL, 82.00);
INSERT INTO public.product (product_id, product_name, unit_id, cost_price, selling_price) VALUES ('PRD-003', 'Молоко 2,5% 900г.', 'шт', NULL, 70.00);
INSERT INTO public.product (product_id, product_name, unit_id, cost_price, selling_price) VALUES ('PRD001', 'Кефир 2,5% 900г.', 'шт', NULL, 80.00);
INSERT INTO public.product (product_id, product_name, unit_id, cost_price, selling_price) VALUES ('PRD002', 'Кефир 3,2% 900г.', 'шт', NULL, 82.00);
INSERT INTO public.product (product_id, product_name, unit_id, cost_price, selling_price) VALUES ('PRD003', 'Молоко 2,5% 900г.', 'шт', NULL, 70.00);


--
-- TOC entry 4982 (class 0 OID 67157)
-- Dependencies: 229
-- Data for Name: product_stock; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4978 (class 0 OID 67109)
-- Dependencies: 225
-- Data for Name: production; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4979 (class 0 OID 67114)
-- Dependencies: 226
-- Data for Name: production_output; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4983 (class 0 OID 67168)
-- Dependencies: 230
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4975 (class 0 OID 67067)
-- Dependencies: 222
-- Data for Name: spec_material; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.spec_material (spec_material_id, spec_id, material_id, quantity) VALUES ('SM001', 'SPEC001', 'НФ-00000004', 0.900);
INSERT INTO public.spec_material (spec_material_id, spec_id, material_id, quantity) VALUES ('SM002', 'SPEC001', 'НФ-00000005', 0.070);
INSERT INTO public.spec_material (spec_material_id, spec_id, material_id, quantity) VALUES ('SM003', 'SPEC002', 'НФ-00000004', 0.900);
INSERT INTO public.spec_material (spec_material_id, spec_id, material_id, quantity) VALUES ('SM004', 'SPEC002', 'НФ-00000005', 0.050);
INSERT INTO public.spec_material (spec_material_id, spec_id, material_id, quantity) VALUES ('SM005', 'SPEC003', 'НФ-00000004', 0.900);
INSERT INTO public.spec_material (spec_material_id, spec_id, material_id, quantity) VALUES ('SM006', 'SPEC003', 'НФ-00000005', 0.060);
INSERT INTO public.spec_material (spec_material_id, spec_id, material_id, quantity) VALUES ('SM007', 'SPEC004', 'НФ-00000004', 0.900);


--
-- TOC entry 4974 (class 0 OID 67056)
-- Dependencies: 221
-- Data for Name: specification; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.specification (spec_id, product_id, product_quantity) VALUES ('SPEC001', 'НФ-00000006', 1.000);
INSERT INTO public.specification (spec_id, product_id, product_quantity) VALUES ('SPEC002', 'PRD001', 1.000);
INSERT INTO public.specification (spec_id, product_id, product_quantity) VALUES ('SPEC003', 'PRD002', 1.000);
INSERT INTO public.specification (spec_id, product_id, product_quantity) VALUES ('SPEC004', 'PRD003', 1.000);


--
-- TOC entry 4970 (class 0 OID 67022)
-- Dependencies: 217
-- Data for Name: unit; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.unit (unit_id, unit_name) VALUES ('шт', 'штука');
INSERT INTO public.unit (unit_id, unit_name) VALUES ('кг', 'килограмм');


--
-- TOC entry 4807 (class 2606 OID 67179)
-- Name: app_user app_user_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_login_key UNIQUE (login);


--
-- TOC entry 4809 (class 2606 OID 67177)
-- Name: app_user app_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4762 (class 2606 OID 67033)
-- Name: counterparty counterparty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.counterparty
    ADD CONSTRAINT counterparty_pkey PRIMARY KEY (id);


--
-- TOC entry 4768 (class 2606 OID 67039)
-- Name: material material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_pkey PRIMARY KEY (material_id);


--
-- TOC entry 4797 (class 2606 OID 67135)
-- Name: material_receipt material_receipt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_receipt
    ADD CONSTRAINT material_receipt_pkey PRIMARY KEY (receipt_id);


--
-- TOC entry 4800 (class 2606 OID 67151)
-- Name: material_stock material_stock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_stock
    ADD CONSTRAINT material_stock_pkey PRIMARY KEY (stock_id);


--
-- TOC entry 4781 (class 2606 OID 67087)
-- Name: order_ order__pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_
    ADD CONSTRAINT order__pkey PRIMARY KEY (order_id);


--
-- TOC entry 4785 (class 2606 OID 67098)
-- Name: order_product order_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT order_product_pkey PRIMARY KEY (order_product_id);


--
-- TOC entry 4770 (class 2606 OID 67050)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- TOC entry 4803 (class 2606 OID 67162)
-- Name: product_stock product_stock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_stock
    ADD CONSTRAINT product_stock_pkey PRIMARY KEY (stock_id);


--
-- TOC entry 4792 (class 2606 OID 67119)
-- Name: production_output production_output_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production_output
    ADD CONSTRAINT production_output_pkey PRIMARY KEY (output_id);


--
-- TOC entry 4788 (class 2606 OID 67113)
-- Name: production production_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production
    ADD CONSTRAINT production_pkey PRIMARY KEY (production_id);


--
-- TOC entry 4805 (class 2606 OID 67172)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 4777 (class 2606 OID 67072)
-- Name: spec_material spec_material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spec_material
    ADD CONSTRAINT spec_material_pkey PRIMARY KEY (spec_material_id);


--
-- TOC entry 4773 (class 2606 OID 67061)
-- Name: specification specification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specification
    ADD CONSTRAINT specification_pkey PRIMARY KEY (spec_id);


--
-- TOC entry 4760 (class 2606 OID 67026)
-- Name: unit unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit
    ADD CONSTRAINT unit_pkey PRIMARY KEY (unit_id);


--
-- TOC entry 4810 (class 1259 OID 67205)
-- Name: idx_app_user_login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_app_user_login ON public.app_user USING btree (login);


--
-- TOC entry 4811 (class 1259 OID 67204)
-- Name: idx_app_user_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_app_user_role ON public.app_user USING btree (role_id);


--
-- TOC entry 4763 (class 1259 OID 67186)
-- Name: idx_counterparty_inn; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_counterparty_inn ON public.counterparty USING btree (inn);


--
-- TOC entry 4764 (class 1259 OID 67185)
-- Name: idx_counterparty_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_counterparty_name ON public.counterparty USING btree (name);


--
-- TOC entry 4765 (class 1259 OID 67187)
-- Name: idx_counterparty_phone; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_counterparty_phone ON public.counterparty USING btree (phone);


--
-- TOC entry 4766 (class 1259 OID 67188)
-- Name: idx_counterparty_salesman_buyer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_counterparty_salesman_buyer ON public.counterparty USING btree (salesman, buyer);


--
-- TOC entry 4793 (class 1259 OID 67201)
-- Name: idx_material_receipt_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_material_receipt_date ON public.material_receipt USING btree (receipt_date);


--
-- TOC entry 4794 (class 1259 OID 67200)
-- Name: idx_material_receipt_material; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_material_receipt_material ON public.material_receipt USING btree (material_id);


--
-- TOC entry 4795 (class 1259 OID 67199)
-- Name: idx_material_receipt_supplier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_material_receipt_supplier ON public.material_receipt USING btree (supplier_id);


--
-- TOC entry 4798 (class 1259 OID 67202)
-- Name: idx_material_stock_material; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_material_stock_material ON public.material_stock USING btree (material_id);


--
-- TOC entry 4778 (class 1259 OID 67189)
-- Name: idx_order_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_customer ON public.order_ USING btree (customer_id);


--
-- TOC entry 4779 (class 1259 OID 67190)
-- Name: idx_order_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_date ON public.order_ USING btree (order_date);


--
-- TOC entry 4782 (class 1259 OID 67191)
-- Name: idx_order_product_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_product_order ON public.order_product USING btree (order_id);


--
-- TOC entry 4783 (class 1259 OID 67192)
-- Name: idx_order_product_product; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_product_product ON public.order_product USING btree (product_id);


--
-- TOC entry 4801 (class 1259 OID 67203)
-- Name: idx_product_stock_product; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_stock_product ON public.product_stock USING btree (product_id);


--
-- TOC entry 4786 (class 1259 OID 67196)
-- Name: idx_production_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_production_date ON public.production USING btree (production_date);


--
-- TOC entry 4789 (class 1259 OID 67198)
-- Name: idx_production_output_product; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_production_output_product ON public.production_output USING btree (product_id);


--
-- TOC entry 4790 (class 1259 OID 67197)
-- Name: idx_production_output_production; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_production_output_production ON public.production_output USING btree (production_id);


--
-- TOC entry 4774 (class 1259 OID 67195)
-- Name: idx_spec_material_material; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_spec_material_material ON public.spec_material USING btree (material_id);


--
-- TOC entry 4775 (class 1259 OID 67194)
-- Name: idx_spec_material_spec; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_spec_material_spec ON public.spec_material USING btree (spec_id);


--
-- TOC entry 4771 (class 1259 OID 67193)
-- Name: idx_spec_product; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_spec_product ON public.specification USING btree (product_id);


--
-- TOC entry 4826 (class 2606 OID 67180)
-- Name: app_user app_user_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(role_id);


--
-- TOC entry 4822 (class 2606 OID 67141)
-- Name: material_receipt material_receipt_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_receipt
    ADD CONSTRAINT material_receipt_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.material(material_id);


--
-- TOC entry 4823 (class 2606 OID 67136)
-- Name: material_receipt material_receipt_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_receipt
    ADD CONSTRAINT material_receipt_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.counterparty(id);


--
-- TOC entry 4824 (class 2606 OID 67152)
-- Name: material_stock material_stock_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_stock
    ADD CONSTRAINT material_stock_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.material(material_id);


--
-- TOC entry 4812 (class 2606 OID 67040)
-- Name: material material_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.unit(unit_id);


--
-- TOC entry 4817 (class 2606 OID 67088)
-- Name: order_ order__customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_
    ADD CONSTRAINT order__customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.counterparty(id);


--
-- TOC entry 4818 (class 2606 OID 67099)
-- Name: order_product order_product_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT order_product_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.order_(order_id);


--
-- TOC entry 4819 (class 2606 OID 67104)
-- Name: order_product order_product_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT order_product_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 4825 (class 2606 OID 67163)
-- Name: product_stock product_stock_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_stock
    ADD CONSTRAINT product_stock_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 4813 (class 2606 OID 67051)
-- Name: product product_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.unit(unit_id);


--
-- TOC entry 4820 (class 2606 OID 67125)
-- Name: production_output production_output_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production_output
    ADD CONSTRAINT production_output_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 4821 (class 2606 OID 67120)
-- Name: production_output production_output_production_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production_output
    ADD CONSTRAINT production_output_production_id_fkey FOREIGN KEY (production_id) REFERENCES public.production(production_id);


--
-- TOC entry 4815 (class 2606 OID 67078)
-- Name: spec_material spec_material_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spec_material
    ADD CONSTRAINT spec_material_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.material(material_id);


--
-- TOC entry 4816 (class 2606 OID 67073)
-- Name: spec_material spec_material_spec_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spec_material
    ADD CONSTRAINT spec_material_spec_id_fkey FOREIGN KEY (spec_id) REFERENCES public.specification(spec_id);


--
-- TOC entry 4814 (class 2606 OID 67062)
-- Name: specification specification_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specification
    ADD CONSTRAINT specification_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);


-- Completed on 2026-03-19 17:59:56

--
-- PostgreSQL database dump complete
--

