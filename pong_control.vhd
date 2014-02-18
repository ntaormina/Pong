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

COMPONENT Button_Logic
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		button_in : IN std_logic;          
		button_out : OUT std_logic
		);
END COMPONENT;


type pong_type is(moving, hit_top, hit_right, hit_bottom, hit_paddle, lose);
signal state_reg, state_next: pong_type;
signal  paddle_next, paddle_reg, ball_x_pos, ball_y_pos, ball_x_pos_next, ball_y_pos_next : unsigned(10 downto 0);
signal count_reg, count_next : unsigned(12 downto 0);
signal up_pulse, down_pulse : std_logic;


begin

Inst_up_Button_Logic: Button_Logic PORT MAP(
		clk => clk,
		reset => reset,
		button_in => up,
		button_out => up_pulse
	);
	
Inst_down_Button_Logic: Button_Logic PORT MAP(
		clk => clk,
		reset => reset,
		button_in => down,
		button_out => down_pulse
	);

process(count_reg, v_completed)
		begin
			if(count_next = 5001) then
				count_next <=  "0000000000000";				
			elsif(v_completed = '1') then
				count_next <= count_reg + "0000000000001" ;
			else
				count_next <= count_reg;	
				
			end if;	
end process;

process(clk, reset) 
begin

	if(reset = '1') then
		paddle_reg <= "00010010000";
	elsif(rising_edge(clk)) then
		paddle_reg <= paddle_next;
	end if;
end process;

process(up_pulse, down_pulse, paddle_reg, paddle_next)
begin
	
	if(up_pulse = '1' and paddle_reg > 75) then		
		paddle_next <= paddle_reg - 10;	
	elsif(down_pulse = '1' and paddle_reg < 405) then		
		paddle_next <= paddle_reg + 10;	
	end if;

end process;
process(clk, ball_x_pos_next, ball_y_pos_next, reset)
begin
	
		if(reset = '1')then	
			ball_x_pos <= "00000100000";
			ball_y_pos <= "00000100000";
		elsif(rising_edge(clk))then
			ball_x_pos <= ball_x_pos_next;
			ball_y_pos <= ball_y_pos_next;
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

process( ball_x_pos, ball_y_pos, state_reg)
begin


if(count_next = 5000) then
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
		
		state_next <= moving;
	when hit_right =>
		
		state_next <= moving;
	when hit_bottom =>
		
		state_next <= moving;
	when hit_paddle =>
	
		state_next <= moving;
	when lose=>
		

end case;	
end if;
end process;

process( ball_x_pos, ball_y_pos, state_next)
begin

	ball_x_pos_next <= ball_x_pos + 1;
	ball_y_pos_next <= ball_y_pos + 1;


case state_reg is 
	when moving =>
	
	ball_x_pos_next <= ball_x_pos + 1;
	ball_y_pos_next <= ball_y_pos + 1;
	when hit_top =>
		ball_x_pos_next <= ball_x_pos + 1;
		ball_y_pos_next <= ball_y_pos - 1;
		
	when hit_right =>
		ball_x_pos_next <= ball_x_pos - 1;
		ball_y_pos_next <= ball_y_pos - 1;
		
	when hit_bottom =>
		ball_x_pos_next <= ball_x_pos - 1;
		ball_y_pos_next <= ball_y_pos + 1;
		
	when hit_paddle =>
		ball_x_pos_next <= ball_x_pos + 1;
		ball_y_pos_next <= ball_y_pos + 1;
		
	when lose=>
		ball_x_pos_next <= ball_x_pos ;
		ball_y_pos_next <= ball_y_pos ;

end case;	

end process;

paddle_y <= paddle_next;
ball_x <= ball_x_pos_next;
ball_y <= ball_y_pos_next;

end Behavioral;

