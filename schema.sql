-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "passenger_registry" (
    "passenger_id" int   NOT NULL,
    "survived" varchar   NOT NULL,
    "pclass" varchar   NOT NULL,
    "name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "age" int   NOT NULL,
    "sibsp" int   NOT NULL,
    "parch" int   NOT NULL,
    "ticket" int   NOT NULL,
    "fare" int   NOT NULL,
    "cabin" int   NOT NULL,
    "embarked" varchar   NOT NULL,
    CONSTRAINT "pk_passenger_registry" PRIMARY KEY (
        "passenger_id"
     )
);

CREATE TABLE "passenger_class" (
    "class_id" varchar   NOT NULL,
    "class_name" varchar   NOT NULL,
    CONSTRAINT "pk_passenger_class" PRIMARY KEY (
        "class_id"
     )
);

CREATE TABLE "embarked" (
    "port_id" varchar   NOT NULL,
    "port_name" varchar   NOT NULL,
    CONSTRAINT "pk_embarked" PRIMARY KEY (
        "port_id"
     )
);

ALTER TABLE "passenger_registry" ADD CONSTRAINT "fk_passenger_registry_pclass" FOREIGN KEY("pclass")
REFERENCES "passenger_class" ("class_id");

ALTER TABLE "passenger_registry" ADD CONSTRAINT "fk_passenger_registry_embarked" FOREIGN KEY("embarked")
REFERENCES "embarked" ("port_id");

