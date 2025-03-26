ENTITY bdp IS
END bdp;
--1
ARCHITECTURE test_1 OF bdp IS

COMPONENT bloc
PORT (s0, s1, b0, b1, b2: IN BIT; Mb0, Mb1, Mb2: OUT BIT);
END COMPONENT;


SIGNAL senyal_s0, senyal_s1, senyal_b0, senyal_b1, senyal_b2, sortida_Mb0e, sortida_Mb1e, sortida_Mb2e, sortida_Mb0l, sortida_Mb1l, sortida_Mb2l, sortida_Mb0e2, sortida_Mb1e2, sortida_Mb2e2: BIT; 

FOR DUT1: bloc USE ENTITY WORK.bloc1(logicaret);
FOR DUT2: bloc USE ENTITY WORK.bloc1(estructural);
FOR DUT3: bloc USE ENTITY WORK.bloc1(logicaret2);

BEGIN

DUT1: bloc PORT MAP (senyal_s0, senyal_s1, senyal_b0, senyal_b1, senyal_b2, sortida_Mb0l, sortida_Mb1l, sortida_Mb2l);
DUT2: bloc PORT MAP (senyal_s0, senyal_s1, senyal_b0, senyal_b1, senyal_b2, sortida_Mb0e, sortida_Mb1e, sortida_Mb2e);
DUT3: bloc PORT MAP (senyal_s0, senyal_s1, senyal_b0, senyal_b1, senyal_b2, sortida_Mb0e2, sortida_Mb1e2, sortida_Mb2e2);
PROCESS (senyal_s0, senyal_s1, senyal_b0, senyal_b1, senyal_b2)
BEGIN
senyal_s0 <= NOT senyal_s0 AFTER 400 ns;
senyal_s1 <= NOT senyal_s1 AFTER 200 ns;
senyal_b0 <= NOT senyal_b0 AFTER 100 ns;
senyal_b1 <= NOT senyal_b1 AFTER 50 ns;
senyal_b2 <= NOT senyal_b2 AFTER 25 ns;
END PROCESS;
END test_1;
--2
ARCHITECTURE test_2 OF bdp IS

COMPONENT bloc
PORT (a, b, cin: IN BIT; S, cout: OUT BIT);
END COMPONENT;


SIGNAL senyal_a, senyal_b, senyal_cin, sortida_Sl, sortida_coutl, sortida_Se, sortida_coute: BIT; 

FOR DUT1: bloc USE ENTITY WORK.sum1bit(logicaret);
FOR DUT2: bloc USE ENTITY WORK.sum1bit(estructural);

BEGIN

DUT1: bloc PORT MAP (senyal_a, senyal_b, senyal_cin, sortida_Sl, sortida_coutl);
DUT2: bloc PORT MAP (senyal_a, senyal_b, senyal_cin, sortida_Se, sortida_coute);

PROCESS (senyal_a, senyal_b, senyal_cin)
BEGIN
senyal_a <= NOT senyal_a AFTER 100 ns;
senyal_b <= NOT senyal_b AFTER 50 ns;
senyal_cin <= NOT senyal_cin AFTER 25 ns;
END PROCESS;
END test_2;
--3
ARCHITECTURE test_3 OF bdp IS

COMPONENT bloc
PORT (b2, b1, b0, a2, a1, a0, cin: IN BIT; s0, s1, s2, cout: OUT BIT);
END COMPONENT;


SIGNAL senyal_a2, senyal_b2, senyal_a1, senyal_b1, senyal_a0, senyal_b0, senyal_cin, sortida_s0, sortida_s1, sortida_s2, sortida_cout: BIT; 

FOR DUT1: bloc USE ENTITY WORK.sum3bits(estructural);

BEGIN

DUT1: bloc PORT MAP (senyal_b2, senyal_b1, senyal_b0, senyal_a2, senyal_a1, senyal_a0, senyal_cin, sortida_s0, sortida_s1, sortida_s2, sortida_cout);

PROCESS (senyal_a2, senyal_b2, senyal_a1, senyal_b1, senyal_a0, senyal_b0, senyal_cin)
BEGIN
senyal_a2 <= NOT senyal_a2 AFTER 1600 ns;
senyal_b2 <= NOT senyal_b2 AFTER 800 ns;
senyal_a1 <= NOT senyal_a1 AFTER 400 ns;
senyal_b1 <= NOT senyal_b1 AFTER 200 ns;
senyal_a0 <= NOT senyal_a0 AFTER 100 ns;
senyal_b0 <= NOT senyal_b0 AFTER 50 ns;
senyal_cin <= NOT senyal_cin AFTER 25 ns;
END PROCESS;
END test_3;
--4
ARCHITECTURE test_4 OF bdp IS

COMPONENT bloc
PORT (a, b, c, d, sel1, sel0: IN BIT; z: OUT BIT);
END COMPONENT;


SIGNAL senyal_a, senyal_b, senyal_c, senyal_d, senyal_sel1, senyal_sel0, sortida_zl, sortida_zi: BIT; 

FOR DUT1: bloc USE ENTITY WORK.mux4a1(logicaret);
FOR DUT2: bloc USE ENTITY WORK.mux4a1(ifthen);

BEGIN

DUT1: bloc PORT MAP (senyal_a, senyal_b, senyal_c, senyal_d, senyal_sel1, senyal_sel0, sortida_zl);
DUT2: bloc PORT MAP (senyal_a, senyal_b, senyal_c, senyal_d, senyal_sel1, senyal_sel0, sortida_zi);

PROCESS (senyal_a, senyal_b, senyal_c, senyal_d, senyal_sel1, senyal_sel0)
BEGIN
senyal_a <= NOT senyal_a AFTER 800 ns;
senyal_b <= NOT senyal_b AFTER 400 ns;
senyal_c <= NOT senyal_c AFTER 200 ns;
senyal_d <= NOT senyal_d AFTER 100 ns;
senyal_sel1 <= NOT senyal_sel1 AFTER 50 ns;
senyal_sel0 <= NOT senyal_sel0 AFTER 25 ns;
END PROCESS;
END test_4;
--5
ARCHITECTURE test_5 OF bdp IS

COMPONENT bloc
PORT (a, b, s1, s0, ck: IN BIT; z: OUT BIT);
END COMPONENT;


SIGNAL senyal_a, senyal_b, senyal_s1, senyal_s0, sortida_z: BIT; 

FOR DUT1: bloc USE ENTITY WORK.reg1bit(estructural);

BEGIN

DUT1: bloc PORT MAP (senyal_a, senyal_b, senyal_s1, senyal_s0, sortida_z);

PROCESS (senyal_a, senyal_b, senyal_s1, senyal_s0)
BEGIN
senyal_a <= NOT senyal_a AFTER 200 ns;
senyal_b <= NOT senyal_b AFTER 100 ns;
senyal_s1 <= NOT senyal_s1 AFTER 50 ns;
senyal_s0 <= NOT senyal_s0 AFTER 25 ns;
END PROCESS;
END test_5;








