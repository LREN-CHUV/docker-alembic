BEGIN;

-- Plan the tests
SELECT plan( 17 );

SELECT has_table( 'participant' );
SELECT has_column( 'participant', 'id' );
SELECT has_column( 'participant', 'gender' );
SELECT has_column( 'participant', 'birth_date' );
SELECT has_column( 'participant', 'age' );
SELECT col_is_pk(  'participant', 'id' );

SELECT has_table( 'participant_mapping' );

SELECT has_table( 'provenance' );

SELECT has_table( 'sequence_type' );

SELECT has_table( 'visit_mapping' );

SELECT has_table( 'processing_step' );

SELECT has_table( 'visit' );
SELECT has_column( 'visit', 'patient_age' );
SELECT has_column( 'visit', 'site' );

SELECT has_table( 'sequence' );

SELECT has_table( 'repetition' );

SELECT has_table( 'data_file' );

-- Clean up
SELECT * FROM finish();
ROLLBACK;
