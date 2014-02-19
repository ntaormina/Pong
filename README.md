Pong
====

Introduction
============
The purpose of this lab was to use the VGA driver created in lab one to make a simple implementation of the Atari Pong video game. Instead of having two padles this game will have one. The ball will bounce off the top, right, and bottom walls as well as the paddle. The player loses the game if the ball hits the left wall. This will be implemented with a Finite State Machine.

Implementation
==============
The final FSM for `pong_control.vhd` is as follows:

![state machine for pong_control](states.jpg)

```vhdl
state_next <= state_reg;

if(count_next = 0) then

case state_reg is 
	when moving =>
	if(ball_x_pos - 7 = 0 )then
		state_next <= lose_state;
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
	if(ball_x_pos - 5 = 16 and ball_y_pos > (paddle_reg - 50) and ball_y_pos < (paddle_reg) )then
		state_next <= hit_paddle_top;
		end if;
	if(ball_x_pos - 5 = 16 and ball_y_pos >= (paddle_reg ) and ball_y_pos < (paddle_reg + 50) )then
		state_next <= hit_paddle_bottom;
	end if;
	
	when hit_top =>
		
		state_next <= moving;
	when hit_right =>
		
		state_next <= moving;
	when hit_bottom =>
		
		state_next <= moving;
	when hit_paddle_top =>
	
		state_next <= moving;
	when hit_paddle_bottom =>
	
		state_next <= moving;	
	when lose_state=>
		

end case;	
end if;

```
