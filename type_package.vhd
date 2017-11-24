library ieee;
use ieee.std_logic_1164.all;

package type_package is

	type display_interface_type is array (3 downto 0) of std_logic_vector(7 downto 0);
	type input_values_type is array (3 downto 0) of std_logic_vector(3 downto 0);

end package;