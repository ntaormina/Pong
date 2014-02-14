----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:32:35 01/29/2014 
-- Design Name: 
-- Module Name:    pixel_gen - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity pixel_gen is
    port ( row      : in unsigned(10 downto 0);
           column   : in unsigned(10 downto 0);
           blank    : in std_logic;
			  switch0  : in std_logic;
			  switch1  : in std_logic;
           r        : out std_logic_vector(7 downto 0);
           g        : out std_logic_vector(7 downto 0);
           b        : out std_logic_vector(7 downto 0));
end pixel_gen;

architecture Behavioral of pixel_gen is

begin


process(column, row, blank)
begin
		r <= (others => '0'); 
		g <= (others => '0');
		b <= (others => '0');
		
		if(blank = '0') then 
		if(column > 200 and column < 215 and row > 100 and row < 225) then
		r <= (others => '0'); 
		g <= (others => '0');
		b <= (others => '1');
		end if;
		if(column > 235 and column < 250 and row > 100 and row < 225) then
		r <= (others => '0'); 
		g <= (others => '0');
		b <= (others => '1');
		end if;
		if(column > 215 and column < 235 and row > 100 and row < 125) then
		r <= (others => '0'); 
		g <= (others => '0');
		b <= (others => '1');
		end if;
		if(column > 215 and column < 235 and row > 150 and row < 175) then
		r <= (others => '0'); 
		g <= (others => '0');
		b <= (others => '1');
		end if;
		if(column > 280 and column < 330 and row > 150 and row < 175) then
		r <= (others => '0'); 
		g <= (others => '0');
		b <= (others => '1');
		end if;
		if(column > 280 and column < 295 and row > 175 and row < 250) then
		r <= (others => '0'); 
		g <= (others => '0');
		b <= (others => '1');
		end if;
		if(column > 295 and column < 320 and row > 200 and row < 215) then
		r <= (others => '0'); 
		g <= (others => '0');
		b <= (others => '1');
		end if;
	else	
	r <= (others => '0'); 
	g <= (others => '0');
	b <= (others => '0');	
	end if;
		

end process;
end Behavioral;

