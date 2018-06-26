% Callback function for STOP_SOUND

if start_flag ~= 1,
   blink_load_data;
   return;
end;

stop(player);