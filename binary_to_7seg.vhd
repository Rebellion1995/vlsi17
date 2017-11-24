library ieee;
use ieee.std_logic_1164.all;

entity binary_to_7seg is
	port(
		enable: in std_logic;
		input: in std_logic_vector(3 downto 0);
		output: out std_logic_vector(7 downto 0)
	);
end entity binary_to_7seg;

architecture rtl_synth_altera of binary_to_7seg is
begin
	comb_process: process(input,enable) is
	begin
		if enable = '1' then
			case input is
			when "0000" =>
				output <= X"C0";
			when "0001" =>
				output <= X"F9";
			when "0010" =>
				output <= X"A4";
			when "0011" =>
				output <= X"B0";
			when "0100" =>
				output <= X"99";
			when "0101" =>
				output <= X"92";
			when "0110" =>
				output <= X"82";
			when "0111" =>
				output <= X"F8";
			when "1000" =>
				output <= X"80";
			when "1001" =>
				output <= X"90";
			when others =>
				output <= X"FF";
			end case;
		else
			output <= X"FF";
		end if;
	end process comb_process;
end architecture rtl_synth_altera;