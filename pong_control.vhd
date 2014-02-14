----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:19:21 02/14/2014 
-- Design Name: 
-- Module Name:    pong_control - Behavioral 
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


entity pong_control is
  port (
          clk         : in std_logic;
          reset       : in std_logic;
          up          : in std_logic;
          down        : in std_logic;
          v_completed : in std_logic;
          ball_x      : out unsigned(10 downto 0);
          ball_y      : out unsigned(10 downto 0);
          paddle_y    : out unsigned(10 downto 0)
  );
end pong_control;

architecture Behavioral of pong_control is
type pong_type is(moving, hit_top, hit_right, hit_bottom, hit_paddle, lose);
signal state_reg, state_next: pong_type;
signal paddle_next, paddle_reg, ball_x_pos, ball_y_pos : unsigned(10 downto 0);
signal x_adder, y_adder: integer;

begin

process(up, down, clk, paddle_reg)
begin

	paddle_reg <= "00000100000";
	paddle_next <= "00000100000";

	if(up = '1') then
		paddle_next <= paddle_reg - 10;
	elsif(down = '1') then
		paddle_next <= paddle_reg + 10;
	else
		paddle_next <= paddle_reg;
	end if;

end process;
process(clk, ball_x_pos, ball_y_pos)
begin
ball_x_pos <= "00000100000";
ball_y_pos <= "00000100000";
if(rising_edge(clk))then	
ball_x_pos <= ball_x_pos + x_adder;
ball_y_pos <= ball_y_pos + y_adder;
else
ball_x_pos <= ball_x_pos;
ball_y_pos <= ball_y_pos;
end if;

end process;

	process(clk, reset)
		begin		
	
			if(reset = '1') then
				state_reg <= moving;
			elsif (rising_edge(clk)) then
				state_reg <= state_next;
			end if;	
			
		end process;

process(clk, reset, ball_x_pos, ball_y_pos, state_reg, state_next)
begin



state_next <= state_reg;

case state_reg is 
	when moving =>
	if(ball_x_pos - 5 = 0 )then
		state_next <= lose;
	end if;
	if(ball_x_pos + 5 = 640 )then
		state_next <= hit_right;
	end if;
	if(ball_y_pos - 5 = 0 )then
		state_next <= hit_top;
	end if;
	if(ball_y_pos + 5 = 480 )then
		state_next <= hit_bottom;
	end if;
	if(ball_x_pos - 5 = 15 )then
		state_next <= hit_paddle;
	end if;
	when hit_top =>
		x_adder <= 1;
		y_adder <= -1;
		state_next <= moving;
	when hit_right =>
		x_adder <= -1;
		y_adder <= -1;
		state_next <= moving;
	when hit_bottom =>
		x_adder <= -1;
		y_adder <= 1;
		state_next <= moving;
	when hit_paddle =>
		x_adder <= 1;
		y_adder <= 1;
		state_next <= moving;
	when lose=>
		x_adder <= 0;
		y_adder <= 0;
		
end case;	

end process;

paddle_y <= paddle_next;
ball_x <= ball_x_pos;
ball_y <= ball_y_pos;

end Behavioral;

