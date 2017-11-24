-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "11/23/2017 20:33:05"
                                                            
-- Vhdl Test Bench template for design  :  top_design
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

PACKAGE top_design_data_type IS 
TYPE output_7_0_type IS ARRAY (7 DOWNTO 0) OF STD_LOGIC;
TYPE output_7_0_3_0_type IS ARRAY (3 DOWNTO 0) OF output_7_0_type;
SUBTYPE output_type IS output_7_0_3_0_type;
END top_design_data_type;

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

library work;
use work.top_design_data_type.all;

ENTITY top_design_vhd_tst IS
END top_design_vhd_tst;
ARCHITECTURE top_design_arch OF top_design_vhd_tst IS
-- constants        
constant clk_period: time := 20 ns;                                            
-- signals                                                   
SIGNAL button_neg : STD_LOGIC:= '1';
SIGNAL clk : STD_LOGIC:='0';
SIGNAL enable_out : STD_LOGIC;
SIGNAL output : output_type;
COMPONENT top_design
	PORT (
	button_neg : IN STD_LOGIC;
	clk : IN STD_LOGIC;
	enable_out : OUT STD_LOGIC;
	output : OUT output_type
	);
END COMPONENT;
BEGIN
	i1 : top_design
	PORT MAP (
-- list connections between master ports and signals
	button_neg => button_neg,
	clk => clk,
	enable_out => enable_out,
	output => output
	);
	
clk <= not clk after clk_period/2;
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        button_neg <= '1';
		wait for 50*clk_period;
		button_neg <= '0';
		wait for 120*clk_period;
		button_neg <= '1';
WAIT;                                                        
END PROCESS always;                                          
END top_design_arch;
