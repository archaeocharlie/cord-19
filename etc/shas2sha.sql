-- authors2author.sql - split authors and fill authors table

-- make sane
DELETE FROM shas;

-- cool spit routine; see http://www.samuelbosch.com/2018/02/split-into-rows-sqlite.html
WITH RECURSIVE split( document_id, sha, rest ) AS (
	SELECT document_id, '', sha || ';' FROM documents
	UNION ALL
	SELECT document_id, SUBSTR( rest, 0, INSTR( rest, ';' ) ), SUBSTR( rest, INSTR( rest, ';' ) + 2 ) FROM split WHERE rest <> ''
)

-- insert using a sub-select
INSERT INTO urls ( document_id, url )
SELECT document_id, sha FROM split WHERE document_id AND sha <> '';
