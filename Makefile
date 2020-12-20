all:
	rm -rf  ebin/* test_ebin/* src/*~ test_src/*~ *~ erl_crash.dump src/*.beam test_src/*.beam;
	cp src/*.app ebin;
	erlc -o ebin src/*.erl
doc_gen:
	rm -rf  node_config logfiles doc/*;
	erlc ../doc_gen.erl;
	erl -s doc_gen start -sname doc

test:
	rm -rf *.beam src/*.beam test_src/*.beam ebin/* test_ebin/* erl_crash.dump;
	cp src/*app ebin;
	erlc -o ebin src/*.erl;
	erlc -o test_ebin test_src/*.erl;
	erl -pa test_ebin -pa ebin -s common_tests start -sname common_test
