-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "passenger_registry" (
    "name" varchar   NOT NULL,
    "gender" varchar   NOT NULL,
    "age" int   NOT NULL,
    "class" varchar   NOT NULL,
    "embarked" varchar   NOT NULL,
    "country" varchar   NOT NULL,
    "ticketno" int   NOT NULL,
    "fare" int   NOT NULL,
    "sibsp" int   NOT NULL,
    "parch" int   NOT NULL,
    "survived" varchar   NOT NULL,
    CONSTRAINT "pk_passenger_registry" PRIMARY KEY (
        "name"
     )
);

CREATE TABLE "embarked" (
    "port_id" varchar   NOT NULL,
    "port_name" varchar   NOT NULL,
    CONSTRAINT "pk_embarked" PRIMARY KEY (
        "port_id"
     )
);

ALTER TABLE "embarked" ADD CONSTRAINT "fk_embarked_port_id" FOREIGN KEY("port_id")
REFERENCES "passenger_registry" ("embarked");

