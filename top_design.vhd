library ieee;
use ieee.std_logic_1164.all;
use work.type_package.all;

entity top_design is
	port(
		button_neg: in std_logic;
		clk : in std_logic;
		output : out display_interface_type;
		enable_out : out std_logic:='0'
	);
end entity top_design;

architecture rtl_synth_altera of top_design is

	type button_state_type is (released,pressed,waiting);
	signal button_state_reg, button_state_next: button_state_type := released;
	
	type counter_state_type is range 0 to 99;
	signal button_counter_reg, button_counter_next: counter_state_type  := 0;
	
	signal enable_next, enable_reg :std_logic:='0';
	signal button: std_logic:='0';
	
	component converter is
		port(
			enable_int: in std_logic;
			input_int: in std_logic_vector(3 downto 0);
			output_int: out std_logic_vector(7 downto 0)
		);
	end component converter;
	signal input: input_values_type;
begin

	button <= not button_neg;
	
-- CLOCK PROC
	synch_proc: process(clk) is
	begin
		if(rising_edge(clk)) then
			button_state_reg <= button_state_next;
			enable_reg <= enable_next;
			enable_out <= enable_next;
		end if;
	end process synch_proc;

-- STATE MACHINE PROCESS 
	sm_synch_proc: process(button_state_reg,button_counter_reg,enable_reg) is
	begin
	
		-- Combinational guards
		button_state_next <= button_state_reg;
		button_counter_next <= button_counter_reg;
		enable_next <= enable_reg;
		
		case button_state_reg is
		when pressed => 
			if(button = '1') then
				if(button_counter_reg = 99) then
					button_state_reg <= waiting;
					enable_next <= not enable_reg;
				else 
					button_counter_next <= button_counter_reg + 1;
				end if;
			else
				button_state_next <= released;
			end if;
		when released =>
			if(button = '1') then
				button_state_next <= pressed;
				button_counter_next <= 0;
			end if;
		when waiting =>
			if(button='0') then
				button_state_next <= released;
			end if;
		end case;
	end process sm_synch_proc;

-- GENERATE LOOP
	generate_converters: for i in 3 downto 0 generate
	begin
		inst_conv: component converter 
			port map(
				output_int => output(i),
				enable_int => enable_reg,
				input_int => input(i)
			);
	end generate generate_converters;
	
-- INPUT VALUES
	input(3) <= "0001";
	input(2) <= "0010";
	input(1) <= "0011";
	input(0) <= "0100";
	
end architecture rtl_synth_altera;



-- CONFiguration
configuration cfg of top_design is
	for rtl_synth_altera
		for generate_converters(3 downto 0)
			for inst_conv: converter
				use entity work.binary_to_7seg(rtl_synth_altera)
				port map(
					input => input_int,
					enable => enable_int,
					output => output_int
				);
			end for;			
		end for;
	end for;
end configuration cfg;