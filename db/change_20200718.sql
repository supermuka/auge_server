ALTER TABLE objective.objectives
    ADD COLUMN archived boolean;

UPDATE objective.objectives SET archived = false;

ALTER TABLE work.works
    ADD COLUMN archived boolean;

UPDATE work.works SET archived = false;

ALTER TABLE work.works
    ALTER COLUMN archived SET NOT NULL;

ALTER TABLE work.work_items
    ADD COLUMN archived boolean;

UPDATE work.work_items SET archived = false;

ALTER TABLE work.work_items
    ALTER COLUMN archived SET NOT NULL;

ALTER TABLE objective.measures
    RENAME measure_unit_id TO unit_of_measurement_id;

ALTER TABLE work.work_items
    ADD COLUMN unit_of_measurement_id uuid;

UPDATE work.work_items set unit_of_measurement_id = 'f748d3ad-b533-4a2d-b4ae-0ae1e255cf81' where completed is not null;

ALTER TABLE work.work_items
    ADD COLUMN planned_value real;

UPDATE work.work_items SET planned_value = 100 where completed is not null;

-- Table: work.work_item_values

-- DROP TABLE work.work_item_values;

CREATE TABLE work.work_item_values
(
    id uuid NOT NULL,
    version integer NOT NULL,
    date timestamp without time zone NOT NULL,
    actual_value real NOT NULL,
    comment text COLLATE pg_catalog."default",
    work_item_id uuid NOT NULL,
    CONSTRAINT work_item_values_pkey PRIMARY KEY (id),
    CONSTRAINT work_item_value_work_item_id_fkey FOREIGN KEY (work_item_id)
        REFERENCES work.work_items (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE work.work_item_values
    OWNER to postgres;

create extension "uuid-ossp";

INSERT INTO work.work_item_values(id, version, date, actual_value, comment, work_item_id)
SELECT uuid_generate_v4(), 0, now(), completed, null, id FROM work.work_items where completed is not null;


ALTER TABLE work.work_items
DROP completed;

-- Table: general.user_controls

-- DROP TABLE general.user_controls;

CREATE TABLE general.user_controls
(
    user_id uuid NOT NULL,
    date_time_last_notification timestamp without time zone,
    CONSTRAINT user_controls_pkey PRIMARY KEY (user_id),
    CONSTRAINT user_controls_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES general.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE general.user_controls
    OWNER to postgres;

ALTER TABLE work.work_stages
    RENAME CONSTRAINT stages_initiative_id_fkey TO stages_work_id_fkey;