% Callback function for PAUSE_SOUND

if start_flag ~= 1,
   blink_load_data;
   return;
end;

pause(player);