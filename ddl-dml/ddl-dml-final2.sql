BEGIN TRANSACTION;
DROP TABLE IF EXISTS "disciplina_avaliacao";
CREATE TABLE IF NOT EXISTS "disciplina_avaliacao" (
	"avaliacao_id"	INTEGER NOT NULL,
	"disciplina_id"	INTEGER NOT NULL,
	"av_feita"	BLOB DEFAULT 0,
	FOREIGN KEY("disciplina_id") REFERENCES "disciplina"("id_disciplina"),
	FOREIGN KEY("avaliacao_id") REFERENCES "avaliacao"("id_avaliacao")
);
INSERT INTO "disciplina_avaliacao" VALUES (1,2,NULL);
INSERT INTO "disciplina_avaliacao" VALUES (2,2,NULL);
INSERT INTO "disciplina_avaliacao" VALUES (3,1,NULL);
INSERT INTO "disciplina_avaliacao" VALUES (4,3,NULL);
INSERT INTO "disciplina_avaliacao" VALUES (5,3,NULL);
COMMIT;
