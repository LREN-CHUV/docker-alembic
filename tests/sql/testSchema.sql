BEGIN;

-- Plan the tests
SELECT plan( 6 );

SELECT has_table( 'participant' );
SELECT has_column( 'participant', 'id' );
SELECT has_column( 'participant', 'gender' );
SELECT has_column( 'participant', 'birth_date' );
SELECT has_column( 'participant', 'age' );
SELECT col_is_pk(  'participant', 'id' );

-- Clean up
SELECT * FROM finish();
ROLLBACK;
