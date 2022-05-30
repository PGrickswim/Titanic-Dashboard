-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "passenger_registry" (
    "name" varchar   NOT NULL,
    "gender" varchar   NOT NULL,
    "age" double precision   NOT NULL,
    "class" varchar   NOT NULL,
    "embarked" varchar   NOT NULL,
    "country" varchar   NOT NULL,
    "ticketno" double precision   NOT NULL,
    "fare" double precision   NOT NULL,
    "sibsp" double precision   NOT NULL,
    "parch" double precision   NOT NULL,
    "survived" varchar   NOT NULL
);

CREATE TABLE "embarked" (
    "port_id" varchar   NOT NULL,
    "port_name" varchar   NOT NULL,
    "port_country" varchar   NOT NULL,
    CONSTRAINT "pk_embarked" PRIMARY KEY (
        "port_id"
     )
);

ALTER TABLE "passenger_registry" ADD CONSTRAINT "fk_passenger_registry_embarked" FOREIGN KEY("embarked")
REFERENCES "embarked" ("port_id");

