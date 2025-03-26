ENTITY bdp IS
END bdp;

ARCHITECTURE test_1 OF bdp IS

COMPONENT bloc
PORT (a, b, sel: IN BIT; z: OUT BIT);
END COMPONENT;

SIGNAL senyal_a, senyal_b, senyal_sel, sortida_zl, sortida_ze, sortida_zi: BIT;

FOR DUT1: bloc USE ENTITY WORK.MUX2a1(logicaret);
FOR DUT2: bloc USE ENTITY WORK.MUX2a1(estructural);
FOR DUT3: bloc USE ENTITY WORK.MUX2a1(ifthen);

BEGIN

DUT1: bloc PORT MAP (senyal_a, senyal_b, senyal_sel, sortida_zl);
DUT2: bloc PORT MAP (senyal_a, senyal_b, senyal_sel, sortida_ze);
DUT3: bloc PORT MAP (senyal_a, senyal_b, senyal_sel, sortida_zi);

PROCESS (senyal_a, senyal_b, senyal_sel)
BEGIN
senyal_a <= NOT senyal_a AFTER 100 ns;
senyal_b <= NOT senyal_b AFTER 50 ns;
senyal_sel <= NOT senyal_sel AFTER 25 ns;
END PROCESS;
END test_1;

ARCHITECTURE test_2 OF bdp IS

COMPONENT bloc
PORT (b1, b0, a1, a0: IN BIT; z2, z1, z0: OUT BIT);
END COMPONENT;

SIGNAL senyal_b1, senyal_b0, senyal_a1, senyal_a0, sortida_z2, sortida_z1, sortida_z0: BIT;

FOR DUT1: bloc USE ENTITY WORK.COMP2BITS(ifthen);

BEGIN

DUT1: bloc PORT MAP (senyal_b1, senyal_b0, senyal_a1, senyal_a0, sortida_z2, sortida_z1, sortida_z0);

PROCESS (senyal_b1, senyal_b0, senyal_a1, senyal_a0)
BEGIN
senyal_b1 <= NOT senyal_b1 AFTER 200 ns;
senyal_b0 <= NOT senyal_b0 AFTER 100 ns;
senyal_a1 <= NOT senyal_a1 AFTER 50 ns;
senyal_a0 <= NOT senyal_a0 AFTER 25 ns;
END PROCESS;
END test_2;

ARCHITECTURE test_3 OF bdp IS

COMPONENT bloc
PORT (b3, b2, b1, b0, a3, a2, a1, a0: IN BIT; z2, z1, z0: OUT BIT);
END COMPONENT;

SIGNAL senyal_b3, senyal_b2, senyal_b1, senyal_b0, senyal_a3, senyal_a2, senyal_a1, senyal_a0, sortida_z2_struct, sortida_z1_struct, sortida_z0_struct, sortida_z2_ifthen, sortida_z1_ifthen, sortida_z0_ifthen: BIT;

FOR DUT1: bloc USE ENTITY WORK.COMP4BITS(estructural);
FOR DUT2: bloc USE ENTITY WORK.COMP4BITS(ifthen);

BEGIN

DUT1: bloc PORT MAP (senyal_b3, senyal_b2, senyal_b1, senyal_b0, senyal_a3, senyal_a2, senyal_a1, senyal_a0, sortida_z2_struct, sortida_z1_struct, sortida_z0_struct);
DUT2: bloc PORT MAP (senyal_b3, senyal_b2, senyal_b1, senyal_b0, senyal_a3, senyal_a2, senyal_a1, senyal_a0, sortida_z2_ifthen, sortida_z1_ifthen, sortida_z0_ifthen);

PROCESS (senyal_b3, senyal_b2, senyal_b1, senyal_b0, senyal_a3, senyal_a2, senyal_a1, senyal_a0)
BEGIN
senyal_b3 <= NOT senyal_b3 AFTER 3200 ns;
senyal_b2 <= NOT senyal_b2 AFTER 1600 ns;
senyal_b1 <= NOT senyal_b1 AFTER 800 ns;
senyal_b0 <= NOT senyal_b0 AFTER 400 ns;
senyal_a3 <= NOT senyal_a3 AFTER 200 ns;
senyal_a2 <= NOT senyal_a2 AFTER 100 ns;
senyal_a1 <= NOT senyal_a1 AFTER 50 ns;
senyal_a0 <= NOT senyal_a0 AFTER 25 ns;
END PROCESS;
END test_3;






ARCHITECTURE test_4 OF bdp IS

COMPONENT bloc
PORT (
    b3, b2, b1, b0, a3, a2, a1, a0, cin : IN BIT;
    s3, s2, s1, s0, cout : OUT BIT
);
END COMPONENT;

SIGNAL senyal_b3, senyal_b2, senyal_b1, senyal_b0 : BIT;
SIGNAL senyal_a3, senyal_a2, senyal_a1, senyal_a0 : BIT;
SIGNAL senyal_cin : BIT;
SIGNAL sortida_s3, sortida_s2, sortida_s1, sortida_s0 : BIT;
SIGNAL sortida_cout : BIT;

FOR DUT1: bloc USE ENTITY WORK.sum4bits(estructural);

BEGIN

DUT1: bloc PORT MAP (
    senyal_b3, senyal_b2, senyal_b1, senyal_b0,
    senyal_a3, senyal_a2, senyal_a1, senyal_a0,
    senyal_cin,
    sortida_s3, sortida_s2, sortida_s1, sortida_s0,
    sortida_cout
);

PROCESS (senyal_b3, senyal_b2, senyal_b1, senyal_b0, senyal_a3, senyal_a2, senyal_a1, senyal_a0, senyal_cin)
BEGIN
    senyal_b3 <= NOT senyal_b3 AFTER 6400 ns;
    senyal_b2 <= NOT senyal_b2 AFTER 3200 ns;
    senyal_b1 <= NOT senyal_b1 AFTER 1600 ns;
    senyal_b0 <= NOT senyal_b0 AFTER 800 ns;
    senyal_a3 <= NOT senyal_a3 AFTER 400 ns;
    senyal_a2 <= NOT senyal_a2 AFTER 200 ns;
    senyal_a1 <= NOT senyal_a1 AFTER 100 ns;
    senyal_a0 <= NOT senyal_a0 AFTER 50 ns;
    senyal_cin <= NOT senyal_cin AFTER 25 ns;
END PROCESS;

END test_4;

ARCHITECTURE test_sum4bits OF bdp IS
COMPONENT sum4bits IS 
PORT(b3,b2,b1,b0,a3,a2,a1,a0,cin: IN BIT; s3,s2,s1,s0,cout: OUT BIT);
END COMPONENT;

FOR DUT1: sum4bits USE ENTITY WORK.sum4bits(estructural);
SIGNAL eb3,eb2,eb1,eb0,ea3,ea2,ea1,ea0,ecin,ss3,ss2,ss1,ss0,scout: BIT;
BEGIN
	DUT1: sum4bits PORT MAP(eb3,eb2,eb1,eb0,ea3,ea2,ea1,ea0,ecin,ss3,ss2,ss1,ss0,scout);
	
PROCESS
BEGIN
	eb3 <= '0';	eb2 <= '1';	eb1 <= '0';	eb0 <= '0';
	ea3 <= '0';	ea2 <= '0';	ea1 <= '1';	ea0 <= '0';
	ecin <= '0';
	WAIT FOR 100 ns;
	ecin <= '1';
	WAIT FOR 100 ns;
	eb3 <= '1';	eb2 <= '0';	eb1 <= '0';	eb0 <= '0';
	ea3 <= '1';	ea2 <= '0';	ea1 <= '0';	ea0 <= '0';
	ecin <= '0';
	WAIT FOR 100 ns;
	ecin <= '1';
	WAIT FOR 100 ns;
END PROCESS;
END test_sum4bits;

ARCHITECTURE test_5 OF bdp IS

COMPONENT bloc
PORT (
    ent3, ent2, ent1, ent0, cont1, cont0, d, clock : IN BIT;
    sort3, sort2, sort1, sort0 : OUT BIT
);
END COMPONENT;

SIGNAL senyal_ent3, senyal_ent2, senyal_ent1, senyal_ent0 : BIT;
SIGNAL senyal_cont1, senyal_cont0, senyal_d, senyal_clock : BIT;
SIGNAL sortida_sort3, sortida_sort2, sortida_sort1, sortida_sort0 : BIT;

FOR DUT1: bloc USE ENTITY WORK.reg4bits(estructural);

BEGIN

DUT1: bloc PORT MAP (
    senyal_ent3, senyal_ent2, senyal_ent1, senyal_ent0,
    senyal_cont1, senyal_cont0, senyal_d, senyal_clock,
    sortida_sort3, sortida_sort2, sortida_sort1, sortida_sort0
);

PROCESS (senyal_ent3, senyal_ent2, senyal_ent1, senyal_ent0, senyal_cont1, senyal_cont0, senyal_d, senyal_clock)
BEGIN
    senyal_ent3 <= NOT senyal_ent3 AFTER 1600 ns;
    senyal_ent2 <= NOT senyal_ent2 AFTER 800 ns;
    senyal_ent1 <= NOT senyal_ent1 AFTER 400 ns;
    senyal_ent0 <= NOT senyal_ent0 AFTER 200 ns;
    senyal_cont1 <= NOT senyal_cont1 AFTER 100 ns;
    senyal_cont0 <= NOT senyal_cont0 AFTER 50 ns;
    senyal_d <= NOT senyal_d AFTER 25 ns;
    senyal_clock <= NOT senyal_clock AFTER 50 ns;
END PROCESS;
END test_5;

----------------------------------
-- test reg4bits
----------------------------------
ARCHITECTURE test_reg4bits OF bdp IS
COMPONENT reg4bits IS 
PORT(ent3,ent2,ent1,ent0,cont1,cont0,d,clock: IN BIT; sort3,sort2,sort1,sort0: OUT BIT);
END COMPONENT;

FOR DUT1: reg4bits USE ENTITY WORK.reg4bits(estructural);
SIGNAL ck,econt1,econt0,e3,e2,e1,e0,ed,ss3,ss2,ss1,ss0: BIT;
BEGIN
	DUT1: reg4bits PORT MAP(e3,e2,e1,e0,econt1,econt0,ed,ck,ss3,ss2,ss1,ss0);

e3 <= '1';	e2 <= '1';	e1 <= '0'; e0 <= '1';
PROCESS(ck,econt0,econt1)
BEGIN
ck <= NOT ck AFTER 25 ns;
econt0 <= NOT econt0 AFTER 420 ns;
econt1 <= NOT econt1 AFTER 210 ns;
ed <= NOT ed AFTER 840 ns;
END PROCESS;
END test_reg4bits;